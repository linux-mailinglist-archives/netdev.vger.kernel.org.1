Return-Path: <netdev+bounces-290800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHgaGD5FEGpyVgYAu9opvQ
	(envelope-from <netdev+bounces-290800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15415B3625
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DBBB30A22F4
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6323F5BD0;
	Fri, 22 May 2026 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZncANVqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2523ED5C8
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450916; cv=none; b=aJbR72Dvp3lCCKaI73/z8aTi/xaVpQIV+pAmZIjLbnjLNaTd6XHGhXzGEh2IeyrFFsoTqB49L/LrRTrbWLbZL+2u4iBDwWM1fBrvOvsgsGlPzQDGScv7BrkL2XpJMPR4yN0qc/cy2cRvVdHj2wg/JBZJGZZ/tvaavSR6qppkOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450916; c=relaxed/simple;
	bh=nCqUD/K+laV0zC7GE/7Q79w435/NySyOe35dTciAaVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P1c3D8gWN7tWR2mRao97y0QlOHa0rKR0/MUto767zOR4oK4w5s+GuK3QKSp3/9y2cz9Y1N+b/JxBB4Fm0jQVMri00XjkgwuNJT98jT/DwbiHgCf/3r/RBJw6Fng/EKt/FKdM8YiCvOLuYxhqzZfQkEjfH0G3dtOEjkxEyBgVU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZncANVqf; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8b7105dfb5eso212642456d6.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779450914; x=1780055714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/wkpv54GBSdWAoduA39aS1FLzx7lj+JTvE39xAjatQ=;
        b=ZncANVqfn0RyJbWw2L5iipZQglgu19qfiMtpV22Yk0XP1McaQUSVuKz1wrpTis7vkI
         +7s1I/R4KhQt5rkE/MFBdaNnGtFAbAtEiyutFkZs6ZyeDk0iE87iy3VasJJKm/HFf3gB
         ADAb6tylaqCISSm9MYm6glDa53OFMb5JbQ7j88gkJzEUcHWJ8JOhBEmO6HTXvPjXxiQ6
         YsVv71pbpoJDlWuTAMA0cs3DQ2g8Z/OO0x/IS4QioZckhKEN2koxEGpHvvon8LGk/B38
         oBpJHykpAue5rXy377bF/t0vVIJ9Pc1V/3vEyGT0T+RUFFHaVHEqCE2JtlTRilOIpL2y
         vJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779450914; x=1780055714;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/wkpv54GBSdWAoduA39aS1FLzx7lj+JTvE39xAjatQ=;
        b=ASz9/LcZnCqE38rgZOVK4fSP4z7aPBIuPaYDz5sOpgHOSbc6pbJiHGhAAVSv2xxU1H
         zkE7sr9O0vORvZ4Jvx7qhuuPNVUE+i+rHic7Bvi3xg1x1Gxz2yzMd30BrzqmKUV07YrK
         ld5pCJmSOn5t6E/8DfDLVuN/Xyl96T1cZBfBfhIRMsymP0ddR0VI9IAxqe1dHQWxlRcy
         66PRnw9BTeNuB36Vfp32S0zqhKlFEply3MCr6lauvqsYQSZBQNTtgS2DqWHVcXpWVfvt
         Ht2rWBoDt4sWkF711iXHphTDhWAPMAHVYosvosPHvzQAHFrTs768nX7QOIixlthcMgxx
         iTIw==
X-Forwarded-Encrypted: i=1; AFNElJ+rXQi/cgVuoTce5zIax63kGBuP4Kvo9LIwlnUBGHLYMQhDF97HKs2r6L7HUHyYuMbm91ePQz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJhOHTs9l5YJ79d8sta8eMwPGYEl4Emu4C4VcT9mKxuhYpGXw
	c6WeB19DeLdpgppK6x28+esMJhQCqgPSm+tVd8Jh1ZYWMtDnMI9oQfaGW6F2Lr01XY2ZOy2JXJI
	4NC88aoDpqWszaw==
X-Received: from qvqg15.prod.google.com ([2002:ad4:514f:0:b0:8ca:b44:ec0a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2aa6:b0:8bf:87c5:fa21 with SMTP id 6a1803df08f44-8cc7b69e13emr57629656d6.49.1779450913321;
 Fri, 22 May 2026 04:55:13 -0700 (PDT)
Date: Fri, 22 May 2026 11:55:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522115512.1519110-1-edumazet@google.com>
Subject: [PATCH net] tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290800-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D15415B3625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In some cases, iptunnel_pmtud_check_icmp() can be called while
skb transport header is not set.

This triggers an out-of-bound access, because
(typeof(skb->transport_header))~0U is 65535.

Access the icmp header based on IPv4 network header,
after making sure icmp->type is present in skb linear part.

Note that iptunnel_pmtud_check_icmpv6()) is fine.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2667f53482bdaf1e693907fc527063d0ddd45580..5f82d84f0f1d0bf863716d8e777f1007f871b9b3 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -281,7 +281,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct icmphdr *icmph = icmp_hdr(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 
 	if (mtu < 576 || iph->frag_off != htons(IP_DF))
@@ -292,9 +291,17 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 	    ipv4_is_lbcast(iph->saddr)  || ipv4_is_multicast(iph->saddr))
 		return 0;
 
-	if (iph->protocol == IPPROTO_ICMP && icmp_is_err(icmph->type))
-		return 0;
+	if (iph->protocol == IPPROTO_ICMP) {
+		const struct icmphdr *icmph;
 
+		if (!pskb_network_may_pull(skb, iph->ihl * 4 +
+						offsetofend(struct icmphdr, type)))
+			return 0;
+		iph = ip_hdr(skb);
+		icmph = (void *)iph + iph->ihl * 4;
+		if (icmp_is_err(icmph->type))
+			return 0;
+	}
 	return iptunnel_pmtud_build_icmp(skb, mtu);
 }
 
-- 
2.54.0.746.g67dd491aae-goog


