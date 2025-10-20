Return-Path: <netdev+bounces-230955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D267BF2623
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3BE4E3B2E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9F283FD9;
	Mon, 20 Oct 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADQoFust"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769526B77B
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977417; cv=none; b=doSE7U9djxGHr94GoVP4c1d4LzG8ZbZWqddJhdFy8xBne5amAUeglHnDVByiR7pSr+Yq70+dlfy5hgPc2wmWYR/RCl6pXdQyj82u9V5k+xRkMNyb6GfliI8AAq9szpsFWpoqayMa2xJS1zHqysDrbpuIxE5YOJs3rnHIi8wk6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977417; c=relaxed/simple;
	bh=JhybXE7R11FfldinfG02n4nm7gpPTPzG49BibXV0xGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo96NsxDPVEySLSKqJwcOj8Jbwyu2rv6AL5ehFp9Ei53dPV7/FdPosXv603lRXoOK3haX0xtpIyrqBMG8Y67h2ahBMM6b3SwPMFG+Gpt6rg6JCjS4wnuEPKREzguvjEwaXHSDcgJp868z88nhcC0uGuZ8czPU5K6X2qOW7NpUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADQoFust; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36639c30bb7so40353471fa.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977414; x=1761582214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LPzc0R6LMpiWe8eMNmrj2awjMOaGK9U57/pCxBYSG0=;
        b=ADQoFustomFtocHdVdTfI1p/t5hXbXj2GFrinPqsE2fvvJqRh7CjotmmMPc1Oeif36
         kR6xXsgudObNn71Xfz4Gzoat6LDoQHGdjkVAo9oAseUQlGHCxaFu7HCaJP1GG89y7n4b
         HiMZdGolsNRUrnumnx1HVYo01/tWnYH5Ul+ZzJ9+z+KalYxy6Dz4IolPSto2fx6XLdsR
         +P0RVIDUwl3fxIz5HjfFTuIAz6Ri2DOQqrKrwV7kwk3pL2yBwKtjRAhMtlT9T6BSn09G
         u4M7TVPJpkKma/uU2I9nhGb9yABsU5XELxLEFJPG+QpDvkv9cc/RvORFyv5TpfimqwlZ
         nU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977414; x=1761582214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LPzc0R6LMpiWe8eMNmrj2awjMOaGK9U57/pCxBYSG0=;
        b=w20gxLoG7gilYaU47r9rIOdXa6g8R8v84bSRtAOUwlDaYYZreWSQXRIBplFKFZyzHF
         K9g7OfwHdaSxkj68GjafTPAd14cYOPLFglfAu//YyIu3+TEUtWOBml8Z+KN73P6+HdoC
         p+nhTfEMWZZq7myW8U25rG7IhDUHup8y4MvsWMhk0R+IYg9JAyWllJkcMmYLjQ2pA3SF
         yf+5+HINeubgUxPQqWQPXzG9J5LyIm+9EtlRkre9qK474CDo/na0tpxTxc4V2ERGQSfu
         yqnW0GAVHrN1KWYR6grZMTYOAV3H1IppErFeboODV5lB5lAiItBJHIwIS/04VZ20UTcu
         n4UA==
X-Forwarded-Encrypted: i=1; AJvYcCW6FCA0wpc+fatCTjs9Orrs+ysOrBOUxWSgN1ViloBkHcw1TuuA27b/igP8oHdd6YGuHMuO5O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhW2gMX3LP+qqHQ6/Kb9KK+OV49mSRr52Y0ie3wVMyit4PoPil
	bUT2kNzO0r3wKYbJKc1a4O3U4AFa6yMt8XDs+M+nQn38gvitpX5DwZKUWOEvWw==
