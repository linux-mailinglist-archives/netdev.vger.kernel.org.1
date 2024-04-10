Return-Path: <netdev+bounces-86417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202D89EBDE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B47B22144
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766C40BE0;
	Wed, 10 Apr 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pFOFv+Yl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769ADDC1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734008; cv=none; b=Ib+sgeplUbPX+aKpUwCKDoCboIEn2up5ed0kggwiwn+RZU+p8y9AUl9oVlBYysdWALVnFsNlpnEXJcRiTrSb4u+I1lGxx6GxdJqQSaHaicXU7KkdttUG7mtfZ87ReuL/snSzhozNns+WqY8dvG9jmlkL/3B/WqLuU6fbkatrpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734008; c=relaxed/simple;
	bh=e+AG6V8H2fl37BdYmx2ZT0nlt0YzNk8468xEWI+ainw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR6vXyjSEVhVJgPTKTbYoekpKlkyvP8hozQpYHEIFmOeWYzlq8gwSWLb5wQdO5V1Wc5cOvJAmWCjkHnw3IfL+Hqlomv3lg6RQdjDirLUAZXEmbbbx8wKK7dO3hy+RjU6KtJIR0LmBgkSFCsGDfNSPp6Y46Anzm2s5Ebr3O3xjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pFOFv+Yl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so228712a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712734004; x=1713338804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdIZZrzqz4wA4YPQi7Rwfe/E1DAX6qVZQwZpQlcq71k=;
        b=pFOFv+Yl7UbrOKHeYeziR/g0T1IMG4f8HfFDZMVh+bchvwpTAREVqHiI2XzdxLu5XE
         bVTmfxSxvhQT8+cVh4GGUAtkvpd6xXVFA9l0FGOXl+PIG90lfASODAlJfkwOStvL67I1
         QGYVOwX5+0V+E9k7+pCuqZOKyAlycLByQS2tbv7va3MNI3NWGkNI4KKpsG6rrjEaZeTV
         vJLN94JJe8yOFcIgNA071LXbPNJb/1mQMP9xDdFh3z7JaLNi2hjA4TGJQ6LUlOeIZnM+
         DZ0yf9rMc+x4bc/GcvcKouqXdqcG3vTsb3DgRXKd179XUEa0/qn2jOIbHN1sTy+ytpSW
         Badg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734004; x=1713338804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdIZZrzqz4wA4YPQi7Rwfe/E1DAX6qVZQwZpQlcq71k=;
        b=V9zV1mSZy0kLbRdqJiluT8JHGL+SYUC7/RVmLkMRIVOVI9HMLkAwezY3LLw13A/2Bi
         43O8HhsKFrWnX1Vx83BUl8vzG6ABdY0SthuTcOf2SROhF5mkSOotO3pRbbZqPG//N6Sk
         gU6/tJnuoxLeaU6AFZu8H7n023qShCj2lKdIkg8aJloLzTWuK6lseG4pnvdDoUaK36nS
         KJuwAcXJYL0xcTlJSBwS5gAR26nEth6XI4PBIePVztV2mneESEVD3R69X31tShsvzaYQ
         H4UHJnmsGAzhkWtiLKhKBPhdkPBq9+LNbrzcuc8b8M8g2N4qjKJdIrV7H20Zyt3f3mPQ
         cH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUKlQC0jNSESK3IMFLckOpvAcEB3Io3dxTwhyfNiZ+Ne/MZgGk+mDxEs+X4jRaIuO9jFRPAFdnsSasu8BeAXoNsTQSfT5E+
X-Gm-Message-State: AOJu0YybuxP3AIkh5OtEJW8wPuOfUfre1Ws/oKZU6CNcqI8DsQsZ3w6D
	2aMprOtDQBFnhl0R9J9zoUEK98oyfcpSCIXSmAPpsvM5V7YGQI5ug7bk0j/tZH8=
X-Google-Smtp-Source: AGHT+IH+W/F1+BSpIHz7mLcAWnXTu1H33OQo8F2Q1DXesJ7VREDNOAHOswXumxvf0957EQQLCH3DJw==
X-Received: by 2002:a17:906:b2d8:b0:a4e:a7a:84e0 with SMTP id cf24-20020a170906b2d800b00a4e0a7a84e0mr995649ejb.34.1712734003817;
        Wed, 10 Apr 2024 00:26:43 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906b01100b00a46aba003eesm6633313ejy.215.2024.04.10.00.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:26:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:26:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhY_MVfBMMlGAuK5@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>

Tue, Apr 09, 2024 at 11:06:05PM CEST, willemdebruijn.kernel@gmail.com wrote:
>Jakub Kicinski wrote:
>> On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:

[...]

>
>2. whether new device features can be supported without at least
>   two available devices supporting it.
>

[...]

>
>2 is out of scope for this series. But I would always want to hear
>about potential new features that an organization finds valuable
>enough to implement. Rather than a blanket rule against them.

This appears out of the nowhere. In the past, I would say wast majority
of the features was merged with single device implementation. Often, it
is the only device out there at a time that supports the feature.
This limitation would put break for feature additions. I can put a long
list of features that would not be here ever (like 50% of mlxsw driver).

>
>

