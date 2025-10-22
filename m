Return-Path: <netdev+bounces-231778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07ABFD419
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EED4188AFAC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BFE26ED52;
	Wed, 22 Oct 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="JUOeD+4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811635B15E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149534; cv=none; b=mFXHJNkXIapbEUi+jNhYNj26WvPImI9r1PwEeygOV//iWIcfPqHJce0pfXu5u0yaX56UK8t9QkiYKVoFpCFH4xICX0Oa78XaQ/fpoQzh7qbiuqUOjzQq8V+TR1IUcB9o5/ZT5WKv+sBrjGzqpBpDVkjmM6CFH1v/N04uqOe9gtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149534; c=relaxed/simple;
	bh=rJ5Nrs/lUYNBsHYppRWP2ng7D8AjCDafkKve5RN48d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaamw8jIPtdDdyjorotpkJ7I/Eg+/J1AWn02gp63uyI8B5ASXX2pvIHEs+45dLVm7AOsxSJytGSVOSHlCBW95oDv/j5H+CQIM2Kygg1nlsr7UyKUz3JP3w9mzB5Gaxkm46pHXGLiED7QhukQjnLHkqdQtoYNC6wmjBE6maWKwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=JUOeD+4H; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0968F3F7C4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761149524;
	bh=hXJoSIXKAZqZaV1/Vtgd9fT53zuB/ef3PvkedjBFaZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JUOeD+4HQBn8EMZNYZMiFc/lT/+997XKFa7JYTFUfzO2EzJfCIgHdAW5/nishzAQ4
	 PILk+zbpevhhWhmWUCf2Q6YF3qJg/V+OqXwp8hDaL3oTi1407IyoZq1dlESBvrkaKW
	 iGSd879PqzqcUjoqMr2y89BAM9rYL03UIBwyI10iZLf4JJ7fjxJ0vwauGtpNKnwmqO
	 o3ZFybdi40nqebyjj3LtEyWOo8Z08s5GFcmWWZeUlETWN34fSY6duHZyGxGo0jB/6d
	 2impmt+fDf3lKZhYJj1tmnP7uG93zzF+RtxIMBb0PVogkqRPMRNuzCZpqYZy2K+h3i
	 /joi/imre2Ep2tK96ckSrLvBrKdhPFpg7iPMiS0zzXY/AYnwjqVUpMc9o6EuuS5aGP
	 5l3Ei2MLABdcxITZYaNw1kb9BeSkKOuCi5xH2FvfuqMx3YgWfvwpAzOZUkWn3vPTGO
	 xEc/cFzNPADFx3L05miWi+EtCYuXjGVglgzbLKa2N6B7yBRwKqC/Xjzg2xd46ZlsJj
	 fuXv7GtYQ/fBU43ibYnT4mDO1V3rUixBFhf7Q2bi+uvyh+z3SDStQ1KtOjkgCTlkZv
	 GKbdfOXSIfpzvchqQWnzkgcoAm7PQQKZLP5j6BfbYcDX0Vv1thOwv+T208YS2/zbJI
	 8x+SatSybPmo0pZFA2irdbAQ=
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6349af0e766so10661793a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149519; x=1761754319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXJoSIXKAZqZaV1/Vtgd9fT53zuB/ef3PvkedjBFaZE=;
        b=LJpV0xV1RKyX6LwLub/k2b3dXWvYgqzLZ9ROI/S88GPysGRoWLHPaUnA7oUOnrTRuN
         sjUYN9Vn3LFowQH9LZ1tYaehmDhmhdXphN+8FmTHucXRRrv0fegExyaVvcrAkd+F8BT8
         vdGE2IrUCd2zytVFyWP9JkN8GLjDVNjoku4N8gSVKg5nmJffFvV0nq0Sv7WKYziba8Cv
         fClm9DH/e5nZ9acsKhT2eeemiR8PRu/yWHSRL0aOgbADnqa0UWLi7YbaLirWGdJM46fB
         pWDUmnwK//qpT1Vc9ElVWwyzPEYsyitJlFTPCjamfLK6gsiFpvArGRbylvfgi4t37O+0
         9+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVRTqwroSkJz5Tt02NXfT7AO1k/3rzTTYNQzlr+bbWbr14D8r3Ezmvw5C0O+MSyIcxR0MqAoYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5PkeJKoBtqMfGQ1h4YNR+gVUZAea3S198MAWX4XZmXSY/aB5
	IaN3pEeb2mmuzMFa+SL77Em/oKE0zd2ZUHC0lUgFrvJOmvo0Sks0XBViTCIMstQu1tDQyCcHsIQ
	PJhDaxtqUkWK2FdqSCdQdgqnSgron8zN+wbXdRGdlLPKdWz4/alaVILcRb6KlpgR2NYuDbYDEFJ
	7dSoqGUJIFjewvcb4FFEzwDBIwO4MzgZIrWfja+IdLDoQDlBrA
