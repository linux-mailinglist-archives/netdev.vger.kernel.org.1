Return-Path: <netdev+bounces-119560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D395635A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA32817FC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82E14A4DB;
	Mon, 19 Aug 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="rFO6fyoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A26171CD
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046896; cv=none; b=GOIvv5Ja+prgiBAgCsvcxDW99109LGPD8JSSJOEPb1NwPxekF3K/IVwdYDy2ffz9miaDasjpT7RhhN5vVbqbVh32mY/h1KEihbrsNR5PdEJSzGfPv4b8cob2RBGi35z2UiA4hX4hewE/VIAGuwGx5aUb4g879U5l1ngcOb9QTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046896; c=relaxed/simple;
	bh=MaBJh8Jz318XFOsD0b2IB7IspiHH9qIG5AIeiBoVYLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdirIRa1TKEyqFDcekrVBvszVDfERW28WdSQl5GdNJpQ1QdSscOVn4+NtwjItxC+k+EG47yR4MKKMprpu9fmIYk4/LkxnFoRtxdnzV7v6eQYw3Wf2Lr//SzJ8UGh3+5sRk53QYYseUXOiN/DU9My5jVRjlMYMlINJiHPZGw2xXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=rFO6fyoB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b44dd520ceso18201687b3.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724046892; x=1724651692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyanCl+W2oaRq7tR8CwFXZyhm3yAxQQx+CVxI8yAOkE=;
        b=rFO6fyoBKMMqkoTQjy64wmAOy3jHAMGJc3ug4pIKZpuzyYZr8Y+ZWG3gdHaovkZuvh
         0lrNV59Jz9Grft6iuYEL2Kg62fA2I4jOilSpVNXeGZfQ7RT5ijvsrSOt2O+V/T6gBIZZ
         /X7HxAbt9lVZGHycI32Gtrf3J04G1PPZX31nE8yEbba7mB4qpOiPjwlzek0EI7srLwZe
         3sSh4a9GIo43xtzIaC9ACKayWlPnTpCVbk9rcMYTE4TZPuaCxZpQ7NbsQOWz1xAqxL0z
         Pve5ld0c72M0KDHXMFVFId3WrYNCSGLIiLx4oUsB64Ni4bfGs1W7cJEaX559STYo/y3n
         n9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724046892; x=1724651692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyanCl+W2oaRq7tR8CwFXZyhm3yAxQQx+CVxI8yAOkE=;
        b=kZQd8tFuzCF6FC4Bqsxv98+ur3jQU5Tmce53keaXn3nXTv3Av4NmTWLjVPHXVBQznv
         pt0/jFLj6oXfWgCQ23Embcc0IMtpODDr+lSIK/ZlQ+Rc9tj1rQg5uZeabpxT676gzA8o
         YlnRza5S3kofGsHZKLKpuFbmj3sd+/NrP417lwkI6Ue/aHbkrdu5lVSa8my55yTFBGCA
         Kl3+s5/cXc2b5DyRHDUvkKWbT27xfA8cgm7hc1VGbcab7VkaVXO2b9wm4Dqmx9EFgM2M
         VVVjpgbxEIEFEQPSlREpAm+2ioQhqV83myY4dwJE2i2si0pyENp7u3RWFc8JDUgYzbLA
         KW3g==
X-Gm-Message-State: AOJu0YwiZVa2wWPKfsRqNQQkgt+h709YLVb6fxrw7tiUb5pHz/WxjSSc
	+H+qwi0HzYT7L2VcvuvONi8oqREo9ybxD+9W0P6Z06hUGWqB6xjqybPKNukBvu9+Rt8t6rpmZER
	tKMaYmREjCTWNJvGdwMi+3AZqPLPUFJmq8vcjbWcQGoiYi41i
X-Google-Smtp-Source: AGHT+IFxZ5+LFJ/3vKVkOEpvLhS6EG4HNHbHMjwC+MehOtQzX3N6262gLFLEvWB1VP7lyZkyox/CaaEUsVggncKjO8Y=
X-Received: by 2002:a05:690c:2706:b0:644:2639:8645 with SMTP id
 00721157ae682-6b1b949d3ddmr88026407b3.26.1724046892173; Sun, 18 Aug 2024
 22:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819005345.84255-1-fujita.tomonori@gmail.com> <20240819005345.84255-2-fujita.tomonori@gmail.com>
In-Reply-To: <20240819005345.84255-2-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 19 Aug 2024 00:54:41 -0500
Message-ID: <CALNs47uXqvu-48-H8HsdX=Rk=Ah9+UMj9q34J7kA=3JDB5WYSw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/6] rust: sizes: add commonly used constants
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:00=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 rust/kernel/sizes.rs

Reviewed-by: Trevor Gross <tmgross@umich.edu>

