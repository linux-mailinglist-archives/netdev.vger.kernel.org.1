Return-Path: <netdev+bounces-105686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAED9124B8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5259289A34
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E261172794;
	Fri, 21 Jun 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6quf9Pv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29265171E5F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971513; cv=none; b=eKPON6HTbInfIkTqv1rbH4+0EsccGZ6x9nej8W4m/OtRypWZizoZZUHS5fhCwHIMWf86H5IUAiE7AKSXAutmpbh+uZuFvPSnMfokyxpfclLaQ/6rITAvTflCtmvm9KBcZtkXP+C+/XwzeLcf1smBj5LPny8r5QGsMV0Btj3x/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971513; c=relaxed/simple;
	bh=cWmRkFC9lz58Kvf89bPTfY2V9NlM/c7e5Z/+ec0yfJw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lca+u54lAC60YNiMyHRDDgBJNFWEmh4u+iuhNza6TKtZ0hD//bi6VoJzRW/hOLF0g4hb3zJpd7sbuU+fsHt7O99Km0XppEqhsS62yiv5ZYcl2Vuc19C9kVlcCEDBHmcBVmexQfh1Xx5gAAv5UiqtQjEBRN+us49BwYSwc0JbSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6quf9Pv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-440609dd118so8665401cf.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971511; x=1719576311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKy8fLfjLp3Tc8D+Yc0B+JXmTfdjQyB1jh0It/7tIt8=;
        b=R6quf9PvqkK7JJpHJ5OA71KufL4y+SM29ay+hFRZ2idfgu50Xy3GGAnuVKT2NndFgH
         cgiBKBKziGhA086OZmT+3CR7dK6Zu/YbB5GsbXRSyUK8UNS0+ik8pg5/Fsq7FV35bLTg
         Yh54OqDb6nLpKmTtplYu9QY2JomyNWhmdGPRfQpKU/k1zNuPMxrxXyYhXPVeTaqV2WAz
         o6fa+os4sqi/VteKBrzfKcwOi9p1cGLQoZqdRJ6CI2c00ZxK4jI+qOqjl8CZvksnb4r2
         SJaFw6joioj6gy+FCZNgsX4LUUZyArsHzwxCtF8n6n3T5DC+BGBnJBU8LD9wnJbNDgn6
         yAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971511; x=1719576311;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VKy8fLfjLp3Tc8D+Yc0B+JXmTfdjQyB1jh0It/7tIt8=;
        b=vXIvwV9mw5F0loDxam5AspipgCDQ2LAthxTiNJNBAollqmC61eNwscb6PjD4fro8yg
         602kwYjpuQKWTJBHurIU+78KoVnpUEQJ0lbUyfsO6Bpc8eEgSaNR2ti47KEjaxKK16Us
         hU7YIoX41+DETaVrNBLzP3jOFalZ6ybIDjV3rvEKf/ZQ6F1yVbDBlRMaCm8VLVkylOO1
         oDUGmS0KokUVMfL+pVHWnxszqjgKL7qUA+CTTa/VvBBBf69nzPP3FFTB8qmBqijGqfuX
         Z71MFfe2ImOKXt97fcyLCxIZfLpEcw2MHn1BG/t/7jOcxi4KYULR2Ykyjj1XQxlILS3l
         xmfw==
X-Forwarded-Encrypted: i=1; AJvYcCWSFkbodMFTX8BKmP6spMUbPVAZUXCFmjbztJ5WVD4+/S3FGycNyvWYPFK+P6UYuVudStO29ky+Up6eP/Hs8sfSd0lqws8P
X-Gm-Message-State: AOJu0YxGDsNxHrCGnA+b/aNGgOyVjRQX+X6IopZpalq6f1TADGDlG3OZ
	+ZDbQow84obaFAcnrfJCHumkncJxQ+8QImS5KmKUC1edotupOZuP
X-Google-Smtp-Source: AGHT+IHk9ofcgT/z5y59gzDNZDwBjp6YDZSVftaMw7MyjYKbTiABaoAc1B+gP1yctzFUB2/ED1BPmg==
X-Received: by 2002:ac8:5d86:0:b0:440:f54d:1bac with SMTP id d75a77b69052e-444a79c1857mr88096591cf.16.1718971510851;
        Fri, 21 Jun 2024 05:05:10 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b36822sm10405141cf.18.2024.06.21.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:05:10 -0700 (PDT)
Date: Fri, 21 Jun 2024 08:05:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Singhai, Anjali" <anjali.singhai@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 "gal@nvidia.com" <gal@nvidia.com>, 
 "cratiu@nvidia.com" <cratiu@nvidia.com>, 
 "rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "tariqt@nvidia.com" <tariqt@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "Acharya, Arun Kumar" <arun.kumar.acharya@intel.com>
Message-ID: <66756c7626a34_2e038a294de@willemb.c.googlers.com.notmuch>
In-Reply-To: <CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
 <CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
Subject: RE: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > 4. Why is the driver adding the PSP trailer? Hoping this is between the driver and the device, in our case it's the device that will add the trailer.
> 
> This for sure is by device or driver, ideally the device. Please comment.

Whether it is driver or device is a device specific implementation detail?

> A few more opens that we noticed later
> 
> 1. Key rotation should be triggered from the device as a master key in the device can be shared in a virtualized environment by many interfaces which would mean only the device can decide based on the following when to trigger the key rotation 
> 	1. Time out cannot be independent for each IKE but at a device level configuration.
> 	2.  SPI roll over, the SPI domain is again shared with multiple Interfaces that share the master key and only the device can trigger the rotation when this happens.
> 
> Apart from this, in a virtualized environment, a trigger from top (IKE down to device) to rotate the master key can cause unnecessary side effects to other interfaces that can be considered malicious.

It is possible to designate a privileged interface that is allowed to
request a key rotation. This should be supported.

For IDPF whether a driver is authorized to request a rotation can be
part of capability negotiation.

