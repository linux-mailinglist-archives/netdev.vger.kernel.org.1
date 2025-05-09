Return-Path: <netdev+bounces-189368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD63AB1EAA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310161C07F11
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F525EF9F;
	Fri,  9 May 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQFIoFd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C03242D8E
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824679; cv=none; b=Rn44oa33uJW1/1cBOoRQyvJU634tUivORtvtK/P4tQhJILZiEwi/Ie5ywKfwlcRQi2S0D1mLxjL9S/9FXZOtPRugiWqjlC3iqup8FPLBq0j6R3ffRbGZ3ipOnaXBCUC1oCVe75xOSD3NxzbZdMLUyQILUem9Xb4Jax3nuCfhQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824679; c=relaxed/simple;
	bh=WdeIOsKITxP6E60dh2WSPZghIf0Q/Fj8tWmDQoMglBw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qejiyG4Xg5oN7Ji8FyRfDPxsfsfhjTUknkTcLH1OTM82hPIuZPYLNh/ka/0ZNXIdG+o/YI63Ug0qlLhuMIWsvqwEDfGJZ7bvHQ+9JxHZ0RWcOgPVzMEaaw5DV6aZrIir24Rw1AVYGCbHOnjIS3ForZVTg3QdS6vQt2O09YHOTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQFIoFd9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so1187698f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746824675; x=1747429475; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYPp3E4tQ7Wr5/DPM9Kyu2NzcVw9qxqIlGUP5yR2zB4=;
        b=TQFIoFd9+miSHqlIIf7IdOetWHpAsYoNMLHtpPg57WCzs2Cga/oSwaoP0BMIYgV0uf
         /PGytNDPuOQr6Cn/aFfKmgudvWiSjSOTidzT4kbnJFUpuQa6cgQ6JKcH0WF5Vb5tmlkG
         Fzo+YjUEYSDoYJ6QtfHb8HzF7Lu5uGG8mBMZORJPB3wNvWvZjvEbMs/Sf0GNEG+cTIwd
         CUKnHadEB/LDqnf4WWyYovYuGHd4db++PUgZn+VFt0BG7ukljC+JvkrInIZ2BJ13+Cqr
         SgB90cwD++JmDePgbPrrEpn20uVzzhHYVcvXsRe/OYmc00D4KbV2I8I8YkpIX6pzwCAy
         Dw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746824675; x=1747429475;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYPp3E4tQ7Wr5/DPM9Kyu2NzcVw9qxqIlGUP5yR2zB4=;
        b=e1mUTNXAkZvWBILT8hx0s66qQHezu7MtNqNwFvkTpNAUr60PGpwF4jKeKQH6p4+dSD
         KLgn24lekOg07GaOeO9Ww8XjwK2vDDPWt76hnuCFYKjdlsiZYSJ9jvcWS2L0QyJRbJRu
         1JrgemZMJEg1E9zQeATFQH+T50MeiNRlIoAAhO4aZghtQ1rGBB7c4GRg0i+djN2SoSgJ
         oBZRJFtyw0icZnAviV1aieKHqFJ+Vl8bpGsYyGe63mqsVXx6ARA6cKvKobM+syshy8vV
         euSWSttZG+6UQxKMdAqQj7ZrA7ESzp+VC0uxwGk7aHryOJqCzPLZjJzYEY1w0E0U2eSm
         xSRg==
X-Forwarded-Encrypted: i=1; AJvYcCWyZ6fKsoDAvEJyR1r5NbqyHP7LakhvlVLVh6CIiaLtc7y/ojgpTVSwQkEoU8JvqPzp3Rq5eCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpAO+hcjJYgWfqsus+GAzMsiDPGfAZNtpelhmwJF0UaxGV45n
	uu8RfKuxAZusfI6AfBkR8NGUp76pSzI3xf5hzFavSXXWY7tY1R4B
X-Gm-Gg: ASbGnctRItLTIhivf1jsZPwQfG7SK5+H0vtUX1yVmyzDeT2UMXSC8/3yWuVuCjxBdpR
	bJRpH2/GJxFtHiceu3LG/qsa+Q/St9wpvj/c9llcLxsih8Tsx+OHuefGfxzZttfuo1NhGTZk3FN
	yiBf5ZarC0zT1E0fthaz4FUn3zfQc27ValGmVQBHOHDpbogH2bP3lkxDJHGKOq3goAqAZ6l3EeF
	b/ruu3g1RJAWRLHoQtmrGt5ilAjK/57OTWucC8lJqn3S/UDqfQvhgD1v1wFQo1bPdoX/88s5+zR
	+Dr+ocHZgHwRttvOLLUfppeLzETK3kM2M0p7QYLJkrNCHgZw1v59nTxFJbUeo65x
X-Google-Smtp-Source: AGHT+IHo5TP8kbSNrOQDmWwVDscITLHVdVsdFKQU+uxZjGV/HC5MKrpJYOboQtqylKvj+7tvA0th5g==
X-Received: by 2002:a5d:6604:0:b0:3a1:f67e:37bc with SMTP id ffacd0b85a97d-3a1f67e3861mr3297634f8f.0.1746824675214;
        Fri, 09 May 2025 14:04:35 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:34b8:45ec:8e8c:7fc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a79sm4272725f8f.48.2025.05.09.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 14:04:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 1/3] tools: ynl-gen: support sub-type for
 binary attributes
In-Reply-To: <20250509154213.1747885-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 9 May 2025 08:42:11 -0700")
Date: Fri, 09 May 2025 22:02:10 +0100
Message-ID: <m2plghh50t.fsf@gmail.com>
References: <20250509154213.1747885-1-kuba@kernel.org>
	<20250509154213.1747885-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Sub-type annotation on binary attributes may indicate that the attribute
> carries an array of simple types (also referred to as "C array" in docs).
> Support rendering them as such in the C user code. For example for u32,
> instead of:
>
>   struct {
>     u32 arr;
>   } _len;
>
>   void *arr;
>
> render:
>
>   struct {
>     u32 arr;
>   } _count;
>
>   __u32 *arr;
>
> Note that count is the number of elements while len was the length in bytes.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

