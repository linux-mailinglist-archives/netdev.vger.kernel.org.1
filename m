Return-Path: <netdev+bounces-175322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D7A6517F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25063165C8A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3523E23D;
	Mon, 17 Mar 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="l+N8vsSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2E199E8D
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218858; cv=none; b=g4xVG8AsLsVUfVvRgJonNed09MxVyPFkFE+5uMETnlVl4dH/55uwOulhWr1tvVVdoAFuSM73n1CDtjm2rKqyZwLXA670f06jjPPJ9YvlDEaeIhyDVdG9BZsIrhodqecB9o6nr0obaS1YzjJpKaK+Ucgy1lcKfBdiEjWCvN04AeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218858; c=relaxed/simple;
	bh=kLSXiwVSzmLJ0MkmFRsFE7u2Alq297XRhanMJ1TeTeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ1UMQTVATK5pvZ6EULqa7FlQhu2mSaX++xI8cWIsgrXQWChWdQIO1f9ik4s5P0rVu/s3XU+78OpYXkjVQKl9zG/+8DrDP096uZCYqrTvMjmIf/K26y/XQTA2AXi2HdJFT+me1VKjAvYi8y2pfHjGAoKPljQ7CgZTBqWyAAyYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=l+N8vsSJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso944696a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742218856; x=1742823656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnsqm3xmIvcxIgATEk9k0TzoObowoxe3J0tHhRinQ2M=;
        b=l+N8vsSJZ81ZyPCBFJnasj+AZl7OsIaShD4vGQXCwbsDyedWJWx8fz5xjaBQ5s7j/P
         dw/i8awHhWoUIME0ifbvVKFvICS8PLO/Mx+oW1/NttWQjQ+7sGztMtqah99IBLGiDrwz
         I7f/CX+TocbHaJxHWBEdBvXn2TCFi9Y/hhPOI55fZjlKlKxk3V/iUIp9jB3k23aUrjk5
         aizezf7fOEkjCC0xKnrknkpEfcTqeYqGmlkdbcYxZe1ysQs9ZFu3E53T3UPPfmOti7Bz
         iny0hqNEE7yAHSQWTL6RymZyQOlvfZhQ82+OiNrXVjPEiZ3IDh4j3hW1jBZ/fKe+Oh0u
         w4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218856; x=1742823656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnsqm3xmIvcxIgATEk9k0TzoObowoxe3J0tHhRinQ2M=;
        b=pO3SQFWmfECYGsYnlV6ypbABr52EvqSlqUOc7QjJ2NifMmqTSYPaXcMpFAQ405Z2Hk
         XiTgcxhZCHsAyR0LGAS8db2g4iVRAajS+BqIrmcUShG3hGBBMY+NWIsKLGHU4lJEgOa3
         9Gbs6+icGdusdAuFgQqC/v+GEmIt/s6/rXv2YCNvKTKC4H3621DVQS6eCYZgIhFS/AzA
         WUKEkXcriW1gbT64cWOXFyDzigXwW0Q6cGDYIdqYczhQIwQrKuLfKfaSccVcJkGDCIgE
         i8OhNdZdxsNKmEInFu9VKxM9g/GWwZQy9uVfUlZdYt2V0/E6xpm0tZ0qzSp00kH2oLwN
         Bq+g==
X-Gm-Message-State: AOJu0YwFazzxrqWa/uK6WPFUAH1xCQxbakrPa/4DDs5VtQeD/4xFnQL4
	6JJlx2xHshTg+C05tIHlS0lclmXv6K3Yc+jhf/GrBFcXQCVmon3wxqr4GEglodc=
X-Gm-Gg: ASbGncvjq+XmTzjOUZ2Tg8t+aF9wgfsRZYD8nGcw2re3OwRlqmAcGLZ3ghRQ4+eRRmH
	TFlPD0jHiBihwQSXneHTN8Hn6vTWBn23fds/DDtj1iiGUyaHwsgMsHFBDVypLA2UJE5yX1FNXoT
	cOUnVhJWhidjuTCe7uFfXIa2BiB8FbpG4HxmV8zC65nT9V9ZMuTRHyaGuBOpOUrXfaoySx6RSVK
	pq56ytUwxq2QruG30oX0Vc6i8WVN1Rwl1gDyEz98Mj6SA4E9vfmUYs0v7uG1UUa5y0+gUzyTbY8
	ZHf1nXxltyq4h6Oamxv46szMJ7ewBrdOd264b989wZ064I44lYd2/TosrR+E6VImZy6oAXNKV2u
	KPGO1tI+oVxZBJqnWcIKLRA==
X-Google-Smtp-Source: AGHT+IHcEtIj1ndlsH7GWBKxayrN3xYjDtV9idgB1vOjqL1ZjkCnhtkv9qTlL5li/uvQAhd8+4xc/A==
X-Received: by 2002:a05:6a21:789a:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-1f5c127a618mr18056794637.20.1742218856070;
        Mon, 17 Mar 2025 06:40:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea9724esm7183138a12.74.2025.03.17.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:40:55 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:40:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20250317064053.4fe8425b@hermes.local>
In-Reply-To: <20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 16:39:17 +0100
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int try_get_percentage(int *val, const char *arg, int base)
> +{
> +	long res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtol(arg, &ptr, base);
> +	if (!ptr || ptr == arg || (*ptr && strcmp(ptr, "%")))
> +		return -1;
> +	if (res == ULONG_MAX && errno == ERANGE)
> +		return -1;
> +	if (res < 0 || res > 100)
> +		return -1;
> +
> +	*val = res;
> +	return 0;
> +}
> +

I wonder if dualpi2 and netem could share some code on handling
scaled percentage values.

