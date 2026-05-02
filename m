Return-Path: <netdev+bounces-283485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JOUQDsVq9ml+UwIAu9opvQ
	(envelope-from <netdev+bounces-283485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B34B37FC
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C301E3002318
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387A388393;
	Sat,  2 May 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b="GuVCHilp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CC2DF13B
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756434; cv=none; b=FPzKiJh214kui1YpchO9wuq721s9G+rk0tpse/XGoSpPY+jyw0ycEJxtLNTAU12pKqxbA4eK9HMavmkwIMOVL0So9kYtUuqV3scrQ8t9G+nCWiaw1eMQhdAqQWVtgi08gDkh0k/iHkN/NwbKDMnTUnsIaCEHwGHzifgLdINtTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756434; c=relaxed/simple;
	bh=1g+iFN/6sGKbzPFEe7kXCCFXwDMjHYvGgw58HkANd9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isu5GttUNKnJo08oGo6j0sRtUfqDAWMN23pQp4qmyEVu9Ls5jSH6vcXfqwDX0nmC6aCeJMxPuCaAHVTog1mq2JYEwB3F7Bk+zrCDN1AD14C70g8NfdHfV4hhvhzGAymCdnTv2RrcCZ40vv2XniEyIx0GyLcm8Fd90YggOkcMh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b=GuVCHilp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so1119486d6.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20251104.gappssmtp.com; s=20251104; t=1777756431; x=1778361231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQhG7VHVJK8QbIDtr2MdRHTbIajT2JSmZzdzx4IHRCs=;
        b=GuVCHilpGOXbdoZGLjfgSKBOakb/iTTE0Jimh3DgkinziHKeigdkW7cbWIsCr9OP/p
         0e4urYqTfZrX3KTzHORy3Ul1NAkyJSqDzJU3eRSnpl96gyxGREx7KEo7r7erqlT4kpcH
         TfbRxrQ518HjzE/ziQKifhiz7wWYm2qecXyIKjkryWlfaTQvCeSsX40xEeiWRclt8ZS7
         M2u8NFaZdkhMKniB15vhMSZQ1FOj5PoHIacYNfU/Jz5uoAvGbK35TdhyczN4YbM0YU5f
         mSLJB82TBaWrKEjXD8ZWTbTcupIAlEPMA+c6GalMUe57FOTtfw6Y9FY/trJ/KjQCDHuE
         BxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756431; x=1778361231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQhG7VHVJK8QbIDtr2MdRHTbIajT2JSmZzdzx4IHRCs=;
        b=N+Q8NvPowfK1P5r4/KhJPIGIRIZKteEoMhxrVhFCXRk95jKFq8vbbI5xaxNgJcdusL
         BhdOiS1bAO+TE9Qs5CguXQbgNOWDv2FP295NirNA7uDeqeW1Z3VuXeNRwBsDbSHsYYRj
         mxx8xGAr88bk9odsB/J2ggk3UMzmY2y9S2QlHZhrXZhv29CrZe1ix8ehfKYEi4cHUjrB
         EdHZYe5kmaRI3U+vFrD8IfNUwKB5h7zvU1h7/SQ78Hurer3MAyvX6t0SK/txCI3T8lHv
         qWZPoLSavqLvetr1+nh1M5RpjZZ3LvHLOO7BQxA7gUbvY9GUyVBtnQgeItx8gyWRPLkD
         JfxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+U2fQap9otsuspfpbgdepWTBm5HGP/K/5EF9QzvPjiTYhs9QCZF6+fxg65Hkj+ejgK33qQ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/BOGoF4uYU+QnyJUNXeMGZQIisxKYu1YPfeb+XITfWJpgMfP
	CzHJGLdfWsVeBn7i3HXJAqug2lZmzgM8rS6ruJfG0sz5KDrJsR9B9emoJjD78KIUju8=
X-Gm-Gg: AeBDievdW9osJKp/x4EixJPdaVPj/+C2aS3/VhtB5QnmemI+8NreCgB+r+dtIUUcKJZ
	wHUVtd2Ebm2QvjFeakN6xy5DYYO6AeBaUmyR5D/YRmn8Pzwb5IUjr78FcywB6F/+PK9kQmejtpZ
	1oIQKWEES9dmH2Ja2qTqsNpPsKs1gmpKTsPjnh+qMihnEBf9+PM4svEM59GozACgFKgiJQr6GWh
	/Ql26OFw89RtTkoVqfTnf7hb5POWH8FmLmqndx0Urix81rxvLJgeuwKIVFijZm0TmlZvmm4C+jz
	pbz3X8Oo7+7IIEPx8u+Jm3eMu5fo99/q9vdQ2QybztOG564+6bRCbYDAnqB62dnCx13KDjI//Av
	Aq2HFwAky72d6H1as8wHNU0EBbOCS2y9KdTh3PL3KPKWDRV2lLgBQOrfkiWi7H+QbfCmexrdX1F
	ts6EFRgdhPcYPaIs5D2J303okPXeItDPpIJ5WdMwohpYbOlVwwl5lAT2CqE3vfjKP6ZtwAv7xG2
	g3vW37uYAJQ/ciwtRGWDBOnHa4wgNtxrehggUIlVDV9LWXwUhTvAJNMqpwmxNKp
X-Received: by 2002:a05:6214:3d07:b0:8ac:a5bc:a6b4 with SMTP id 6a1803df08f44-8b668f06ce1mr88565016d6.36.1777756430942;
        Sat, 02 May 2026 14:13:50 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d833sm78281496d6.10.2026.05.02.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:13:50 -0700 (PDT)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] rxrpc: always copy skb on in-place decrypt to avoid pagecache aliasing
Date: Sat,  2 May 2026 21:13:40 +0000
Message-Id: <20260502211340.446927-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF3B34B37FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[u-northwestern-edu.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-283485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[u-northwestern-edu.20251104.gappssmtp.com:s=20251104];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.815];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,u-northwestern-edu.20251104.gappssmtp.com:dkim,u.northwestern.edu:mid]

skb_cloned() does not detect frag-level page sharing introduced by splice()
with MSG_SPLICE_PAGES.  When such an skb reaches the rxrpc DATA path,
in-place decryption (rxkad/rxgk) writes plaintext into file
pagecache pages still aliased to the source file, leading to
corrupt the page cache of any readable file.

Drop the skb_cloned() gate so skb_copy() is performed unconditionally
for DATA packets, severing the alias before decrypt.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 net/rxrpc/call_event.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..39d19a354172 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -333,10 +333,12 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
-			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
-				/* Unshare the packet so that it can be
-				 * modified by in-place decryption.
+			    sp->hdr.securityIndex != 0) {
+				/* Always unshare: skb_cloned() does not
+				 * detect frag-level page sharing introduced
+				 * by splice() with MSG_SPLICE_PAGES, so
+				 * in-place decryption could otherwise corrupt
+				 * the source file's page cache.
 				 */
 				struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
 
-- 
2.34.1


