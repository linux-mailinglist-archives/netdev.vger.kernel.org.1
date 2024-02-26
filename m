Return-Path: <netdev+bounces-74989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416C867A90
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75BC1C28D28
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7912BF05;
	Mon, 26 Feb 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ib8A4GsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97812B140
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962240; cv=none; b=qVp33Bs8nfnrhw9yt0327nXZQ8xnq2u7m82EQP/pX6atrlMWLIMa0uS88fAHiRyY3xQ84iCRdSiW/eZHmw7s5Hqa9sjbXoRAUcgsW1BZKMG62WlzTRPN9cCZkWp/q1qfa0k4A+giMeO0sUYlwdbiaTOdQbILJJcVyxOnJlWLW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962240; c=relaxed/simple;
	bh=2wyf2ujb08m8GhazXh3Gyxy718s5Mv9dJyv60Q7wujU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw7h12zayHYac9TftQOYMRYxBswQJWgl/txjcdTNrsSRVBslBsjSvU7Hw6YruJSCvssvjaTSt24P9T3Zt6RTq6/qT0+MY2QU5CDhbJpPKfMr6NNw3Bg+JvnOPcNmUP3iearZfsOrSmDI+zNqPOYho6NqWFeaP58Yi12Q5Ptry/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ib8A4GsB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a4055897so9939835e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708962236; x=1709567036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvYdJ2bX5RdvpWqE29LP7ldFuj3uxxQcDnVOS9BvGUM=;
        b=ib8A4GsBiqQLqYS/ehmOBluq139i2a+2RkThpYyph6LFfdWpuDoWiO+072rWRIdqtN
         Yx2YrJKCGrDtIUhxlt1eb1etUIMHCvzYO0RYy0aO1gdw/FfR4a9/LGT6l6WYRkZERDSp
         qngNOvAg071CnAOREV2KgOvNWIV6M63p2ulOns7w03yo+V0HTghTDcNpt+3qXfA3ZDDV
         O2oGUOCYGQpLbjeQps0iFrYwUbBN+ILhK368ktAYZmL1EgVFkYma6PtM73FmOrl44RW9
         IsVOEDX5ZHnSuLluJDwgjRouB30ydUaLP0BOX/pkbbpvAICdpoBenfJ8Uz/vfC1VCbkN
         tQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962236; x=1709567036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvYdJ2bX5RdvpWqE29LP7ldFuj3uxxQcDnVOS9BvGUM=;
        b=nxBb8VpXfu3sHLDvn0FmBz0PDRtUSyVgCpD6HPgUozHZw3usu43p5l5GPXQUqc1M1x
         88/9BvD8G/qZ26rgCIc44A0CoLW2WUurwSeVtybX9cGrtNH+i6zrF+vUmphx02Uxpszj
         t/s/lnFx5zXkN39poZJkD3d0NOcRACzh/Dc3uSzOWPeRb1FRw8qA2E0ZLLPndWkwiVNz
         R2mSpl4ttbyYrXCz9brfpasyPt1EHvSO3Esm2Kx+bjdgfvhdnmMYL23wACYsUdNuXUCx
         nBlvfM8TJ34nHp00YPRyAMWroDK9AA6zqYoZ6w+6JqBMipDVY40lvcVpHfovRoP3DRC3
         GF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWtZkeMhh6g0r2BvM83ZmtdA9K9mukJgHpzaH14NHqf744wkXqYs9+0iEqUObReFwvueDpPoICog0zYtok20CmFyJO5TVT
X-Gm-Message-State: AOJu0YxfjYhaDgvQatWyz2IaAlnLCFJMkHWVpxSHA03bMWe9RKKKV0Lo
	rR+xSKKcnE1N24ETfRP7qTKR6oU3Teb3Kd4iMiCWO7tNOaU3qQNvCWKqVrSR4Ow=
X-Google-Smtp-Source: AGHT+IFhLwI5PSlJ0OM2xL/E+xxgK4oP1sElYrCNx5Enleue6GFv0SvYJepL5iZYrAujYqejlWV7jg==
X-Received: by 2002:a05:600c:3ba3:b0:412:11ad:b891 with SMTP id n35-20020a05600c3ba300b0041211adb891mr4787527wms.6.1708962236419;
        Mon, 26 Feb 2024 07:43:56 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b004129018510esm12410716wmr.22.2024.02.26.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:43:55 -0800 (PST)
Date: Mon, 26 Feb 2024 16:43:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bnxt_en: fix accessing vnic_info before
 allocating it
Message-ID: <ZdyxuDFY9_LpXr89@nanopsycho>
References: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226144911.1297336-1-aleksander.lobakin@intel.com>

Mon, Feb 26, 2024 at 03:49:11PM CET, aleksander.lobakin@intel.com wrote:
>bnxt_alloc_mem() dereferences ::vnic_info in the variable declaration
>block, but allocates it much later. As a result, the following crash
>happens on my setup:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000090
> fbcon: Taking over console
> #PF: supervisor write access in kernel mode
> #PF: error_code (0x0002) - not-present page
> PGD 12f382067 P4D 0
> Oops: 8002 [#1] PREEMPT SMP NOPTI
> CPU: 47 PID: 2516 Comm: NetworkManager Not tainted 6.8.0-rc5-libeth+ #49
> Hardware name: Intel Corporation M50CYP2SBSTD/M58CYP2SBSTD, BIOS SE5C620.86B.01.01.0088.2305172341 05/17/2023
> RIP: 0010:bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
> Code: 81 c8 48 83 c8 08 31 c9 e9 d7 fe ff ff c7 44 24 Oc 00 00 00 00 49 89 d5 e9 2d fe ff ff 41 89 c6 e9 88 00 00 00 48 8b 44 24 50 <80> 88 90 00 00 00 Od 8b 43 74 a8 02 75 1e f6 83 14 02 00 00 80 74
> RSP: 0018:ff3f25580f3432c8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ff15a5cfc45249e0 RCX: 0000002079777000
> RDX: ff15a5dfb9767000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ff15a5dfb9777000 R11: ffffff8000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000020 R15: ff15a5cfce34f540
> FS:  000007fb9a160500(0000) GS:ff15a5dfbefc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CRO: 0000000080050033
> CR2: 0000000000000090 CR3: 0000000109efc00Z CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DRZ: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
> Call Trace:
> <TASK>
> ? __die_body+0x68/0xb0
> ? page_fault_oops+0x3a6/0x400
> ? exc_page_fault+0x7a/0x1b0
> ? asm_exc_page_fault+0x26/8x30
> ? bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
> ? bnxt_alloc_mem+0x1389/8x1918 [bnxt_en]
> _bnxt_open_nic+0x198/0xa50 [bnxt_en]
> ? bnxt_hurm_if_change+0x287/0x3d0 [bnxt_en]
> bnxt_open+0xeb/0x1b0 [bnxt_en]
> _dev_open+0x12e/0x1f0
> _dev_change_flags+0xb0/0x200
> dev_change_flags+0x25/0x60
> do_setlink+0x463/0x1260
> ? sock_def_readable+0x14/0xc0
> ? rtnl_getlink+0x4b9/0x590
> ? _nla_validate_parse+0x91/0xfa0
> rtnl_newlink+0xbac/0xe40
> <...>
>
>Don't create a variable and dereference the first array member directly
>since it's used only once in the code.
>
>Fixes: ef4ee64e9990 ("bnxt_en: Define BNXT_VNIC_DEFAULT for the default vnic index")

Nice example how things may go off when patch is doing multiple things
at once :)


>Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

