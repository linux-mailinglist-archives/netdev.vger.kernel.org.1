Return-Path: <netdev+bounces-247863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E96CFFA33
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD0033006982
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B7342CBB;
	Wed,  7 Jan 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbYROVYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444672A1BB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811236; cv=none; b=VTyau6r/c0RIZR6jdKNtJPFSkjxs5PG4wVWI0Da0IYPN3f3D4JY3HnJXiiHTb297UJodffwQuawvsQ8KcvahC+wSteuF1/KzsIg4TmtSSElUA1x0F1UxJDfuHZhlI/kJ26zChUxkjCUmGSV14X57I6Wwp1OMWtlU8JRqX21+SXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811236; c=relaxed/simple;
	bh=ozDTbTw2biD1T46c9WzcwMOJF0YeCBjZW5lAEW7frQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjF9xjbxyJvU1oK3QoC/F3ON/Zy9iQYqbuSvj53HFzSsWgG5vJRrTpG8WQQUm0CjYHJ6Ebeveb5yERPr0TcjKfGvbBpOo2cJPdSqTafxxiQqr6CeMrhkyP6pYPSNgVwbOG2iQXfzclK8hU0Hv+Bv9PsBZ8dcmiQQFYiuVyZzK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbYROVYq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fcb465733so26889217b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767811223; x=1768416023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtsftQdWvc92MJo/GOY9PADpHyfnOF52TK2njaD2TIA=;
        b=IbYROVYqSBNuMMVd4jZFF94nu4zQ+ANljP8v4FGEcG79lhW0+suRrUiHXMO7CmsNPX
         W2YU0k3tPNEk1e0XZ4thvvpLX8CInAh/v76/Rsq877JLus7zUMYsY6k/94MHb7GnyGIm
         NRMkW37J8ttFn4nKjioRL1Bs2HXUfaLp+PVXeiPYoGRbXdqwfpcWGtGscktCnz75Ie6N
         X109qraA7CU0w6jnulJ1oooGkP8rVPCaAmZvPRLGq757RYcze3pK1hVhsm4UtpSeXypg
         0TRuFrQmCIbMmFDQiTfZsqiabvKBG1tDFQVRWoNhMUPKVhgRZI6JxCx19DKGT8C+hZx4
         q8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767811223; x=1768416023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtsftQdWvc92MJo/GOY9PADpHyfnOF52TK2njaD2TIA=;
        b=k3xRoiHyyj3kew+0YKGhDDT2ux23mp4Ujb3TQsEKrA+kjlAaKL6vebhTPXJ3cQAAaO
         /wzk4JSPs9RHhWFfTVQjslhk4H0Z4FRcMpXoJt981IcBix4ZGVHB184CgAgwBgU1p5IG
         Mtiq9ZcyiMUYdsnwdu6W3+6CI+DmVxui555l3t5UGn8KZjE3qI+c0gWxbZ03KOdIEDE4
         vUeBD/qUAg8OT9pIZABQbfoivGE5gwDGE8/zZymcMdqQRsN5F5/OWurO1QakVDtu4UL+
         uxuNSWV7WAd2l21+N1zHenuRc1iiGMmiOD1AZr6EjPpR/LmGHtXDgmeEe67CNDfHr6SX
         Q0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUso4oPV4ZdyzeHcYwFTH68Fa3ia0ueuqDeb7mU/ukbQR9IChPQ5axcwX4NqgkL9SySAPm2Fmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOviyHNnmMtgPCnkZCoyQI4K/d1aT5ZzEP54mwMM1VBqtmMJhc
	T6LhtnA0lTXnA93qXDBbekwYVlSitLY0RR5GMD1FBuPkxP9sDZ6z2Un5TzdEpptPqd88knstn4R
	BdRULIParnWQUuPEU8FILEyGXDVQicl9pWBQJ302R
X-Gm-Gg: AY/fxX6BVVU8BVdq2HJr4izGAbYNdNsTbw/d5tMbEJPtDecthFugSNhMKYKG6TqQ4tI
	Of+kvg2VVXO+BJQ/nDi5eUgcl0UfOChl0xJ/qTQz0GhtSm8Jaqm09qSRTAwUiQ/F/myrnDP/2eM
	ZvL7AUCvCgJc0SHW0RB22wrKp5D6b7CT6irkpfQnOyLjQDR4tDKK/59vZAAi9W30tkVIuW9vyLE
	nDti/P7pQXPNpQae3orT/VG7tZWFCTBnRGelqZBham45S+nCVa6+QcQ5FOFtCxDr1cKDIpBlh5K
	1hoVPPmZ2Gv3KpAcZhAjNDnhAw==
X-Google-Smtp-Source: AGHT+IFjytPWCRjgBg2Wc9JejGPrceLN1OzIIgu8DsxNWG6LoiDOWn9N99G3/90yQ8AkNTL5f6o/QaFr3PxKunb2Fr8=
X-Received: by 2002:a05:690e:14c9:b0:63e:3b29:f1e1 with SMTP id
 956f58d0204a3-64716c04ccfmr2869235d50.36.1767811222897; Wed, 07 Jan 2026
 10:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com> <9cee39b6-edf5-4db2-8f0c-4550fa84b5b7@intel.com>
