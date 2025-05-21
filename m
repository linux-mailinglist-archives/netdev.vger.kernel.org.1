Return-Path: <netdev+bounces-192256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D21ABF21A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6929E1BC2D14
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8562367CD;
	Wed, 21 May 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="QiXcN7Ip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C61241682
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824631; cv=none; b=sYH5N2Wu1XTGVgBr0Yz0lJ+wTn/GtO1MaDy8N7LKKDtGGPTP4xk4FADuRu/MqaGjLwwurYBJ3W+Z2KHMulDb/v2w3vUOepgzKIdxS5hteXQx+leoyaVwnoy3LYN8ksrbkFLYVIgsmA2w+NElfm1lV1y91mBGShSQb1akg3TjxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824631; c=relaxed/simple;
	bh=M2vtiVgfR6FZgf98XhswdEOcn93NCHdD3EXICxZzTaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMwlvIKzoHZpMNFK6HrEs3yLogEjd7Bc7/CiIS9ooH1+RT/PZHlYVnIjtbQcC3G0ARhzeubAUWhpimQIZ4Uh+I1g4uQj04P+XtbnQQBZl8M2xQNdEZkChLeb7C+61/QsM2hs98VqXl/rklLUMPH0a12jKnCzRFPQtbB5O6Ih2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=QiXcN7Ip; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad53a96baf9so757348066b.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1747824627; x=1748429427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2vtiVgfR6FZgf98XhswdEOcn93NCHdD3EXICxZzTaA=;
        b=QiXcN7IpLchMhBq0dFTDLKr+zIuCOtzC7A/8GWSyrXGdwRkwc33pGnvO+3EQIBg9JC
         Of9GmYowDoaV/AsaSGazZ7hRUVsi9Sbc2/bTtESrZ77bjs+qYyl14o0eZTt7JTGQVo9a
         CMoNFyvEsQERfVKIyxU14A0JuKeFzkfVsR/Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824627; x=1748429427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2vtiVgfR6FZgf98XhswdEOcn93NCHdD3EXICxZzTaA=;
        b=aag8neYqB9kTqLPvKt09cczhZv+FKZUwiGY5Ii9tXU42g5g+Y40Zke9mvDNQTsOhSD
         vQDCHTOwyTy29iAQkBy4zSKpHnVXE1+BZPXcEUJiNm/xdEGHnr01kKIbx2MbNb4K5CqT
         RLb8IhPagxrl+mHksYXh2nBV+MzFNKFWvFGStrE1YugBf99nFfrvhHi6eAnd3ix4VVzG
         agVfb1VWP1B3Ofpw8xpF2RP119nEiFFL0aMxEdAsdROZPUfcSqGRrNmZoHTi1ahKSPIj
         xvKmBx4/WkShU+b0dh9cOPcJ+x7WZiw1zKIeJ33yQQ4ooHSCJZzVzNuOSlYP5iU5yaOH
         vxWg==
X-Forwarded-Encrypted: i=1; AJvYcCXc06BHts8n2m5NMW8SLjKtdYQaLWaHID366QXBI6lTSPbpPwLIjomeFDTUnfJ0crKFikCkjkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzUQXimzofXud+naFA/1Ox6VujEBrViKJXgVuvZx6IhtshvEA
	rZuHbTTOW3Bb+yraoW75wP4AeAvVY/hPIWauDxdmf5sHVIdrhyD6tYMwiRqmgst0/UIGI6IaR/P
	3HC195W07bA/PmM6mdcGhB8UvFk2lrUp3bEsWw+p3
X-Gm-Gg: ASbGncs8zzhVdKcioTQ5j+F0DTcPIiNr6iQDfl7Z33LRF/3SK/53PK7DfnGIp6rbm2P
	MFA5oHDaeTTCxAvRjJvmA9EX1aBs2cFVOeZtzo8H5vrF1oS3yPFfpNbWR/gySJN+S+N71Ya3cDQ
	as57H6ShcgM5+RSaA44d2Zh8f0rwcOOMW7YQ==
X-Google-Smtp-Source: AGHT+IFn4M467pvwWvYeEw98IU4Dc2GTeW2Js4z67oBu89Sg7yvTZK/pGdM21txGydc1ZTRTFG2e55xgFbzF1unShc4=
X-Received: by 2002:a17:906:1dc5:b0:ad5:43de:cda7 with SMTP id
 a640c23a62f3a-ad543ded27cmr1146889666b.61.1747824627327; Wed, 21 May 2025
 03:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com> <20250415175359.3c6117c9@kernel.org>
 <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
 <20250416064852.39fd4b8f@kernel.org> <CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
 <CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <20250416171311.30b76ec1@kernel.org> <CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 21 May 2025 12:50:01 +0200
X-Gm-Features: AX0GCFtZfcKm6dgoe5vWiOgtcBl87bqlfdi0XwVIbm4e2i0w3XJB8ODLcpCFOUs
Message-ID: <CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Damato, Joe" <jdamato@fastly.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, 
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 17. 4. 2025 v 19:52 odes=C3=ADlatel Keller, Jacob E
<jacob.e.keller@intel.com> napsal:
>
>
>
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Wednesday, April 16, 2025 5:13 PM
> > To: Keller, Jacob E <jacob.e.keller@intel.com>
> > Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>; Kitszel, Przemy=
slaw
> > <przemyslaw.kitszel@intel.com>; Damato, Joe <jdamato@fastly.com>; intel=
-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Igor Raits <igor@gooddata.com>; Daniel Se=
cik
> > <daniel.secik@gooddata.com>; Zdenek Pesek <zdenek.pesek@gooddata.com>;
> > Dumazet, Eric <edumazet@google.com>; Martin Karsten
> > <mkarsten@uwaterloo.ca>; Zaki, Ahmed <ahmed.zaki@intel.com>; Czapnik,
> > Lukasz <lukasz.czapnik@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes wit=
h ICE
> > driver after upgrade to 6.13.y (regression in commit 492a044508ad)
> >
> > On Wed, 16 Apr 2025 22:57:10 +0000 Keller, Jacob E wrote:
> > > > > And you're reverting just and exactly 492a044508ad13 ?
> > > > > The memory for persistent config is allocated in alloc_netdev_mqs=
()
> > > > > unconditionally. I'm lost as to how this commit could make any
> > > > > difference :(
> > > >
> > > > Yes, reverted the 492a044508ad13.
> > >
> > > Struct napi_config *is* 1056 bytes
> >
> > You're probably looking at 6.15-rcX kernels. Yes, the affinity mask
> > can be large depending on the kernel config. But report is for 6.13,
> > AFAIU. In 6.13 and 6.14 napi_config was tiny.
>
> Regardless, it should still be ~64KB even in that case which is a far cry=
 from eating all available memory. Something else must be going on....
>
> Thanks,
> Jake

Hello

Some observation, this "problem" still exists with the latest 6.14.y
and there must be multiple issues, the memory utilization is slowly
going down, from 3GB to 100MB in 10-20days. at home NUMA nodes where
intel x810 NIC are (looks like some memory leak related to
networking).

So without the revert the kawadX usage is observed asap like till
1-2d, with revert of mentioned commit kswadX starts to consume
resources later like in ~10d-20d later. It is almost impossible to use
servers with Intel X810 cards (ice driver) with recent linux kernels.

Were you able to reproduce the memory problems in your testbed?

Best,
Jaroslav

