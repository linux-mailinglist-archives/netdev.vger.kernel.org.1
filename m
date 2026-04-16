Return-Path: <netdev+bounces-278990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BVwIvS54GmIlAAAu9opvQ
	(envelope-from <netdev+bounces-278990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E730140CEA8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029863065D91
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50144396567;
	Thu, 16 Apr 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGSnr5KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721B391859
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335268; cv=none; b=CvHGIhdYn9uQ6oSp/vLjprHVgbJId/8sV3cW8oyq2zJOQSZrTEYtPhNw+vtWCEB8qh7qaJoo89mVnyr48Vkk0SKgvAGDW5pZd2N6myelZhGLXy1XjqZpF7g469PyryLB2F2h4q9Hlr/OKo3fgrXFNK8JAopCphX0z/uU74j5law=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335268; c=relaxed/simple;
	bh=eVMfaS9Htr2NWHGAP5A6Gykmh2FgdSVZeiEjlkQqUTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiVAVv2ReffKlJCfkcRMBA7mgmmx9pnyolCCq4UmDcuTGTWDHmyO6yNnts2i/v2W7k0O6MtgbGUOP5QoZxSks0t52B3FivgR8EB364BOeQ7IfcgykitDybZN8ApWgzDKKvacanmzycDP8BPqZlquAB5kvcsgot4wEpDIt2sT1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGSnr5KA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35691a231a7so4984863a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776335266; x=1776940066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPEANDp2uS/rJVgdIpcE1PpwteF+KYA4VRqUQwVyjdI=;
        b=XGSnr5KAnSTyGIwZD0DRbo9aaiSNloKA/DewRAA90WHu9CoTf88LPZQvNJTrNqD2aL
         W5uyGvEnyBtxmRevbHXDSAXdk+b4AmtM5cTdPq5CB86wbHNkI6erSCd4oMGqN8CK2S0x
         ef1uOQwYPMUDq23cN8ivjTtvLK0KMH8JDGlqMX7MeLWns/wGcYcEJJA8X2SlON1OqlXI
         11EQZDuW6+1j6V9MYeQVSRZuRciifHQM+QDDOWHBPnxsvSUWKUpV6Jrm5C6D0oFchyvF
         QEyaucNXYujTEMP0luVAULlF96Z/ugLhxv2P/H/y4EDhZzsCxeOS5Gu3arUAeinZoTTb
         XV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335266; x=1776940066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPEANDp2uS/rJVgdIpcE1PpwteF+KYA4VRqUQwVyjdI=;
        b=WLecjOA2k3SC86lZkkjhF7qYJVtg+xzxUBQVf9tf8FTcc0UWsGyLoYuH7ik8sFhXd/
         qwmjLiAHQfsgrEMRgcN7VZU07jHDRXXgu0GiSjfMbp79XHLEEfaqVC+cXT9XKn6czyuN
         vscQ2zocaJjcoY6IGqQ7gTm3wf/XC45cIjTcOZdMQMvv7fkElU3hgmps/2U41bKMZW1n
         qsnnvyyLwhFK5L/iKhPVt3dATQguBpyXTHn2u3YD0kXoZ4HqzmrOV2OXLQdhEFOQO2pU
         azR97zYVFL8363oWjvmL274VPyzSw5qnMFJRFF5c0o3etfntbXPL2xIvPYFKB+s6gujc
         MR+A==
X-Forwarded-Encrypted: i=1; AFNElJ91VDr+OVFq7u0O7HvZRZNk8Wdn/Ab+keyc6UkxD8piJQ0vHHBJxRLbv6jzWRtXsL8RNNFN2go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1g1/Qfi9QZ7zd1Ta71/Vfu/xlwkzTnWi4t8MQ+oAzyNeUVUmZ
	djTdtxwCsKjXpnr06f7Zs7bbtE5ZgC5JRpoTepMV42sCKMUMis9xLX9u
X-Gm-Gg: AeBDiet/Oq04tCaobbn8kAdoeuaJ458alN/Xh9/CtzutMwukBL5BHMOlCjJJYlbm239
	cEWszg5n8XJ2KVvcuFjV3SulIHdUrnMkJCo61DFMGcE34qNJ8fjI8awI6SDMrVk8oYcb7yw5sun
	/hm2V+S7rHjnDTLGUd7m0rv6yTvM0uGyYDXqHhfXSIMWkWZ4Q0CRub+mEDUg23T76YPlRWy7VyL
	6CjfIFlqovfLkZge4ndV1IFySJgM6UE+ImnvcKrvtMIKdAirqpp9MOEwpmhEJxiNSLy/cNSAzd9
	vGRYREVuK9/s1Yc75UvWXEfje/wFHlp1P0BNSKSfVBK+jszHe+TLBXzaY7b5Ph1uGjqR6CTXLkw
	mgok903/3udr41erg2m26YsKmlwcFqIpibrHbmPgdoLEguflBwLXZxNT7/eaQxKWi0UcliiFlG3
	XEhZtPS8y/V6GZoY7EWuSV+HKbrNccb+SEKP7f+MWffA/3edOEXmdOBFZEIgDr7plCB1yOc+NgZ
	NdS8Q8EpIRp
X-Received: by 2002:a17:90b:3d0e:b0:35f:c5cd:cc5 with SMTP id 98e67ed59e1d1-35fc5cd0f11mr10611198a91.24.1776335266245;
        Thu, 16 Apr 2026 03:27:46 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce809648sm1918941a91.1.2026.04.16.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:27:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] slip: bound decode() reads against the compressed packet length
