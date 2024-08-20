Return-Path: <netdev+bounces-120374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7139590EB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08041C222CF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E71C824F;
	Tue, 20 Aug 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LQCWaqjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E821C8245
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195454; cv=none; b=pmvyzPT6BNLeFrY6yZLI2zZnZzwOZ5K8Ndn357frio8F8WneEgQh3+VS43yxewv5AevGm0gEBcP2I1fz4ooQCEE55v3QkQs9IgZWHrn5/o5t95RVREPR5DTqfVdfOrDXxPEmoiMOnIlX+rlORDNf8+Bd/v3/TdJKaXuqkP01TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195454; c=relaxed/simple;
	bh=XtIk+kD00iSoE4z1imrAKe0aG7GWpS0xE5lCIpWyzeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guYVLPPd9deeE8/7fdncVszmptwBNvmBJCSpK1g7VAdqY4J3KwAfzd7zEA6vIeEx0K6Do/J1fLQFfx6lG9nfeRcfsIeeqAB1yXCIhm8f1n4Pau/v87DgiuEaGv9lRQnP2zRqLQdcf26l8Nmdqzc4g0tOimpqylhTwNXHMnjuJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LQCWaqjW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso4735934a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724195452; x=1724800252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5f2w4LZM4TRAbHrkXGO8wWfBGvh6M9E2Z4iDQZHMiQ=;
        b=LQCWaqjW3jMllS3ufVvAiGnmAc6diNGBEd+xGKCw7FLeDOd9d7V1IPEZVr6deKV2Me
         BnLOnEYsAKh/B3zxoTAi7xYkjmQicJN3VV2xGpXP10lk8fhhPorg6rRfni2MDHcMJVBT
         YL7u/gyIigf4kdvqDFbUpieptzTsgP6vLrwqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195452; x=1724800252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5f2w4LZM4TRAbHrkXGO8wWfBGvh6M9E2Z4iDQZHMiQ=;
        b=cV/ovecfJmY0VdRvC2KQtQEAle/3Z7Pqc7wcMTB9p0b34hDRQJYQIVkFr9bn+8nKWq
         TToaoyjrBgw1HWA7ej6uVRenA2oYonUv2EI5W9GGuDabzI5ITLcbjgJX4GNvlQUndIGz
         9CqdlthV035yqzmegaVMvJJwU6d8LkyFKGOg9reIq4s9SofWYWu6yHxoOmyfXP0zdWAH
         jhb57K2TzHE5UnfhcpFb4Fi9ECtCQMx9jD5hJkqm1WLUXtLrLz0/7o4MqLXduQMlUfav
         42prKXKxfr3AUBbSgg/r6CqiblsHouXkSN1OyjSvkTD0dmIoAokm44vU28Qe7t1GMj5Y
         t+Zw==
X-Gm-Message-State: AOJu0Yx2JNi9Vx0mvUHIQ8qRBjRuWkB0DzpFMkl6teGwdCH3E64QVVK9
	4+DNux9CZDoLXc+omsIGZ+MZLoMZ5ChSYwaCe6GHHvPK7EhDSAMmB3HdzRZ5ZWd609eXQIIr3LW
	rVj9AIviLD0UzI8froXxUiO4NwwdriLckFFYH
X-Google-Smtp-Source: AGHT+IFGNMXXmYcdXaQzr5Tz8USVmNU5xbNdMKeKaadN4lTbxlZnVc1egcdct5/lyGa8CAVi5X81ldwsfwop3kkiM1o=
X-Received: by 2002:a17:90b:23d3:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d5e9ed08f1mr498981a91.39.1724195452084; Tue, 20 Aug 2024
 16:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-2-jitendra.vegiraju@broadcom.com> <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
In-Reply-To: <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Tue, 20 Aug 2024 16:10:40 -0700
Message-ID: <CAMdnO-LH0xNeMO_Y+WhSmbyNrK33zb=AtVd9ZRTObQ-n8BWR6w@mail.gmail.com>
Subject: Re: [net-next v4 1/5] net: stmmac: Add HDMA mapping for dw25gmac support
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:30=E2=80=AFPM Abhishek Chauhan (ABC)
<quic_abchauha@quicinc.com> wrote:
>
>
>
> On 8/14/2024 3:18 PM, jitendra.vegiraju@broadcom.com wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Add hdma configuration support in include/linux/stmmac.h file.
> > The hdma configuration includes mapping of virtual DMAs to physical DMA=
s.
> > Define a new data structure stmmac_hdma_cfg to provide the mapping.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  include/linux/stmmac.h | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 338991c08f00..1775bd2b7c14 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -89,6 +89,55 @@ struct stmmac_mdio_bus_data {
> >       bool needs_reset;
> >  };
> >
> > +/* DW25GMAC Hyper-DMA Overview
> > + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
> > + * channels using a smaller set of physical DMA channels(PDMA).
> > + * This is supported by the  mapping of VDMAs to Traffic Class (TC)
> > + * and PDMA to TC in each traffic direction as shown below.
> > + *
> > + *        VDMAs            Traffic Class      PDMA
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
> > + *TX     +--------+   |----->+------+         +-----------+
> > + *Host=3D> +--------+   |      +------+         +-----------+ =3D> MAC
> > + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
> > + *       +--------+          +------+    |    +-----------+
> > + *       +--------+          +------+----+    +-----------+
> > + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
> > + *       +--------+          +------+         +-----------+
> > + *            .                 .                 .
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
> > + *       +--------+          +------+         +-----------+
> > + *
> > + *       +------+          +------+         +------+
> > + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
> > + *       +------+   |----->+------+         +------+
> > + *MAC =3D> +------+   |      +------+         +------+
> > + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  =3D> Host
> > + *       +------+          +------+    |    +------+
> > + *            .                 .                 .
> > + */
> > +
> > +#define STMMAC_DW25GMAC_MAX_NUM_TX_VDMA              128
> > +#define STMMAC_DW25GMAC_MAX_NUM_RX_VDMA              128
> > +
> > +#define STMMAC_DW25GMAC_MAX_NUM_TX_PDMA              8
> > +#define STMMAC_DW25GMAC_MAX_NUM_RX_PDMA              10
> > +
> I have a query here.
>
> Why do we need to hardcode the number of TX PDMA and RX PDMA to 8 an 10. =
On some platforms the number of supported TXPDMA and RXPDMA are 11 and 11 r=
espectively ?
>
> how do we overcome this problem, do we increase the value in such case?
>
Hi Abhishek,
Agreed, we can make the mapping tables more generic.
We will replace static arrays with dynamically allocated memory by
reading the TXPDMA and RXPDMA counts from hardware.
Thanks
> > +#define STMMAC_DW25GMAC_MAX_TC                       8
> > +
> > +/* Hyper-DMA mapping configuration
> > + * Traffic Class associated with each VDMA/PDMA mapping
> > + * is stored in corresponding array entry.
> > + */
> > +struct stmmac_hdma_cfg {
> > +     u8 tvdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_VDMA];
> > +     u8 rvdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_VDMA];
> > +     u8 tpdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_PDMA];
> > +     u8 rpdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_PDMA];
> > +};
> > +
> >  struct stmmac_dma_cfg {
> >       int pbl;
> >       int txpbl;
> > @@ -101,6 +150,7 @@ struct stmmac_dma_cfg {
> >       bool multi_msi_en;
> >       bool dche;
> >       bool atds;
> > +     struct stmmac_hdma_cfg *hdma_cfg;
> >  };
> >
> >  #define AXI_BLEN     7

