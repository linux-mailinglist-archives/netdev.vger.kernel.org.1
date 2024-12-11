Return-Path: <netdev+bounces-151040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229E9EC8D9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C52831EF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B94233685;
	Wed, 11 Dec 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr3BRNSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372A233680;
	Wed, 11 Dec 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908890; cv=none; b=NqZr1SdR5/voQbwmQ/pd/npWnoJfi5+ngZP6WjIz2ZPyw8VJgRnKLwpX4da1/BmnRtfsyFsdV2eOSjIGxGHgxRxxBJBMGf0rW1lUPAZ+n+HX1/V36QJza/P0x43Ta8Q04jBgvIBYsO7Z9slY39lA7KGch2O3PPstAc5K0y6PV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908890; c=relaxed/simple;
	bh=Vbr7zBVOm/pARfCcOcrQIFDxRG1mJaGjCYWMOmqortY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK4e/jHJJ+TGW+6HYW7SjpmuZE5+6YhKxJimG7qzK4u7qONObF4i3+mzZ1TV+2qriyFd6Wqw/veEtLQVOx65WZejAmNkm2v7iWxTCzrNvSQ5mf8SqKRRR/ILy7+V3Q02xoHjNFIwwwrGg9+DLrSr/PvupMHqvFASHJs7374JgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr3BRNSz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e65257182so3177960fac.2;
        Wed, 11 Dec 2024 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908888; x=1734513688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4C7h5QSxdQhEkPXm8Dh6pX6yYARA5FoXrNT66IKEhzU=;
        b=Dr3BRNSzrr6emiU12EqAC7OJ0mVlRYI63EziHgjCtE7WXeytcmtGgNssEfIwU3N7De
         zAfOQqK52pTs9iJHAzxkAVQU2ZNHLSZsDGIvO45C5Tn6MhDO0XMm8/BSgOInXyb+5mhr
         F7a8G6lqVjIxNQs2EUfns+cAeew5j8kJZRXx5HuGBbRJm0LSJWCtVgum9W0ni/HsnZJM
         gzyd16otCB0D2OZSI5cr/u4aTJ1JGI1rXcT525m9LVMIzvKboah3U3FmB7t3T4aVAd2b
         fjBLoGbvd4E9ewhmtoQcrXaA8jhiFu56m9d41wch+REyj5lJ6UCietM6ih+aQjI02RyU
         wDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908888; x=1734513688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4C7h5QSxdQhEkPXm8Dh6pX6yYARA5FoXrNT66IKEhzU=;
        b=LNf7wYnnydv8aeOhH8AqZjjgtFau/Z3dLusO6xQEPT+7NOqI2GnMeZdUp+aTGSVvMm
         NZ3cc2Qru4j3PhV74LBaz05ou79dIlkHCm5jdG72O+zHRaC4eArNvYNFUwCBN0CewKpA
         kTf/9RH9pn+/pNCoaOqEk8KjRHrXxO8qcz5e9/Hyg+radO8dy8HJGQgaLiZOsv5GvGYT
         v2fjrxzk7w0plyulhgthKO5FrFWBqY5QewjaOVo6nRlL9dlgEgCLCgCOpChIV6USwe/y
         gGXSHyOALqq7dJA850bcBD0tFx0FAH7J/ivzJ69qTqP9PdrTnjVTOsnFxYM+jxfQwGWe
         iBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjxLqQHpdUQ7E6CcT9IS1qjxxVOU919PSNJMyqujrNRjIJImK9g1Z/lakJ+yzX32Q3BNeYpjdW@vger.kernel.org, AJvYcCX1QQod1jlY5D8vKHcNR3VQwPKw6bDmmOsV+J3jN4HZF2w8SgjPCAWhYncq0rFOXj5x31YK94s0vZptIpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ppefFOdFxH4N7jL6hdkItUauwFf/hlr0I6SWFRkuqPhwgg5I
	sPAZTzw0nWDG9/vqrbJi3RRH/r2HOb9EZ0JmV9/Xc/dqV+AK4JcqxwM5dBf90QYFY1racxr74pQ
	RP2s7WMN8s5WjKfbZMokIdKCSYHk=
X-Gm-Gg: ASbGncvt8jnhH8z4mstOhOdOTmp3jtan7Pd6yRMpggeYfO1GA1b+yKhYImTq5MucN5K
	vjbdZ9oBCsJEjWoEhOAVpPyrHmT7zM/vRklohovhRbY5c42t3Wk/R75pdADKtK4ndLQ==
X-Google-Smtp-Source: AGHT+IHHzpkUx+85WfKb6z7dl1FfQiVarlRubmXVZVAhAXjutW57Dv2ET8VHr18PaRsAOXGkhPrgH1pQDP3YXgk10NA=
X-Received: by 2002:a05:6870:9687:b0:29e:6b6a:d6f3 with SMTP id
 586e51a60fabf-2a012e24defmr895276fac.39.1733908888398; Wed, 11 Dec 2024
 01:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733755068.git.jstancek@redhat.com> <ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
 <20241210192650.552d51d7@kernel.org>
In-Reply-To: <20241210192650.552d51d7@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 11 Dec 2024 09:21:17 +0000
Message-ID: <CAD4GDZzwVhiJjJ=dqXMSqN39EeVBrUbO3QYB=ZhrExC86yybNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools: ynl: provide symlinks to user-facing
 scripts for compatibility
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Stancek <jstancek@redhat.com>, stfomichev@gmail.com, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 03:26, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon,  9 Dec 2024 15:47:14 +0100 Jan Stancek wrote:
> > For backwards compatibility provide also symlinks from original location
> > of user facing scripts.
>
> Did someone ask for this? Does everything work without the symlinks?
> If the answers are "no", "yes" then let's try without this patch.
> In tree users should be able to adjust.

I asked for the symlinks for cli.py and ethtool.py to avoid surprising
people when they move. The ynl-gen- scripts are primarily used in-tree
via Makefiles so I didn't think they should be symlinked. Happy to go
with your suggestion to drop this if you'd prefer not to have any
symlinks.

Thanks,
Donald

