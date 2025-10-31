Return-Path: <netdev+bounces-234619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1BC24B54
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C526D350824
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C1534404F;
	Fri, 31 Oct 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V8PFmfsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60483326D70
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909067; cv=none; b=PAYv6v4SO+PO62YG0bOPC8WYF+nZU3vhe76lnq7UhJ9sZ/VvrUJR6LdgutQpEGeFNYnKlhN8E8qXCqkPRRALntLnFU9XzZEU9xgVGl2HAlnRmvxt4BwQ3zOjhYdLaADcghFcELM9jt9JVpYoAd64KxcBTJX6eHd4TJv0JKPA7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909067; c=relaxed/simple;
	bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADnhN8IpndBSMKySDLYgzhdowum8pmAkHTH0/m4cwnhxxcNIVBO7qzfi0dFkp4Ta5GwsmDgU3IkOpbho8cYuHS4A+ZjyicWUerhgbXNtS7iWsr5qC2JWFL63i//bBjAiDN/+djqZifbUOQ4bNhCvCRpXE8YIZnG8ibT5O70ARTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V8PFmfsy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so3062485a12.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761909063; x=1762513863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
        b=V8PFmfsyFu4rxcP0DmndC8zVKwDrqsIcwvS0nKfErS74qlI0hvn0eypcx+Z8npsInU
         wFxWVWTH4ZocOfdtE8/qUPPXVrzJwj1UZsr2o2Ta1cDx3ZQmsrmeu54PQ8wcwzUIhVwQ
         sJ90sKIR4hIDv8dhmCbCians+bnlLYWl7DTd5WBYOJlNbg/iwhWq2M3WXg6K44Y6hxeo
         6AwmuZPMGD5o2B/+qehNMX0P4r1pJloVkcz7zn6nzBo+kYs3N7AFMpDEWM1SoH/Sivpu
         ky+6TuXM/WypaC3HJVcVb+N/LCXo4TMMK4vuh8mDtqHZ+ahKv/pfsIb1putdmdl/DT48
         mdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909063; x=1762513863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
        b=IMLGH7avU0mvdC3iBT+B1D7Zq2O3nQYnU4j+W7J6rBN956heHThhitEJ/j+zZPUzCI
         0+JT2edziAlO5IGec5HAcTNZCWlqCVMEfw+1GOLfKoHuwocnQV/L88ZCzhUubKkRAAjT
         Xwj0vglKxydPFGGwp9HwjBH/3AlovzaPRmhYRio0Rxo1RxDTiu5BCEGReCkmu7dj0Dd7
         P1Q+UW5x0FEOaYdbLLuIYy6tUZg1qUBpVwKawCgP4Ku/sQlZXT87l6xwp+V/QoUfbUZg
         fg0Co6VW32E3YYH3SsUZGj9kcI3ZgqcPmqAFBnjafTGSePqIWTtaHnuNnnpOmKQexC9H
         06LQ==
X-Gm-Message-State: AOJu0YySmWoUIaLoxLyQZGqjuj9mzFr5RQEL10RqnfwuUPbpKMX/V9Rd
	h8NcUqVoUl/r/UgM8KF8QZZvm1fscXaBLE+xdLGK36x1RiRtgyculgU5o7AdNl+USyQ=
X-Gm-Gg: ASbGncuGlpNBrxcW6dCQe2agyotkesnL9ncIyyMLMbyFHIBPcjl3pGviGaslmkC5SXG
	5xkYJ485flb8nbwxyQqzuekZqZ+N9LBPfEeXsk1Gs/vDQVtbgzpxDcaB8+ygjpvJaowYp7WWpG4
	iWyvYw90sBgWO24NUI3VkkZMxqTQoMkSo+JpFsq8/Oqh33hBoxf/rBFtGqEMI3DCbNZ18jWxwzI
	n7hoc2DPNiO8+o742Vx7kH9TGVgz1IHejMA5a0HeOm8cEKen+AF+yOpaAnXEiLZqzwvlEI/bpbX
	BaUvEf1vLqJg/mY6xOSbq+3TAjduhSF8dlyJ/ThQ4T9fBzZphu5jRBFKS32o554MCq4hY2xi0mQ
	bc70B37S6Xx4O7ZWUbW05gRavR6sG9AoTOlrJNZz8YmoT5CySVFE3keAEyt3SgE6VluqjbCHSuJ
	QpQaHsQjZml7UdJ4JCnRanPxBHjEQbpxKBs9g=
X-Google-Smtp-Source: AGHT+IEjms4qrB4LmCYAXPaycpxI8yZMVC22mnbEDh4Pi0tNLAsk57VjXYG/l+laWrQ2KLiFhiONkg==
X-Received: by 2002:a05:6402:3488:b0:63c:32a6:e9ff with SMTP id 4fb4d7f45d1cf-64076f66bbfmr2677787a12.8.1761909063307;
        Fri, 31 Oct 2025 04:11:03 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b449fadsm1297395a12.36.2025.10.31.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:11:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:11:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: add phase-adjust-gran pin attribute
Message-ID: <55jjhdqtmuvhayhnehqguauw76z4awa6bebsw3odcvkiclda6y@dhl5kswtv374>
References: <20251029153207.178448-1-ivecera@redhat.com>
 <20251029153207.178448-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029153207.178448-2-ivecera@redhat.com>

Wed, Oct 29, 2025 at 04:32:06PM +0100, ivecera@redhat.com wrote:
>Phase-adjust values are currently limited by a min-max range. Some
>hardware requires, for certain pin types, that values be multiples of
>a specific granularity, as in the zl3073x driver.
>
>Add a `phase-adjust-gran` pin attribute and an appropriate field in
>dpll_pin_properties. If set by the driver, use its value to validate
>user-provided phase-adjust values.
>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>Reviewed-by: Petr Oros <poros@redhat.com>
>Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

