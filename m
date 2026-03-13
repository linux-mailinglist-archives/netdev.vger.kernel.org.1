Return-Path: <netdev+bounces-267275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A9CIwx2s2mwWgAAu9opvQ
	(envelope-from <netdev+bounces-267275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:27:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03CF27CB90
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB76D3097A66
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB933FE05;
	Fri, 13 Mar 2026 02:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C7248166;
	Fri, 13 Mar 2026 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368823; cv=none; b=fPw3i+s0Q5MtZ1MbocTAuyC8eVeocfO8ENrOrNB5seEcywE/lEbXZ7i0patO6DReZVfYBOB4DU2PxzlTV9e9pbGo0P4o1IEBWjmJYHVw1CwgCKvqCkaQsC7qlWqq+PEnNFwWrKiZht2MyIexlAs76fawFKHrg7Z+fe0XzD2FkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368823; c=relaxed/simple;
	bh=OiMc9YAZ8ONZEE7YERToNzRgA0ZJiBBxz0m/eLAT+K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFZO/8osyM+TA+8OwqGvdmwnXwSEKpicyXSHjCJ/mA3fFQIIBJXNTuIDW9bSKryBIS9khkuOG6Ti3nvMIhGDEBY0sZunKQ5xL47n0AYC8dTzivPHds/kO7h+DTd4PFDjlYW+nQVeDtmuWMfNNkQRJe8S3mjby0e56H51UcRWV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 12862e941e8411f1a21c59e7364eecb8-20260313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:7eb3ec22-c341-4a81-882e-f6ee0116d5b4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:89c9d04,CLOUDID:cc7cb362049be88cf2253c05f17cd667,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 12862e941e8411f1a21c59e7364eecb8-20260313
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 539483965; Fri, 13 Mar 2026 10:26:42 +0800
From: Minhong He <heminhong@kylinos.cn>
To: edumazet@google.com
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	david.lebrun@uclouvain.be,
	dsahern@kernel.org,
	heminhong@kylinos.cn,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2] ipv6: sr: Add NULL check for idev in seg6_hmac_validate_skb
Date: Fri, 13 Mar 2026 10:26:34 +0800
Message-Id: <20260313022634.51885-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iLBN-fxUQ11Txtn73XQ6M9mrpaWEfjK=EfMU8UO1yOdBw@mail.gmail.com>
References: <CANn89iLBN-fxUQ11Txtn73XQ6M9mrpaWEfjK=EfMU8UO1yOdBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[heminhong@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: F03CF27CB90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
can be NULL if the network device lacks proper IPv6 initialization
or is being torn down. Add a NULL check to avoid potential NULL pointer
dereference in subsequent code.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/seg6_hmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index ee6bac0160ac..e6964c6b0d38 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		return false;
 
 	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-- 
2.25.1


