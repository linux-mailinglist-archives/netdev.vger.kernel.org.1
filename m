Return-Path: <netdev+bounces-119600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB689564C8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B71C21681
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAA157A55;
	Mon, 19 Aug 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="owFl/To0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AD157472
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053037; cv=none; b=dxlBJ7UcHydqdyrRLxR29fUZkqQsBX6jh13ioetRXGIJHM5C5uGylN2eDVV/uIrUThpVzEOyjh1TMJuqGohCcPS3NvX0Z5P/C1vpHABPmvVi1aCT2K0/QyU7DOjjzviuosRzTv636g6xRyhFbcZIqpSfg9TXhbek9tWA6QjgStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053037; c=relaxed/simple;
	bh=8R+HLMGC9DANB5Upwhp7nK70CFwhS9LHDQm2sVdKp9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldJV7SQgVYjg/q1Bv6E9sCdyppYB+nm7oz0Ha8c/Z2HsQRGEvyw5JYbYX9Leu222EPJovkP29c/6i3EABgBemB9JK/teKrB5KHavaImDJ8R0EiuwRHj2Ft40amZCCjpPAy4PdTVI8r6MrT3xXBM4Rln6WxHQ6apc4gUDLOSpR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=owFl/To0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-691c85525ebso36882277b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724053033; x=1724657833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R+HLMGC9DANB5Upwhp7nK70CFwhS9LHDQm2sVdKp9U=;
        b=owFl/To00VXWBCS5sSO28/PnMkDEwYUoEE+0RXhvj/0FNVUzabNnj5ZQ/sEoz6QF1J
         osUgDus9gLORI1PCTtpNExD9yFHXEjGn2V9hep9jiP9uyFdD0mE3HtbGbIuLhnhXs4i4
         aPVL+DY1MKjSwCxSLJe8dAXrdYJ3YXRb3cHKuvWfteT8ciE1dcc5GBo1vaNFkTOyKqvY
         aiv/J+oiYz4oh/G3nSJp81p/fu+/KbluXfCzHRLAaNKI58QZ1Rixt58N0iYnckQhq9PW
         paDORl/C2OU9T1EnH8c/m2z5jcJs4QpeFlTwnTYMl+WIvnaQPU5qjrt7m69rfoLQ2Gkf
         Gr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053033; x=1724657833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R+HLMGC9DANB5Upwhp7nK70CFwhS9LHDQm2sVdKp9U=;
        b=tcLJ3JNThR8TPTt0FPOHmn3aplIeeBc5Q9nupUpxFasNRy6g9uaVZgx92u6f3CQMUB
         6Y5y+3LluwsP+tIoa/GVtG3sRf3CjfGezUjETxsJk7AFMCbY7AIu/IrGE4OwYZpPHBwj
         xSgmvqs23LEecz1fbPt69HNC9L6sDzcRo0ucT3Os3ypehE+lxDH0xDGgqY8EiMKKqqeM
         IgXJqZ+fEfvDVxTP3Ij7NjAjTfoXa2cjuj5AMAlSCPmgTQEbG/SeCK5fmJvO5xquQuTE
         5C74gtwahDSud2qv5dbUMiihRIhdpRuX5TJdvCDv3NyiU7joCUfeLuP3wclvUoB9scdv
         AWZA==
X-Gm-Message-State: AOJu0YwXasLCopmw4xyEpQ/msqGsKYWxgX2LxKjqBsGVakUudh8O3kz6
	VLrQlzV3miFReo25sW6UpY4Q2jGwBeBEZG0MGFLd9pfW+lLOEjaEt0IsZz4Lia7fNl3imi7LPYE
	FYd5yw/yyz7YmRUj+2N73O341wS/QTgZtPa/eEA==
X-Google-Smtp-Source: AGHT+IFp7kZc51+IIezkIKw6qvUfXZ+YpkHllZrprtp0K/0BIXlAECx6uUl9oWabDPVcWKm5IL/NjaLLy/MJWc4bqhQ=
X-Received: by 2002:a05:690c:7013:b0:627:de70:f2f8 with SMTP id
 00721157ae682-6b1ba7e4845mr107827237b3.14.1724053033006; Mon, 19 Aug 2024
 00:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819005345.84255-1-fujita.tomonori@gmail.com> <20240819005345.84255-5-fujita.tomonori@gmail.com>
In-Reply-To: <20240819005345.84255-5-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 19 Aug 2024 02:37:02 -0500
Message-ID: <CALNs47tLDD2SQDeJ7h24Sakd6N244OXM8HvPsHQMds4XjwOTQw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/6] rust: net::phy unified read/write API for
 C22 and C45 registers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:01=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add the unified read/write API for C22 and C45 registers. The
> abstractions support access to only C22 registers now. Instead of
> adding read/write_c45 methods specifically for C45, a new reg module
> supports the unified API to access C22 and C45 registers with trait,
> by calling an appropriate phylib functions.
>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

If there winds up being another version, could you link the previous
chain for these two patches ([1]) in the cover letter? I knew it was
familiar but couldn't figure out where I had seen it before :)

[1]: https://lore.kernel.org/rust-for-linux/20240607052113.69026-1-fujita.t=
omonori@gmail.com/

