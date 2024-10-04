Return-Path: <netdev+bounces-132005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B29901FA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C290281B28
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3589A155C98;
	Fri,  4 Oct 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh7bkzjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596213AD03
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040789; cv=none; b=vDJhbqlTvuJ6KoGPj3Z05LlfIaWLQhAHMg0Kj5T2FgH0kpz+7IMWgYyrWP2wr60Hy68syUD9nzRXi51zZJVmcJ+o27Olv827qjIOCBWPGyI1yYpVEg/8/mlvbyJ4nNAWb986mLFIaUccF7kWB/gj3u/vjZM17E/bOnK/3bAoOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040789; c=relaxed/simple;
	bh=OybRsfH6iKf+HDwwj9pBXwKaxVvvPcR7LIt9eGmKgn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbHK2JBzmqtwX+NNpi83ziFHC0Ie7b7xuAcTtNoipc8naIkOHPM0h7cfKGpv17PmRYFj/yjLyjBZBeBYPLQGZCmjXkMibQMCVCAF05W7gvVJ0vHjddpWZkWU2IbCB5BG4WLnnkEnfL5R5vF8B3yhdt0jJNjvg7MFE3KnK0js2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh7bkzjy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a966de2f4d3so29296566b.2
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728040785; x=1728645585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21/ANHQaVAmEnIKVWasnSHMY8ie5sYhBEQjQDCw2+OI=;
        b=Qh7bkzjydjPF7q+N0ZJndlorBpXEAnisbD6W/E1TIuToGrj/IEJq6Sp9s1yL8zFvcM
         E1YwV+GkEXr83egu07wzlYtMAIy3P4xQv7RYEib/vKGb/e34X1y4rg2dSXp3Ctf+JPoJ
         Dol1rJCfQBcnrG45j1MCl3kCcSqYbAzmXCZjAM4qff9XwpVzq/YbRqyLoDCl0RYMIorh
         tSVLnDwCiKZ5sc5OASuAo9OBvRxgF1SVK1TaNk5AIINSp9e0tWGPdI9ACFSw126sa7fG
         /v5QvAbRVq3qoQV5ZBEbwbSw8HUD8R6aUzzorsYfVjorjKjAxdCoc13EKxiODPHCFs9g
         kwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040785; x=1728645585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21/ANHQaVAmEnIKVWasnSHMY8ie5sYhBEQjQDCw2+OI=;
        b=r4ze3QtqIUz7RxKF33AkpfrOqNa+K8Z/+cDtCBY6EKgtD6/9ULrB1Rn8an9oZpMih3
         HqG60Pr00YMmR2T53gsRQChuQZDdA1LWjhLzlCH4I164i1JQsBVuZHx8VKmNULsdf+0G
         VrYDB40V4Y/iivxMx3ROewUtr7VMlBSWBCo1y4YseHupW07nfzBZMq2wmj+S8t2wSpvm
         w2hHQwrNrIC4Tldfx+ra+KYPdnRtbkZ+3334zPDxP9pFNyMeFjit3exr//jeQKag7DqF
         TWtPCAm4SyVTCAzhQxcsvWsIGY+k0uIiv4vUJ6//29dqLJTbzD2hKQBK70Q0yJO5mFKK
         5YLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8xOVecXitmrmSaMxNwcfPv303XoQbIhECcha7KLfZL/YQbB5BShM6UUOH2Lm95g+r/wgJqAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3IiJuQWyQ+HH9p9zjTQqQMMrENgWPj2kCRz/kpasOSQnL4rB
	iDcKZbmwiXXcXDIlDYYr0p3GnRp/9Y84zoGOeRzMb8nLCZU5SvBC
X-Google-Smtp-Source: AGHT+IFPKLUaC6w5boja1xHVBGVElwe3dN447ckuLj8ZW8kJK8aoR+nYtgFWEIxSqzAexPpQpvcpJw==
X-Received: by 2002:a17:906:7310:b0:a8d:2624:1a84 with SMTP id a640c23a62f3a-a991bed1a26mr110366866b.11.1728040784216;
        Fri, 04 Oct 2024 04:19:44 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910473155sm212364466b.151.2024.10.04.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:19:43 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:19:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <20241004111940.xbtssgeggp5mcprl@skbuf>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>

On Fri, Oct 04, 2024 at 11:19:57AM +0100, Russell King (Oracle) wrote:
>  drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-

I want to test this on the SJA1110, but every XPCS cleanup series day is
a new unpacking day. I have to take the board out of a box and make sure
it still works. It might take a while.

