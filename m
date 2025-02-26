Return-Path: <netdev+bounces-169895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EAA46498
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A951F3B5B32
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E7229B32;
	Wed, 26 Feb 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lunz+Z8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D243229B17
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583548; cv=none; b=k8AAsclJq2VwWGK2ol1MNWRuE8oA4IWioH6ClJ9bd0TYQEQlrxEiu64GHC978BVCDtQhGlUaVNZ//heXHILSHGURR9XspHLbUce/bV9J8/3W7YpCwi4NZMs8RdwL/f+OwNHG+3O6LCVVEJ8Jy7TG3+bB1iaT7UTNDINjW/TkDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583548; c=relaxed/simple;
	bh=7Jty2k2VPmJIiAMCrg8borokEqk8ISqVGkWDU1cB4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHzJsSdVpda77E8+JIuP7Mh3LqDCFqYVIjSO352q1D4qvzJDWvzJ8BuiRvQTm6MU6Lt31X101i15xyYp0kytIjhn/KL+W+ogXI+OYCx8x+SeQFME4wIkMVTV8wxAMpHGM2BjJgwr9xSmisRKzeLMtNxOJnt8GsTKWXrYiuLQNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lunz+Z8C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so12278998a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740583544; x=1741188344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cCFCorbQ79EPV2pbT8nLnau3UHQm0d9DNeVh1UKL6E=;
        b=lunz+Z8Cvfb+XVlyXGhbyeHtUA9drYVFEA9zMTLZSVo4L4/HgAnBJnqVwFGoEBE09z
         9YKXgCrhX8C91JcJu468SQSjTM5QnF+9PGc2Exp06fqTe84ylfF5UnQA92WKaC57nL50
         jOAv01Mgr7OmimDEfSp2/FGIc5cjR4maUiTy+6bauOtYcZhpy2IJ6WkdQPWAGXtGq5sK
         iMo6nrhCPv61Halv/VRGAvVaQiRKc8UHDVbnDT0ssb+N5oP9Q5LmbkV22orNfxQtUk6u
         V7ojfJMKYcUMJOpkRurDvhUm+J0Eeiy73wxNiiZcEVtzn78RLmXz1V837LpU5yuBzWDE
         KM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583544; x=1741188344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cCFCorbQ79EPV2pbT8nLnau3UHQm0d9DNeVh1UKL6E=;
        b=s/BNQy9cbELwrElHr+A6AyC9gT6Q/9ftigVcwz9cpsdPdBtqCIa/ijVVNIs2NE0SbA
         n+O5lW0Q3EZcWmAgdidvA87hXNo6qhXpw3fm7ReUUgP0f58C4XYji+jxPjzB0ip8Lzbf
         rebp4gDi/3NmRsV/d7Fos7hkFajY9pBfzPOwni/bkz7wE5AL6OgXIn3FkH0qTgAiWZV7
         TorNSOx9r/bNg14FwxLbaILct/bvUoyHxh69kqiMDLF4e40ljmirM3iz3pLKd/uHLu6t
         o9gLAhcS0g8uCoUXr9pdhcnpxtbQ2FM+v5Jn7CT/wmu7tlTExD1bbPyKaUDMakvD0q3g
         dJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVDO4AblVW+A2KLDIHInLrJxLtplDttOaLDmSXdC/rUJkm3GSSkX44XoUvcFl3+AqFK1cD7wsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBZHgZiNS2+okfBgaqlh5wMQ2cAeKKEgHyrk6PmApGTU1bV5p
	Hjx1e8I8oH70CMAsAEnK5u5WGRhAwNfc48cH3uYLGAhQPqRfQVIctY4IwpJlU+w=
X-Gm-Gg: ASbGncvnkknrRB0B6JBs/wta5Kh4VhvTEAGlckmnQCfPoRNgNUm2tl1bPS4crigFdOt
	Mne5LgAnpeH1F9C2Zi8+UA2rOM+nup+mPCsVEq4lyezipf6aJvyEiVwz3GiIQJJK3j9U3N3UX6a
	vcfw71o+zbB71soX3mHpPIx73mcW7NVS/e0zMIUZpJgO+71V4X8U2YGP93HorTGBXC4isqa5HZM
	i7B5LoLDIWcfgCWVR6h/ddU+Bc8vkyOsJP/CRp1u9LOiHaeH+vVOqcN09QGtqxCZPpJEqXfBjkI
	slAnEWxGCq9rDkAgaU3rMnXxACrctpDL5oGEuktjpfmwbVo0/rhCBg==
X-Google-Smtp-Source: AGHT+IEAB0uZUjm/Wdvyv3vHgJUK+04TyiWeXLkLcV/pvCw1WVdLP+IcTgUanL5Fn+YUOt+NzbtPZQ==
X-Received: by 2002:a05:6402:348d:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5e0b70f8732mr22414421a12.12.1740583544488;
        Wed, 26 Feb 2025 07:25:44 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e461f3e84bsm2970646a12.76.2025.02.26.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:25:44 -0800 (PST)
Date: Wed, 26 Feb 2025 16:25:41 +0100
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
Message-ID: <rar5z5jtct4qbucpcr6i73zecl5mz2otdqq6uc5ygaukxzi4jb@4rugso6dgobh>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
 <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>
 <zzyls3te4he2l5spf4wzfb53imuoemopwl774dzq5t5s22sg7l@37fk7fvgvnrr>
 <e027f9e5-ff3a-4bc1-8297-9400a4ff62a6@intel.com>
 <iiemy2zwko4iehuw6cgbipszcxonanjpumxzv4nbdvgvdgi5fx@jz3hkez3lygw>
 <31477321-c064-4f3d-b4c9-e858d98d5694@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31477321-c064-4f3d-b4c9-e858d98d5694@intel.com>

Wed, Feb 26, 2025 at 04:06:19PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/26/25 15:48, Jiri Pirko wrote:
>> Tue, Feb 25, 2025 at 04:40:49PM +0100, przemyslaw.kitszel@intel.com wrote:
>> > On 2/25/25 15:35, Jiri Pirko wrote:
>> > > Tue, Feb 25, 2025 at 12:30:49PM +0100, przemyslaw.kitszel@intel.com wrote:
>> 
>> [...]
>> 
>> > > > output, for all PFs and VFs on given device:
>> > > > 
>> > > > pci/0000:af:00:
>> > > >    name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
>> > > >      resources:
>> > > >        name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1
>> > > >        name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1
>> > > > 
>> > > > What is contributing to the hardness, this is not just one for all ice
>> > > > PFs, but one per device, which we distinguish via pci BDF.
>> > > 
>> > > How?
>> > 
>> > code is in ice_adapter_index()
>> 
>> If you pass 2 pfs of the same device to a VM with random BDF, you get 2
>> ice_adapters, correct?
>
>Right now, yes

That is a bug.

>
>> 
>> [...]
>
>What I want is to keep two ice_adapters for two actual devices (SDNs)

