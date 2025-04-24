Return-Path: <netdev+bounces-185663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3528A9B459
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BF35A13A3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327A28934E;
	Thu, 24 Apr 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WHj6CB8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EF197A76
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512933; cv=none; b=eXmO3NhVS8tZDUOddiO2ILBp0qadFY5vA7X8y8TRbj+Rz+k65vrgUVQDxtJZtBHNizbwxY0UQY1xtDOKYXtg4tlZakDVMsJOF/Bw2iFEuHTt/k8HWFTtiUgFwz9CWJylsRNuBCHuNRrbh7xbUh+Qa3NMN2yh9zO34CVkbvZJoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512933; c=relaxed/simple;
	bh=JeRt1GjyfAtswwCrV7oqxoxM6m1xqly/Nd6SBN4t56Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIyl1UHYS2L4oohJEngbfPLVuc8NTWclcGY47nU90z2+mtlhBDMJ0znHbIZu1RteQ9XCE6J1ihSLHtra+Jq/DsTs6pt1MBDwUyUVHGreA2W7xYe7juqSf8KRaFEtp6E6V1Gpqd0MAA5XYKLMbMdy0yHGhWuXUUqeG9WVeFM5tQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WHj6CB8b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224341bbc1dso16680195ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745512931; x=1746117731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdeGo1ClxSoX72okoFEyRfcK08keDtWUfesWE0Wuy7E=;
        b=WHj6CB8b9o3TcipQkg5zNKjnK63fmwIi5v6tYQzgdLpquoLFKWuYch1/s2CJWAwC7e
         FNa10rGdpVBkrPew8ZLNt2REwMU1w3WixFw80RCpF8+xN0TwpXdNZiDyFqiS2SffOLBv
         FtQqO/EwX3r1McFB35zKaaem0t8SvKQaysrKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745512931; x=1746117731;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdeGo1ClxSoX72okoFEyRfcK08keDtWUfesWE0Wuy7E=;
        b=TvB76gkGmTRRossmkeSsuKm20wXQ8QtHGvP6CrY90Rm5JYjCL4YKQe57INd+TgCI5i
         gkgdDxmlIi11UR+bUHtNb9a4CN71lGsk/yIKYRXKWe/CBTHrWsv31qaraV1e7R/0p0tl
         H7kVK4cWAQh5gcrqk8sD7m/fH+aW/iBLSFNt5kAVVCMqGfsOLyq3g4HozSSSuznkFFpH
         99NwH8V3S0QqAzNl0Dz3HZBqA6reO53ygMoC/4Sv6Wc7oSWNkvviTBhqF85+We2NUJoS
         EVXv1ldKAjmJf8NkKTefOozuAbryCBQwA7UGX7l6GTsmI93yTO+5fijH4la5j0QGrIU9
         ZT2Q==
X-Gm-Message-State: AOJu0YyZ5CoEviOk0FsEVzrtmgnLU+ZFapZO77KenLSla8A0xn3D7yrc
	V4MHYPYX4lpY2hBcHOx9wRWX3WZiMWzt8XB+wR0BS+fyMrySOpWGaDGiNqY1vv0=
X-Gm-Gg: ASbGnctX550Twp74G1hqgytT6Sotg6Z/LcBNQ1WdnlkgOh/2iDQI0H3zdVJ1OEvbEyX
	o4jW04DilU7VgDpqMv1alTIsamxfOZZkXHLediVvpI/u0uh9KfPZF+FaxZM5P0YH0SSCHj5oWp4
	dx7hZOgkTbbyJ9x7BlSIe97gHjrc5SdmAIJ8YB8S0VLyz6LxnfzYct1vZAtbUBQoPSsFF9EsdL6
	roXkc1r5YwN7upcYVlLh0/+V/JM84MpSRw1qqC1t+eOf8XlJpIXD8FST5EyDavQAi/PIYgw4UC0
	5KIPzjKReluflVCVGwDrBe8j4RHzXEuQJlI1jG8l5Vx41ZNqgG0DgwMLpU5FFfNCzx2AmQkw4be
	H4THVCmJiWq2V
X-Google-Smtp-Source: AGHT+IEa/leTTXpHP/P8tSsO/GzMgau+ZpxBmyYg6Pl64hRilNRa+l3k2UxWj9/OLHG4D1p4FcHJlQ==
X-Received: by 2002:a17:902:cf03:b0:223:62f5:fd44 with SMTP id d9443c01a7336-22db3d77712mr48516315ad.40.1745512930792;
        Thu, 24 Apr 2025 09:42:10 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e79f7sm15673385ad.155.2025.04.24.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:42:10 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:42:07 -0700
From: Joe Damato <jdamato@fastly.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/Makefile: Add ynl target
Message-ID: <aApp31D9sCcLQG50@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250423204647.190784-1-jdamato@fastly.com>
 <m2selxsw1t.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2selxsw1t.fsf@gmail.com>

On Thu, Apr 24, 2025 at 11:17:34AM +0100, Donald Hunter wrote:
> Joe Damato <jdamato@fastly.com> writes:
> 
> > Add targets to build, clean, and install ynl headers, libynl.a, and
> > python tooling.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  tools/Makefile | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 5e1254eb66de..c31cbbd12c45 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -41,6 +41,7 @@ help:
> >  	@echo '  mm                     - misc mm tools'
> >  	@echo '  wmi			- WMI interface examples'
> >  	@echo '  x86_energy_perf_policy - Intel energy policy tool'
> > +	@echo '  ynl			- ynl headers, library, and python tool'
> >  	@echo ''
> >  	@echo 'You can do:'
> >  	@echo ' $$ make -C tools/ <tool>_install'
> > @@ -118,11 +119,14 @@ freefall: FORCE
> >  kvm_stat: FORCE
> >  	$(call descend,kvm/$@)
> >  
> > +ynl: FORCE
> > +	$(call descend,net/ynl)
> > +
> >  all: acpi counter cpupower gpio hv firewire \
> >  		perf selftests bootconfig spi turbostat usb \
> >  		virtio mm bpf x86_energy_perf_policy \
> >  		tmon freefall iio objtool kvm_stat wmi \
> > -		debugging tracing thermal thermometer thermal-engine
> > +		debugging tracing thermal thermometer thermal-engine ynl
> >  
> >  acpi_install:
> >  	$(call descend,power/$(@:_install=),install)
> > @@ -157,13 +161,16 @@ freefall_install:
> >  kvm_stat_install:
> >  	$(call descend,kvm/$(@:_install=),install)
> >  
> > +ynl_install:
> > +	$(call descend,net/$(@:_install=),install)
> 
> nit: I'm not sure there's any merit in the $(@:_install=) construct,
> when it's only really needed when there are multiple targets in the same
> rule. For ynl_install, $(call descend,net/ynl,install) would be just
> fine. It's funny that the existing convention in this Makefile is to
> mostly use substitution for the _install rules, but literals for the
> _clean rules.

That's right, I was trying to follow convention. I agree with what
you said. If the maintainer of whichever tree this goes into would
prefer that I re-spin this, I am happy to do so. I was mostly trying
to keep it consistent with the existing targets.

> Either way:
> 
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Thanks!

