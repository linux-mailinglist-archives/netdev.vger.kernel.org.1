Return-Path: <netdev+bounces-240107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A678CC70A23
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71244358604
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1736B05A;
	Wed, 19 Nov 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vsa4YKJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6F2FABF5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576168; cv=none; b=QuzlAGRwO6ofIQNIkGgbTxK0NTC0rXophAwDsW5yrRibaojCH6nXcymOtR+nHf8rZfFx5lR5yn8jEvvUDvQvIFYEgoo/RJC1grHD7Y0AuEAGpw7MvPY/UPQRdEY+edOD3gu+6Gz4X733KB8MY99gv2otmpeoQCgCxvNGTCZsiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576168; c=relaxed/simple;
	bh=RKvWZkLINNbTzkE6eJpjEs5aqbtxKc/vZ2Uu2jxwFHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdqlUk0IB04s4ZTrgs53ZUt14WlS5yWkT/nsSky+q8bqoPJ+DZJHwwUeYiKMng5L2Y/ki34m4oQGkawI8+GGkS3vxEeHdsPVjQ2Nf9hUPXxcVyknhY9wLVe9Z0kNVkMhcTsnuril4Sykexnt77vmYVT8Y7/fkGIgHwAJiCDLF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vsa4YKJt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so651625e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763576156; x=1764180956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wc1BSEoIWw4ANtTyWzBO7SGYwVfIN8l/WWDpFYAxfoQ=;
        b=Vsa4YKJtLC7Z12qCQrty9v3azOsgWXnLv7ORfZlHFVxf35+cww8KIqofgovGBBlBGF
         gEldmrpRckupff74+P4+enkznhBPre1Qw0bd3Kr267L6MJO+UhsAcqIVpobzTlEypnxK
         RGLaCEFYX09+92PC8NX5b3iz/w/f7TOO4UFbI+bKV9UA1vbtqY3vPb005CJMBxQeW19i
         K1npbiNUC5SRK3UEGCKHpsNOFkpTE2XWynSODHVFWzXCJRitmFRBxytAryNq0cbcImMg
         6LjP2dz7/FArjdORW7BPcFE/A0sGhNxruA3VPvUDjdS3i+p95X4gXjOiEnDsjjJU+Bly
         7UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576156; x=1764180956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc1BSEoIWw4ANtTyWzBO7SGYwVfIN8l/WWDpFYAxfoQ=;
        b=GW0QHJoui/7H22eUYMseV40ZvaLoMJdxzLcAKXWcl1S2hlEjXDsNwGQytjkXVUtL8x
         +Zaa9vLgDUpC+YQytC2z00jNJG5SJHCTr3tkk7gzKHrAEUV2HEJvQO6u2DJ38XFQ8B5r
         MaagLw/H5YTZCn4CTjPiW5KAQL+w+RsdhFGI/aHEZfeCJZhPCoxoPjclDF5vFe7worh2
         eY/xWjs+3u4veIRsD+5G/MsPwjTHHxloJkbFB9WJxLERx4EOMCbsMYxITGLy3slW+E2g
         fpGUF0wHoQilz+sDPPTa/b+oT3nYySn9QclzQmx1quun48r+Mwd7EXlQOYwXGj4AwVe1
         ig0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUI/doN3/cQjUCYNYQdX1Ggp9asEOlOv68q8w3rO6VtjJpdA/6tOTbwJUnDMLD3lY7kNkPTsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDMCTdErejeHRY0JUhIre2wnNzsleXdtsEZSGcqiE0lsr5x32
	l16DI/SjuQIQ0Pfjs2ztVTONWR7bhpmamqVez0gPlhkVJkuapXHEQzXZfOAG+ceq/TwYNQDtNxJ
	3d2mF
