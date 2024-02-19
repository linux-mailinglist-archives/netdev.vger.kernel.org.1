Return-Path: <netdev+bounces-72921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A847B85A245
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADE21C2100E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AAA2C6B2;
	Mon, 19 Feb 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dry4wvDx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1D2C691
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343067; cv=none; b=D6fAQFgyepglCqiORGBpgus1MOZ5A7O52AJD2V+lDmlMjA7wAVP7fVCG2o83AGEFMM/Q+SpNaciuCLed3xSAoiKg15vJWAWng7OVEh3I/7bFnSmgMXc8k6X3LAkGzucMXZIc4vF+5uP742rDVtwbOCCiKptljLAcXSPu5bT6C3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343067; c=relaxed/simple;
	bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csP3n2F30MLNio+kBbE09ebFZiQVFXR2EYUVH3fEFDTRwMc+eXYS6YYTRgBteivXxQkxa4QettPG2wdpiWtmcsYvAEylQ8LcRK3Y2FdRwBoXNJj7txexesrfUl5eU61qBBJ8Lw4XTw1sVR13CNE2534Oexwfn7gUMpgMhy8/W6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dry4wvDx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
	b=dry4wvDxtXI7dP3ln4nyKSpqlLi+nqPlKWqM8TJtqpcEcJ6hmtb0zODLGl7HhsqIbbMOe8
	h7joAXnrW2IhE9J6ePfGp07lUWlVQdPDC1GfUK2HUZHJt6pTKNE/RgRwiduXUNPYzibSB7
	xPYmgvaf34zWd4X82zEo3bOnnljLHOo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-uS1SSasZPYm9q1QKII2npA-1; Mon, 19 Feb 2024 06:44:23 -0500
X-MC-Unique: uS1SSasZPYm9q1QKII2npA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f747e0ec4so6724196d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343063; x=1708947863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUntlLLADUk9fOwIp7/2ak+sHS72oT6rdDnXj0smozo=;
        b=SIUE9UPJcMk5Q3pAQ+4wD7MrjsWLL6lQfH7P1ZekgUH2c+WycoE7imOGe+VsW9TIhj
         m8fvVtY8TlJm7pJaxFje1o5nlr95AvFyU6DX4mINrVLE/7AORm5JaCcPh4hc7fPPnf4H
         k7SYkzQp7SVZt0DHPvOfh6rbQU5nwdgVpGqEhLy5gt4p0rQXeS8d58zv4CxrTEpmMwWU
         5sz4ne317jFXNFGpzT7OQ3MNYNyeOwzdFLSgqZaGWf7Q6W5ivQQI9frsTpPb+PA1lNub
         FHqETf1P9owFpSJtqLVq1FoMSQUdEbcu4k5Pcxm+pd4OWWc+X5NXVoSu4xZPv1FT/5au
         SBkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Y4Nx+0MdtlWxnT81jx94NYQ/XnVZUG7saGcN9wuObT2W+3BuPnkmaEVOp6Xbf+Ea0yRjRfL/cWroWCplSUB6H++i871y
X-Gm-Message-State: AOJu0YxBhkKiT1PrwDkp/cmnUgDCkYhTmj1/vT2P6wXib0ilxBK2xkmt
	I/3GkFduDKRoWxn68+ecW6FnD43dEY13Nv5MZJP0VjpAfx6lAJNzbGb5nFEfaZe9FdayKVTZ8ni
	+IUqxBSayekqzCGWmClqrv4RkOoXOIaUbbfhCN0/wHU/Zu3TL1r50XQ==
X-Received: by 2002:ad4:5d69:0:b0:68f:4645:8cad with SMTP id fn9-20020ad45d69000000b0068f46458cadmr2351907qvb.57.1708343063351;
        Mon, 19 Feb 2024 03:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLbhd1hRBa1Vi4h+/NrkLkws+Hyd7ejD07jtvzpsrfiTatFhwS2ruE/0PimVLy9ybIJlmUWQ==
X-Received: by 2002:ad4:5d69:0:b0:68f:4645:8cad with SMTP id fn9-20020ad45d69000000b0068f46458cadmr2351886qvb.57.1708343063103;
        Mon, 19 Feb 2024 03:44:23 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id d11-20020a05621416cb00b0068d11cf887bsm3121135qvz.55.2024.02.19.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:44:22 -0800 (PST)
Date: Mon, 19 Feb 2024 12:44:18 +0100
From: Guillaume Nault <gnault@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/12] net: ppp: constify the struct device_type usage
Message-ID: <ZdM/EjzGrmdGIpvg@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-5-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-5-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:27PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the ppp_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


