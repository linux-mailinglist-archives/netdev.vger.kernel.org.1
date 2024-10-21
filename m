Return-Path: <netdev+bounces-137523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF19A6C28
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A761F220E1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074401F9434;
	Mon, 21 Oct 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLsX75u8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E61E8851
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521181; cv=none; b=etPHrQJ5oqFeAV9M1BiDk1evAWf3+QX0vY+3157AIh+KIRIeeoYfQWllc4yGXkMNKbDc9bfNED2iU1mbe9pXspP5pjgocDUUpLdGLbwmhQ2+aUqXP3GyalaMhU888fYtWnUMLgUqMutCkjrAnL9xT3kalC7NtVJVQf1W8ImY5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521181; c=relaxed/simple;
	bh=8oL7AjLsejCFCCc+8UeY/rmUqL/LthVWjUTWzlIOAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5VbjXTdnvvYgvYUOHs9MvLj60Ar96UiZ66FEs3kIuYeiqTNalHMCmdAfsvivI2oxEtn/sxRyGehA5mk7WLDi3QfurHRCn7errnNci1U80C5v5qtS021oFEl2xPNna4PTq6eKWSoG1wliFgqGE7473sNlCFy2ZHE3S8t8jfEtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLsX75u8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2912209a12.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521179; x=1730125979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gsw3qei6dDCPG5GIeOw0lcZORqy5STrwjiLbFoS3YY=;
        b=CLsX75u8tJh+cY2492z7G4sAeF3i5LA1fZ4l+64cKsL+M3duLCyeOZhI0S1WZyCbfv
         hJzbIlpXlKyd3mO0vskxkjukFQVLX3QfadxETYbpZuwyn3tmE+8k/UnOzfX5GXdQJDDy
         8EjIrCb3bJixhsKJZYY7zNQRcVyL5gGNF3PhZgpGY87QPudpuRqcTlJihNiVGC4F93Bz
         cnxw1yrM94RB4/YxDg+xCJ9MByYCZDrpYN1+RRK5mOTMNkxfuI6z1owP+X2TdHYmeGSL
         bxcC5bOvQjV1a6sodCxY8sFz+BFVEwqC0bDvuFg1fgQzHHRyowr3S2lLCdh6TNEBkE+t
         yCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521179; x=1730125979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gsw3qei6dDCPG5GIeOw0lcZORqy5STrwjiLbFoS3YY=;
        b=KxWKyHweV8C7yh8RpkiTo8NtAwooex4Qr3rGcWDlTFN1D0uAIaSacKE5hA99A1joNr
         gyApYtIAOkpJm1hbVW9hNZ+TieK9guldq4JfAj98yckCVVfWgMnVA68/AOhqKo6BUgun
         UrvwQeG6M5uOaP0nKRTV3cRrf/goLu/6FTJt9xcdcxp/6aLlduOX6k8CZnk9UFwDYbyL
         QpW8a6uRUPHKOWJX5l6bAboU9f5Jc2RNg2dsc6z5f8ZZCw//RVGlyPGkEmQSl1ftLMHW
         jXe3VmTEV7LDHn3PcGlKbcjnKonqBzSl78sztHR4/06FY32ZT4ol4jhaiVEB8BsEElVw
         xczA==
X-Forwarded-Encrypted: i=1; AJvYcCUPcb9orUUPrh21eeAaSkxUqVS3n5PneIAmBge59U0KR+RtBrpgLH/v+lRWpoKQNFGlaKnF/8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wvKzbBmRgfhz8MgYoo6NRhdLsmqwhydDb7/1BJNOOd+MBmEx
	GvgYVz+eN30QrOJohhJsDBmvP7hbptpXwUYIBdlZGmYN03klVwc=
X-Google-Smtp-Source: AGHT+IGQ0JsShkEx1i/OSoJXqXO2mbvfF/N7PSeq6WmenSNoMd1hgmpHbQkl/dQF4S6GVnSVdobBVA==
X-Received: by 2002:a05:6a21:9cca:b0:1d9:2078:3e46 with SMTP id adf61e73a8af0-1d96b7156d2mr127913637.30.1729521179226;
        Mon, 21 Oct 2024 07:32:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1408989sm2932586b3a.213.2024.10.21.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:32:58 -0700 (PDT)
Date: Mon, 21 Oct 2024 07:32:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: Re: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <ZxZmGmNWjViZEEbX@mini-arch>
References: <20241021052011.591-1-darinzon@amazon.com>
 <20241021052011.591-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021052011.591-4-darinzon@amazon.com>

On 10/21, David Arinzon wrote:
> Provide the relevant information and guidelines
> about the feature support in the ENA driver.
> 
> Signed-off-by: Amit Bernstein <amitbern@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> ---
>  .../device_drivers/ethernet/amazon/ena.rst    | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
> index 4561e8ab..9f490bb8 100644
> --- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
> +++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
> @@ -56,6 +56,7 @@ ena_netdev.[ch]     Main Linux kernel driver.
>  ena_ethtool.c       ethtool callbacks.
>  ena_xdp.[ch]        XDP files
>  ena_pci_id_tbl.h    Supported device IDs.
> +ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
>  =================   ======================================================
>  
>  Management Interface:
> @@ -221,6 +222,83 @@ descriptor it was received on would be recycled. When a packet smaller
>  than RX copybreak bytes is received, it is copied into a new memory
>  buffer and the RX descriptor is returned to HW.
>  
> +.. _`PHC`:
> +
> +PTP Hardware Clock (PHC)
> +======================
> +.. _`ptp-userspace-api`: https://docs.kernel.org/driver-api/ptp.html#ptp-hardware-clock-user-space-api
> +.. _`testptp`: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/ptp/testptp.c

nit:
Documentation/networking/device_drivers/ethernet/amazon/ena.rst:228: WARNING: Title underline too short.

---
pw-bot: cr

