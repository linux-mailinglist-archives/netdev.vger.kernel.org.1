Return-Path: <netdev+bounces-149761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BCB9E74F8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02A0161730
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C81FCCFB;
	Fri,  6 Dec 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCdSh1G7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C191B4122
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500640; cv=none; b=F0dZZB9Eu49dFxOgCKsIFe+KuU4QGKTtMOGQRzY2zpfUcaKmjODwfoVnTVaA11JzOXsUq8CVRZx1V1NEI7v4FpvuNNdfbDbuL53yl9HrZ36BnR6ThgnPZu2aoGaOdie7+G6mIe+mJrkdv9hkM0lMxickxh4FfY8+9QPA79cxFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500640; c=relaxed/simple;
	bh=+HSEPPgI/DSkMwUTk9RHGEYo96tsBEPpPHlcwd8jt04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5VL6vYGDl4s5T5eeKCGAkQQxzGDUdfH3QhgYkshdkTgG/MV2cXJ6QuVZS1872k+8G8OTDFtKHK8XGTgw/400p+nq1sb/s4Luw/FMBtSDYzk2ox5hHdS+6wq+0bLcvl92DJHOSfDYkuww5JcZklnFb576gaBTmCShndofpV+MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCdSh1G7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa636f6f0efso145908966b.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733500637; x=1734105437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HSEPPgI/DSkMwUTk9RHGEYo96tsBEPpPHlcwd8jt04=;
        b=WCdSh1G706mv3cyJ1snAQVbM89L2l/LEdF7BJhwjEcI6t35+rxyxpoR08OO+GTa2cd
         64M3m0oiBrxlK/q3/6dsFnnhbCdp+fNzFERogGUUqevQ/sfa+2niM+jzBi53z6DsjLbe
         sIThtducrYG/60a2DMaCEhaMv7d5yiWTN7DH1eiQUJ9xsO3XvuZ0KfBQUfvODybYlLBK
         Rkx6VlYW54yMcLRiCHfJ9PnHRNDaL4QvEN2P5f1jb+uAw7v/l42R+9F8yqK5KccUWMo4
         p0CK9p5eIqDMQvOQKE4QR+UpQ46qsKyM/U5dyAdjfv8mCKCI4n35ECtEQxiakmXqjzDq
         U4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500637; x=1734105437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HSEPPgI/DSkMwUTk9RHGEYo96tsBEPpPHlcwd8jt04=;
        b=OwIX3v6a0TWjfoP04TP1rRefRvrG4Q5+T1PIrsGSxM6YkNssHnWoTsYF/XuvF3LQW2
         cx/PI5e4bHh4rr5voyKN0qiH/XvxG9xvhwlp6q7DvOxcOOrIe70LgUpUn7zkDKfijyX/
         JTB50hxugscLAHwnXGxE0IV5A+vWNP+ybFHqTIqWaik86CpDtESTwjms9B+lTj/rHDn7
         U0OaqAwoUiKW20nEFX6JeQoM7oTAfIPIoedFCQVNIANMyMGICZVfxDxArmKQP/rM7K5G
         RFafq0EDXbCBGjQcvGUWKfDiGq3HOvlxOtbLRSwEr+5W4tFyv61jSq8JQ91aeIh4rko0
         jxLg==
X-Gm-Message-State: AOJu0YyEPEXSCzP9/cf2mG81ZXQsEzaOu0RedTCEpi3WUqEU6iLDjAux
	2J6qY7jpMf/M4TSnrXBuARXeTQIX+HsH743c0AAOMRI1U6E3Wmke4aPZ++F2B831NHNAIfw0anQ
	ta7kkj0PihhgMLuWo+nyYGn37qioFmzxlWshQ
X-Gm-Gg: ASbGncsN4/0912fzlryIekZ/Hw4k5+z7ZPd2/PDdx6WIGGyh+d4N++/InbdBn5cXAgC
	d+XMTELcfK9Ho3lzZksHb5RjwUMELpNY=
X-Google-Smtp-Source: AGHT+IEFBnrfGU4sChFAYT5OJwfEFcaD2RnkrM9yAW7hIVfJwrVOzHi2/8hAkx5WK8TRJllOcJB4e2UCGfn6+rX4caw=
X-Received: by 2002:a17:906:4c9:b0:aa5:d06:4578 with SMTP id
 a640c23a62f3a-aa63a15a016mr226018766b.28.1733500636712; Fri, 06 Dec 2024
 07:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
In-Reply-To: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 16:57:05 +0100
Message-ID: <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Fred Chen <fred.cc@alibaba-inc.com>, Cambda Zhu <cambda@linux.alibaba.com>, 
	Willem de Bruijn <willemb@google.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> After the blamed commit below, udp_rehash() is supposed to be called
> with both local and remote addresses set.
>
> Currently that is already the case for IPv6 sockets, but for IPv4 the
> destination address is updated after rehashing.
>
> Address the issue moving the destination address and port initialization
> before rehashing.
>
> Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Nice catch, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

