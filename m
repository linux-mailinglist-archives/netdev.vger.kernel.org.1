Return-Path: <netdev+bounces-84979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57D898DAE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4DB20B03
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569212F5BC;
	Thu,  4 Apr 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6m81NYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0B12D1ED
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253859; cv=none; b=snfkyXDOW5n6Lk5FEnIK7qnUXGo84GcMGTVGn4gZIL3cYDAjYLt7pUOwWY6Ts+OMOi+PFIWey7Sdus9aahkoWnUp7WhR1nHF1bVezoKgSMch7eyZM6+IGEsTvuTnbw+r3qflrtUql2u4sogTJbET65+QWneWg/N1vRU7+DU/iuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253859; c=relaxed/simple;
	bh=UQ3nNDwtzZGhNX3r2B79tnzlwwXuegoLud5wus3uImY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkm0aXUzC/0qt0xxOEFAJn4jQc1j7B9HFp9BfqjjPD/1+mJsXAtlM5k/IgfftWTj5unU/iLcPY2MDjn0U9OzL3re5qnjuKZSvHRl/d1KR7UPp8cxbAuOXlrFhmJBO0QdBb4s70UKwrOzD8uYzjkqiKIdH+T8K7Z5sVktahxEE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H6m81NYA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so2990a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712253856; x=1712858656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3nNDwtzZGhNX3r2B79tnzlwwXuegoLud5wus3uImY=;
        b=H6m81NYA2F4yDeeyxRGunvjjO7B8OC0jXhA+CkTTWedo3svIgSgkr+oq8MJFMaeHo4
         AVH+P5jj2gcIFmxU/JI7u+7jHZqXXL+m/+jmoJMzn/6AtJhM0duE6y32oXTJkpNRvPS8
         FUU8Fore0d1DcVH4rcBFy8Y55kJEfN7k12Q8UKMcvMxwCqqczZ54VWUhNgTbjKD7BBgX
         jBG8DC7aTGIo/LssKb5zX3DLlxyJCdcdCHen0OuNT38OzIjTDgFOB0WonbQSr+zJPVDj
         SqQt1s6Cld9AbVnJ3ziT5q+fqeLm53SPA/FYdi8Vw6mUxsPFv1lvYouAb3/c9SMlZtRf
         LVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253856; x=1712858656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ3nNDwtzZGhNX3r2B79tnzlwwXuegoLud5wus3uImY=;
        b=bI/1ZOZIITLyCcwKr3MK2i2gklgmJAqg20a1beOB1sXYA0cvxOebFl5aNzSlJ8ypx1
         5mjlWWtfdjguwltiMzErd4szJpJ0xbSGi7D4FE+tKAiBsjyuGBFEue8n/udpItizVHi8
         aqlCAZH37jPCYIkOTjgjT6srNdRN09gpqA2Lpcome/HDUGfGir4VOQKOIbds4pUL7m09
         HpiS8k/3/wVj2OJojZlwKmhYhC3Czmfrg7C76flfNgCrIXcfvcB0jhcA49Muz6rB05am
         FQwEHvTXWAbCFOjvDf+Rw8X6cdFfdH3OzBi/8KwSg1eT5xOKIJ4bV7livAgWMOp36SH1
         RJuA==
X-Forwarded-Encrypted: i=1; AJvYcCXcpj4WTkyqSVmeb/5HV5zz711AjtA8D+AAe9C/jh5145gYKDhOy7r+BV1JYMXp9jqbk0g0XZHay1BJBEOQbHVFfsPJ/sY4
X-Gm-Message-State: AOJu0YwDfPbCrEjlQIeEADWFeExjOaQgvWVtNTd6Os9hvdYvqJNDhNL8
	zy//7mvVn5dUyyi+O2q0mjV+YVWdRvZ0NKzXhEaKiOTB2uJxLnpQa8OeB1KxCeMoOaAjDcXBy61
	Ud0BfXUDLOTxsfq4lsYLUSzu2vAK6ZqsHJI+4
X-Google-Smtp-Source: AGHT+IHD7+n8KXPzEOb7wTWaImtUHgPT4i9LxYXq1dhw0nugWFmnjJmeiLhFFTdEA6/lCFIUEnuuVDRY1p8eohM1/oo=
X-Received: by 2002:a05:6402:2696:b0:56e:2ba2:c32b with SMTP id
 w22-20020a056402269600b0056e2ba2c32bmr35454edd.6.1712253855668; Thu, 04 Apr
 2024 11:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404164604.3055832-1-edumazet@google.com> <8ce74a4c-f20d-410d-ab15-818ea9205ef8@davidwei.uk>
In-Reply-To: <8ce74a4c-f20d-410d-ab15-818ea9205ef8@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 20:04:04 +0200
Message-ID: <CANn89i+W-LDjyOZw3zEieeu7-Gc9aZ3rp-7GJxQiGN98tfS+QQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dqs: use sysfs_emit() in favor of sprintf()
To: David Wei <dw@davidwei.uk>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:57=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:

> Checked that the above are the only 3 instances of sprintf() in
> net-sysfs.c. Rest of the file uses sysfs_emit() which has the same args
> as sprintf().
>
> Interestingly the docs for sysfs_emit() claims it is an scnprintf()
> equivalent, but has no size_t size param. So it's more like a sprintf()
> equivalent.

sysfs uses PAGE_SIZE allocated buffers, this is kind of hardcoded in it.

