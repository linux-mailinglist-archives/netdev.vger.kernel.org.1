Return-Path: <netdev+bounces-137630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DD9A73AF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BA01C213D6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248C1F943D;
	Mon, 21 Oct 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3Mc4KPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DB1EF0B1
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538644; cv=none; b=CMxq0RF4TBO87FnNRYn4bOeuHV/jJYCTjLooR/kIoiHsTeHh6ho0r/gPpLNXOPTnQeBqPfLu3AIgrdLRHpJMxOBdvjTKS698i4KZpWW7MN1+bHE//pjOCBiC764Rs0Xsd3GjQy7shviE/Xi4PRP4bfCXGhb3JBZTuLWsIIr3J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538644; c=relaxed/simple;
	bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rubNc031syTg8GSu2r7iGSbijE/ytsVRrNVfJShakZEtbSy18dOgMg2MMYZ1Nv6vPaF0rWW8OjJuRMZBH/aIMkOKF0AQ0hPCvS4cMOV4ow39yxjHrhXIuzf+lPD4/X3IA8B2rMZchwOjg5DjmHWzRaHm7LpP9iiDYmtmbT31jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3Mc4KPa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e63c8678so5869564e87.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729538641; x=1730143441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
        b=K3Mc4KPagRVjySxT9sxPigJ4cQydp03rp+p1GomJCN89urbXQ8Nz4/gjw7VD1Ll2Oy
         L9arl5+yolZPcOGEUFecxgYawVGYHg2dRBLyCcP/dY6VPEu1Vsx8B6/o8CNUI4JQTG+i
         wZI3WhLF6+3YP674IcT1cuv00wbrAwf42sdJ15hoHBCiIidoUqekTngel01atxac1Inq
         6rYvyNkvHcC4p6+s3UZplnyWkYblPN3UbkYvofLeiYAdjPnmJqw4jT2aProx0C5fWjCJ
         WHIVO8MEMLcON+4I+SSGJIASaV8Y8+0Js93gseiLYlB0i8inp9yl8x0H/PUYtruISyA1
         lKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729538641; x=1730143441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
        b=kLHegBKKTfcHtgniDuvtDFipEWJRJS1A/cZ8e0WRtgUx6LwL8tn1lNrEyzk2DyB9E7
         Lpyum4BGDTP21janhOhoLnZR5SKdlSsP9EfrktfzwR2kvb7FzqWRY6daU89eWAbchOcD
         7Iw4kdo0OnyTdaiq1VRvJ4ZiN1Te2BE65DI8sTW3u3ZZXgUCdVrLaD1nU5UEZTRqNaqm
         17h/++hb+6O3K8GpS1wBLjVIN5rCaoUB+S0c0eE1lrKQrDrlufp9S1ra0177S6YtUy0x
         /6wR3YUif86EH+T094GkSDFUjc57eumA11o7tf01Fp0mUZf8VfkO3BOmU9M8A3OUEVeR
         QBtg==
X-Forwarded-Encrypted: i=1; AJvYcCUhpmlZY9ZyGqMCVW6ANAESQPgtbfO4TkpI7VCXLFLGM1XwCLeN+9YpA2WaSYypVFNeg6UFgWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxi/CnYFMspnN/2I/QuXM5KLfvQPXauZzwNuKpOtQACtrV+OIc
	vIe0kob6t0AxeKP6gedcxMGJtb9UKYiqgarFDeu3vRbETkPdpxiEj/DL50cMTnOWOcl/V6ZZ4Ht
	no7c6w8gdLcLcxmjvLFtasVz+TYGEwRKWdB+T
X-Google-Smtp-Source: AGHT+IFRh1XbNg+j/0ewusaGewVZkzNsIsMX6w9/LexlTO/szwAeGbvnPYVeCPp13s4+dp9CMTE3gxCPLcyFJ7YCXQY=
X-Received: by 2002:a05:6512:2803:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-53a155088cfmr5843319e87.54.1729538640575; Mon, 21 Oct 2024
 12:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021182821.1259487-1-dualli@chromium.org> <20241021182821.1259487-2-dualli@chromium.org>
 <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com> <2024102102-much-doormat-cba1@gregkh>
In-Reply-To: <2024102102-much-doormat-cba1@gregkh>
From: Li Li <dualli@google.com>
Date: Mon, 21 Oct 2024 12:23:48 -0700
Message-ID: <CA+xfxX5UiQuTLnNqXuJvz8geB-K31_6QfSffn5LeXmSiQeM4gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
To: Greg KH <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, donald.hunter@gmail.com, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:56=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 11:35:57AM -0700, Li Li wrote:
> > Sorry, please ignore this outdated and duplicated patch [1/1]. The
> > correct one is
> >
> > https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.o=
rg/T/#m5f8d7ed4333ab4dc7f08932c01bb413e540e007a
>
> Please send a v4 in a day or so when it's fixed up, as our tools can't
> figure this out (and neither can I manually...)
>

Fixed and sent v4 (link below). Thank you very much!

https://lore.kernel.org/lkml/20241021191233.1334897-1-dualli@chromium.org/

