Return-Path: <netdev+bounces-222949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7115B5734E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 646AC4E17F9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDC2E9EDD;
	Mon, 15 Sep 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a9kI7BVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3B2877DB
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925876; cv=none; b=taxAFA9R4UIQ4j/RW8ObzmsXSUiOfjVZPgNOP6oKVzAfWL5FZ+U47kzzuopnW2OWwuiYudzzRyaeMs09MyADSwan3QCo5r4xBGoWceYOZFfvqcUGzmglqAL5vlCSx1BA/nNLjbQd9d8bu1OljpR48Cv2UJvUk/0oZoWtgcZ77Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925876; c=relaxed/simple;
	bh=g11jWENkwoU8Na+ecvRfnbd5v+q98Q+5TPwd/Vvp8h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMMw7y1n3nHyzNJ3RG+7czkbtZWNQGfWMjedjB7zvkCW8QOxxzu2/ePPvKoZ4QymiPgyt0H0l1NEHBHMjZceUUaCGqbCo93TJwdRh0pz9s/htu6niCtmXoAdk8oDRjKD+qPEGqRtIKqPaWrp4VB1XueY83xXI4PkZ/0gPTzSZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a9kI7BVV; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2445824dc27so34252175ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925874; x=1758530674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQb8RYMYAzTXzTdmlJMr3dWkAPM5Utj+gm4PBU9wVqM=;
        b=RzW/y7wj7X8/VgfWSqKjj66Ao/l7pePXe3HBk0Tj8myYUgUEiGB1DKYB+uSB+/vbBo
         UUFlU57yg+8c5yCje42x07LFm0oz+FZIBgnKQEsKkzZSAiJIcjbOEourkNPM9O8FdlZP
         XOQ7Ag0PEMY2IxXH09CglAnOxBtP1kQj/RDU0EvK0j7XEyet09a9lrvFZT4LLJHDk+FH
         IOuoRoJeTCn24mssi3KFNVOsoBdFE/tbaBnY94vf5czDIjmqYDp34lnQrYWIFwMAWSdI
         r5WaK/2x4xu6roQYsiZnEg5h4UKUC9U42N/kYQX17M2XobJm8Et8V6EOSEnG17BMjryR
         UEOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtEjrU3Kkm9cf4ZSbLAyIk7xegdX7h5YRUt2auMxKTYwcWHX9Q+i8bF9SodWwCkHDpY2/4yoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizdAWlIq1a1ADg7G3fZANpVwjWCtLeqCuIyU2J/kazhO7jDS+
	VpFzrxTwapaLJtfNYGp6VAbk1jlVCWGeNgWnhii/bRE+G7zJYv04Lz6dYjvA0T5xf17t0EQfsix
	4Xx75ODsfqQuU+KNG5zRrsW/3AMnmVzmbq96p3TEcNucudUY/myJ+soHHVnRGVzErosTFjjypMp
	9MKjcP5LJwwMBZo4G/p3y+tSbqUGAzQ83TkxnuHnDTZnNAwCT0qZR5D5VouMcDej6WPpndMZBhY
	wsQHFnitw==
X-Gm-Gg: ASbGnct7i0rF+sVpmHHCURAPx1aD2FLbasZDz2/ejOXN2ApdHepPDlUMEgD2A8eS9JT
	Hmu+mNrSJa8wGeiyztdwL6kvTeYLIPy9/FtNNKJFgNSzVziL4dN3WdSv8xtptFIk57/OCXo37v5
	+/QcPUg2WiCuQOVR/+uCVxMCrL8czm0XgJ8b/YCjCTS9l8G+3PPiX+pJm8pEkylHYjnU2wnRixb
	va4moD88RBxkoPZ/Gs07pHgsBLHj5+vRuFggOaFjfSv6yOD2mWryaSRamfKq4dRaJfmuT8ZQ1IH
	GuhE1QOzZFbHaxBN3xpMvvxhJwaxnFEQ51H/252raJBsfOPzhXgOBmYXwNdE7v6bih06/2ySOht
	5GLoeWWoB751cTOJ7GgMcFrgSxUaEFQxTHo+kWb7zZYQ/B1AVqSYsVoYKLSN2dqUPWui959PTxw
	==
