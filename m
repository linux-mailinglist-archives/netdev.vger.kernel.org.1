Return-Path: <netdev+bounces-200784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233AAE6E5D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21225A74BF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845732EA47E;
	Tue, 24 Jun 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="A5HigzZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674D2E9EC0
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788603; cv=none; b=fPdtRoYPUbD0ibih87ezDf7Rkjnqi5z5zPmf2hPnhoJTGYmuQm0z0mET7z2bZqYLXG+JTT1TxWYdivJXOLICVzfRWDGvDm7e9NmAk1GUPHJLAjit2CJakB7TYKB2x8pHNM+ZDp80nAZ0XWEygTwnvL7nx3YAGqRZgqAwZG3dE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788603; c=relaxed/simple;
	bh=xPtkWNTb5m1aO+RnY3aiBGgtdd4ECCu0lY9ZeNJslVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYhDoLES9Xo5Rv7uOlWnTid3IORSUsnwl34er8DKtQg+9MZSR4jEnR4cC0E06g17sIINz9vsuimJfHENICLlU31aYhU2c4BvwylKUvS3Axn6KFuHjHXp5Ggx23wuwSaEwTq08etbcxnOTQ0w6rgDDrqtK61Drzmhc7vh3EeDsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=A5HigzZz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso1490300a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750788599; x=1751393399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nflvs2sdRBJfx56+IwyO1LWAC9asffyxrOtp6qhe+Hw=;
        b=A5HigzZzlTW8GJ46sgb7zzHbMfY3hV4eH2Y6FuKz01wU8e4affV9XL0tFdXNuUYJLl
         YbjUnAA2i8QdudSZBoSCfiWAdM4onI2HtP822/VvHnvkDjPnAdZpqK63EZRtebpu0ZBx
         54c0vwCseh3YuclR+/befBqGn+uh+EOnBhGBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788599; x=1751393399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nflvs2sdRBJfx56+IwyO1LWAC9asffyxrOtp6qhe+Hw=;
        b=MUbFnB6HZTQ/f8BXstf6rN4+adn9S4615qJO6y7eF+cRYPvFWY7x802l5fJiY67FPr
         H5pfdhjALfxtqtC7uN1n8BrNc+WbK1b4R7ChhuSYZAVl7qntyzXNL2enM8TMcDvTfLeK
         vL9oz5/6lWNn7IeH+D4gsfi41vUEMVK+i5+Z2MYs/X2kN1GtiODsuU3Bhn73v4pPFH4y
         63Vyemehea/vYtIEUZHE6vYwrW3kw2xSWzxZqjSIUH5J/7Hc7o+YHEF7rG9bAZhMkML4
         BB2C3Il5JgROOIFe9JTDvHDm+qUQ+n3VWScKPC+Yv/+EWrp9+chCGyce6TbjkIMnhup5
         ClsQ==
X-Gm-Message-State: AOJu0YyESPcclowq8njNTzNUP9i5bHY50L32UPrdwpJ0nyW6M/AYMFlb
	nSARv07QUjxDNcyHGBlBIfiBNyBshcX7uW46wij7VRwTODI9pPgtBQFv7R6ligMKswI=
X-Gm-Gg: ASbGnctpV9ZFjwERbYrR9kPSJ4z1FAz3SQUx5kR5MshInxnqjCounPFgRC4Pyzk8Ft7
	6guW9tqWSvqg7un69RF8YcwXO0LWkTopdnK0q3fIATmCIvr8MflSLsZ+kV4vAIVz5ynPCF6zX/R
	dZ8Q0tZh6bH5jWtd+BC0CNv8tslCuLPJlucLU2Jt2h8k4ShzBPJcUt/pZDcH0YN46aOHuZ9oJtO
	DWqR0v4rJriZEmWdZ60RTyCmJ47cG/8WAPlSZcLbaqXPKRB8hkUqSItIu/dxr2By/GvueqfgVnK
	+wBYAwltpS4UOfbTiC+uzK6OU8s8QQxy9RADC9jQNAn1rMEjemxPAZEfR9W7zLHwvGlAyTY=
X-Google-Smtp-Source: AGHT+IHGV2CGHqVXxvWQBoECn/St+l/2gPj8/qo8RZDk3XQOtf2KeH6f/V/8mHerOF1P0VbmfGeo6A==
X-Received: by 2002:a05:6402:350a:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-60a1d1a2dffmr16643388a12.33.1750788599551;
        Tue, 24 Jun 2025 11:09:59 -0700 (PDT)
Received: from cabron.k.g ([212.105.158.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b043dsm1356174a12.29.2025.06.24.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:09:59 -0700 (PDT)
Date: Tue, 24 Jun 2025 21:09:58 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc: netdev@vger.kernel.org, David.Legoff@silabs.com
Subject: Re: wfx200 weird out-of-range power supply issue
Message-ID: <20250624180958.GC9115@cabron.k.g>
References: <20250605134034.GD1779@bender.k.g>
 <2328647.iZASKD2KPV@nb0018864>
 <20250606140143.GA3800@carbon.k.g>
 <3711319.R56niFO833@nb0018864>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3711319.R56niFO833@nb0018864>

On 25-06-06 16:42:42, Jérôme Pouiller wrote:
> 
> Things are going to start to become fun. Your wf200-v6.6.pds is exactly the
> same (same md5sum) than the one I use for ages. So the issue is not on this
> side.
> 
> For info, I have a setup with kernel 6.1 + firmware 3.16.0 + Raspberry Pi
> here.
> 
> Do you think your power supply could be unstable with your new DT? 

Yes, this turned out to be the case.  Now the chip appears to be powered up and i
get nice and very promising:

[   33.960683] wfx-spi spi0.0: started firmware 3.17.0 "WF200_ASIC_WFM_(Jenkins)_FW3.17.0" (API: 3.12, keyset: C0, caps: 0x00000000)                                               
[   33.991401] wfx-spi spi0.0: sending configuration file wfx/wf200.pds                                                                                                            
[   34.006885] wfx-spi spi0.0: enable 'quiescent' power mode with wakeup GPIO and PDS file wfx/wf200.pds
[   34.007212] wfx-spi spi0.0: MAC address 0: 84:fd:27:71:72:f7                          
[   34.011703] wfx-spi spi0.0: MAC address 1: 84:fd:27:71:72:f8
[   34.045198] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'

However, when i do "ip link set dev wlan0 up" i get:

[  118.481024] wfx-spi spi0.0: timeout while wake up chip             
[  118.501051] wfx-spi spi0.0: timeout while wake up chip        
[  118.521142] wfx-spi spi0.0: timeout while wake up chip            
[  118.541059] wfx-spi spi0.0: max wake-up retries reached   

Could this be an issue with:

"enable 'quiescent' power mode with wakeup GPIO and PDS file wfx/wf200.pds"

from the kernel log?


thanks,
Petko

