Return-Path: <netdev+bounces-212638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A9B218CC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2390428003
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87265229B1F;
	Mon, 11 Aug 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l30znbNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76742264CE
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953092; cv=none; b=D7OUyjzAM5aDhumd8i5HzcDUtw012S17cnL+u/4Cm5JbQ/xiE5/06+Joj+ebtDKDXjSQ8sGJsqDzP7KkNY7M7md/qHttXuCPrFZ4gcqatXyt8RCKpmQItseS6639D1BuwZHAFCS30fv8NSGn4rlisIMZ6jMq0FqdZOMHjgG3ltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953092; c=relaxed/simple;
	bh=PVz4vozlHp9y1RUDr0UzibkJH7GSlun6qncNd3pvSP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlHy6gkRsY9+gfnmkRY68dCiLImkSp7TVrrV1Wp+pwGmfrh7zgNR9cj0+cRrR69envGQScqazsOKzo/DLCAftEVD/GwD6mUXhBbEq1LfL6porDIKM8YZj0dCmQZMPWwBWQN4wW2PmUfg5++Io2SJdhqzBRQcvkfd9g0Rf55ZObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l30znbNG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e55b170787so1866815ab.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754953090; x=1755557890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVz4vozlHp9y1RUDr0UzibkJH7GSlun6qncNd3pvSP4=;
        b=l30znbNGvf29GfW0gkaEXP5Yrcu3Aj/USp9X3idWJJeewAeUqu6LJn0G3Hh0XwYBZc
         0Mvc70VokpAQh67Ph+F8/Xb1JVu8HOu/f1418TTk0fVBjGtdgknoRIupMRV9MkWeoELs
         gGphEXSNUCBVurIN1THpDoPAhWRHN5J5xjXZQROS85Mq8wQbnYfCJ2VDuL/dGahwVVJ5
         zdMqMe61VdDR4in9HrLqfJLPlFfFqTcCzs9UW6cj/hWfFnYzwPXI+AFdDHP7m8+IJIDg
         zy6WJX5OAETiCR7PZhvAg1eX6WWt4E/eTxEkYM3HVUIF2IoYBQ9Ur6EZ9dyhnADa50dL
         rOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953090; x=1755557890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVz4vozlHp9y1RUDr0UzibkJH7GSlun6qncNd3pvSP4=;
        b=MwyKX6Qc9qTQndK8LdX/vrnuZfN4BN+SijmPx5LUTZeMRi5yOUFlD8AJ0hOYwtXTIr
         9y6H21NTPa5cFQXBxquk5TdYxIZAQclgkFI+2diFu/8G6GVk3zBPkWg91XKlkb1xptQP
         NHyPYd34+yZdagkAXx0ySpAqwAo31b+TGU4pvWrOWwwND9XHV0VvPwLXP+/qpFugpyGa
         /+Vfg3uKYh1hAunpm6C2wFLbbpW1nBteVblzLDcWBLvu4G782elRVWpzbCePX9gSvr1a
         CKUSt1qQKir89MAGoM9l6lLhIpHHAxquLNqV9rmWrfVTzi12GATuIgIJbA0k7bAuuq1z
         jq/A==
X-Forwarded-Encrypted: i=1; AJvYcCU8ulVHpIcNriA1Gv/zoKo9GyghSdWgRtGwmpxpL8ehdCaCTXvMnBtQcYxHxPgFwLyiFn7LdZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVtn7RMh1VtgSx15DlcpfeMPFiC5B1TI8jMfu7VEagjbK4gf+
	rwIXeArMYZYHnRza9skRGXdqhn6kxn+x4ggK0xHxLg1mB/Qeym5L7f3lWHAXqEPQGZWtNDDstb2
	P7pUMAqbBDInZqGI4bnaXYYxlHWE/yDM=
X-Gm-Gg: ASbGncuufwNoZ636d/mfqSPklVSHGk7lGRj7kzYD18PQCcqj0cr3egaWPNo71jQFKod
	1GvT3pV1QAZa5sWnXxN3lVMQrIluE6OrpfDcn1pBMN+zR6IZtbJweN63aEEJfHKHQPix6pSVSpO
	2otw4OmJm2vqtEHNbOEitK+CzHm2GxIgiVn0Q5hJzWSrIqkIUCTX8LK/6x3gQDJmnR31gu3Z+vM
	i2yJQ==
X-Google-Smtp-Source: AGHT+IHvOitDXKIs4WhQwxzhDVxXHbsLiBvTJ/NLngi6Pf7bissC+I+Jd34xd5hW6IYpkSwi6u/ca/v8Yk0jjErbqSg=
X-Received: by 2002:a05:6e02:380f:b0:3e5:5952:80b9 with SMTP id
 e9e14a558f8ab-3e55acbab77mr20629895ab.11.1754953089909; Mon, 11 Aug 2025
 15:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <CAL+tcoAAq9ccjUybzxoYbVG6i3Ev1C098aGKWvAvKMUeFyG3Tw@mail.gmail.com> <14d36e48-251d-4dbf-aafe-57259003e064@intel.com>
In-Reply-To: <14d36e48-251d-4dbf-aafe-57259003e064@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 12 Aug 2025 06:57:32 +0800
X-Gm-Features: Ac12FXwQQL3r3LVvQt-AVF5C_Z3s4vocuCAGT8fKu417DwnUgPHzE98nCRDIaVY
Message-ID: <CAL+tcoDNoZH_rnC9th8od-qu2QE8nWHgiWEATA8SVs_jc9rJnA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: przemyslaw.kitszel@intel.com, larysa.zaremba@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:38=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
>
>
> On 8/10/2025 5:22 AM, Jason Xing wrote:
> > On Sat, Jul 26, 2025 at 3:04=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> From: Jason Xing <kernelxing@tencent.com>
> >>
> >> Resolve the budget negative overflow which leads to returning true in
> >> ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
> >>
> >> Before this patch, when the budget is decreased to zero and finishes
> >> sending the last allowed desc in ixgbe_xmit_zc, it will always turn ba=
ck
> >> and enter into the while() statement to see if it should keep processi=
ng
> >> packets, but in the meantime it unexpectedly decreases the value again=
 to
> >> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc ret=
urns
> >> true, showing 'we complete cleaning the budget'. That also means
> >> 'clean_complete =3D true' in ixgbe_poll.
> >>
> >> The true theory behind this is if that budget number of descs are cons=
umed,
> >> it implies that we might have more descs to be done. So we should retu=
rn
> >> false in ixgbe_xmit_zc to tell napi poll to find another chance to sta=
rt
> >> polling to handle the rest of descs. On the contrary, returning true h=
ere
> >> means job done and we know we finish all the possible descs this time =
and
> >> we don't intend to start a new napi poll.
> >>
> >> It is apparently against our expectations. Please also see how
> >> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statemen=
t
> >> to make sure the budget can be decreased to zero at most and the negat=
ive
> >> overflow never happens.
> >>
> >> The patch adds 'likely' because we rarely would not hit the loop codit=
ion
> >> since the standard budget is 256.
> >>
> >> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> >> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> >
> > Hi Tony,
> >
> > Any update here? Thanks! I'm asking because I'm ready to send an afxdp
> > patch series based on the patch :)
>
> Hi Jason,
>
> I have this slated to be part of my next net series. I do already have
> this patch applied/staged on the Intel tree [1] (dev-queue branch). You
> can base it on that and send the changes now; I'll ensure that this
> patch is merged before sending the other series.
>
> Thanks,
> Tony
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/

Great, thanks for the pointer!

Thanks,
Jason