X-Gm-Gg: ASbGncsAx5TO+eQFRNIEJAVMhzeJsmIpxB8iGXzDL58o1fwgxSVQe/89BsYRsnGK8pU
	fMiBMkXDVkD1aowDofzqjE6jabrdghDvjDcOa8V29mqFzFS7Qfd5ZqT8SqnpHpWyK1iPfjNlJEc
	+rVOfJ4dKwH/8KggbGvjJ45M6wVJNxmk3/uHJCf/5RYniRNWAZJ8nVKRxpb/j8lA9jKLaz34BE7
	GEFQ+EprS1gZwKZYMY0JmReDLobrC5yLfOcDC8p7Z3IutCQ/6V140NQkV6fdv3hhoNjyQ7Jbg9J
	dndBLqWkGD69iCgKTn23Dx47sTFWc3iXGnG1vm+3ikGvFMdAHbzcPHMf9OCivIwpNWNN3iFBZzM
	nYVnXL0H5eJ2HVez1Xv6CUsw/UShHYvYmY8lqI7YgFz1EjbHGowR/pR1chheNH7noAl0P//Me9m
	FKUOyQxtv/JsHDWl0tznEFW7X6DuE=
X-Google-Smtp-Source: AGHT+IFl1QPDX6Ojn5Td2m0DZOehjJbEt94UzdPkTL0dqFsYL/3PF17ph4lGeiIlQ5KrtBb3EJb94A==
X-Received: by 2002:a2e:9a0c:0:b0:351:786c:e533 with SMTP id 38308e7fff4ca-377978ab86cmr42134981fa.15.1760977413859;
        Mon, 20 Oct 2025 09:23:33 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91f5a3dsm23228331fa.19.2025.10.20.09.23.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Oct 2025 09:23:33 -0700 (PDT)
Date: Mon, 20 Oct 2025 18:23:27 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device
 driver for config selection
Message-ID: <20251020182327.0dd8958a.michal.pecio@gmail.com>
In-Reply-To: <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
	<20251017024229.1959295-1-yicongsrfy@163.com>
	<db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
	<20251017191511.6dd841e9.michal.pecio@gmail.com>
	<bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
	<20251018172156.69e93897.michal.pecio@gmail.com>
	<6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
	<20251018175618.148d4e59.michal.pecio@gmail.com>
	<e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 11:56:50 -0400, Alan Stern wrote:
> On Sat, Oct 18, 2025 at 05:56:18PM +0200, Michal Pecio wrote:
> > On Sat, 18 Oct 2025 11:36:11 -0400, Alan Stern wrote:  
> > > How are prefer_vendor() and usb_driver_preferred() supposed to know 
> > > which configuration is being considered?  
> > 
> > Currently they don't need to know, but this could be added by passing
> > a temporary struct with more stuff in place of udev.
> > 
> > Really, this whole usb_drv->preferred business could be a simple
> > boolean flag, if not for r8152 needing to issue control transfers to
> > the chip to find whether it supports at all.
> > 
> > It seems that ax88179_preferred() could simply always return true.  
> 
> Instead of all this preferred() stuff, why not have the ax88179 driver's 
> probe routine check for a different configuration with a vendor-specific 
> interface?  If that other config is present and the chip is the right 
> type then you can call usb_driver_set_configuration() -- this is exactly 
> what it's meant for.

That could be doable and some code could be shared I guess, but how to
get the probe() routine to run in the first place?

The chip may be in other configuration, without this vendor interface.
If we remove _AND_INTERFACE_INFO, it's still a problem that cdc_ether
may already be bound to the CDC interface in CDC config.

Registering a *device* driver plows through such obstacles, because
core allows device drivers to immediately displace existing drivers.


It seems that this could work, if cdc_ether blacklisting and revert
of _AND_INTERFACE_INFO are applied as suggested in this series.
(But as part of the main commit, to avoid transient regressions).

I wonder if blacklisting is considered necessary evil? Without it, it's
possible that cdc_ether binds for a moment before it's kicked out by
the vendor driver. Looks weird in dmesg, at the very least.

FWIW, my RTL8153 is blacklisted in cdc_ether too. So much for the
promise that cfgselectors will allow users to choose drivers ;)

Regards,
Michal

