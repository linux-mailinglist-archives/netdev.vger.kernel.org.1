Return-Path: <netdev+bounces-144920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79DD9C8C73
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC011F24AF0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473844204B;
	Thu, 14 Nov 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT0GHCfW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9F25776
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593257; cv=none; b=N3BkIwrBgXEbKZJkXU4cPW1iBtTgl0qdJy/cTR1tRHMpn3KVvrFM8eUC712ZReyDqd1Hjj5nEroD/JOy5km0x0JQ0uZZQy3zcg1mr4jXnDWXglXWpHKh1ND0DmjhMjOy5urSLX51mZ9m4WAkhytuRuPwPCiK++sqMyLwzlITGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593257; c=relaxed/simple;
	bh=WUzDeLLAJtW+Z0kgOfdgeEqqhYnBqQ4TWuHZqdvOLmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6s7wN6lGa9AKX8y498cGfetezDJIX+vH9XF6mbCMt88yj2uVV9IoklcCH9kuRDnpZX82cEP5sltTfmM8j1Buo2psZdEjjyDzMR2i6JThtMmQmxD4kVcGSexVTOip4ox0EubxRkSCF0awYZDaZEGQ0zKRs92bQtgziicDQ6A8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT0GHCfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731593252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0gBUaNEyoe8hJ+dYpFL/aTlXJr3V+IJ2ahMbY21d80=;
	b=jT0GHCfWv1HUgAfDfPBs9up9oBzdFJvaPRSoIRF1DyDHTugqjexxeigSoirScn7i3eJTFd
	bdir//QXaf2ieYnaOfMxT496co5BlOpfDPVkfZVxgmc3ExUXo8iCdjXADyj3RuqIQD1GnB
	cI8oqpz7cK1Gc+uQITO8ZVJgLYTDA18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-qYhZEuMIOFiWfBsQHEg_CQ-1; Thu, 14 Nov 2024 09:07:31 -0500
X-MC-Unique: qYhZEuMIOFiWfBsQHEg_CQ-1
X-Mimecast-MFC-AGG-ID: qYhZEuMIOFiWfBsQHEg_CQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314f023f55so5079615e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 06:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731593250; x=1732198050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0gBUaNEyoe8hJ+dYpFL/aTlXJr3V+IJ2ahMbY21d80=;
        b=TLpkhns22EixUniwgDtdDkbUktyWmgicGsx+cLMko+E+clF8RglU/U2FKmnrrRsafg
         wnoG2OYjx5GQ4HbcvsHRaNHbkute9kUVFhvdaXzUZuGhqH37/6ypLZTqGYJ/dpvcTZhP
         5oVL90s/8C6G7XzfjKJgCKr7UVCksNddmRnCiPZWWzMzbl15Ki32swznP6L76fR/CmtT
         lxCjTnkz9Bxsexcwx7eZAohjHlrqRtJOOfo+fslBuq5RcEcjtxuK/S6IHxizXXhDDj3C
         +DrWmKag4hjM6ZSc6juYEUVRSnJBXzelIx/1TST6zg+5tJK1mjwqASfNLKoCQfIKAHYm
         ZO7A==
X-Forwarded-Encrypted: i=1; AJvYcCWLsGafve7RwUU9hPdTXfvb59+7QcRDNWc+kbSgyIW9TH0L+Nb/PklcfluLL2ptvqqULwC7g20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0bHvoUHNzzOJ5N+oPTxQew5nKWRu8mVSgVNc/Q2B5x1j7mFV
	9Uq3mhLeCGtE6fwhwA24wyF7xS6j/Z1Dw2g+Tc3WqzJH8ZfEiXYEZu9futmsVcDjad+7mBso3bE
	+1QPjiP/T2Oe59sUV3AFn2zzMXyNX8/5m/SeeFRYaK+Em40XU5Ku8NQ==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr223068245e9.14.1731593249954;
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlAsv5aiN/Qn1l2dvPuDWBAlvuNUEXu9wk/kXmBPHQK9kBVTOoQJEVnzmbxW6W/XkP1hbywQ==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr223067825e9.14.1731593249568;
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm21463955e9.25.2024.11.14.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v4 2/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzYEH+q4AG5FBCiG@debian>
References: <20241114-am65-cpsw-multi-rx-dscp-v4-0-93eaf6760759@kernel.org>
 <20241114-am65-cpsw-multi-rx-dscp-v4-2-93eaf6760759@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-am65-cpsw-multi-rx-dscp-v4-2-93eaf6760759@kernel.org>

On Thu, Nov 14, 2024 at 03:36:53PM +0200, Roger Quadros wrote:
> AM65 CPSW hardware can map the 6-bit DSCP/TOS field to
> appropriate priority queue via DSCP to Priority mapping registers
> (CPSW_PN_RX_PRI_MAP_REG).
> 
> Use a default DSCP to User Priority (UP) mapping as per
> https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> and
> https://datatracker.ietf.org/doc/html/rfc8622#section-11

Reviewed-by: Guillaume Nault <gnault@redhat.com>


