Return-Path: <netdev+bounces-51270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBF7F9EA0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4618FB20D7C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C91A27C;
	Mon, 27 Nov 2023 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8RrZ4lP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E910A
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:32:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c897ba4057so49200671fa.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701084756; x=1701689556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7OSBy3ds1uj4pC4OX5qkf39ZZikExw7hhktBM5V9i0=;
        b=j8RrZ4lPG2dvwIx8Bz6kM8uYwtE1N+uifn6NSB9YfB6lxviepYrj5vqsqUaKrcHO47
         qVeVqbeqSuUqz+DakKxmAuSmu9xmfh7lY7eRHdQyJ/ksLNVeNH4qy/tEHJ3XqlmnSK+s
         Sz9IZufQO2AutC309ZNgMg7xA5+6Zbay6iINoJBE1qbidRNpTTetOMJGFeGDTe/Ztx0V
         EzsmYKxVQPWr9HnuNQMyjl+alYBRFjDO/+Ls25lxYXYO3cTgxWaJRhjeDDyfOK4zstLX
         xyw/F890KMh226FzdRRQNuusXjWveYVsi9Mg6JNpk/FZM83WpTswMgeF/7qjMhuFbApg
         KGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701084756; x=1701689556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7OSBy3ds1uj4pC4OX5qkf39ZZikExw7hhktBM5V9i0=;
        b=xEwXp9gUk1BiISZPneQ6wABr0g7sQV53WSI7bLo7AVcpT8h4efl0Rl6iSlKDY6uBpm
         dFAHO7pf1vVShRTRgH96jh/JfVnT9huh+2VMTTuK4HP4kY6rO9BaXYOxu8E7+7wxl6Su
         Y5qNkWW6u4nGbFkm4U5lGJRy+hAhJ0JZAjiEKOmne0OaKbZAPgh6W2mXRZSKcWwpQgMD
         bMC/klNjEjSsZTK2Euv60pnQYPt+15xp88aHd9iInvccugfTFNpxVtGSB+4zdGbufRHc
         nfunPgoQLaFlBGIFyQNzVM+9YBFUXm9SaiFMAPQxLZk53xBfQzA5UYPfZOuXNh/TA7Lw
         MPNg==
X-Gm-Message-State: AOJu0Yz5hmleVBpvWgd1ALD4calQ470HBcKQDeqv07XTPdiDTHzr6vTx
	kSZ/mPYKsLbzWGQKJF+0k94=
X-Google-Smtp-Source: AGHT+IHh5skc13rlT81IBrOX4l27eg3nZ6uS9+zPvlQKXzOjQxJPUZimOnpqL78RUvvjWwsxJwzrYA==
X-Received: by 2002:a2e:6e16:0:b0:2c5:80d:53b1 with SMTP id j22-20020a2e6e16000000b002c5080d53b1mr8777784ljc.43.1701084755854;
        Mon, 27 Nov 2023 03:32:35 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a25-20020a2eb559000000b002c88bbac093sm1314705ljn.63.2023.11.27.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:32:35 -0800 (PST)
Date: Mon, 27 Nov 2023 14:32:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk, 
	dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <gbwyupdmey4qiabqtpkqryufsme3dx5wxs3gp3snamijfkzyda@7r2av5z7szs6>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
 <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>
 <7dde9b88-8dc5-4a35-a6e3-c56cf673e66d@lunn.ch>
 <3amgiylsqdngted6tts6msman54nws3jxvkuq2kcasdqfa5d7j@kxxitnckw2gp>
 <4f9a4d75-7052-4314-bbd1-838a642b80ab@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f9a4d75-7052-4314-bbd1-838a642b80ab@loongson.cn>

Yanteng

On Sun, Nov 26, 2023 at 08:25:13PM +0800, Yanteng Si wrote:
> 
> 在 2023/11/25 00:44, Serge Semin 写道:
> > On Fri, Nov 24, 2023 at 03:51:08PM +0100, Andrew Lunn wrote:
> > > > In general, we split one into two.
> > > > 
> > > > the details are as follows：
> > > > 
> > > > DMA_INTR_ENA_NIE = DMA_INTR_ENA_NIE_LOONGSON= DMA_INTR_ENA_TX_NIE +
> > > > DMA_INTR_ENA_RX_NIE
> > > What does the documentation from Synopsys say about the bit you have
> > > used for DMA_INTR_ENA_NIE_LOONGSON? Is it marked as being usable by IP
> > > integrators for whatever they want, or is it marked as reserved?
> > > 
> > > I'm just wondering if we are heading towards a problem when the next
> > > version of this IP assigns the bit to mean something else.
> > That's what I started to figure out in my initial message:
> > Link: https://lore.kernel.org/netdev/gxods3yclaqkrud6jxhvcjm67vfp5zmuoxjlr6llcddny7zwsr@473g74uk36xn/
> > but Yanteng for some reason ignored all my comments.
> 
> Sorry, I always keep your review comments in mind, and even this version of
> the patch is
> 
> largely based on your previous comments. Please give me some more time and I
> promise
> 
> to answer your comments before the next patch is made.
> 
> > 
> > Anyway AFAICS this Loongson GMAC has NIE and AIE flags defined differently:
> > DW GMAC: NIE - BIT(16) - all non-fatal Tx and Rx errors,
> >           AIE - BIT(15) - all fatal Tx, Rx and Bus errors.
> > Loongson GMAC: NIE - BIT(18) | BIT(17) - one flag for Tx and another for Rx errors.
> >                 AIE - BIT(16) | BIT(15) - Tx, Rx and don't know about the Bus errors.
> > So the Loongson GMAC has not only NIE/AIE flags re-defined, but
> > also get to occupy two reserved in the generic DW GMAC bits: BIT(18) and BIT(17).
> > 
> > Moreover Yanteng in his patch defines DMA_INTR_NORMAL as a combination
> > of both _generic_ DW and Loongson-specific NIE flags and
> > DMA_INTR_ABNORMAL as a combination of both _generic_ DW and
> > Loongson-specific AIE flags. At the very least it doesn't look
> > correct, since _generic_ DW GMAC NIE flag BIT(16) is defined as a part
> > of the Loongson GMAC AIE flags set.
> 
> We will consider this seriously, please give us some more time, and of
> course, we
> 
> are looking forward to your opinions on this problem.
> 
> 
> I hope you can accept my apologies, Please allow me to say sorry again.

