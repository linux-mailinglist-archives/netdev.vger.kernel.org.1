Return-Path: <netdev+bounces-223441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8CBB59241
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F16595E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351C2BDC1B;
	Tue, 16 Sep 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YZNuJBqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF829E0E8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015075; cv=none; b=l2T0L30jhPqSRMUcn8e5G/o9sLvEAyMxWgzb2l+rfdnYal/B5lEUBk+yJilILZOxSwtk9ooi/nLOoPxXZndj7jmTVdGokOLJzbnpCHaMvQ85xyY11+WF+DS8QxnSn6WiyJRCXh4XYv5hmoKM1NN6P3C6Ter0VFJ4ZW7ZoVf6uDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015075; c=relaxed/simple;
	bh=G5DKJK3CELjgpndrNA/+eHqI1RVUDy7+NIgwgAlKssg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4YR2W3O0vzTm9fw9kxSeVD8ow5SIlqiAet6cHxK/325lh3r+7nUloGVEIQb5QTH1rBnvLEIFc/W7tyICPqc8sjQN60ydBtaLGzW8JlLxDppk/vwoLxxtBUeR9RtRi4Rz+oZsnACs2Vmfh8W4KLfn5AL9RZB/uBwU/UgHRgY2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YZNuJBqu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so10818985e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1758015071; x=1758619871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ACpTvDk4rKkRfQ2RQ4sxr8j1UikIa22f7RQMKzB/pRg=;
        b=YZNuJBquxbhPFirZrZK7NYrrhJrCjpOG0kGgAY47Lr7F0TXTMcCVUdtjFuhDb88l51
         2BszKTLLZnttGF7JJCiX9urlimaYhq2mA3nRKB7P16jim67VSirJ1MSqOS/YCpxPpU3N
         JMrSkC1yarTUQ6Iu0TEjD8qke4gl+zLXsSN9YxP3rNJPBDjnIn814v0ZPPysHE37iMyi
         n47vbPjX8wjZ5es8QWIbrtA5v6DCXorVwW+lL6keMhUW9KufG3KkNbYLJx5kRGmFB4h0
         XLpxdS2G9uxm1jUYIItn0FsRG00A7rIPQKfTFi9Mn6KXU+9FXoiRvyDhTRHGoUySTLgz
         0s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015071; x=1758619871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACpTvDk4rKkRfQ2RQ4sxr8j1UikIa22f7RQMKzB/pRg=;
        b=fRgt7GkXY1HESbh/1t4vzPlkw8giADFLJUVB7VqgXxZre0T4GRXFiCYflxTwnl6HAe
         AXTHfAqUhVBE6kcv+yWUukWDwovIuUfnqyUafBm6ek/IjH/epNC3lYcVD6YMeljAfqUo
         mlLpWZuTYtfDLQuYL/6WXE7wxc2Jp3QO5HOicweuBdfRClYN5rVfGUujA9AxNGBAmXWv
         rUltty7V6r7GJ7g8PiMn9NfMFMoAs6ZdKOqP2Rm73mCtoRgrHsJ575AGAm7h+OHbAK00
         3GhbqGSDlO3sA4DdJwBlO3fc3T4Lhj4NMjoeKz2odOSvjEhNkjZcO6HdM48+Xm1H65+i
         GFbw==
X-Forwarded-Encrypted: i=1; AJvYcCX8xv7YgqKe7Khds0l5+tziq1dXBOY0jDPkp8kF2blwRHHXyn+GbT9Z/ttqR0hLdW3oIl7kfgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjN/8TF08KSbbs3ipLkiFOKqnV61D1gXGn1VkW9F6EYwzL+5FB
	GkwVge2o75sFpDaDtFzQvY4novyQWV4CNIyIsgvLEKm/ZKrytDWoKIqj4FdlSJaP53Y=
X-Gm-Gg: ASbGnctK+4c52RYQYF5JKdNP+gvo2fLYieFQ7XQ/Zq9dJuJBi5K02oEdkJzjvjBPPji
	S+W4+DLTvx5cQuEIajl068A2XMMctwXezEVxslMKaavUPfD0UZS2jB0mKsRdiEmVq1mK7Fqc+a4
	v7rNqU8AytDm7TmiazsIk9woQ9SxLsVZQxSx430p7ErR2r9XBRIz7Cpt//eC0IMDKGhZmkq65tR
	9hyEjAsh0m6G/wm7zumW2NAZmdX31hivZ6Z3nvd46eiMiaapZz4TX4XIJFJEKKnPhMYHE7NvbY3
	C42WDyxwdfLvA5sLsbBuvMT/tGWfU97kDknDappSHC3TIQbppV4DUEmEMw6S224jNETXcuC6MVB
	0XaPsJmLmiePIrYYB/pmlqknI
