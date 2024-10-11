Return-Path: <netdev+bounces-134456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9649999A3D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 04:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7BB23752
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69B1EBA12;
	Fri, 11 Oct 2024 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q76UtA3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C41F4FBB;
	Fri, 11 Oct 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612909; cv=none; b=ltyrEPnC+EgpY3CaK7jQd1F/Dk334KK9RmrserbI14TgCL1EzLT1brnmr6t1QlorzI2iybKD5u5nVSOwVmbCG4TS+k22juoApCk2KtjSLFZ9IvinUsokraH4tVo19tI7wW9z7zMBSTpzN+VaQoKhEVql/6M0lyqC4nqj4dbm8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612909; c=relaxed/simple;
	bh=afqQyJJRGa9Py7JgDpniv4pH0blwhuSvGDb4ahRaPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POtYJWp5e3G93w+Y1dH3gSjLrDWi7m6P2RxRfEwUMkezzGcO0Hh0JLUegUQu4VNsZTIjkJN1+y1W++ckGG+ay5pI3pA24/ZrIo/r8t5bfVm4dTBgpWUQUHN7r+QCfKGOXDddE1ArCyHe0vHbC96HOHV+nuH/2GEY1P7COE9g/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q76UtA3K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so9208b3a.0;
        Thu, 10 Oct 2024 19:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612908; x=1729217708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afqQyJJRGa9Py7JgDpniv4pH0blwhuSvGDb4ahRaPxw=;
        b=Q76UtA3KF2lymPO3o+1fM15rU25yb9DMTQh+QPPZmt5ntOPu391PjRcBm0+JZ/il15
         NRn35rFoJLn+epsmU43YNBhHKfmJuKYGj6ESQLtsZ/2ThW4UqD6WO7uMeIEKidypcDC0
         wWfZCTh2oryf5VOHk0qzv84gXi5LHeUwj5gvXk6AHQ/NEOYJ6eAGu0OSiSPe8fUiYT7R
         +hLF6AeanreGS2hrzo02fave6eMtUD0A3KVuOXJVJEdl3l5QfyxgAku/rd7n8RpK40bH
         vZloY4F2zpYyxjs6QZuQ84EFRMO+3ZIOsRSuL1LaEE8HyacqktmE6WlaTTUd+k9hFzwo
         +i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612908; x=1729217708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afqQyJJRGa9Py7JgDpniv4pH0blwhuSvGDb4ahRaPxw=;
        b=R/+7fTam8VBcMSGY+47CWZpRtuKQ1cHBTA5ivOvMSn2knjBY8Vcz7mHPn1Za9uVHtZ
         8+U9nbVBnHnlcHcd49+blXbCWXurbJDMYw9E5DPj8e/QMyoiR6oFfrJPRy4Nj4P3xfx7
         N37m0ejqAwHnfH9LOcXbXYEAkkl/0KFy8AcgQaVzXob7mKz9GhrxGcYuIDmwG9Fh5SU8
         YS1KG9oFxb0WOum2xymCOHNqc0QoCGGtZBYSwUMGI5hKUC+7nxnn96QzaLJe3f8mg1wv
         1zfmxiv8TUv+AeIerIFzR3okUllqgZVaGWcjXMSiwdAz7URhLODoFCZSbzz7/r6gMWEN
         C6lw==
X-Forwarded-Encrypted: i=1; AJvYcCXj2Xk4XMmzP4ZAVv7dCewFPAwMtezrgU4Y2sliWQw69TdHkTnmQMgiaDz4YovciTAuie8jAtp4z/Kp//U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrYdqu7TJ2TwsVScU6XutMNCNxKXs7EudEU7LymPOJ/bauYtC
	VllanLuzJrCv3upL3NXKXf6eCL46kbJCHTdopLNPhywXP9F52Q6t
X-Google-Smtp-Source: AGHT+IF7F43rjuoSrxjiEloA6/Y0ZsI80N0Wn656yLobEBvQmz/dF90W0nINukyfO7XXZFPkesOb9g==
X-Received: by 2002:a05:6a00:4f95:b0:71e:21:d2da with SMTP id d2e1a72fcca58-71e38083ec2mr1837618b3a.27.1728612907510;
        Thu, 10 Oct 2024 19:15:07 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e368932aesm524003b3a.91.2024.10.10.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:15:07 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:14:55 +0800
From: Furong Xu <0x1207@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Message-ID: <20241011101455.00006b35@gmail.com>
In-Reply-To: <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
	<601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 19:53:39 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:

> Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
> when calling page_pool_create()?
> Does it only need dma sync for some cases and not need dma sync for other
> cases? if so, why not do the dma sync in the driver instead?

The answer is in this commit:
https://git.kernel.org/netdev/net/c/5546da79e6cc

