Return-Path: <netdev+bounces-167646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E5A3B4CA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B86E189C78E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A71E51F5;
	Wed, 19 Feb 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbOWhKTF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97C1E32D3
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954252; cv=none; b=WLsdIKxhBXxVTLdmkzBSCmcaoBI4IzpcEzxWlQnXZqUsBvhVma2MSZY12iBLNwP23gJ7PGZ2ALojZ1d9NhYrgAu0lH+nwTPUm/lFhKGPkaZqodkytSdsnZHG+zuIJ00WtSdeaNcrTHFfylMICczsIG0/l2xAfs2Q5FvwAU9cVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954252; c=relaxed/simple;
	bh=/bNbrBFFMVddKdQVi4fHOOgishG5U3ZJbLlFkbCgeWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPu/2/hqMmVcbsZBXehmTP/ppYcXSPFk1rSpfJwBZecH5ue/3GxaeWh6fKUVySV0e8XoDLUIWJ70Kz9ED2KUweyBBl4WUVzuykP+ApNmpy4pOVNc2CfpMJP2nhOoIJdhQii0+yEdvwhyZeLT1IVtZaJnrTJ+9DLpGRuYEl32Iyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbOWhKTF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739954245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bNbrBFFMVddKdQVi4fHOOgishG5U3ZJbLlFkbCgeWU=;
	b=HbOWhKTFmPZ2lhPr2Vmda2TZFf5Emca9SXRGRxxbTOX/Vw9+IuIHqkv96F5ndSVSE6t3cn
	MhyUO3JvqPFxh0Myqe/uMatT90t6HeBeGWxmvGAO89SlIuZ2Vua6iBVWyCoMdC1flOswBr
	6UrZq/Pdq9eVwv6pSuWga88gV0ZnU0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-nQEGWk9wMA67RgGU_oi54w-1; Wed, 19 Feb 2025 03:37:24 -0500
X-MC-Unique: nQEGWk9wMA67RgGU_oi54w-1
X-Mimecast-MFC-AGG-ID: nQEGWk9wMA67RgGU_oi54w_1739954243
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f28a4647eso3454477f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 00:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954243; x=1740559043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bNbrBFFMVddKdQVi4fHOOgishG5U3ZJbLlFkbCgeWU=;
        b=cVDIjctw6Gj+AFAm7zPOsJyaxzpvMGyapxaPECo5Ks9sME6yWrhKYxPfQNmdeatd1S
         RklgXIjGp5AEt+jYiCOExVk4ZRng3DAQ0xOjp/+NRzmXlPdiVEN1v/iD9r2fDByuMs0M
         afjY2qzEhGmLr1RiRv+L3+F5SZYzvqG16Ivx5q5peBYCj3/+tbn2soKVG500nqsP3pyT
         PiE6k6QaN+3okuqFBjvL/Hp2zsfyvnRtbKE8A9KMZakRKn0yh71hboy69/g32mtnH5xQ
         snBTukXocKERv1Hdh5jVUsP73S0EfxmMh6cThnxdTcTIBysznyqKatobn2KrQLVb/rie
         vi3w==
X-Forwarded-Encrypted: i=1; AJvYcCX8Vmz/5mCBHNGKJDBNlZfhZRRMEGyCzhENeU7a6ZU7v5NROghuNoD+qEcRDrH3XWF1fOI3z7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuldwf4XNbsJ1o9KatMeW5JBoMKpUeHsaD7F/M7GXrJdDO4HOk
	XK9+5G5ny/EQjt3AAx1lydwZkDCZIg2GPSGNWk+pd/m3Htdgq9vrnjw06ITijOrKNGcKLBLWDVK
	mRQLPdAVH9ZXNbeXMXdovI2enlFOtW6ySz2Y7dyVFp91yIGHFtjkPTg==
X-Gm-Gg: ASbGncvf48S9Q5InuIq1UnkUh29k2nubNDZJ3MiO0RMpJwvgttMOC1kNqpp/+j64w/u
	1xENYNT2aElqqDya9kswX5cLqFl3sZv5UuYgq+9eEhzu8H757KuQ5YT3UrbhSaTyGOmwoAozrZT
	RTH32SqKCrLbZzQ81nkbCm0WG52XJteLgrQiJPZ5dQxKF3t98nibW5eixGrEgRmjO4Mf3nDokuy
	sqX0sr8tt0B8IVclZf/KLJ6J045eAKNIX/SKvqzUL/VaRmUP2vHKehGd8Iolb74VeNpnuTKdOIF
	b5A8fImeZIOgyink/eSRb8jDdtCPGkSXMQU=
X-Received: by 2002:a5d:5f4e:0:b0:38d:ce70:8bc8 with SMTP id ffacd0b85a97d-38f33f119d1mr14836245f8f.9.1739954243136;
        Wed, 19 Feb 2025 00:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmanNBEc1/LKld7u/WRc22w1ScBQGUbdmsmPp4f8lNHp7KYRRbJFv5zwWdszstXjt/kspTA==
X-Received: by 2002:a5d:5f4e:0:b0:38d:ce70:8bc8 with SMTP id ffacd0b85a97d-38f33f119d1mr14836217f8f.9.1739954242819;
        Wed, 19 Feb 2025 00:37:22 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398e35c522sm58467275e9.34.2025.02.19.00.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 00:37:21 -0800 (PST)
Message-ID: <2ce3a63c-8c05-4b70-a6ed-4131fdf9ee34@redhat.com>
Date: Wed, 19 Feb 2025 09:37:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 11/12] docs: net: document new locking reality
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 Saeed Mahameed <saeed@kernel.org>
References: <20250218020948.160643-1-sdf@fomichev.me>
 <20250218020948.160643-12-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250218020948.160643-12-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 3:09 AM, Stanislav Fomichev wrote:
[...]
> +RTNL and netdev instance lock
> +=============================
> +
> +Historically, all networking control operations were protected by a single
> +global lock known as RTNL. There is an ongoing effort to replace this global
> +lock with separate locks for each network namespace. The netdev instance lock
> +represents another step towards making the locking mechanism more granular.
> +
> +For device drivers that implement shaping or queue management APIs, all control
> +operations will be performed under the netdev instance lock. Currently, this
> +instance lock is acquired within the context of RTNL. In the future, there will
> +be an option for individual drivers to opt out of using RTNL and instead
> +perform their control operations directly under the netdev instance lock.
> +
> +Devices drivers are encouraged to rely on the instance lock where possible.

Possibly worth mentioning explicitly the netif_* <> dev_* helpers
relationship?

/P