In-Reply-To: <9cee39b6-edf5-4db2-8f0c-4550fa84b5b7@intel.com>
From: Li Li <boolli@google.com>
Date: Wed, 7 Jan 2026 10:40:10 -0800
X-Gm-Features: AQt7F2r6bV6dIcmijk5Dw_7PVdGEoCOZKZRo7usguyrZU391ci6mo2WlJyu5eYk
Message-ID: <CAODvEq5L9dBHAfmhATtXmuUde7My1wCobMN1JRvACDKPwa3XRQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/5] idpf: skip getting/setting ring
 params if vport is NULL during HW reset
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please reject this patch series given the underlying issue is fixed in
an earlier patch
series already, thanks.

On Wed, Jan 7, 2026 at 9:41=E2=80=AFAM Tantilov, Emil S
<emil.s.tantilov@intel.com> wrote:
>
>
>
> On 1/6/2026 5:04 PM, Li Li via Intel-wired-lan wrote:
> > When an idpf HW reset is triggered, it clears the vport but does
> > not clear the netdev held by vport:
> >
> >      // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
> >      // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
> >      // idpf_decfg_netdev() doesn't get called.
> >      if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
> >          idpf_decfg_netdev(vport);
> >      // idpf_decfg_netdev() would clear netdev but it isn't called:
> >      unregister_netdev(vport->netdev);
> >      free_netdev(vport->netdev);
> >      vport->netdev =3D NULL;
> >      // Later in idpf_init_hard_reset(), the vport is cleared:
> >      kfree(adapter->vports);
> >      adapter->vports =3D NULL;
> >
> > During an idpf HW reset, when "ethtool -g/-G" is called on the netdev,
> > the vport associated with the netdev is NULL, and so a kernel panic
> > would happen:
> >
> > [  513.185327] BUG: kernel NULL pointer dereference, address: 000000000=
0000038
> > ...
> > [  513.232756] RIP: 0010:idpf_get_ringparam+0x45/0x80
> >
> > This can be reproduced reliably by injecting a TX timeout to cause
> > an idpf HW reset, and injecting a virtchnl error to cause the HW
> > reset to fail and retry, while calling "ethtool -g/-G" on the netdev
> > at the same time.
>
> I have posted series that resolves these issues in the reset path by
> reshuffling the flow a bit and adding netif_device_detach/attach to
> make sure the netdevs are better protected in the middle of a reset:
> https://lore.kernel.org/intel-wired-lan/20251121001218.4565-1-emil.s.tant=
ilov@intel.com/
>
> If you are still seeing issues with the above applied, let me know and I
> can take a look.

Thanks Emil! Yes I performed the experiment at a commit past your
patch series above, and it
does look like the kernel panic does appear anymore. Now performing
ethtool commands during
HW resets would result in "netlink error: No such device", which is
expected because we are detaching
the netdev at the start of the HW reset.

Please reject this patch series, thanks!

>
> >
> > With this patch applied, we see the following error but no kernel
> > panics anymore:
> >
> > [  476.323630] idpf 0000:05:00.0 eth1: failed to get ring params due to=
 no vport in netdev
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/n=
et/ethernet/intel/idpf/idpf_ethtool.c
> > index d5711be0b8e69..6a4b630b786c2 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > @@ -639,6 +638,10 @@ static void idpf_get_ringparam(struct net_device *=
netdev,
> >
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> > +     if (!vport) {
>
> We used to have these all over the place, but the code was changed to
> rely on idpf_vport_ctrl_lock() for the protection of the vport state.
> Still some issues remain with the error paths (hence the series above),
> but in general we don't want to resort to vport NULL checks and rather
> fix the reset flows to rely on cleaner logic and locks.
>
> Thanks,
> Emil
>
> > +             netdev_err(netdev, "failed to get ring params due to no v=
port in netdev\n");
> > +             goto unlock;
> > +     }
> >
> >       ring->rx_max_pending =3D IDPF_MAX_RXQ_DESC;
> >       ring->tx_max_pending =3D IDPF_MAX_TXQ_DESC;
> > @@ -647,6 +651,7 @@ static void idpf_get_ringparam(struct net_device *n=
etdev,
> >
> >       kring->tcp_data_split =3D idpf_vport_get_hsplit(vport);
> >
> > +unlock:
> >       idpf_vport_ctrl_unlock(netdev);
> >   }
> >
> > @@ -673,6 +674,11 @@ static int idpf_set_ringparam(struct net_device *n=
etdev,
> >
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> > +     if (!vport) {
> > +             netdev_err(netdev, "ring params not changed due to no vpo=
rt in netdev\n");
> > +             err =3D -EFAULT;
> > +             goto unlock_mutex;
> > +     }
> >
> >       idx =3D vport->idx;
> >
>

