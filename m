Return-Path: <netdev+bounces-272506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGHQFWBpxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:26:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C679034369C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF35301303D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D238550B;
	Fri, 27 Mar 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVko6hsG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEC3B0AD7;
	Fri, 27 Mar 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610461; cv=none; b=mwAYR+5AwXmiRFPe0B3uebQo2Hu8QlhI1e/+tGjEfTHHAwJl0Cp5rYbADk94THPT8KTZcKIU8UoTm4wo/PT/TPU9lJVFd9d1EU/c258Y06ifRcEcrTyyP6eIDQQmJJllsO5xzD0o6HpUCXemhQOZ/1UKgjC9VrJJaqfFlOimhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610461; c=relaxed/simple;
	bh=CexnmDRZ7Cp+fH+8nL6oilVVi6b5Bwd+yn7ecTHIIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZWxZmQkncaOioDaUfGUThJONz1KPtKGF8nM34MMseELaJQmPkgUJsoOLzDmy+mnyXIWI5jl7wZKtuuwWk8NxfS14NpH2PFwWGQbshKVpeQbA+1p17omdM8eWfuE5BNwdSnxb0dVxfUCcNVzXq/YuJYuiBqAWauGBSaPIzeVp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVko6hsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92973C2BC9E;
	Fri, 27 Mar 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774610460;
	bh=CexnmDRZ7Cp+fH+8nL6oilVVi6b5Bwd+yn7ecTHIIV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVko6hsGi9f9VFcN7+zZSpRJQC4NcplZGU3SYz8i5aONt/2D4q35oauA15LZP+RVf
	 6lC5dkyY9NBnZ2+BwxSiq6nvzcxWoNUViZwpNx84PowmKbFGzdfoKEmtnGEk5g/1lX
	 /RIxVFguMv3divtttcIlHAa7EWH4XgEBWKmin/2mIVm6TwpmJVS4tImNyVWZHIO+b/
	 LW9s9jVEXD+3CK0KAu3tsyTFuGjxaLT3SCQ433YlkIAsANk91VnJFje26AsJEwkS9F
	 DFBGMzP7zJHDPq4Aq+Iwu75yE5X2//PzlDYbvwPNsFL16/YVidAlwv6paKNDxlJL1m
	 743EC93Xb7B8g==
Date: Fri, 27 Mar 2026 11:20:56 +0000
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: cfm: do not reschedule TX work when interval
 is zero
Message-ID: <20260327112056.GC567789@horms.kernel.org>
References: <20260326031957.3299500-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326031957.3299500-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272506-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C679034369C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:19:57PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() uses interval_to_us() to convert the configured
> exp_interval enum into a microsecond delay, then passes it to
> queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
> callback re-arms the same delayed_work struct at the end of each
> invocation, forming a repeating timer.
> 
> interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
> out-of-range enum value. When this 0 is passed to queue_delayed_work()
> as the delay, the work item fires immediately and re-arms itself with
> zero delay again, creating an infinite tight loop. Each iteration
> allocates an skb via ccm_frame_build() and queues it for transmission.
> The skbs pile up faster than the network stack can free them because the
> worker never yields the CPU, rapidly exhausting all kernel memory until
> OOM deadlock panic.
> 
> Since CC config and CCM TX are independent netlink commands that can be
> issued in any order, there is no single configuration entry point where
> rejecting interval=0 would cover all cases.
> 
> Fix this by checking the interval at the start of ccm_tx_work_expired()
> and stopping transmission immediately if it is zero. Set period to 0 so
> that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
> restart it later if a valid interval is configured. This also avoids
> transmitting a CCM frame with an invalid interval value.

Hi,

I think that the principle should be that code that doesn't need
to be in the datapath shouldn't be in the datapath.

So, with that in mind, I think it would be better to set a lower bound on
exp_interval when the mep is:

a) Created. It looks like that happens in br_cfm_mep_create
b) Configured. It looks like that can be done by setting a policy on the
   minimum value of IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL

> 
> Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

...

