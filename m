Return-Path: <netdev+bounces-135479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D899E0ED
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A671C21451
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D41CB53A;
	Tue, 15 Oct 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP3V+4NI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C51C7B99
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980576; cv=none; b=dLU4BSu4dCKWGFs4usV7Z3swWSqnLQWx68yBil59zXFrlI9SmcfiMJZS7r3g1CfTOjk9ZLv8O3LJGEcDjtPauQZbXxsp/MclzIJ7k1BSV3Z2AQiROrwPzJbYAGzxUP45fMHiAEbLuslTTCjNMkfkQHSKzXFVTGaCMdw6CfqDxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980576; c=relaxed/simple;
	bh=NNPZrM/hsHsaii0u40T5699JhwPSOd1nnJljs5kFqUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr035rUd0nEnGvS7jy2UCmPv4/ju1Dx44wurZBkBo5CT/CXYPKjYDtsIzs48TKnt/dbCg4yKGn+y6V3OmLtbpcoHshLX7gCl9iOKTpxeqB96wsJPW6WQjXcGaNppAX4nAk4yY2lEiqErNH0V30avx0mwJTaf+qULZN3d53u8oJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SP3V+4NI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c949d60d84so4662680a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980573; x=1729585373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNPZrM/hsHsaii0u40T5699JhwPSOd1nnJljs5kFqUE=;
        b=SP3V+4NIBGh6XBYek9vvRdPWo4yeGkLw/itkdXSL4pwmGUSFpifdl0sNrxpnev82ML
         3r+jbc3y00aXhdNaWREC2KPDG7iaZlHRLx0m48tMmJw1i5zB/33geFyY5qj1UDWBx8k1
         DJHrRK80c7Dx84H3NGor3UmpMBQmlfhNGiq7fSIoIrEAaVvciBJuGEUm7I0fgHgIJ01B
         SOWTqaKk3JRWmw0Cn2JghlswFZRkjOWyBOFuR1Bm5P6GCgfEaO1bsPAzE85iggsG4kB+
         nlbD/qQHMnpTRLmC8UrlC2UReJcLGyaWr9VPy+r90szFK/pPTaRVMi64xxoNE4MB9UCd
         5I2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980573; x=1729585373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNPZrM/hsHsaii0u40T5699JhwPSOd1nnJljs5kFqUE=;
        b=eaHQMcBc5xwU+vFCuT/hUi80Ba7QupHb7IlWqmsZQbDKkUduOJKlGaWYfHDgZpRSkx
         S2bwPTKi6dL7AG1CYPMbfJHWORj2vWWgbdpZHzAMCRZOs6K3xqAfTV/+UytHy4KsSB8z
         p77GtPzEyNJ5QtYqIUsya9fgF1htgMG3zsQLQaSVxIDKyIaGslzqq/XKBs89ws6/INDk
         e+SZttQHYTPhG5AiN0LcP7C7CHcXvqpOGZDC73B5ZNm6PEPqMXwZm9Pr4rNtycCYuj2a
         zUO5enu/PBCWYE3fl017/n8aH1QYemRJ5EqjcSRBbtEYl3rP0tV16ohTbYbouWBKysDu
         1nlA==
X-Forwarded-Encrypted: i=1; AJvYcCXfH0uLF2B9YRLm0BMaD7TFMpu1vZinu4HadE9dE1vSuvnL7lYw6mjgi4kF9oXYpsZ+u6DXIQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/37sd/HpuiNGWnYTTndQOCOLznRJ3X2TxaJyDvUgpfbCpwbwZ
	TXcyyBpyZHwYRe83UWVtgVGEDU2AeqTQUssg5vp/XfdEKRgGvhuIZ/f6zhGSaRtbavdcw4eOMnu
	FH8eq9iieM1prybHNaej4F23SXNTHQyyeTv3Y
X-Google-Smtp-Source: AGHT+IHnv0vuPkUPs0o0pqod/fLyBEoogWYUEly+HOnq11w0qHY2J5JlzhJtuvfYN+63xVIzsfPdS28d0VN8OKDpTfE=
X-Received: by 2002:a05:6402:2747:b0:5c8:8c16:3969 with SMTP id
 4fb4d7f45d1cf-5c948c88313mr9638974a12.7.1728980573079; Tue, 15 Oct 2024
 01:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-11-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-11-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:22:41 +0200
Message-ID: <CANn89i+HwQiypVTgcBmUAkjL+jeMx_YNxrnZ4uGqttW-4CBwQA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 10/11] can: gw: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register_module() in favour of rtnl_register_many().
>
> rtnl_register_many() will unwind the previous successful registrations
> on failure and simplify module error handling.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

