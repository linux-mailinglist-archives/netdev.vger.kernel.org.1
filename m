Return-Path: <netdev+bounces-120230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090B9589FE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487A12882D4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E61191F9A;
	Tue, 20 Aug 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxFDVG92"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBF191F81
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164977; cv=none; b=OcILn01dL4EW5akl6DuDO0rXyNQzT8htBd46BWM0nabzzECS/FLd+YRxr1fv5irNPuaxSR0pRX8jB+onpasXMWNRW8AOA81TSFsmlnnX9gRG2G/S89oofAlglEsDT5LkDCU6HTTuO2KtC3Mw4ufWZgA7t8lnyB7A/3XHQJResFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164977; c=relaxed/simple;
	bh=ejArwdH/GCuKtYASKHBHy+oCqeyYmvzQZGmVaEqs9hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vos3nhZMq3E1kFsVl3lScrbAEWKu7SZqsyxYVfQvw4YJBciheg1MNySpmhGUr0hkbKa8KsvlFWsQ4CHt+mA60f7XvnSv596oUSK6o1r9JwJ6LhLKSQXd2PVx/srXD5KLtPV7W8n/rxtBKws5gYRX82I9LNvT/r/PokqezBiwszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxFDVG92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724164974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydhevR7sNCZW4QWQke0ngPB+mitsjK/8az2rf5wXLK8=;
	b=DxFDVG92eXzUMdhD1SpYgfZC2QRAN/RLWVkks4m7/O0IR2+yYXS9PMAI+KbeTbAi9tbLSV
	ZEQ6YM69scUZJUcT5hxYIikzPklnT8sfCIi5n/AGVHNHFJnFwcgcExvl/Osii62hin3wnu
	dGNHzTBUEFHVrFJAPkSRwPPIupMGUus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-VMyHHDH4PrOm-OE8d43gSg-1; Tue, 20 Aug 2024 10:42:53 -0400
X-MC-Unique: VMyHHDH4PrOm-OE8d43gSg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-429e937ed39so47043865e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 07:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164972; x=1724769772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydhevR7sNCZW4QWQke0ngPB+mitsjK/8az2rf5wXLK8=;
        b=X4PAzrCET6nesDOuVtTgPa3pymS8LaIJfiaP8Jj5iJZxFQhy5BxI+nsf2/F+E2P/uQ
         nlhKTgyAXoCGBpPRx9ALYcVDKbZYO5wlxGlsKtE2eDvGlbbUi5VHwIFVwT7cH8z7lxmJ
         /m1TY5Vk3Jft++70ic4WPsZ+lsmSDYLrJpKzelPyIgoIsgYeX8ysW9md5szdPGBH2STU
         UpYCncME5gdxd7UDJiOa928gRGdZ5ujFloW+sblc6JVOC5CbCFpinDgd2lj7NMFfY1lY
         iDj76FPIrXgWmiJphavSmZ2Qw7XVCvkX8uCuNmmQw+wLnN65NgPsLNPwx9BNyvoO9lWk
         tUCA==
X-Gm-Message-State: AOJu0YzEGvaFL2ScQkkoTOAaN31KvFUN6Lk4J4/35LHU5nJewnLHm0zO
	v1cFnTACvOKo30VKQ3u+Ncjj4tjaV7pHHJUZFizqRJGlpulUk8gOhNxd78ZY1ziPbC1RXZIyKN9
	+5VuQp1Pz/BH4riXLifNUbF2xbTKlwKCfkr+JsEXzYZNb9QxqlCzHPw==
X-Received: by 2002:a05:600c:4e91:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-429ed7e232emr96770255e9.33.1724164971636;
        Tue, 20 Aug 2024 07:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHVeQ6jHcAhxfzkL4buSeHfHsZ3iDOB6Od9pARovqx5Xe2BHKWBj47sEnzPcyJ2IMCTsGtsA==
X-Received: by 2002:a05:600c:4e91:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-429ed7e232emr96769885e9.33.1724164970597;
        Tue, 20 Aug 2024 07:42:50 -0700 (PDT)
Received: from debian (2a01cb058d23d6005b76a425e899d6bf.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:5b76:a425:e899:d6bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ee3sm196333585e9.29.2024.08.20.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:42:50 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:42:48 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH net-next v2 3/3] ipv4: Centralize TOS matching
Message-ID: <ZsSraEC0ZSGjK/Qt@debian>
References: <20240814125224.972815-1-idosch@nvidia.com>
 <20240814125224.972815-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814125224.972815-4-idosch@nvidia.com>

On Wed, Aug 14, 2024 at 03:52:24PM +0300, Ido Schimmel wrote:
> The TOS field in the IPv4 flow information structure ('flowi4_tos') is
> matched by the kernel against the TOS selector in IPv4 rules and routes.
> The field is initialized differently by different call sites. Some treat
> it as DSCP (RFC 2474) and initialize all six DSCP bits, some treat it as
> RFC 1349 TOS and initialize it using RT_TOS() and some treat it as RFC
> 791 TOS and initialize it using IPTOS_RT_MASK.
> 
> What is common to all these call sites is that they all initialize the
> lower three DSCP bits, which fits the TOS definition in the initial IPv4
> specification (RFC 791).
> 
> Therefore, the kernel only allows configuring IPv4 FIB rules that match
> on the lower three DSCP bits which are always guaranteed to be
> initialized by all call sites:
> 
>  # ip -4 rule add tos 0x1c table 100
>  # ip -4 rule add tos 0x3c table 100
>  Error: Invalid tos.
> 
> While this works, it is unlikely to be very useful. RFC 791 that
> initially defined the TOS and IP precedence fields was updated by RFC
> 2474 over twenty five years ago where these fields were replaced by a
> single six bits DSCP field.
> 
> Extending FIB rules to match on DSCP can be done by adding a new DSCP
> selector while maintaining the existing semantics of the TOS selector
> for applications that rely on that.
> 
> A prerequisite for allowing FIB rules to match on DSCP is to adjust all
> the call sites to initialize the high order DSCP bits and remove their
> masking along the path to the core where the field is matched on.
> 
> However, making this change alone will result in a behavior change. For
> example, a forwarded IPv4 packet with a DS field of 0xfc will no longer
> match a FIB rule that was configured with 'tos 0x1c'.
> 
> This behavior change can be avoided by masking the upper three DSCP bits
> in 'flowi4_tos' before comparing it against the TOS selectors in FIB
> rules and routes.
> 
> Implement the above by adding a new function that checks whether a given
> DSCP value matches the one specified in the IPv4 flow information
> structure and invoke it from the three places that currently match on
> 'flowi4_tos'.

A bit late for the review, but anyway...

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thanks Ido!


