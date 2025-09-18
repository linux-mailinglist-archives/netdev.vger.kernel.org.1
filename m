Return-Path: <netdev+bounces-224366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8556B8430D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8211C8347D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BA2FAC1C;
	Thu, 18 Sep 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BNhcXiXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758742F99A5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192089; cv=none; b=L4THQpMgg+e0AoWLoxe9IjzoFc6fmNdZTEYVLR+D6wquoHtirRXeymWqRX8Ctxe4PepuKCpGxCEdkPre0UIMh1XziTeeY69YYN+zyZWjiTgyHb9nWu9w0uO8brrBfvuWZnpsaBTlyYj+aj6lwVBpZtmJRmhZWvY5RXH9ysS5X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192089; c=relaxed/simple;
	bh=CbE49JSJ+LMRaHZriOstDzk9yUxo35FaLPw3pqofbVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0F70P/Cm++Aww63gpAIlfWM2tbQgc7Gr2AsYDBUarkW1et/bO0X4zcFFNSIMJK6bIW7QwfinvhaGqLQeBkNNzyArDz5BN13kszJoYKiyIEdPyypPKTQeODpn4Eedv4m+2v9wj9x0sEt17uzIVrdWoY9WqCZFQN896f/rxXjEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BNhcXiXQ; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-322f0a39794so194682fac.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192086; x=1758796886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQCJx6p5vPHKg/pDposcY1SdIZSMhxTSp8O6tFxrHXM=;
        b=W6I3HPp0RBBeq4ccXJ8f75ffOE3bgI5Jh1gzuydEDkMt0Caq8hFZWmks8iuJVZt929
         HDmRIM5vMVpKsapUxe/6JsJCd2G7uZnQeNf4/kKA6Q7hNEldx0CA6p/QAaSL0ulPD6K0
         slH2VzEAckkfmKwl5Dw3MQ2oO3OylmZfZ/1qHdvHrNPZiXlTiMgMVZ8MDd2YI2JjivxQ
         jzf8GrT5rAVZa1HZC97QN7+DwOj0fkqgi7QDU9JymAflOt4MDRbWpi5JIrD0pqGGYAG8
         QOcNWdaBFxdGZPxcbgQZEI5eSXIgnmI1PzpEw80PJNV5ls13binS5Bak0u1Myyjbkqjx
         nQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCURoWbrCfNRumUFzipEFcnrLuLRLwA8txkukaVaB+ySFgJja/VT6KqPPlz9LALApLiqhbgH9BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrv2XWyEYPx/hNtocIrPDGFdnr9HYyf+X/OFIKytkJDQbMOaXr
	Q48F2WTJEgcDXgQGwzlJYfekDeEd4Jhb/fpbKFM4CpZenxG5lAQlUBL0770XGX8KGpbAniHcz/b
	DWcB/7OPE85EFwdUnMydCg22BtEkHOrM59/P9SZ1CYMw4NNp1g+rR+7yH1e/FN1ui63/H5eUwqy
	G5/ykLPATO3CNCN7vOjgnY1nJPZnmJ729v0O1M/qm7zv9hThsVKx2OoP14zzBraz/CQAYuk4O7E
	Qi+L/60dW04pr/SzQ==
X-Gm-Gg: ASbGncviX+DFcD2FAMdtpUjyyZ0LtHyIZHgUYTnaJ8mY1TeS+uZKsG2fDjhOC/BPVMC
	69ig5P1AkPXjtZ4TSZIaPLUxwOpdgx6LK9DV/Kxhdd6u7d5bVstm5V7eLqQA9gjXIPr9tab1oti
	cW3bZNPfmcDTxWkrhONlNgGzB/UUD8iXqlPRxLKMiTRBXo5ynsIARh17Yg75+3UeN1RUVFbKpUt
	PjLgsknf5apIQvye7VqSh3nP9rB9j29w/Vz0+JYq7GSl1PVB7TjAJGz7Wv5OqIHFOtA4NpHiwEm
	DXeILroY9xs0PG3M9DmkfRIbASE638+UGFgbnkCL410GpAq2e3amlcEdT/0gg6RgiJyeIG37mpv
	bX+UPBDf/VGxCC7hAuCS8r2Xw+PhT3qnJTQVuEwGewroFlxLC4qPN8Mv3rISPIgi8sEhrCRTE1l
	qnQiVkC5kv