Thanks for your response. No worries. I keep following this thread and
sending my comments because the changes here deeply concerns our
hardware. Besides the driver already looks unreasonably
overcomplicated and weakly structured in a lot of aspects. I bet
nobody here wants it to be having even more clumsy parts. That's why
all the "irritating" comments and nitpicks.

Anyway regarding the Loongson Multi-channels GMAC IRQs based on all
your info in the previous replies I guess what could be an acceptable
solution (with the subsystem/driver maintainers blessing) is something
like this:

1. Add new platform feature flag:
include/linux/stmmac.h:
+#define STMMAC_FLAG_HAS_LSMC			BIT(13)

2. Update the stmmac_dma_ops.init() callback prototype to accepting
a pointer to the stmmac_priv instance:
drivers/net/ethernet/stmicro/stmmac/hwif.h:
	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
		     struct stmmac_dma_cfg *dma_cfg, int atds);
+drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c ...
+drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c ...
+drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c ...
+drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c ...
!!!+drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c ...

3. Add the IRQs macros specific to the LoongSon Multi-channels GMAC:
drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
+#define DMA_INTR_ENA_LS_NIE 0x00060000	/* Normal Loongson Tx/Rx Summary */
#define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
...

+#define DMA_INTR_LS_NORMAL	(DMA_INTR_ENA_LS_NIE | DMA_INTR_ENA_RIE | \
				DMA_INTR_ENA_TIE)
#define DMA_INTR_NORMAL		(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
				DMA_INTR_ENA_TIE)
...
+#define DMA_INTR_ENA_LS_AIE 0x00018000	/* Abnormal Loongson Tx/Rx Summary */
#define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
...
define DMA_INTR_LS_ABNORMAL	(DMA_INTR_ENA_LS_AIE | DMA_INTR_ENA_FBE | \
				DMA_INTR_ENA_UNE)
#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
				DMA_INTR_ENA_UNE)
...
#define DMA_INTR_LS_DEFAULT_MASK	(DMA_INTR_LS_NORMAL | DMA_INTR_LS_ABNORMAL)
#define DMA_INTR_DEFAULT_MASK		(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)

etc for the DMA_STATUS_TX_*, DMA_STATUS_RX_* macros.

4. Update the DW GMAC DMA init() method to be activating all the
Normal and Abnormal Loongson-specific IRQs:
drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:
	if (priv->plat->flags & STMMAC_FLAG_HAS_LSMC)
		writel(DMA_INTR_LS_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
	else
		writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);

5. Make sure your low-level driver sets the STMMAC_FLAG_HAS_LSMC flag
in the plat_stmmacenet_data structure instance.

Note 1. For the sake of consistency a similar update can be provided
for the dwmac_enable_dma_irq()/dwmac_disable_dma_irq() methods and
the DMA_INTR_DEFAULT_RX/DMA_INTR_DEFAULT_TX macros seeing your device
is able to disable/enable the xfer-specific summary IRQs. But it
doesn't look like required seeing the driver won't raise the summary
IRQs if no respective xfer IRQ is enabled. Most importantly this
update would add additional code to the Tx/Rx paths, which in a tiny
bit measure may affect the other platforms perf. So it's better to
avoid it if possible.

Note 2. The STMMAC_FLAG_HAS_LSMC flag might be utilized to tweak up
the other generic parts of the STMMAC driver.

Noet 3. An alternative to the step 3 above could be to define two
additional plat_stmmacenet_data fields like: dma_def_intr_mask,
dma_nor_stat, dma_abnor_stat, which would be initialized in the
stmmac_probe() method with the currently defined
DMA_INTR_DEFAULT_MASK, DMA_NOR_INTR_STATUS and DMA_ABNOR_INTR_STATUS
macros if they haven't been initialized by the low-level drivers.
These fields could be then used in the respective DMA IRQ init and
handler methods. I don't know which solution is better. At the first
glance this one might be even better than what is described in step 3.

Note 4. The solution above will also cover the Andrew's note of having
the kernel which runs on all possible variants.

-Serge(y)

> 
> 
> Thanks for your review!
> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > > 	Andrew
> 

