Return-Path: <netdev+bounces-122402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0C96114F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159581C2371D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FE1CEAAD;
	Tue, 27 Aug 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj9jUvKO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DC1C7B9D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771861; cv=none; b=JB70t0NHDRjaxdIBtr1SZeWbOSi00bcQu44bVIOIm596xiysBUkECSyvjum+hKKcE/OC6A/FcBgdWdR+rT5PcBng8XSIpO2Ex6+JAceNBvfrTLEdemIfEhg0c7mo27tja/B475VLDwZcmUKYxfWkyLXwir/uwB/qmznL4GAki6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771861; c=relaxed/simple;
	bh=Uis5UcWx7ESlkENuZddUEHlXPVlgyb9s9E+Dsu2AWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+r6R/GISL10DARO++qWZ1J3pQujesN7/HR93xToB9FMK7UJnHBzm8FyIqF2ShzIWaem+VBzDdt/emAVP5kG3jWadpw6ttuMRjq4usA1pTEeh4szha6N+OAaZiEJx3TTFP9LO8cKdA2JfRhPjcvRXdtFE1VrD+JhjnUR+Yr4VBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nj9jUvKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r02ycll/0+vd2yPmctrGqk6tQvR75YJwftDX2X34Trk=;
	b=Nj9jUvKOQPd2Lw1gBsFqpuJiS35/flZvLsM+1FBBL+J5BDdaaIIx6aK0YqFHPNrRdUGJUd
	2UMUUyds73ALxSt8K099Lp3msSDbYZqT6525dAW+6rToFpgDQUr4nyzAy9aRlqkt6KpzWV
	0ePTKMdmK5A2UtYfKN4BBLQv7uJ8ZoA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-4X6C3JEQN32ZGjb00WLY3w-1; Tue, 27 Aug 2024 11:17:36 -0400
X-MC-Unique: 4X6C3JEQN32ZGjb00WLY3w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718eb22836so3613292f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771855; x=1725376655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r02ycll/0+vd2yPmctrGqk6tQvR75YJwftDX2X34Trk=;
        b=QkV3JToiixR9YmRFewwMq7Z4ZRb46WWdmYQEX1LDaAndxRrKfgtiLXT0Zu851TigAY
         gH2ODfGeTM3B90x2HqkjEpiSPMunRV5sJtQPP7rfgD/p7d+5+vUrQUmvaRp0hKs8BSne
         StrEZCbsmsfoGo/lQsUH9jKPVsc125XHP1xQ7mDJiSDqk+9Wa0xpMxzha1IX98J+jGBU
         U90sBEqo65c8lonXOuqoQ5GjKAjOYcjHazJ+a1lm0ENxJg88qZYzRTNAY/C1EHEpwxMz
         Q5kwZ8uAPH95bfIiCe1N4Ug5mmyKvcbEZgA6Pu4ROh/ExBVqBPo9CNo+TIKqDppiqqbk
         NwoA==
X-Gm-Message-State: AOJu0YxVNhYkke3GaMbzZZOKUxFUYgoFzRhS8Uf362+1ecboI2Sydwyf
	io5rxqsEUuELb9tDjNz9Pi8ziitY2gtwNWGfvaLBo8b8Lw9awuVtaBqedMWMI6SxmAywfa0JavO
	TygEZJwL3jXuOP5OuazOFwgd7YrUcDs8uwaU0Ee6sPhhwUoWR93xxyw==
X-Received: by 2002:adf:f24d:0:b0:371:941f:48f2 with SMTP id ffacd0b85a97d-37311865284mr8397731f8f.32.1724771855070;
        Tue, 27 Aug 2024 08:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELEUy4Prnr9PE8d6tJK0MjviDOOjG/ZZtWnIZk+XgFtC6kYa611ltjAGDxlvpBWZTu5GJaKg==
X-Received: by 2002:adf:f24d:0:b0:371:941f:48f2 with SMTP id ffacd0b85a97d-37311865284mr8397686f8f.32.1724771854246;
        Tue, 27 Aug 2024 08:17:34 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c536sm13546752f8f.36.2024.08.27.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:17:33 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:17:31 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] ipv6: sit: Unmask upper DSCP bits in
 ipip6_tunnel_xmit()
Message-ID: <Zs3uC1rpGScO4Cvn@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-10-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:10PM +0300, Ido Schimmel wrote:
> The function calls flowi4_init_output() to initialize an IPv4 flow key
> with which it then performs a FIB lookup using ip_route_output_flow().
> 
> The 'tos' variable with which the TOS value in the IPv4 flow key
> (flowi4_tos) is initialized contains the full DS field. Unmask the upper
> DSCP bits so that in the future the FIB lookup could be performed
> according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


