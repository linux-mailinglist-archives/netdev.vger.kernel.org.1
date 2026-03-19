Return-Path: <netdev+bounces-269645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI65GT1dvGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:31:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2F2D22D6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F9253015B6D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7003F8DF3;
	Thu, 19 Mar 2026 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+OpU2qA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFA3F7E93;
	Thu, 19 Mar 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952148; cv=none; b=iCm9Lz5TMp2BI6+KIoCCouMm8AMyhhOYOJJlRjmXoPxdjAW0OsZZSSfQgHChI4TlrOZAiqy0Nnyw5beEgXopF3Y+qxjq5CJBMrqeS+QRm1YV94xbwuHgodAAGZq226l43c1CJpNT7OqmT31VxT7KYonsqCbeMwHvhWRgv2I0u10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952148; c=relaxed/simple;
	bh=7ACvntPl68R9KORabL8FBbFxjqDNvytpN2H9zxa9d68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpiPtiGaB5EAfQvX59BVgQ3pdhW2hCQqhlf1N/UhQh0PcrfzPNX29qTbZUuWjQgqjSCJPb97Ji+dbNds+Z9IJChHR9yBg8gMaysuHOBkL6on/7KexVvbAKT56ZJPa4IVQImAWeegUaaJE+D77fNsFrWAPydI04MOzFMH1wDGFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+OpU2qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AD1C19424;
	Thu, 19 Mar 2026 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773952147;
	bh=7ACvntPl68R9KORabL8FBbFxjqDNvytpN2H9zxa9d68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+OpU2qACzJ+O+97qA71hO9HQdf2jcKV40cP+bWm66ghhFOEsQp6+XZQNLuouHaAF
	 kPfNpnXBFkC8wv2EnSBbwq76xYvTb7weya5ME+EbjIiyQs+663QDtUuAs7sxHUDgd7
	 G8UTsznBiXhPWNFeqwTSc5ShpvyYyrPzr5KvVf9TNjSXtyH+j7Yaw1zNrml/TEjsrP
	 ROWa42iRmyCa5hw3OrMLOOwZzigBP+cPFU26NAI1OA7OX6DKweDHcWaAaD36rF6VKL
	 MTX2YL4Ct3TbzTTdxJLS1JPQzOyizRmRw8N1sw+IhrXojD4iMvfsp3VFQBztMOfj4E
	 Be7NE+GqfBx+g==
Date: Thu, 19 Mar 2026 20:29:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: bonding: add test for stacked
 bond header_parse recursion
Message-ID: <20260319202902.GW1753385@horms.kernel.org>
References: <20260319035902.6106-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319035902.6106-1-jiayuan.chen@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,bond_stacked_header_parse.sh:url,shopee.com:email]
X-Rspamd-Queue-Id: 06B2F2D22D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:58:56AM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add a selftest to reproduce the infinite recursion in bond_header_parse()
> when bonds are stacked (bond1 -> bond0 -> gre). When a packet is received
> via AF_PACKET SOCK_DGRAM on the topmost bond, dev_parse_header() calls
> bond_header_parse() which used skb->dev (always the topmost bond) to get
> the bonding struct. This caused it to recurse back into itself
> indefinitely, leading to stack overflow.
> 
> Before commit b7405dcf7385 ("bonding: prevent potential infinite loop
> in bond_header_parse()"), the test triggers:
> 
>   ./bond_stacked_header_parse.sh
> 
>   [  71.999481] BUG: MAX_LOCK_DEPTH too low!
>   [  72.000170] turning off the locking correctness validator.
>   [  72.001029] Please attach the output of /proc/lock_stat to the bug report
>   [  72.002079] depth: 48  max: 48!
>   ...
> 
> After the fix, everything works fine:
> 
>   ./bond_stacked_header_parse.sh
>   TEST: Stacked bond header_parse does not recurse                  [ OK ]
> 
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
> Changes in v3:
> - Fix CONFIG_NET_IPGRE sorting order in config
> 
> Changes in v2:
> - Use tcpdump + scapy instead of custom Python script
> - Remove unnecessary modprobe and skip checks
> - Add CONFIG_NET_IPGRE to config dependencies
> 
> v1: https://lore.kernel.org/netdev/20260316165946.46e9f8f7@kernel.org/T/#t
> https://lore.kernel.org/netdev/CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com/
> ---
>  .../selftests/drivers/net/bonding/Makefile    |  1 +
>  .../net/bonding/bond_stacked_header_parse.sh  | 69 +++++++++++++++++++

Please take some time to run shellcheck over bond_stacked_header_parse.sh
and make it shellcheck clean.

I suggest that can be achieved by adding the following somewhere:

# shellcheck disable=SC2034,SC2329

-- 
pw-bot: changes-requested

