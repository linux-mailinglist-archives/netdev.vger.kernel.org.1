Return-Path: <netdev+bounces-30448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE8787569
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E00281647
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47430125A7;
	Thu, 24 Aug 2023 16:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748A156E3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:32:56 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46712E77;
	Thu, 24 Aug 2023 09:32:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7751FF805;
	Thu, 24 Aug 2023 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692894771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsZa7pZKZNbOWTMTAuaVYbIB0/GSiNJq7wZvQfer+ls=;
	b=nFqLNEvPxHjcfURhNwgVrXak5QCYFYuY/xVoa2IdayasepT7+bAW6cycLkh5qxW2v/blqb
	tIm3mQ5Vd8ytwAOyuhV3ZZOGkBO2OUcbGr1ZxCrLKW+ptuNJt4wNaLv3Xiq43vbcUs4q7h
	vfD5hXaYwMqEzhVXe+iOUgiiyYBTQr5qnIFUytGfxXFyG5bPC9G49VMll2D7OxAI1LWeVR
	PjTqnx2eyDwQWulJUtPAco2jbccZtAXUjq6YsfYQFfCqo/PvOaqu9s7dedj24KU02U8dGc
	5/DxtsUwOk7cg6s2XKm6BNMJ58dM27YmcBy9wLVI0DkEMhSL4xig+IzZEYRZzw==
Date: Thu, 24 Aug 2023 18:32:45 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 20/28] wan: qmc_hdlc: Add runtime timeslots changes
 support
Message-ID: <20230824183245.26bea22a@bootlin.com>
In-Reply-To: <cbdcf645-f473-f10c-a76e-feb6316d2a47@wanadoo.fr>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
	<1364a0742fc76e7d275273dbbc4c97b008ec70a5.1692376361.git.christophe.leroy@csgroup.eu>
	<cbdcf645-f473-f10c-a76e-feb6316d2a47@wanadoo.fr>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christophe,

On Mon, 21 Aug 2023 07:40:26 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 18/08/2023 à 18:39, Christophe Leroy a écrit :
> > From: Herve Codina <herve.codina@bootlin.com>
> > 
> > QMC channels support runtime timeslots changes but nothing is done at
> > the QMC HDLC driver to handle these changes.
> > 
> > Use existing IFACE ioctl in order to configure the timeslots to use.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---  
> 
> Hi,
> 
> a few nits below, should there be a v5.
> 
> >   drivers/net/wan/fsl_qmc_hdlc.c | 169 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 168 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
> > index 4f84ac5fc63e..4b8cb5761fd1 100644
> > --- a/drivers/net/wan/fsl_qmc_hdlc.c
> > +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> > @@ -32,6 +32,7 @@ struct qmc_hdlc {
> >   	struct qmc_hdlc_desc tx_descs[8];
> >   	unsigned int tx_out;
> >   	struct qmc_hdlc_desc rx_descs[4];
> > +	u32 slot_map;
> >   };
> >   
> >   static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> > @@ -202,6 +203,162 @@ static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
> >   	return NETDEV_TX_OK;
> >   }
> >   
> > +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> > +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> > +{
> > +	u64 ts_mask_avail;
> > +	unsigned int bit;
> > +	unsigned int i;
> > +	u64 ts_mask;
> > +	u64 map = 0;  
> 
> This init looks useless.

Will be removed in the next iteration.

> 
> > +
> > +	/* Tx and Rx masks must be identical */
> > +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> > +	ts_mask = 0;
> > +	map = slot_map;
> > +	bit = 0;
> > +	for (i = 0; i < 64; i++) {
> > +		if (ts_mask_avail & BIT_ULL(i)) {
> > +			if (map & BIT_ULL(bit))
> > +				ts_mask |= BIT_ULL(i);
> > +			bit++;
> > +		}
> > +	}
> > +
> > +	if (hweight64(ts_mask) != hweight64(map)) {
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots 0x%llx -> (0x%llx,0x%llx)\n",
> > +			map, ts_mask_avail, ts_mask);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_info->tx_ts_mask = ts_mask;
> > +	ts_info->rx_ts_mask = ts_mask;
> > +	return 0;
> > +}
> > +
> > +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> > +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
> > +{
> > +	u64 ts_mask_avail;
> > +	unsigned int bit;
> > +	unsigned int i;
> > +	u64 ts_mask;
> > +	u64 map = 0;  
> 
> This init looks useless.

Will be remove in the next iteration.

> 
> > +
> > +	/* Tx and Rx masks must be identical */
> > +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> > +		return -EINVAL;
> > +	}
> > +	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> > +	ts_mask = ts_info->rx_ts_mask;
> > +	map = 0;
> > +	bit = 0;
> > +	for (i = 0; i < 64; i++) {
> > +		if (ts_mask_avail & BIT_ULL(i)) {
> > +			if (ts_mask & BIT_ULL(i))
> > +				map |= BIT_ULL(bit);
> > +			bit++;
> > +		}
> > +	}
> > +
> > +	if (hweight64(ts_mask) != hweight64(map)) {
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (0x%llx,0x%llx) -> 0x%llx\n",
> > +			ts_mask_avail, ts_mask, map);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (map >= BIT_ULL(32)) {
> > +		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (0x%llx,0x%llx) -> 0x%llx\n",
> > +			ts_mask_avail, ts_mask, map);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*slot_map = map;
> > +	return 0;
> > +}  
> 
> ...
> 
> > +static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
> > +{
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	te1_settings te1;
> > +
> > +	switch (ifs->type) {
> > +	case IF_GET_IFACE:
> > +		ifs->type = IF_IFACE_E1;
> > +		if (ifs->size < sizeof(te1)) {
> > +			if (!ifs->size)
> > +				return 0; /* only type requested */
> > +
> > +			ifs->size = sizeof(te1); /* data size wanted */
> > +			return -ENOBUFS;
> > +		}
> > +
> > +		memset(&te1, 0, sizeof(te1));
> > +
> > +		/* Update slot_map */
> > +		te1.slot_map = qmc_hdlc->slot_map;
> > +
> > +		if (copy_to_user(ifs->ifs_ifsu.te1, &te1,  sizeof(te1)))  
> 
>                                                           ~~
> Extra space.

Will be fixed in the next iteration.

> 
> > +			return -EFAULT;
> > +		return 0;
> > +
> > +	case IF_IFACE_E1:
> > +	case IF_IFACE_T1:
> > +		if (!capable(CAP_NET_ADMIN))
> > +			return -EPERM;
> > +
> > +		if (netdev->flags & IFF_UP)
> > +			return -EBUSY;
> > +
> > +		if (copy_from_user(&te1, ifs->ifs_ifsu.te1, sizeof(te1)))
> > +			return -EFAULT;
> > +
> > +		return qmc_hdlc_set_iface(qmc_hdlc, ifs->type, &te1);
> > +
> > +	default:
> > +		return hdlc_ioctl(netdev, ifs);
> > +	}
> > +}  
> 
> ...
> 

Thanks for the review,
Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

