Return-Path: <netdev+bounces-125052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568996BC50
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD341F2198D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F41D88BF;
	Wed,  4 Sep 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpTvzF3v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F861CF28F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452992; cv=none; b=RX6gtqadkgkyrVRiYV7DE0j2L954uiqhJigtAcQsIE7lwFUhYZylFCyB+N/5YhrCXxDwrnmbFcuBVG2mYqwhEs/fAmA8pZgzPujjb7ALjd9NeccqFm4zeCegQwexVRPY1s96ApJ1TQo8n7rXI7o7C/LrXxd9lurWl36mg8AsxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452992; c=relaxed/simple;
	bh=/mEadjI5SD6YX4IRCHi1cGueM0UcKfFREGqcUE671go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad+nkCz/fxLRwHVl1otAvY51bdeXIKsH0CtFkCmvQDbLPhW+zPOF/6+v6uO7LvjSlSfSIWQlsSztGDK5g/Moe4t6OV0SsgEOUDc8nvk/aeQxMqbU8KEKbswGeThg1Nqch/j7+NyW4BtOwG6TRsmOdGc2O6qgtzmDYHu68A+IhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpTvzF3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725452989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OtDRlKx52zIaLvjjoZHPRapnwImYxHHcU/GYadh1zM=;
	b=BpTvzF3vBLdZBUNVgjZz0GL0eys2U1e3KGP0aw2OAKusno/EwEt9IJPZ7ffTqpQMmJxc5P
	FJgqAxFpcSAXue11bSalaHz5wVv+FQZeI4xEiglvjqZ8+wQW6uYeSNo63QeKbM4LgJLwKy
	MQfus1IvsKblF1kbNg3c+SGtzvgADXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-KI-Vi3tWOu-yEshII2FFNw-1; Wed, 04 Sep 2024 08:29:48 -0400
X-MC-Unique: KI-Vi3tWOu-yEshII2FFNw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c7936e564so38809685e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 05:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725452987; x=1726057787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OtDRlKx52zIaLvjjoZHPRapnwImYxHHcU/GYadh1zM=;
        b=qfDmM9bm4X2uwQc/GiCLFM54aEytoS5GAdfnpsKq9dK3z/vnrtAV6SLZu8dTFjz1tB
         uSsz6knN8zAg8f5QJaRPs/qAWJ81kxwWfWltI+I+HxFthQCgRVak9asUQDXvw2NZ30lR
         t7Wyw6wEifTyeOt+bgENBkwqKHamaYSmWxspkyBh9dq7D4+VeFLYLbJGMSfoebRhVONG
         1p3tKbf0/ettf04LaYgcEv5H+BrNim8hMmeE4g/uybhYQ/Xxbjw9QTiG00nx1SGWQNXk
         2K1C/2Dhhart/gGL4QdkukkB9aXM3+H22lDKmlG0B8Iyio8Ir056K/5S8a5ftQS2lVj7
         VERg==
X-Forwarded-Encrypted: i=1; AJvYcCW5M3OJ97ED8RKCgeundT6wMvk8/CDEHbZB7gtNM4Igjz1fhHUOmhA1Vao/lD3QSScVslVbDII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBR8BLMjSsOT3jYMnluakdzEeO60VuTSVtMeyDydvgIy3z8xl
	HlZrDs9V2+QUpzx0nP62Tk+c1IK1dcNBvJnhnL3kBIuH9HA6GD0t1RKE1ZTRqlhh3Vw1rnuzORW
	z7nfFnnoxoFMxpcYsGcNlNSAy/qRUuenpVcHgyD75oW9xTd0vq/Qo5A==
X-Received: by 2002:a05:600c:1ca9:b0:42b:af1c:651 with SMTP id 5b1f17b1804b1-42c880ec221mr57319075e9.5.1725452987429;
        Wed, 04 Sep 2024 05:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWhD0kPiOGhYrqP3ZIajRSUHRGMo1N4q4B3qt63gfMUcv8Fmtwp5DGVkKJNd4lSEMCEJpS+A==
X-Received: by 2002:a05:600c:1ca9:b0:42b:af1c:651 with SMTP id 5b1f17b1804b1-42c880ec221mr57318625e9.5.1725452986372;
        Wed, 04 Sep 2024 05:29:46 -0700 (PDT)
Received: from debian (2a01cb058d23d6001cb9a91b9d4fedb5.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1cb9:a91b:9d4f:edb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm214774055e9.15.2024.09.04.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 05:29:45 -0700 (PDT)
Date: Wed, 4 Sep 2024 14:29:44 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <ZthSuJWkCn+7na9k@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903113402.41d19129@kernel.org>

On Tue, Sep 03, 2024 at 11:34:02AM -0700, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 17:31:07 +0200 Guillaume Nault wrote:
> > Bareudp devices update their stats concurrently.
> > Therefore they need proper atomic increments.
> 
> The driver already uses struct pcpu_sw_netstats, would it make sense to
> bump it up to struct pcpu_dstats and have per CPU rx drops as well?

Long term, I was considering moving bareudp to use dev->tstats for
packets/bytes and dev->core_stats for drops. It looks like dev->dstats
is only used for VRF, so I didn't consider it.

Should we favour dev->dstats for tunnels instead of combining ->tstats
and ->core_stats? (vxlan uses the later for example).


