Return-Path: <netdev+bounces-53842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56845804D77
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8836B1C20A9E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF53E475;
	Tue,  5 Dec 2023 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OOs6rrNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875483;
	Tue,  5 Dec 2023 01:20:09 -0800 (PST)
Received: from localhost.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3F8CD40F1DE9;
	Tue,  5 Dec 2023 09:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3F8CD40F1DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701768007;
	bh=Xkj0nuUUERVo3DmD0W5CbQml3tG2cDGWBXJRyDsrHq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOs6rrNxIXNTpiu+wwKGkoIxiCIgN0JjlOkTYcgNboYScKjXAtJUNbYxCx1uhxUV8
	 V+dSISTy/vUdFlBok1a3MZBkLoxXytP8ZzQhgiKfvPLttDjHjp4EYZz5IX8s9V5rXa
	 43jfNC40GiHt+8/BgkeP+wcGGsb2DrgnsNzJMeOs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date: Tue,  5 Dec 2023 12:19:50 +0300
Message-ID: <20231205091952.24754-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZW7oQ1KPWTbiGSzL@codewreck.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs while processing an array of strings in p9pdu_vreadf
then uninitialized members of *wnames array are freed.

Fix this by iterating over only lower indices of the array. Also handle
possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
fails.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: I've missed that *wnames can also be left uninitialized. Please
ignore the patch v1. As an answer to Dominique's comment: my
organization marks this statement in all commits.

 net/9p/protocol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..043b621f8b84 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -393,6 +393,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 		case 'T':{
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
+				int i;
+				*wnames = NULL;
 
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
@@ -406,8 +408,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				}
 
 				if (!errcode) {
-					int i;
-
 					for (i = 0; i < *nwname; i++) {
 						errcode =
 						    p9pdu_readf(pdu,
@@ -421,13 +421,11 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 
 				if (errcode) {
 					if (*wnames) {
-						int i;
-
-						for (i = 0; i < *nwname; i++)
+						while (--i >= 0)
 							kfree((*wnames)[i]);
+						kfree(*wnames);
+						*wnames = NULL;
 					}
-					kfree(*wnames);
-					*wnames = NULL;
 				}
 			}
 			break;
-- 
2.43.0


