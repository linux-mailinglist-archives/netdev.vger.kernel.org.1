Return-Path: <netdev+bounces-169486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5122A442E4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F647AAD37
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB826D5C7;
	Tue, 25 Feb 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ECHhAzrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8026BDB9
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494118; cv=none; b=MNQdEUyoKtqS+uX2SwORArZEk11oYnN6EC1WF4KhDgaFn87Qh4ZVDoyP2AO+WyeqVoBxgJrK8sdvrDJDGUyrpMB4vPXjGccbPaVeTO2mVeDS/jQSWodeP1/Y8OoRkJIrqWTf9lug1hA/65QIKtJ7cxfVBjyfr7ahsTQAp1M/HYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494118; c=relaxed/simple;
	bh=4LXH6hHiM+bwKdfiEgtyzEEXo5T8p09+JZBv4iD47CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClbrMKNGL1gRQdXxF5rofzm2LqiM7pAiyY6l8CH3s8TslrhCNZNR4BMxd5GOIO4lPiXEXdcjDjzcziit7lqd5Kpbx+4bQ5qt82te2A75AIjlqT3r7uUwDJh2mLCCGwWGoZxSn8IRbKqxsk+qfANJlVlIa8Ejc19i5L7QaTzvUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ECHhAzrl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43989226283so39022865e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740494114; x=1741098914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qdy8pR/Dcc2nulb9kFWPIH5MwfoS+sb5ucheWbrsmU=;
        b=ECHhAzrleb01XcJnRDBeN8GcUhgnsy9v3pytzFdEgh+vv64qhINtgu6aKfT7tGqvDV
         Td/FhvvSBVJ4/ssx5lrShJoCsNepZ0oTqPrWiCPh2tOVTrPMRmrIyoiQKGWndYNAPL9o
         WdMsBbzWVXbbfX8d09sHQ5HRLuDy8uJ8YZ3zYGk3ehswHx2ZrWX+Olt098aP3Npljfwe
         izYGOxbAudnlAoPOmSXB4LOa9x4CKnc9Dm9fplizU3DdnVmyqLSWRqzfLRgpVPZUkhL4
         k5qrGdYdlwrg1iX9sbXkNhGbSkvqxNvKKodvmFyf60DFlrZKJ9RIQiinV6uFxKsbfLER
         iWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494114; x=1741098914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qdy8pR/Dcc2nulb9kFWPIH5MwfoS+sb5ucheWbrsmU=;
        b=CQurt6p7tK4PSAOmCMQ41Gmdc1k1opwymd8p9lsRcUhSpcT2iQeFLWmGK7Z6hRgDW4
         dgf5FMJWPGaltmt3n9MRY2gyqH0XYn7mDmN29voUnRRcdf1M8C7klPU/S4Pwg0CuD10h
         tu2pbYk5TrB6MMnijT++yw8Jn/NAEtnL2wOWvP+KahK1LT4614EJN8kjW4DoKqogtWmV
         ORRwhQOkS6Rwcxvc7ZPHqBH6MX3beEDRnQAHrunclb/ro5qSDVrIX9pE6PlTMMqoUf1f
         TnEFgmsZUGohImVsj2OMLhJDsxpyOrszlVwNDbl1a4wWtTdbnm5+/4cClHUXEOryNCvy
         hemg==
X-Forwarded-Encrypted: i=1; AJvYcCXtkwXTTtbG5NUeUgZO967H8VAXX8Z3FYXWu4K7Ij404jRjX6mNyITUqJpLC3oAtoAQjyUFwiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkE5cnbDnVd5FSlIPeBH2pMFI9ZliH8ksCgXx717sNOErGIKQT
	Xla61AbTGNAhNktyQHzgPWRN7vw6PZanCngtPHPFCsF8qYias4GOdNrRgDM5zcw=
X-Gm-Gg: ASbGnctrfc/r5+W0qJ8ALsSm7STGihkfhHa/6VOdw0XIuI26SmUbOts+Obm9c/Iczt3
	JiLT55zIoEqlXbDFNjBVlVyzQYsjqWi1+jJ/+wqI1/7SlUxEoRHFghSWMTc3/VAyJSh2p6vs/m9
	UUT3FW+7nJPtKmjrY6TaeaxSZWiQvHtN7BW/W++lNJIXn5MsjBg5XGPiyrpQCmRCKLkbYnHL8YO
	N8Lvlx/A388tLlT6DD01s5tI6dcAR4k6S7aGOXz25c1DjtcKblVYnPBDcc1ETndSaWbOeWy4/qK
	ZytbBw6rR8YNFc+KCAVL0KMnQV1VSN8ABGQkVFx0CaSs/8q664D3OA==
