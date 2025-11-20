Return-Path: <netdev+bounces-240378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7361C73FC4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 936094E1E15
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9432F751;
	Thu, 20 Nov 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGT/MsQV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607613346A6
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642161; cv=none; b=DnOAzE1OWWeLsi1ANr6mqAe3LIzj698p7J+aTiQzTmJHC5ZRHQjPZduRdCkbz89Y8lYPMgen6vrTDji/A3NLa++yEdYXsly+qVsJPUj7py1NPXO+2ScKxR9qDQSUDyFaKSj7pUQNenGGUzvr5gfvvZUomqE2SnxpA02DPnEqdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642161; c=relaxed/simple;
	bh=J9EV7Xxw/VbEhKHYHTWdk/F5UkI7z5YvYQvVOBmey7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aINPriRyKn5z2SUBae1OPvFppTqnxobd1R/FxK9pkpMaJAv6nUKJLq4PQ6FmxqinAFzfuppGhKjfwwU7zwp/U4KpIfZft09knNmpNVUch1S09ccPIph+Qrq10gn9VBseYfnoJji9FOBjc2l0ciMoVSxPiXzM37V7kyTpgCPVaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGT/MsQV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso516978f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763642157; x=1764246957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIesttVogaz8x2+sOJDvGgQICG7Pgv0ixf6Ikm0KQe4=;
        b=DGT/MsQVTh8YLd5dnKb6B6nkPm2n1l2llSm19s8OUDdTRh9ndl+zgzPBpgMEoJmVar
         Vid+zBRtrrkZbDd6y2egxBf18IV3NwWYjNFCTFmka87mrtC0YGSyGrd/zYDFsoKoioZn
         4hkwrPKxPnMbG1JxMnXzwEtijRqWzVUiwOQxDt4awv98hbuG5KAHaG7PfeoEJkXB6JyB
         ynbUmEABkNc7o2lPR7rX72Dceg/0vcDg8IISVjDdPnDS1iENiTHy6ZnTdX0mLkgMOyKc
         5dDN2QsWsG0WUiv/Q1taAr5kHls4FNjwtxeTOHl7gRGzeH+rselkU4zbtZMBYmBhDumz
         3Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642157; x=1764246957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIesttVogaz8x2+sOJDvGgQICG7Pgv0ixf6Ikm0KQe4=;
        b=W5LRBQ2IAE4rXuSpzFeF0133d9HJscT5tsBbfWNFy1FCTPjHFYIJgGExaO5VPF6/N9
         Iy0th9vje8r5kT6946HUNy+J3EXbSnrCEMc0RaZpyybln/V7f1tK0bITS1SBMEP8T1DP
         IJSTt+dYaidXqTyCibl8uXAPzMNxCEL30tGHEYgBJ/dEm6WyHCi6yqH2vTjp7JWLaurJ
         wVgrniRGg8QkZtrgROnar2VTy4/hZ5/iwI+v2TsMZT5C5ENRjDZ/EXyn/I/pbVqtuVbi
         20Aq+ScIsRZ3mhu8yXPtsQuux3KWOEaJXhy6fdoruzf2TbVk7T8VwWELRp+QwCQ9bvIY
         DJyw==
X-Forwarded-Encrypted: i=1; AJvYcCWfSpyTseSMCLJHe6EkV4TieXYCug8MCeqJzWGqysanGvJEfZw2Fcjc8RA+QLzvPvAKFMS+hcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pBGfPVOBI4Ms28GuuXvsx8lZtn25Ad9SdUeTS3J8lJrcAqcy
	cvE8I2m5aS6IaxDE5o7tvTEpuH7Aee9RohXtpBczUxNk4CdyfB2tl7gjV9ojzxqa2Hw29+2tkAT
	3eU+q
X-Gm-Gg: ASbGnctKjnYeooawOpQjAH0STD/HRSnH3AdmI98wIVzcpFuZXtjVurtl+9H3vCeZloQ
	fPMlVh5+TTUMX2in5eTmOKS7bmPcFumR+kipBQ9fTs/BnD2GF3b970o9KEecTW2dlGf6px1TlVZ
	PWjZa91Qwnk5fsKVdTcFwoqptIQP8g6vtnDZ4Y3yfFPyUp4cPWi64bSqaABzZZQYJJX8ZILgsyQ
	QPBoKTqdo27tPxC7d5UytN1dyldfeSFvFaQ/oSFGoknip8CJpoBmKeEQWVTKBh2d1GPAf8cUoKS
	w59zy2X48VmVz3Yn7MsGyBOZiEw0izKupU0DGS4e57tItOfDXv2P+3Rj+8RayVDs1nbQCTqZlq2
	YADZK1H5qrhMsYBy+ssdx1k50N9gN1LIZQCuv2i4iNV9wppm0zrVNzww3dORS2fZaY1I5aWE9P1
	wbPS8yG6ogNqC+KPcv
