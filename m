Return-Path: <netdev+bounces-288540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJGvCYvEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9A559B09
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1006F3018C01
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28212877DE;
	Sat, 16 May 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuOq1zlu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5522F01;
	Sat, 16 May 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893934; cv=none; b=OAen5CPase0leBFwVR/eRRUTjvZszZPIfC9soUx+aZE2avP1MW0v/nOXU7HFuaHjttvvYJg596jN92DQ8Pi5vSGNOg6PvibmjrqeESP8UbJow+BCFOM5nevcTMz0ruMRoMfbp8Xm+qsWH6iAjHVd1PuZ8Ssc5WBZCynkUH1Q9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893934; c=relaxed/simple;
	bh=kl6nArGsb2HxlHIA+dMBM1mIEbBuHXLZ/1LYYT0F72k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGOncMWbqNfsoHevBu8mi3ZNFKVMym8wSqrqnXjYgCPOK3Di3vz2M3kLiPNBCWy5kdu1kyAq9WeQ8yg5LrHq6jTKvSbzkfaxPspgsTY3smuSm0uGY9GeBDdRxVKtkVIWs/hO49sbU++04GvO4Ag286/zbfDf1tjgShpIHF01ky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuOq1zlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F0CC2BCB0;
	Sat, 16 May 2026 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893934;
	bh=kl6nArGsb2HxlHIA+dMBM1mIEbBuHXLZ/1LYYT0F72k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuOq1zlu9HwfvdzXyw1XlMZt5AtIx8MoVt32JOe6sPbIOvdq6xMgr+/L+6NsPb8Dk
	 TfJy+wvCiyTtQUafo5uM8bIjJmYmc8tTiQKDijkImgFGmYaPgh9AL0m/kizW5iVoxk
	 7YkhUV6Pw+ZqRSgrV84QhfSqLAFV+laTXjfywyhWjwxS9o885URcyYaLgXuy0Re9Dw
	 0bhPSjPhaGmTCuMQje9h7fGVRvq6R3daajKwqnRs0EJ9VtNrJszmYnw9eJE/D4Mq1L
	 Tm1IQXco+mP7LiWISZNA5KXWkoGRVliS/Nk0oApJz7U4DNA1fs9TOzYxtriJEt686J
	 uEv0YPuho6UJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: t.fuechsel@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lukas.prause@ikt.uni-hannover.de
Subject: Re: [PATCHv2 net-next] tcp: Add TCP ROCCET congestion control module.
Date: Fri, 15 May 2026 18:12:12 -0700
Message-ID: <20260516011212.1859280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agMMMUotXaG_Ypqz@volt-roccet-vm>
References: <agMMMUotXaG_Ypqz@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98D9A559B09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288540-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email,doi.org:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Note: The format of this report is altered to provide a free-form summary of 
the findings due to recitation restrictions. The original patch code is not 
quoted.

commit 838c20dc5dd6210ad01e69f78cc66400822cd8c7
Author: Tim Fuechsel <t.fuechsel@gmx.de>

tcp: Add TCP ROCCET congestion control module.

TCP ROCCET is an extension of TCP CUBIC that improves its overall performance 
in cellular networks by using additional metrics to detect bufferbloat. It 
introduces a modified slow start and uses srRTT and the acknowledgment arrival 
rate to determine when to exit slow start.

Link: https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
Link: https://doi.org/10.1109/WMNC.2016.7543932
Link: https://doi.org/10.23919/WONS68803.2026.11501781

Can the srRTT calculation cause a catastrophic integer underflow? If a socket 
has not yet received a valid RTT sample, curr_rtt remains 0. When 
roccettcp_cong_avoid() executes, it calls update_min_rtt(), which computes 
curr_min_rtt as max(0, 1), resulting in 1. Then update_srrtt() calculates 
curr_rtt - curr_min_rtt (0 - 1). Since both are unsigned 32-bit integers, 
does this underflow to 0xFFFFFFFF? Multiplying this by 100 yields 0xFFFFFF9C, 
which gets integrated into the curr_srrtt EWMA. Would this resulting massive 
value instantly exceed the threshold and falsely trigger a severe bufferbloat 
response that permanently cripples the congestion window?

