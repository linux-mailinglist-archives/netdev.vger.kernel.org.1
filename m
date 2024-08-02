Return-Path: <netdev+bounces-115380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E39461C6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC5C1C20DB8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330D16BE04;
	Fri,  2 Aug 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJCkUR0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6516BE02
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615909; cv=none; b=uHLdP6pFEVk9ohRC1/9og6efMmeNMa5xa1OcyeuNPpaIvMox2whb7qZy1JNX9LmS3/+4SebzWlQZF8MGW+hRYAAhtt3LRE45ZpMsXbYxYVHj13shMbCBnNqXjO7tfvhWodfp8kdrA0JQOwfd8dc1bvrpms3BdNJh0Y5Car1dnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615909; c=relaxed/simple;
	bh=A3oXqoSjCoqStGQatEhLnw4AJIuQLtvHAWqN3eGA6Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdRxrR1SzS+jEv/++fyMocWFgI8mbTlVIOIPIGN8auwr5SRFLKSo9Hrf1NxVLQjvlxqOc3VNmjbWckr2ZVsZ2FdPNaR1xfdcdGv75TekM0mdhnHln0lwelvl/4BuJooyvTJZsuZ511avQfjnmg/7wNDwHtyLwqE5bqdmIBDJjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJCkUR0x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so150425e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722615906; x=1723220706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vb0FTmB8SfX+Sw0RQTwY2OY18Kw+COhw7jrMnQ7GKDo=;
        b=jJCkUR0xxTj+8jslGrRJa0oEEc7gDCrNRvh2ptDXLURvjdFLV8naVVeSNmr2pakEnH
         gVoHh5QdDsz2UTAM5kJdIzsNuDxGL8M08+lOdfnPVQJ4SLSi5nrejTYdfQyNEdzFMmYu
         fOrbwCJac9gPX40ZMvSeHOjkQMCiYfAWT4eP8P6Xu/kILZ1KI1FqtE6NoA5vhyYasfe6
         IdaTw5kkRKmrUoJTgrbr2qQU1aTqb5f+1WeFvI0EIP0d4D554E+gEt/eUvvIYcGHnEtp
         v9pwiqcsmSBOkFnywzF94NwaUaQD7CxVYjNi7UzMtzHKma82z0JtxuFfoVWbMSC1yxvy
         w62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722615906; x=1723220706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vb0FTmB8SfX+Sw0RQTwY2OY18Kw+COhw7jrMnQ7GKDo=;
        b=oKbzLErfpNRDAfXw3GBOI/54uVmMCL27sfCGBuzK3JniWiWagIwxqm+OwHFsxmulaG
         7ZlIGYnDM59pjYKDVQwYft8aF6xYZSFQyJLIv8msqMaVNdSff6CMt5VKlP9WVEtgCld9
         GZGznJMnqpdmt/xhSvglUlsJ2WWCiRN4ygno0q0QMOd/4gebRct+FTKuZS8Ewuqg7hPO
         KtqxxBpNC3fcDJAVSMEqOGDilsaAp0gAv0l2QLfFNfcBuO4zHPOIME9EbgwJRAUbbYk+
         129S0N5mGitEZykreCsv88r5uf1Bq7+GW6AEiOyODjx3LcCmiOdnnwpVZPW4f9vojhHm
         VKPw==
X-Gm-Message-State: AOJu0YxY05/jsD5qyA2OQONK/Y2LCkKUeAv82GCOmATLPvr8mf8YGnAG
	yQzzCEz1FhFovpvkgBEIJwzd7u1/brhGHbQp4Ab5cnDPdXtHluSlDmNrviD57pkxeDyORMi30kW
	cFlkdQIMx82lUJGEsWym5Udo9X1nfs4k7Pmjk
X-Google-Smtp-Source: AGHT+IH+oauFhrGk962P0GyLOjLr5EscUXKbwN+rSQJOLgHMAS/EKcyqui3OT6N8E3yVmftV8W+vR77X+z+SKOTUvgs=
X-Received: by 2002:a05:600c:4f4f:b0:428:31c:5a4f with SMTP id
 5b1f17b1804b1-428e9c6d986mr1229975e9.3.1722615905086; Fri, 02 Aug 2024
 09:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801205619.987396-1-pkaligineedi@google.com> <20240802123303.GC2503418@kernel.org>
In-Reply-To: <20240802123303.GC2503418@kernel.org>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Fri, 2 Aug 2024 09:24:53 -0700
Message-ID: <CA+f9V1NeVd-t2y-MbFi-NhSpCS=sm5Mx9pRJG=u86UkRJx5cBQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix use of netif_carrier_ok()
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com
Content-Type: text/plain; charset="UTF-8"

> > -     if (netif_carrier_ok(priv->dev)) {
> > +     if (netif_running(priv->dev)) {
> >               err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> >               return err;
> >       }
>
> Hi Praveen,
>
> Not for this patch, but I am curious to know if this check is needed at
> all, because gve_adjust_queues only seems to be called from
> gve_set_channels if netif_running() (previously netif_carrier_ok()) is true
>
> ...
>
Thanks Simon. I am aware of it. I am planning to send a follow-up patch
to net-next to remove the redundant check.