X-Google-Smtp-Source: AGHT+IEv6KUWa62Di9zsqr2UgU0OCNEK37DEe8A/HZTRaKz+g713Jz/zybwu4+A0ZzN+snfEpXG8D3c6zbyG
X-Received: by 2002:a17:903:120c:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-267a1f19d82mr11849145ad.18.1757925873981;
        Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2677a5cf705sm1309335ad.4.2025.09.15.01.44.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32e3c3e742eso648772a91.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757925872; x=1758530672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQb8RYMYAzTXzTdmlJMr3dWkAPM5Utj+gm4PBU9wVqM=;
        b=a9kI7BVVgIa316KWODzi4VXHNKcvd3yogQOE/9UP0mZ8mqsO4JxRpIrWXaOOCd5RTK
         /2nt+vuNsd8bt1uSSjxeGO/QVD7tAkq25v3jEuYteti3LVGZeiR5nIICME6f5mZ9158s
         zPzqTtKZ+OR4VY8HIhy3MLbPaxsS5FYOFV+BQ=
X-Forwarded-Encrypted: i=1; AJvYcCXYrPrOhZWvXaVc87bduM1vVB6+/U4OEtcNGMHmrL3s9sO3PW1VxtVZ/pNG9I55G32kJk6xfu0=@vger.kernel.org
X-Received: by 2002:a17:90b:3a47:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-32e2059f465mr6831682a91.7.1757925872448;
        Mon, 15 Sep 2025 01:44:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3a47:b0:32e:2059:ee83 with SMTP id
 98e67ed59e1d1-32e2059f465mr6831666a91.7.1757925872010; Mon, 15 Sep 2025
 01:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com> <20250912083928.GS30363@horms.kernel.org>
In-Reply-To: <20250912083928.GS30363@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 14:14:19 +0530
X-Gm-Features: Ac12FXw_V23dGUkYYORcZ7epnqiUhOp5KppY4fGCy2Xx8Nd4CLPLSNw62BORLqQ
Message-ID: <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling Firmware channel
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Sep 12, 2025 at 2:09=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> > Add infrastructure for enabling Firmware channel.
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband=
/hw/bng_re/bng_fw.c
>
> ...
>
> > +/* function events */
> > +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> > +                                  struct creq_func_event *func_event)
> > +{
> > +     int rc;
> > +
> > +     switch (func_event->event) {
> > +     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> > +             /* SRQ ctx error, call srq_handler??
> > +              * But there's no SRQ handle!
> > +              */
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return rc;
>
> rc does not appear to be initialised in this function.
>
> Flagged by Clang 20.1.8 with -Wuninitialized

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
> > +}
>
> ...
>
> > +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> > +                          int msix_vector,
> > +                          int cp_bar_reg_off)
> > +{
> > +     struct bng_re_cmdq_ctx *cmdq;
> > +     struct bng_re_creq_ctx *creq;
> > +     int rc;
> > +
> > +     cmdq =3D &rcfw->cmdq;
> > +     creq =3D &rcfw->creq;
>
> Conversely, creq is initialised here but otherwise unused in this functio=
n.
>
> Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
> > +
> > +     /* Assign defaults */
> > +     cmdq->seq_num =3D 0;
> > +     set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> > +     init_waitqueue_head(&cmdq->waitq);
> > +
> > +     rc =3D bng_re_map_cmdq_mbox(rcfw);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> > +     if (rc) {
> > +             dev_err(&rcfw->pdev->dev,
> > +                     "Failed to request IRQ for CREQ rc =3D 0x%x\n", r=
c);
> > +             bng_re_disable_rcfw_channel(rcfw);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...

