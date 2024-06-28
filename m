Return-Path: <netdev+bounces-107635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FA91BC94
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590B92826E8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040515534B;
	Fri, 28 Jun 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBEpXR4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5F15351C
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570463; cv=none; b=Z20q3JWMpa3uxn4q1J8zA9i7QDxXISgAPdy5GePCyy9U4iNaF2aphb0Jyt45TYiaJVETHwLW8b2i0t7SUX1atJHhplu01aa5DIme5KRCF37LH97bYrrUpJy84AMROqmi6tq5biouW48iOhkmDqX0BVhGj0CM6/GMf4iGYOI/EYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570463; c=relaxed/simple;
	bh=dQqAyVeg3cBeHv2LlACuxo2/AhFe5frp6zeGzDD4u1o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XHUtxJ6kzd/X9h/HX60g8CAG2ikchwvumKEZ15z7+Kqa9Q/kdMbwnzM8m0c+KslN7cm6wErWpR9mgB/P5PTHCpIAaEW/frmCW3tPJG5tUyiTK4D6l9oZaZNLFIhLnk0Z57MqQbUteppYO5GMho7keWgBzeCeVlRKsRfczf8Y03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBEpXR4j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424720e73e1so3722525e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719570461; x=1720175261; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJGPF2pxFShzriPZsd0sVo8JLYMmyTVn4E458Bzsl4A=;
        b=iBEpXR4jq2Xl3VvxtIvcDk/AXtCPe5Q2dC3meJ81jD3O+gVKgZUomZhXHBdq6JvIYW
         ZTPBz3J7gjpHpuSQOSJrOD1ov2axFSfMrEt4dO61S17Hf7tSIXTIRVtg1Mug/Xw+zLLI
         CY6midOq1r8IdM7UcA33zdNetUJjK3xyQxNiwryp8UMdz+LQJIF4aYypQcJ3YX6/FNIc
         1Tx9kQE8jJfIUWHdYxerOMT5ETyX9lf/PUelCsU5mGyJVD8mH5hFxyQOsbtZus4jnPvy
         gCr8AX1HWV+Wzt/VDDN3OlZ8UncL3QAoNqlSw9+0vFkwMfre3JVZp2FY0Obtzv8F6RYU
         04dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570461; x=1720175261;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJGPF2pxFShzriPZsd0sVo8JLYMmyTVn4E458Bzsl4A=;
        b=mBxzhUR/6MHheNCX2wYQr6ok66gndkg2Ls0QDS3a46InMk1PY/zViyPs3PnsAkrsdY
         jrhgb8hlZGQryIdQVHY5SrTqHfqc0gnuvHhGb08BIcfS3nHtDiEPo548BUJjmeTJ2tzr
         zE3Ee3sE14GYjtNGcYrT/Xo2bK4kR2aZOLmuesPXRVcANsNzcujrupOmohEgH06/EVY0
         oxn5G8EE0lJP94uP2o99OuBLTpcfD6heGt4+kgehWFRNZCNPL8rXPwqfxTbyv9LveY1f
         cDcP8U6iOsfrYexawppb1tqXcbzHMufx/VWfiRjj8osaxF0QQkIdO4Wng/4eKVm78Y+W
         Cw1w==
X-Forwarded-Encrypted: i=1; AJvYcCUz8Pcm5vCNT1jAVp8YUe0X7WTkhgbKARwSlpuE4ZVuy2ayl0+/orfmyx9Ch0l9FhFOw6cwO2d9kHlsic9oqNoc1mMR7tvv
X-Gm-Message-State: AOJu0YxGWjRtep/dfQMWrX5PuI9SF4xeW4W0U0pSt8sWCRu8YPsqKgYI
	5SkfgnvI8CSgHgY+b5xXV0CXCN5xC2uBny1EnGKGND037o/8kzty
X-Google-Smtp-Source: AGHT+IEe/vDVCk1aOoxCulYrTcozg9TjJ59VZ6j52jvo/wWGBw+doHcuTM4rg+9t8QPl3zlVAEF7ZQ==
X-Received: by 2002:a7b:c3d8:0:b0:424:a4ab:444f with SMTP id 5b1f17b1804b1-424a4ab464cmr68431595e9.33.1719570460689;
        Fri, 28 Jun 2024 03:27:40 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:49ff:2a2d:712c:9944])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm1832542f8f.28.2024.06.28.03.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:27:40 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] tcp_metrics: add netlink protocol spec
 in YAML
In-Reply-To: <20240627213551.3147327-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 27 Jun 2024 14:35:51 -0700")
Date: Fri, 28 Jun 2024 11:24:03 +0100
Message-ID: <m2le2pbc1o.fsf@gmail.com>
References: <20240627213551.3147327-1-kuba@kernel.org>
	<20240627213551.3147327-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add a protocol spec for tcp_metrics, so that it's accessible via YNL.
> Useful at the very least for testing fixes.
>
> In this episode of "10,000 ways to complicate netlink" the metric
> nest has defines which are off by 1. iproute2 does:
>
>         struct rtattr *m[TCP_METRIC_MAX + 1 + 1];
>
>         parse_rtattr_nested(m, TCP_METRIC_MAX + 1, a);
>
>         for (i = 0; i < TCP_METRIC_MAX + 1; i++) {
>                 // ...
>                 attr = m[i + 1];
>
> This is too weird to support in YNL, add a new set of defines
> with _correct_ values to the official kernel header.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

