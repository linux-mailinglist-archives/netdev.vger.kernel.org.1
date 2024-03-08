Return-Path: <netdev+bounces-78880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B05876D61
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039261F21DE0
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442F374FA;
	Fri,  8 Mar 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NfiUC6k+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E41F93E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938743; cv=none; b=K/1TUTZS/HHC6j810lZZfQrTVhJwL+DAj9b9f4MbZjkJq5DyUwMIdcegsxvJAGQuVQ/RrT7/r0N1uK13d+hrJtZoe/l4I5nZZbnsMpr2tk4Xtrnkh894Upf2lQcFZFmtRsypQHQhybaK05Xas0PZZniVF/8jATZyh5prHDGXUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938743; c=relaxed/simple;
	bh=1GCz/JFm1xNbIEujMjBxX66BJG+i6QIqMIQHdK+rWfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIcTJceN687pZJe99Mp4SllD0W5wo41wGK7Tb4aCKhjPIhO4QH/HXJIgkRbgndpS1Wn3mUwdqziAhx7Jrziq6W5/2mAqPY2OaVbhS3DPbAIejGMb7GEm3n7oiXJ+//+MNdsyfup+/AgsO0qHojSwSvS0yJJM6BEC3g6/TdqbmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NfiUC6k+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1092132a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709938741; x=1710543541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZbtAb2ae1odbaBilqx8BT3VuF4lqcL+pYvutOBzT2M=;
        b=NfiUC6k+abVOQECWH981LzGBgm94pAXz4zpBEDXP340TWkq1rt95XX6tXtIzZvjb9d
         V50KT/pFPUfWgbvXtlCVbJZcjQVGTGkMO3bEjg9qA9t76kh8LWYzYH2LHTfZ2GZoL4yf
         3OOMg/9IS/ieYH4NzvkD3VwhOgRTpAoacbMufpVkQGH9Uaymj4gzABXqIXTylNzUC4YE
         0k4/rFD5puy//LSgVRt7jl5ERRYOjzuKALJf6uxB/BeofBYbV8pbX5JiP9lp0i5dPSwy
         r8awxP5FkIfh8SmRgd0KuE8sTQU7fPaJYI7k9+6fh7kTaFIXkoLJ2+ny7JKYWvEW0CZ3
         okGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709938741; x=1710543541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZbtAb2ae1odbaBilqx8BT3VuF4lqcL+pYvutOBzT2M=;
        b=lG5bDgKLq9/VuVnoZ1wAw//L4TyTMMg9bRCmh6D7MdFUrlpOdEhYFnLqT6QNzQMGkZ
         uI5X9ZjkQnmlPqwd2rtJOMejs0DKR9Z60wsZFkXi4Tbb+lI6+zxkXmc/ajjAmVZyAC+U
         cWQTcKTXBNuCTKN9/O5rSW/h9xYVfe9caAVUcI22NzSQtxJ5traIJFZdgm2zFa66hhCd
         dLOmMShmasiF9RctVUmr8ixsXVTCkiip0Gytp+8w1Ql8FP39I72Y0vCil3GgkmbbXsWv
         /dq8iycRxWmFrSH8Jxme89GGu4Ds8vnK3lgMko0iy0smR4a594fKK9BLXggNezSGPnM0
         xBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWb6WRxLH2ZFILrz+KUNOLBBMQkIGFZfYnLSgWvvrbYzKzNWBmF5VzSvJGPmURAMUw/NwsSCGJETrP5RLlXO2Srf9fVuJ9m
X-Gm-Message-State: AOJu0YzSztJGhQVWvOO4riOAk1H3IctCvSNkDN9Uk15NMbYSv2wVC3Kl
	VHGoRi5YsynqL/k4PxUJZRgPLsPDXeoGXLuEDMKzUycV6Hu4sXhyUGnbub+3ufs=
X-Google-Smtp-Source: AGHT+IFTC5wipJHYEnkszRZAkciHwP9sM/5/lLgtohQJLtxcpdd5z5OOiqS3ca9zhPm7/yMhZjpQFA==
X-Received: by 2002:a05:6a21:3405:b0:1a1:88ae:4ed3 with SMTP id yn5-20020a056a21340500b001a188ae4ed3mr98766pzb.35.1709938741322;
        Fri, 08 Mar 2024 14:59:01 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z21-20020a170903409500b001dc23e877c9sm163405plc.106.2024.03.08.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:59:01 -0800 (PST)
Date: Fri, 8 Mar 2024 14:58:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Message-ID: <20240308145859.6017bd7f@hermes.local>
In-Reply-To: <501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
References: <cover.1709934897.git.petrm@nvidia.com>
	<501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 23:29:06 +0100
Petr Machata <petrm@nvidia.com> wrote:

> +static inline __u64 rta_getattr_uint(const struct rtattr *rta)
> +{
> +	if (RTA_PAYLOAD(rta) == sizeof(__u32))
> +		return rta_getattr_u32(rta);
> +	return rta_getattr_u64(rta);

Don't understand the use case here.
The kernel always sends the same payload size for the same attribute.

