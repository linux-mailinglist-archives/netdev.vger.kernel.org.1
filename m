Return-Path: <netdev+bounces-132837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8948899364A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D901F24264
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4351DDC03;
	Mon,  7 Oct 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx+JxBH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF51D7E52
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326124; cv=none; b=LFVGY3Ths2r0pJS7RDbtLFBgsHnHk8zvPeLeyWFb0JW5fo0skkhf9Qnm4cHKZDJEnMXTk0JDI5zt3E3ovR2me3LvuqhIn0VADBsQq5sT9PqhWDsO8S+/LzKn2egu3fBXq9iGPZH5gbVMtPm5ZYIzQU5FAn1g6Ii47IffK5qWQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326124; c=relaxed/simple;
	bh=S9cHN44L4W+WPqSYQaecyVrLp6eMPYmCcHcgcuCZKyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT1J0Gyy5u3bMKTRgwKXBDcVlLyqvWItRzS+39LlwN+VT+nMfXe3tMhbu6KPZT9Fc2L2n8AirNghgXPduh17WhTOgJK+7T8XWb3i1V4osFRnvYSuCR2k8zqQQOrpH5CJFU574h2J/gtF5/PD9n/6qRWKopaN1uartnA5Rwp67IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx+JxBH4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4582a0b438aso38574671cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326122; x=1728930922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0RV937lmTQ17+PUsFIASvlpjdebJu2y5yqjaW972M=;
        b=lx+JxBH4vt+BBo0gx47jqX4S41lWLqHeMwScmSP3QSU64Q+je3Ue4VWxopv2a0OJqL
         /q7Le2/0E5TSdWVkxqu0dQ4bK119vzknQ2bdWNLjN0onOs+5X5JyBO5OQ+BsnqCBh7cU
         Yi5H/zAzqkOK6dGyxpjf3ocosD7AgyzDmxptYZU0aqw48PKQAdPtWXiNVq7iKjPB8KWA
         ynvQ3DE4lC+CeoCrUlfAto0b+I5sfWxSTBVklBGO5qOpvdBNVGuyoa9ZutI3LyAmFZzB
         /nzHPumjw70vMKY+MDiGi13HklxVr6Zhw1JS5vGDoT3WYZYaZTrQz8sO/SBRbhvSBk01
         UvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326122; x=1728930922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq0RV937lmTQ17+PUsFIASvlpjdebJu2y5yqjaW972M=;
        b=Q4haGiJls2FNaJNoU2RZWLTVjvCYlbc7cpzfUEb/37WFLCn5hBx1qs412I0XCuIoUs
         7pLfdXGqSapblF4Lgymp7JFltLB4D28lzKy2bdahWAzmYsR7BDibxbWVlfs2Kgai99qz
         0NWZiDHp+IUGlw9z1sJPAtHB4US30sAFzgEid9HSP5xB42EIVA0NFS1cDRhiHi4ybjJu
         mGMak2qBgEdrIQxA7DheIK0zRTQpJMcLTAK9ynk3BTLGQA3zTg4/PBOE6Ok+NBekHtxD
         4VhokgMVrWOGjZkSrwIJzT8WyXKkhGTmZa9XBlPxq8nqVFNpuMvql6hKTC3NI0Hri9/M
         m5MA==
X-Gm-Message-State: AOJu0Yx1fNJDv+PkruNceJo3eUKEjFQG1yT7jdH1WnNQIT2pqrNk/t/O
	CJzOW0agv8lplcGEW1zjksvZc7lLPGv/iDTs8sHcg9bgknljm5Vybt/NyA==
X-Google-Smtp-Source: AGHT+IHk3R8GUiKtFj6/qKP0IK9iAjyznpwFZ8yLVL1FumGfa+3F3D4y6zCLaBRS1CLcAmnxN6GWZg==
X-Received: by 2002:ac8:59c5:0:b0:458:5ea0:c795 with SMTP id d75a77b69052e-45d9ba40012mr232827591cf.16.1728326121899;
        Mon, 07 Oct 2024 11:35:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75ed3ddsm28915361cf.73.2024.10.07.11.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:35:21 -0700 (PDT)
Message-ID: <009d90a1-16e6-4f6b-bfe7-8282e9deeeb3@gmail.com>
Date: Mon, 7 Oct 2024 11:35:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux network PHY initial configuration for ports not 'up'
To: Tim Harvey <tharvey@gateworks.com>
Cc: netdev <netdev@vger.kernel.org>
References: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
 <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com>
 <CAJ+vNU3qCKzsK2XFj6Gj0vr4JfE=URYadWsr3xvxOO__MVNsPw@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAJ+vNU3qCKzsK2XFj6Gj0vr4JfE=URYadWsr3xvxOO__MVNsPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/24 11:18, Tim Harvey wrote:
