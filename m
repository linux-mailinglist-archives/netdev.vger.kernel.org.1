Return-Path: <netdev+bounces-269239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ1pOoNJu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:55:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1AC2C43C9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC1530DB0A3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CB253340;
	Thu, 19 Mar 2026 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InVUC79S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115E26A0DD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881705; cv=none; b=kBDUQMrtVKcD7XNtNlvI2ctouXNwH2+KqJKYbrsBAzC3JfZNefLB9ZRbmGEu6tz2v1UYKa4apRXtntyb7jGtAlMsIWaIDADhgiWljNkoQY5yNgnbN5EMb4EdA0o9Bn6UW7PgTV4YtWJq6fATsuACD+4gPK6eA2THzZJsZ5vrDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881705; c=relaxed/simple;
	bh=9ChrqgqzLxv0HG6d+sVJ8ZSrEehv96eJRupsVAvr+Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Doq5vKsQvcwXqx/pjJlS0Pq9DfxgEBGGfZRFR+N/En7jlsji+THTk7zyY+KNgDC5ojN2qsADBedClzZwRXJbTkYTTQ2WHCk4ME9Uh7nx6SMNRjAMprQ7nra4v35SkfP90jK5gZL/PUtpspzub7FxjZQoQdb6T87TNRBhj37x3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InVUC79S; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35ba749f441so478819a91.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773881704; x=1774486504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqJVnNKLFkL+jq1ernliZYc8SMaYZ+fQvvfgLT6r30I=;
        b=InVUC79SeCKFpxRjV+c+SJe/7DLtmAWCtGe8jRVK7AWLOeStJkaoESfs6Qo/YJ/4gt
         5eFD/ZWX3Rms8UMXhaRo+EMRKcZq2GboPzar8GGy06HRj/O/MW5cI0gnrbLkaHrl7AzS
         rrkAd25Yo1N+xKw05OGlo/cURCjYy885QHiuITNF4EH5+aREDetRLUNiaoNROuVHC7Ke
         rbA+jy+zrMP1WMtOPWTbIoeby9bJY36lG7zXPNHecS2aKLuj5aOxZlx5yjfdyoTCcKjp
         Ac+TaNFPTK1Yw5RSUt6XW1ItTPB82DKee5eQUOG6bqLvdT4/JkZQC3B2kvhvVpNcT0fZ
         F9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773881704; x=1774486504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqJVnNKLFkL+jq1ernliZYc8SMaYZ+fQvvfgLT6r30I=;
        b=i6J0DMbdcPi658qUe7rmq2fs8dODLIBvxGDdLJuKnugBnpJsnmxlynJZnI7YJDUCXo
         XmyA6rTr3GG2sMGPuOMoWLArpZhyMR+dtgpDDgHiad8xAjoBWR//QM2PzVodq/iW6KwU
         zvD3FPtuP3zEQfONarYQiUg0bu63ogNLjZ2iej/4n8muMazfiC/HuSeb54aZ6zgVj/5V
         uQ+hhD+OA3q8GUKZHQOS0K4gSioEpT3v8ki+cdKK5WOD2WL1BoLElMIy92oVRVSrBziN
         eUvbz/RR6lNUxJ6p6qcbzu3g4IUnDsEre4+LGB6WIoiBoX4BEtXaj3iW2IbNVN/BhtQk
         cd0w==
X-Gm-Message-State: AOJu0YzSHIUJJaDv9x3tUpY8IeEU2D0M11yEyL80A4FDJ+BpVAf2Yyvg
	gyf85LeDRH8Ih84IeIPcX4C28AB7Qi8om0OME7J2yNFTfR6Zaw2O8QO3
X-Gm-Gg: ATEYQzy3LtDXzhaHjraOH5OOKlMn4KEFC2rh+2SsKZTqCGcNMhPv7wn2ep3coRRXuy4
	hwPDl6YPGU3ebGiYQ7e2FeuY1rtYZ3gJRHy+YOmBo4mO7TcFuB0qY0MjmQBtY3cnFeGiySZHqKv
	J/zhhP4vmdkWP2CT8fbq+n/7OgV/NoLCIPOfWZ0FVJLYJPgpxddy7JSUMpx6djczH8n/EIsXsZS
	X48YqPgxckErLTEisVOAn4DdRh6znXdFMWNKy5eSD/SCj5aJlzGB+hrqEM9iRj3O3QAPMRpIDkg
	WDbnnJqeBRKkxADvubmt2aUtHrVu7adptGbk4NPtiPbFMtyB7SKls9nfR+0lFRCRMGo6od9f7Bg
	mpt/WODB3j85TobFESJXUwxq2efgXxE4OIdLwSaWrAIe9xR8ZeQQnjUrfMKLAgX7B2Rx89Y8l9t
	kh8x1UkHhhy8p5oW95QEtVDOkGNYEvYW99bM+WkB1zAknSi0f+URpwNvcC096f2Z/rrhnAk167I
	hb/RD4wlMQ56dvwHhv/z/TofOW+cJYaOIrISb9TGos=
X-Received: by 2002:a17:90a:d604:b0:35b:982a:28c4 with SMTP id 98e67ed59e1d1-35bb9e3d04dmr4936496a91.3.1773881703854;
        Wed, 18 Mar 2026 17:55:03 -0700 (PDT)
Received: from DellG15.lan (2001-b030-804d-ff67-2d87-7642-b84f-7a21.hinet-ip6.hinet.net. [2001:b030:804d:ff67:2d87:7642:b84f:7a21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62e4506sm860182a91.6.2026.03.18.17.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:55:03 -0700 (PDT)
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
Subject: [PATCH net v4] net: use skb_header_pointer() only for DODGY TCPv4 GSO skbs
Date: Thu, 19 Mar 2026 08:54:21 +0800
Message-Id: <20260319005421.14908-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0a25f57e-fe08-4fe9-9722-e1c6adb81e91@redhat.com>
References: <0a25f57e-fe08-4fe9-9722-e1c6adb81e91@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269239-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.572];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4E1AC2C43C9
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
v4:
 - Move struct iphdr _iph to the outer scope so a pointer returned by
   skb_header_pointer() remains valid when iph->frag_off is checked.

v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..d47bf7b1fa99 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3805,10 +3805,20 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		int nhoff = skb->encapsulation ?
+			    skb_inner_network_offset(skb) :
+			    skb_network_offset(skb);
+		const struct iphdr *iph;
+		struct iphdr _iph;
+
+		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
+			iph = nhoff < 0 ? NULL :
+			      skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+		} else {
+			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
+		}
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1


