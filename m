Return-Path: <netdev+bounces-98681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D48D20EC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B12B231BB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AA17083D;
	Tue, 28 May 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I84F9MFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4C16EBE2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911884; cv=none; b=rlrSi2IoT6qQkzl/s6klA8Qw4/QfzqtWSv6A47lXiGaR//PnLginZg0hj24vCV2yW5akIDmc42FpuABa6lj0UDozeItYOOrnSyhV844EGCf/4K0ycpXZdx1ESvVm1T4NGBIsVopjgaFJTnRyL0Z6DZbUhQ5PhU2Z/wGpYul40l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911884; c=relaxed/simple;
	bh=E5IyaMl1+syKFYIzvuhau9vDNA18ADiFppgUgfo1Ioc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUkC3pbUmkOBRv+6aZz8/UA4ma5dLHym+LWkhAFDDDwC3lJbUS5+tr9EECLnGwH9kuSsEbrKP6mBvs7Fx9VFxzMUgSM5Rs2efyEirPW2xRUjQYUu3UK/lQlWbTf4pDElVKxkc12nCY7QAtECB17qs4IGeO4wFb5rL7dGBhLbAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I84F9MFV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e7eadf3668so428504e0c.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716911882; x=1717516682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEq3CSLqJ7CwWb5M3DLfelzAr2/MIODd7fEuDXb02kE=;
        b=I84F9MFV71icDEyYIfphn9B4vcpaIFxQrLO4ok1HxlUEH67ytqOX3sFXQNBL7GnPLi
         Eh5d5gh5UuOxl7EvaaTvYR1FOZ03np4GFjWnbx33hsgWeJsPDplNmWWSAxkF34Cv2/at
         FmMBp3F/luhPYVTWvHYoUmQoVRt9K1O7E83RNG/3XQclLb4bK2hPzcLcS6TMFeOJtX37
         1//jQ2ovg1JivK54T6RNxU2CaQaLeB6Q+y0uBZrSTEwH4N0OEjaRFhXm+qAlFdxVRUAv
         q1NA8w/G9Nsr5szrzb110nWs7hQODLRcEuEWLQSXwaYhf4pvDZ9YCgZUP2xAUuiLWUVG
         Oomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911882; x=1717516682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEq3CSLqJ7CwWb5M3DLfelzAr2/MIODd7fEuDXb02kE=;
        b=IybIl1XnA1NBJ+JiNSdw1bCrN1rdIjI4YqNe697FVSKET+nokMMK6hjihWP1AZQMMt
         IwNe1r6+RnN4sWvP86K57dn0Q6YU3eASDymoLT76n//AfKIxnMv/AaaXPrbgO0QpDnoA
         rgl/moxWYGsUWhIT1/Am5M5K9gyCXm3kLBNhYcq0MB5v5PfHZzKy9KhsnHYpC/pRxxny
         WPao4tXVMZsXTj6SJI09PimGIzAguA3K2SQVNdDTUXk1KOykq1Axgtbw2klzC/I1EeBp
         UPKD3XuHH84zJ3rjKmzLC2MGS/aSu4ld546yl+MA5ltk3uNT8R0FRSj8va3Imr6DLxtx
         mCww==
X-Forwarded-Encrypted: i=1; AJvYcCUtncp7iB6760JgCbyMvM8hVmf+2q4hqCYRXGqTkmVUaM0aI7oCvnWgqOdp3hADcNZ61fbV20JkTll//U6SLQOsUy0nuIgR
X-Gm-Message-State: AOJu0YyZ9Uzd0slZdqKKDT1C9LBk7uzCxtgQZesDY2jKpMLI7PUXf3kt
	XTJAIKUyxMsxGtM6/jEFeTUbYgskgWzoXKvkBRtTf03sJxrW4tL1IcS30A/OWMgG2AIY8eUrf5B
	x9qw0UM8I/w6E77FNFE08hBXi0FVyRaqZyXK1
X-Google-Smtp-Source: AGHT+IG83MMiZ7d+aa5gb0M1TK4PFFHy3UXkjxY5UhBeCgIzHhQXBwgSsIpCwJSpki4fHSu1FJwPhEuJKDDVTXbpdYo=
X-Received: by 2002:a05:6122:458e:b0:4c8:e5a0:4222 with SMTP id
 71dfb90a1353d-4e4f02d2667mr12627125e0c.12.1716911880601; Tue, 28 May 2024
 08:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com> <20240528125253.1966136-3-edumazet@google.com>
In-Reply-To: <20240528125253.1966136-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 28 May 2024 11:57:44 -0400
Message-ID: <CADVnQykNsAjPbkOVaSHH8ceasXsPMtOUrss2wDxrPbNmQGT_rg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/4] tcp: fix race in tcp_write_err()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Laight <David.Laight@aculab.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> I noticed flakes in a packetdrill test, expecting an epoll_wait()
> to return EPOLLERR | EPOLLHUP on a failed connect() attempt,
> after multiple SYN retransmits. It sometimes return EPOLLERR only.
>
> The issue is that tcp_write_err():
>  1) writes an error in sk->sk_err,
>  2) calls sk_error_report(),
>  3) then calls tcp_done().
>
> tcp_done() is writing SHUTDOWN_MASK into sk->sk_shutdown,
> among other things.
>
> Problem is that the awaken user thread (from 2) sk_error_report())
> might call tcp_poll() before tcp_done() has written sk->sk_shutdown.
>
> tcp_poll() only sees a non zero sk->sk_err and returns EPOLLERR.
>
> This patch fixes the issue by making sure to call sk_error_report()
> after tcp_done().
>
> tcp_write_err() also lacks an smp_wmb().
>
> We can reuse tcp_done_with_error() to factor out the details,
> as Neal suggested.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