> On Mon, Oct 7, 2024 at 10:28 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 10/7/24 09:48, Tim Harvey wrote:
>>> Greetings,
>>>
>>> What is the policy for configuration of network PHY's for ports that
>>> are not brought 'up'?
>>>
>>> I work with boards with several PHY's that have invalid link
>>> configuration which does not get fixed until the port is brought up.
>>> One could argue that this is fine because the port isn't up but in the
>>> case of LED misconfiguration people wonder why the LED's are not
>>> configured properly until the port is brought up (or they wonder why
>>> LEDs are ilumnated at all for a port that isn't up). Another example
>>> would be a PHY with EEE errata where EEE should be disabled but this
>>> doesn't happen utnil the port is brought up yet while the port is
>>> 'down' a link with EEE is still established at the PHY level with a
>>> link partner. One could also point out that power is being used to
>>> link PHY's that should not even be linked.
>>>
>>> In other words, should a MAC driver somehow trigger a PHY to get
>>> initialized (as in fixups and allowing a physical link) even if the
>>> MAC port is not up? If so, how is this done currently?
>>
>> There are drivers that have historically brought up Ethernet PHYs in the
>> MAC's probe routine. This is fine in premise, and you get a bit of speed
>> up because by the time the network interface is opened by user-space you
>> have usually finished auto-negotiation. This does mean that usually the
>> PHY is already in the UP state.
> 
> Hi Florian,
> 
> Can you point me to an example of a driver that does 'not' do this? I
> can not find an example where the PHY isn't UP regardless of the MAC
> state (maybe I'm biased due to the boards I've been working with most
> in the last couple of years) but then again its not because the MAC
> driver brought the PHY up, its because it doesn't take it down and it
> was up on power-up.

Essentially any Ethernet MAC driver that calls phy_connect() in their 
.probe() routine would be doing this. bgmac.c is one such example, most, 
if not all of the time it deals with fixed-link PHYs because it is the 
Ethernet controller used with integrated switches, though occasionally 
there might an external PHY connected to it. There are certainly more 
examples.

> 
> Some examples that I just looked at where if your OS does not bring up
> the MAC the PHY is still UP
> - imx8m FEC with DP83867 PHY
> - KSZ9897S (ksz9447) switch/phy
> 
>>
>> The caveat with that approach is that it does not conserve power, and it
>> assumes that the network device will end-up being used shortly
>> thereafter, which is not a given.
> 
> agreed... it seems wrong from a power perspective to have those PHY's
> up. I recall not to many years ago when a Gbit PHY link cost 1W... and
> I think we are currently way worse than that for a 10Gbps PHY link.

Quite likely, yes.

> 
> Then again think of the case where you have a switch with ports
> unconfigured yet connected to a partner and all the LED's are lit up
> (giving the impression visually that the ports are up).
> 
>>
>> For LEDs, I would argue that if you care about having some sensible
>> feedback, the place where this belongs is the boot loader, because you
>> can address any kernel short comings there: lack of a kernel driver for
>> said PHY/MAC, network never being brought up, etc.
> 
> I agree that boot firmware can and perhaps should do this but often
> the PHY config that is done in the boot loader gets undone in the
> Linux PHY driver if the reset pin is exposed to the Linux or in some
> cases by soft reset done in the Linux PHY driver, or in other cases
> blatant re-configuration of LED's in the Linux PHY driver without
> using DT properties (intel-xway.c does this).

Unfortunately if you care about consistency or independence between the 
boot stages, you have to duplicate things a tiny bit, for the reasons I 
mentioned that while you might bring-up networking in u-boot, you may 
not in Linux, or vice versa.

It's all wonderful if you can come to an agreement as to what belongs to 
the boot loader configuration and what belongs to the OS configuration, 
but in practice there is quite a bit of overlap due to each one being 
somewhat independent. I don't think there is a hard and fast set of 
rules, because all of this is inherently PHY specific, but there should 
be some general consistency that applies, starting with LEDs. Best if 
you can just HW strap though...

> 
>>
>> For errata like EEE, it seems fine to address that at link up time.
> 
> one would think that makes sense as well but the case I just ran into
> was where a KSZ9897S switch had a network cable to a link partner and
> the link partner would 'flap' with its link giong up and down due to
> EEE errata until the KSZ9897S port was brought up which disabled EEE.
> In this specific case EEE could have been disabled in U-Boot but that
> would also require some changes as U-Boot does the same thing as Linux
> currently - it only configures PHY's that are active.

OK, but unfortunately I don't see how you can avoid not making those 
changes in u-boot.
-- 
Florian

