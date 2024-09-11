Return-Path: <netdev+bounces-127241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B5974BA3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE3F28D421
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D313B58D;
	Wed, 11 Sep 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXCS2lwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515C3CF6A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040466; cv=none; b=QwpXm98SKKFdVeRkD5dcmddPWigzAjVGW10nMBK61UazSF1ugO8HCSIwkdEcWK6GJbgvVFVWyGJ/1bSheNLKMaaRYHWwMMGoYEsm/Of4B1FlbVXgf0NzH/o4JeNONUR+4zvW1YTiSdHxvcH5Twju31XerNy/RmVN+JUn4Wd1Dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040466; c=relaxed/simple;
	bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVhMrnIMXI50e82faXWw+xYIOHL/hkCYcNMiYrk3uKMpM6uK6SSd3XTRS8ubA8p2Q8WfBz4RuWqZPwjLXLqfp5UUfTrCFMVVtLSnedExl8dpK497V5wbmbfgXhZE8MoicjLcWzmI10aMGkbB+sSeA1rNMEcgcdaBzCF99xRpw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXCS2lwL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53659867cbdso8421772e87.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726040463; x=1726645263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
        b=tXCS2lwLRtCgolf7w83k0KAFOeB6oUtzw+UvRuZYlsB7PfKRST4Fw43RA4D3rzdsJE
         ebwAoMsCJdJyGRyRoWD4lYc5pj3Qbjk4a+Ww5BR8U+VjVyktrNenimzOBprMBvwLzQgu
         WUQeLqn41QSfCfSfFhNVSRpqi4Cs9CT1xFylayRhkrZLdgXyRMa0LvCLbgZiMV3BL6D3
         lNTGOCuafkTi7cKqI7qClb4jZ0r5UqyqEfgQC/97ucFhtw+8Hj+3Sr3VD9knc9w50EmW
         biCmkPDCb87tJ5CA9Ql4/lBHsnM4Ei94ttFKunbZ2kM3kFnewcAWLOBoJsPUE8XdAi3e
         9wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040463; x=1726645263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
        b=wUIrX0qf31OZhkho4B0B9MO23VR0RcAt/1X5otqDTJE/+j27lApJp/1WuJ7+AmYyGV
         4psw/a8Fh55miBTzhy1d/SBE8/BTFTmh+L42psFe33FM5fs+Wcsbl5zG7D6fPA2ZUArk
         hbvvRZ8PpVqbOriW6/XPdk3O5tq5JYFY/JiuGq8mC56jbM4YQYDHRXfDPvmC0FMyVKvM
         dB82L4FSbaacFWc2j3BTtzo5av9gAcpWE/cZo5YGSuUI9PXGaRo9gKOJfOMj+AaVv0g0
         H3x8rKVMrWv3EKZloA+vfs+zIwBwljxflx0OC30R65VfKyqrggcNDbrrNsResiTGZwTI
         nT6A==
X-Forwarded-Encrypted: i=1; AJvYcCUaoaEFhG/H1fIHaN2BxeY2T3cJfLC9PXfr7rAVnyNc2/od6yl+ncpwpMOkUbt6D2w2SxHETjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWkPke1HdQzhQG8zMuUuhZCQnZgcJTk+rzdIyD/CM0LnhH1cI
	oEpisEjP9ORkRtchF6nAfpfSKBhFjHj0D79cWM3jTJeHZ+GaKbtxqsIUKBlTdU+na1++uOI35v+
	XxAgFjMLcNkPeKJOiODUf/7ZivCFGP2/BtcmLtMGtQ7vJxVHvIA==
X-Google-Smtp-Source: AGHT+IFRO94eFk8lyGieG6bzBf83rb2Yj1ldYiU+jYKRj3JF723mkSoRslv3qc8t/lvhC6jB+C0t4gg/v8XUz/zgTtI=
X-Received: by 2002:a05:6512:3ba4:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-536587f87damr12970563e87.42.1726040462052; Wed, 11 Sep 2024
 00:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
 <20240909-net-next-mptcp-fallback-x-mpc-v1-2-da7ebb4cd2a3@kernel.org>
In-Reply-To: <20240909-net-next-mptcp-fallback-x-mpc-v1-2-da7ebb4cd2a3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:40:49 +0200
Message-ID: <CANn89i+6yPqdEsf7gEWSys0ibYwq7CLm70ikC5F2Rahync4yOg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] mptcp: fallback to TCP after SYN+MPC drops
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:10=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Some middleboxes might be nasty with MPTCP, and decide to drop packets
> with MPTCP options, instead of just dropping the MPTCP options (or
> letting them pass...).
>
> In this case, it sounds better to fallback to "plain" TCP after 2
> retransmissions, and try again.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/477
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

