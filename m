Return-Path: <netdev+bounces-53826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C6804BCC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119C31C20CD5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86E644;
	Tue,  5 Dec 2023 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ZeGt7KND"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA6D41;
	Tue,  5 Dec 2023 00:05:48 -0800 (PST)
Received: from localhost.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id BF7DB40F1DE9;
	Tue,  5 Dec 2023 08:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BF7DB40F1DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701763546;
	bh=JTEXi8TgIL4mRes1RKwLHstGL+1Ht9ZpBqt+VDl25fI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZeGt7KNDwgTR4NzwLFREB5RIzRFIzKzj8J8UY8T9MJ56stiHkXx6ciQse+PccqsEC
	 GysZq/0K7yIzDBSDAsN/QgKIspYqMjWRgsZ1mIa33nFG0HiaJX+g+waEXIPT7atVY5
	 HmTZUSaAsMxczUfMalOl3hYFHECIm4diML+dyO8k=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
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
Subject: [PATCH] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date: Tue,  5 Dec 2023 11:05:22 +0300
Message-ID: <20231205080524.6635-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs while processing an array of strings in p9pdu_vreadf
then uninitialized members of *wnames array are freed.

Fix this by iterating over only lower indices of the array.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/9p/protocol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..d33387e74a66 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -393,6 +393,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 		case 'T':{
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
+				int i;
 
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
@@ -406,8 +407,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				}
 
 				if (!errcode) {
-					int i;
-
 					for (i = 0; i < *nwname; i++) {
 						errcode =
 						    p9pdu_readf(pdu,
@@ -421,9 +420,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 
 				if (errcode) {
 					if (*wnames) {
-						int i;
-
-						for (i = 0; i < *nwname; i++)
+						while (--i >= 0)
 							kfree((*wnames)[i]);
 					}
 					kfree(*wnames);
-- 
2.43.0


