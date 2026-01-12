Return-Path: <netdev+bounces-249209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97ECD157FF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D00730006C6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1AA30FC1D;
	Mon, 12 Jan 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hueAJ1ct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A924A05D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254935; cv=none; b=o6/3Q1ETXxpwKaQ9Dyi5q6aOkivF+1uB7waocfEnVcqsxyOOWC6lTK4ATmm8r3uuHm87LZEvEidCoJGy0o9y8YTraZDy9WhJsKbZ9lOSXSoghJsBJUd1ut7ood2f7TCkAxL58Wq/Lj6JxE4NYolTIAYTCF3kMmBEjeOac9AYoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254935; c=relaxed/simple;
	bh=uq1j7/7lwZs97JC5UrHI7rl2H6armqzEJl+GArBu10E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoD2pkqQSz1qa7FH3RCKxgRZLDtg279Uqy+28SDLAS4cYBqRU/01OTVYsnOpDEPFkLX0DHdDJXvJm/lJIihudTEGt6N6Y2pjC0ruIdJA9nYoLQvE9J+MCEGqkStob2+o73jLtlkkzGec4Z7WRQk0nbI+/P/ds6toemxgT5fTyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hueAJ1ct; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11f3a10dcbbso6225013c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768254933; x=1768859733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFpZqya3J42tgEdzzL5HR/Y4eVhKBF1SwzqjTV+m+6o=;
        b=hueAJ1ctk7QBQjOiVF2ENuisvrDi2tucdE847wgyzXWv7kECSx94V/56qtzna/Dtu8
         e0Ku1Wc56no9ZDocmffMRhwFOM4Gq7xmKrmrocTpYfdF5d4swFxM6I7iy+0oLcxOFnAF
         zAdKQLCX1sHosrTJUjPmOXFY59t4yPRNDzLqWFCgEP57biI5hnjXNoMW2U5lt85nqAv3
         KdVqWLzKjE6IWi7XzXnpsaPV57xVdRIKd9Z9dZaeuXwoYK53+HguQOgdXHYwtzPQ4n58
         lViuOLmyJaXmgCwm5ElJgbvdPtNqN+Sc4hGkWyCpZ/rWLi8dobHNE4P4vj3vnO96vbjh
         LqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768254933; x=1768859733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFpZqya3J42tgEdzzL5HR/Y4eVhKBF1SwzqjTV+m+6o=;
        b=WOBsKX1pZTvGg7m5de1/72aGSkt4wOeMHiG10gcUZgd+T5aW5IQrCTKjpYcb3XI818
         ImokCIBA21gLZ29FbIioTjm96BY/VVqGXE1/zWcIHstiuHrJNLo9c0makfQyfmONI96V
         X4+x0XAwJzO7xpasvrm3FwCHv2engRfWTocb0pb5pM7JboPUkFJ72ROLGOEeEPagRj+4
         ZV6/QajtqZsFDgZRRDR98148OgKTojGovxdtioAq6XVIK9/fw6iMNKF1/PHoh/wlzmwd
         toFkDGHiGK0prj89nVRsDaRxw29vRbpHvl2G08TnTrsOwT4fLm44O3ulVAnCebMly+ZJ
         yPpw==
X-Gm-Message-State: AOJu0Yy8UsgLw9FBPaOEj3I9Bz7+kVwEEKDrzoSNUnDJCVWLdLVXN7hm
	miq25SYzlBpJ4urixNsrBzLCSkQ+D8L5CVLMfcdoLBLF98Jfy7FSZcLaaU1Y+z39
X-Gm-Gg: AY/fxX5/6/VnyFoG5YKVuQzw+bBxAjd5yKqeWoECT9LVJ3Au3cChjKVUUCkAhj7EkPp
	oQOx4HH9qYSRnQ+0JhCEKNwZOVyxI/QcD+94zj3Y5trasyVjLGZY4DVyMU5tj14OwBrcjXP4dt8
	E6eozJlJmDBf9tmtpdJFuW28WzdJyN6Ga1OE3A3du+nAXSN5AUMvSDjYqeNiBWD2kEoxQ89O7gO
	o0xhjLvoPpqnZREffoqtysEhtLGGoc1AclHcTXdLFcUHkUS7ISF7ugfWzHS5w+FLQ4Agl6bey3U
	ao5BT+7fgcRiPqtxMHsNM2NTWadjP6pwxlNGOIpkGrFSZUkJs+m0sR0mSPsgd9DIbYFKyWBwJIC
	8z7M5kyyUB3Yao8VRMzRiv3E1GO2mttm1OKiRqsVjqnXwTkoJ0c6av5ZAjJ93R+Ly6DmrVm/2Pb
	Q+SIZ+38vvp311xUDNB507zqMRlDS+LPife1WawFcDsHrLE0Sg7BLHsTKhNKpn/IQ=
X-Google-Smtp-Source: AGHT+IFPRbvT8dlimBYDAExBs325W6HsGqVK3JPrirCAaX0G1XFg5OER8Bg2zcDIzw72720a3zTMkw==
X-Received: by 2002:a05:7022:43a0:b0:119:e569:f609 with SMTP id a92af1059eb24-121f8afbcfemr16271974c88.2.1768254933015;
        Mon, 12 Jan 2026 13:55:33 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:f38f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24346b5sm26632057c88.3.2026.01.12.13.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 13:55:32 -0800 (PST)
Message-ID: <318477a7-8bbf-4300-a44a-deefe4a40758@gmail.com>
Date: Mon, 12 Jan 2026 13:55:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V0.5 0/5] eth: fbnic: Update IPC mailbox support
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us, pabeni@redhat.com,
 sanman.p211993@gmail.com
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Update IPC mailbox support for fbnic to cater for several changes.
> 
> Mohsin Bashir (5):
>    eth: fbnic: Use GFP_KERNEL to allocting mbx pages
>    eth: fbnic: Allocate all pages for RX mailbox
>    eth: fbnic: Reuse RX mailbox pages
>    eth: fbnic: Remove retry support
>    eth: fbnic: Update RX mbox timeout value


The version information in the patches is leftover from internal. Please 
ignore the version information. This is V1 of this series.

