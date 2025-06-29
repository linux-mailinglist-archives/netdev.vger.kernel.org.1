Return-Path: <netdev+bounces-202214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23FAECBFA
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F611717AD
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B836202C40;
	Sun, 29 Jun 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+N2729e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4208A93D;
	Sun, 29 Jun 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751189785; cv=none; b=oMGzAeSvB3jXQxWCdSDjFxbRZzfC57D/hcUugGtT2iZ/So2yH8cb3XtjwUgIlIUoCGWKW9I7mHzFax4WDBlFHNVnbFRGwno+erBuiKfUKdeztw4sVWOWDZTEA94oW5Y7rYLhl9BDCUT1lRZhwdeF3qTZuqbO9IlkebF4sNj/gKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751189785; c=relaxed/simple;
	bh=Ry1uJCu62CkLW9LcbZeSR7YaJJlm1KONhJOR6UVwkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiXXFOsuO67faHZk5VADx+Ie682bQoQbUUPjDEuTVwqgByuRr8QJHM8HRD3vc6PA2XoM0pyyU4k0ZXTzweyFIFaXaEmTRWgmNqN6dmCaPFsK6DSTNxG3M8ppyo6qI7/Wv7q6yjVXkPMQDtyhCfPlWBYMA/dcS0Tz6ynlpZfm20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+N2729e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso944790f8f.0;
        Sun, 29 Jun 2025 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751189782; x=1751794582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7IZF6P2H3Qklyp7Y946TAOUCcx7EHumDWuBAo4Oo5Q=;
        b=k+N2729eVRxUJFZfa1zUb7W3N6HGbhmiSKTCREGTcV1cWeilQPCN0LOZJPNXunRbwO
         Ze9DAClgh5c+2ATmaXbHariVmHkTuS3rABPywQ3DwBCov5gPIYRDexMDB8HgJ23navFc
         AaoJ/AxYSVAvP99QjmXkjBf5hZdpSDkbbUf0qpHjyIkqlfaq3mDesRFb3/J/NqwFIlE2
         ZzSFIlme0VwrO8GZo3yISDMasTXF65chjDI/z72+fxuyT9vuFOw70m4V69Oje9WFjcPR
         4YX4Kyr2QKUtOnfTEaoilE5CE39DtTPzcD3YJtgV/1jOyK47nohKE7vmr0HhD3Ceo6uq
         ijIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751189782; x=1751794582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7IZF6P2H3Qklyp7Y946TAOUCcx7EHumDWuBAo4Oo5Q=;
        b=QTJ4qpzHA/R7TGc0eZ8XRhtIfpvuYjW1aZ7lbQr0tkrmViTe776b3azayfgPslMh4e
         B6ZvlpJIav3R/cWf0fAsTJ78+nOZRmGgYK8f0+eppmTF091mBjx/LK2iXc5Y/p6/4zdC
         rqSJuxEEcOPmWeZds4Qi9se8qlcIZGJay8X9DaCo1QEDfCir7gjrRk9NSbNdfOaEdkJF
         TNbeisC+zaIKihJOunV43FS+6aw1WrLjjgXf2DdoaQbLEe1tgaq5YP6MYlq/nQpX+k0W
         fmL8E4lcw0k1CGIDKHw7JRk/fRFkGWnH6JrBxoYQbwAkKFlIyKb0S6JpIC5325dlOTbM
         eICg==
X-Forwarded-Encrypted: i=1; AJvYcCV+krIUHpGCpJ+pRZAqY1LaG7CCwbVTcI4rBRvjDCZ2ZPcezDrcRW2D/wFaeaNShDCCF/tJiYEv@vger.kernel.org, AJvYcCV2a9d2j+5hey+IndTNfsBM0rbOIQMfdxoEfI/whWejo6XhBGhG4azJziijaHLWMWpX4ilsJ48oNju5tWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgfh+5ikbS2K/Y2gEatSynstrecC6tEm1+KRHatrzUyKd+k2Z
	QYXc2U5GArclwsKNPT+GlviYdFurfU1zQCgjswSStFs6iejAvVVQmcgD
X-Gm-Gg: ASbGncvvL1Za9gT8ifLhQVvDgLFOCaIjlvhcA3sDE/8uEK+8bE2gt/5j+M9lHq9W3rB
	ODFMS5KYJwyJv/jiP29uksymaWWzasu4VB7wL1nBzTA1tvthfl/e+39ARC95jZ79g6OQNuLMOku
	4e0nfhWkyOnqvko8ukdwey0dS51Soa40W7AsB6HDHRG0oMCSzBGiCuOq7ap1OGz7+631EjCCsFd
	MA+SFAq2FWGlAnzTrFidcstb2qhGQjJ1uqHFXT5dO+Nw5yPTd0SNfzji+DlCGOPHD7mYYvk0ZL3
	8abBrf0RdTdixCJTVhf9XILHAaXHtZDIFB3pDS2A+HP23Esja2xHy/LlKvPoCf9HyWMtI5qZg0x
	+qlAq+ZKCl/3tI5JQzA==
X-Google-Smtp-Source: AGHT+IEOnc57iTWUFaDPB8HVttZZBXkGceicoCUz2ChQ8zSFsL0MhttY/Cd1T4mxAOtbASHj5+U7yA==
X-Received: by 2002:a05:6000:2893:b0:3a9:dc5:df15 with SMTP id ffacd0b85a97d-3a90dc5df54mr8669775f8f.13.1751189781866;
        Sun, 29 Jun 2025 02:36:21 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7396sm7208499f8f.9.2025.06.29.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 02:36:21 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:36:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vlad URSU <vlad@ursu.me>
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250629103620.186ea33d@pumpkin>
In-Reply-To: <613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
	<5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
	<20250624194237.GI1562@horms.kernel.org>
	<0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>
	<20250625094411.GM1562@horms.kernel.org>
	<613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 15:05:01 +0200
Jacek Kowalski <jacek@jacekk.info> wrote:

> >>>> +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF  
> >>>
> >>> Perhaps it is too long, but I liked Vlad's suggestion of naming this
> >>> NVM_CHECKSUM_WORD_FACTORY_DEFAULT.  
> 
> So the proposals are:
> 
> 1. NVM_CHECKSUM_WORD_FACTORY_DEFAULT
> 2. NVM_CHECKSUM_FACTORY_DEFAULT
> 3. NVM_CHECKSUM_INVALID
> 4. NVM_CHECKSUM_MISSING
> 5. NVM_CHECKSUM_EMPTY
> 6. NVM_NO_CHECKSUM
> 
> Any other contenders?
> 

0xffff

With a comment saying some manufacturers don't calculate the checksum.
Then you don't needs to search the definition to find out what is going on.

	David

