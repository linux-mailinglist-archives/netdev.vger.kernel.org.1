Return-Path: <netdev+bounces-203318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91879AF14CD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F383A6B8D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217726056A;
	Wed,  2 Jul 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HgqKojtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190325CC78
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457702; cv=none; b=BRtV/3ZY9nZyBdyJGuFu2umBWC2uXpeY96XWESvR9+A66NkRlwlO7aYajCSxXEN/p/zns6nRMJMpnPsD4SAHeKu1RxC7VMlVcfyFXJxBLWtub8heP23jGnwi/oR4cWw4LxjUgBZB/BJJ/JOvFOhWsFZpHOjgqRK+Rj+4wFyYF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457702; c=relaxed/simple;
	bh=nIVOyH1pNNhYSIg0y80x9hchFkRGUaJXVGD49xjbamE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK8wHFrvmX7jR/VsFy9ruORF8juJxSG1Gnn417xTaVZmMOEZSq/QZi1CArpGRm3DIGgvZvRdr4vSGqKulVd6o14B1YaTJxbFt4hNWTPqi134vWUCt/dOMQaCUVzqkAeDmHmo2MBhjQ20iB9FLklXZLqkzwXUD9tTSx+r2QkVJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HgqKojtH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so4249255f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751457699; x=1752062499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GP5yXE53ih0sxTNELPBB00JWDnKqbTnSZYff+1z9sqA=;
        b=HgqKojtHbQIpdtF4QNdC33oTdaStSRuXzRCoQF4Cr2opy0KITR0/uDQsHhcBSgUgIZ
         B9nri9yh9WhwPVki3PgRAoF7vU/xPKBCcIQ6hjzlr/vrlxmK4QcWXDARD4S3B8mA1nIr
         n/tQJZVD+39Kpw/cVjcmzZIE6BjC0VVemiYNmYmPMd6ALH11saxnEkVlOXyT4spcSrwT
         MxL1N4F660ZrphSuhgEzGGIWJz72mub91F95y0osSA3c+NmQRZsYkUVsF5toOoNB34Zi
         2lkSv0/c7cWxzGIJORiEr2BqaTe3ljRKsSytEqjKMtly4g0rN6Wp8Jxu7Lrxx6GaoRKm
         hiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457699; x=1752062499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP5yXE53ih0sxTNELPBB00JWDnKqbTnSZYff+1z9sqA=;
        b=B2inV4oV5GGIo3LMoRe0Z/FthAiuNor+IyGVa98LS+RTerBeM19nbLj3j3UlZdqeln
         CwYr2kOY0TiPWo5bdorLWWSNC3WbRME6rpI5gblph+ko9hId8QDCFFLTLh6WBCy7g7rF
         1PF+VCBRx5pgIhslaxs9muzUcBn1k94bYjg3iZ3y5ECxBCuXCiuFoqHB7mhJkjxqJvTR
         AKhIjU7RoH4PxYb52LSHGxsJmb/njngXlkqX9rP6YLS5PyB9hWeVFowjnB8209NioUbt
         eB+ShhBa2TNVUR9Th2X7MIV/kyVr74oOlc/0Zu4d48jCVG1oiTZZi4yl5YGAqrw/cTzW
         JmpA==
X-Gm-Message-State: AOJu0Yy8S5FiekDWkZXr66TTh41WvVHxX1Q9DeSQKTCPGIPYZa/VIa2Z
	wXaA2okgx7KoopFnvUaqR2kcLYxlLyf/qzgD8NHvDp8lyF9cnp22hFLWO4emYaJThOw=
X-Gm-Gg: ASbGncsVQko83HCQskA592dwFRmBwEbP/DNegQieUhqJPtIRrlBhXipMR5DZgsukUiJ
	ii87SHFulkJQeRUTO1BHYmBosTsR8b5pny4gMZ7+96cGKrNn0/Kzgv2KDu1rrtvuMaWpUnbS+zb
	Jt/AoYJPP5gh2W00tO7MxwDoCJqnuPFeF4ZmQurgmFXjVctPBamvZJMQZ6s+DRhJHvPfBQG9n+a
	AHrgYr5jPOsyhAIPo+7r9ggmwXRtMoiDUS/K+iiWCfwQdUs4Csm3IxtXW/9dOU8aqbUkIEiVNMj
	vTi63TLdNjDAdjrN1Y4M/vNY8HLYWyTOG+uV/jivulcwDURMUPyB5PA+TrRdYpkENVH1qQ==
X-Google-Smtp-Source: AGHT+IHB1JKTxeR2sHIwzZ+aS7YH5ll4SYWX78Jqml5XoTj/zuWa+7i2inAbVYYF2YrORcoFyNx64g==
X-Received: by 2002:a05:6000:23c8:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3b200c3ed50mr1295857f8f.51.1751457698903;
        Wed, 02 Jul 2025 05:01:38 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c800eaasm16233867f8f.37.2025.07.02.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:01:38 -0700 (PDT)
Date: Wed, 2 Jul 2025 14:01:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
Message-ID: <cpgoccukn5tuespqse5fep4gzzaeggth2dkzqh6l5jjchumfyc@5kjorwx57med>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-8-ivecera@redhat.com>
 <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
 <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>

Wed, Jul 02, 2025 at 01:43:38PM +0200, ivecera@redhat.com wrote:
>
>On 02. 07. 25 12:31 odp., Jiri Pirko wrote:
>> Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>> > Add .clock_id to zl3073x_dev structure that will be used by later
>> > commits introducing DPLL feature. The clock ID is required for DPLL
>> > device registration.
>> > 
>> > To generate this ID, use chip ID read during device initialization.
>> > In case where multiple zl3073x based chips are present, the chip ID
>> > is shifted and lower bits are filled by an unique value - using
>> > the I2C device address for I2C connections and the chip-select value
>> > for SPI connections.
>> 
>> You say that multiple chips may have the same chip ID? How is that
>> possible? Isn't it supposed to be unique?
>> I understand clock ID to be invariant regardless where you plug your
>> device. When you construct it from i2c address, sounds wrong.
>
>The chip id is not like serial number but it is like device id under
>PCI. So if you will have multiple chips with this chip id you have to
>distinguish somehow between them, this is the reason why I2C address
>is added into the final value.
>
>Anyway this device does not have any attribute that corresponds to
>clock id (as per our previous discussion) and it will be better to NOT
>require clock id from DPLL core side.

Yes, better not to require it comparing to having it wrong.

>
>Ivan
>
>

