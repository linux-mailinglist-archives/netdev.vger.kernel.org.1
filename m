Return-Path: <netdev+bounces-130938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EC98C20F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EBA1F26500
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351571C8FCE;
	Tue,  1 Oct 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJW2JKHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F61C7B73;
	Tue,  1 Oct 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797983; cv=none; b=EkMQlEzu0hFVlLonTw7UzJqfX51XFEOlBrkIWM5EaAG2ZHunwlht2yWS734U89/WDgTkwXmvDeY7rke+rHiKu3n0QRs45fW33FeZRy7PIoSFg/JBpWqDmPD6jz0N+BiH1jyiy914Ek+xq7qkRVIBo9xxVkaNQvXs3Hfrv4kEMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797983; c=relaxed/simple;
	bh=I1EN8WM6WlNYcwlYbJtuQMRVRuc6yhexbmYZ7lgHd3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTX440MSTLiSlCPT5mfDP1+lBe9T+9SmJjjEzI/AYKt+PJ7jbLEeOvuzwoyVMsKQHLDwoQlhGB3TjVv3jQgwc5ZmkIL3ZEawzTeW4LCqIF+I74Y1JEfwMqy39kzkbJWo7LSGRqD2PVFdiEUNuS/UGZWc065QlLCDonj8n6Ij/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJW2JKHb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71790698b22so810777b3a.1;
        Tue, 01 Oct 2024 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727797981; x=1728402781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1EN8WM6WlNYcwlYbJtuQMRVRuc6yhexbmYZ7lgHd3Q=;
        b=KJW2JKHbS2LAZkfSWiVv5MkdjqDb0rHB5c00MBH8v7GF7xlNzzRsFAM3i0ENNYNTAy
         0tR0eO5AGKw4TrYlFEjEmEoQd4jpMUfxSb2CL1T4S8gXFAUZrEkMNbaEGoqtPJUTY9tW
         DYhiXIMVMMEvqvWKlHDeD3E5jqGVpCFsILDFTx1DJVF23EGaIsrjMV0qzfc50YTc/4oM
         J0shW1x4f8/vTqvWxqUxGEN8qJY2dbo8Q4GfE/MERw2odIEqW7X8THgFI2ceX98wvOkv
         OzDK9vcjEPcNU27APf+fbXlMZuoMLzRqQhXdaWErOg9U7hflnLyQ4/+IqW48DjQTrUx1
         dV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797981; x=1728402781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1EN8WM6WlNYcwlYbJtuQMRVRuc6yhexbmYZ7lgHd3Q=;
        b=S/YtC0OZ96BRwwaElyZ5m6TBze7+kYMHyY+wzuoanH8HuEceRqfUKuNIZ7CZ4l4LnQ
         lXY9xILItcGzT7yiyCdPfn9R1QwmKxZVRBfVsCUQjNB2jp+uFoD8WnqegtP6Wi6o4QOC
         OHZ8VVMHandHZEIjUfNKU8bmEMOpEvJZylfjkP+cZhYB7H6s6FU/zdrGiZ9XfAMGy7Kn
         QKDropGBJodqMiivQDusJ7vXn61Fw+gGZJT04G0MZKag+poRvixlnO8vk3l/2i+SvGsX
         8w0xdt+n+so+gD15SprT9M+I5tJ7TI/soyBEEr1+0ubfRwMgjBfwbOIlKyGm8IovO8Yo
         cbzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7wU5ZNvJgprN4OmqnounaR0GKbS0qwQ7CltQMicIwVxmxw8RTfH6GvwP9APp4pPNxerGveKladdcreHvtXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dggp2CkBdu0lPiJFVDgv4EPNIX08Ajdq6lHEn6jhOXeS6ek5
	qDB04kO0GDIYx1sxVsQCr/ULYLRFKF6UxckvOvFcY7T53zxKU8dT9i7onMz0ciFZCiuK06Sxfvz
	kpl2//kme3/ysJZdvujXKLdDUhgw=
X-Google-Smtp-Source: AGHT+IGuVsu+bost0XG2Diz5M1G+dBUjtnnh6zWkPgIrncfRleLFDLGEITo3yTPzeleQVyk+EWXWXe6wcofXaEUhIfk=
X-Received: by 2002:a05:6a00:138b:b0:714:2051:89ea with SMTP id
 d2e1a72fcca58-71dc5c43365mr102145b3a.1.1727797981013; Tue, 01 Oct 2024
 08:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926121404.242092-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240926121404.242092-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 17:52:48 +0200
Message-ID: <CANiq72nLzigkeGRw+cuw3t2v827u0AW8DD3Kw_JECi3p_+UTqQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: qt2025: Fix warning: unused import DeviceId
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, aliceryhl@google.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:16=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Fix the following warning when the driver is compiled as built-in:

Do you mind if I pick this up so that we keep WERROR builds
error-free? (I am sending a `rust-fixes` PR in a day or two to Linus).

Or is netdev going to pick it soon? If so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