Date: Thu, 16 Apr 2026 18:01:51 +0800
Message-ID: <20260416100147.531855-5-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278990-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E730140CEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

slhc_uncompress() parses a VJ-compressed TCP header by advancing a
pointer through the packet via decode() and pull16(). Neither helper
bounds-checks against isize, and decode() masks its return with
& 0xffff so it can never return the -1 that callers test for -- those
error paths are dead code.

A short compressed frame whose change byte requests optional fields
lets decode() read past the end of the packet. The over-read bytes
are folded into the cached cstate and reflected into subsequent
reconstructed packets.

Make decode() and pull16() take the packet end pointer and return -1
when exhausted. Add a bounds check before the TCP-checksum read.
The existing == -1 tests now do what they were always meant to.

Fixes: b5451d783ade ("slip: Move the SLIP drivers")
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20260414134126.758795-2-horms@kernel.org/
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/slip/slhc.c | 43 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index e3c785da3eef3..d1c0523085d3a 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -80,9 +80,9 @@
 #include <linux/unaligned.h>
 
 static unsigned char *encode(unsigned char *cp, unsigned short n);
-static long decode(unsigned char **cpp);
+static long decode(unsigned char **cpp, const unsigned char *end);
 static unsigned char * put16(unsigned char *cp, unsigned short x);
-static unsigned short pull16(unsigned char **cpp);
+static long pull16(unsigned char **cpp, const unsigned char *end);
 
 /* Allocate compression data structure
  *	slots must be in range 0 to 255 (zero meaning no compression)
@@ -190,30 +190,34 @@ encode(unsigned char *cp, unsigned short n)
 	return cp;
 }
 
-/* Pull a 16-bit integer in host order from buffer in network byte order */
-static unsigned short
-pull16(unsigned char **cpp)
+/* Pull a 16-bit integer in host order from buffer in network byte order.
+ * Returns -1 if the buffer is exhausted, otherwise the 16-bit value.
+ */
+static long
+pull16(unsigned char **cpp, const unsigned char *end)
 {
-	short rval;
+	long rval;
 
+	if (*cpp + 2 > end)
+		return -1;
 	rval = *(*cpp)++;
 	rval <<= 8;
 	rval |= *(*cpp)++;
 	return rval;
 }
 
-/* Decode a number */
+/* Decode a number. Returns -1 if the buffer is exhausted. */
 static long
-decode(unsigned char **cpp)
+decode(unsigned char **cpp, const unsigned char *end)
 {
 	int x;
 
+	if (*cpp >= end)
+		return -1;
 	x = *(*cpp)++;
-	if(x == 0){
-		return pull16(cpp) & 0xffff;	/* pull16 returns -1 on error */
-	} else {
-		return x & 0xff;		/* -1 if PULLCHAR returned error */
-	}
+	if (x == 0)
+		return pull16(cpp, end);
+	return x & 0xff;
 }
 
 /*
@@ -499,6 +503,7 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 	struct cstate *cs;
 	int len, hdrlen;
 	unsigned char *cp = icp;
+	const unsigned char *end = icp + isize;
 
 	/* We've got a compressed packet; read the change byte */
 	comp->sls_i_compressed++;
@@ -534,6 +539,8 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 	thp = &cs->cs_tcp;
 	ip = &cs->cs_ip;
 
+	if (cp + 2 > end)
+		goto bad;
 	thp->check = *(__sum16 *)cp;
 	cp += 2;
 
@@ -564,26 +571,26 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 	default:
 		if(changes & NEW_U){
 			thp->urg = 1;
-			if((x = decode(&cp)) == -1) {
+			if((x = decode(&cp, end)) == -1) {
 				goto bad;
 			}
 			thp->urg_ptr = htons(x);
 		} else
 			thp->urg = 0;
 		if(changes & NEW_W){
-			if((x = decode(&cp)) == -1) {
+			if((x = decode(&cp, end)) == -1) {
 				goto bad;
 			}
 			thp->window = htons( ntohs(thp->window) + x);
 		}
 		if(changes & NEW_A){
-			if((x = decode(&cp)) == -1) {
+			if((x = decode(&cp, end)) == -1) {
 				goto bad;
 			}
 			thp->ack_seq = htonl( ntohl(thp->ack_seq) + x);
 		}
 		if(changes & NEW_S){
-			if((x = decode(&cp)) == -1) {
+			if((x = decode(&cp, end)) == -1) {
 				goto bad;
 			}
 			thp->seq = htonl( ntohl(thp->seq) + x);
@@ -591,7 +598,7 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 		break;
 	}
 	if(changes & NEW_I){
-		if((x = decode(&cp)) == -1) {
+		if((x = decode(&cp, end)) == -1) {
 			goto bad;
 		}
 		ip->id = htons (ntohs (ip->id) + x);
-- 
2.43.0


