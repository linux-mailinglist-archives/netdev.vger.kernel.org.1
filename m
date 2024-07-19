Return-Path: <netdev+bounces-112166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4F9373F0
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614CB28172B
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E03C6AC;
	Fri, 19 Jul 2024 06:14:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132E1B86F8
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369665; cv=none; b=Y3Qm61OeH/BC3efQ93kqPr924JTQITI3z21n7ycYlWK9O2015QdLx3fKa4/K+yjA1KInuA2pv46tojWkMGI82dYlKhaOYMLqM6FyDQUJ1/r1sz231eXyhJsNmTmSj9QR+rU20OKpoHjdAPVCpDgGugU7UlQZMZrsBOnxW/XBDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369665; c=relaxed/simple;
	bh=3xv01XgAhVyhOIm1NVv4lZlklJMsmzR8RGkywlV5k8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVPbcOoCknzIroLe0wq31f7o7Rl6e9SdpY06YLyM0K10CAksDhHrwfS65v6jC36swwCl3nyjtXhjAwW8t9LhVG5P0ks7wbxP7yJVSD9v9bbaZdIaSIHge2hE9IpF9otgkT4bdbkZlD4RqbkLstoWthhM1etx9/pxmjA3AO0GFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sUgsg-0007hi-0J; Fri, 19 Jul 2024 08:14:14 +0200
Date: Fri, 19 Jul 2024 08:14:13 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs
 module functionality
Message-ID: <20240719061413.GA29401@breakpoint.cc>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-7-chopps@chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps via Devel <devel@linux-ipsec.org> wrote:
> +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];

Why not
static struct xfrm_mode_cbs *xfrm_mode_cbs_map[XFRM_MODE_MAX];
i.e., why does

> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return -EINVAL;
> +
> +	xfrm_mode_cbs_map[mode] = *mode_cbs;

do a deep copy here rather than
	xfrm_mode_cbs_map[mode] = mode_cbs;

?

> +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
> +		request_module("xfrm-iptfs");
> +	return &xfrm_mode_cbs_map[mode];

Sabrina noticed that this looks weird, and I agree.

This can, afaics, return a partially initialised structure or an
all-zero structure.

request_module() might load the module, it can fail to load the
module, and, most importantly, there is no guarantee that the
module is removed right after.

Is there any locking scheme in place that prevents this from
happening? If so, a comment should be added that explains this.

