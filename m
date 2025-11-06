Return-Path: <netdev+bounces-236470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC2C3CB3F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8401F3525E1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F134D937;
	Thu,  6 Nov 2025 17:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDB34D917
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448769; cv=none; b=rfO35NInTqPCL2fBB03jC8AWeUSm71ufEqm3/xrg3Y3dywz8E7nkqTklWOKpOfYO88Ezl7W/G6EY0StYs8mACsyxLtUkSkp7T8eaPaIWOFSEMsnUXyuU/FGKiKwe4UxRUufV2Q/To+Deo6/DnfDEzigN8zSTmY0s7G4ehVPMVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448769; c=relaxed/simple;
	bh=u9XVqLZpaWPD6eBVLxWNFs4+riQ5k6PAyZ3Iq48h8Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV/sYRBhFxU79KG3RVRXKDPXkXFgBVjiRAVJ/gQ8/i3yn8JvUEodY9zIpgtTyJ7yRclAiu99r7U5O3u2GJMzk/BD+14q3g5RMWK2esmApUvLE7T+FIjQZTRUBJ+Ck0le3Xa6ARer59gjxHLgJfoyg7H9i63MEx2NZ0B6UsyKZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so2009990a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448765; x=1763053565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+WGVXXWVhyjyZGYUX+1y1Q+1FkWB5jkOhwquLJi9MY=;
        b=MW589c9yacUzcRnXmNVJQtEZH77SNyisQf6zN843tkStghoJDw0Z4UU2iNcOL/FI7G
         NpcBSsWw2Hd1mzkd8RZwyEvLfcoa+I0SxgfjlCgmCP6yCp/X3xUX1tqMdNdkJOXg+7ne
         XAPLEwSYDUq3xLWR8+fhDH4wK4kBWngG3m0m6IpOTTnnuzkHcMT/N2O87HGKzyfumPwv
         dKMxFxg5byP4dxH6zRHTUYWp9RbwrCi1oa9LIBtEG5OKb80F34vHYB5wpP1GuZyxg55n
         E/65JFDkVvz/T85YJgG8oC5toDGx/0dV6g3rzET3DAcT/6lauVU/piP5BnMxBJIQuYOO
         XxAg==
X-Forwarded-Encrypted: i=1; AJvYcCXUVB5wED3m0d3qCGwcENpOZevLYcqVUiJFolJq0yRloG+MuQB5ayXdkE/AWYrKuw0Cb3DS8no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1OA1qEzQa0v68KqqRJSJ1l0pxzhACS3s56BReCEp1ENW29se
	Ub0w6TJwVDY+ORM//jXPySV1XfU7Gie19wZkHu2rIwMuStMB7ljoF0/I
X-Gm-Gg: ASbGnctRs+tqi7TEZqPDr6hS7tSfwjccRXXj5bVHTY8GQ4H5jpdLMdFh62DJU5SamI0
	5ADVOtNVKf97w22F8WuioQ1dEEwycl+tWfvKgGwVbk4m+pdSsT8PVihAVot370ro86N4m7f7CiJ
	ApKoadUxDDY0hNmRkL6kZxl8CVIGCiLs0sZ+fHh9/VRJA5sq4zRiEzT0ugTgkNj5TtugEDlL2va
	F467C8ybkHNY6aHodQwnr6HdHZuEV1zbkjunUG3iBLFZNQSpAh+sogb2lInRWkZd3TzRPHf1mIE
	XRSYmVRIiQMWab5xQa2pf6+vg+Zcdo37NESzASB+otUMKZ6xfaVusPbyrcC7ylnPP6j7LLeyjPP
	Slgas6SElhvivMxhU/+YaWfDsfhMY3etwZakQUyKbHVYlJ9LRvun/EJd1O0vcs4TJumoa4QhDFp
	1z
X-Google-Smtp-Source: AGHT+IHFnIfbtm1ZjvxdkHLl9Wb1IGZm1PL96ngnoeuGIDRz5E+nh+lXTjs6tMmUTl6jXosCKcP1gw==
X-Received: by 2002:a17:907:7ea6:b0:b4f:e357:78f8 with SMTP id a640c23a62f3a-b726553b6b5mr760452766b.52.1762448764934;
        Thu, 06 Nov 2025 09:06:04 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm6058266b.31.2025.11.06.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:06:04 -0800 (PST)
Date: Thu, 6 Nov 2025 09:06:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>

On Wed, Nov 05, 2025 at 11:05:34AM -0800, Michael Chan wrote:
> The existing code to use num_online_cpus() is actually not correct.
> This is more correct:
> 
> return min(netif_get_num_default_rss_queues(), tp->rxq_max);
> 
> I think when netif_get_num_default_rss_queues() was used to replace
> num_online_cpus(), tg3_get_rxnfc() was not properly converted.

I can resend the current patch with this additional patch:

Author: Breno Leitao <leitao@debian.org>
Date:   Thu Nov 6 08:05:49 2025 -0800

    tg3: Fix num of RX queues being reported by ethtool
    
    Using num_online_cpus() to report number of queues is actually not
    correct, as reported by Michael[1].
    
    netif_get_num_default_rss_queues() was used to replace num_online_cpus()
    in the past, but tg3 ethtool callbacks didn't get converted. Doing it
    now.
    
    Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Suggested-by: Michael Chan <michael.chan@broadcom.com>

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index fa58c3ffceb06..5fdaee7ef9d7a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
 	if (netif_running(tp->dev))
 		return tp->rxq_cnt;
 
-	return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
+	return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max);
 }
 
 static u32 tg3_get_rxfh_indir_size(struct net_device *dev)

