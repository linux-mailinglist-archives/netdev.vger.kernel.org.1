Return-Path: <netdev+bounces-160295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8CA192D8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B539F16C5A3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F52139BC;
	Wed, 22 Jan 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfgyXjsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB12135DC
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553477; cv=none; b=lWgelg9XKj3jz6zihxVGrESufF1Oa3gLM69PjGmMYOdDbryjNu1LE3BNUV83/4KyHmoeNO3bhbpQDZ6feL+5G6VVh1GF2Yb2V3tu9inYRjVDlS6iU+phAJmIKxcTnQqEDrkL+AO/1BmMk48qO1hp935nik24m3MLhgDNIX6w4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553477; c=relaxed/simple;
	bh=BIvCWp8FFu3JhEClwVZrpfTGXiC20e9nDxcxKC7KN+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfJf9Cldvx67kumyt3yJnIjvVa2PDSoaaa05aMtOEvCydkKN6vecOQAi6YnRBBsOqzPjqkEMDAyeAeKveCRWHOJxatrVwnL2I7WWUoYq6WAtoi8+hWTxigDHo1cxClm2WUUlaPGRnOPaviVOjocc3uFessHjXJb+YxxzGizxOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfgyXjsU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so12746260a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737553474; x=1738158274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIvCWp8FFu3JhEClwVZrpfTGXiC20e9nDxcxKC7KN+I=;
        b=XfgyXjsURJWWI1SQ9+iI4bKv51kVsSjblV5Fa6TEsbq6GPUQmGrfspO6k1KNrbGdq0
         viMReKUz2C2gJ89NkOim0zAC7XDfy/POrs3g6Z8yM/bEE3KHqtTKRYMyLnbYxCw74wFR
         0gnGLnb+Hs9jmxI6tjkm1f0KQnAmqqRoVuTo+lZWuymRSekZngU6d0nZySLLc80ev6TF
         rmEvNVehLEF5zqJUjs3uQv8phbuFMuNjb2nec+F4uLcJohMbZL/7AbkDlXR4y/mHZNAK
         JEx9LLDBZG87s1NI4S9k4izWzgbezKKoDqg0fYw74uR+Yb0iutZCmAommnr6L9ncaFtM
         Y4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553474; x=1738158274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIvCWp8FFu3JhEClwVZrpfTGXiC20e9nDxcxKC7KN+I=;
        b=wmwlBtCGUr0tZH1Igo6nn64bkPXOStJEou3Z8LMp4pjPZcI8kzycPYwgahDM3ldk/Z
         br4oBC/IxVJV1HFGTWnNUqe7g6CAiOjIKNszzUdDRUnYl9xoixK8OAs0KXCGY7s3eVy6
         vUg01HxdAJXn+lM/DTdi84IrpRDHcXRQ0hBo+O9PZT/JzNVPkd5esRF10AGxc8odk4zD
         OtZwKycLWMT88zHgr1EjYhFe05LPJK0K6p5XgJ4hqbqY3vOAFbwpV1XteRVw/fenQnzJ
         qVMsXabu3F8FhWoyrYHntCYuSn7LMdldwkefaD3C/eFSNHBMMAThrKRJQVIc5RNzXr7Y
         N12w==
X-Forwarded-Encrypted: i=1; AJvYcCX4MFAnlJ0SGQcqZpW8Ms4u5DpL/dKCbGJhWuIc9hgE0OhKMwMRUuVM3e9rjoV2QeSejB4QwRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSxNVfCbCRu9yqJ9WPZGr9QrDfDkOZQHAWURSxuulb6TeLITV
	qPhj40j/ajwonOypx6uOMPnZQGR9w5disRfGw1rU40noRQve+iWU2uQcczMdRW7ER2jeBGXGHg9
	zimOjyeJeoxxgl4RENgCRdRjdIlecqKCoCcrSw7dLNV6PzeGe3Q==
X-Gm-Gg: ASbGncvFyIRQ+xv9zfzNjhtbYOhKqpIEKzB2+2nl1TXYcOg4QTrwaNh2FLt11xCOO3E
	vJLXCR+7ZX+/l2I5rEuRCzh9NTvIpPOZPSjJrheFexhAdYHBxaw==
X-Google-Smtp-Source: AGHT+IFIQIEMRT2LZWeFpL4TMoPbPAe83obaJAYSAVPrIeKUDOD3KAY4PXuFRASJoKQmWnfT0gvCQ/QN0jc5q1RFqMc=
X-Received: by 2002:a05:6402:5251:b0:5d2:d72a:77e4 with SMTP id
 4fb4d7f45d1cf-5db7db1234bmr21211043a12.28.1737553474328; Wed, 22 Jan 2025
 05:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-4-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 14:44:22 +0100
X-Gm-Features: AbW1kvZ7amq2FQ0lgMye820n3-QVW1OgwMgjmK3wGHBWcUMzn1aXt9TVvZZIMOg
Message-ID: <CANn89i+r5RN25jvXJmF7w_HcFph9xEKJfzAMsk+T6fgdPJUkOg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] eth: forcedeth: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	rain.1986.08.12@gmail.com, zyjzyj2000@gmail.com, kuniyu@amazon.com, 
	romieu@fr.zoreil.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> napi_enable() may sleep now, take netdev_lock() before np->lock.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

