Return-Path: <netdev+bounces-209713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B7B10832
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228EA5A5C17
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A9269D16;
	Thu, 24 Jul 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OU7fFOe5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A22257AC1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354455; cv=none; b=XjwzKd+5Rn1OiqZ/MBuRuYQneGhs6NXrkWYXdgoGG5SswnIjVu+y2NWL9rFtzoU7wMH+POkHaRB+h3froj1jWkVpHGpPBLxgMLReTfwGJZ/ivSrUEg0mbhYgjugLer5Za0kNKY8EAEWxKdEOSYZqfehNueC5IbJt+uEDXPZTvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354455; c=relaxed/simple;
	bh=uxMoftXdMI+6x4R0vIZEaauJt+EeF9hGvLXRf8t3A70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJrPyMgfn7NNWACVYu4+qaRT5tI8z5QzbLLieegIG6EkixkIPmCcExvydnWu0gn6lOu59prQXdo1wui6JPuOz/9WDE9i6gmmAYmcmtz0w94W13kZORDlBvV2MBl/Puy/70jWMzdTkc+XtUTku9EOckuGYy/wJ/reSUeVZrH4J9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OU7fFOe5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753354452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxMoftXdMI+6x4R0vIZEaauJt+EeF9hGvLXRf8t3A70=;
	b=OU7fFOe5lFkVvKdTnpyp1zZe2sam8rz1MdkmuOEqYMFeeOhP+QKFKp72nKJVhbnn/VGOmf
	87S2WhJQTPMEIPpNEfEIuVLiMt/nZHyQNFZkfJdA3KlIUgXohyGeHKK47xTYizsu6gUBuy
	jbAitz/oKNbx0+VrVwGN+M6tq/JuSLM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-3C35LsahPD29b8ssRqDA4Q-1; Thu, 24 Jul 2025 06:54:10 -0400
X-MC-Unique: 3C35LsahPD29b8ssRqDA4Q-1
X-Mimecast-MFC-AGG-ID: 3C35LsahPD29b8ssRqDA4Q_1753354450
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23824a9bc29so13505185ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 03:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354450; x=1753959250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxMoftXdMI+6x4R0vIZEaauJt+EeF9hGvLXRf8t3A70=;
        b=c2Dt8f1WUVh9y+SNvmmGO+HuWO2SzBYJjMYa5+qv0Z0WGgHPkbqXEd6BdGJMDmBFCo
         t8P2bhuCyurKdy5uoL1XvDzbn1bZBf9QmJPvlIs6dhtUMKXlPHYMhaA7vf+n9X/Jf1ak
         7xBqNoWtlMkuTuglgJTi2U2uqD+U4tie2DT7+u9UtWVtkpCw3RzY/0pn0kEBUB3bURed
         ZJaiMp6FtAhvR57VFfomeIQDEPj4Fp5qMY78W2KQ+Pduf2efybBlaYB/d4NvJuexp3BC
         R3dmHR3q+whI35Be4zW8rJ2J+2CZ1ZKhGR1BE+ROGdYpA9F+9UjYz/BI4nAb4xk+ybxx
         +sEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYokS0fItug+zs92Pdl03DuWKQie4oanbM23ejmJjtMsIN0UMBBTyBgk2Ml0aPf2HN28XnRwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWa3TEktHjDjRrpLiND1UpaHJ8A+3sRdQrYOZEsw+FpbDUqP3
	QiVYcUeWFzxrnQYjbdRvFy0U4Nmz/3PrqUhFGg8OR5EzlfX9r4TfTQnMqbXFmmTZyg1+J1rk1oD
	oyW1tHipMOYY7+Kzgflw2hgv8IJMfmnJLxVg453qI2Qp8R37Mppj5ziap0Dhmutl44Q1PT+RuyH
	0GnZe0DKirlYzpfuBZvP2vRYjGq3Ep8RfW
X-Gm-Gg: ASbGncveSZKGpKQYWdLt+EVapBLadHC+PsxkT9ZKzRi07jPJA2WIhbW4RhnirPU+M92
	LnYlpBDRksInpf8a2k3sS9sXMqL2fPCpLayrlYDgrsatf6SGLGLrzNYjvBZnCMeSoLJAsW9ExI3
	LL6mxGdFFoUh1XkLUtKTc2
X-Received: by 2002:a17:903:198d:b0:235:ea0d:ae10 with SMTP id d9443c01a7336-23f9813e205mr107649455ad.12.1753354449693;
        Thu, 24 Jul 2025 03:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFOTVdXAfjtLsbycdawUZ8DDcX6to21wyaPJOYD6OmaegW9Wrx82jONFo7CF4t+3eGjdY7xZMdF+RAzGmSJY=
X-Received: by 2002:a17:903:198d:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23f9813e205mr107649175ad.12.1753354449322; Thu, 24 Jul 2025
 03:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
 <20250722145524.7ae61342@kernel.org> <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
 <83470afc-31f1-4696-91f3-2587317cb3a1@redhat.com>
In-Reply-To: <83470afc-31f1-4696-91f3-2587317cb3a1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Jul 2025 18:53:57 +0800
X-Gm-Features: Ac12FXx3S2AWWiQuEPTiKRRXtLmbN2_tfvmAMqH4-csQie5HcUBvfdjvqHvt628
Message-ID: <CACGkMEtg00ih8tv4LTgxNkUEREF5vzYP=dKrth_eFPbEDZg11w@mail.gmail.com>
Subject: Re: virtio_close() stuck on napi_disable_locked()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zigit Zo <zuozhijie@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/23/25 7:14 AM, Jason Wang wrote:
> > On Wed, Jul 23, 2025 at 5:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
> >>> The NIPA CI is reporting some hung-up in the stats.py test caused by =
the
> >>> virtio_net driver stuck at close time.
> >>>
> >>> A sample splat is available here:
> >>>
> >>> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-st=
ats-py/stderr
> >>>
> >>> AFAICS the issue happens only on debug builds.
> >>>
> >>> I'm wild guessing to something similar to the the issue addressed by
> >>> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi=
,
> >>> but I could not spot anything obvious.
> >>>
> >>> Could you please have a look?
> >>
> >> It only hits in around 1 in 5 runs.
> >
> > I tried to reproduce this locally but failed. Where can I see the qemu
> > command line for the VM?
> >
> >> Likely some pre-existing race, but
> >> it started popping up for us when be5dcaed694e ("virtio-net: fix
> >> recursived rtnl_lock() during probe()") was merged.
> >
> > Probably but I didn't see a direct connection with that commit. It
> > looks like the root cause is the deadloop of napi_disable() for some
> > reason as Paolo said.
> >
> >> It never hit before.
> >> If we can't find a quick fix I think we should revert be5dcaed694e for
> >> now, so that it doesn't end up regressing 6.16 final.
>
> I tried hard to reproduce the issue locally - to validate an eventual
> revert before pushing it. But so far I failed quite miserably.
>

I've also tried to follow the instructions of nipai for setup 2 virtio
and make the relevant taps to connect with a bridge on the host. But I
failed to reproduce it locally for several hours.

Is there a log of the execution of nipa test that we can know more
information like:

1) full qemu command line
2) host kernel version
3) Qemu version

> Given the above, I would avoid the revert and just mention the known
> issue in the net PR to Linus.

+1

Thanks

>
> /P
>


