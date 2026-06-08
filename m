Return-Path: <netdev+bounces-296476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRLoHi2cJmrfZgIAu9opvQ
	(envelope-from <netdev+bounces-296476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC0655390
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:40:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b=QNyAtSUL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296476-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3E03305FC4A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97723B47F1;
	Mon,  8 Jun 2026 10:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B938D017
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:32:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914765; cv=none; b=rjP9xYLLZbAZ6i/WFxvNer9c4T29/Cj6L/hmmyQGJzozGVLb/e6w0XKy1HGTF318K/yVRbivQ/EQQ3MdXGtfhjlhRLLrmN9RCSrj40emhQDiFPERhghbNIJXHDO9U9toF4asfa98YoO0Nor/IcAsaDrnyh0wcZPV0TUfWfpdoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914765; c=relaxed/simple;
	bh=UwEbz+t34EV5iddH7QA8WixWMDCulwNmm3b2Mwp4hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZ/h5+JSomsMout/byh22ULUnUy9Hg+cDEO3KrEgv37PrqpJ5+o/xEYAWzYbPYeYw6BRmgJeo1jhi0deleow/eWb/wYP96CgSln+KTi0a4kKt1w0McotewXpOm5oo8OX7PRw2Fb/e515Yp24WwODcMScVkzaEJNzfTU1iobRcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=QNyAtSUL reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so1658289a12.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1780914762; x=1781519562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7z+CvKnAGor+c7U0dVX35N7V89+YB/8qEbvrSee3CY0=;
        b=QNyAtSULm8FwJUssxe5WNhfafXswnyxxWqbrvXC3uz/xSpdEyIBafibzlJrqmpGCI6
         E/tyY/AzIwyErdvzcj6LpmYDOsZ2Ke97EoiZOxVGJf6+1Y7JNfr0JaqIbPrjFdV5712/
         hhE6ZMzP8yN007c6sUX0aBa+5n3qCjr7HHQe91z2MNOoR0QFCMNdQh2fyrkFFy6jD/Ly
         +SSHAUM3eJzMPBoIEPz+wY+oKH8dNI2prVchI5K9D3h5NPoe0otRpz/T17z9Cq9C58hK
         l+n6EW+dW00xngtUHntIOHLt2DXkslUQGfjg+JVEqLf/+4WXDMNS5XuhThyMFhh2p74d
         kYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780914762; x=1781519562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z+CvKnAGor+c7U0dVX35N7V89+YB/8qEbvrSee3CY0=;
        b=F3IAADWtZtiry+2XDSEKLWcTo3Y3D5NGLPJSqDsBdVfIa7HzNC6OxyUYh1RfnBidU+
         3migy2l/Id/YB1vI+quuF9qkZfnNzYKWFcuen+3RqPuCKBK7vkitvwKXTNXO031MgV+n
         1chWNMqIf+Vh5gRDEVOF3s6RK7n65/6P3GISOrgralVWXJLZ7JQx8+cb8GBZp4RET9fs
         6bceOKmtC9Zls9lHonXFbEacYk9+JN53dUC8SDKs0yLDJSyAPcpALapWmPIVuk6LkwrU
         7kdwFJtp9PtpNY+bJvOkr0fVg74GgpCGxfDLjP3d4Y9hniWVJocm2yvWL2FMg7cznqp8
         CKCQ==
X-Forwarded-Encrypted: i=1; AFNElJ++Hrb1tdYSLD7fvd5beCVGh+PiQjej47bjPFhhuy/brwYcyKu7miygR7M0FkvJmhng32TxYWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTRBzhh1mIwbGGCxcPxa7XdHqYu7R+cdJ5MRpyCDJWb4DJZV6
	0CY0GUgZg1sCzIklX66kX+xvBSe5Y4XYj6v+jTznJvDoPsVC3MGl+pJT3fxteBkLCrM=
X-Gm-Gg: Acq92OGUZQyYw+CHg5pS4edRi7VCFGEQ0+Hvqc+z+lQUGpoauCMXcfkTmFpuB5votkb
	btidIuZp+ZMAZ0afxEtw3f+Oey2hvGq82bMoCs8B60BjMx3Ofu7FVwgxAvMsm4ZmnTrZgbPCkul
	eBvCEKtQgeh+MljpXzstfTpLoKq8/0IJOA+eTe3z0Of7BrkxEk1d/YE7Ygq38nfGWi8IcwXO7WJ
	zxd7Lo4s3GlKmp0cV5JZ9I2+p/mTmgTI/S5p/8BWiuLeo1c/CkARbrTfne/+n0J3MLGPPT5QbrZ
	0Kdh+YgJ3f7wz3k9Gzyd657PzGx8WZq0VUnRV64yZKPVGJ8bN+pcnGX0Xc0k4/tmU53RrNuilZ4
	wU3p+trf7gVp+f1o3Qp7F0vaVZ2T1y6TB4CT/iMgD4R2Hb3oycs8iMjSIDUaheBiZSL+Kitn3UP
	nx2GIraUpc/rYhStlcBq3h6NgR+EcT5oqTFmWPIhB/GZeDvBelQchm5wGUy9w=
X-Received: by 2002:a05:6a21:4d92:b0:3b4:85db:1bd0 with SMTP id adf61e73a8af0-3b4ccd659aamr16493944637.12.1780914762547;
        Mon, 08 Jun 2026 03:32:42 -0700 (PDT)
Received: from manjaro ([103.186.230.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm16326028a12.4.2026.06.08.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:32:42 -0700 (PDT)
From: Sayooj K Karun <sayooj@aerlync.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Sayooj K Karun <sayooj@aerlync.com>
Subject: [PATCH nf-next] netfilter: nf_reject_ipv6: do not reject ICMPv6 Redirect with an ICMPv6 error
Date: Mon,  8 Jun 2026 16:01:55 +0530
Message-ID: <20260608103155.8339-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-296476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:netdev@vger.kernel.org,m:edumazet@google.com,m:sayooj@aerlync.com,s:lists@lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,aerlync.com:mid,aerlync.com:from_mime,aerlync.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39DC0655390

While fixing is_ineligible() for the L3 reject path, the bridge/netdev
reject path was found to have the same defect. RFC 4443 section 2.4(e.2)
mandates that an ICMPv6 error MUST NOT be originated in response to an
ICMPv6 Redirect message (type 137).

There are two IPv6 reject paths, and they suppress this in different
places. The L3 path (ip6t_REJECT / nft_reject -> nf_send_unreach6())
goes through icmpv6_send(), where is_ineligible() decides whether the
triggering packet may generate an error; a companion fix makes that gate
drop errors in response to a Redirect. The bridge/netdev path
(nft_reject_bridge / nft_reject_netdev -> nf_reject_skb_v6_unreach())
builds the ICMPv6 packet itself and never reaches is_ineligible().
Its local guard, nf_skb_is_icmp6_unreach(), only matched
ICMPV6_DEST_UNREACH and let every other type through,
including Redirect.

A triggerable scenario: a bridge or netdev firewall with a REJECT rule
applied to incoming ICMPv6 traffic (e.g., dropping Redirects from an
untrusted segment). When the Redirect hits the REJECT rule,
nf_reject_skb_v6_unreach() builds and transmits a Destination Unreachable
in response. Without this fix the guard lets the Redirect through and the
error is erroneously sent, violating the RFC.

Extend the guard, renamed nf_skb_is_icmp6_unreach_or_redirect(), to also
match NDISC_REDIRECT so that Redirect packets are skipped and both reject
paths behave consistently.

Link: https://lore.kernel.org/ah_hYJa3byoUyose@chamomile
Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
 net/ipv6/netfilter/nf_reject_ipv6.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85c..d4eec8d9a 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -8,6 +8,7 @@
 #include <net/ip6_route.h>
 #include <net/ip6_fib.h>
 #include <net/ip6_checksum.h>
+#include <net/ndisc.h>
 #include <net/netfilter/ipv6/nf_reject.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/netfilter_bridge.h>
@@ -104,7 +105,7 @@ struct sk_buff *nf_reject_skb_v6_tcp_reset(struct net *net,
 }
 EXPORT_SYMBOL_GPL(nf_reject_skb_v6_tcp_reset);
 
-static bool nf_skb_is_icmp6_unreach(const struct sk_buff *skb)
+static bool nf_skb_is_icmp6_unreach_or_redirect(const struct sk_buff *skb)
 {
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	u8 proto = ip6h->nexthdr;
@@ -127,7 +128,7 @@ static bool nf_skb_is_icmp6_unreach(const struct sk_buff *skb)
 	if (!tp)
 		return false;
 
-	return *tp == ICMPV6_DEST_UNREACH;
+	return *tp == ICMPV6_DEST_UNREACH || *tp == NDISC_REDIRECT;
 }
 
 struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
@@ -143,8 +144,13 @@ struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
 	if (!nf_reject_ip6hdr_validate(oldskb))
 		return NULL;
 
-	/* Don't reply to ICMPV6_DEST_UNREACH with ICMPV6_DEST_UNREACH */
-	if (nf_skb_is_icmp6_unreach(oldskb))
+	/* Don't reply to ICMPV6_DEST_UNREACH with ICMPV6_DEST_UNREACH, and
+	 * per RFC 4443 section 2.4(e.2) never originate an ICMPv6 error in
+	 * response to an ICMPv6 Redirect. The L3 reject path enforces this
+	 * via icmpv6_send()/is_ineligible(); this bridge/netdev path builds
+	 * the packet itself, so it must check explicitly.
+	 */
+	if (nf_skb_is_icmp6_unreach_or_redirect(oldskb))
 		return NULL;
 
 	/* Include "As much of invoking packet as possible without the ICMPv6
-- 
2.54.0