X-Gm-Gg: ASbGnct4g3SHYa8r1nZ7r7lFIi5gOg6ARKIxccIbf+p2pb1mZe3lwVVe5vKOCFMs6h/
	4EsnLwbdmN71RIFj0iN/ewnxXviKJPqBoNDM9vKShd+063HWhOVmR5WdymHU6YlkrnxDIKVgHw9
	uC5knGuLCoKTy74HaO/TPxCMiS2x5l4LKM0SsFX6eqaNww3ythzxG7nO07ZFZkDcJLKCgGweIZU
	TMbZhZxSxoTUQ==
X-Received: by 2002:a05:6402:3585:b0:636:240f:9ece with SMTP id 4fb4d7f45d1cf-63c1f6d90d0mr21265284a12.34.1761149519158;
        Wed, 22 Oct 2025 09:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo+EUlFBfQHcw0UwsmPphdFUhsNMc7g4lASSpo/GqY9R6yD4UV9MMURzb4IVRJTknj/6hFy7Q+FY5jHEndIVo=
X-Received: by 2002:a05:6402:3585:b0:636:240f:9ece with SMTP id
 4fb4d7f45d1cf-63c1f6d90d0mr21265253a12.34.1761149518706; Wed, 22 Oct 2025
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021154439.180838-1-robert.malz@canonical.com>
 <0c62b505-abe7-474e-9859-a301f4104eeb@molgen.mpg.de> <IA3PR11MB89860CA0245498E6FF720E48E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <5578e792-2dd6-42db-8ad6-b12cd05c2617@molgen.mpg.de>
In-Reply-To: <5578e792-2dd6-42db-8ad6-b12cd05c2617@molgen.mpg.de>
From: Robert Malz <robert.malz@canonical.com>
Date: Wed, 22 Oct 2025 18:11:47 +0200
X-Gm-Features: AS18NWC0K4JlNBwhxK-j9aBt205Uc7UwVg8g7j0m6_4GsNSQueSsgnqvetVnQuU
Message-ID: <CADcc-bxT13tqWKQFfXX6a5R125dRT21VT+5_ozzV-pmpX708gA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] i40e: avoid redundant VF link state updates
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Jamie Bainbridge <jamie.bainbridge@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Dennis Chen <dechen@redhat.com>, 
	Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Anthony L Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, 
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Paul, Aleksandr
Thanks for the feedback.
I have updated the commit message in [PATCH v2], some notes inline.

