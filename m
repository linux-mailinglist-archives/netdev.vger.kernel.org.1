Return-Path: <netdev+bounces-254167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJIEQnXeWlI0AEAu9opvQ
	(envelope-from <netdev+bounces-254167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:29:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5739ECD9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4998300DF71
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3E3345CBD;
	Wed, 28 Jan 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZStqnL97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3333D6C9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592571; cv=pass; b=fZ32bZ6g8j62KvcPDM+pNAfr7cirAn4Rj4xGf0MfhQmQLOLQt8cwRp7nFykagxiNmRLRzDxaZ51GwsQmMWOre+epF2p1VCrQqBaElLt0g4zctVQlVBWZTWmRL+3naDMbW4E5FJTm2soSv321abIeib1HfWAKPS4Z0zzI5fedOmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592571; c=relaxed/simple;
	bh=RSIAd/nJtkq9oPfjNS35NWWtyldhhz18m0qHrSgjs0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB2txh1f5tS/2C0ebx/kluaKnsDXGo291x8vY1yvb1h/t7rKzQJJ2OxaeetkRBRSniNCby4cMXhjLvzCUvEuzWylUzPa9eEsRe0Vu7buyFXvVOeNxZPCl058WveBstjVkkgaFJGxe4DFL0S2pEkzkQAmajsL0Xgb0HeofuXat2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZStqnL97; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3EB5C3F6EE
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769592566;
	bh=1qE6rKoNiQxDL9EWiREE6xxOPhSv5w6cMT8lb0+AlqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ZStqnL97LMqhYjszKKnSXiQAj9Q2LSwXC3o3b3+5pgzTtGvJnF3dk7Psjis+G2m0C
	 InYXxbunoNpLJUfJbUGnUtChG9EISKI0K2ndHHAPilnwhbD31OJvRZCg7l/FwOboj2
	 A94yXYi6O+FWglfMvKkad06hrTEZ+llRwYjzaIIIB+vc0i5c4nWkpun1kYlsIm3dZV
	 3payobt+10Ly06dgqjP4oGIArqKbRN6Vdfq+5WWKbpUrbT8lMm+LnxuVYMGDTw0liQ
	 h4QMq7SHatWd7gqlHDP4GjBUsJlRsBcLi740vXrIYdhXNuDV2JG0R1Xi6DeaH5OlsU
	 L6t5F9BZhG95pGIt2Q9FWLuBQFmh9bpAkFR8dMPpvefLXnLwTmM1iuyVSnHp6yniUV
	 ceWrDKW3KkUwd0yI7ng/C1hWJ8UXVQc2cpk+O/+rJ7p0n7t/onczoDijgjMwgXUdEp
	 rz+DiMf+r8cH+FnloJYVusGBc7z/OKpUPZmbmOMj0Vh9wNoydRdAag76faQDs+IfZT
	 iIlHkWJxEhloCnvPhcXR8zVEeZ28DyVGO+eqkgm6iZqs96ISZs4jW6gM6TW3+J7XQx
	 CIbZJh/XjcbYpLpUQ1MqU/cV2OlX3LFrwiNDBBvceZ3AAAO7JuUHGt5dtXSTiS7gZq
	 fIPfZZXdsza6AUUx90C1IZ0k=
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b74766fae7so5617691eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769592564; cv=none;
        d=google.com; s=arc-20240605;
        b=dSPzUdXfYhvCUr4J6Q8N/Z2Pq7bI0XIqXw7YxGAjPYu3afHsw6XugT4754XgzB+dCY
         PEGWVBR6VDYzdixeH8nbmbOOsv6U8M8P43yhcOOLa+VyvrARcW8KC6pReckPOnjPgfCg
         qbyzPnePbZRJnjEONpH8bBi93CbLVlPwJ4NTUOwQjn4JjnLejiL276Es5WJLRU1Q8NHD
         h6Q9TDnQ64fkb14KbfVRgXOcLzENFgxIHZzujeIZPY+9IrF9TT2UTyVhy6NaDhfzeOwZ
         g2y2F6Y/qpGk2MOXWXwVXRvuFzyxkeHxBAPWc4HME8BwHbw8F2CtPYNQzsw1/+5iWx5s
         ReOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1qE6rKoNiQxDL9EWiREE6xxOPhSv5w6cMT8lb0+AlqQ=;
        fh=N7pSRZ6d67A69mOBp+y1cfedA9QOCOypl2t2phpGEN8=;
        b=fKJo3aZqvVj5pdtGM8NNGizO5R4wy1SG6pE2a0wXrVuwg2/xHBLJ5OBo5bIrMQXyXs
         MGBzt0RAqLAIgMxhj5DunKaOYbA7wMX4P+9nohaMzPay7xYylJeFzZm9WXrSnoxhnQIY
         +NOhZh483dBG3q+Fe1CA+Mo+c4RJTi8swZuUTLGRSSnBHUpeXzKOsL8hKm4q7Ht1q3dx
         CYNfAA4q/9btybwoWkSmXYBccZfvMhM9xpaPgZR9ACr2NM/xXVpKEY906tGVnRGd34PF
         z2/bSHGe7X4VP7QWPPCsVa8K/gtqf5IOXtrsQLcqOhfqwFJU8XK8e3PDuHjjf2B0/1fE
         n9OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592564; x=1770197364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qE6rKoNiQxDL9EWiREE6xxOPhSv5w6cMT8lb0+AlqQ=;
        b=sl6dQRR+2dEpvdfAAYM27YZm0Io9xXyvZoB5NXPQ0ajsrvq0Ag3AlkFq6hLjCVtmQW
         385IjbM91WVzCsVNCkIVA6YF62TRqxCq9RTI7/yXTj09j30pLtcii77zhNQC8O0I93Sn
         /PwndY89i1XWR5nkhniRqfzDxpJaexdGdsGZh01Jua/TjpEcbVpoBUE71+ncOZ3+pfb1
         4jDruGkh25RQgUT9wHrREqewBO4Or3WLcqOh2eF4Z51KN8KYQG2CVUefciptP4sHYiDE
         prbss3CsBEecO0eMYFng+UzepoWMIM3sUmXLs9axjdN+H/Zw5CgwWXYkIvoxGYoOTcgp
         ZDaw==
X-Forwarded-Encrypted: i=1; AJvYcCUovFOtKsFLn0ynmriR8S0JACaeBtKJlv/C7e9IfKi6g9vu+JLZmixbh7yb28GPBE1lHbW5D5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZfQzJVmFgkzGvVc6czbdkaTfHVWgoAU/ccdKE1gIPQajCzW3
	WgA118LHm15CQcOK1i5ElRyEQstgsf1sqGgKJETOYHGetYtB+UY3KI1X93Nc5C2Nw7urCkM9nFn
	mFyvgr76P7FuzQ2TdJ7Yb1G0BC6zHaoCEafLVa+UlMYzIl+vTM3OtFmv3BHGnL4Bjv1g62syBpT
	4zaGKnWHgqTciSjqD4fhkDj4p4q+GglSgD/LD/OQdNDK2YdjA6
X-Gm-Gg: AZuq6aLI0LTJL+4NWqr0cxvCapUsGVaFRL0QO+7k7Our9ra1wD01WLao9A+i69T2O5N
	gYm7IZ+ugFQ8gZo2v6KoOkv90BcBNABpMtj6P4IT0yPAvcHwPqIP5MMhVFkGxTsrVWIrjJEUV9X
	SUaj0r6HDRIIO7bMQR9NNBjDMN5flhOLtTQsQj/pw//yuZJ9McGJZwM2VWPB/LOiN9T54=
X-Received: by 2002:a05:7022:1e0f:b0:11e:65b5:75ce with SMTP id a92af1059eb24-124a00638dcmr2673613c88.10.1769592564449;
        Wed, 28 Jan 2026 01:29:24 -0800 (PST)
X-Received: by 2002:a05:7022:1e0f:b0:11e:65b5:75ce with SMTP id
 a92af1059eb24-124a00638dcmr2673601c88.10.1769592563932; Wed, 28 Jan 2026
 01:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225062122.736308-1-aaron.ma@canonical.com>
 <20251225062122.736308-2-aaron.ma@canonical.com> <4a771aef-4227-4f83-9852-80105190722c@intel.com>
In-Reply-To: <4a771aef-4227-4f83-9852-80105190722c@intel.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 28 Jan 2026 17:29:12 +0800
X-Gm-Features: AZwV_QgL6FJ04T2ofaJuqdex-U7OER7rhndajJNjXZ3ipnT0x2aQoU_xK3CxizQ
Message-ID: <CAJ6xRxUa8h3yO8OksnddWJp6-XkYOsb0qg4vAmt+8MHs0ncEyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ice: recap the VSI and QoS info after rebuild
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ertman, David M" <david.m.ertman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_FROM(0.00)[bounces-254167-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8F5739ECD9
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 6:32=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
>
>
> On 12/24/2025 10:21 PM, Aaron Ma wrote:
> > Fix IRDMA hardware initialization timeout (-110) after resume by
> > separating VSI-dependent configuration from RDMA resource allocation,
> > ensuring VSI is rebuilt before IRDMA accesses it.
> >
> > After resume from suspend, IRDMA hardware initialization fails:
> >    ice: IRDMA hardware initialization FAILED init_state=3D4 status=3D-1=
10
> >
> > Separate RDMA initialization into two phases:
> > 1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no plu=
g)
> > 2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug device
> >
> > This allows:
> > - ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
> >    in ice_suspend()
> > - VSI assignment deferred until after ice_vsi_rebuild() completes
> > - QoS info updated after ice_dcb_rebuild() completes
> > - Device plugged only when control queues, VSI, and DCB are all ready
> Hi Aaron,
>
> Sorry for the late feedback, but I'm working on getting AI Review in
> place and when I ran it against this path it flagged a couple of things..=
.
>
> > Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on =
ACPI S3 resume")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> > V1 -> V2: no changes.
> > V2 -> V3:
> > - mirrors init_rdma in resume as Tony Nguyen suggested to fix
> > the memleak and move ice_plug_aux_dev/ice_unplug_aux_dev out of
> > init/deinit rdma.
> > - ensure the correct VSI/QoS info is loaded after rebuild.
> >
> >   drivers/net/ethernet/intel/ice/ice.h      |  1 +
> >   drivers/net/ethernet/intel/ice/ice_idc.c  | 41 +++++++++++++++++-----=
-
> >   drivers/net/ethernet/intel/ice/ice_main.c |  7 +++-
> >   3 files changed, 38 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/etherne=
t/intel/ice/ice.h
> > index 147aaee192a79..6463c1fea7871 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -989,6 +989,7 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_=
reset_req reset);
> >   void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
> >   int ice_plug_aux_dev(struct ice_pf *pf);
> >   void ice_unplug_aux_dev(struct ice_pf *pf);
> > +void ice_rdma_finalize_setup(struct ice_pf *pf);
> >   int ice_init_rdma(struct ice_pf *pf);
> >   void ice_deinit_rdma(struct ice_pf *pf);
> >   bool ice_is_wol_supported(struct ice_hw *hw);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/eth=
ernet/intel/ice/ice_idc.c
> > index 420d45c2558b6..b6079a6cb7736 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> > @@ -360,6 +360,35 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
> >       auxiliary_device_uninit(adev);
> >   }
> >
> > +/**
> > + * ice_rdma_finalize_setup - Complete RDMA setup after VSI is ready
> > + * @pf: ptr to ice_pf
> > + *
> > + * Sets VSI-dependent information and plugs aux device.
> > + * Must be called after ice_init_rdma(), ice_vsi_rebuild(), and
> > + * ice_dcb_rebuild() complete.
> > + */
> > +void ice_rdma_finalize_setup(struct ice_pf *pf)
> > +{
> > +     struct iidc_rdma_priv_dev_info *privd;
> > +
> > +     if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
> > +             return;
> > +
> > +     privd =3D pf->cdev_info->iidc_priv;
> > +     if (!privd || !pf->vsi[0] || !pf->vsi[0]->netdev)

Aleksandr raised this change to:
  if (!privd || !pf->vsi || !pf->vsi[0] || !pf->vsi[0]->netdev)

I will add this in v4.

> > +             return;
> > +
> > +     /* Assign VSI info now that VSI is valid */
> > +     privd->netdev =3D pf->vsi[0]->netdev;
> > +     privd->vport_id =3D pf->vsi[0]->vsi_num;
> > +
> > +     /* Update QoS info after DCB has been rebuilt */
> > +     ice_setup_dcb_qos_info(pf, &privd->qos_info);
> > +
> > +     ice_plug_aux_dev(pf);
>
> "
> Does making ice_rdma_finalize_setup() void lose error reporting? The
> old ice_init_rdma() called ice_plug_aux_dev() and propagated errors to
> callers with error cleanup. Now ice_plug_aux_dev() returns int but
> ice_rdma_finalize_setup() is void, so the return value is ignored.
>
> If ice_plug_aux_dev() fails (kzalloc failure, auxiliary_device_init
> failure, or auxiliary_device_add failure), the error is silently
> ignored and RDMA functionality won't be available. The old code would
> return an error that ice_load() and ice_resume() would log, helping
> users understand why RDMA isn't working.
>
> Should ice_rdma_finalize_setup() return int and propagate the error, or
> at least log a message when ice_plug_aux_dev() fails?
> "
>
> I agree that logging a message would be helpful to inform the user.
> Either here or propagating it and printing a differentiated messages
> would be nice.

Aleksandr also raised this.
Since ice_rebuild() which called this function can't propagate errors,
so I think logging a dev_warn() when ice_plug_aux_dev() fails is more
appropriate.

>
> > +}
> > +
> >   /**
> >    * ice_init_rdma - initializes PF for RDMA use
> >    * @pf: ptr to ice_pf
> > @@ -398,23 +427,16 @@ int ice_init_rdma(struct ice_pf *pf)
> >       }
> >
> >       cdev->iidc_priv =3D privd;
> > -     privd->netdev =3D pf->vsi[0]->netdev;
> >
> >       privd->hw_addr =3D (u8 __iomem *)pf->hw.hw_addr;
> >       cdev->pdev =3D pf->pdev;
> > -     privd->vport_id =3D pf->vsi[0]->vsi_num;
> >
> >       pf->cdev_info->rdma_protocol |=3D IIDC_RDMA_PROTOCOL_ROCEV2;
> > -     ice_setup_dcb_qos_info(pf, &privd->qos_info);
> > -     ret =3D ice_plug_aux_dev(pf);
> > -     if (ret)
> > -             goto err_plug_aux_dev;
> > +
> >       return 0;
> >
> > -err_plug_aux_dev:
> > -     pf->cdev_info->adev =3D NULL;
> > -     xa_erase(&ice_aux_id, pf->aux_idx);
> >   err_alloc_xa:
> > +     xa_erase(&ice_aux_id, pf->aux_idx);
>
> "
> Does this error path call xa_erase() with an uninitialized pf->aux_idx?
>
> When xa_alloc() fails at line 423, the code jumps to err_alloc_xa which
> now calls xa_erase(). But if xa_alloc() failed, nothing was allocated
> into the xarray, and pf->aux_idx contains an undefined value from the
> failed xa_alloc() call. Calling xa_erase() with this undefined index
> seems incorrect.
>
> In the original code, the err_plug_aux_dev label came after successful
> xa_alloc(), so xa_erase() was only called when something was actually
> allocated. The err_alloc_xa label came after err_plug_aux_dev and fell
> through without calling xa_erase().
> "
>

Right, after xa_alloc failed, it should not call xa_rease, I will remove it=
.

I will send v4 patch to fix 3 issues above.
Thanks for the detail review.

> Semi-related. I sent patch 1 of this series on since it seems like it
> can be independent of this one so no need to carry that one with this.
>

Thank you very much.
Aaron

> Thanks,
> Tony
>
> >       kfree(privd);
> >   err_privd_alloc:
> >       kfree(cdev);

