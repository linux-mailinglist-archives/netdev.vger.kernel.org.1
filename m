Return-Path: <netdev+bounces-292220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAzWCp+/FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC35E2396
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0A0F305E5E1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE33EDE62;
	Wed, 27 May 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="kMx62GHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEB274B5F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875194; cv=none; b=SoIrQy+nQEu6EUCCpZj8LEy1PYJovxMS51e6LV8/f8PSTl1I2Uehenke/u5l/Cj/vwzWk0We0q+aoQO1L8sMLPh5nvHRO7e4eyWkMK+0xFpLH7/R46X4DBw02Z7T1E+eL3UkFXPjQiWig0T/hU0NbiYzYiVKYMXiIC4PIDIeAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875194; c=relaxed/simple;
	bh=FhOru0LkjtK9KlCo9Su4OyMriEnBTJCGfVVgls09jNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG5vdAw+8aCCvyDVaUONGDq2+565vnZ+DOV2+FFJi+o/+bNL5f+G8okizQCJ2yR4+UkOolxrWVE+moHf1C8rn9FObikinTkiCs2ljUrvwto7jrbB3tyiXQ2W6eYfGP/LqLO8u+7KuL2ecX/ppqdnQiPvYf73uw1RZamBEJ0ZvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=kMx62GHY reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c828daf83e2so5129068a12.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1779875189; x=1780479989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPeZ4rIumdd2AJnMmbRbkMdKC8gRmM+285vY/vqYczk=;
        b=kMx62GHYY3TfIRqJWmwzhM4ffQNRQxCjVFJtxwHkrVzeH3CmOcKrs7830ashCZxXjw
         QwqyJh8XNSWCsPzktPEB/mZuH7SCMD1Lp2c6EJBFClVY4LrB+cB6VYcLHKnwBl9HQVRf
         5A10aUZX0QnH//e2iIPZqmtvBkeOXNIar1t76uFZuJ3VAA9sS8u2PtMzewVThJVSlgNR
         9J8S855rpnY7UikmX6w6fIkza9FzYCV2xDKAYOMk9KGM5CYnf9KnOPRHrIdnqf8JHEXs
         tD7T4Zn/Y5ID/bCCf0L5EBmTDD2Adh77CVkkPdBE0HI65CEZEnD235O3EGo+3DfwLO8S
         fEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875189; x=1780479989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPeZ4rIumdd2AJnMmbRbkMdKC8gRmM+285vY/vqYczk=;
        b=XP9iOLAqirnmOS525c/RSeT4diyigMvQJPTF4RAk3XT4LdY55lggYCDB8sXJtlcohj
         Z8vs8Ipzz1/Kc5pDnuUWK3lzlq5nAq67n80NqI0GNFAy1rPCYInw5uNhLq5ogtVur5ph
         S6Xgqq1sLrAMwIG6qreeZ7BOjWoTeE9biXNg4f21SkiFdsHsOq70xDWarucS6FFZy+nO
         SECmHgchx3Zgil8D1ovMAT5YEDVJx0Z486ffUNoSl8jwP4dotyZf2YmtMkqbRxxHtB2a
         beP4xcJZQ5KH/9wh3m+DUpuJMUsi7NmBWec1AncJpXaRmZk1lNL7JxB97NDnpNtSWZgF
         T/UA==
X-Gm-Message-State: AOJu0YxdKfBCfidQtV84NoVTP4IOWpMzKfPoPpnRm2D7JPn2Jf17Wd92
	mw7PVuhRNTCX2MxYIDJprLThm/BhQh43u81HNd5aG572E+xDXETYGxybNQckae1k/6QgkUGJYKZ
	ttK+j
X-Gm-Gg: Acq92OEbncZeIg+Dtq5GW4CJcCIQLVX9T3dg5UWKGTNoRie9NtHCMtQ7sOFPNidIiOJ
	xmYo4J9/SYYXuuQxcfDAPvpJqoXP+eVsIzeB2PO0m0/2pnlkVtdqu0tswIQOocwD3ZjQBCPerNF
	Z1NfdS4xS8N970U7i2PTTYW3Y9Iz0TwuCxhYYgeGTtNTFgfRka1TwSLSCbTo6YDnhWvK8KwsnrM
	kfYfy0/mw7nHlMsJUSnmh0grNB1bTeKsGCrAkJDD9vVCGft7qN4vySQ//JLu+hR6tbxvfJRpoLH
	r36NXk0H9uZuuUCZnr8qtg3uYXKWBUZB30EShbhxhznzbLolNAjkMAe4iu2SXdF7uYVcz1dvVaC
	fWVIpNouh1xRZz2GVtd5lbDZeL44hn8cr1xkidg8XcslF9AZxNyjFlyyBSBCm9Jx+1zZesHIPo9
	gfDLYMzJ8eV6aauSJuqKCRzIOu8V/vyFrSp29GMnRB3BH/pH8GnMJS6uqujXpRU5pcVmt6bA==
