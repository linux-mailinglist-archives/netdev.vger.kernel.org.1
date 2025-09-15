Return-Path: <netdev+bounces-222974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A47B575A4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4341AA0AF8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD222F5308;
	Mon, 15 Sep 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U0keAOAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7192777F2
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930962; cv=none; b=SyibS2Tq5brwZ0syRjOzjaXPLAt3Du2NsWGQ8pruwasFbelz8V0YmFgjlMHMGLq/p0nY9hs5zewE+1/zDG6erl6z+rzxS5uNyo74SAAAyFc1RJqFdfHalXB9RRgvEjASD9s/QplmOhDTikhUs7F4nI/6CyZ+hDRUIlNPzLZGSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930962; c=relaxed/simple;
	bh=U/PLbhhVuEXlMbLlMRHkNA9W3tLKTI+TRSl6kCsCOXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAEGKEiFSvu1CEt4sF3U2DKxMiClc12jZ7T018JMMCp/03tG4jSAXVCswR9A+C4aE0j3p/p1FEJ7/aOVFtYYg4c2iodWWyZAUPDAuxv18GFTymx4ghUlR4CyqQhpZhUqApMfEnJGAiYPjcfGAPQ7SDYZsq+UBGQybC8ZbJoyMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U0keAOAv; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-77256e75eacso3289841b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930960; x=1758535760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBavr9jQ+h9BKvCBr1gL7d+lm7C+nGo8s+r9hY3b8xs=;
        b=Tq+pZZ+vnNN05VoSn8OK0NPfgSumRmNgBS77egTEegGKbdJXm8FYajpDN9QrhlpdpU
         e70EKCMLMwVKCcH5fBHCq3NJ3KJlgegNnAUQyk2eAafO5Q+DEgVpIOZeFo7i1hV5DnFU
         +ITcEBarPrR1yaOG+N/PKZ/fjuqwSUIXmaz/F3fYVWD1rr8Aam2bNXXVHI3KgP1F9uYa
         of5gRYrTGEyNUuVrGGx0G8yK+kj1JU4exSHRSCLH1+WOMTIV8U3+6xIZDXYUwaj6e/vI
         9BkLy+42wLmH3p8HTZQCx9ozuWxc2c4tfVVZCKLY17/u1FzSbIjc2fJJSg50pAG/zD92
         cITw==
X-Forwarded-Encrypted: i=1; AJvYcCWv2cv6hnD9ywuyMBrRnhvW9zHd3K0xgOybb2lIsy9ZwOwTtIhdSMcfPHFpey4BAmCFn5jEfRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJoUdXQPpGDZtUhFfHinXaqEtfj3BQmypBQZn/IENmylAeGWn
	i2uBUJZUqThYoawX1Br/iT0b+8pOI1Yw/6+mRqS2j6XOIpcciDZwTBxpv78m5GGcu6V+CZQl4hp
	E2ZjwT4Bnwb/vnF/nMZHh5ivzt9GJPVAjwZ22yTb1cmMGa5vpA0dEZXeJcLqhO4Z/j+G1U+Ch1u
	WdYWCdYeLHi8COGfTY0rX/N/V2CdhN1pdxTpgisAQNIi3HQCci8Umw8bOv2/YmUr5decZKb+L9Z
	ui4vENMHw==
X-Gm-Gg: ASbGncuR34exJDdCZileBMkXrDN2rRe7V+yg4HF3Nbo5JhrY65hTDAaOJCpn+UgZUyb
	MjO5IOCgYUdaWwmw9gSH6rF1LS8+nT4ODrsnKDj0ExAjNXBmIUOmffihCPMejUlDl/f9srwUcAy
	PFGMWzw7ihXcivrO7EMEV3ZCm9CCccDaj12/dJiWITN/CgCJPNBAE3N5FnDZKjYhJu0wp7xxhnj
	e5H8pOy45Qbc/2Y3s4jLXzUPsR9nKU6HdktemQo0ttg4QGgr7dY+Hmy0PQ7TXEsuK2SaUOt8yf9
	QuQ1eRG3D5ph1mpaYsKZGVYIpII6xCgBlAQ+w9r74vKdc3GiA5btBqJeU6soK98cZpJRY4WIYlo
	T2AiwKnBUebUlXMekYD8mHW7TWCLgDcWiTge+RsHVkV4pimBA3dDU1NAaYRh1dPJ0Izxd2Vp3Bw
	==
