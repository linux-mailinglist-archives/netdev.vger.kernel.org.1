Return-Path: <netdev+bounces-65902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66583C462
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444531F21214
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80027633F0;
	Thu, 25 Jan 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOFpI5Tr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284F63130
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191864; cv=none; b=gYt2ZzOfyTwXhrLKD5I4Vf5Q+XwmEDwwq/Ce+PU5yIqh72z6X+RgethdzUc8XpxHaYq2CYUH5nWAKnMcUftoqvnSuykehSJNKpVm00PtW91dtL7WBN1bIa5hwbkTy5PrOyw1EqT4BGKZYVucxGMg8KwqlXV4r678uxa/b1X0saY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191864; c=relaxed/simple;
	bh=YGtqFeoWDvTAXCZ/E3J7VIws2uIcaJskBgsECuxvlmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuGB8JYvyb6T1cMNq0YCxCL7HcEUVctdKCq99RO5D379vrkjYhMzftdaCIbt9i9HkCvxqFlA9QBuydYUh1XJackPBiVWj178X0gU38zsMtfipOoWR49LG7BTq7UerboXrRkEXMx1uqzE/Bw1OfQoXY/6KjO1bxMtjW4Tm+28gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOFpI5Tr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so7983a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706191861; x=1706796661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0paZxjndXbxA3IXAZFODvQOsfkkH6eb2L9bZuPwRqI=;
        b=nOFpI5Trv+wNgjdwN5k4wtoIEHewZ9wrd1VF/9p4lSjcCRPrYai2ARY7be7WtOAo/C
         ghJWzfBSMhukJWyPYAliyoZ9P+B5x+WmMbYpjaZaJZSnDPNm5sHal3en7zqac0IKB0hB
         ia3mPDZ+dEbg0u3tTQIDaoM1A9VWlpac2mrtfrZ9Dc6mYZr5D+EDLYmdmzOM0TfMNitq
         gqjiLmNOPC9WeEDLRgvOd+3xsZuIngXEgoz8msyKTWl2sbzOgeDjE3xYgLY5b+ifr9SO
         nuoXwM1jzYIMWcODYe4Tqpz2k5hQIZbog3JxJsipg7AnBP2IqY48MTYXWeQC2I0Nf8WV
         UHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191861; x=1706796661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0paZxjndXbxA3IXAZFODvQOsfkkH6eb2L9bZuPwRqI=;
        b=MIG/cd3alRmyW2UR5Y04yZssvG1qd6BL4rYfzjsVvIjdYsSN7oXa7okfs3MKlape/B
         t8VedeCA8UqO/ZOWqJPdM2xFLnq/8FBed0JLb+l8ne/Posf1CTKZx6uAhiga+5pvuyWw
         21pujM+PAoSQVbPTlJRkN6dgMNM3fkC0oEYux6007NsQj97HXlMl/MG+thbqRVvMrFWM
         Hn+C7uijps5AuWcDXywnidHmcJ7PzsRg4SJEfwvsOwd+eDszp3Ll/882S803KRxP0bL1
         U5SMR+c6fDwlo7chv5HlsFNyODb0bBs+GkeTk1wOj3qCMPF//ZVcUkhC6FOnkmwc/Uvd
         6xng==
X-Gm-Message-State: AOJu0YyuURz7Npl2Dr+ePW28U7rjRqHoNXV3JR/4a68VOv+gTwzPbfyx
	eHK/pQY1GdhtRYXc97smLoT8ukAJiSs9kRt5vtssFR38GIrNeCYiMSVQddCcT3HN+RO6HDrzalB
	ZmcJD0fCsKVf5tbFLOEL1puRMcze70SnfG82f
X-Google-Smtp-Source: AGHT+IFxk2A9+v1kqGAENOjM4HQcFUEnHOvthj/NtkVNGrk2tJ4/S05mEuv6M44YLmK/dqB8uKfOkT/dTmyrJ6mbDrI=
X-Received: by 2002:a05:6402:1bc9:b0:55c:8eda:6e19 with SMTP id
 ch9-20020a0564021bc900b0055c8eda6e19mr204055edb.2.1706191860534; Thu, 25 Jan
 2024 06:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
 <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com> <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
In-Reply-To: <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 15:10:46 +0100
Message-ID: <CANn89iK_i+7RzgeaGQPUieU3c0ME27QeJU9UH9j-ii2TeBoEAA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej enczykowski <maze@google.com>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:38=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-01-25 at 09:48 +0100, Eric Dumazet wrote:
> > On Thu, Jan 25, 2024 at 9:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > the udpgro_fraglist self-test uses the BPF classifiers, but the
> > > current net self-test configuration does not include it, causing
> > > CI failures:
> > >
> > >  # selftests: net: udpgro_frglist.sh
> > >  # ipv6
> > >  # tcp - over veth touching data
> > >  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
> > >  # Error: TC classifier not found.
> > >  # We have an error talking to the kernel
> > >  # Error: TC classifier not found.
> > >  # We have an error talking to the kernel
> > >
> > > Add the missing knob.
> > >
> > > Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-=
tests")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >
> > FYI, while looking at the gro test, I found that using strace was
> > making it failing as well.
>
> It looks like the gro.sh (large) tests send the to-be-aggregate
> segments individually and relay on the gro flush timeout being large
> enough to fit all the relevant write operations. I suspect/hope
> something alike:
>
> ---
> diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/se=
lftests/net/setup_veth.sh
> index a9a1759e035c..1f78a87f6f37 100644
> --- a/tools/testing/selftests/net/setup_veth.sh
> +++ b/tools/testing/selftests/net/setup_veth.sh
> @@ -11,7 +11,7 @@ setup_veth_ns() {
>         local -r ns_mac=3D"$4"
>
>         [[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
> -       echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
> +       echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
>         ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
>         ip -netns "${ns_name}" link set dev "${ns_dev}" up
> ---
> should solve the sporadic issues.

I think you are right.

I tried multiple values, and found 600,000 was not enough in some cases.

With 1,000,000, I was able to run the test (with the strace overhead)
100 times without a single failure.





>
> > Not sure about this one...
>
> All the udpgro* test should write a single UDP GSO packet and let the
> veth segmenting it, hopefully slowing down either ends should not
> impact them - but I did not check yet!
>
> Perhaps even the gro.sh tests could be modified alike?
>
> Cheers,
>
> Paolo
>

