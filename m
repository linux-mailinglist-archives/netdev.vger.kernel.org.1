Return-Path: <netdev+bounces-78731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E269876493
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C165F1F22025
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7217BDC;
	Fri,  8 Mar 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5D6jNEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D418EAB
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902459; cv=none; b=oxe9Vq7wHy00LpeAkfdGyEOY9WGxMroSEXici0cEoQPvoJC8W2JKCY7NeSGx4AMe9czw4/1XXoFHoI1669eoWhMJeXBF6pn1Xt955tSD5zlPCTyvX846bebc5aZSm3UpWmaW+bN6XFxtDOg80mwGFWYEgHW4ZvMBQXZdTCsiBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902459; c=relaxed/simple;
	bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCHPAqyS1O8h0xbwUaGtUXO2d16RWCCPlQ3v0i1F9P+XaCibUuhx/RjhQx+Kkh//mo9jP/HnmFpauQtGIoYUzY8o9XsOE31MOvTX9FvHEsKIZeOjKem3F/tGO4lAQ2T1X/DtaVVur5JzuiXRRa55Z2B8bWZSS3oTe9cJVZ4kh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5D6jNEb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so15056a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 04:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709902456; x=1710507256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
        b=o5D6jNEbWbcAzxkQ9M+RMrsnKcc3kkiyO4YCM0NErlnpdPl9DNMwHCJIlZNBXiwx68
         WXDMS1pmSFKGP7bOjam0v3uwAUYUPxQGh6BX3fZ4rbb81QDocuBKmPDKdR9ZVY+GxYB/
         vLRSjFGI6S9xOPYVw0Jm0FtVU803jYe0N4pamCkUorpnowvObFIFZxka/7nevOdBO7Fb
         E+ZNyjOIXlz2LkbR6sRlFrI69371yQaukWltVlpXQVA8flPZLg+3XQN+BtoCFPpra3yt
         t1MXqcaePCmhQ5QCh1wSezF33fRfFkw0BJYd44hnXrcbweuxeJTm1g02eFeXKJdk12R7
         c96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902456; x=1710507256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
        b=lgenfA+Oz0XjwI1Gx6H7niQoNHesuHiXdhQAwWBcizIhwuiB7Z0ipHrB+f9cjmy2QY
         VWoLPnHoi52PSCrxTbORBEY7h1hE54rd4YzeaQaKE94yIWTPMzVImHeWLhzbjwjrYb98
         hD6k11TkhS0voaqF5Z+MoQuJU/zum/G6S+4FFLeuewP7kPYC5k8lMC+eeaLkJCogYqDR
         okxK/8TSG2yTCb4Z2B6R207sP2/KQ77pRzr3CHAyin83Lc0tORE9PDxSu1dYsJ8eimDt
         sPvEZxw274Y87q8ENXiSa2JVa/krqSUbrCFXu7kxEfxRnUGu8W+wToT2AWiKTtozzsXC
         h+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWkE84cpVvxT6cP4F93/P9h/nKVb37m2gXWRfxmiX1z67Scx9JQWPbHYZaO8LwU0uOxR0HPe7njEyK0YmzjRSKaOaWlgl/U
X-Gm-Message-State: AOJu0YzKe3Exqi29CuzKFZbvhvaQTeZvgDFxcC2qKRRBoyhlkr+Dchhu
	ojgwQfylGPPzvXBD6yckr6gtkLcNIjDYQ4jwZ4aqOmwnpQ9fl1vn4i3GeWtemSR041RigODQP9j
	/hbFinKXxCXcDpfdB0qMk0KWCD89bgV443I9u
X-Google-Smtp-Source: AGHT+IEGml08pvLJ9T6mUK843g5WD7xcNWqyrsy/AFWQwhrshtjB2SW+NypVQWf+EBk0jLN3uLwh2XmPqVlgzP3RZh8=
X-Received: by 2002:a05:6402:349:b0:568:257a:482f with SMTP id
 r9-20020a056402034900b00568257a482fmr225313edw.3.1709902456150; Fri, 08 Mar
 2024 04:54:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308112504.29099-1-kerneljasonxing@gmail.com> <20240308112504.29099-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240308112504.29099-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:54:05 +0100
Message-ID: <CANn89iLaD95hfe90EAkkKadxhDGniT4q5tf2Let7kTHYSm2gqA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: annotate a data-race around sysctl_tcp_wmem[0]
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It's possible that writer and the reader can manipulate the same
> sysctl knob concurrently. Using READ_ONCE() to prevent reading
> an old value.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