X-Google-Smtp-Source: AGHT+IGNp7rEHtYkMZo1Trw4dKGb7tZvEVuOkYawJpOVXMcIIDqGp6C+J6qKQ9JH2a4Ap1Qmx85pBA==
X-Received: by 2002:a05:6000:1863:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42cb99f595dmr2430442f8f.23.1763642157388;
        Thu, 20 Nov 2025 04:35:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7f363c0sm5091044f8f.18.2025.11.20.04.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:35:57 -0800 (PST)
Date: Thu, 20 Nov 2025 15:35:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [bug report] devlink: Move devlink dev reload code to dev
Message-ID: <aR8LKLebnQFnEDU6@stanley.mountain>
References: <aR2GHqHTWg0-fblr@stanley.mountain>
 <35ekvmjyb4ty5vdkyspwirz4qoahotpow22zt4vkonqjmtqziz@yk6pwla34ayn>
 <aR4JWMyC7QHITJZp@stanley.mountain>
 <itvidojyoklvtzlrnsufxwwrnpk3rxnhkhz4tygsgc2qrxyfva@ykpysuejrqpu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <itvidojyoklvtzlrnsufxwwrnpk3rxnhkhz4tygsgc2qrxyfva@ykpysuejrqpu>

On Thu, Nov 20, 2025 at 01:10:39PM +0100, Jiri Pirko wrote:
> Wed, Nov 19, 2025 at 07:15:52PM +0100, dan.carpenter@linaro.org wrote:
> >On Wed, Nov 19, 2025 at 06:19:18PM +0100, Jiri Pirko wrote:
> >> Wed, Nov 19, 2025 at 09:55:58AM +0100, dan.carpenter@linaro.org wrote:
> >> >Hello Moshe Shemesh,
> >> >
> >> >Commit c6ed7d6ef929 ("devlink: Move devlink dev reload code to dev")
> >> >from Feb 2, 2023 (linux-next), leads to the following Smatch static
> >> >checker warning:
> >> >
> >> >	net/devlink/dev.c:408 devlink_netns_get()
> >> >	error: potential NULL/IS_ERR bug 'net'
> >> >
> >> >net/devlink/dev.c
> >> >    378 static struct net *devlink_netns_get(struct sk_buff *skb,
> >> >    379                                      struct genl_info *info)
> >> >    380 {
> >> >    381         struct nlattr *netns_pid_attr = info->attrs[DEVLINK_ATTR_NETNS_PID];
> >> >    382         struct nlattr *netns_fd_attr = info->attrs[DEVLINK_ATTR_NETNS_FD];
> >> >    383         struct nlattr *netns_id_attr = info->attrs[DEVLINK_ATTR_NETNS_ID];
> >> >    384         struct net *net;
> >> >    385 
> >> >    386         if (!!netns_pid_attr + !!netns_fd_attr + !!netns_id_attr > 1) {
> >> >    387                 NL_SET_ERR_MSG(info->extack, "multiple netns identifying attributes specified");
> >> >    388                 return ERR_PTR(-EINVAL);
> >> >    389         }
> >> >    390 
> >> >    391         if (netns_pid_attr) {
> >> >    392                 net = get_net_ns_by_pid(nla_get_u32(netns_pid_attr));
> >> >
> >> >Smatch thinks that the "net = get_net(nsproxy->net_ns);" could mean that
> >> >get_net_ns_by_pid() returns NULL.  I don't know if that's correct or not.
> >> >If someone could tell me, then it's easy for me to add a line
> >> >"get_net_ns_by_pid 0" to the smatch_data/db/kernel.delete.return_states
> >> >file but I'd prefer to be sure before I do that...
> >> 
> >> I don't see how get_net() can return NULL.
> >> 
> >
> >It returns whatever you pass to it.  The ns_ref_inc() macro
> >has a NULL check built in so it accepts NULL pointers.
> 
> Of course, I don't see how NULL can be passed to in in the current code.
> 

Fair enough...  This is a complicated thing to track with static analysis
because create_new_namespaces() has a bit of recursion as far a Smatch is
concerned.

	new_nsp->net_ns = copy_net_ns(flags, user_ns, tsk->nsproxy->net_ns);

It's copying the old tsk->nsproxy->net_ns to new_nsp->net_ns and Smatch
says if the old one is NULL then the new one could be NULL too.  It's
just a bit complicated is all.

Anyway, it's a oneliner fix in Smatch.

regards,
dan carpenter


