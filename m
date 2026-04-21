Return-Path: <netdev+bounces-280120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRVNVd452lZ9QEAu9opvQ
	(envelope-from <netdev+bounces-280120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6543B321
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47A23065A6D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4303D666A;
	Tue, 21 Apr 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFwja/1H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B222A817;
	Tue, 21 Apr 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777046; cv=none; b=jYkOIFnuezobcUgURc/QMea8sTXeLeUqE9CDb6nFuZao3UxTulkUdDXV7wwZdBLTLKcz7ue4tFpyaHWH86yQDAqRT39R5IDGSTEdK6BivVH4pkHyAiWScp0/z109k3G6Zy+2Lq8509CBOwfB3Fj3fy38iu8f4yfg5WPyzmaHlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777046; c=relaxed/simple;
	bh=wdB6JNQz6DFu/XYSinyJ1DxwR8phdAf78gwLP/h2J5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEgkEyQ+z3QB6fsx/cjrp7Z/PF1v1zHwBG0qQ2Zs6LSlpt/BoXQnxsJrzRt7oDEPYSawdwNzLXlyh82pC6QM4JUbgQnLnSCblWP7afwZnoiGYX5hOj+YOHRcSiL77N/l6UoZ9l9oWUf102SzPcoD4if33NocqsrL8dBmBUdv5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFwja/1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EE6C2BCB0;
	Tue, 21 Apr 2026 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776777046;
	bh=wdB6JNQz6DFu/XYSinyJ1DxwR8phdAf78gwLP/h2J5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFwja/1Hn9YXep3bvu5CxTuoPGrUsNOQVhM8ifYCIH4fNcpgI7GpmgNdDWE8hXnyi
	 grSjVV/xCo5V0SMRUTI9f58JbY4ZM7beAQlVsDcYmujiynxzrbeFos/X+8qi4SHaDp
	 GrTNjrcYUvhPVBoricD9tmg1rz2qg4m74eiyLsfb7mGqIkzYDUVY87YZGTN6Df3n7X
	 fcmFa9DqOXHUuDAdsZ78don4SZYsJykLiSA2omD+OSRKvhCtJ74eBJkgdwoAoJiRjE
	 us5jQkPhllz51LCFMiP5nUYyutvTvDsK+oXf3x1Ohzmw5pJb8MXyE2rmNnc/0gkjSN
	 B/chdLfO3Eb0g==
Date: Tue, 21 Apr 2026 14:10:39 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dave Taht <dave.taht@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot configuration
Message-ID: <20260421131039.GA651125@horms.kernel.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-5-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418032027.900913-5-stephen@networkplumber.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,mojatatu.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 42A6543B321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 08:19:42PM -0700, Stephen Hemminger wrote:
> Reject slot configurations that have no defensible meaning:
> 
>   - negative min_delay or max_delay
>   - min_delay greater than max_delay
>   - negative dist_delay or dist_jitter
>   - negative max_packets or max_bytes
> 
> Negative or out-of-order delays underflow in get_slot_next(),
> producing garbage intervals. Negative limits trip the per-slot
> accounting (packets_left/bytes_left <= 0) on the first packet of
> every slot, defeating the rate-limiting half of the slot feature.
> 
> Note that dist_jitter has been silently coerced to its absolute
> value by get_slot() since the feature was introduced; rejecting
> negatives here converts that silent coercion into -EINVAL. The
> abs() can be removed in a follow-up.
> 
> Fixes: 836af83b54e3 ("netem: support delivering packets in delayed time slots")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>

I acknowledge that Sashiko has provided feedback on this patch.

1. "Does rejecting negative dist_jitter values with -EINVAL cause a
    regression in userspace ABI backward compatibility?  Since the kernel
    previously accepted these values and silently coerced them using abs(),
    existing userspace tools or scripts that happen to pass negative values
    might start failing to configure the qdisc."

This is intended and explicitly explained in the cover letter.

2. "Could directly dereferencing 64-bit fields from the netlink attribute
    payload cause undefined behavior on strict-alignment architectures?
    Netlink attribute payloads are typically only guaranteed to be 4-byte
    aligned because NLA_ALIGNTO is 4, but the __s64 fields within
    tc_netem_slot like min_delay require 8-byte natural alignment.
    Performing an 8-byte read from a potentially 4-byte aligned address
    might cause an alignment fault on certain architectures."

This patch does not change the presence of this problem; and I suspect
it is not a problem at all.