On Wed, Oct 22, 2025 at 2:25=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Alex,
>
>
> Thank you for your input.
>
> Am 22.10.25 um 14:06 schrieb Loktionov, Aleksandr:
>
> >> -----Original Message-----
> >> From: Paul Menzel <pmenzel@molgen.mpg.de>
> >> Sent: Wednesday, October 22, 2025 1:49 PM
>
> >> Am 21.10.25 um 17:44 schrieb Robert Malz:
> >>> From: Jay Vosburgh <jay.vosburgh@canonical.com>
> >>>
> >>> Multiple sources can request VF link state changes with identical
> >>> parameters. For example, Neutron may request to set the VF link state
> >>> to
> >>
> >> What is Neutron?
> >>
> >>> IFLA_VF_LINK_STATE_AUTO during every initialization or user can issue=
:
> >>> `ip link set <ifname> vf 0 state auto` multiple times. Currently, the
> >>> i40e driver processes each of these requests, even if the requested
> >>> state is the same as the current one. This leads to unnecessary VF
> >>> resets and can cause performance degradation or instability in the VF
> >>> driver - particularly in DPDK environment.
> >>
> >> What is DPDK?
> >>
> > I think Robert needs:
> > - to expand acronyms in the commit message (Neutron =E2=86=92 OpenStack=
 Neutron, DPDK =E2=86=92 Data Plane Development Kit).
> > - to fix the comment style as per coding guidelines.
> > - add a short note in the commit message about how to reproduce the iss=
ue.
> > @Paul Menzel right?
>

@Aleksandr Loktionov you mentioned that comment style does not follow
coding guidelines, from my perspective it looks good.
Could you elaborate on that point?

> Correct.
>
> Maybe also mention how to force it, as there seems to be such an option
> judging from the diff.
>
> >>> With this patch i40e will skip VF link state change requests when the
> >>> desired link state matches the current configuration. This prevents
> >>> unnecessary VF resets and reduces PF-VF communication overhead.
> >>
> >> Add a test (with `ip link =E2=80=A6`) case to show, that it works now.
> >>
> >>> Co-developed-by: Robert Malz <robert.malz@canonical.com>
> >>> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> >>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> >>> ---
> >>>    drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++=
++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> >>> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> >>> index 081a4526a2f0..0fe0d52c796b 100644
> >>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> >>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> >>> @@ -4788,6 +4788,7 @@ int i40e_ndo_set_vf_link_state(struct net_devic=
e *netdev, int vf_id, int link)
> >>>     unsigned long q_map;
> >>>     struct i40e_vf *vf;
> >>>     int abs_vf_id;
> >>> +   int old_link;
> >>>     int ret =3D 0;
> >>>     int tmp;
> >>>
> >>> @@ -4806,6 +4807,17 @@ int i40e_ndo_set_vf_link_state(struct net_devi=
ce *netdev, int vf_id, int link)
> >>>     vf =3D &pf->vf[vf_id];
> >>>     abs_vf_id =3D vf->vf_id + hw->func_caps.vf_base_id;
> >>>
> >>> +   /* skip VF link state change if requested state is already set */
> >>> +   if (!vf->link_forced)
> >>> +           old_link =3D IFLA_VF_LINK_STATE_AUTO;
> >>> +   else if (vf->link_up)
> >>> +           old_link =3D IFLA_VF_LINK_STATE_ENABLE;
> >>> +   else
> >>> +           old_link =3D IFLA_VF_LINK_STATE_DISABLE;
> >>> +
> >>> +   if (link =3D=3D old_link)
> >>> +           goto error_out;
> >>
> >> Should a debug message be added?
> >
> > I think adding one would be redundant since skipping identical state
> > changes is expected behavior.
>
> My thinking was, if something does not work as expected for a user, like
> issuing the command to force a reset, that it might be useful to see
> something in the logs.

I treat VF reset in this scenario as a side effect which helps VF
bring up the queues.
User should not expect to see VF reset each time these commands are
run and there are
specific commands, like triggering VFLR through pci reset, which are
available for that
purpose.
Like Aleksandr, I found the logs in this area to be redundant.
>
> >>> +
> >>>     pfe.event =3D VIRTCHNL_EVENT_LINK_CHANGE;
> >>>     pfe.severity =3D PF_EVENT_SEVERITY_INFO;
>
> Kind regards,
>
> Paul

Thanks,
Robert