Are the congestion control state variables curr_rtt and curr_srrtt properly 
initialized? In roccettcp_reset(), memset zeroes the state struct only up to 
the curr_rtt field, leaving curr_rtt and curr_srrtt uninitialized. If a user 
dynamically switches an active socket's congestion control to ROCCET via 
setsockopt, could the icsk_ca_priv area contain leftover memory from the 
previous algorithm? Might these garbage values be fed into the core RTT logic, 
causing unpredictable bufferbloat detection and spurious throughput drops?

Is it safe to expose internal TCP congestion control callbacks as BPF kfuncs? 
The module natively hooks into the TCP stack, but it annotates its static 
internal functions with __bpf_kfunc and exports them via 
register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS). Does this allow arbitrary 
BPF struct_ops programs to call these native state-modifying functions 
directly? Could a BPF program invoke these functions on a socket using a 
different congestion control algorithm, blindly casting sk->icsk_ca_priv to 
struct roccettcp and corrupting the socket's internal state?

Could the 16-bit ACK rate counter wrap around on high-speed links? The 
ack_rate.cnt field is defined as a u16, accumulating the number of 
acknowledged segments over a 100ms interval. On modern fast links, more than 
83,000 segments can be acknowledged in a single 100ms window. Will this 
silently overflow multiple times per interval, recording an artificially low, 
randomized rate and breaking the slow start exit conditions?

Does the interval boundary logic discard acknowledged packets? In 
update_ack_rate(), when the 100ms interval rolls over, the interval state 
rotates and ack_rate.cnt is reset to 0. This happens inside an if/else block 
where the else branch contains the counter increment. Because the else branch 
is bypassed during a rollover, are any segments acknowledged by the specific 
ACK packet that triggered the boundary cross permanently discarded, causing a 
persistent undercounting of the throughput?

Can a timestamp wraparound freeze ACK rate tracking for idle connections? 
The update_ack_rate() function evaluates elapsed time via an explicit signed 
cast of a 32-bit microsecond timestamp delta. Since this timestamp wraps 
around roughly every 71 minutes, if a socket remains idle for more than about 
35 minutes, the unsigned delta exceeds 0x7FFFFFFF. Would the signed cast 
convert this into a large negative number, rendering the interval condition 
false, freezing the interval logic, and causing the counter to accumulate 
indefinitely without rotation?

Are ECN marks being ignored and cached, leading to spurious later drops? In 
roccet_in_ack_event(), receiving an ECE flag sets ece_received to true. 
However, in roccettcp_cong_avoid(), this flag is only evaluated and cleared 
if curr_srrtt exceeds roccet_xj. If an ECN mark arrives while the RTT is low, 
is it ignored, leaving ece_received stuck at true? Could this stale flag 
falsely trigger a severe congestion window reduction hours later if the RTT 
naturally spikes above the threshold?

Is there a division by zero vulnerability during module initialization? The 
variables beta and bic_scale are configurable module parameters. In 
roccettcp_register(), bic_scale is used directly in a do_div() call, and beta 
is used in a denominator. If the module is loaded with bic_scale set to 0 or 
beta set to 1024, will this instantly cause a division-by-zero kernel panic?

Does the implementation match its stated ACK rate bufferbloat detection 
mechanism? The commit message states that the rate is sampled over 5 RTT 
intervals, and slow start exits if the rate stays on the same level. However, 
the code uses a hardcoded 100ms interval, and the exit condition only triggers 
if the new rate drops by 10 or more segments. If the rate genuinely stays on 
the same level, the difference is 0. Does this completely fail the check?
-- 
pw-bot: cr