X-Google-Smtp-Source: AGHT+IFbUcoHiBtSwH/dRFa+OIyHDCaNUFaFSzscYqKv5SpUEUS4+iybkDZXSOreAsEymh00vLC2+Q==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr140180855e9.29.1740494113674;
        Tue, 25 Feb 2025 06:35:13 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2483645f8f.22.2025.02.25.06.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:35:13 -0800 (PST)
Date: Tue, 25 Feb 2025 15:35:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Message-ID: <zzyls3te4he2l5spf4wzfb53imuoemopwl774dzq5t5s22sg7l@37fk7fvgvnrr>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
 <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>

Tue, Feb 25, 2025 at 12:30:49PM +0100, przemyslaw.kitszel@intel.com wrote:
>
>> > Thanks to Wojciech Drewek for very nice naming of the devlink instance:
>> > PF0:		pci/0000:00:18.0
>> > whole-dev:	pci/0000:00:18
>> > But I made this a param for now (driver is free to pass just "whole-dev").
>> > 
>> > $ devlink dev # (Interesting part of output only)
>> > pci/0000:af:00:
>> >   nested_devlink:
>> >     pci/0000:af:00.0
>> >     pci/0000:af:00.1
>> >     pci/0000:af:00.2
>> >     pci/0000:af:00.3
>> >     pci/0000:af:00.4
>> >     pci/0000:af:00.5
>> >     pci/0000:af:00.6
>> >     pci/0000:af:00.7
>> 
>> 
>> In general, I like this approach. In fact, I have quite similar
>> patch/set in my sandbox git.
>> 
>> The problem I didn't figure out how to handle, was a backing entity
>> for the parent devlink.
>> 
>> You use part of PCI BDF, which is obviously wrong:
>> 1) bus_name/dev_name the user expects to be the backing device bus and
>>     address on it (pci/usb/i2c). With using part of BDF, you break this
>>     assumption.
>> 2) 2 PFs can have totally different BDF (in VM for example). Then your
>>     approach is broken.
>
>To make the hard part of it easy, I like to have the name to be provided
>by what the PF/driver has available (whichever will be the first of
>given device PFs), as of now, we resolve this issue (and provide ~what
>your devlink_shared does) via ice_adapter.

I don't understand. Can you provide some examples please?


>
>Making it a devlink instance gives user an easy way to see the whole
>picture of all resources handled as "shared per device", my current
>output, for all PFs and VFs on given device:
>
>pci/0000:af:00:
>  name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
>    resources:
>      name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1
>      name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1
>
>What is contributing to the hardness, this is not just one for all ice
>PFs, but one per device, which we distinguish via pci BDF.

How?


>
>> 
>> I was thinking about having an auxiliary device created for the parent,
>> but auxiliary assumes it is child. The is upside-down.
>> 
>> I was thinking about having some sort of made-up per-driver bus, like
>> "ice" of "mlx5" with some thing like DSN that would act as a "dev_name".
>> I have a patch that introduces:
>> 
>> struct devlink_shared_inst;
>> 
>> struct devlink *devlink_shared_alloc(const struct devlink_ops *ops,
>>                                       size_t priv_size, struct net *net,
>>                                       struct module *module, u64 per_module_id,
>>                                       void *inst_priv,
>>                                       struct devlink_shared_inst **p_inst);
>> void devlink_shared_free(struct devlink *devlink,
>>                          struct devlink_shared_inst *inst);
>> 
>> I took a stab at it here:
>> https://github.com/jpirko/linux_mlxsw/commits/wip_dl_pfs_parent/
>> The work is not finished.
>> 
>> 
>> Also, I was thinking about having some made-up bus, like "pci_ids",
>> where instead of BDFs as addresses, there would be DSN for example.
>> 
>> None of these 3 is nice.
>
>how one would invent/infer/allocate the DSN?

Driver knows DSN, it can obtain from pci layer.


>
>faux_bus mentioned by Jake would be about the same level of "fakeness"
>as simply allocating a new instance of devlink by the first PF, IMO :)

Hmm, briefly looking at faux, this looks like fills the gap I missed in
auxdev. Will try to use it in my patchset.

Thanks!



