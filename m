Return-Path: <netdev+bounces-109456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6B928890
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340A8B2409D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF23148857;
	Fri,  5 Jul 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1altUN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944D143875
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181867; cv=none; b=NV6ykNoM1V91rymhVM+suoH6a3xDkiV546WM6iaPpljgsqJU9H31den0cfUjkh+C9qJ3u+UD6RrJ41xwimD0FCSRFOd4RK74OikUx8xTObO9AO5zb1ma4SI5QnxgxfWitjEOp9CtZtfJkjyrEk+G5BzUKIrb26Hx75zqDwQM5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181867; c=relaxed/simple;
	bh=/sgkHmGQdvkH8dJtnASU9XCTFzIyC5vfErwReBnR9sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPVFliepTCASU+YDqqjYydEFxtb8SgGhlZVLWubim8H9pVpddBJ1Jkcc+GbOk+nPZTnvZkw8HfkvSAMFcZcK5OvY9L9Q7OJg82JuIuZ0IuaE3YGaW5hgtVAe5OCV4HvOTMAaUc+c4nFWWgMQd6TRxunZqI0X9AD66cOGDzR+DUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1altUN1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea33671ffso1060035e87.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720181864; x=1720786664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1sm8VOXwAuzsn10aUKZEYYkzJgPGxsr4Ym/Y7pEiZw=;
        b=J1altUN1dvirq1TeVCjpyvWOllt525vri1WzZ3VW0ViYE0frsNNxYjGUlXg39vxJ5T
         v4dqrWlTDGaYN9bkfntHD0LQ5XrZcsDF62zyoJtLh+/hVkn97YntV33xGrfupGeea1+s
         GwFqW1JKs8ncfKJ7inzfBTKFXJeDVQ1DwNitym8bcxnxJkfDjHNSYIE0ev+UMJ2itQHA
         YBsMgQUMLSHHXXxmNWdQEUuABjebxdalMMQBFyDDR6yfH5amLgjYNhQcOkYN6yxIEH57
         deLD2HDp3qGbZU04IHjbejCbcLHOUDX9b/t5l/DDkx4FeWP9gywAG1usqLYQOdy2e5hu
         4Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720181864; x=1720786664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1sm8VOXwAuzsn10aUKZEYYkzJgPGxsr4Ym/Y7pEiZw=;
        b=mIuARXn07yq0Lpj1Sbs4pRbDfODz++V7jaDcKc4uTFvQqNHdIm7RXOrQxxGdp7vj6G
         Thn6EbzsTXBgI3FyflSnDJUAB33SDVonVvmU4Gjj07NmHyIdB5ifNJYDJshlLxE2sjqY
         K+ubZ/+Rj7kEXBrcuFMI4ejFzS+mtY0fUVoyeDIXRSTY9KuoD1J2NCIuwI1OCXgmBuO5
         AdI9OOKvatzZQ7dbnOojGa0BNNcOKxCde6hKKIxEuq/e9kdvLoSGi33z/fK0EsM59c1p
         AULoKkBRavKX0Jf2sd0xk433SDpyWMCzgvkODZtXEVzq5WkLRaPx1LewRG8xrt3zwI2E
         aH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1OvBfVmCcozcoxXNFBAC+XHWVIrCz+KxQD3rITgbCpo7Bs0YB6Q4pcvWEQl3qQmJEpsBklaBcg20jkv5H3cBQqZo6VfXj
X-Gm-Message-State: AOJu0YwDUE7yjlmscE/sF6Y/8c+z3IAgUdR/LW1wuOLaOr8TsuCY4sgR
	j3A+k3YpWrx/nhLvrf1+wHnOiAC0/TnodTCb40NVNoIHeJxgKJZ3
X-Google-Smtp-Source: AGHT+IHcaF1H/G4wVA0LzQTe+pND/S1BbsVRL+9uniYwbHhBpBi+uMHwWkPOO5qkxgoCvYbSRAIl2Q==
X-Received: by 2002:ac2:5289:0:b0:52c:e4cf:4f31 with SMTP id 2adb3069b0e04-52ea06e4cfemr3275595e87.49.1720181863653;
        Fri, 05 Jul 2024 05:17:43 -0700 (PDT)
Received: from mobilestation ([81.9.126.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea79de0cbsm122492e87.296.2024.07.05.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 05:17:43 -0700 (PDT)
Date: Fri, 5 Jul 2024 15:17:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
 <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>

On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
> > > > But if you aren't comfortable with such naming we can change the
> > > > macro to something like:
> > > > #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
> > > Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
> > > is a little better?
> > > 
> > Well, I don't have a strong opinion about that in this case.
> > Personally I prefer to have the shortest and still readable version.
> > It decreases the probability of the lines splitting in case of the
> > long-line statements or highly indented code. From that perspective
> > something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
> > the driver currently don't have such cases, we can use any of those
> > name. But it's better to be of such length so the code lines the name
> > is utilized in wouldn't exceed +80 chars.
> 
> Okay.
> 
> I added an indent before 0xXX and left three Spaces before the comment,
> 
> which uses huacai's MULTICHAN and doesn't exceed 80 chars.

I meant that it's better to have the length of the macro name so
!the code where it's utilized!
wouldn't exceed +80 chars. That's the criteria for the upper length
boundary I normally follow in such cases.

-Serge

