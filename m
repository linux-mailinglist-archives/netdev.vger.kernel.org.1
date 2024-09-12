Return-Path: <netdev+bounces-127946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7C9772C2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A937281AF1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368FD1BF7F9;
	Thu, 12 Sep 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1i3ks5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6721BC09F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173311; cv=none; b=H6pcuJ8MfAulHjzDBMXThXB+aWKTbVASjulSCXf1AkqhrLAgqNck1mdgv9FkAKsHNG9pwifW7PQpFjSTjEiNacMwF6M7YIF4uREl5y9fvKMNMREtFaZDzkfbc7wJewbYul5POEXG0FstNX9Q4l7BMh/Lznn53JEz4K3BWbiFx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173311; c=relaxed/simple;
	bh=magR+6/JzW5yaiuHfIsOBpljH8zp8gBOUAa3k4YeExI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHQecsIIoTCbVcfWVpmLqGW4eYAFxlk35XzcAGLyIdds51Hju0VFw0c/2xuQCkRnU74QIqyJXMZh1u5U8hpUobtwT4GSui+pKYU+XlrK2HjqksgP13zj/I/joIOUgsCp0G85XFhK58/Y5X2PGnJFMeYOoQBmLs0iL/braW5yClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1i3ks5k; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582b71df40so16181cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173309; x=1726778109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=magR+6/JzW5yaiuHfIsOBpljH8zp8gBOUAa3k4YeExI=;
        b=F1i3ks5kPZpD2CzHgiLx3EUzhtdgFUwJ+iBVWKqjGecbME/sNKj3+UoQeoe2wG+mSV
         D018K0ORZf+nLFQAWF3IpYOYYYtbdHfFamaSnF41O+cophB3c9htXxo7uZyg1vxX6q/Y
         qu7UygKmCfAllY9G0kqrn71NSpbyn9wLEjlBFoxnIm67dTWnhD/sgGj+tY+tE/uyQOWJ
         ZxbnDVROdNmFKaRrHfOxkZqUSy0Lj0UyyR467sixv8JvGxqpi6rlkAmO7W07mL2/UvYs
         DxiVYj1wpiUgNPqykw/O6/fOun16aGDHYIkMSnGTLi9Z3A/Ga5wYo/oysTb2Nttg9b9L
         ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173309; x=1726778109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=magR+6/JzW5yaiuHfIsOBpljH8zp8gBOUAa3k4YeExI=;
        b=H2kb8if63pLJFnjM+3BzRgdKDpr0eh7l5z7Gt/xoVZhAwJ2JI8M4afrJTZs42ounBu
         Yj7mKDoqfHUKOI8D6zrI+mk4WYmC5kEEHoesZWYA2SWJUU05mz9Tm2fw92vjbGeZQwIf
         P6DumqIxf7cHPA6NHmDttDf0S6HJs9o5oz6FBSfsvcj+ilN1EQU4SFmcYJkP6BZ+qVF0
         v4qOvme+fYHqIbBEfpze0inlAaFpUmJYRE+VYJfuawyRs3SCHF4nsEkijkvsCGy2v4ED
         eQsLRHK/vualjdRx0AAikLAk8mcGUmUBt27flTOi9x1AIHcfpjcW7NIqGKAf7adKLBWM
         GvlQ==
X-Gm-Message-State: AOJu0YwICvCgFNf5D2DV8UQOqguUSO+ZcsMN6NdRtOMKCaHoo9NzaAtk
	eF1DnGJ12gCodwiXYrHQKb0Peqc2PUHDjlxvCvh6E5HP0hwp1QHWCQ5odlQqH6Dl0qIgSQta+lc
	6hJRmgPBdz4FnfBrP0X0zKu+417dqquW94HUh
X-Google-Smtp-Source: AGHT+IHWGbkMbZlVGLeWb9px0ueuf3gCgtpkmLzUhsXAKP708aF1mTLRP/7hMoQ4Jkmh42llIASW6mSeC+nqvdLKGWA=
X-Received: by 2002:ac8:5ad3:0:b0:44f:e12e:3015 with SMTP id
 d75a77b69052e-4586452ab7emr4545761cf.25.1726173308190; Thu, 12 Sep 2024
 13:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-12-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-12-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:34:55 -0700
Message-ID: <CAHS8izNKzuNX-nttnucfVioOt4PuMOfq0h=5W5=30jouP_2qvA@mail.gmail.com>
Subject: Re: [PATCH net-next 11/13] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Use single last queue of the device and probe it dynamically.
>

Can we use the last N queues, instead of 1? Or the last half of the queues?

Test coverage that we can bind multiple queues at once is important, I thin=
k.

--
Thanks,
Mina

