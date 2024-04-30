Return-Path: <netdev+bounces-92392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC68B6DAE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33C91C21B1E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F373127B58;
	Tue, 30 Apr 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BhVE6Jed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464E205E2E
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467802; cv=none; b=ftvyX0AwWJt86eJzntwjVI04ZEFd0teWolbVi1Nsaq7sVKlMOsVM1bI74watMrDUTkIbJUtQZqAL0quisjsmCwHr9LXiWegRG8ngYX5gJR6qh8X5X+tQIXQ2KhMsDuWnYAkNRMbBG/6awM6NTFueUSmhNuo0k0Uf7h0v7FRx1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467802; c=relaxed/simple;
	bh=Fbt2A3UDLMG1pW8fVX9FN4VMTt7nP0+UBo3NdEI63+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1ecwL7NmG+itfd8yiEmTlD+vaLS9uX8MoDupKm/7cegJN7dJvObhe4LsjDzNJwLLpodaiyfQ/c7mZh69QsZNJgdMkH9fqnmBN1GkCvbcuxGBoeqfOcfnWbQjdGig2tQHqWOQS4t/JoseLkzoR0x9tCNsdTx1et7RgPsTy3dM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BhVE6Jed; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3982384a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1714467800; x=1715072600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjBo2QVMI1CyWQlsIFe9ysVmh7llCcHOfQxc+A80P+Q=;
        b=BhVE6Jedox7v5/DDiK1UZELvJXfCJSOXdV2Z+WKiM1v3HY47DFNQnXDg8biRrh1MVh
         jGa2lkCAYQgNEMg8sG3WqVt2Che8fJVtcj6c37Ha9JfL3VPVb+9NvB1P1IitXjaDMkaL
         AvZJ8hZ72pAZmXkxME87yKi5mN6xUo6Q8ml54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467800; x=1715072600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjBo2QVMI1CyWQlsIFe9ysVmh7llCcHOfQxc+A80P+Q=;
        b=ABH+cOxtaKwkYo7UbKHWjlyI4zljLy9f4gICCQp9cy97YeZCyqthHN9VtaUpqInoj5
         McGw+CTfMS8NpedQ6jPtU8cecpJCOzwge/iuhpD41NNwqHWcmcnXHmaXmimcRCeee149
         le5+lbWIKefHm8Un8ExWtB5J9n76hOEAYxMm6nTnPzL5abpaZg4OoxJhQ+tR3UTXlnPC
         AazC3qecdN1gdFf9py6mHa4Duom3/VgAL6+05zi1jY5rWLd4IDrSrCRnezSg6fkQjCFg
         C00KNnsXj0sE4SM+K0/wn9CwsRqMQEFJU26fXwnjWoZYaOK8gmLVs+Mlg/OKXZRJ5IRY
         IxTw==
X-Gm-Message-State: AOJu0YwO3EeOIxOj+hR7MJ6Rk9d3itEdIugf8hWaWMxUxE5j7jl2eHK2
	Mk5vUMFw2tDPTSyQYx5obzioZ/RwxZferZAXiXC18FaRs9fTHSsaeG2Lr7Qkp5FVL2fYTBK81eX
	Qd3agnhdR1tROmkJgcUL4Zd4Lhfsx3XJyBt1wcZCH23rbvmqABA==
X-Google-Smtp-Source: AGHT+IHFA3yXARPgRd7WfRg9inQlkDKb45T+L+W2rOOOIIWOKTAuDP2mXbHpPw5MN5nf9McFe4daxw7WvYNPhjm8Tkw=
X-Received: by 2002:a05:6a21:3948:b0:1ae:3d01:d with SMTP id
 ac8-20020a056a21394800b001ae3d01000dmr2256870pzc.9.1714467799596; Tue, 30 Apr
 2024 02:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429124922.2872002-1-ross.lagerwall@citrix.com> <a0359435-7e0f-4a48-9cc6-3db679bde1ac@molgen.mpg.de>
In-Reply-To: <a0359435-7e0f-4a48-9cc6-3db679bde1ac@molgen.mpg.de>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 30 Apr 2024 10:03:07 +0100
Message-ID: <CAG7k0ErF+e2vMUYRuh2EBjWmE7iqdOMS1CQv-7r18T1mVbK1aA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: Fix enabling SR-IOV with Xen
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Javi Merino <javi.merino@kernel.org>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:04=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Ross,
>
>
> Thank you for your patch.
>
> Am 29.04.24 um 14:49 schrieb Ross Lagerwall:
> > When the PCI functions are created, Xen is informed about them and
> > caches the number of MSI-X entries each function has.  However, the
> > number of MSI-X entries is not set until after the hardware has been
> > configured and the VFs have been started. This prevents
> > PCI-passthrough from working because Xen rejects mapping MSI-X
> > interrupts to domains because it thinks the MSI-X interrupts don't
> > exist.
>
> Thank you for this great problem description. Is there any log message
> shown, you could paste, so people can find this commit when searching
> for the log message?

