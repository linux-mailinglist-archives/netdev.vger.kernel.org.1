Return-Path: <netdev+bounces-53460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC297803127
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D78CB2098F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306B224EF;
	Mon,  4 Dec 2023 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaYdwlTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC7F5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 03:00:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c08af319cso14192585e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 03:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701687639; x=1702292439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0GjZblnHyXKxMnT2vNIaeSasod01cHebJrAhLXFYYg=;
        b=kaYdwlTfLbNQj3VPCly6ww6r6XC0EF64ztZhRSk+OKweRF25X90R0RhVcgsBMHS9St
         XtlCq6GiYzZeNKB/pxWUolv2mp0hV+H8Il2j9jkTi00bNU0unoeUiSmNcexNyY8g9cYS
         baZ0yDr97k3Vfsz+ksab9G1o+3wPMqmDURDA8FEJZbAX/IbYYPU5zJA81UT4DtZCIQxc
         B0dny4fIKaFB0no8l4TTfr8kreQmQlOcwyYWykBPLHrDBOhbIiiY0dHTGT0cA3fGmiiq
         sAx3Zl3NuxooDWgzr7BwNpKpOPfczXB/WZ2TWs8yFINtUdgqW1xpyd0sa835gGh1FCd0
         AOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687639; x=1702292439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0GjZblnHyXKxMnT2vNIaeSasod01cHebJrAhLXFYYg=;
        b=m+lykMDI7kgQ5AV7Jo/DUsQMPXWQoKAox8VvuncGnEnWNACBXs2jU3uDgAsZWu2efn
         g7ko4UNN4qSU96FBzlLm1nxN8tld53Qk2yOvzCqQyRUkC+7VVrtZ8dM5bXFpn3x17D7r
         wfD4qbfu/iVtbnw4Ax7j73+2PlIMvb9U6Ga03FdpTU4/Ti0vZGvJ/YaqZTssm85xF2iE
         vYydPH431UgiTZmvN2DGo729U3J7YiOK3wsYkAqSZ7pCUjADdzlG1NseZ+CGjGT6FfIM
         /ljpa0dBpiIVUyGt80ZRjgKGLqSd9Aiy3N3dAKB798CweNGsVt1/mqDpGwXOyVG6MHAo
         mQNQ==
X-Gm-Message-State: AOJu0YynjbGQENqrq3wXyTHqoQnrkMceGw7oflXLyz9Nqfr/QOxSLTMx
	IMj96R29B4Ta4fWlIilw6Ic=
X-Google-Smtp-Source: AGHT+IErcHBUcOtPBXx5F6yulL/4xr089hG/NL+qIfLXIWSkRzsFjAJwgKrCyhNoNda/DOTIm1MAnA==
X-Received: by 2002:a05:600c:4ecb:b0:40b:5e21:ec21 with SMTP id g11-20020a05600c4ecb00b0040b5e21ec21mr2281196wmq.83.1701687638724;
        Mon, 04 Dec 2023 03:00:38 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0040b34720206sm14581504wmb.12.2023.12.04.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:00:38 -0800 (PST)
Date: Mon, 4 Dec 2023 13:00:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Austin, Alex (DCCG)" <alexaust@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alex Austin <alex.austin@amd.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	richardcochran@gmail.com, lorenzo@kernel.org, memxor@gmail.com,
	alardam@gmail.com, bhelgaas@google.com
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231204110035.js5zq4z6h4yfhgz5@skbuf>
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
 <20231201192531.2d35fb39@kernel.org>
 <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>

On Mon, Dec 04, 2023 at 10:26:30AM +0000, Austin, Alex (DCCG) wrote:
> This seems like a good approach. I'll re-work into a v2.
> 
> Alex
> 
> On 02/12/2023 03:25, Jakub Kicinski wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, 30 Nov 2023 13:58:25 +0000 Alex Austin wrote:
> > > -     struct hwtstamp_config config;
> > > +     struct kernel_hwtstamp_config config;
> > > +     *config = efx->ptp_data->config;
> > Do we have a lot of places which assign the new structure directly
> > like this?
> > 
> > There's a bit of "request state" in it:
> > 
> > struct kernel_hwtstamp_config {
> >          int flags;
> >          int tx_type;
> >          int rx_filter;
> >          struct ifreq *ifr;             <<<
> >          bool copied_to_user;           <<<
> >          enum hwtstamp_source source;
> > };
> > 
> > Maybe keep the type of config as was, and use
> > hwtstamp_config_to_kernel() to set the right fields?
> 

If I may intervene. The "request state" will ultimately go away once all
drivers are converted. I know it's more fragile and not all fields are
valid, but I think I would like drivers to store the kernel_ variant of
the structure, because more stuff will be added to the kernel_ variant
in the future (the hwtstamp provider + qualifier), and doing this from
the beginning will avoid reworking them again.

