Return-Path: <netdev+bounces-66210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AA383DFF7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C6D1C23E9F
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF512030F;
	Fri, 26 Jan 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlDhnZRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AA1F5FD
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289899; cv=none; b=aThqZsrRfQKqC8BU/ocFJovNFPxhma6aQTzkREDOWrTRYBbdCMPNkEeMlo5suoiq3U/IcFZEj8xiXuxUoMQNS3qXyWSYmM++OiHbK4AjZ+iUqu5yqyv6NkrOh1DRrgIOwy18/sajfbSIv+95XgSU38QbcZaSGnMzG2UL8IxhDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289899; c=relaxed/simple;
	bh=CaUCcoIae3ZPre9f2gHK4/kaL8gJqS2UbT/T4e+eSNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YigSxMATA5MpgaWd3HGbln79l6CCKu0Wjy/n/LB1L8Bms60nLdeO2ZrNnnT6bV6CtDH2v0DmAUf4IiKoXdQhQpfftoUvKyPvtjx9Ra+km8Te7/b4LGsuYi5SRRUZu4nSUmy0uOmd+hpjh5dsgjpaF8LULUwgCL/lJVbvMobCOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlDhnZRv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so10016925e9.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289896; x=1706894696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CaUCcoIae3ZPre9f2gHK4/kaL8gJqS2UbT/T4e+eSNA=;
        b=LlDhnZRv1bieVh9ZqKzuEnSxbN82CMzZrT43ufc+WsKnmUhvfFdPwZ/BSUXP4jOWRQ
         296PEcNdXptdKOuO3Wq5m/FE2PG6dWvW9OWKcnn10BdcDBFNhAqFLtUoWHLaheG6QEVb
         1Q5ExtYFiaS0cI5o4nYDWkV90CRd/T4PmjjbuJAX7X7b8SzCNf/OCFvisopSpkNcvYsx
         JtdTMjNsqQxDVue+BmmqnKfOkfKThZOEKh2/VneedWaB4D0xb9P9rFDiIfRfCeaq005G
         LEQXWlmyCy3I73yOuXicpIE1MIap45LkniBDrlI8I5KP7S3yz1QU/jlaRxjrRHZQrBIw
         LZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289896; x=1706894696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaUCcoIae3ZPre9f2gHK4/kaL8gJqS2UbT/T4e+eSNA=;
        b=V7ZDxSW+2VqZGC4ROdI3sxSqB1mXjTUFib+Oy5vvuk9v5O2ceJbmGcDlgtCSpXJi4C
         tZZkewhS/+Lvj3gqrl9s/hh9j6yeESMq2JkqsjZTephOxzGmhrfLgmLSWKBJOe58gnd2
         6RJob/JZDYt0GU5TQYS2t68zE2x7XkJn3XmUMAMpM3OlHqP3eA3CQzNQV/ftcRkijhCt
         40SizjNEHx1YJf4G8fM5Gxc21PgGLYlvbO6Lp+pLUX3nGBEqkmOnO7uhaj2yQ6CcOYY9
         IVjpeJmuKTHvyTGZhaJrvmDNIBqv/oKRoUN0Gsl1mv7hMCaDvwQpNhtkWVCEP/YEDj83
         v96Q==
X-Gm-Message-State: AOJu0YzbWazgZ2N8PC/tVpCukdePVvz3B8bDFFaWTwTf/I5xFGtA1TL4
	QAsBg/6vsUABwjmph/0l3SAfbOr0YWX66CMXdfgQo8/ui5BeevV7WRpSypMKoIUdDkEc5miouYp
	it+B+Zbs0ORXqYnj+X5eDWtxnGptne6j5QOY2doH1BWy1nnnf9Bg=
X-Google-Smtp-Source: AGHT+IE//xJ776tfB0WqJHvKAhOsmhLKqp6g4ekELnrxzpz/eAcMLPXZZ3Ihfz23L3awpNlhL7nMT3LM1Sxf7IRvmac=
X-Received: by 2002:a05:600c:1e28:b0:40e:863c:b647 with SMTP id
 ay40-20020a05600c1e2800b0040e863cb647mr81847wmb.145.1706289895786; Fri, 26
 Jan 2024 09:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124170010.19445-1-songjinjian@hotmail.com> <MEYP282MB2697FB6601DC1A323ADBC036BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2697FB6601DC1A323ADBC036BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 26 Jan 2024 18:24:19 +0100
Message-ID: <CAMZdPi_2twk+AC3QrwK78Buw3Z592JOx0B+ewU5UbR3pG-GjEQ@mail.gmail.com>
Subject: Re: [net-next v6 1/4] wwan: core: Add WWAN fastboot port type
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com, 
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com, 
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com, 
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com, 
	nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com, 
	felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 18:00, Jinjian Song <songjinjian@hotmail.com> wrote:
>
> From: Jinjian Song <jinjian.song@fibocom.com>
>
> Add a new WWAN port that connects to the device fastboot protocol
> interface.
>
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

