Return-Path: <netdev+bounces-73972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E485F83E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56C71C21C3C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544EF7A731;
	Thu, 22 Feb 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bmf4L0gz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD537A710
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605095; cv=none; b=YT4mI6diKj9taw6Khl+2HVc7ioHrPIUVhmqjM/InqYD7A0L/q0UwV9PrIn5toVNBBXJ/ByZ8SIyE/RnaaprWxUrtFXBVq64Rt5T+V/lhoE1FY+CzNUZr2UwEAlf9vjX8NJY0ezyfGDWOo3M4k5WzL1JcQEP8nNVdRhLYDttJ4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605095; c=relaxed/simple;
	bh=upHR8eftOIDX0Nk6HXc+B7jlOAnVWy5Id6SOJmojtvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8gOciPAd3tZl4f123h46Q9a2rdV9ShoJbP9jmqnvi3vxtZp9WbVxuPVDgT6bMwnSJJDQjEcOIuVLFsFhlm+qgBhe+WyZejQH3NEDd6ZyrwCT3ACTukB6bj+FdSoFvXLd6Rp3TzqtPM0kERztRpo5mX8K5H/b/50Ns4Tn3xTVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bmf4L0gz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so9285a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708605092; x=1709209892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upHR8eftOIDX0Nk6HXc+B7jlOAnVWy5Id6SOJmojtvk=;
        b=Bmf4L0gz8/dOv/gVIQg8DtPE9hzzTqqLJOloASrLn9e0oH89Qh2FFtXroyMl0ApkSO
         jmUaODpOdbzAz2bdchtxVkRAtH8c/d5dY9IAQJca+tDfnE3NWEGo4xERZ2RDHuXrNuJz
         RG53wmfghbm+8yZ6Pf5hKgvFd7hCp1R4PsBC0Yr4c4G2rjAol8Nv2nmXfCFtMevb9T8p
         71MHcjujmjj86EvVu7bUggrqU42JUcALJvV2fTyzLcbAyiqbTXoHWYLReuSNLYTCTqwp
         SFo3hUo8Ye1+9JfKLOV0ha6NU5+ivQo9LiEqOfMEaPprJmnk7NO4Wn6eEx5hC+pxa8jq
         jikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605092; x=1709209892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upHR8eftOIDX0Nk6HXc+B7jlOAnVWy5Id6SOJmojtvk=;
        b=vrYIwLAWn42Ohh1UhjLdmGo5omvUUaTKnNmX4iir4v9Emk8947IH1y6w+EFBU6LbuD
         RwR/nKO/3S4KtTGWSX7oG046RnYQDrg0NptbKA4eqi08Yi2GBIEJc4yIbbR6z0mLKkq9
         6ySM82CwPa6OfyJoXsez8pVpaY/bbO5t0SsOBTTTVHeOzS4HuLnwlyONWzHp5CVMFiiN
         o2LpCp2qP2f8DRJ5UM86F8X5zFv8/OA3sSQOHOC2MmnkB4IOCqJ8m+FhACq1F/6SzwMk
         r3nCJbYuYiccy6Z5/0h0C5FNEyEHyDXHhEXehn9qb84JpdBJYRxMnA8xnDwMX9NlKQTF
         4sig==
X-Forwarded-Encrypted: i=1; AJvYcCWjrNZzEgkFRUCMqUTpH7ni65VnjgrgS8UrQMM4q91MgvOj5mt2pXHPFjCLZ/HQYeG4JZ6PfdvMAYV6SvtCaBZucV49St1O
X-Gm-Message-State: AOJu0YwQtByycxy0Q/XZ0ZNoqmKeWp8TPooMh1oggYYmgzNiH9CeBID1
	thgi/33su1cPrga5eJtL8HrQhzwvfODCJUFWssECy4Th/mKXQZcCZfnFLi9MZOaE77BLLjo5KCi
	tE0gxOtgumvJ6ORqITVpgjb6dCcFrmorG2Ucf
X-Google-Smtp-Source: AGHT+IE2ckprsvwfL2GLsWWcQuL/YC7y5He6k4flGxlg3Nh/gHwZB+fM57asJE9ryLclRWlP+TXt+tBV8w/+LiTLe80=
X-Received: by 2002:a50:f615:0:b0:564:e627:9e22 with SMTP id
 c21-20020a50f615000000b00564e6279e22mr449645edn.4.1708605091563; Thu, 22 Feb
 2024 04:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222113003.67558-1-kerneljasonxing@gmail.com> <20240222113003.67558-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240222113003.67558-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 13:31:20 +0100
Message-ID: <CANn89iLOxJxmOCH1LxXf-YwRBzKXcjPRmgQeQ6A3bKRmW8=ksg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 03/10] tcp: use drop reasons in cookie check
 for ipv4
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:30=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Now it's time to use the prepared definitions to refine this part.
> Four reasons used might enough for now, I think.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