X-Google-Smtp-Source: AGHT+IHeZJ7Nn7uAoeI9He1XORqk2Vn/1Bc5li7Mtl+c7QW/BWRONQ9vz/OgmwI74q93rD5jSbajJwwCi8PU
X-Received: by 2002:a05:6870:9a26:b0:332:7373:523f with SMTP id 586e51a60fabf-335be0b5da3mr2799622fac.13.1758192086385;
        Thu, 18 Sep 2025 03:41:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6aa02ffsm239637fac.22.2025.09.18.03.41.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:41:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2665df2e24aso15163365ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758192085; x=1758796885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQCJx6p5vPHKg/pDposcY1SdIZSMhxTSp8O6tFxrHXM=;
        b=BNhcXiXQGqm9CM8zSPgnlcJB7SOKNBfda2nDknRva5BeAb5O17COUPsoL4VksisPn8
         l7KIVKwxeEujPgq3butIBOUcbsN1MEBLhGqa1ic5INoAeLoyovEWSJOM34cUIk3pLT5Y
         cIHmSZMG8aF07Rur9yQjG8zjEcKNPZtvBg8Cs=
X-Forwarded-Encrypted: i=1; AJvYcCU/xe09AilmgobvgYD9ynBQf9jrYscQZWqoB+++pz4HwRy3oRd5v560/MgGU1rOauvDmrUe+WE=@vger.kernel.org
X-Received: by 2002:a17:903:4b07:b0:25c:101e:8f04 with SMTP id d9443c01a7336-26813bf16aamr68403885ad.50.1758192084733;
        Thu, 18 Sep 2025 03:41:24 -0700 (PDT)
X-Received: by 2002:a17:903:4b07:b0:25c:101e:8f04 with SMTP id
 d9443c01a7336-26813bf16aamr68403675ad.50.1758192084392; Thu, 18 Sep 2025
 03:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-9-bhargava.marreddy@broadcom.com> <20250916155130.GK224143@horms.kernel.org>
In-Reply-To: <20250916155130.GK224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 16:11:12 +0530
X-Gm-Features: AS18NWBXxQ-XRVIz_9_yMEp0dLlt_TczR64kZc3knMwWoDDMOSdrut_aSwS6y_M
Message-ID: <CANXQDtYdxMq_EAPqu_WvnYqZ5SKW2k139Hwm+jW=kZpSQQgRtQ@mail.gmail.com>
Subject: Re: [v7, net-next 08/10] bng_en: Register rings with the firmware
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 9:21=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:05:03AM +0530, Bhargava Marreddy wrote:
> > Enable ring functionality by registering RX, AGG, TX, CMPL, and
> > NQ rings with the firmware. Initialise the doorbells associated
> > with the rings.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_db.h b/drivers/net=
/ethernet/broadcom/bnge/bnge_db.h
> > new file mode 100644
> > index 00000000000..950ed582f1d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_DB_H_
> > +#define _BNGE_DB_H_
> > +
> > +/* 64-bit doorbell */
> > +#define DBR_EPOCH_SFT                                        24
> > +#define DBR_TOGGLE_SFT                                       25
> > +#define DBR_XID_SFT                                  32
> > +#define DBR_PATH_L2                                  (0x1ULL << 56)
> > +#define DBR_VALID                                    (0x1ULL << 58)
> > +#define DBR_TYPE_SQ                                  (0x0ULL << 60)
> > +#define DBR_TYPE_SRQ                                 (0x2ULL << 60)
> > +#define DBR_TYPE_CQ                                  (0x4ULL << 60)
> > +#define DBR_TYPE_CQ_ARMALL                           (0x6ULL << 60)
> > +#define DBR_TYPE_NQ                                  (0xaULL << 60)
> > +#define DBR_TYPE_NQ_ARM                                      (0xbULL <=
< 60)
> > +#define DBR_TYPE_NQ_MASK                             (0xeULL << 60)
>
> Perhaps BIT_ULL() and GENMASK_ULL() can be used here?

Thanks for the suggestion, Simon. Some macros have non-contiguous
bits, requiring combinations with "|",
which would make the definitions longer and harder to follow. Since
these Doorbell Register (DBR) values
are hardware-specified, I believe it's better to keep them as they
are. Please let me know if you see any issues.

>
> ...

