Return-Path: <netdev+bounces-161439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3CA21709
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 05:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5053A15B1
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 04:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8418C903;
	Wed, 29 Jan 2025 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="A15/Dq5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92821865EE
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738125096; cv=none; b=o5HB3pHXnNgig+/JO3Xr3iLDKU6IZGuiMbYO9mObC3dVZDAdc/QpehPCCGvqkcGH3FjfncsNbwPdEYSo2M07lVkjFADDNAT1dEfOVFdNIepHRW848W2X9X5nJ+3PZ0fBm0VFnBJENe9to8i82O3Daebl3RdYRYK5lkVEEKq9O0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738125096; c=relaxed/simple;
	bh=808ZSvqrp6Jw2j2yHfLGfGLkh4ZMtd/+Cno4IekELSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/jqcDwVU0xPuTKFUWe1JdK2WXmBPk7NZZEardPC4740XR7asjz3dcjkACKcRyAPqMjgfm6WtIf64QDKZCz5td0LV1jxK/pXhKmSH2IyycIUIHbnzdidFdv/3nyE4BXKoxd4YBaYAcc3JrY71MsRINmaTzGIDrAjEKvVo3uxzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=A15/Dq5I; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso9156314a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 20:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738125093; x=1738729893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBO9dXCuMkurFX9lxY8xUIlOlPnO5yILDAytp6+TmDI=;
        b=A15/Dq5ISv6qNcMNtQo6IdH5ymgQsJtm2inFFTGC2chkyaDwOx2OVchjd5E1+cBIHz
         d1Kv4+5V6Ff165p22hMMgRcspdL8lflK1uwpP3zkiqMkLKR0D5l/42PvkhsWq2MLIp1Z
         4W5A1FO4+z7hZTYqbKu76oKDo24XKPraZxF5hnOHSjWWGx6SAr+8qbc4ui1J7flIVz6e
         Idvi1XVVjKtmDhuEweyVLuVSrYlVOQFXik2G/VhstFdOUcS7Pa6Vw3w6qNQb2BnlEDQn
         M2yPvvmFRslGzrKkvlCj9TEEl6S3k0BWakfW3f/NgPsSd+h0tKR1ZaadBGLpHZIiSL7I
         KuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738125093; x=1738729893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBO9dXCuMkurFX9lxY8xUIlOlPnO5yILDAytp6+TmDI=;
        b=O79857OdqFJXfl1VDZEgnqFWRpOhnuxQsdWcghhtRTi7LENt6DTXaTMvHEg9de3xhp
         WeRSx712+EIHBx8mjmrBMu1V3HLvwmlv2wVgxs3CVch/f4vZ56/7twJmoGIixdTYO0p9
         p/sYedkqNW5qGFaxqppkUK9TDhOYX1vWCa2lxIpwdDQg/HQJ8e6K16rrAFt24q9IncTx
         kKGxE3hcz7zX1/xSFjNj/M+8cIphpkcpfZTgfh17+9EUrAYaw17s0qhpt19GAWYFq46Q
         pMkTS9UJBE49pLnuOEAeXvHpSIL/YAAvAhjIbnqR4N47lVe4euwufwJB88HbCpSn12BK
         NLbw==
X-Gm-Message-State: AOJu0YwxZv8DNyZJYJ+WScna9nFWMq44fBWag24cxGRZyOS5Cj1Z7XRx
	+OvrbAADiJRQUyeD4u+hGFb065x8+iwtD1Ec7zkPkdO6bAAyBB/wBq355/GBj3ZpB4WTJ0C7UqI
	SJRBKUJ2MLb+Z/ZD3ctCyhAzATSUfVFSYsn40uA==
X-Gm-Gg: ASbGncu+CIt4hCOlQmM+7ltpVf+8PhYTWi19rp9S6pIGI0bfMA6DbwlIMgJAfzNmCLN
	I/ZBrOsnqw2CWefYsa1YG173Ad24Se7Th2JRjWxD0HWyy/iuIjv29coVbXJUjWF8rQx0U5P6kxb
	/oEqERPonh7w8=
X-Google-Smtp-Source: AGHT+IH1M08WO5Qx9Ys5wiCpk2W2FW/E9jpAyqZ8NwwuVAWi7zCv6NhLJzzXsfmmPElRMVxILXxlKaLqHmCQuLcAg3o=
X-Received: by 2002:a05:6402:13ca:b0:5db:e7eb:1b4c with SMTP id
 4fb4d7f45d1cf-5dc5efbf41amr3735244a12.10.1738125093185; Tue, 28 Jan 2025
 20:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5cgWh/6bRQm9vVU@debian.debian> <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
 <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com> <6798ed91e94a9_987d9294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <6798ed91e94a9_987d9294c2@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 28 Jan 2025 22:31:22 -0600
