Return-Path: <netdev+bounces-227302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D8BAC1B1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74333B8DDC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6AA2F4A15;
	Tue, 30 Sep 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgxLDkOG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E42F49EB
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221933; cv=none; b=kPzkePRzvWBB3mX/p2dwJpxxkPBYXvIzN2MlpEMWCPrNu/WX0tcVY7Xdue2/BuH7D9L+XIpu/s27ElVcrXT81gKDHpWYO1tm2nodT+cxroEfk0g/s1T0QihEqTsA+AEL5dm/+ZN7mKhx91cb8ZDgLUOfzFn3uOGc2IBAvD/udFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221933; c=relaxed/simple;
	bh=akTONfhlc6noSXEuTwrjzlpLffmAM+CkZ+vcVOLFT7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAdw2U8eTzxWcp8Nek0nL/YXXnaU8enzQo32sqF3KneC/z6lLTS2eE5YmESSFFdV/9XE7iMQ6kuWGD1KctQSoR0Mdz2XuFYW+uiGB2Onk9bq72Yp0N8ouGwqEmfOrPFfhmqbMtVgFv+AkrvVD5NH/uS756icyHAL4V/4aLfaEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgxLDkOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759221929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0eGafpXn10hIE2BMjDxL8LFlIDcwprmVgIo5sjkkOc=;
	b=RgxLDkOGzvv3CWnvjMluJuP9yWgUoHiWjoIalke864VdN9x35Qdc6CaF9CdYWotiNnW/ZZ
	hcx0zFXqXuJKWdliIN6o54AMgBDRdso2wObBaYaRxuruuAFk8yLQn0ghW2ZaEDGqMikI1f
	MDI4t57z0NmXkXxlVKzUYj6ILHN81Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Fkc0qT7qOQG2pWN6qS6z2g-1; Tue, 30 Sep 2025 04:45:28 -0400
X-MC-Unique: Fkc0qT7qOQG2pWN6qS6z2g-1
X-Mimecast-MFC-AGG-ID: Fkc0qT7qOQG2pWN6qS6z2g_1759221927
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e407c600eso23414855e9.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221927; x=1759826727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0eGafpXn10hIE2BMjDxL8LFlIDcwprmVgIo5sjkkOc=;
        b=wcHxD/B7pObUww4IFuSAqlv/ZenTY4yptGLx8qAEGeZLMlT3+8iIMFNZmIUcRIZNxg
         sV1rEhMi1xQSJHhXKoC1BgtJUDdnI8/AptVdt9JzImXLsWvb5WGKoNPLJsnzKjggMLq5
         +kGqvm3A7jsCrfm9NbZwzWfuQwiC8TIddPA0DqCCHQi8EVKFm5R+xb/zrwFOrwhh4wuu
         5sZ50Ctas0A/7XhryF7Zp0PbpGqBF8Ke9PkPmUTUHOkYC42JKedG3t0NFUs/F4uq/FPj
         VR/dC+aMXZ2rZbw4H+1YmKEY9pumQEGQO1RrjFbZtcaYvekN3DXtVpXSBIhjBSYf5tRD
         6hGw==
X-Gm-Message-State: AOJu0YyBwxU8Vw3uIKxUMtAgmyesv/UN91WJ5WLJU1It4LogsxgJesFp
	OtUBodHceho+cqsL2Ks9QbGBA9JvdiQpSwqGwFhBjbTjkXo9e1g870+PUHpNh+PfH2mAFKHUtgV
	URb651R0Sx7MN2ATauG+xDRmZGls35llO/O0QRDY69hCrB6f7juXu9jbh5Q==
X-Gm-Gg: ASbGncso0vfE9YeLt5QBSznDTXAJ5k3fQVPltPCgG8q1V4HNSTKxl8TxUu1+cpvPRKc
	SG/WFwhR9p5vgH6y+qLgI9NbiQD2tU5VFjdzoDELd/3Z7LpWMG8+evh7Xl17+oD6y1yVFDAyPpO
	jFMx8Si8byXtH9MkfHHkHXxRv7R1amd0cxV7FvAHIdi0DWOEdchESyAAV55v56QSPEBT+M84502
	+Met4mEEnRlaVjaZgAJWxdP/9XkemwmtQ/jrKCH4/g9Lm76Ga/EWaK2qW+FWq67fmpXwXvPIvBC
	RDv/bzsnRUXFsWQgGAF1kSKAPJ53ukxdRuEHbB28Jvi6z4/OL8zCKHZMBwpkbntk7U1l2Jc+cYF
	WxZGMykI8YZ+JQcjiGg==
X-Received: by 2002:a05:6000:288a:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-40e43b08daemr16176953f8f.18.1759221926874;
        Tue, 30 Sep 2025 01:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRKeCg7YnGTHgNrPoON/pDG0wzo+V+MgKB/0TsB17QowrUPCybnWt3H7zBthCuTUQFXwPeXQ==
X-Received: by 2002:a05:6000:288a:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-40e43b08daemr16176925f8f.18.1759221926486;
        Tue, 30 Sep 2025 01:45:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2bf35sm21915958f8f.53.2025.09.30.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:45:25 -0700 (PDT)
Message-ID: <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
Date: Tue, 30 Sep 2025 10:45:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, pwn9uin@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 10:42 PM, Deepak Sharma wrote:
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index f6b447bba329..4f67ad1d6bef 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -804,7 +804,7 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
>  		/* This lets us now how our LECs are doing */
>  		err = register_netdevice_notifier(&mpoa_notifier);
>  		if (err < 0) {
> -			timer_delete(&mpc_timer);
> +			timer_delete_sync(&mpc_timer);

AFAICS the mpc_timer can rearm itself, so this the above is not enough
and you should use timer_shutdown_sync() instead.

Thanks,

Paolo


