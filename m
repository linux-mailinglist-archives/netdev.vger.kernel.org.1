Return-Path: <netdev+bounces-115481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF6946842
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B321C20B31
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DF7D401;
	Sat,  3 Aug 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZM00vp/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16B23CB
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722667902; cv=none; b=YJ0bhMEB+wY+zrIrOBL+ZgnUKrwMXTCfsi/jfGmOOs6S4frO0pFfjn0wQ/rTrb71PpJvbPNOgCGcdFkhNe3MrY4OhfHCX+L++lxz0luCcjRB49kJsHGK1Qgn4nqrpVZoQDSobMDHpv5ENoPjYkrTXxY5LWrCpXb0j/S7+TVZHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722667902; c=relaxed/simple;
	bh=uleyU7zkiVlvxkjAj2rzgWy+yK3wNK3zxum2C1m++kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMoQY7GK+vBU7Ch2by+M1yYG0zRpBJbm+P9xsf0jdcxO98hu9Pcboe/wUB9O8N2/oiaz+V/uxP3fLpHOhzEVU+CJ9xaoQOgQUFH7MYk/BRLHWOR6wOZMCJ5Tyfvdo7LkmqsqFzDfysMAnzoN7ZQX52RIHcn7fDBH1MadFFwUiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZM00vp/u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so109569171fa.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722667898; x=1723272698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jt5lP+PY1t5tQI/CD9mWXG7Nv0yty0RhYyKPZQtUTE=;
        b=ZM00vp/uWhSV5U+ArDKju4DS/DTe9r/Y/V6/qVA+ZNfFxN/zSVWzj4ga/coCXpAJ2V
         4R3N4+mnh+FgJUOyym2ubkzub0enHc2lC6Ktz/PcMxywOsKFCrTBPHxE7F+A2vuZOMWD
         xrIfYptOejkSuhM+VczdFIbxAXnAwf5ODExVQ4rgd2i3ruleEjTbd+qRYFA0G/lfqG65
         4pzXcfAOhpbBiXBwwyq6FG1pQGH6QTA4X0j4DIjphnGT+JbcbxmuR2CjN9oDGS1aRNKT
         4CrxwtZr1AvqzsE0gTbpBFKbMo+1KAH7izwqU+N6sKEUvl+ylV8jnOjOLxKIHwSe6Yj9
         LBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722667898; x=1723272698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jt5lP+PY1t5tQI/CD9mWXG7Nv0yty0RhYyKPZQtUTE=;
        b=aCZEkqi8VbMDs8Qq0nlouJeDCgAClHqg7Arvr37hhIEHf2fPp0rEULYDM+xW92ewNA
         LxvaZmzUpbOfVwtvr5RT87aYyeNvOGajmfAzesTl0M/1zHtFofA2CQoVCzl3bTqRJ1Th
         Ba5v0d66YztEO7Xu9GvXOz19YOyzqrYZvUqwMrIrLIa0JMnqNOV84Pi2hcjxW5tFPS/s
         UNI+05qYr2ltJM9Ua2mMt108RJwk3IPAmByZe1BPhHR9kih1dJ5ov5fSu79gkyH/rXrD
         tFCeXjCXUBr/uAmRO3RHQ9F9J2TY2YVcv8vt7h3sehw5zhqxPur1GEgtxdImPSSPWVFn
         qpsg==
X-Forwarded-Encrypted: i=1; AJvYcCUjGypgPVH5HJCrn37rklVjZW2s0ZAGHsAxFIHsTDxHFx4dYV1Z7L+zF++nKEUvi2LV3wUH4+A6Iaqn8mLNF73KdSFRtshL
X-Gm-Message-State: AOJu0YyvlwM3f8xTTjbotiZ7pTebCFkoVHAlDNrD71ms86OmDSnFKHj7
	KYEFKzbsVcRF2WsZW7L0EpqQ3ly54QO+39fKchttG/MTGcrizOKxP2JaspserVx6EIqY+a6obdY
	I
X-Google-Smtp-Source: AGHT+IFYLk/qX6EFl1Fi++CbL+WO5rnxnUjP7b7fbuUi3Lq6aeF7pO+HqCq80/484ZjnjyG1KWynbw==
X-Received: by 2002:a2e:9d8a:0:b0:2ec:5c94:3d99 with SMTP id 38308e7fff4ca-2f15aa8340cmr38504171fa.2.1722667897891;
        Fri, 02 Aug 2024 23:51:37 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428240b3041sm118735015e9.0.2024.08.02.23.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 23:51:37 -0700 (PDT)
Date: Sat, 3 Aug 2024 08:51:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <Zq3Td6KFXa1xNxo5@nanopsycho.orion>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion>
 <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
 <ZqyDNU3H4LSgkrqR@nanopsycho.orion>
 <ZqyMQPNZQYXPgiQL@mev-dev.igk.intel.com>
 <6e5c9fd5-7d03-f56b-a3b9-3896fbb898ba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5c9fd5-7d03-f56b-a3b9-3896fbb898ba@intel.com>

Fri, Aug 02, 2024 at 07:38:34PM CEST, anthony.l.nguyen@intel.com wrote:
>
>
>On 8/2/2024 12:35 AM, Michal Swiatkowski wrote:
>> On Fri, Aug 02, 2024 at 08:56:53AM +0200, Jiri Pirko wrote:
>> > Fri, Aug 02, 2024 at 07:11:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> > > On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
>> > > > Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>> > > > > Michal Swiatkowski says:
>> > > > > 
>> > > > > Currently ice driver does not allow creating more than one networking
>> > > > > device per physical function. The only way to have more hardware backed
>> > > > > netdev is to use SR-IOV.
>> > > > > 
>> > > > > Following patchset adds support for devlink port API. For each new
>> > > > > pcisf type port, driver allocates new VSI, configures all resources
>> > > > > needed, including dynamically MSIX vectors, program rules and registers
>> > > > > new netdev.
>> > > > > 
>> > > > > This series supports only one Tx/Rx queue pair per subfunction.
>> > > > > 
>> > > > > Example commands:
>> > > > > devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>> > > > > devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>> > > > > devlink port function set pci/0000:31:00.1/1 state active
>> > > > > devlink port function del pci/0000:31:00.1/1
>> > > > > 
>> > > > > Make the port representor and eswitch code generic to support
>> > > > > subfunction representor type.
>> > > > > 
>> > > > > VSI configuration is slightly different between VF and SF. It needs to
>> > > > > be reflected in the code.
>> > > > > ---
>> > > > > v2:
>> > > > > - Add more recipients
>> > > > > 
>> > > > > v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
>> > > > 
>> > > > I'm confused a bit. This is certainly not v2. I replied to couple
>> > > > versions before. There is no changelog. Hard to track changes :/
>> > > 
>> > > You can see all changes here:
>> > > https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/
>> > > 
>> > > This is pull request from Tony, no changes between it and version from
>> > > iwl.
>> > 
>> > Why the changelog can't be here too? It's still the same patchset, isn't
>> > it?
>> > 
>> 
>> Correct it is the same patchset. I don't know, I though it is normal
>> that PR is starting from v1, feels like it was always like that.
>> Probably Tony is better person to ask about the process here.
>
>The previous patches were 'iwl-next', when we send to 'net-next' we reset the
>versions since it's going to a new list.

I still see it in the same list. Same patchset.


>
>Thanks,
>Tony

