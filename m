Return-Path: <netdev+bounces-233243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B6C0F21F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9786D4F8E89
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B230E83E;
	Mon, 27 Oct 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYr5iALW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881230DEA2
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580109; cv=none; b=RHZQ3T/L0RT5R4aVlFe0wPhdQ+T2a3Pcsh1V1OqjEkLVnJLG1UjeCgH754IXwxBh0LZ/bVcYv7vPNid+GtMTegyGCI5o/KAYH5TTF9qhQVCGE12hrehCXKcX/PjMUap/w1n+j8KUEBUpkbpOUkZa8NGAFjMZ+GTeXKV7yfOY7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580109; c=relaxed/simple;
	bh=Rbg/xIApRH61xx9kD8T7usjjJ2WobHBt0lmoRUT3BG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6IZzFPufQ57g3dmS7H/tPhsFqxZhcvvfFtpvZrctu2cRXgedMtt0gPac4Zg+kDWED/+i9r3bH0Lg+6jhutHcFzsFeneHOXlJS5TJe12SV8Ll/9i4wd5nxP5aBQZ7bYmTs8PvRmwWXaJU3R82Kb0MpPoieHS5UK6RLKgYf1JXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYr5iALW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E449DC4CEF1;
	Mon, 27 Oct 2025 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580108;
	bh=Rbg/xIApRH61xx9kD8T7usjjJ2WobHBt0lmoRUT3BG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYr5iALWp6cZRKsCM+cy+Lppy7nVWQSH8eJNlhEcGAwBBD/KV2ZTe0Is//6C5GrpD
	 5ms7smEsQJMo1eeAqMhafdDzBU0E0osffXmgS3x/OFne7wR4yYvJBibL/au1XHrJgz
	 Z1OF0kJwPo15yurUa5SD285iT0aoBEyAYjZgA3HfDNvsiYhKnwF9cgrG5CHoPbkbWX
	 g1ywsukFz9K0qvV/Qg3CKPICHDVJP6A8g0ABrsobn1rIdqq0OndyeOZaGMn4pO6vg3
	 5uHs8nyMza5q8xU39GYSOGnmD9d3JF5eMOIy09QZ0Q4TAwPQBOHvQeojlTnfDcCCgA
	 6u3iWpI3FqDTg==
Date: Mon, 27 Oct 2025 15:48:25 +0000
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH RFC ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <aP-USZf42BUtQcgV@horms.kernel.org>
References: <aPhzm0lzMXGSpf22@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPhzm0lzMXGSpf22@secunet.com>

On Wed, Oct 22, 2025 at 08:03:07AM +0200, Steffen Klassert wrote:
> This patch merges common code of esp4.c and esp6.c into
> xfrm_esp.c. This almost halves the size of the ESP
> implementation for the prize of three indirect calls

nit: prize -> price

> on UDP/TCP encapsulation. No functional changes.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Tested-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  include/net/esp.h       |    6 +
>  include/net/xfrm.h      |    4 +
>  net/ipv4/esp4.c         | 1067 ++------------------------------------
>  net/ipv6/esp6.c         | 1093 +++------------------------------------
>  net/ipv6/esp6_offload.c |    6 +-
>  net/xfrm/Makefile       |    1 +
>  net/xfrm/xfrm_esp.c     | 1025 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 1156 insertions(+), 2046 deletions(-)

Less is more :)

...

> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c

...

> +static int esp6_input_encap(struct sk_buff *skb, struct xfrm_state *x)
>  {
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +	int offset = skb_network_offset(skb) + sizeof(*ip6h);
> +	int hdr_len = skb_network_header_len(skb);

nit: hrd_len is set here and incremented below,
     but otherwise unused in this function.

...

