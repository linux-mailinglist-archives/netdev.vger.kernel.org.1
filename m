Return-Path: <netdev+bounces-192743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31012AC1014
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39101783C0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FA298CB9;
	Thu, 22 May 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JsqJe30H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA20539A
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928374; cv=none; b=a4mp+zrPQV4UYpvY5cT5aRI/EI701FLQlb2yhD/XH9bAuwm3qRvVbW6feJLRFqlTGaQrBNUh75KGAg8WZc5ZzoXs4DBdRPZw5mGu2yuuq4P8joyP+rLc4lahtjZSeie5k9AqxJAZ1HaQSCE0RxEYuUDZZNnzOLcvoUXTuUUwRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928374; c=relaxed/simple;
	bh=f3jIqM52vcqWjCqepnJKFYtC3WSi48/Bvb4QSVppzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK0TAI9vOBh3xiS6S69jgVirHRRBHNDFnNDEwGBAZD6NkuN2/q5VLGHDYFdtDsZv3EE2hu8MAvzjq+Or2AsryPsbT36Uu4vyuszuQ5iQ5J4NpLkZDnMQ3GCBd5jXDvNqPWeGJhDI/S2xmaQ6H2sNSzTrlTyEVWk7T0R4/WztR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JsqJe30H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so27725e9.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1747928370; x=1748533170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBrUhxFusf/re/QniUvwpPohDVtoXSs+UQAuYiuzrp4=;
        b=JsqJe30H9w7MIXDh8sudFSSG4IFQwHUD5wqaGLW91PKl8t+bzVaEQR7EAIJMxWM7iS
         WgnxyKNZmSRiu+fS65M3eShbfyROM6usyexCYBMdcT2UBeniLB3lTQH/9ae94BJ7RufJ
         SR1YbE1EwNhLRiKlKuHxwwPiUXrE3lgDVski/8U9J/EBe6dLpMljR3P/05APCwHzi6+x
         YTPSFRWTGNWYW56I4UNhY42C5tlOKSfjNM13bKd6hqCumu7cNAcOn2wMfKNdqDFOvadk
         kBUHTuRu1OEiVk+cCSCO+4C0e4KXMSfWjjKCygIofLqVx50YYLiilj/M+a3wTkTAAWRY
         WbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747928370; x=1748533170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBrUhxFusf/re/QniUvwpPohDVtoXSs+UQAuYiuzrp4=;
        b=v42AJQLEFg/ubbCbUA03o28qvp9apnMdsdDfKL4VaAg7Tqy/bFcDvRpLwxzixSuyEv
         yM7QmLfAbWmMU98FMfLUuMJ7trHCtgXo60Xb2oi8An2SrGU4Q6lXLhRbJbBmzdhvuxw4
         imJIwBV+sUl4GrZsy/K+HZzQ5k47HZwIxxM5ywt1CYWyOAdYbbMZ2BM3osttexXiSm14
         JwHjItNK5n4t6DF+Py7W20pYeXpfdahOAKmVZS+2uFfVz4LTgANewJpyrb6UNAd+ceLW
         qS+srTLA8nYCVsd9L5VFOm6YHbskx3yiVWeRzvGJ+h75pTuHwFMBbaJIrIh+vCa2mwHy
         fhzw==
X-Forwarded-Encrypted: i=1; AJvYcCVxkpjbACHw4Q5BsyjTiP6wTay5yIo+K5BBtBtn/ONwDsh0LQQ8GyGmX0pvFwuCH8YlIPFP148=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12WTTdryS88xHyQTu1aoWLNTv92cmD4gBrQEQ5gZ9DAdM9sFI
	QvzasUjoVgitjzarr6jrwzPyiqXQX88JwekFYlc+XFdB6sVkkpnekVNKMjWhhAc7hT8=
X-Gm-Gg: ASbGncvsIPjBhiFbJ4zhg/h/QAXiJ1tgyauOHBpFYNSPiKL7qWxTlAuaijhq6vMI7jG
	S+J8Yp9CfH0KBFotR0kfoeAru6ENh65lHWIokA9Ftah18d7mgXDynv6VwagnDZowWsvciluBPXm
	fSanZF5suTl+C24gkoSqWi60x/G5yZrZFlsCZ62kX8cYrX8Z0S3yrQNUhup7Ih/x3DUW8EixMrw
	xaUNYmtMIKcYk1WMePsMpL/QARV7JN9tfoIdtniXmQCu6U6fxhy7iMTzsPoI4YlSXhUj9taAF1t
	bK8u5i3HcSY5nAglMNRyXg3XyzJdI/AUfet9BrcAE5QJSLkFdDJz9w5ROOzZzKYQwBRZwnkxHD2
	81rw=
X-Google-Smtp-Source: AGHT+IG7wBUcHQn4FFPhoL0oTVfzqq9GHHVziBbb4p/3+Qe7Vbc3o2ItO2N+QvXHTIe3cZ9zaY2EcA==
X-Received: by 2002:a05:600c:3587:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-442fd9970d1mr214826385e9.15.1747928370318;
        Thu, 22 May 2025 08:39:30 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447eee9d8desm113970295e9.0.2025.05.22.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:39:29 -0700 (PDT)
Date: Thu, 22 May 2025 17:39:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	"Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through
 devlink
Message-ID: <7bs2olcdw5bgti74lhbqubcbvj4y5lezakt3jxwfiyamyj6x7e@tigvi3vp5i5c>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
 <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
 <11eaa373bb894946bc693d9a1e112ca5@amazon.com>
 <76xnvcmdkohjxui2e2g7xe4b4iaxiork5e3k4n6inniut63a5s@6voxc4okdixd>
 <6469535d9f814e238b371f56e91da4ad@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6469535d9f814e238b371f56e91da4ad@amazon.com>

Thu, May 22, 2025 at 04:55:35PM +0200, darinzon@amazon.com wrote:
>> >> >+enum ena_devlink_param_id {
>> >> >+      ENA_DEVLINK_PARAM_ID_BASE =
>> >> DEVLINK_PARAM_GENERIC_ID_MAX,
>> >> >+      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
>> >>
>> >> What exactly is driver/vendor specific about this? Sounds quite
>> >> generic to me.
>> >
>> >Can you please clarify the question?
>> >If you refer to the need of ENA_DEVLINK_PARAM_ID_PHC_ENABLE, it was
>> >discussed as part of patchset v8 in
>> >https://lore.kernel.org/netdev/20250304190504.3743-6-
>> darinzon@amazon.co
>> >m/ More specifically in
>> >https://lore.kernel.org/netdev/55f9df6241d052a91dfde950af04c70969ea28
>> b2
>> >.camel@infradead.org/
>> >
>> 
>> Could you please read "Generic configuration parameters" section of
>> Documentation/networking/devlink/devlink-params.rst? Perhaps that would
>> help. So basically my question is, why your new param can't go in that list?
>
>Thanks for the clarification.
>This is a topic that has been discussed in the versions of this patchset, specifically in https://lore.kernel.org/netdev/20250304190504.3743-6-darinzon@amazon.com/

Where exactly?


>Other modules in the kernel enable PHC unconditionally, due to potential blast radius concerns, we've decided to not enable the feature unconditionally and allow customers to enable
>it if they choose to use the functionality.
>As this is a specific behavior for the ENA driver, we've added a specific devlink parameter (was a sysfs entry previously and changed to devlink in v9 due to feedback).

Why is this specific to ENA? Why any other driver can't have the same
knob to enable/disable PHC?

>
>David
>
>
>
>