X-Gm-Gg: ASbGncu1lk7tSgwmfr4mCqjtNfeo7oy8EqkIhMhvNWECBxQ7Kl2ZJOkk2WbE4Xq6/hL
	eDdU+fWx3q+1YBys4RUGwnlWcUsEwVILBKEOjCn1wLKcupQF4jgYXtZAaa5fA5FNTTT6/Xr/eJI
	mSS649BzdVmRakrNaIQ7kUJ2fURN5T1uYAmtjHdnW6zKJZsSVdymZ/OViTfrQelsw6lu21zvd/K
	PETg0W756N9lnYT5JdFrgmamrE7qFFMDOztm1iZTP7buILl1wgYEfRD3PIUUoPYhjnu2ElieU+h
	28Yyo+2t0tujCXNFvkdF6tO8NGdwjx2ptqRp+kNL6KjTosG2lU+2M483rtUTwYSgmlNj396jH5x
	vq4FCBBoJvNzA+2zogJO5+VC0zBTbEyh7yFs1lhqkGf0nJbfzv34HfJqhVqZOIrmsQCwxXGHa9d
	SSAMEN1VzlzLiLLZq2
X-Google-Smtp-Source: AGHT+IEQc5KExnU9qglIf5Gu1CMbp7GmZEQIS59yeDd169evEeC5tGsfaEUi4DbJdLGQSWAUODcE6w==
X-Received: by 2002:a05:600c:1d05:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-477b8a518f4mr1503685e9.6.1763576156023;
        Wed, 19 Nov 2025 10:15:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477b831b6a6sm2981535e9.14.2025.11.19.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:15:55 -0800 (PST)
Date: Wed, 19 Nov 2025 21:15:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [bug report] devlink: Move devlink dev reload code to dev
Message-ID: <aR4JWMyC7QHITJZp@stanley.mountain>
References: <aR2GHqHTWg0-fblr@stanley.mountain>
 <35ekvmjyb4ty5vdkyspwirz4qoahotpow22zt4vkonqjmtqziz@yk6pwla34ayn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ekvmjyb4ty5vdkyspwirz4qoahotpow22zt4vkonqjmtqziz@yk6pwla34ayn>

On Wed, Nov 19, 2025 at 06:19:18PM +0100, Jiri Pirko wrote:
> Wed, Nov 19, 2025 at 09:55:58AM +0100, dan.carpenter@linaro.org wrote:
> >Hello Moshe Shemesh,
> >
> >Commit c6ed7d6ef929 ("devlink: Move devlink dev reload code to dev")
> >from Feb 2, 2023 (linux-next), leads to the following Smatch static
> >checker warning:
> >
> >	net/devlink/dev.c:408 devlink_netns_get()
> >	error: potential NULL/IS_ERR bug 'net'
> >
> >net/devlink/dev.c
> >    378 static struct net *devlink_netns_get(struct sk_buff *skb,
> >    379                                      struct genl_info *info)
> >    380 {
> >    381         struct nlattr *netns_pid_attr = info->attrs[DEVLINK_ATTR_NETNS_PID];
> >    382         struct nlattr *netns_fd_attr = info->attrs[DEVLINK_ATTR_NETNS_FD];
> >    383         struct nlattr *netns_id_attr = info->attrs[DEVLINK_ATTR_NETNS_ID];
> >    384         struct net *net;
> >    385 
> >    386         if (!!netns_pid_attr + !!netns_fd_attr + !!netns_id_attr > 1) {
> >    387                 NL_SET_ERR_MSG(info->extack, "multiple netns identifying attributes specified");
> >    388                 return ERR_PTR(-EINVAL);
> >    389         }
> >    390 
> >    391         if (netns_pid_attr) {
> >    392                 net = get_net_ns_by_pid(nla_get_u32(netns_pid_attr));
> >
> >Smatch thinks that the "net = get_net(nsproxy->net_ns);" could mean that
> >get_net_ns_by_pid() returns NULL.  I don't know if that's correct or not.
> >If someone could tell me, then it's easy for me to add a line
> >"get_net_ns_by_pid 0" to the smatch_data/db/kernel.delete.return_states
> >file but I'd prefer to be sure before I do that...
> 
> I don't see how get_net() can return NULL.
> 

It returns whatever you pass to it.  The ns_ref_inc() macro
has a NULL check built in so it accepts NULL pointers.

regards,
dan carpenter


