Return-Path: <netdev+bounces-134487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D0999CBD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BE6B224CB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A320A5FF;
	Fri, 11 Oct 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihyLHtcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8441FCC75;
	Fri, 11 Oct 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628329; cv=none; b=XUzgWcJw9eVUohRzsWBOPcdPy3cpOV5aw0I3HQpsOTdOlucl7ogCGHHIfD+V8xMJJzJyCr+6vT6Ymg5xF0omlqrlOJAp+Vz5l/+eibKI0r9dxjjZbqjB5U/jHZpBEXe3R3AQvDZGqPukD6t6CBx8ffl0AVMbomeYnxzRewTD+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628329; c=relaxed/simple;
	bh=13dCV3kWAAYPx5fa33hRGiCLH9dgqHe0//VTY9onCuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf1kn5D/6aeAAOr+DiiQMMYtI/N5FMVyuxiPyEdKPU+W5F/HjjydU7BtBhXN8Alp3ukPoq0yj4erYpGmpWTE8qD+zh792UDirwtrANfhcLObPUjS0qAQQaUgQ1ty0drIIRc0RA2qM1KROhV6JfDNMGtCSemafIv0IbZ0dMPO7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihyLHtcZ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e3dfc24a80so1075658b6e.2;
        Thu, 10 Oct 2024 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628326; x=1729233126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4XqDMH4pZzArH3MjM6e77LuXKEUbkAL8eknF5yWjS8=;
        b=ihyLHtcZiUKlB9QdigWS9K0dQC62Y/O7YaaqUMaBAv2YJ+TB8JEuutGrX1VY6AuMzV
         5G+abctJL0obs4T957pg3sgqItAP8Lqy+yghksCJnjCdUA1sBR55vX9dwsxc5YNk655I
         RGT6ntPVaJdaw8m7iqKhX+CFTAJytgRuy2XG/yuzMelaYzh3gDMZ/x7dTpgM71q9RFfw
         wobeFL21YxxV6xWe8+SL0XidT7JLKXve4ilgV615gV8lCRSwUQebc+L9RXwDZyZh3E7w
         SY4MguhFSIl/mNPFhrFVIvO2J901WXTkH38pSNa7MAgeJ49AfbrMXSYSuOaLSTYQxEs8
         FK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628326; x=1729233126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4XqDMH4pZzArH3MjM6e77LuXKEUbkAL8eknF5yWjS8=;
        b=ONOS5P1awDi5pvzS/CiS3L/JwKM21NxLU+k6PbrLeqxVZERTJwEVTCh36lE6Q02V8m
         L0YrHuyotIRXwFSy/v6l8HAHPF5fuaEmDorSj/UB1tZY1BMLUC1ghEcwfVgqWixFxtZK
         TvPLCwyymJThVmSNpVzbzwOZL9928AuScyuGYdfpZgNiDvdo/Wdb1M34zWnAKEsTrlh4
         8IO4mRf+FxD2uTI3iLLspnq+O63DBZVSHsDSKZXEWWfsKB3qYtQ4hAMD76eDc4HNTLeT
         0bGr1AjWpDvS5c4Q4sGXMPP4FRiQRulykX5I4LSpS8iRUmupr30leP5EkG+5fgg+AuWi
         44mw==
X-Forwarded-Encrypted: i=1; AJvYcCXjB8+sADZUOp+Ovo1IbCUtk31SspXFFwxLezzEFjq4Cz5l4FBMbCUahnCaNGkeHwJLDcrwfdTwDZ4cwoI=@vger.kernel.org, AJvYcCXkRFrkHEMua9oeW0WiIQMISgK2/L/TGDnVQdNU52WXq7hn0sGxF3Yt8QYeSjQv/yWWiTVgPUjN@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeiodCr/gEXrypi7Vr1UypCdaKuqdfjdpBY3/dkjnIGRfHy7q
	t72DcKNkwe9pxniJjaN9UzASZGQ7JQ4LTcLVXyaylU/AHNZSuO5C
X-Google-Smtp-Source: AGHT+IHApRESLPacUyw6ARMFxeD+8+Myu2m3IOu4bGEFE6CDC5bPOhwCrGsxjsKZdWzx9x5vUwFAkw==
X-Received: by 2002:a05:6808:210a:b0:3e0:4076:183b with SMTP id 5614622812f47-3e5c9119695mr1291478b6e.32.1728628326453;
        Thu, 10 Oct 2024 23:32:06 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5419sm2007668b3a.50.2024.10.10.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:32:06 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:31:58 +0800
From: Furong Xu <0x1207@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241011143158.00002eca@gmail.com>
In-Reply-To: <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
	<20241011101455.00006b35@gmail.com>
	<CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ilias,

On Fri, 11 Oct 2024 08:06:04 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Furong,
> 
> On Fri, 11 Oct 2024 at 05:15, Furong Xu <0x1207@gmail.com> wrote:
> >
> > On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >  
> > > Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
> > > when calling page_pool_create()?
> > > Does it only need dma sync for some cases and not need dma sync for other
> > > cases? if so, why not do the dma sync in the driver instead?  
> >
> > The answer is in this commit:
> > https://git.kernel.org/netdev/net/c/5546da79e6cc  
> 
> I am not sure I am following. Where does the stmmac driver call a sync
> with len 0?
For now, only drivers/net/ethernet/freescale/fec_main.c does.
And stmmac driver does not yet, but I will send another patch to make it call sync with
len 0. This is a proper fix as Jakub Kicinski suggested.