X-Google-Smtp-Source: AGHT+IH8DCDGESmWObhYAAet3S0BhH1Fzzukf1zx3cCjpw50+fa6UzbNTX5giSJQmy/9uVP0YCa3Ow==
X-Received: by 2002:a05:600c:828c:b0:45d:98be:ee95 with SMTP id 5b1f17b1804b1-45f211caa67mr130397715e9.3.1758015071252;
        Tue, 16 Sep 2025 02:31:11 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325a32f6sm13224245e9.2.2025.09.16.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:31:10 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:31:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
Message-ID: <nj6wipqud7gnaiuvj6cl4sum7zfyp7jdvjb63op6ff4ruz7rjx@5rtkshsuxojl>
References: <20250815144736.1438060-1-ivecera@redhat.com>
 <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
 <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
 <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
 <CAL_JsqL5wQ+0Xcdo5T3FTyoa2csQ9aW8ZxxMxVOhRJpzc7fGhA@mail.gmail.com>
 <4dc015f7-63ad-4b44-8565-795648332ada@redhat.com>
 <350cecaf-9e41-4c34-8bc0-4b1c93b0ddfe@lunn.ch>
 <dcca9d10-b2b7-4534-abe6-999a9013a8e9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcca9d10-b2b7-4534-abe6-999a9013a8e9@redhat.com>

Wed, Sep 10, 2025 at 02:51:33PM +0200, ivecera@redhat.com wrote:
>On 09. 09. 25 3:50 odp., Andrew Lunn wrote:
>> > > > Yesterday I was considering the implementation from the DPLL driver's
>> > > > perspective and encountered a problem when the relation is defined from
>> > > > the Ethernet controller's perspective. In that case, it would be
>> > > > necessary to enumerate all devices that contain a “dpll” property whose
>> > > > value references this DPLL device.
>> > > 
>> > > Why is that?
>> > 
>> > Because the DPLL driver has to find a mac-address of the ethernet
>> > controller to generate clock identity that is used for DPLL device
>> > registration.
>> 
>> Maybe this API is the wrong way around? Maybe what you want is that
>> the MAC driver says to the DPLL driver: hey, you are my clock
>> provider, here is an ID to use, please start providing me a clock?
>
>Yes, this could be fine but there is a problem because clock id is part
>of DPLL device and pins registration and it is not possible to change
>the clock id without full de-re-registration. I have provided in zl3073x
>a user to change the clock id via devlink but it means that the driver
>has to unregister all dpll devices and pins and register them under
>different clock id.
>
>> So it is the MAC driver which will follow the phandle, and then make a
>> call to bind the dpll to the MAC, and then provide it with the ID?
>
>In fact that would be enough to expose from the DPLL core a function
>to change clock id of the existing DPLL devices.
>
>E.g.
>
>int dpll_clock_id_change(struct module *module, u64 clock_id,
>			 u64 new_clock_id)
>{
>	struct dpll_device *dpll_pos;
>	struct dpll_pin *pin_pos;
>	unsigned long i;
>
>	mutex_lock(&dpll_lock);
>	/* Change clock_id of all devices registered by given module
>	 * with given clock_id.
>	 */
>	xa_for_each(&dpll_device_xa, i, dpll_pos) {
>		if (dpll->clock_id == clock_id &&
>		    dpll->module == module)
>			dpll_pos->clock_id = new_clock_id;
>		}
>	}
>	/* Change clock_id of all pins registered by given module
>	 * with given clock_id.
>	 */
>	xa_for_each(&dpll_pin_xa, i, pos) {
>		if (pin_pos->clock_id == clock_id &&
>		    pin_pos->module == module) {
>			pos->clock_id = new_clock_id;
>		}
>	}
>	mutex_unlock(&dpll_lock);
>}
>
>With this, the standalone DPLL driver can register devices and pins with
>arbitrary clock_id and then the MAC driver can change it.
>
>Thoughts?

The clock_id in dpll is basically a property. It is not used in uapi
(other then for show and obtaining the device id). So if you introduce
a mean the change this property, I don't see a problem with that.


>
>Thanks,
>Ivan
>

