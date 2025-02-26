Return-Path: <netdev+bounces-169880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA3A46354
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937D11899E8C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96898221D8E;
	Wed, 26 Feb 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HKTP/rEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E1221712
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581082; cv=none; b=YWqXefcqs7RgAXcdFNJrBFn1SmKirfzzdFtS9vRVISNgL3NdGS0tuVNweCiNVIJ6TIBxUajtIPz9nVuof7iYQ7nmoLR2hUb6fr+ibeLYczdrpnhoeuoNi19MLlUBQOBPCodxvOVHlH4nkK4I6jaXVVOENFH28tE2lII0K+DC7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581082; c=relaxed/simple;
	bh=kU/v7wqnqnL/CUwnJwMJlEh59FgkJ8snU821pG4Y7vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhs/wy5MYC086kPMmfC7aWNsDnGWAWlvLZz1on7xbv7ZSj+z6Na3nuJnApiTKbCeblbFjMc5TRYsrOCQdKyMzPJZ0ohQecm31GRSq6vkML5vdHCN46rXQH7rGWsj++WrRKPxdeVV3xn72X9nTaTCuRtV4ks6L4TL/dpLIR/ngwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HKTP/rEo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1392543566b.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740581079; x=1741185879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3lgX5xVuREpMskRYofLOpLEr+lAUcsjQpUjCM0xtcE=;
        b=HKTP/rEol4MUDaKRuNqYBS4LAinMV1RbRDy5AIFnFpP37rJ+cHLPKFoxE4Ke7fga3d
         luty92mDw39JL/6RPiQBQPc3Bvs1SuICsdL5bpjQ9fcnTtpH2eZoNrRE+ltjdz/hWdlj
         UPUDUSwMsajcdFOH8jap2vAQWwZnok1dzcB8N5U7sZcCKLzlarGMd5czaF49V2e9XyKx
         4pGkGTY1YctwNcH7/IOFozPvwB61T57iRHASXEcLxRU87haPmok09+FmGT0oN5MOF50T
         3BRlq7tmgeeQVEDMHBkeSDe6R2UeaSfYrQ1NBP6aJGe35I37yZUnZZjEbCXhm8CLgqEM
         /yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581079; x=1741185879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3lgX5xVuREpMskRYofLOpLEr+lAUcsjQpUjCM0xtcE=;
        b=KNqKXQEwEoLHiRRBJTTy42DQ4+qsfuRzPU+BH1E99BBox5oK0QGpkNzL52cLGZlO/7
         QJQdgQfXs56T5/UQg/W+vom8v23W6Uo8NRCj/jdS2u4dCmjhcFTEmvXCbs/xUs3x1VwZ
         iwmb5BL3UIzzNqkKIR1F88CT9dSFz/bBGR3FDIYJSRvfhIlSMH/fBTkNfmcpsO7l100n
         GYPqdNVm7Ex0ZiyMAbI01L9sZNrkWcx3GRla9MYfKn3rTrkLNpyRTQDATejBbp3qcg5c
         f7vC3H0rWRuEymKwqn8A1tKJurbk1EdiGHho9GEUA405+NUPn7HfIoP6ssdHRXdqQKAS
         +/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtvYpWkm/sJ5CcJaB8D/Z7LPo6bVtayXwg420HDCQAgnVG/Ik/+AXUkO+lbNY20SVKr2fdFEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ArO52m45F8xZeUlgoswuHuB85rJp2ow0Fv2JYLCj8LtqV6Y2
	oSAV8muBHwH969m2b6iSpfak2xg6C+1U2Uzxxu7lABSMBN0NReNxD3OyOgGhSvw=
X-Gm-Gg: ASbGnctPB2uyvLUskqCTNBCrU+FMSeL5vL/MMZsq8PVF2O+B0dqA7rrFTLaVEYwxMn3
	VMESsfBtpDRaLWooS268CRprHg2BAcLnvjK587U6UBqrONLo3cvvdcCvzbJSXrgKGev7suiRw2Q
	iYWzsiH+rcnRn3nP9NDugZ7ARua2pAOB6fWa8sFPs56yZvz3LCgBWnLEyJpP8xQbe7Swv6wxSTE
	OT2NiP80ubx457EIclpe1cW+1NVivWOfYjvsy1+ew9LdPjDNOkvsVBUaUZsSrq0Q5RJrMgRSe6n
	oEr183SBXMHRrPH73RCdIs0PBMYlsGJJSomdTRK6TDixgVIHF5KAtQ==
X-Google-Smtp-Source: AGHT+IHIRtlrHZVjf/hDRjPSID8OLFIzIelRBHIadTGYyg2MUE07spOk+sYZauxSRswyF+7Ev7Qp5w==
X-Received: by 2002:a17:906:c147:b0:ab6:d575:3c4c with SMTP id a640c23a62f3a-abed0cc511bmr827247366b.17.1740581078919;
        Wed, 26 Feb 2025 06:44:38 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c7efsm340987766b.149.2025.02.26.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:44:38 -0800 (PST)
Date: Wed, 26 Feb 2025 15:44:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225174005.189f048d@kernel.org>

Wed, Feb 26, 2025 at 02:40:05AM +0100, kuba@kernel.org wrote:
>On Tue, 25 Feb 2025 14:36:07 +0100 Jiri Pirko wrote:
>> >The problem comes from having a devlink instance per function /
>> >port rather than for the ASIC. Spawn a single instance and the
>> >problem will go away 🤷️  
>> 
>> Yeah, we currently have VF devlink ports created under PF devlink instance.
>> That is aligned with PCI geometry. If we have a single per-ASIC parent
>> devlink, this does not change and we still need to configure cross
>> PF devlink instances.
>
>Why would there still be PF instances? I'm not suggesting that you
>create a hierarchy of instances.

I'm not sure how you imagine getting rid of them. One PCI PF
instantiates one devlink now. There are lots of configuration (e.g. params)
that is per-PF. You need this instance for that, how else would you do
per-PF things on shared ASIC instance?
Creating SFs is per-PF operation for example. I didn't to thorough
analysis, but I'm sure there are couple of per-PF things like these.
Also not breaking the existing users may be an argument to keep per-PF
instances.

>
>> The only benefit I see is that we don't need rate domain, but
>> we can use parent devlink instance lock instead. The locking ordering
>> might be a bit tricky to fix though.

