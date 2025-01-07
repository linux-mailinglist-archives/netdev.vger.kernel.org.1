Return-Path: <netdev+bounces-155868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1FA041E1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB6188963E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0E1F236F;
	Tue,  7 Jan 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4doySWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C291F2369
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258798; cv=none; b=RiY0WHwEec2ZB6ks5obOt70p9m372ujQmuK7oYZNnnfuBpB5wxn0SiLAwhuhQ1aToddUcyelVEQPDQ8W3wnd/D1PxwusScUfbcDfZFUSjb6IgVwg70bqjcQd/MtWxHBE9attPrJYau64xNeRXkKyNgKP68a0Tl29bvwDE4qKjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258798; c=relaxed/simple;
	bh=HwtmZWMndSkmcqjzIIOGfPV1sCgWCf08bO76OLUEun8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XlonKEpJkcMNbeodRa+JCOaBEgyMvzKc3iqwZkIh4CVVVHgL2RBjQklI6OietpHM3nnMaqvKOt+fGZiMNCb5C27oCtp8qbjAYCsxpQqxkP+8prZmeMDEpbtC4qLixtrVqqUxCh0C3I+iJKiWeG++0USPvM7aHjNMm8XE5Unlk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4doySWG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so2092202485a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258795; x=1736863595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMLViNvNMAFcRQ/OZoGFqF12yXyzc1TQ3JjKXXmZEy8=;
        b=A4doySWGWxFf6kvkvDCTHOAgVtwTGnRe1Zq2W7snjgeOnB2lq4x/jCfZX+xOERkn7z
         gFVjpdh5e+UPbw4aoUhfcFNhweTIUdE7OoFnv/Wrkw09DBUyIvr1oPFBRN16tzsy6g7A
         X4MIz5+1Lo1WwdPGpmZq9wVcm1yw7LDC4BIXxSmtuohnoDsdBjuN+TzvbhbF+dgCczAz
         qJ6Jy6ZIz0X2CwCtUuSF6HLHglqWRInG3nlVa3nO6bLK3NhhNsTFshfqKl7Dmny8PL9G
         b1VfY9slZMpXulQ1oUIb4Q4jU0MuWCixa5ZSrQDCtuNVnmH6YUKG7HurPxsV8HB48xxk
         JKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258795; x=1736863595;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMLViNvNMAFcRQ/OZoGFqF12yXyzc1TQ3JjKXXmZEy8=;
        b=NLgTjcvaRdEDLT+gZSHdjEanfb+uOQOHNBT4MOJ374laf+BJd8R/6Ark1nlHpHNQ89
         LSOSXk2Yh5JPxBzm3ioBGRrInjPImnLcoe9ARgWpGY+zizfHOuml7b/hiAZDRgftgbhl
         WqtwQXx7UvA4wICYOjZYHqX3BxZBqPxd0TaGZ9F/IyF8h+47KDcrca48fll8bFRs/q9t
         bL5HlmMR4e55XffEypRN6F3jLRQfPzUDGlUkmUhx9DZWrOegXC2MtYDi1vp5t5f1G0pX
         nsJKZYWdMSmjzo/c2KQ15ozqBuJ1ZuJvBCgL2b7wmmLsVHMOo+1s2nQCPyVQcLAjJw7J
         tTmA==
X-Gm-Message-State: AOJu0Yxgdmmw5PkJVzHy3E/ZAI+4rjwa+hR1kadFSJ4kQOGE9K7rw8Yh
	QCRm37bqrUDGfjKuHwMMzfzradMlkcbcOhHQOQMPD9/9HK/KqT3b
X-Gm-Gg: ASbGnctNikKdRBwUSCUEEi4Uao4MkHt+JrQ9DwRJH917a5Ri+kIzVJP6fmemgRFBHwi
	Zqj4biyQ8PHPwdc3fNSnDeNi29ClXDDtgN0RaO3RfSfZ6X59PgqXTOotV2mS4D3JQoQYkbOtVRm
	Q6+MJboMIimM/mSyxPLjpvspoqt+T1vMSP2FSZUe9yw++kSz10g6w7zOkCzpa+6J/BVkFTKlIlc
	UgQQLnh5JUcUta+tNIUCypawsSLAfDCkIasIItMMSCphYW+F7SRC4yplKXw/DDnXCE527+Xy8r7
	hlgTy8q4oBcXfDQ0r/Kbv6fP7DbF
X-Google-Smtp-Source: AGHT+IHwEMdBhmQtjyiOiSGM9+oiAHckXPOuQ9kslPQvS6bX0SIQe+q7ITfS8tuLaIIMNTY9t8wAQQ==
X-Received: by 2002:a05:620a:28c7:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b9ba6efacfmr9612737885a.12.1736258795283;
        Tue, 07 Jan 2025 06:06:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac313b6asm1595499585a.66.2025.01.07.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:06:34 -0800 (PST)
Date: Tue, 07 Jan 2025 09:06:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dw@davidwei.uk, 
 almasrymina@google.com, 
 jdamato@fastly.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <677d34ea7523_25382b29484@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: make sure we retain NAPI ordering on
 netdev->napi_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> I promised Eric to remove the rtnl protection of the NAPI list,
> when I sat down to implement it over the break I realized that
> the recently added NAPI ID retention will break the list ordering
> assumption we have in netlink dump. The ordering used to happen
> "naturally", because we'd always add NAPIs that the head of the
> list, and assign a new monotonically increasing ID.
> 
> Before the first patch of this series we'd still only add at
> the head of the list but now the newly added NAPI may inherit
> from its config an ID lower than something else already on the list.
> 
> The fix is in the first patch, the rest is netdevsim churn to test it.
> I'm posting this for net-next, because AFAICT the problem can't
> be triggered in net, given the very limited queue API adoption.

For the series, subject to the indentation issue raised earlier:

Reviewed-by: Willem de Bruijn <willemb@google.com>

