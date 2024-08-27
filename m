Return-Path: <netdev+bounces-122481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468659617AE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FBB1F2655A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452911D362C;
	Tue, 27 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8DRmV6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AA1D2F5C
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785550; cv=none; b=sNsQWLi08r100Coj4Sgyk7xHEmlVVZ07dHxTfxSry9AgqjZSXWzhlwR3w3WL6Aawsq+1zEEWKta63Z3wI4e+bvY8TgqbhfF8sA/G+7Naw0GH3vOYyYdaXkYwRyRIZTNgujB3MrkVkydmNjX+mvEAc4BSG/o5KE4Rj+JCiJKYXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785550; c=relaxed/simple;
	bh=g2qfOyzD7mj2ctfLhV+IRVqjYo+8o4pLyGoAVHj2xpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB0eVZVpM7hyzTNavK7Pz8M2goH24ARyhUrQOd0t68fnO9Ts4CAF/uDYQKGHYOshLfS8NOSh2T3o5mo7KmLicoKUgFKNg8ZwIGXO9t6xBMTMLsHsFVhrIXo4UIc9qh3JFlCkdYe1cEjgZckLIHHITub3QnjIa5hglAcent8bV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8DRmV6k; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8223685fbe9so318671639f.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724785547; x=1725390347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=m8DRmV6kaV1LHryNqCjrFMqRFIqAEjBnmdg7YxEaaSJL6COGd7idy6QlK8B5XOMnZ+
         +JHVI9G8Hx+/5XfWjo+kcF44wcjk8694+405egBeivCPcBCsriCbbyqv5oFpTl4p469C
         pkj5I9dDzMSMSV+GE6/f6sFBzSQy+ypfkcJ6H0YayDDrLGi2uxGQRGJiNvDTXRRoWgwa
         Yw8uwpJI2ry0OvWu64xckonkv45AJwI4gayaoOaqSWiZ0kSo84bI5Tb2/UR3qf3W2uAw
         FdAosR/idbDqsnvCgZNVgSHCrrrG7j1RghXNxGf63FD4vD9C6OFY6ypa/WgvmtDHU3w/
         jqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785547; x=1725390347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=o5kyXM0iWqepIgP2lUWOjwz6xP9V17QAWvQZwVbMhuBKwkqhkQhAUd4bmSxY9/Xh7h
         GAIdGTiL5n/CwAkX4E7o10CVfKv2LoSe9CfuxTohX3Nkb7qPSwpXLym5LpSk9gKR5jYr
         beuvxzsgEdLrggicYQYkpPicDUox2PFE12e7EOR4moyE3wegSjYSfcbDlvNlnUMrrzoT
         jv9Z/hhiwyC2oZym9Gx+4rMOsIFz2zuxWu4Hi/Vw84NloEcfHttypcgOm9+OECmofHGO
         V8vEZ1GEbK/KFB9HOmfCJ4iazstDxxJVD+Mx0/BiJ75aDsE0nTMRKQmxTt1oAgQ6wfCl
         d26w==
X-Forwarded-Encrypted: i=1; AJvYcCV9N0Nfm566Fn0DpWAFInmhLrCBVHLdeSFLT/FMj4nSmc4I6Cav4nbbj761aex34ZxuelHmnuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoVaevszK8Cii4ODHDUN83Wr68UM5FHRdZtdApCwXb8nrb9vM
	ckJKBwcHIqgFmSuokMD05KAbc5OEuJaqsDGsDJMZ/NZ0KAHoS7isG/wYC+JZWiE=
X-Google-Smtp-Source: AGHT+IEuujl/9dEsZ4FQ8JuKJxuoRbbHy6rNrvvhcf00pWo8FSAo3yeLetJirxmhnMEDUTEhU7xR4w==
X-Received: by 2002:a05:6602:13c8:b0:824:d752:986 with SMTP id ca18e2360f4ac-82787387f9amr1917557439f.16.1724785546835;
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f20255sm2724543173.3.2024.08.27.12.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Message-ID: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
Date: Tue, 27 Aug 2024 13:05:43 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240827185616.45094-1-pstanner@redhat.com>
 <20240827185616.45094-4-pstanner@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240827185616.45094-4-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 12:56 PM, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's calls to pcim_iounmap_regions() in probe()'s error path and in
> remove() are not necessary. Cleanup can be performed by PCI devres
> automatically.
> 
> Replace pcim_iomap_regions() and pcim_iomap_table().
> 
> Remove the calls to pcim_iounmap_regions().

Looks fine to me - since it depends on other trees, feel free to take it
through those:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


