Return-Path: <netdev+bounces-55381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D959A80AAE4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82391C2084E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D439FE6;
	Fri,  8 Dec 2023 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UmWvGTUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981E11D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:37:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d069b1d127so18282245ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702057048; x=1702661848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKqyefL6cZoxtR9NsXaYRqJ33cRC9URjq1Fv1wwKWxM=;
        b=UmWvGTURQasDsN9U1eSIbSV8v3VoFxSvlMv0zmh9xl7CF1oRMYBRVSpGsUQoJjrasS
         GIxCqmrm58P3iePulHzpnryTTMHNZb9reYUe4qu6ucmC6gg6bJThXBp1/N0+oO+zp7kg
         7GAthp3AGAXCs1y+0CHPwxpHdmJYiOQABU/3KTAUAw1nnvykA5fq01QREPADKw1J4YI5
         xr1tIKQYa7Qhm6gldblKySxBN0218H56MV+yuddEYZoixXjbPjgmQwKPVmFV+XgvxSms
         mUjZZrCUP3T9sj8TUnDo8gJOQdRtFeb7TkWKTA6jgz5N6zKh4Aue2xLFJms1XsvA1tIy
         g5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057048; x=1702661848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKqyefL6cZoxtR9NsXaYRqJ33cRC9URjq1Fv1wwKWxM=;
        b=e/JT15fQNp+ebeyOTN2iC21JLZYGXgKW/YghizBcXyfAeJyyukeezReskuejvRPoqB
         mYL+rsQtMXK+QxPALHC3iK3RlFO+WOiMpPQocI7G+0NoIQc97puz+46za+HPGHuJRLIk
         1tu5nBAGkIXxlPpunFy8AngYsxCQCo+r06UPIY+QyaKRBMOIx2jgxRg3wXA/LFf/DwxS
         UOCj7+kl5AoNG8eE6G1EfodKGBRSDVbwmO9zqy5PikRjttGGVm8L5knUWgz64YJaCTUO
         CR9Gs16OcKIBC/PT++8Zhs7GfJPNAnmDRYFuUvx917ke/MNpCgITdiYGFmDAsmWGBW6Z
         kZ6g==
X-Gm-Message-State: AOJu0Yxdxcxr4TB85ep1iD7/ZS6Dkoh2aFD/z2FTTWqJbH5ZKCmF9LR9
	ZxmS6Q+xIncB2d7VJHXa1uQZ8eJDdJm8H0gLiUv55Piw
X-Google-Smtp-Source: AGHT+IF6FLlwGa6pfk6z8Ai3DlAeKWZxTy6gEp+cWst+ugeCndmWM7+FRHk+xwAW3vtUvoES8fLJvA==
X-Received: by 2002:a17:902:728e:b0:1d0:a35b:8cf0 with SMTP id d14-20020a170902728e00b001d0a35b8cf0mr378679pll.132.1702057048142;
        Fri, 08 Dec 2023 09:37:28 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001cf684bf8d8sm1950444plk.107.2023.12.08.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:37:28 -0800 (PST)
Date: Fri, 8 Dec 2023 09:37:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Arjun Mehta <arjunmeht@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Rx issues with Linux Bridge and thunderbolt-net
Message-ID: <20231208093726.371fd47e@hermes.local>
In-Reply-To: <4E2F8965-E609-44F2-A361-270082367DC9@gmail.com>
References: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
	<20231207143758.72764b9f@hermes.local>
	<4E2F8965-E609-44F2-A361-270082367DC9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 10:30:39 -0700
Arjun Mehta <arjunmeht@gmail.com> wrote:

> Hi Stephen, thank you for the reply.
> 
> Proxmox does use a kernel derived from Ubuntu I believe (eg. kernel for Proxmox 8.1 which is what I'm using is 6.5.11-6-pve derived from Ubuntu 23.10). Not sure if there have been any modifications to the Linux Bridge in it.
> https://pve.proxmox.com/wiki/Proxmox_VE_Kernel#Proxmox_VE_8.x
> 
> Long shot, but do you happen to know of any workarounds with the Wifi interface issue you mentioned that would mitigate this issue? Maybe they would apply here.
> 
> I will also post to the Proxmox forums about this issue to flag for them.
> 
> Arjun

With VM's the issue is that many hosts have source address protection in
either the SW or HW for VF's to prevent address spoofing. 
This means you can't run a L2 bridge in the guest.

The only mitigation is to do some form of Layer 2 NAT.
Possible, but I have never done it, and likely to have scaling issues.

