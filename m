Return-Path: <netdev+bounces-132314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2385599132C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A031F24278
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68214D2A2;
	Fri,  4 Oct 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr0eZ1r2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E545231C9A;
	Fri,  4 Oct 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085142; cv=none; b=dFcgkT84X6xEDm9wpdt4I40jzUGg5yM48OP683QTKIb7y2aw53NZJ4OkrASNZ+8uow3C9F4fGjKEbYZzc/yBS/JNYrrr2iXjuWmYHdHVfE19W9hY2BwEoS1RlprCbmo5Ro40eExbhmvVZqob1buxkhoqAXMsIo/tIbWpvpKXGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085142; c=relaxed/simple;
	bh=oY1TupuPlu14EjOcXLIJBR6JBIQwKhgBi8s6aRIrcAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5qROvwFXDCiSVuCrSMFXW7oaZ0kjXwODfYRnaFqIilqoZ3qXhbMleAbYU6e1IZfaGeTBRGmbHw6nb53u5mEl/OKeuQn4bWgy3cNEusoWV/QlHQu0ly5sPWGS6yqvZ5r0f+0X2lAvRW2WXfqgQ9SN5EW4xk3+nLuG7a1Yq5/9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr0eZ1r2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e23b300bf9so24442497b3.3;
        Fri, 04 Oct 2024 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085140; x=1728689940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPpTXik0wbn3T4wiITPw4m1JZiAot6UkQW0tEBEtqGs=;
        b=Mr0eZ1r2ImKpYeCRT4VH4KRy8To7sf85gOY4ZoquLSoz46DaOMhs6da3frIwkoGCzt
         o5zS3FD7RvfsF0snHXTGAQ5gt9V19JRH0UYO4AVDoNykVWIZjw3z+UMJDEKgI1Xr2Cgg
         5cDEkfhpYRW+EZks22McihgK727Uy/J5Wmqe6bcXTQXyJ7XZB+widsYwvGzfJolTtSin
         hOQHvM/Onl3eWvNN+yNa7KTGyjOC7CrisvT+djW/G/Cm1vbsd70QAK3VOAa6PBLeOq8W
         MbQyk+Q4UhttjYGwnpjcKPisNcKQrLepqYiMA+a0ui/10sP6T6ikrCzIBcQnxqKtDNAR
         oG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085140; x=1728689940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPpTXik0wbn3T4wiITPw4m1JZiAot6UkQW0tEBEtqGs=;
        b=OH34u56dvsUdfmyrWdQMWy/O0TDiWVZbzs5G6I54LaM+rgrXA9pn4dSliyZUHPaHjs
         8pf8ZU3Grmq7QJpx/F/vBjYZrjOzCz+pPpmS53QGupBR2y0E/e0D5L/wbdRCs55Xsbpn
         GT1j5GzzgObHjJbcRmNgM1TFqurNVHV1jVeWZhcBkhoXb4Ja78xF9Dad6Yax5we8yNVV
         f+GPb7MkllRQoOA8LzPtcN0xmXyqrMrKY2L9w7P+UurIYa3kdsbKtHnosz1Jp83l91xX
         kTj8dnub72pB9QQgL0fzM5T7tuCsR7QzrrHd0gXtJKsW269/3dgmCl5mBcXUQOFW97PQ
         jDkw==
X-Forwarded-Encrypted: i=1; AJvYcCUl2ZrVScfltHQvXV6jzyMqi7K3+qd8W4Gq/M1Ex8G8OOm1R12IaW5SZvl1tF7wdgkLd2lREw2Q8xcQMLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiqBmquwfZZqL6PremT/axjN5C5V49WXnuIbuMjLvgiXf4xGi
	cgEuNDM0VqHpNvhXNN/lha1J3G1zlO41UbnQODLf1vtQRTvhZJJxCpVnlHKkiUJ7cD1fvKFTRs5
	Rgrtzjlu7X5x63GvfV6ywyXyfTbM=
X-Google-Smtp-Source: AGHT+IF8Za5R0vlfbgDIrEd4tb5oRDEfIejhm7QFJvFhcRbEKhf8JxQCO7ar1fJRvOPqg7I4hVybtQyfbGTNhaVrg0k=
X-Received: by 2002:a05:690c:385:b0:6e2:167e:8155 with SMTP id
 00721157ae682-6e2c729376dmr44437487b3.33.1728085140351; Fri, 04 Oct 2024
 16:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021135.1952928-1-rosenp@gmail.com> <20241004163253.6a41a52d@kernel.org>
In-Reply-To: <20241004163253.6a41a52d@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 4 Oct 2024 16:38:49 -0700
Message-ID: <CAKxU2N_C-uWK+5jnGy_8VLXAd8_OaWKn09GyQc3pmriSgcBu2g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/17] ibm: emac: more cleanups
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 19:11:18 -0700 Rosen Penev wrote:
> > Tested on Cisco MX60W.
>
> Thanks for including this info.
> Looks like there are various "sub drivers" in emac.
> Which one(s) is Cisco MX60W using / exercising?
All except zmii. That's for 100Mbit ports AFAIK. Cisco MX60W has only
gigabit ones.

