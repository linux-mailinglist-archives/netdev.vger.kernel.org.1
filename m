Return-Path: <netdev+bounces-86461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC789EDF8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A227A1F23632
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B015538F;
	Wed, 10 Apr 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnCUYsL0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D682154C0A
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738774; cv=none; b=cjZsMLRo/WyF0tKPI1430SwSWBanpzHfvgReSpBypjd6bYg/bg77xm217fKW8xjo8xpc50fu3lCuhCwD0bgROSNcsqIYaco888tdQ0no2zDaPdAQvVw4xc8pgahJU3HVt4J6V0uBPdLaxs4ubcKBAtrBIbbdJ2k0iDEVqL4EWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738774; c=relaxed/simple;
	bh=3pgPPV6B17SwLTg0XYgMMHEmNOtnjT2keY//R4viWB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dsp/d/nq6cpjNhkzvNDVGMi3QnremQO2fBA+9SV0ltZqFiE/NsgpyumwRH3hlg1tg/VfPhMRVhJ1HExRS3YiuQ43L4HHtiEcLWKUNYlnyWpC1IXZ2f4/cOzwbAcDFVCb8yNiHGdkHf/Mlfru8anbEYfaE6Ryy0Buef0Ox8qwszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnCUYsL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712738771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vs2rp2L6tCQ7g5xi3s0wrn5TKcp9p/YiGVc014R2eMU=;
	b=WnCUYsL0295gAc66AWFzoYN/qzkSCl5V1kHVWDo3orx1mvCfxAtDcey5E8In+N1nZq4i58
	Y3t7sOKcSfh57Z2AreAOhCuJrPGT7y7NDsLBGqbwC1IhP1j4jA3HjiWMJXJTqCNt5x4/GC
	kFzv5aPVIhbWzb8hawDv16GlYHRxKCM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kV1qwjNXNser-bYPXkc_YQ-1; Wed, 10 Apr 2024 04:46:09 -0400
X-MC-Unique: kV1qwjNXNser-bYPXkc_YQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416a207b107so3605705e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738768; x=1713343568;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vs2rp2L6tCQ7g5xi3s0wrn5TKcp9p/YiGVc014R2eMU=;
        b=EwrU1Jq942IPnliFFrPa/IfYUOxung3pxm+0rwyqHvSmOAZ6xeE9dA9/O0eJ3NLZNZ
         cBaORjww7Du/BgE1s/F3DpG2Mn5r5d/3qTdOnuO9nduuMpCYoqZb+nFFzzRjDMSip6dh
         qWPqtRhdlx3ySCpa3YrE6oOQ3yU9D3q/NWeOVXQtKzNBNNDnRU4sxhbUD1tfg+2KIlc7
         yL3dfnQaNaDsj99/dSn6mOc3j9vKcNB3xjNiNRV6nCFbpihgRLYSRNz3d5Vch8LxFZei
         KCgN2uWbCDDExrVeA6YyEJkocg67Hauzyn1WMqTWWoj5bN3w2N4U3E4lCmjPbsBmfTOE
         t85A==
X-Forwarded-Encrypted: i=1; AJvYcCXvEVtfAdNwLt0i1HANyUnZ4E9onECfLkpC26YPoq/B3IlgAbacd4tYt1VTh0i4QjB6ZH58H+9Ais/U3zl+Z6U1qSlxxpQK
X-Gm-Message-State: AOJu0Yz7brx0Hp+01b/uRylUyRHm+Lj2thOguCamgLE+ltEl7DWdjGIn
	MiBQJBiwtzRmwjcbMqXf/Anhuiz+zwXsXA4vWtVsV/RK2G7ZmIqajJ3dby4brgUhlMuDbw9Dxja
	XJAuz2WN83Y6PGvfLShcNSCn8uchcdJaBC82L5JmkE85cZQbz3K8RIQ==
X-Received: by 2002:a05:600c:3b8c:b0:417:29a3:3c92 with SMTP id n12-20020a05600c3b8c00b0041729a33c92mr694176wms.2.1712738768676;
        Wed, 10 Apr 2024 01:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJfzyhNv2wGxGiUu9uxWvkmHt6L2DotR0M9w0HcxAf95iza2ncu4tSL7gteeUokmoVJmNRQ==
X-Received: by 2002:a05:600c:3b8c:b0:417:29a3:3c92 with SMTP id n12-20020a05600c3b8c00b0041729a33c92mr694165wms.2.1712738768226;
        Wed, 10 Apr 2024 01:46:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-180.dyn.eolo.it. [146.241.233.180])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c45cc00b00416253a0dbdsm1593727wmo.36.2024.04.10.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:46:07 -0700 (PDT)
Message-ID: <ae625989c2b1a21b9f2550ff1d835210d2cf2ca9.camel@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: socket sendmsg MSG_ZEROCOPY_UARG
From: Paolo Abeni <pabeni@redhat.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: edumazet@google.com, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net,  kuba@kernel.org, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
Date: Wed, 10 Apr 2024 10:46:06 +0200
In-Reply-To: <20240409205300.1346681-1-zijianzhang@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 20:52 +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>=20
> Original notification mechanism needs poll + recvmmsg which is not
> easy for applcations to accommodate. And, it also incurs unignorable
> overhead including extra system calls and usage of optmem.
>=20
> While making maximum reuse of the existing MSG_ZEROCOPY related code,
> this patch set introduces zerocopy socket send flag MSG_ZEROCOPY_UARG.
> It provides a new notification method. Users of sendmsg pass a control
> message as a placeholder for the incoming notifications. Upon returning,
> kernel embeds notifications directly into user arguments passed in. By
> doing so, we can significantly reduce the complexity and overhead for
> managing notifications. In an ideal pattern, the user will keep calling
> sendmsg with MSG_ZEROCOPY_UARG flag, and the notification will be
> delivered as soon as possible.
>=20
> MSG_ZEROCOPY_UARG does not need to queue skb into errqueue. Thus,
> skbuffs allocated from optmem are not a must. In theory, a new struct
> carrying the zcopy information should be defined along with its memory
> management code. However, existing zcopy generic code assumes the
> information is skbuff. Given the very limited performance gain or maybe
> no gain of this method, and the need to change a lot of existing code,
> we still use skbuffs allocated from optmem to carry zcopy information.
>=20
> * Performance
>=20
> I extend the selftests/msg_zerocopy.c to accommodate the new flag, test
> result is as follows, the new flag performs 7% better in TCP and 4%
> better in UDP.
>=20
> cfg_notification_limit =3D 8
> +---------------------+---------+---------+---------+---------+
> > Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> > Copy                | 5328    | 5159    | 8581    | 8457    |
> +---------------------+---------+---------+---------+---------+
> > ZCopy               | 5877    | 5568    | 10314   | 10091   |
> +---------------------+---------+---------+---------+---------+
> > New ZCopy           | 6254    | 5901    | 10674   | 10293   |
> +---------------------+---------+---------+---------+---------+
> > ZCopy / Copy        | 110.30% | 107.93% | 120.20% | 119.32% |
> +---------------------+---------+---------+---------+---------+
> > New ZCopy / Copy    | 117.38% | 114.38% | 124.39% | 121.71% |
> +---------------------+---------+---------+---------+---------+

Minor nit for a future revision: the relevant part here is the 'New
ZCopy/ ZCopy' direct comparison, which is missing - even if inferable
from the above.  You should provide such data, and you could drop the
'ZCopy / Copy' 'New ZCopy / Copy' and possibly even 'Copy' lines.

Thanks,

Paolo