X-Google-Smtp-Source: AGHT+IEN233J7MsdsvXPy5D1+udmEtbBfjVWcMZ/4cTF66xz9YR5bmmhdz+Ry52xg7FrqAxJ5Jxaa4rgukSM
X-Received: by 2002:a05:6a20:6a10:b0:24e:c235:d7e6 with SMTP id adf61e73a8af0-26029ea90c7mr14847836637.5.1757930959989;
        Mon, 15 Sep 2025 03:09:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b54a32de0a5sm937784a12.0.2025.09.15.03.09.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:09:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b521ae330b0so2860634a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757930958; x=1758535758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBavr9jQ+h9BKvCBr1gL7d+lm7C+nGo8s+r9hY3b8xs=;
        b=U0keAOAvAmPPbBDQ7rypqEd4YWx0DFdS5eLesJ4u3X9rqpMAI1W6sA5v/VrrZd+Hm6
         TBNXCZeQtBlc8Ma+wgXfPKsowN44VV9Z9ORP7k9pEEpu6ctU5ir4jUlioUIBfsovBVB5
         vWtBZDrGtISQxwzcf1NzVK/76y+qIYwJFle8M=
X-Forwarded-Encrypted: i=1; AJvYcCVKNu+stiuJcUctnBMsHlzQ9bxB/8bsy7iuuCvLTHYcXqypxAzSmEk60YAkFAaKVx1XehJm100=@vger.kernel.org
X-Received: by 2002:a05:6a20:7d8a:b0:243:cb7b:4f5f with SMTP id adf61e73a8af0-2602aa8540dmr15028006637.25.1757930958128;
        Mon, 15 Sep 2025 03:09:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:243:cb7b:4f5f with SMTP id
 adf61e73a8af0-2602aa8540dmr15027979637.25.1757930957686; Mon, 15 Sep 2025
 03:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com> <20250912083928.GS30363@horms.kernel.org>
 <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com> <20250915090030.GB9353@unreal>
In-Reply-To: <20250915090030.GB9353@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 15:39:04 +0530
X-Gm-Features: Ac12FXzj8nttMlLesrNI78MUsEI7XtM_elOMf9bmvak_fvi5RopheCYFXb7wkdE
Message-ID: <CAMet4B7oKv3wHJaXK-iFdbdtR30G5oYCz17TFQDYMLtrWH20bA@mail.gmail.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling Firmware channel
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 15, 2025 at 2:31=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Mon, Sep 15, 2025 at 02:14:19PM +0530, Siva Reddy Kallam wrote:
> > On Fri, Sep 12, 2025 at 2:09=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> > > > Add infrastructure for enabling Firmware channel.
> > > >
> > > > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > > > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > >
> > > ...
> > >
> > > > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infini=
band/hw/bng_re/bng_fw.c
> > >
> > > ...
> > >
> > > > +/* function events */
> > > > +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> > > > +                                  struct creq_func_event *func_eve=
nt)
> > > > +{
> > > > +     int rc;
> > > > +
> > > > +     switch (func_event->event) {
> > > > +     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> > > > +             /* SRQ ctx error, call srq_handler??
> > > > +              * But there's no SRQ handle!
> > > > +              */
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     return rc;
> > >
> > > rc does not appear to be initialised in this function.
> > >
> > > Flagged by Clang 20.1.8 with -Wuninitialized
> >
> > Thank you for the review. We will fix it in the next version of the pat=
chset.
>
> Once you are fixing it, please squeeze you switch-case to be something
> like that:
>
> switch (func_event->event) {
>      case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
>      case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
>      case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
>      ....
>         break;
>      default:
>         return -EINVAL;
>     }
>
> Thanks

Thanks Leon for the suggestion. Sure, We will fix it in the next
version of the patchset.



>
> >
> > >
> > > > +}
> > >
> > > ...
> > >
> > > > +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> > > > +                          int msix_vector,
> > > > +                          int cp_bar_reg_off)
> > > > +{
> > > > +     struct bng_re_cmdq_ctx *cmdq;
> > > > +     struct bng_re_creq_ctx *creq;
> > > > +     int rc;
> > > > +
> > > > +     cmdq =3D &rcfw->cmdq;
> > > > +     creq =3D &rcfw->creq;
> > >
> > > Conversely, creq is initialised here but otherwise unused in this fun=
ction.
> > >
> > > Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable
> >
> > Thank you for the review. We will fix it in the next version of the pat=
chset.
> >
> > >
> > > > +
> > > > +     /* Assign defaults */
> > > > +     cmdq->seq_num =3D 0;
> > > > +     set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> > > > +     init_waitqueue_head(&cmdq->waitq);
> > > > +
> > > > +     rc =3D bng_re_map_cmdq_mbox(rcfw);
> > > > +     if (rc)
> > > > +             return rc;
> > > > +
> > > > +     rc =3D bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> > > > +     if (rc)
> > > > +             return rc;
> > > > +
> > > > +     rc =3D bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> > > > +     if (rc) {
> > > > +             dev_err(&rcfw->pdev->dev,
> > > > +                     "Failed to request IRQ for CREQ rc =3D 0x%x\n=
", rc);
> > > > +             bng_re_disable_rcfw_channel(rcfw);
> > > > +             return rc;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > ...
> >

