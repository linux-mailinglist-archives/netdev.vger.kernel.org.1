Return-Path: <netdev+bounces-267015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMFsDByZsmnENwAAu9opvQ
	(envelope-from <netdev+bounces-267015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:44:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DB270758
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8C5304D973
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD953B9DB2;
	Thu, 12 Mar 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpDhM3bH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4073B95EB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312250; cv=none; b=uzDYxljVXu4ZWZx1sX3YfL1JKrW4zfQltZynG56DVbLShOuEqtQJ+eg0nehitL436LNO2xOrNVsau6XbreEnUU/9kNOvw8upx3/oJvT+cZpVNrdZVG2X1Ec6Ohe4s25OoMGH2KYGfbbkandrX7koUGP66pQuhat6rYCOFGy4Mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312250; c=relaxed/simple;
	bh=Orz40UWyMu/DDc6OQ5Hx2UVKCN31H6OCVGLhTx/94lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhNNc0+hQyvAm5Bz50RKMddv/orh0PNrCxukyNWn2ZTxbLEwGLLpMgf0jc1J+kn85S9Sp/pucpS+Z0UOCpogUF730tDGQUCe7BA/hCgYtNCP1rP8Ct5Q98HWsigefEDR0NvVdmp9QLpxPwm5ZlCDOsOcQQMUnF5BautaAjURcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpDhM3bH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-356337f058aso529934a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312249; x=1773917049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhvJAlYXK6QIgKv+j9fZb4MsfQCzPTuvZ8nlIAaEfTc=;
        b=HpDhM3bHcn7SUaLe9uxPr7pS3OhfrUoqh5BxKJpOgSbks2HKe04yXLgWEs/bxVxkEW
         2xAyi4dNVpOTFBGcX+nG1Nrk0+4IUUe2RqZFRnWjZDFvym37Xc+AcvRZr+IFBrIoyvLT
         o52T/S1iBt2q90AScUihJcRIE5LjV2rWhTtxWcajbpTlHrRwn7qAer23UuI/zFGO7zKA
         DIaK9JcrnVhVp4oNVMxnr9DGUAom2jACXJ2ZNPGfWV8oOIc+rflvfFLmk6/IvkDeL6o4
         FYAULLlPQ13oGF6wWZb9BIT602VpKf7o70Rw73ZGDYFOofVzjF2biNV+lc0lNFeHn4ve
         FMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312249; x=1773917049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhvJAlYXK6QIgKv+j9fZb4MsfQCzPTuvZ8nlIAaEfTc=;
        b=fI54gZlx7yuLoVDOEl7IHeiUDwhfO3HcG+upc5rads+4Jtdgc5MoZUpV6OeRDqND1U
         PByvLDkHCysFooaUu+2PqnDM2y9jxWxJH5zuE8NGhx1D43JHGvk+V8FCZF4JvHn21gII
         MH6v3lq6Jofi90f0emFLUPN2cGbG31F3Lwb7rHufelYA5vgtPZ+t4p++a9aytPSpE3u8
         oQOEHpLPBCcn2GCif1i0D0wqAT69CBiVMvlkEg/w5yPlcPe6ek3ChVygPI6sUzcdxB3X
         Xo6C0DZpkbiiGcNDVELPcLDqESJRxHJYWHR8oTXYo3ehMiozOD2hOXaFDJKBRTwodIYE
         5X7g==
X-Gm-Message-State: AOJu0YwdA5Vw1H4NpJ6sX4ZkSS/Cs/7l3X0AiqzL5+Xo3Ffu5lFQdhko
	W3OMCp72BigFKgj+ybWm53CkxXd/5SggTO1a99Z49YkqYgNRFUGOsYBH
X-Gm-Gg: ATEYQzwOriGLyUyUXYWWyYM3TUDqXajCd2+mxVfhB5tlenUeHzs24fY8QmGHGm22IJG
	T/oByvRPoh4oGjIsMOwbuvRYuaSiQhKT9bd/oRmYmUsbc4xUsrUu/IVp6P1IMT7jzgfvZmxS+94
	vZwvpTEh+qEC4hIKYcUdW/IdRD4ylXqXRQs+3nQcFE/yP53H7/ldtp3BsohJOjcuIgSVTih8fA/
	/Zt72Xa0OeojU7wdE7Lpv8e7J+4yL+/hBheUCBuyQN8bROEID93aMpRTa+ySrXvAzsiSkrtEjti
	sMfglyuaPT1ndODdW+PHv1+1feC8H8cxNYuTSNIz4hYeKtPZVFAs2+9RFjM/0OPpo77qVO4u7LU
	+kdBxBiw8Q04ornv/b4EtqzsddyA8GvWk9LOYb3JWQEkLIrRtXPHzbXH7tPVNZ5XcfZN+IsKlNf
	jgUH4zAp7R+5h47dSqlyxTsHyN7OOLhA5OS/rnkROfDCS+sr71cCWedi0lpJ5P6EJgqfxjTbFGv
	TU9HOk0MENmAk6yARm4jP863Nk//1uIT2Y=
X-Received: by 2002:a17:90b:2691:b0:359:8c01:674 with SMTP id 98e67ed59e1d1-35a012eb057mr5428728a91.22.1773312248808;
        Thu, 12 Mar 2026 03:44:08 -0700 (PDT)
Received: from DellG15.lan (2001-b030-8069-ff8d-2d87-7642-b84f-7a21.hinet-ip6.hinet.net. [2001:b030:8069:ff8d:2d87:7642:b84f:7a21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm2576730a91.5.2026.03.12.03.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:44:08 -0700 (PDT)
From: Guoyu Su <yss2813483011xxl@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com,
	Guoyu Su <yss2813483011xxl@gmail.com>
Subject: [PATCH net v3] net: use skb_header_pointer() only for DODGY TCPv4 GSO skbs
Date: Thu, 12 Mar 2026 18:43:51 +0800
Message-Id: <20260312104351.185370-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310174841.5f5671c5@kernel.org>
References: <20260310174841.5f5671c5@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267015-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 818DB270758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported a KMSAN uninit-value warning in gso_features_check()
called from netif_skb_features() [1].

The current direct skb->len check is not sufficient for SKB_GSO_DODGY
packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can build
a DODGY GSO skb whose total length is large enough, while the IPv4
header is not fully available as initialized linear data for a direct
iph->frag_off access.

Use skb_header_pointer() to fetch the IPv4 header only for DODGY packets
and clear mangleid_features conservatively if the header cannot be
accessed or the DF bit is not set.

Keep the existing direct ip_hdr()/inner_ip_hdr() access for non-DODGY
packets so that buggy internal callers are still exposed.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
v3:
 - Use skb_header_pointer() only for SKB_GSO_DODGY packets.
 - Keep direct ip_hdr()/inner_ip_hdr() access for non-DODGY packets.
 - Fix AF_PACKET/PACKET_VNET_HDR reproducer where skb->len is sufficient
   but the IPv4 header is not fully available as initialized linear data.

v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..f3340d7dd87c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3805,10 +3805,21 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		int nhoff = skb->encapsulation ?
+			    skb_inner_network_offset(skb) :
+			    skb_network_offset(skb);
+		const struct iphdr *iph;
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
+			struct iphdr _iph;
+
+			iph = nhoff < 0 ? NULL :
+			      skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+		} else {
+			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
+		}
+
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1