When this issue occurs, QEMU repeatedly reports:

msi_msix_setup: Error: Mapping of MSI-X (err: 22, vec: 0, entry 0x1)

>
> Do you have a minimal test case, so the maintainers can reproduce this
> to test the fix?

Testing this requires setting up Xen which I wouldn't expect anyone to
do unless they already have an environment set up.

In any case, a "minimal" test would be something like:

1. Set up Xen with dom0 and another VM running Linux.
2. Pass through a VF to the VM. See that QEMU reports the above message
   and the VF is not usable within the VM.
3. Rebuild the dom0 kernel with the attached patch.
4. Pass through a VF to the VM. See that the VF is usable within the
   VM.

>
> > Fix this by moving the call to pci_enable_sriov() later so that the
> > number of MSI-X entries is set correctly in hardware by the time Xen
> > reads it.
>
> It=E2=80=99d be great if you could be more specific on =E2=80=9Clater=E2=
=80=9D, and why this is
> the correct place.

"later" in this case means after ice_start_vfs() since it is at that
point that the hardware sets the number of MSI-X entries.
I expect that a maintainer or someone with more knowledge of the
hardware could explain why the hardware only sets the number of MSI-X
entries at this point.

>
> > Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> > Signed-off-by: Javi Merino <javi.merino@kernel.org>
> > ---
> >
> > In v2:
> > * Fix cleanup on if pci_enable_sriov() fails.
> >
> >   drivers/net/ethernet/intel/ice/ice_sriov.c | 23 +++++++++++++--------=
-
> >   1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/e=
thernet/intel/ice/ice_sriov.c
> > index a958fcf3e6be..bc97493046a8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -864,6 +864,8 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_v=
fs)
> >       int total_vectors =3D pf->hw.func_caps.common_cap.num_msix_vector=
s;
> >       struct device *dev =3D ice_pf_to_dev(pf);
> >       struct ice_hw *hw =3D &pf->hw;
> > +     struct ice_vf *vf;
> > +     unsigned int bkt;
> >       int ret;
> >
> >       pf->sriov_irq_bm =3D bitmap_zalloc(total_vectors, GFP_KERNEL);
> > @@ -877,24 +879,20 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num=
_vfs)
> >       set_bit(ICE_OICR_INTR_DIS, pf->state);
> >       ice_flush(hw);
> >
> > -     ret =3D pci_enable_sriov(pf->pdev, num_vfs);
> > -     if (ret)
> > -             goto err_unroll_intr;
> > -
> >       mutex_lock(&pf->vfs.table_lock);
> >
> >       ret =3D ice_set_per_vf_res(pf, num_vfs);
> >       if (ret) {
> >               dev_err(dev, "Not enough resources for %d VFs, err %d. Tr=
y with fewer number of VFs\n",
> >                       num_vfs, ret);
> > -             goto err_unroll_sriov;
> > +             goto err_unroll_intr;
> >       }
> >
> >       ret =3D ice_create_vf_entries(pf, num_vfs);
> >       if (ret) {
> >               dev_err(dev, "Failed to allocate VF entries for %d VFs\n"=
,
> >                       num_vfs);
> > -             goto err_unroll_sriov;
> > +             goto err_unroll_intr;
> >       }
> >
> >       ice_eswitch_reserve_cp_queues(pf, num_vfs);
> > @@ -905,6 +903,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_=
vfs)
> >               goto err_unroll_vf_entries;
> >       }
> >
> > +     ret =3D pci_enable_sriov(pf->pdev, num_vfs);
> > +     if (ret)
> > +             goto err_unroll_start_vfs;
> > +
> >       clear_bit(ICE_VF_DIS, pf->state);
> >
> >       /* rearm global interrupts */
> > @@ -915,12 +917,15 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num=
_vfs)
> >
> >       return 0;
> >
> > +err_unroll_start_vfs:
> > +     ice_for_each_vf(pf, bkt, vf) {
> > +             ice_dis_vf_mappings(vf);
> > +             ice_vf_vsi_release(vf);
> > +     }
>
> Why wasn=E2=80=99t this needed with `pci_enable_sriov()` done earlier?

Previously ice_start_vifs() was the last function call that may fail
in this function. That is no longer the case so when
pci_enable_sriov() fails, it needs to undo what was done in
ice_start_vifs().

Thanks,
Ross

