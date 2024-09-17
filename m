Return-Path: <netdev+bounces-128715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347297B272
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9956BB232BC
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2BC168491;
	Tue, 17 Sep 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b="VYKEUJ3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26F15AD90
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588720; cv=none; b=h7knzeJ0clkQYczkECNndJqCFmzhkHwjBOzs8mjoVVsh/b44Lp+r6VO5cwjUS3xbCl9d5fHK+y8Pn/1ktJgDtcS2S6YAxmEwHAimDDRxMBlFIciVR9tjgohd0RSRjDtNbpoasaj5mkvjIwd6jpLBy4XZwlRz083eCyWSWOneXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588720; c=relaxed/simple;
	bh=tTrCSRxPlmpGC0E+snPGrYoeesYWPiQHWc58HUglYc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7XM4+ZWuQQS7ehZak+9Pv/CwilWPkOt7btYzs3leTQAWT4yusCYmcghUCeeSLGcnTMd0w6vhUCImG860cVDbQDwkY49i2/3NUdyMot/b+zOFzFOaxXflEktqo0aTDRGuozq52W4M+yRI81vGPxYHFGk5nDfZ821QHiHShUvXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us; spf=none smtp.mailfrom=zach.us; dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b=VYKEUJ3S; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zach.us
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ddd138e0d0so19427107b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zach.us; s=google; t=1726588718; x=1727193518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lz4OPRlMZfOS03mipAUNZakHwVWbCa5htpiEjWfs0M=;
        b=VYKEUJ3SK9T0NaG2pB5jQL/qa8mN3ns/mjKmukB+xy2p3KIFJ/er0l/BEhJbc+4Kch
         lLiCr0B9kNypMYO060h+SzIS35E5tsfEwVMO5AKFjfykOz39fFMOrN37qTmgoyeja/Jg
         hLKCg2d2MKv8iZJl/ysNaXOzUur4WQRCMAQOEsXUIV4vn8bI+imXtHiXLfaX9ZLdaD5H
         qbYGpRJeuIXcrISTDWZJ/XmfACjeFqK3k9jDvP7Vqbf6NDM96/dPsLUviHqBGTn18ezs
         KQ1FsQW4gBajtbgh5g1TzOObkRoYSYSMD61w1AW33DFrluGeAmBUilRcJU4xB4R5hjH4
         oQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588718; x=1727193518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Lz4OPRlMZfOS03mipAUNZakHwVWbCa5htpiEjWfs0M=;
        b=dnfbZssi8Z48C0omutBoqZSVFdhHBcYRZw895+vUiNUgukZyTZ3AJoNBeHEZf96Qpa
         PeE5xDk/IG60I1cWsLB7HPeFr9ZZPm6oo5C4MuF0cEz/I1AJHY8aoDG9H3EDTNRuoeZC
         ybrCt3EfBVq+Z+WwozV1lsaxL1zodB7Qwz+klPyHGkSSpYAuxCfT+OslcDTr0uy95HsJ
         BVeFvb3du2/xZcFItrVZpqtCcaWCY3t0OfxKX8ch4xMBHQke/nHLwwglQI//UXahm+ov
         ohYCHZ4KB0Vmp53uRVonr+BNYkJ7owaGVWbArbWm5KDYpuFa2Z+2uBb9aINwJmaCPHQs
         e+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCULffDdFmKN7Q9y4ZxvdoqROFpmoXEn1jWSHDyStfpjxAX9j4vSOqNoix0u0TRtQvT34H1hKh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPNeGPMtFMOsvYrCywyz92f8dwWrYxzA91PlT9eI7Bz8qN9L9
	RSo6eJwKkwHrf2Y/rHrElAsvtT/628Sw2o/t7CnMI3z5VDvjb/djl1T/NDabnxlpn/jnrJWwwqj
	tmG1XvhS/CZqid7k/gBdBxIz2Gg4zzw9iADXodA==
X-Google-Smtp-Source: AGHT+IHo5HMKq66keU1Fyiezt2oQmRRjY/4u5fj56F+H2LwLa6EsNCTt5OusZ7iMIMgorfMYpt773fLCsWYko+bYcsQ=
X-Received: by 2002:a05:690c:94:b0:6dd:d5b7:f33b with SMTP id
 00721157ae682-6ddd5b7f991mr49936807b3.33.1726588717858; Tue, 17 Sep 2024
 08:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
 <66e9419c6c8f9_2561f32947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <66e9419c6c8f9_2561f32947d@willemb.c.googlers.com.notmuch>
From: Zach Walton <me@zach.us>
Date: Tue, 17 Sep 2024 08:58:26 -0700
Message-ID: <CABQG4PF+xeeAckkop5oas0zjE4aKM1Y=fSLRAHt5WiZOhJMGtA@mail.gmail.com>
Subject: Re: Allow ioctl TUNSETIFF without CAP_NET_ADMIN via seccomp?
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I think this might have been a misunderstanding on my part;
seccomp is meant to restrict, not expand, permissions. I spent some
time looking for prior art and see nothing like it.

I will look into alternatives like AppArmor/eBPF. Appreciate the response.

On Tue, Sep 17, 2024 at 1:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Zach Walton wrote:
> > I was debugging a seccomp profile that attempts to allow TUNSETIFF in
> > a container, relevant bits:
> >
> > ...
> >       {
> >             "names":[
> >                   "ioctl"
> >             ],
> >             "action":"SCMP_ACT_ALLOW",
> >             "args":[
> >                   {
> >                         "index":1,
> >                         "value":1074025674,
> >                         "op":"SCMP_CMP_EQ"
> >                   },
> >                   {
> >                         "index":1,
> >                         "value":2147767498,
> >                         "op":"SCMP_CMP_EQ"
> >                   }
> >             ]
> >       },
> > ...
> >
> > ...but I get:
> >
> > Tuntap IOCTL TUNSETIFF failed [0], errno operation not permitted
> >
> > Looking at the code, it seems that there's an explicit check for
> > CAP_NET_ADMIN, which I'd prefer not to grant the container because the
> > permissions are excessive (yes, I can lock it down with seccomp but
> > still...): https://github.com/torvalds/linux/blob/3352633ce6b221d64bf40=
644d412d9670e7d56e3/drivers/net/tun.c#L2758-L2759
> >
> > Is it possible to update this check to allow TUNSETIFF operations if a
> > seccomp profile allowing it is in place? (I am not a kernel developer
> > and it's unlikely I could safely contribute this)
>
> In this case seccomp would not restrict capabilities, but actually
> expand them, by bypassing the standard CAP_NET_ADMIN requirement.
>
> That sounds like it might complicate reasoning about seccomp.
>
> Is there prior art, where kernel restrictions are actually relaxed
> when relying on a privileged process allow a privileged operation
> through a seccomp policy?
>

