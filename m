Return-Path: <netdev+bounces-289876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ+sJfqNDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FE58BCE8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE672303CA7B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB63D890E;
	Wed, 20 May 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lG7Tk0ib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290463CF698
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272895; cv=none; b=Ih7A4CG4HFZVed9GHcP9KirpV9O0GQNMYZpuQoet3Xk9YMlv43nGEnQuFyE1A6RNg/xgkyLPXTbZkKiP1ycfw8TNK3LYtDgKo20VVZzrn8ZO/CdalUV7XXMi08Ih/HBJrg6wmnVeQigz5Ydk+I/WmLzoujlhbbcwMW4nzbsdCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272895; c=relaxed/simple;
	bh=Dt4gtk/9t8Q0pUGrAZDK5wPM+YunpJ40zv2ggc6be7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7ywD/2OGNibDVYFinN8fEqGS4rbhoJ4mzwel8RrPJZhqdk/iBN5wKJXb/cBH9R0rLBdCXBMIIOofu/qi7sGQpqLGOplayFMoFW8cLSxlbPufZabBlbdS4SyWtE4AwFOIau6WUjNoyXoH7YisoXAmGD0kq09AdAIP02WCmubjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lG7Tk0ib; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso2652209f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779272884; x=1779877684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2PRQ96kutFisa+sIMLWv8AnJneLspgAcXkKd0ULNdE=;
        b=lG7Tk0ibBWlG7IEXuitDMfkAdM486EKSBlx52kQ9/b4xYcnkH+k5N3X13XkgQhlpiF
         BYazzIP3ja+3UgvKLw7OC2OhFPQjXBZ/TaV6tzD2YmkvcVio9F/QvUcOZkJT+p+AlmAf
         yw9IoLt87VBc6mnfjpfyYFM6FALZQ2M7Hb3xdIMQs8S8vWvF75RWF9GQSJHXLNVOcaUG
         ni+HqdV1PHEEbUlfhpoJMEcBXUf7DuJWo/qBa+ZLWG28GzrpkVGpYZ7m7YbiU766OoRy
         8GR+GiGARN4yJBhOqGNbTEVBMynoaaWHDx0qHuzcqazqMzawbX9ocQQuFO6hCa6hraNB
         Aung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779272884; x=1779877684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2PRQ96kutFisa+sIMLWv8AnJneLspgAcXkKd0ULNdE=;
        b=eU1z0Gz6xdE4uI9EE0NENsW163+1UJOGzbzCo/FynVdbOwygsfPOA8ZlByiE3NVBKO
         l1+JqScPplfVOl97gF0GACWvPwJejbjERDw55pBjWfhnZ2snyDgHARbdI/scqWTaqx/+
         QvLm+xAbOmvdlF+swURfFwBVMFL5zYOnpI/4AMPhdt5NHdG8kAL8xl8fB+3MxTmYtKXR
         Z6BEDAZ1I53+Ewii5Uo5DE+y5ENnnxYKd/SmiOcCv6xAtPsrRJH6V95xvD6IDGcZhB6x
         TTxIx1Cb9eXT+bCgXgPcp7F2HWQK+kBVfAHBRyf7MUed1og9S/vLCAk/ggBw/mJQ6Ioi
         uAJg==
X-Gm-Message-State: AOJu0Yy6Y3Mtj3MMFtNSVyxEDB2iu4GSV139f25gEn1YMJtSIROhZJ+h
	us8vL3v9R7a9F97XXqs99zZuDV7Ivf1GOmuuxH4U+hRCNEg/HSwLuL+7UpyHs/5xrXw=
X-Gm-Gg: Acq92OFlDcbeDp4T1j+PEQom2ao+G5dImEEy3tJkdKYDhmfmPPfnLlHDwB53WGeU9AD
	dLW67dLLUissJh/wSOObHcZkxpl4naIXKhuTTM3GJoyDWLJsvyMCzr/vDqSg8DlrkPgXJIT8BWL
	SX0Yu8CfvzuW6/ElJXtsY7i0wzuuzD7PX8cK670irrZ54S2rjqpBRYJtyY8urTHjEh+WyrYhgUB
	U1fIfamzEXWcQyY1iutZr8j5TenhXnLqKs9/Xw/Rqy9QtG7H16UKEQm4/bpbtdN+zGgus1g+WZm
	iAoFLTdhSaAEu98o22Jmq5wxZ7SLkU2peztgb0hToXTHHAto2tVok/rgZdjS6fWCZqHps9HsDe+
	sa8wmiNJ8kv7e9ReZzgSJGIu+z0csGYrZ37OWcsZk2ck2AWprgGWWX8MMamHEoH8mhENDcq3AoX
	T/4vRrHxI2Itu59oqUvqTuTELhA+ov/0JyMvd8a26qCBcXXwKCeovenyXIrQ==
X-Received: by 2002:a05:6000:2f83:b0:45a:e3dd:5869 with SMTP id ffacd0b85a97d-45e5c595745mr38287206f8f.30.1779272883458;
        Wed, 20 May 2026 03:28:03 -0700 (PDT)
Received: from localhost (176.111.185.220.kyiv.nat.volia.net. [176.111.185.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm52156514f8f.30.2026.05.20.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:28:02 -0700 (PDT)
Date: Wed, 20 May 2026 13:28:01 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH iproute2-next 1/2] iplink: bridge_slave: Add support for
 neigh_forward_grat
Message-ID: <ag2MsQnu7tH8ULc7@penguin>
References: <20260517082501.899009-1-danieller@nvidia.com>
 <20260517082501.899009-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517082501.899009-2-danieller@nvidia.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289876-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Queue-Id: EF2FE58BCE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 11:25:00AM +0300, Danielle Ratson wrote:
> Add support for controlling gratuitous ARP and unsolicited NA
> forwarding at the port level via the neigh_forward_grat option.
> 
> This allows configuring the option via:
> $ ip link set dev <port> type bridge_slave neigh_forward_grat {on|off}
> 
> Or via the bridge command:
> $ bridge link set dev <port> neigh_forward_grat {on|off}
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>  bridge/link.c            | 14 ++++++++++++++
>  ip/iplink_bridge_slave.c | 10 ++++++++++
>  man/man8/bridge.8        | 10 ++++++++++
>  man/man8/ip-link.8.in    | 10 ++++++++++
>  4 files changed, 44 insertions(+)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

