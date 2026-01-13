Return-Path: <netdev+bounces-249381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A3D17DA0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493A5308559B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D0387379;
	Tue, 13 Jan 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRGDB7s9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSzmEWb0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A9389DFA
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298498; cv=none; b=Rpb2Ba/RUpNDsx6c2EEIqYK+XuYnl6VYxSpeCEuM1/gum4VtfSdOnsoE3aNq16C+IN6Dro+TUOg6nD4ipxFThJo9CFx39MVeQXDC7hyh41Px5nH0y0GWy68bTAj4c0MgOAsvkQ+SUgSYvIjQ1+T58DSmnScPRi8jsvB81BEvwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298498; c=relaxed/simple;
	bh=QiIO06NbOtKJd7noNM+naDyDMN3dR3vKI6X6b2VLfDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIY4u9fh3fqr+o0bDm49f4hOHgEjYZV0+Ehe0gmPL3xuEO1z4eM4sRH4bjQXQs8d2QJWLAfN/UnCxjQzka2TUdgGvbIccYNi0xRoJaBwKuLxmKolB60b/0X6QXU3pkG0A1gS11hwqH9dFKx7HPj9GcxlgTE1QfMvUGBssuzKTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRGDB7s9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSzmEWb0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768298495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkLupUEBEy8efLEmzphE1FsQt9S1AcRYsLtzY+j5s8k=;
	b=FRGDB7s9HXPHsFSHP9RdfgTRB6fd0OWqVFsL2BNv4mqm8MLK7HQh1Z8aVwXKS8RS6aaqr7
	TSwc8aZ3VcJh3juJ8NjAphz/apj39wizLX1aAWOqGcWD/jJ7uGXwR+qtCjlKIWNR9pWwFC
	mIHbIeiBMT+FuNeVLuA5GJfs26Q04Io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-TbUdMPOIM0mDFVaXyyhiLw-1; Tue, 13 Jan 2026 05:01:34 -0500
X-MC-Unique: TbUdMPOIM0mDFVaXyyhiLw-1
X-Mimecast-MFC-AGG-ID: TbUdMPOIM0mDFVaXyyhiLw_1768298493
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso32470295e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768298493; x=1768903293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkLupUEBEy8efLEmzphE1FsQt9S1AcRYsLtzY+j5s8k=;
        b=CSzmEWb0QGiiuR8alo8JjAmrOedEm9FWGHhAZSIKaEylj7puCEwAksucqW9CQKpLwM
         a8+fsjfbWQkw3fz7qRb3/mKX654KO6TJi6jEt8k1lJ+CFPt0F/4LrkVh2m1smUdkFkVz
         5OGyFqhpmg7XVTbTsu9UkzYeFu4GSvYwsavbN/xu4wV4yeqlUpPG+bJIiTgN6KzMpy+h
         //08rc9LV/eGezv4Qkm2LUegUHsVO8NUUohqRksoR6eVJShS0ODQzj8p2qya7H7r3ymf
         DnWg396i4B062B365bCi6mKhjXItyfRzgrSf1MCpODqhpSv7+JO2rkgBgh6SvrnHZd2n
         cZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298493; x=1768903293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkLupUEBEy8efLEmzphE1FsQt9S1AcRYsLtzY+j5s8k=;
        b=b+rRJOC16//zDXabpP615HJjfXS0KGpx5AEq7dUG+f4O4/QTy+RcLvRG09NjZmoxCi
         vtDwcHjdaVyC4AwSitq0uCKN7DAWzY78DG3HiMls7ZZLrGQ9bm2Mggg0SU4mbJq9xPSA
         NwcAX1HcLioEiULErYE1ut/y1yaRiqOaKSuDMKx6WvsIbgr/NT7G7fT1rv9n5rvn4F35
         4euXMawJsY9+X4gNuBa2CqaUehXkbGOvcQm0qfQ1MQ341l6MjdqA0ZbwxMSDio7PQFD/
         anl6aVGq/Ip/PV7Ju+lCrE8yXSyUSOogmQ7NBMuao7kSJyWcLmdL+BO9vplTy+L4zfLp
         SnPg==
X-Gm-Message-State: AOJu0YzRO051OCU3PxOLh0PzQb/Z1dWDDWKC5leaf3eKIZcS6wTwBNNh
	hKt967BXWZfiFN7Zdu4kAvOrtdBYRaIlF8r7pVXisuqBlSDZ6JxLpTdXBCWp0A/yiMN7EnU60dm
	cgeensokII7vyUjM47BZwCucXBQyrjy592r1ZVSUM5dNJeQg+cycEkKi/Qw==
X-Gm-Gg: AY/fxX5XYWeJ97nhv8cvZ05ap7VMrDimUktLl8iiqe3tgpI0Qgi7kQHLfvMIhBFlO7x
	4ThEwqpqGG77vI+kenxK78aGgnAkQsq1zrYfLREUQApbAhNx66poTP/F4xLN1cCJuLq0RlbEkw1
	pGoQd/A0SNems71J1Z3DZ+cvIn++ePocCW/T5tzJhwquS55mUyGZEQLBAljLvxvCvBSCcCi2eAq
	B7lPqXLY+avfWa3nS3TA2zxShA+2URcPkcgEtt6rNrbai5mBkfqV9fZdT/8Ual0sBGebVhaEqpM
	eEqNy043Z9BB0d5GKtcjANfOeXlYEACOImvC/0MH+WskIIPzPtFjLxmkg1YzX38wXVLNBm9Nbzb
	sx7+so5h0KHwc
X-Received: by 2002:a05:600c:19d0:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47ed7c3b7a3mr31104345e9.16.1768298492807;
        Tue, 13 Jan 2026 02:01:32 -0800 (PST)
X-Received: by 2002:a05:600c:19d0:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47ed7c3b7a3mr31103925e9.16.1768298492364;
        Tue, 13 Jan 2026 02:01:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda463e92sm11337985e9.16.2026.01.13.02.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:01:31 -0800 (PST)
Message-ID: <eb4bf4fb-a1a5-4e4c-aa54-aef6b131ea2d@redhat.com>
Date: Tue, 13 Jan 2026 11:01:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] r8169: add dash/LTR/RTL9151AS support
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112024541.1847-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 3:45 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds dash support for RTL8127AP, LTR support for
> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 and support for
> new chip RTL9151AS.
> 
> Javen Xu (3):
>   r8169: add DASH support for RTL8127AP
>   r8169: enable LTR support
>   r8169: add support for chip RTL9151AS
> 
>  drivers/net/ethernet/realtek/r8169.h      |   3 +-
>  drivers/net/ethernet/realtek/r8169_main.c | 130 +++++++++++++++++++++-
>  2 files changed, 130 insertions(+), 3 deletions(-)

Note that you should not have posted this revision with the previous one
still pending:

https://lore.kernel.org/all/20260109070415.1115-3-javen_xu@realsil.com.cn/

I process the patch in order and I applied the above before reaching here.

@Heiner: I'm sorry for the confusion; the patchwork backlog size called
for somewhat urgent action and I thought your doubt for the patches
posted there where solved. Please LMK if a revert is required.

@Javen: please wait for Heiner feedback about an eventual revert before
any further action.

Thanks,

Paolo