X-Received: by 2002:a05:6a00:1acb:b0:82f:6e7:1527 with SMTP id d2e1a72fcca58-8415f32f286mr21808866b3a.23.1779875189021;
        Wed, 27 May 2026 02:46:29 -0700 (PDT)
Received: from manjaro ([103.186.230.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7301255sm2063068b3a.57.2026.05.27.02.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:46:28 -0700 (PDT)
From: Sayooj K Karun <sayooj@aerlync.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com,
	Sayooj K Karun <sayooj@aerlync.com>
Subject: [PATCH v2 net] net/ipv6: icmp: fix is_ineligible() to block errors for Redirect packets
Date: Wed, 27 May 2026 15:16:01 +0530
Message-ID: <20260527094601.23276-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526101622.38536-1-sayooj@aerlync.com>
References: <20260526101622.38536-1-sayooj@aerlync.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[aerlync.com:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292220-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aerlync.com:mid,aerlync.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 22BC35E2396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Discovered while reading RFC 4443 and cross-checking the ICMPv6 stack,
which in section 2.4(e.2) mandates that an ICMPv6 error MUST NOT be
originated in response to an ICMPv6 Redirect message (type 137).

is_ineligible() is called by icmpv6_send() to decide whether a received
packet is eligible to trigger an ICMPv6 error. It uses
ICMPV6_INFOMSG_MASK (0x80) to suppress errors for ICMPv6 error types
(bit 7 clear) while passing informational types (bit 7 set). However,
NDISC_REDIRECT has type 137 (0x89), which has bit 7 set, so it passes
the mask check and is_ineligible() returns false and icmpv6_send()
proceeds to generate an error in response to a Redirect, violating the
RFC.

A triggerable scenario: a host with an ip6tables/nftables REJECT rule
applied to incoming ICMPv6 traffic (e.g., dropping Redirects from an
untrusted router). When the Redirect hits the REJECT rule,
nf_send_unreach6() calls icmpv6_send() with the Redirect as the
triggering skb. Without this fix, is_ineligible() returns false and a
Destination Unreachable is erroneously transmitted in response.

Add an explicit check for NDISC_REDIRECT so that Redirect packets are
treated as ineligible, suppressing ICMPv6 error generation in response
to them.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
The bug can be triggered via a netfilter REJECT rule targeting ICMPv6
Redirect packets. Consider a host with the following rule:

  ip6tables -A INPUT -s <untrusted-router> -p icmpv6 --icmpv6-type redirect \
            -j REJECT --reject-with icmp6-adm-prohibited

When a Redirect packet (type 137) arrives from that source, the packet
enters ip6_input(), which invokes NF_HOOK(NF_INET_LOCAL_IN). The
netfilter framework iterates the registered hook entries via
nf_hook_slow(), reaches the ip6tables filter table, and evaluates the
rules. The incoming Redirect matches the rule, causing reject_tg6()
(net/ipv6/netfilter/ip6t_REJECT.c) to be called as the rule's target
action. reject_tg6() calls nf_send_unreach6(), which in turn calls
icmpv6_send() with the Redirect packet as the triggering skb.

Inside icmpv6_send(), is_ineligible() is called to decide whether to
suppress the error. The function detects that the inner protocol is
IPPROTO_ICMPV6 and reads the ICMPv6 type byte. NDISC_REDIRECT is
type 137 (0x89). The check !(*tp & ICMPV6_INFOMSG_MASK) evaluates as
!(0x89 & 0x80) = !(0x80) = false, so is_ineligible() falls through and
returns false and the kernel proceeds to transmit a Destination Unreachable
in response to the Redirect, violating RFC 4443 section 2.4(e.2).

Tested using network namespaces with the above ip6tables rule. Without
the fix, tcpdump confirms a Destination Unreachable is transmitted in
response to the Redirect. With the fix applied and verified under QEMU,
no error is generated.

From the RFC:
(e) An ICMPv6 error message MUST NOT be originated as a result of
    receiving the following:

    (e.1) An ICMPv6 error message.

    (e.2) An ICMPv6 redirect message [IPv6-DISC].

    ...

 net/ipv6/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index efb23807a026..3fdb3a97dd8e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *skb)
 		 */
 		if (!tp && frag_off != 0)
 			return false;
-		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
+		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
+			 *tp == NDISC_REDIRECT)
 			return true;
 	}
 	return false;
-- 
2.53.0


