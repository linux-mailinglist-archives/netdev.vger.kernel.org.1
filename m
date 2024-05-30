Return-Path: <netdev+bounces-99389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B555A8D4B39
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC041C2336F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA510183A81;
	Thu, 30 May 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXLUbnCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C31822ED
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070476; cv=none; b=E11lBUhbT5/EfEfXyZM/+vsEVgo8a/myaePtPFzQ5YotRhAszIZ3nLr/Pm5nIzoeGn7P7Y9O8aa6czBeDi4RfX5UiIE1BMbgwFSWb9+ap8TkGZT5Q/7cPM+WVI2ZEiSoAbUXltbm4MBopxj0q4nIwedoUOBbFhoxD3lWY8kaK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070476; c=relaxed/simple;
	bh=JHXrr2qc8agUswvtTLg+R/oyv8tWdoALgi6g3yJUp8o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=nXCiiut7+sVH71CspB1ki8wZ8N+Ui8gmvjG4Y3PLxfVzp4XsUciG+0TTvg2mPPmfbSvTYw8+lkLIAMZvFBRA8k/dBpqshQ66TKkEd2MIvKTYamY8qNphsjn7W22LYpk9+5Wgjl/z29o/piAEOvdiSW/ODhDQrCIjCHwbTZEXRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXLUbnCz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42121d28664so7991835e9.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070473; x=1717675273; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkjeW4XGw3Mq9ieFLH3DPakwZg1paNyg0P8rq3zz3tc=;
        b=JXLUbnCzrnEkGbTsOqxmdrkaDckrORqzKDDk52dIEk8ez7xTmgaSwZyvo6tBwL6bz+
         EWhSkdGQvCR4Z6JyGP+pRlskktKHasOoIzsatfVhcmJGmsr6sG5PWIQ4xBUUJjjGXvsa
         fdqajWHFIMhYk1aXpWeD5eG+GOHP4GKnd1ANwx/uCDQ/FpqQoZV4y8AUKz5CQ7G8euDY
         hHbrLuwJq1Zee70/VaLPeqXlTg9TDk6SVxnOP5abkF/sn7SwompIyUjlSTpCH4k+JFnK
         VnLltPyyB7qBbUIAPLcar9izM+fhS9ouc/L2HxL2Tq3f5l6bmANNUS7+QkuYvzBRZB+D
         yrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070473; x=1717675273;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkjeW4XGw3Mq9ieFLH3DPakwZg1paNyg0P8rq3zz3tc=;
        b=owsObYLCIUjrCWIUsAkCyJ0k6MGC1G+LkQPB5lyZOYlA07fHEJved/UikDgAu3B+cN
         VQlX0UzJa7eMQy3ewKE8EpLav7hLsIhU+X+6U72IqpfcPQn/Wk06zw1ylJczeanQ+BNB
         0Qd73H/2GnZTH4bPCni5AQL81wE+g3H+e9utJkRw6M+p+nEndllXj7+14mOpe34FsGGe
         gXPFSTKvImis/xivIcKCqlq139YtF8GXQlyMoO5tXeyUXdnAA5FvTPganXjpdiyteVTv
         01kMKPQhi/4zCycs3ECKR13wfiPkhmhChw98qv1EyjYmFxxFYl5acCcUCyj3D13ywVY5
         pMfg==
X-Gm-Message-State: AOJu0Yzorn72PbnS5gb21L5KsPV+5T2WJugB1T5lKjaYvnNNnMNV41iu
	Xnf/ppsGCQuY0yV0xYi4MtT7pMq6KGsdE8yOTBNkRaMj3vOVpE7F
X-Google-Smtp-Source: AGHT+IE7HUzFx/vDwwFe925SovAyx+P4OeuN/AIr7YOX/YI2Ys6yjoczAAuKgMQwmirJ0v2h6SJRxA==
X-Received: by 2002:a05:600c:8505:b0:41f:e959:9053 with SMTP id 5b1f17b1804b1-42127935261mr21831175e9.38.1717070473479;
        Thu, 30 May 2024 05:01:13 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c8da:756f:fe9d:41b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dbf8d9b47sm1906656f8f.56.2024.05.30.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:01:13 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Breno Leitao <leitao@debian.org>,  Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/4] doc: netlink: Fix op pre and post
 fields in generated .rst
In-Reply-To: <20240529181001.4f2f8998@kernel.org> (Jakub Kicinski's message of
	"Wed, 29 May 2024 18:10:01 -0700")
Date: Thu, 30 May 2024 11:42:10 +0100
Message-ID: <m28qzrd1j1.fsf@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
	<20240528140652.9445-5-donald.hunter@gmail.com>
	<20240529181001.4f2f8998@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 28 May 2024 15:06:52 +0100 Donald Hunter wrote:
>> The generated .rst has pre and post headings without any values, e.g.
>> here:
>> 
>> https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#device-id-get
>> 
>> Emit keys and values in the generated .rst
>
> I think your patch still stands (in case there is more such attrs) but
> for pre and post in particular - we can hide them completely. They are
> annotations used only by the kernel code gen, there's no need to
> display them in the docs.

Yep, I wondered about that. I'll look at suppressing pre and post in a
followup.

