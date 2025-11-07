Return-Path: <netdev+bounces-236799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81401C403D3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817114F0D37
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16065319857;
	Fri,  7 Nov 2025 13:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E448433BC
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523957; cv=none; b=fWC8qIuWOpG++nuFXpt6mauMpTw8CTCtnyl9zkeCy1L2Dkd5/vBlsU0loUfKwH61K+BrM35KOYuuXgfJb8NQOzZn3z7HmpoHFfuCWXQicKcNdkTkULCRUp7bO8D9Hbc2z2tD3hXr4vkHL1WRAWgIHixXofAMZneB+zV9dmULsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523957; c=relaxed/simple;
	bh=8JxOVPMisbF56oYxS5Y+sDye3oJBmOCWA+veCsBSQt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMlie/Oc9v95LmlKN4gJjkRLMLSciV1YZWZ4Hexrq8iJg7Wi6ABk99DnhxTl1shMYQaFBRb8PWqa7gp8AyQLfPENtOsvfYyel+pJUyOvb4a38YlbgK6N9JdVaOdElhHP/LHAWZx9xrvoCtAEAWTUPVCHqWkkI86oaMaIwTGbyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso132909966b.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523954; x=1763128754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJVwwG9Ykxrpv2wC8GWxsRY2S8SK8LdQYPdOrnHuv/4=;
        b=B7j9MkSplDjRlRi5rvk0kWiDxJENmS5hJbOAAoPWX2g/+48bj6dBOZlrOGNmzPGYiL
         T92qpseGBpNdwqFp76wRQRt2xva/o5TtnhVqPmrfGLBYn81x3JGDEP/VK2cb6UD+s02X
         ginnxGh0h1Y4+B686GxTznC8CYQ7jH3Tz1iJsrR0h0E0Ej0VQ30flllU1t9buvhmkinL
         fOWHqF8sk54IFR521Q7RAFH65GFLvNs+0/Nphf4lBUFFjcZSNU8cS3zrMBORzMGllWVx
         VjLScDLZcygCNyo3nBroUMXPZxQ4BvKsiGW6Kg/Q1A5w0a2d+n9h9nUs8sVecnnhnY7y
         IW6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2WYCKL9lkkknDZAveZ/b1N07b9Oh4VPx1+cg48FqD2IGKJbu0QgPzVM7A3CzJATPGn36AOQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ROUWYnsP8uRPzikiBfaQ/YEVwlNJ6rN88TkJiBUpY7cIBaNo
	ywOnvrENdE9DZ1NoRNK1AzL/cw4dA3NOLq2mx0m/korBioiXp9xctEPo
X-Gm-Gg: ASbGncsVWQ7KT3iCeNI+HDb7TVOn5xP17PMDjodFS66LmP6Q4P1Pn/V8qzfYcE2gywx
	FHewsWHxpIB27mXic2m/+QXVZ2cL71VHSjXkonSOv6G1121D+D/cl+Ld0qtVucppgG9c59tQlrG
	aOhgm0EgpCI/QpitrmUpVYeREkn9v13Ib95UAggOLkTxVVbGWZTJK24p2jGEF9zQNaHvah1hyXI
	O2XyQpijPg6obCx2kEoyBvX7e5M/aw/UlXv5bRcX7ZGCDDLVsqZsmghI2M2dHDlOM2y5EWi41bM
	ofeQbmcL3qny1O3lxcFmldOgMKNReSx+VQ+B2oW82DfS4WA/ehYH6oLImuUkt9XTKid6d2bln6u
	Oa4Y2utoTiEdTA8HCEyVFqvJFMilC+is9k9LvNi84hzbddkCCUFERokvdluXep2Q3XCQsbDwsUp
	aa
X-Google-Smtp-Source: AGHT+IEnql9f6VQXY9z+xJPuqmV/UVO/NZG7OfzcZVuiSrpqgNziJ9vCyEN3HJ1eqE7qwBWjWJ2N/A==
X-Received: by 2002:a17:907:3f99:b0:b6d:f416:2f3 with SMTP id a640c23a62f3a-b72d0ad0b7amr205260966b.19.1762523953394;
        Fri, 07 Nov 2025 05:59:13 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm261464466b.52.2025.11.07.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:59:13 -0800 (PST)
Date: Fri, 7 Nov 2025 05:59:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <pj3m2f53zs47z2i6se4qaqs6izwfsgssnslna7ik7t2my3lpcr@7jyvaialnjxq>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
 <4abcq7mgx5soziyo55cdrubbr44xrscuqp7gmr2lys5eilxfcs@u4gy5bsoxvrt>
 <CACKFLinyjqWRue89WDzyNXUM2gWPbKRO8k9wzN=JjRqdrHz_fA@mail.gmail.com>
 <aQ3SNvSigJwffoQK@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ3SNvSigJwffoQK@horms.kernel.org>

On Fri, Nov 07, 2025 at 11:04:22AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 10:45:21AM -0800, Michael Chan wrote:
> > On Thu, Nov 6, 2025 at 9:06 AM Breno Leitao <leitao@debian.org> wrote:
> > >     tg3: Fix num of RX queues being reported by ethtool
> > >
> > >     Using num_online_cpus() to report number of queues is actually not
> > >     correct, as reported by Michael[1].
> > >
> > >     netif_get_num_default_rss_queues() was used to replace num_online_cpus()
> > >     in the past, but tg3 ethtool callbacks didn't get converted. Doing it
> > >     now.
> > >
> > >     Link: https://lore.kernel.org/all/CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com/#t [1]
> > >
> > >     Signed-off-by: Breno Leitao <leitao@debian.org>
> > >     Suggested-by: Michael Chan <michael.chan@broadcom.com>
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > > index fa58c3ffceb06..5fdaee7ef9d7a 100644
> > > --- a/drivers/net/ethernet/broadcom/tg3.c
> > > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > > @@ -12729,7 +12729,7 @@ static u32 tg3_get_rx_ring_count(struct net_device *dev)
> > >         if (netif_running(tp->dev))
> > >                 return tp->rxq_cnt;
> > >
> > > -       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
> > > +       return min((u32) netif_get_num_default_rss_queues(), tp->rxq_max);
> > 
> > Isn't it better to use min_t()?
> 
> FWIIW, umin() seems appropriate to me.
> 
> Commit 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
> includes quite a long explanation of why it exists.
> And that does seem to match this case.

I've send the patch using `min_t` in [1] before this reply, and if
I don't hear any concern about replacing min_t by umin(), I will update
that patch with umin().

Link: https://lore.kernel.org/all/20251107-tg3_counts-v1-1-337fe5c8ccb7@debian.org/ [1]

