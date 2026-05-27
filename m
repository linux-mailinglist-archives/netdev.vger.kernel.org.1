Return-Path: <netdev+bounces-292223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKNCMqC+FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242495E224B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12613009166
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AD383C7C;
	Wed, 27 May 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="NDkFc10s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED63BFE38
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875484; cv=none; b=KQy6kRomeqbdz66KUNsFNj5BPRnliAyRQyOlwgkoZrJASFMpTPQCnz2a0mf61Zf1frYli8TgjrgD4goLG+sLJBrQoL0bgJZ8U6+ou7RuIxDhyu2JolBvFivQqJensOark8PsUuznJtJ5OSI4znDXy9UFc5pgHRuNjtQ2XlkYVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875484; c=relaxed/simple;
	bh=FhOru0LkjtK9KlCo9Su4OyMriEnBTJCGfVVgls09jNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imftm8ATd6GcZc/dyYQO/FXGE5qV/04yXAWj2xzpgqoFu64yFlJN9B35N+Z0znuVGEWMyJoxODgT3/EnfRSpnoRWRiNM2WQXeY+t8ZnKuZN3rHDztB4OmPYpU5iNpDPcc4STEn294WetVIvEzc9VGime38sNO1irpynJXNXoFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=NDkFc10s reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso9234142a12.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1779875482; x=1780480282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPeZ4rIumdd2AJnMmbRbkMdKC8gRmM+285vY/vqYczk=;
        b=NDkFc10sbyzP5yGuy/pgSxQsIxx3eq8N9p7j/2FL/Uu/Bn4MTLDJo6Wgr9nD5IQJQZ
         UUKkzovChcTDSOLDodWqM1S/CvxRVSLx3wITyOfGxkrhx8FmmXrPgCbAR0KZ4B1hO27+
         9VJMLWau5YZ9RksZk1d+RLvx11cagK9sagxBpC+g0dyCBcncKQywSKXSpI4qw/VeoZF2
         Wv265sLJmLSWyF0pFSWnAi2YyQFi0xGCX9SlvlIi8YqODaT4wn5f71SWOQEdKy32w7XO
         rwk9QnPOV6A8Igg+PRTDIWb17qBme+dic0Hd6PON9ya1npNQ2XRNU3Y7PBMc+eGkhAEB
         OVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875482; x=1780480282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPeZ4rIumdd2AJnMmbRbkMdKC8gRmM+285vY/vqYczk=;
        b=V17HP85Qdt1lN06MkJsTSSXLS4apSovqgHGKAiJyWur8smcIq9p9/GF8FmRnJ7N7Q8
         Fv2cslBx0YI6PtHUgbqO1zNGWkdFxpY1y9humzUa5oeyLp8BODbElzzhMpvLGzCErQ2k
         z7/AH7ykwYyxuYDWvk0tzinTbe2UO47r3apb6tOjzVa5Q9192Ln8QVd8RlbsGeQPryXl
         FXycHo4MtRzUyCodZOiL5x2eOhO9k8gDxGPykAe4mSeAp1bM+5hdivt77E8cNhKvDigS
         QzdnR4dVVSa3hf2HPbcMplm5iqkaHbtBqcXN+JGRMCn4D1NxOY+G3Z62iMkxMwqplqoJ
         W+Mg==
X-Gm-Message-State: AOJu0YzG3zX7+psQj2lbhnTgNjN1RLZaClE04s+VGefkcfURTtHwYu3M
	OwvLccb+sTKjTtSKh+QjLpXNxoogJjH6EgTitTucX61GVQYnGF8eTdbLNdFxFhTyJO9sCGgiB1P
	kHzoq
X-Gm-Gg: Acq92OF/W7QfZzpyvoY2WBcz3uJave9HydIpNKE4uFU5uQiknsA7yOP3pdbqUbY0qXG
	agBsjvaC+d/+NwMihBG0m6DTpXj+O7xHfJEZjbtEyLa9YvCKaHeIkUES8YR346cxpjoePCjtKGQ
	AFd1feI6ZSrnhvQKvdSkY7Tnrlt6Y8H04qbd/wMQ6yjx3ZpZeGPHSY6xpA/yhH+akdVoOo0FnKY
	KMcpaAF95EHZkfFNLM7N1qLMS+ABAjirv0YJ9ePPHzznNMcoxeKFjGVGHUcnQfDfetcuzwPjhWl
	yrPQ37p/1zgecs+tFttG1hFdC+lJAKjEnJWBkAiEDnILNB7L/SmZPeQEE3qvdAsDxYaaAywBA1Y
	1bqlCyv8yHlNfFmanelph/EMYOsNfz1QirMhD9/n4a96ZudSxOqeHVCZ5J2TM/cDUqBy5FTurxm
	8jzW8LbzeC9ot6jQELv5VgqUkYpWDGqfeHsvkKJenPP4Hc+OY5d4WVwpI4BSEKeR3G9i5spQ==
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:dabf:fef9 with SMTP id adf61e73a8af0-3b328eb2e40mr24190306637.27.1779875482422;
        Wed, 27 May 2026 02:51:22 -0700 (PDT)
Received: from manjaro ([103.186.230.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8520561e94sm13332089a12.22.2026.05.27.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:51:22 -0700 (PDT)
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
Date: Wed, 27 May 2026 15:20:55 +0530
Message-ID: <20260527095055.23413-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[aerlync.com:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292223-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 242495E224B
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