X-Gm-Features: AWEUYZkFF04hIq6CQys-BAU9SzPyBvvzYRnsiHHxwADQ-M2LEFAF1toT_s31iWM
Message-ID: <CAO3-PboS3JB1GhhbmoJc2-h5zvHe-iNsk9Hkg-_-eNATq99D1Q@mail.gmail.com>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Josh Hunt <johunt@akamai.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > Hi Willem,
> >
> > Thanks for getting back to me.
> >
> > On Mon, Jan 27, 2025 at 8:33=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Yan Zhai wrote:
> > > > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided G=
SO
> > > > for small packets. But the kernel currently dismisses GSO requests =
only
> > > > after checking MTU on gso_size. This means any packets, regardless =
of
> > > > their payload sizes, would be dropped when MTU is smaller than requ=
ested
> > > > gso_size.
> > >
> > > Is this a realistic concern? How did you encounter this in practice.
> > >
> > > It *is* a misconfiguration to configure a gso_size larger than MTU.
> > >
> > > > Meanwhile, EINVAL would be returned in this case, making it
> > > > very misleading to debug.
> > >
> > > Misleading is subjective. I'm not sure what is misleading here. From
> > > my above comment, I believe this is correctly EINVAL.
> > >
> > > That said, if this impacts a real workload we could reconsider
> > > relaxing the check. I.e., allowing through packets even when an
> > > application has clearly misconfigured UDP_SEGMENT.
> > >
> > We did encounter a painful reliability issue in production last month.
> >
> > To simplify the scenario, we had these symptoms when the issue occurred=
:
> > 1. QUIC connections to host A started to fail, and cannot establish new=
 ones
> > 2. User space Wireguard to the exact same host worked 100% fine
> >
> > This happened rarely, like one or twice a day, lasting for a few
> > minutes usually, but it was quite visible since it is an office
> > network.
> >
> > Initially this prompted something wrong at the protocol layer. But
> > after multiple rounds of digging, we finally figured the root cause
> > was:
> > 3. Something sometimes pings host B, which shares the same IP with
> > host A but different ports (thanks to limited IPv4 space), and its
> > PMTU was reduced to 1280 occasionally. This unexpectedly affected all
> > traffic to that IP including traffic toward host A. Our QUIC client
> > set gso_size to 1350, and that's why it got hit.
> >
> > I agree that configurations do matter a lot here. Given how broken the
> > PMTU was for the Internet, we might just turn off pmtudisc option on
> > our end to avoid this failure path. But for those who hasn't yet, this
> > could still be confusing if it ever happens, because nothing seems to
> > point to PMTU in the first place:
> > * small packets also get dropped
> > * error code was EINVAL from sendmsg
> >
> > That said, I probably should have used PMTU in my commit message to be
> > more clear for our problem. But meanwhile I am also concerned about
> > newly added tunnels to trigger the same issue, even if it has a static
> > device MTU. My proposal should make the error reason more clear:
> > EMSGSIZE itself is a direct signal pointing to MTU/PMTU. Larger
> > packets getting dropped would have a similar effect.
>
> Thanks for that context. Makes sense that this is a real issue.
>
> One issue is that with segmentation, the initial mtu checks are
> skipped, so they have to be enforced later. In __ip_append_data:
>
>     mtu =3D cork->gso_size ? IP_MAX_MTU : cork->fragsize;
>
You are right, if packet sizes are between (PMTU, gso_size), then they
should still be dropped. But instead of checking explicitly in
udp_send_skb, maybe we can leave them to be dropped in
ip_finish_output? This way there is no need to add an extra branch for
non GSO code paths. PMTU shrinking should be rare, so the overhead
should be minimal.

> Also, might this make the debugging actually harder, as the
> error condition is now triggered intermittently.
Yes sendmsg may only return errors for a portion of packets now under
the same situation. But IMHO it's not trading debugging for
reliability. Consistent error is good news for engineers to reproduce
locally, but in production I find people (SREs, solution and
escalation engineers) rely on pcaps and errno a lot. The pattern in
pcaps (lack of large packets of certain sizes, since they are dropped
before dev_queue_xmit), and exact error reasons like EMSGSIZE are both
good indicators for root causes. EINVAL is more generic on the other
hand. For example, I remembered we had another issue on UDP sendmsg,
which also returned a bunch of EINVAL. But that was due to some
attacker tricking us to reply with source port 0.

thanks
Yan

