Return-Path: <netdev+bounces-121060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26895B86A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1F0287917
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EB1CB329;
	Thu, 22 Aug 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rUYWvbW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769621CB136
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337073; cv=none; b=tTBgqL49nswDmJgdBHHUHccjt3/SOVLf7gfoMg/r42lhi7Opmnm/fpQN4+5UruDQkxgD6/EQWO8Ekgu+W7rQMSjfkznTTz2YYXdXhqcMoei0YVDA8b2TP3SDDTgPAVIZGIeAggOXdyRsO8GMlOIko0748KKtVkF87QTJleuy5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337073; c=relaxed/simple;
	bh=3SGAXZaH/rE1WvEbCj6idIpnocFm5xheRuEI63yXlBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nubEXn3aP4cp4Gw7SwE+j4IiYGCW0L4mVDAHCXd7dW+MFwLSBROQ2uTJLx7QsiZD/8fuX8VkAj14p02J5cSJf8GC1cTCwuka0OHqKKtnC99893NhVF9PqN2XeFh3FWhdE3M65fcB0xgvixAfFMbcW7IDfQQ2I+K8vOykyU01U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rUYWvbW+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86910caf9cso130958866b.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724337070; x=1724941870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZKLbEyZ9gHbIbuvLacizSv9GBt5s4tjqSEPtMXh11E=;
        b=rUYWvbW++de3NPDWxWFjabnqhgihrAxzIw8uwI2J9ocx6QZrZGjkGOBp/7PWvdpuyl
         WU67rusazfLTlJCWOqdgObCj38B1Q2RjhSopkrcTyV95yXPicYBUKVTeeraELTTlH4Va
         pREq9CAhyot7yhWxau4aJCyNgFCod9Y7MVPKcmU4tHcUxe0VyP7XH4mR0MbI+aQ8c2qs
         1oDUuvqYP1huok5+xhITLXoI3l8GiYnJepbxXHnT0jB5gEPijSs+UNdDyGatYvfM64V+
         eMaqa/3R0AxIpcLU5LZ4mhxtwwEa/KbHab+Ad3AgZgTzSzNlpjawL0x+VrrDWHg/A43A
         SrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337070; x=1724941870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZKLbEyZ9gHbIbuvLacizSv9GBt5s4tjqSEPtMXh11E=;
        b=eZ3Qy/WA7ltHk4PulqkPNg/zjRCg32NkHjCPXoATfTsa8MQH+XHtxxIHsQt7O0Mh5s
         6v9fhN6f3kEykY3sEbRjLMEZUz/KMYc73LXT9KTK2+Fb0V33q5oRndQ2bkTk6hHgobee
         pZZXWKVpvLR6izYaCWVTbBNcVcrK3i/fhQfkFvFrfzW47fM5LOmiK35RCmL63qdU2u6a
         ayDG7LOLFDBOKJvEzHSYZ1j8T7sgMhDySNzo9ZPDde7rrr/RHRBkNGEHqlXyl5iGt0cK
         VEljxHcJczrl0wh8betEiGemDLyWjaowbHgIgauYeZT2e1kLZgglBtSZ7VEWYjLGqs76
         gxbg==
X-Gm-Message-State: AOJu0YyMNV/uPkNZ/AG8sQqrv/vO7RYSA4FrOMbHoCv3Njev6ZVBNQcA
	nPQ0oPe0PhExeGl6A1uPbgFeGclK3x4k7/SGArRJT4IuAMNd2eiFRI1gYgdlIiI=
X-Google-Smtp-Source: AGHT+IFiRRznE47uFTTwd5IXO+dQr605HlZFSoahRrX1Uz1DifG/1En1fFRusx7rla2thNoRU0twqg==
X-Received: by 2002:a17:907:3f24:b0:a80:b016:2525 with SMTP id a640c23a62f3a-a868a802340mr310380366b.8.1724337069538;
        Thu, 22 Aug 2024 07:31:09 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e74bbsm128224966b.95.2024.08.22.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:31:09 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:31:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 01/11] octeontx2-pf: Refactoring RVU driver
Message-ID: <ZsdLq8TdZhpNGnkG@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-2-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:21PM CEST, gakula@marvell.com wrote:
>Refactoring and export list of shared functions such that
>they can be used by both RVU NIC and representor driver.
>
>The changes include:
>1. Moves nix_stats_lf_tx/rx structure definition into header file
>   so that it can be reused by the AF driver while fetching representor
>   port stats.
>2. Representor PF shares same mbox design as of RVU PF and have same HW
>   resources(TX/RX queues). Hence, mbox and HW resources configuration
>   function APIs are exported so that it can be used by representor driver.
>3. Moving the link type checks and tx credit configuration into common API.
>4. TX/RX queue memory operations are combined under new API.
>5. Add extraction of queue and vlan id to common API so that it can be
>  used while matching mcam traffic rules.

I see 5 patches at least then. Again, please have this as a separate
patchset, one logical change per patch.

