Return-Path: <netdev+bounces-126803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E773D972932
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C1E2876C0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B3175D4F;
	Tue, 10 Sep 2024 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzAx5J9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8E172BA8
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948042; cv=none; b=AWqP/fe4hoCOFEGzn9urmwLTqBBoWd2WVlMeusq/UQZdT1igFzp7QJ03/xVLpIMSjxYSjY6RI/1CnAnY5mhtDHxG51aaHdOTo+LqBn2MGXb9JIaWdMdUUdLm5LZ5vErVS5bOx+3fv9UGWG6JSH+o5Ledx12SUmhSL2zDyf1Jv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948042; c=relaxed/simple;
	bh=EFiwHJNSpOkCVGiETs6qdxo9BYVO4HaOqN/EuI8xr6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDyC9MH7RUkHek/57Np85CRoZHS8rKHGWnnEpNCkjQK//gFzbv4B1V0Q+vZAcrlFc6HukFIlpRxWeFqggE6b9BXZm7i9YAR5zM36/m4VyENfV5M4ErVN2EiXiS2eBB0Pc2RDPnj5dngq9mnMgBVxQpKKIc89yfFYOSDJZy9FsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzAx5J9i; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53659867cbdso6208213e87.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725948037; x=1726552837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFiwHJNSpOkCVGiETs6qdxo9BYVO4HaOqN/EuI8xr6Q=;
        b=FzAx5J9ibRHQh76AYRjJUyeLdFWcHx3ZNxe4HqMitzIjvi0Ll3wk2rRfrE/hOWo4xz
         PagLprEb1PnmafH+VsmTsNemiSDh7vCHbMMo4plL0bUg3BWbdgFAH/zU3iPDkHta2++x
         PF/moXy7EvN0gpG9d7bnQGJJE0yosgyF8O3eCU1dCT2dFeA4XCQ/kNELW83nNGqUVrA+
         uOcRcqYc5TlHGOvRlGU4fU/uHvOhO/KxNiSn+p+5zmgGuKHzLTFuLqdvJcYFtYIK55B3
         x72k5dbEXlnBOt5a2KzTfK3U3hXrG6VYTQAyxxf+30Awvsw9Q8Mfi/MH2KnzeApq+d1e
         WFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948037; x=1726552837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFiwHJNSpOkCVGiETs6qdxo9BYVO4HaOqN/EuI8xr6Q=;
        b=WamuvFvoEC0EA+Rs0rSaaggBs1DUdARUs6yLNuXyV1X5RvbzNjtgPiB4NymUHOZg9j
         cFoGebPr/i2WSq4oT3JU3Z3ioQd5nVMbfj4UESJJDIcH2yMij3syVXDhk/NWZoKVljqc
         eVPabcnYn7VwuTaK5ZQQM+z1r7EUfKYPigQeoL7zY9Ekfb2s0mJvHqj9QMespGULWxRJ
         Yn8Gaom9qiCgt/h3kQ2yPMFrTuYO6459HyRQrunpjtcMPHw4hFBc1N5z1h5ZRCAEoirl
         rD6aWGDCIapb1iQs+nqiicEgeFQW8wopBDxRxN1I1+WT37J/bpMjeCjZt/MZ4EhIbmRS
         6ayw==
X-Forwarded-Encrypted: i=1; AJvYcCVhH0ASDbYvu1DiTou6/ScZVm6pjiPx5I4GvQnomU2QNf4688qv15tH9OqN1ntF99WF2MymViw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywytk3HEFRgJrNcxJ7GOR52ZuutdHOgX98R6+OWZTuBGErTNVmi
	6UtTMJkac0qpgkR6e7YIV2+1hC9VGy8/c8egSWQ/i6ARMQ2Qhy1OYsV5a2bvqq7b53TdH+tt6Oi
	vwjlCYDukWNweFmi3oL2RHZgvptw2z4ow9kLZ
X-Google-Smtp-Source: AGHT+IGKBHtciuLyS9iz/VM0PUIGYeyeDxcKP22ePmimkHEtVYiNQTMQGBCDu9UVctX9gF8Is7XAfEenW8FH4jf84Z0=
X-Received: by 2002:a05:6512:3d17:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-53658818bf9mr9481551e87.59.1725948036354; Mon, 09 Sep 2024
 23:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
 <03C87C05-301E-4C34-82FF-6517316A11C2@gmail.com>
In-Reply-To: <03C87C05-301E-4C34-82FF-6517316A11C2@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 08:00:23 +0200
Message-ID: <CANn89iJhX4ny3Se1mz74M5NbiG9NTSbUagTYG0chk-33F_HNvA@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:23=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
>
> > Eric Dumazet <edumazet@google.com> wrote:
> > =EF=BB=BFOn Mon, Sep 9, 2024 at 8:48=E2=80=AFPM Jeongjun Park <aha31051=
0@gmail.com> wrote:
> >>
> >> rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and do =
not
> >> verify rt->dst and use it, which will result in NULL pointer dereferen=
ce.
> >>
> >> Therefore, to prevent this, we need to add a check for rt->dst.
> >>
> >> Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in fib=
")
> >> Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entries.=
")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >
> > As far as I can tell, your patch is a NOP, and these Fixes: tags seem
> > random to me.
>
> I somewhat agree with the opinion that the fixes tag is random.
> However, I think it is absolutely necessary to add a check for
> &rt->dst , because the existence of rt does not guarantee that
> &rt->dst will not be NULL.

dst is the first field of 'struct rtable'.

Always has been.

Unless your compiler is buggy, (void *)rt =3D=3D (void *)&rt->dst

