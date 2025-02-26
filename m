Return-Path: <netdev+bounces-169882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635CA4639E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0409718876E9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFC221703;
	Wed, 26 Feb 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="inpkz+vP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDE2222A1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581321; cv=none; b=lp4Jp/TcFdR+FVdTVyZqeJ2zObIZ2ZkIcdoD3aKIIcZzlXNNnVR2xkLgk+8JoYlI8viQyqieWTmsk8hSK6U7j6xseVa6rsOzaVSXz8jnrhpsArDVl8DWpRCgDOUcECTLgv+C6X57CmGhGWTK7OPKTn5uTVdDL1k/jZO4ry2IoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581321; c=relaxed/simple;
	bh=su0PyH6fk/umxyHrvcwmhEHJXABA6CnmzbapAUQDlIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7JRIW8r+/nCDni++nLirejtNkAxlEHCRBogfeN110q5CwYD+SDR2t9xmjKAFY5gwyMt/afvqEWIlrHniwI8NXJ980W8nVS2mmcDB/bhhGZYPKkr/+6c/es53a3mdS4VFNk0xWT//aoGYDR71CkmGAFgGJaGj4emUglw4ESVW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=inpkz+vP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso799851a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740581318; x=1741186118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMoILKIF7N8WQlVNtPKgkkC84yA+V5fRgKd3rLXRVvE=;
        b=inpkz+vPNl0mlm9nSbeeNnKOTt1q+9n6oHZNQrX7CjQukEe9Avk9f8bqnPOxPu0XDW
         2+hMyEhuzWWNA3Jzaw9AD8Or1ANsQAhJ+IT+M08iyUH99AJ3MkhkOMZSm2jLWDPmjWBv
         78ZZUHS+AjxLiiV0aOpALNWZoIDcoUD+Yy4EyAsFTIFSAlUI9jLw8vKNaj8YF2FWg0eq
         PrnjADb6w0dMtB9ytr7dq8WcoXjUNe7QfJWWOL3YiR0mcEA9Gwiup+qsdrKX+MAwN/I0
         EKoIH+9MNh4vjab2EQBAqv311ZV9B1LtdgsSb7WA9Cx0g3sDOyvibT/smDai2GDpMHuR
         jEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581319; x=1741186119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMoILKIF7N8WQlVNtPKgkkC84yA+V5fRgKd3rLXRVvE=;
        b=v0MFPr9Tp/99EgrlvbajeCi7hEt3va39PIE+tMHnRyH3Yk+HnyvgFFcJBwwo8kzSv4
         ZyYR95cBrEInJSV7Q1eKevhHHzK026LbV+cmkMEZa57mjz/t26RHk4V3neTpeZI3bSQL
         gyt1pm+Kiw5QCm5Q/kictjAvC3XITDi/nOVIOejn0D9Z4KF7XpkjtlU5oHldGzDHyZLP
         aKZ90jFEtWzdONLHGqtMOeZRg5BK5YMkWCP/9kCWORIm0u51p3NREUwPlQ1LUoTYQOkO
         ilOSL8sJ38Vc7tDaSAy5+uTW8LUaKyt97x8kUfb8fuG9SxvaFznEtUBHECnA3DYwwdMO
         mf1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPzjftvl/BxaVEWUIaCQIALwxdpu0LMolDSv4m7npfG512bitOQWf1/WAaCRQlcgXnQgUIi3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkTo039J+QP/UxaU+yUzviyoo4IgZ0MI4fHz4qhbnrQPfWbCO
	zYObVk9XAF/jRV11qoUb39ogi9ny81FvfgSkgF/y9ojlhBDkqAWoxAN2uWP7GAI=
X-Gm-Gg: ASbGnctESoNXKXW7vhwCfa+Nv5yPtDHp+qF5SwpS1wNvDAz9qP3wawxSczxf7B4vbx6
	rpe0XTOlC4U2/MboMlXng2okOIPkYlLd7124P2Zs37o+8ORQWf2NsVbJwVK+4mofr3kIjEowBHy
	ge5+yyHT3R/uOTKUvji5RNLnw5F4Hx/b8/AaEALb59RW6JyGXsjvurL6C+YcLxFXOEOHMcpkdqm
	8o9gYCho10smd3JlU9lN4OLv5CjPFg2yUsh14vijlvaVJq/snTtDK6KyoWE4Lx6nFar/JwPVtze
	1GuHgJT5Pbsivqpd/V5NmYUZM4CO/mNvV3oOU8fwuRW2E3yCZas3Kw==
X-Google-Smtp-Source: AGHT+IGtH1CcVMxMCJwtVi3LYJ16g2hv5Xsh1dW0fQCUJV+H/J70PtPy1kYytDJYuVvZvlxBA+dtIg==
X-Received: by 2002:a05:6402:5202:b0:5e0:7f52:226 with SMTP id 4fb4d7f45d1cf-5e4a0d45e24mr4468134a12.4.1740581317806;
        Wed, 26 Feb 2025 06:48:37 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm2912497a12.68.2025.02.26.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:48:37 -0800 (PST)
Date: Wed, 26 Feb 2025 15:48:35 +0100
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
Message-ID: <iiemy2zwko4iehuw6cgbipszcxonanjpumxzv4nbdvgvdgi5fx@jz3hkez3lygw>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
 <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>
 <zzyls3te4he2l5spf4wzfb53imuoemopwl774dzq5t5s22sg7l@37fk7fvgvnrr>
 <e027f9e5-ff3a-4bc1-8297-9400a4ff62a6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e027f9e5-ff3a-4bc1-8297-9400a4ff62a6@intel.com>

Tue, Feb 25, 2025 at 04:40:49PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/25/25 15:35, Jiri Pirko wrote:
>> Tue, Feb 25, 2025 at 12:30:49PM +0100, przemyslaw.kitszel@intel.com wrote:

[...]

>> > output, for all PFs and VFs on given device:
>> > 
>> > pci/0000:af:00:
>> >   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
>> >     resources:
>> >       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1
>> >       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1
>> > 
>> > What is contributing to the hardness, this is not just one for all ice
>> > PFs, but one per device, which we distinguish via pci BDF.
>> 
>> How?
>
>code is in ice_adapter_index()

If you pass 2 pfs of the same device to a VM with random BDF, you get 2
ice_adapters, correct?

[...]

