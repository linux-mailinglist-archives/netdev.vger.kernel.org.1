Return-Path: <netdev+bounces-259888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gORPCskwm2k0vAMAu9opvQ
	(envelope-from <netdev+bounces-259888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EB16FA86
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D62300FECE
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07623570A4;
	Sun, 22 Feb 2026 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JFn9f5z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC442248A8
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778206; cv=none; b=ftoucqH7TbCGnXEVp3uFJN+wCbgSDni3i3Btl89PiO9mZs3ri5rKc+LVRNPELtT4r4dBzDNwqgkY1AjTkHuHP2gS1Su8TfewpxuXcgw+mPUq8YU7/JL1cSUyPQm4Umzu+UusktrkNNQC4BySFBV1VFMgCzQUk3SAYc2anY+uWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778206; c=relaxed/simple;
	bh=rnbek1Iwi7qlHWqEfo8ESEvJKxQUEY5jbcHUe6OKjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQC6e8mhnjvCe2NLy2hgD+rknNJo1i53Gi4kvmHkjudR3fXHtK4fVDkcIerz3kDgbJfiQCkKqh4Sd8RvcGxW3sx85hiUEKNwQwXT4k0fkerPznQ7MpO3XHOBZTSYmYL6vRmx1IJH95fDoELugd2xLt7UepuoTP34oEPSZCln1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JFn9f5z9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362197d174so2243854f8f.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1771778203; x=1772383003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzpxqNPGSFGHysEvY3gxBQ/Fl4mK8lzti20PHekkHDw=;
        b=JFn9f5z91fQ5h8DlRAhEI0rxvDPX6UjH8DiJXzH/Y6ddwrkFVuYqtbnKu8d8IDSybA
         rirOghWZ7k9TjzbVl/WQsR820RdZOjrA4QwN3KMXA5K/Hr+eX6kJmyoru2/ds5B+Y5+G
         sGmLsaEaY4rGm2W5ZiJOoqCFNE68Palhbgfy1qReEV+N382ctrfYSReT/8I9ypsEl0Ps
         Yvlcdm+HnREpDE7p3QERtTAb9aISY5b/lR/lEhVFlNZuf+SdB/C7BI4CZSo3/FWSWRNY
         rEENx1rpyxA04zZOhCNM63H5mNJK4cE0c2U+qyEmDMb7JdJI1nIU778dSXBcZCTyYUqM
         xPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771778203; x=1772383003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzpxqNPGSFGHysEvY3gxBQ/Fl4mK8lzti20PHekkHDw=;
        b=BlYfV315yE7rDgFdwHtCGg0N8d3Adi47NwTAvc1WAFgmNroul2G+Y2iA65Db9zQE5y
         3kuw5bd/OWbhNi2cTOWtEutQNdDPq1CxEgT0BpvV6+V33xqlJVstau5R+s8ryOv/LO4G
         d/+4U5YTbQn+4HSBNpNO2FH55mPvPMqFnvGrTzDKcXR9zGLlvUYPd+e4ZG1gB8SW5Dht
         NbW6dLmXLqPDZ9qYf7yJ6zwLYsPHhm4gLft4uj7g9OCik2cELOcNdoExezQeXx33YEvu
         ZP/XylRRT2HDkPkIfjXdG3IBLqlZ0tEmf40KX7GX20Qukve2qRwRX3D68JV+X3sKvYHi
         utOg==
X-Gm-Message-State: AOJu0YyBpkPqlqPfr6Wbw6MGch5aXo0Yj+NBt+WFVaBhP0ByfrTYGRQM
	uYg2J8+lArjMJj7KGvtTMgOjvQperLC4OPcudhPBtFJA5vt8qWGxixeE4a3Fgt8RV0Y=
X-Gm-Gg: AZuq6aK8dG27OohY8iPep9HeL3SJbq0y/dV+UakMwx98s1kTvf7OuRNotTRe3yUZ+uk
	F/fFT3ou3YYSKtA51MoZfsiBZ+nJ+Ldxg/3PBfMKQxcbndYdGEFVVEZUtZ88GNFyLI1tpY/Nmn7
	eufaSIai5JdAssYpltrYlRcBP71PgXUG3yZnoz/0tnvhLTtUr5J6MWruI/5C46edPaPoL46HcVr
	O/m8cVOPKtN9YWlqJ9zAnxyddd+vILGRF0JWujnsMGGDSlAqRfiDyeQ9VRJS+SW4EEG9Lo+Vu1Y
	CgPQ9CxTmsbfcJbvlUdFgBNmFORXZxf+vVxEYBHgJ6jPfqVYShaDFB4qetFIkB4CaYX7nQp2Lpg
	F4HrOxAWO8Bg/eLndUAC9By4QOylk9dhq14ABvt9dqQlw2Q6NM8uK28q8jbabLFbABi41nl+0VA
	6sPg0SRXaBTmH3cyiiLAZyE0jRI695RwqRqYzcLqhUxDWDwMrATsQp9Tb6NGM6PBJykaln
X-Received: by 2002:a5d:64e5:0:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-4396f17a9c6mr10832074f8f.36.1771778203092;
        Sun, 22 Feb 2026 08:36:43 -0800 (PST)
Received: from localhost (176.111.181.192.kyiv.nat.volia.net. [176.111.181.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fff9sm13229307f8f.18.2026.02.22.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 08:36:42 -0800 (PST)
Date: Sun, 22 Feb 2026 18:36:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net 1/2] bridge: Check relevant per-VLAN options in VLAN
 range grouping
Message-ID: <aZswmWqzeZTkEFmO@penguin>
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222085338.3143823-2-danieller@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-259888-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Queue-Id: 7A7EB16FA86
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:53:37AM +0200, Danielle Ratson wrote:
> The br_vlan_opts_eq_range() function determines if consecutive VLANs can
> be grouped together in a range for compact netlink notifications. It
> currently checks state, tunnel info, and multicast router configuration,
> but misses two categories of per-VLAN options that affect the output:
> 1. User-visible priv_flags (neigh_suppress, mcast_enabled)
> 2. Port multicast context (mcast_max_groups, mcast_n_groups)
> 
> When VLANs have different settings for these options, they are incorrectly
> grouped into ranges, causing netlink notifications to report only one
> VLAN's settings for the entire range.
> 
> Fix by checking priv_flags equality, but only for flags that affect netlink
> output (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED and BR_VLFLAG_MCAST_ENABLED),
> and comparing multicast context (mcast_max_groups and mcast_n_groups).
> 
> Example showing the bugs before the fix:
> 
> $ bridge vlan set vid 10 dev dummy1 neigh_suppress on
> $ bridge vlan set vid 11 dev dummy1 neigh_suppress off
> $ bridge -d vlan show dev dummy1
>   port             vlan-id
>   dummy1           10-11
>                       ... neigh_suppress on
> 
> $ bridge vlan set vid 10 dev dummy1 mcast_max_groups 100
> $ bridge vlan set vid 11 dev dummy1 mcast_max_groups 200
> $ bridge -d vlan show dev dummy1
>   port             vlan-id
>   dummy1           10-11
>                       ... mcast_max_groups 100
> 
> After the fix, VLANs 10 and 11 are shown as separate entries with their
> correct individual settings.
> 
> Fixes: a1aee20d5db2 ("net: bridge: Add netlink knobs for number / maximum MDB entries")
> Fixes: 83f6d600796c ("bridge: vlan: Allow setting VLAN neighbor suppression state")
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_private.h      | 10 ++++++++++
>  net/bridge/br_vlan_options.c | 26 +++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

