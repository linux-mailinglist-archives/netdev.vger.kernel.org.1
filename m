Return-Path: <netdev+bounces-137020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F39A408D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DCE1C21593
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5E18E37A;
	Fri, 18 Oct 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyzU8Cmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2991EE011
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259776; cv=none; b=be/RYc2ypvHlfSpH9mabMLmmqE/b/SZ+zlFbyvvU5v8B+fAt1hwE64iva4uqwhj7tX/xmXvruPEiMgoXI05AvHLU1E8p6lfsXauXVGDksx4NKtOoYtzWgLpNi9Kda2+eLRpIfKjYKNS2mSJuF4R62kTzGvjLiKEUuVYXfp+REqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259776; c=relaxed/simple;
	bh=yAhSv6hHkXizOcLrMBouieikXpwGLUIDtBIkTxJOe/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oImGN8Ne5/c1JSGBmmvP/rqi98cT9zZ3J10jSAE26CsmH3S/kzE7hiUDbZLciDSRtinKZznOyZ3c8FzHVf1ATyDAPjmMXQPAp0+33EEu06PtJojSRBs1W7v3B17FWsVcRYlSk6F945T0TeNPzhOx6NkINtR1H6iesI8e429Y/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyzU8Cmx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso5664694a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259772; x=1729864572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAhSv6hHkXizOcLrMBouieikXpwGLUIDtBIkTxJOe/0=;
        b=wyzU8Cmxfsf5nqEPqzZ+egFS4R47IXwRTqIkcIqAtSnvCQcPsy8XiAS2rX2JOEarhP
         6kEmeywktpTvhnN/10ulgkHjpxpNbADSoky/+BuvOMx1ieSLIh9Ry4t/R8kriTi78S9d
         67EjPRwC933uBxt+ONvdaKw/XVLdmswcHz5e61sQLMDfkf8UNwL5j0hRFCsRaMBE56QX
         YUQxAOFE2K14kzb0t2acjDvZQGZEtS6ItYW+IRnPJpVkUmmMQ1FHkEIKRjJfhKwtPtjK
         TeIYfpx4o14/qHrRgltfJ0bAyyMeYK6lM812YEvknk8DVYiVeWZuMRLw/JWcrmRyvCkq
         2TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259772; x=1729864572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAhSv6hHkXizOcLrMBouieikXpwGLUIDtBIkTxJOe/0=;
        b=ChbX3ZEJMgWRV9+8rw4Bix+s47ioWBIr2kKREdhvifLLHZEOI2NrcOqwvg2J2LYxLC
         bKIQXz24T2lThVuU2IBkGJxXX9oB3MK+U6i8xjXbiKOuPbOkZWGMjsqb261b6VT5RcYk
         5Ii7rmABEaW70QWB5jOH3luldWsI5JpvgMbmD6uR02tPAPKTXaCzrVxKACwGOUPiLMXR
         6gi8qeO6CMJApwfAz+DaRMm2o5oz73PJ9VBkOzB3EFsZXokBf0+qN1WAKSDlGNqw7gdW
         Jk+WhyGBiqdPtetaIIJDxJoVDNGabrcwW2mMLJaqZbXKyn/P2WKuwPj6QhlK9iuZXzU8
         tCog==
X-Forwarded-Encrypted: i=1; AJvYcCXK4oQD/LSmepMhtxyIuQaFy9ibt3TtWsc/MzBKG7cWI26fYErC1ebgb+MfJzAV2lTCMLNq2gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCA4EdMYPp8+3+yc+QnQbzxddOo8gKQB+F7n3ZTfwiBmvtwnLe
	U7NdjywpWvjX5lPjt9yxmosddbFnzjbQeb/wZKEQwDE3R88vU7tP8xf/TZ8iBxvoZ3LcIidq7vf
	aMReGnudRISwKZx/Sj9PsXOhCF9GQmQA2WNHbOXymY1OgUqgAmBS+
X-Google-Smtp-Source: AGHT+IGgw1tO8KIY+EOWErymQTSy+QR1wLERf4Lu/rG3S78AsNHQUBucEcr9XdCDX0ubZ6wSZAhd0dyoF/hFtju7MX4=
X-Received: by 2002:a05:6402:90e:b0:5c9:6c7:8b56 with SMTP id
 4fb4d7f45d1cf-5c9a5a1c04fmr7440704a12.7.1729259772272; Fri, 18 Oct 2024
 06:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-10-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:56:01 +0200
Message-ID: <CANn89i+5n8=tEP-3nf+=2iXjnCZy0_ivQiqg2PNV5XpO_06y3Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/11] ipv4: Convert devinet_sysctl_forward()
 to per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> devinet_sysctl_forward() touches only a single netns.
>
> Let's use rtnl_trylock() and __in_dev_get_rtnl_net().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

