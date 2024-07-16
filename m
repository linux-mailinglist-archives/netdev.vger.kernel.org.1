Return-Path: <netdev+bounces-111809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FB932FC1
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234FE1C22005
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297CE1A01B3;
	Tue, 16 Jul 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QujV4/Oe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E119B587
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153499; cv=none; b=RVN2OjFxMM7gbxEUn3u93N7JECvoD/6hSrNLeG2uQxXJx2QeID9BwTJNL7bBeBZxCactOEA1tZ1DvoD2EFfm8/UBXGo5D08Du3S+Gm6Aaa3a9fpFbaPqb32I+1UTBwDQznARGPy5nOhhVeMrfLptXSQ56zw78lqJ13+eIsY4k78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153499; c=relaxed/simple;
	bh=bikN/RuZjvbf9tFWiqRF9s31aXIKoMoeOvEsrIbDkJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/jX90XZVbnzuGyd56nImukj7KhdCxRwS1bZsXagT3ChGUPSG1V1OTjICBogYHUnLtefctLv46Sw/5W+IHDFyEuTnCjMzMeiBP4ZCaCBoc896z/Or8wF1/lx4lvKqf5oMFEG1Ucmv7tpqoj3r/IdYKKUKn6KdMA1QIl8OHbVAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QujV4/Oe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721153496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/KJbSvYczm8IBPIU0yUQmJj8mpbQtOKhuPcIFJ/hSU=;
	b=QujV4/Oe0vwBKPs7ZHt6lCJAHexrGHgnhg5LGx746roPxBOIQ6fQz2T4ZjFtayn2ltloDF
	1v4Pl8ap9JOsRwrIB5kRoXLmJ+j3HE7wyEEWuQhKEQBhD0oJi+pGmv+iYAQ6QceBtrXycD
	kI2CDkM9Q+/gtRk1mPjaJzxAGP8l/6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-7uNG2hMJMQq5vHBbkYyFQQ-1; Tue, 16 Jul 2024 14:11:34 -0400
X-MC-Unique: 7uNG2hMJMQq5vHBbkYyFQQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426703ac975so98625e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153494; x=1721758294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/KJbSvYczm8IBPIU0yUQmJj8mpbQtOKhuPcIFJ/hSU=;
        b=tjcdLTWoGd2lgWnPb8REayPagj3DxRcyu61a46bOYRmVXnc9PPn+PucSlFfsEIEHzA
         eVwSbf492O0SLnSD32VU3DUnYTdGLr5FfC8R/0432AoTQiNnPKdWXMDqRWPSGvGr+9i3
         aSVP2otpPnJyP1koeYgXPG+SENhwOWjqQ7jJqF0cgsHc5q7bdLNGve/tLKw128oFeBQo
         No6n0iYQ4mo8w5DLPgunoxoLs2tFK1vzkLtSwWta+ZGRY59Oe+R92oS6oE1+aRnvarAx
         viPAAitq/xs53MoM8RKkoeZOAxtbPHT5on3FePR/RAYnl5m7HW3H3Wxaey2sBN5gTNmg
         6e8Q==
X-Gm-Message-State: AOJu0YyN9O708RHBA5m7hpt7AOlga5q/JvADJ6Sm2TlzJG6TZW94BSwl
	KhCgb+b+5jMczy4VMUlRvYS964B+dXvhCr2kpc+etV4KbZfJHyOL2zyiSUs5zpd3o/8sX1cQPI7
	ca26OBnxQLvb1qm/jZI4lomxZEgUqgmoJ9ZEpXCcUsIZ+CdrgLOpS4w==
X-Received: by 2002:a05:600c:3b89:b0:426:686f:7ad with SMTP id 5b1f17b1804b1-427bb6d35bdmr22326135e9.10.1721153493785;
        Tue, 16 Jul 2024 11:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH85ma9p7lMegI6gqqGWceRUX0+O6xKzznwHixGOoSyGeT+XxQY/2vPLhonidTaJ2UCovWQQ==
X-Received: by 2002:a05:600c:3b89:b0:426:686f:7ad with SMTP id 5b1f17b1804b1-427bb6d35bdmr22325915e9.10.1721153493181;
        Tue, 16 Jul 2024 11:11:33 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef550asm137639795e9.46.2024.07.16.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:11:32 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:11:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	roopa@cumulusnetworks.com
Subject: Re: [PATCH net 2/2] ipv4: Fix incorrect TOS in fibmatch route get
 reply
Message-ID: <Zpa30mhAqoG5FP1X@debian>
References: <20240715142354.3697987-1-idosch@nvidia.com>
 <20240715142354.3697987-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715142354.3697987-3-idosch@nvidia.com>

On Mon, Jul 15, 2024 at 05:23:54PM +0300, Ido Schimmel wrote:
> The TOS value that is returned to user space in the route get reply is
> the one with which the lookup was performed ('fl4->flowi4_tos'). This is
> fine when the matched route is configured with a TOS as it would not
> match if its TOS value did not match the one with which the lookup was
> performed.
> 
> However, matching on TOS is only performed when the route's TOS is not
> zero. It is therefore possible to have the kernel incorrectly return a
> non-zero TOS:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get fibmatch 192.0.2.2 tos 0xfc
>  192.0.2.0/24 tos 0x1c dev dummy1 proto kernel scope link src 192.0.2.1
> 
> Fix by instead returning the DSCP field from the FIB result structure
> which was populated during the route lookup.
> 
> Output after the patch:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip route get fibmatch 192.0.2.2 tos 0xfc
>  192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
> 
> Extend the existing selftests to not only verify that the correct route
> is returned, but that it is also returned with correct "tos" value (or
> without it).

Good catch!

Reviewed-by: Guillaume Nault <gnault@redhat.com>


