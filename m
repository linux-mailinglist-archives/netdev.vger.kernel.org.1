Return-Path: <netdev+bounces-115423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E694657E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AD5B22D10
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5315099B;
	Fri,  2 Aug 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/3G9qMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB78120A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635163; cv=none; b=O5rVXQL2QgBIBpWP66HrJU2l5kNRglBXIByLJJrAhNGGX4gNZIDoeUAcYAhlbW8drMZ3CkjwJQk29lzWiq1qqmu22BF+EBjop062JZ0QZo+QnHIM4NXhMLaK1BQ6efmAiksdCIp9fHI0w85nvmR9omyaF/X4SRxTBqVYEDPXASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635163; c=relaxed/simple;
	bh=CLgLwCBQz+SOj2L4A+2atrxYMUduHMBsKzplkUr+idM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKqxs983NbRZYsVrTRrv8sQrxNS8l9J7vAO156m9D/05yf68cHWfvT9153VZs+WOPtMuMo8aGn/EnxYv+vhXV6T1zfrG7uBOvAx8BVRg2X9s6j4/6UkUsqmDY56MCDhQoftOput7bUXCDvEIcpdIJBGAbN5LKvFDhlBtN7Wc6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/3G9qMR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso5929274a91.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722635161; x=1723239961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JU9A3+pkHtkV1/Zl7dIEANXrrOXhOpFpmn/8LwuWvI=;
        b=P/3G9qMR18sDpa7r6qj8GvYo7vI1AggEyP8UqWa7W8+6+3IHeS/cL54jP/aGRPzezh
         FZSSMfQTHPsAAim0bf8ZaT6AffZyTYyWg3mDsrldlu3IxfUb6dnj0GWAUhzUZKbdMRiZ
         JU6MswonsKNqIHlsoREq/TPKtQJvfsyq0ZIf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635161; x=1723239961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JU9A3+pkHtkV1/Zl7dIEANXrrOXhOpFpmn/8LwuWvI=;
        b=anarkYoIyoUIGCGC+F4WZBUCrNVObMyjIbBXrL/eNl8NuNQH6ejKdLidDwVWDtLwQe
         I1w2gRrdsl8GZY/MGDmG0Qjtg72gUAQdn8ODlwJ37SmMEbOaPOPj9dF2qj/hrQsTFveS
         hanFU8WrF2qJlG1Fyk8GE2//+JsJJqfTc4qer4zJAtSxT426IugBGd3WpPxJ5gDsnvdG
         DdOS+xZDmJ3iEx8mKYaaatkTX0XJDTN6cjntZNTU2ZFzz1Ms25ewISkVgZHeX0XjnkDz
         XJpYjkk4frUqjzTqrVZ3bUSBE97Xdl+B0VjnciCgij5KO7RRApDGnx4V5yLXpOjLOdW+
         D/2A==
X-Gm-Message-State: AOJu0YxBz7QVvswXmpRxeoR6Yyv5lkuPF6y1bLflWbHrtONjEgkHR0W3
	9rABGm8anv+d5D61lTTAwyALyqort57kdBpdCDW6kXMqiVad9GHaXQMrSRPh2/B1+RhNmqu3tLA
	CocalU6/JTgEyrmsnffyinvf9ZmtnrX5OQw89
X-Google-Smtp-Source: AGHT+IF40zRRZ4gCavijc3AcIA9p7ICZ/ZbFiiXFymV9WjpQVTokLcCdEOjlLAeEwbQjG/06LFmkIZxUZud2wsOJD7k=
X-Received: by 2002:a17:90a:6387:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2cff9413e04mr6094475a91.18.1722635160975; Fri, 02 Aug 2024
 14:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <20240802143818.GB2504122@kernel.org>
In-Reply-To: <20240802143818.GB2504122@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:45:50 -0700
Message-ID: <CAMdnO-+JBk9X66rzPqWL+1Bf_0kyqnMN9+ikaTp65CfzVmps=g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:38=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Adds support for DWC_xgmac version 4.00a in stmmac core module.
> > This version adds enhancements to DMA architecture for virtualization
> > scalability. This is realized by decoupling physical DMA channels (PDMA=
)
> > from Virtual DMA channels (VDMA). The  VDMAs are software abastractions
> > that map to PDMAs for frame transmission and reception.
> >
> > The virtualization enhancements are currently not being used and hence
> > a fixed mapping of VDMA to PDMA is configured in the init functions.
> > Because of the new init functions, a new instance of struct stmmac_dma_=
ops
> > dwxgmac400_dma_ops is added.
> > Most of the other dma operation functions in existing dwxgamc2_dma.c fi=
le
> > can be reused.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>
> ...
>
> >  stmmac-$(CONFIG_STMMAC_SELFTESTS) +=3D stmmac_selftests.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>
> ...
>
> > @@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops =3D=
 {
> >       .enable_sph =3D dwxgmac2_enable_sph,
> >       .enable_tbs =3D dwxgmac2_enable_tbs,
> >  };
> > +
> > +const struct stmmac_dma_ops dwxgmac400_dma_ops =3D {
> > +     .reset =3D dwxgmac2_dma_reset,
> > +     .init =3D dwxgmac4_dma_init,
> > +     .init_chan =3D dwxgmac2_dma_init_chan,
> > +     .init_rx_chan =3D dwxgmac4_dma_init_rx_chan,
> > +     .init_tx_chan =3D dwxgmac4_dma_init_tx_chan,
> > +     .axi =3D dwxgmac2_dma_axi,
> > +     .dump_regs =3D dwxgmac2_dma_dump_regs,
> > +     .dma_rx_mode =3D dwxgmac2_dma_rx_mode,
> > +     .dma_tx_mode =3D dwxgmac2_dma_tx_mode,
> > +     .enable_dma_irq =3D dwxgmac2_enable_dma_irq,
> > +     .disable_dma_irq =3D dwxgmac2_disable_dma_irq,
> > +     .start_tx =3D dwxgmac2_dma_start_tx,
> > +     .stop_tx =3D dwxgmac2_dma_stop_tx,
> > +     .start_rx =3D dwxgmac2_dma_start_rx,
> > +     .stop_rx =3D dwxgmac2_dma_stop_rx,
> > +     .dma_interrupt =3D dwxgmac2_dma_interrupt,
> > +     .get_hw_feature =3D dwxgmac2_get_hw_feature,
> > +     .rx_watchdog =3D dwxgmac2_rx_watchdog,
> > +     .set_rx_ring_len =3D dwxgmac2_set_rx_ring_len,
> > +     .set_tx_ring_len =3D dwxgmac2_set_tx_ring_len,
> > +     .set_rx_tail_ptr =3D dwxgmac2_set_rx_tail_ptr,
> > +     .set_tx_tail_ptr =3D dwxgmac2_set_tx_tail_ptr,
> > +     .enable_tso =3D dwxgmac2_enable_tso,
> > +     .qmode =3D dwxgmac2_qmode,
> > +     .set_bfsize =3D dwxgmac2_set_bfsize,
> > +     .enable_sph =3D dwxgmac2_enable_sph,
> > +     .enable_tbs =3D dwxgmac2_enable_tbs,
> > +};
>
> Please add dwxgmac400_dma_ops to hwif.h in this patch rather than a
> subsequent one to avoid Sparse suggesting the symbol should be static.
Thanks, I will make the change in the next patch revision.
>
> ...

