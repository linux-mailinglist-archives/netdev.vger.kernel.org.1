Return-Path: <netdev+bounces-114924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF0944B0B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938FA1F20D47
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54953172BD5;
	Thu,  1 Aug 2024 12:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABF49641
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514400; cv=none; b=oC/sA5PQe2ox9UZ1LpznjIUvmP+ttCQi8h7oMFovyduEMyPtlm2JNyKQ0+XvmXlxebNeuvqKTVMkLIUJ3iCt6iTbIRB07U0v9bvYOeCsSgJ0KeC8GSs0qrvJJRbYT5emHBHAvDWMO7N8B5jfz/VcNJHzYWEEZyF6SwMzPNAfLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514400; c=relaxed/simple;
	bh=O8N+Zda9aWqgCfLdcELACsfdjnC5t/TgFd9q7n5G3bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL+WS7GGpggGEdiFwPqa5luN8pC5TgBDQxmCmX87IR3kK3m/rdE2ZLKVYzw1l9Q7975ESqhSGKFAGPBo23gfIL7AnNq4njqZg3BJKCVqG793l2eGa+wu/4wHw/ZHmCD1AfnxlEi2z3iZE4XEaXIpTOnz+wkydGA9lGjAFmJph3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sZUgA-00088d-Se; Thu, 01 Aug 2024 14:13:10 +0200
Date: Thu, 1 Aug 2024 14:13:10 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v7 07/16] xfrm: iptfs: add new iptfs xfrm mode
 impl
Message-ID: <20240801121310.GA10274@breakpoint.cc>
References: <20240801080314.169715-1-chopps@chopps.org>
 <20240801080314.169715-8-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801080314.169715-8-chopps@chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps <chopps@chopps.org> wrote:
> +static int __iptfs_init_state(struct xfrm_state *x,
> +			      struct xfrm_iptfs_data *xtfs)
> +{
> +	/* Modify type (esp) adjustment values */
> +
> +	if (x->props.family == AF_INET)
> +		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
> +	else if (x->props.family == AF_INET6)
> +		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
> +	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
> +
> +	/* Always have a module reference if x->mode_data is set */
> +	if (!try_module_get(x->mode_cbs->owner))
> +		return -EINVAL;

If the comment means that we already have a module owner ref taken
before this try_module_get, then this should use __module_get and
a mention where the first ref was taken.

If not, then this needs an explanation as to what prevents another cpu to
rmmod the owning module between the lookup in xfrm_init_state and the
module reference in __iptfs_init_state.

cpu0					cpu1
 xfrm_init_state
   -> xfrm_get_mode_cbs                 rmmod
     -> __iptfs_init_state		  xfrm_iptfs_fini
       <interrupt>                         xfrm_unregister_mode_cbs
                                            release memory
       <resume>
	try_module_get -> UaF

