Return-Path: <netdev+bounces-149532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DA9E6234
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BFD28357D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D7256E;
	Fri,  6 Dec 2024 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRg8Ue5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835038F9C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444928; cv=none; b=YR/o0MizRD0QP0R2gDKDD/xlejBFpXbac6dOWM/yknHa9VK3snpNCv2T79hx8YoHe1NSdWUTHZV/Mq4eWLeicidg3Cm25EXmw19O06cGX6aSOzR4euxFX+ukd8bkXXDpIW35Md07Ad4IUrwPOaZQ1ZgteNURU7IlFloE4j/LQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444928; c=relaxed/simple;
	bh=VfBdcae2KUh5v/VdrEeEeh96qIrIOO+XAKQ7O/pYtUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkXFwy+YPTFBr7XDT49NfsJhuSOgNVgRrbVc6HnVIp0DMQ58OcaOXxSqov9N4U6A9VtRIg/Sih2DCJrnLTW7kjJxuWY4X7CxJYB4rpJSXpBbU771vYkcOsFnwT2ou05UrKm49NNSe9XWwNyJGQ3nVbllOueV4IqTo8xZWdRjfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRg8Ue5S; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e59746062fso1167051a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733444926; x=1734049726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcUMT3Y0bxb+geHb7nUv3OFU7xyZbKbzOqeFtd1iy+4=;
        b=fRg8Ue5SE39HD0KRcy/GjycZXK7wp3wZYt3UHq8Lf1AVsm1Y0wga/+w4fkAXjbGL3M
         2yyf2uQeU7l6tkjbEb4MY/h97ZmBciZa55ewEKWqxYF698jE+Swysh/lkf1rTu0Bf0tF
         o4lonrc5FSQfO6dC4xTkGkvzoGpmcRhQ9V0FeEbr2lgpp/iig0ZNZ5UTzfiqkvyV6eL5
         aLpT4M+jAcHAHvoF3+gUIzJboeLYXX8vk9jNoScIfu/SkEXjwhx9IzBvOQckzuYvHlPx
         X2przfW4rLk6u5pshgpTBoZyIuFrIj6sp1AZlpOraiG1DnNnwKLnHotoUqvVaeE1ivSf
         eVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444926; x=1734049726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcUMT3Y0bxb+geHb7nUv3OFU7xyZbKbzOqeFtd1iy+4=;
        b=TunMxiWVKz+sO+0mFVuOc8jvbSgWPro4blhuEFgcgyNY5z9Wg9XtpHHHgZL08d8uRt
         IxWDURCHpDjjN1peWkTv6kVJTVzFkb9PTNYR4PIxlZ2pU2NfH5p6U+jr4oxiMyRvUr33
         ia14AjpMX8gcp57ZmUcKRRGQg5kont6+Se2FzmJmViuBgLf0IrTRKNMugfmvA0Z0o4Kn
         /+1b83DLzZ74MbvKF5sQ4dUBzQhhC9Qqr5wTJLaTPoqCymjfOPI0HWDlgka8Y38tXnuz
         SVh+GDrgHtUkRaGOOp57zcvEOiuUHHxRaHxyOZgqnfjbztt8/FDNC0y77Xz/M+A2yjfH
         xzpg==
X-Gm-Message-State: AOJu0Yx9TOdaZKh5FMko3D7cDLOC/xBOrL44S/3+5NfRUbQMwQNu+ucH
	ciBnxCr26gPUCf6mYYbPkmUwyexaeeCBEFl9x+ES+gfLIGIOMYAZpxc9mRXnDtz76aAa2f8uRmk
	mGSLYvY9ux5jBRyNOyT8aV3fxxvhaAg==
X-Gm-Gg: ASbGncuo43Q3LHX7UMvZOo9hupw9BuqCRNAw8auXJeQyFpZejCpF5SpMQgA7gfPNiK1
	Ctqw9WceAQQMj1wGq+ctKiHezVheAoQ==
X-Google-Smtp-Source: AGHT+IFaNahJSrbiYpQne7Dp7EAcgbWGLEc9+Siz8zy34dbgscioUYpKgFTKxUt6mU3m3+YqZLQf50uKcLIL1gFVy8g=
X-Received: by 2002:a17:90a:d2c8:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2ef6a6baf04mr2007524a91.17.1733444925755; Thu, 05 Dec 2024
 16:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205070656.6ef344d7@kernel.org>
In-Reply-To: <20241205070656.6ef344d7@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 6 Dec 2024 00:28:34 +0000
Message-ID: <CAJwJo6Y2QhX-_6rW5CFKCSxoTgz7_UqQYR=JZ-Db7hOQTORx9Q@mail.gmail.com>
Subject: Re: [TEST] tcp-ao/connect-deny-ipv6 is flaky
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Thu, 5 Dec 2024 at 15:06, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi Dmitry!
>
> Looks like around Nov 14th TCP AO connect-deny-ipv6 test has gotten
> quite flaky. See:
>
> https://netdev.bots.linux.dev/contest.html?test=connect-deny-ipv6

Yeah, I've noticed it as well.
Going to look into that.

Thanks,
             Dmitry

