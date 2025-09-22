Return-Path: <netdev+bounces-225347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFFB927AB
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF574440C9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707A3164D0;
	Mon, 22 Sep 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXtxJQr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204A3168E5
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563467; cv=none; b=EhFy4hv4MIEp6Xb5RWSlQKvHxTUODKX4L3ZHADcreM7+0kEK02dK9lrKr3bH9HOnCl+a9A+oyD7FlVG3m2siuHfwXgUJ0A6tBYCqZSy1uz/U4EYvLp7UshYBXytymZXXCelgRBgx+/xZygmWR9OzUPOwlPd6yAjKlV1i/7x+MW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563467; c=relaxed/simple;
	bh=c0a6RFSFL244AZExUgaFK/XTq3j9EgV6tyBZrfjl6Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftwlt/SwmyoIqMYqXirBvRqhO7t5cpEXmvhwtkDQhxkql8qFHNMHEkPxsBvoIXqHnctHLSzOkGRSL2HwUM/cmMZeUevEwJTP6d4ohCLhbEcuSurdBJHH/VOMns7iRVfLJPPl+8aUfcw5qcN+9+gGdzm3VYwZmX92NDumhQ4MUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXtxJQr3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761578340dso5500408b3a.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563465; x=1759168265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kpp8y4+/qufo5dJZYCrIeeCLKzv+9CNWvBYi7Kz/e8=;
        b=KXtxJQr3DtfVL98Tzr4btcEGluda+xk3qAIu6ot+3TzncFqirkqzOZLjEPznEEc2M8
         2p+JrxZUv6gYubh7SeabOZb9N0AOmG4b/tNeztJ6BtIYNKxGIVY9dLdRn8QAig7Pz8Xu
         vGqkNCuODRSDF9Z27ikN+0tDmLnzyoRJEiQ5ivxd3WgJWzseBX8Hs66Pl+nyefpES0j6
         v0Rz/0VUOa0Hxp4doLXrbLCTEQX0uq4xUI/bEUJnoWWVdZiyOdSOq8wP4uOHEyEFX7x7
         LZ9TwWLzx7a4ThTzrwAedTjhidWny/fJEjgRpBB9JglAgdoJu5DeD11s6lIq4D3oFWFh
         BuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563465; x=1759168265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kpp8y4+/qufo5dJZYCrIeeCLKzv+9CNWvBYi7Kz/e8=;
        b=onk2Yk36gZu7VrsWu8pt80OARiC6CE6PVSYm0tu4BLYIkMlRIsfWAIx5JD72BKyxLN
         N601E4MXMqu+N+wNaTj0785/D0vTBYFYKFSsy68qwZ6x0HGeevxRyHWz3l0Pw/ifXewe
         1kFTR7++0uBUlEbtXEYCqXEIdizjlmflvzCII7HQnNJr7QjshFG12Oc/1qie67YD4tN2
         AK2BU8YC4AtGlQJLq6sA6UyZOIRWxXkc1+b/Rw6KkTEMl8Q7PXT2KB37cAzJ5Gn4DNPo
         VGk6do31AU6W7ndboDnoS/UgB+ezFW/tQpXsLjLlOJmWufR2tJVK3I/lkzjh6bEvRBGE
         9C4w==
X-Forwarded-Encrypted: i=1; AJvYcCXeoPCoOT4iPCOLO2SvM0dZCDtKYKcTSSeCoJcfy1NDdxciUjLBP1EffkfTkSSONw+XBwFEhOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+5/Y5ZyUrgph2Ys7LCfIbgGaOFH7w+9SEDCiSZp53bspjRkJ
	wS3i55WV0j3OBiuihhBXwlaZzBPbRaQluMW+kcxzlHfQ5d6RhIHlYBI=
X-Gm-Gg: ASbGncsfLW7P64t6G9QU6d3JPJSrPqGaN+cmI4XjLmagroCoIEAWavEfKaXhvj8MHm8
	rhAlczSGduRwMS8QQfjf1mh+3BzDeBb+GTMapSoDOzM8LgVvLXK6dA6pyYvk1vo9FF5ZyLq7MsS
	dWBVAW0aQ6AP9WkAKHQRMiDrrHU2ohlodrSxcPD6OXIgQrR4tUJEaT+KoYakPved+xrAvCYGM2s
	0NK98JmKmL+jQ/es+X8UXgFCd8fomNbyTzEbzXCwhMm1PjvSSEyMknN69xqqGDXIZj42AgI/w4P
	Up+b+G58wJXnykSwQmUVslbRayqQpLLDal6tgRgkvmGPL9bUpPeKQeUuJiO+VENEbRWyqKTTvZY
	Jol8Mbv9yUj8alS6v2xny6ITFWtik+wXIfYDWAgZVbAcinmXb9OfdODX4iJWSTRzJSh0nR70rQc
	7iZ9FC83QFpYRXpxybynpDqFf42MjYKdOC8vJN1jYbsZ/1jML4ewa0URSQBbFKaqR2FOC6IwfLW
	tYB
X-Google-Smtp-Source: AGHT+IFpzkffBGVdyl3FepoZ59EN9XZi2pZw2cC261Hr4BtGiCIH//T8bpBiwA3kypUTCERHjE/DDg==
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id adf61e73a8af0-29270319fc8mr20827440637.36.1758563465349;
        Mon, 22 Sep 2025 10:51:05 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b5516b997b3sm9855293a12.0.2025.09.22.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:51:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:51:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH bpf-next 3/3] xsk: wrap generic metadata handling onto
 separate function
Message-ID: <aNGMiNMmNRf1N3e3@mini-arch>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922152600.2455136-4-maciej.fijalkowski@intel.com>

On 09/22, Maciej Fijalkowski wrote:
> xsk_build_skb() has gone wild with its size and one of the things we can
> do about it is to pull out a branch that takes care of metadata handling
> and make it a separate function. Consider this as a good start of
> cleanup.
> 
> No functional changes here.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

