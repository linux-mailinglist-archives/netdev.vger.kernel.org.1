Return-Path: <netdev+bounces-17512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDB751D95
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B9281CBC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12807100DA;
	Thu, 13 Jul 2023 09:42:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327B100D6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:42:45 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680330E2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:42:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992b66e5affso79715166b.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689241334; x=1691833334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKiW2pF15hMHCaDxQaIgbd1AvnmLAavLr0qvJQpEsic=;
        b=g7tQfQuZFH7I4trabZSATPW2027Fd+86PAdU0VFIufgdgo0EV+4Z6qpfCtMZE4lesj
         s23DZIeifJv9auCmJKgljmPxGR+eTiplBDHnPLbAolQ+gOWYyaX6rtBrXauRG7moP5Ja
         Q26Qz6IXoBJXAEf80/ZWkt9rKv5f5d3h0yjc2h3Gbjqd4mr5XgLzxYoG+TUv1xHsDmeo
         dhE1IizRiY1ldq7znEzbkjIAuOZxUF5G0dg40iAj2ZHEL+Mi0fdvg6M63ccJnXaD/z/U
         3lUph/ze8UIBF18KOTkmaObVuNokhXOLz/s5HZFlOB6ISjufrtN1x6AlwFZ2Pl6VpjTF
         W52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241334; x=1691833334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKiW2pF15hMHCaDxQaIgbd1AvnmLAavLr0qvJQpEsic=;
        b=CJw5/SsfqU+PzjQkiHcJQ0GSdh6JMOMUTZMP0GSodCqGHQoYIFTBFoLg9J8ZEIwheh
         ngW4sP3ZFlTnc1n8JMOLwLwsZhURMGgGpF6Ixyh5kHSw08yCTqaqYgYYfAGQXrILvVWD
         CP9Uc6/ZYcJw5Y/ST6d4HiMEBcjgfk83hu7i1qed4orcYDTHW+GsXnkaeJFOPpksQVs7
         jjVT2P4c061uWSFdWRasIgV50ZIAOkrx7h5VyzNSPr+EAnUIYN19DCV11aQPD/bTJflt
         sxoFKH3pYwm0XL981BzTK3Fb5hbGKvkM4gEAx7c1mghYFKrJrzksx3LqNfMCTCUJVNX5
         9B3Q==
X-Gm-Message-State: ABy/qLZWYuq+Aik75Ju5I3ge40MVOn3XsiIJRl/zlRsRqeq6/y4RO/LT
	WGBoYkINVibFZanDabbu6LQ=
X-Google-Smtp-Source: APBJJlEX2iQausZX29mW/C9QDnafU3HDQk8ZHQlPHekWVnjs+5x+vQt4KzeF0/+K7mC4cbTQyhz3LQ==
X-Received: by 2002:a17:906:2091:b0:987:6372:c31f with SMTP id 17-20020a170906209100b009876372c31fmr978510ejq.37.1689241333969;
        Thu, 13 Jul 2023 02:42:13 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:9d33:114d:9337:5e4d])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906140b00b0099297782aa9sm3694996ejc.49.2023.07.13.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:42:13 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:42:12 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZK/G9FMPSabQCGNk@eichest-laptop>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-5-eichest@gmail.com>
 <2de0a6e1-0946-4d4f-8e57-1406a437b94e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de0a6e1-0946-4d4f-8e57-1406a437b94e@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

Thanks a lot for the review and all the hints, I have one short question
below.

> > +static int mv88q2xxx_read_link(struct phy_device *phydev)
> > +{
> > +	u16 ret1, ret2;
> > +
> > +	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
> > +	 * therefore we need to read the link status from the vendor specific
> > +	 * registers.
> > +	 */
> > +	if (phydev->speed == SPEED_1000) {
> > +		/* Read twice to clear the latched status */
> > +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> > +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> 
> This is generally wrong. See for example genphy_update_link() and
> genphy_c45_read_link().
> 

Would something like this look fine to you? The issue is that I mix
realtime data with latched data because the local and remote rx status
is only available in realtime from what I can find in the datasheet.
This would be for gbit, I split that up compared to the last version:

static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
{
	int ret1, ret2;

	/* The link state is latched low so that momentary link drops can be
	 * detected. Do not double-read the status in polling mode to detect
	 * such short link drops except the link was already down. In case we
	 * are not polling, we always read the realtime status.
	 */
	if (!phy_polling_mode(phydev) || !phydev->link) {
		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
		if (ret1 < 0)
			return ret1;
	}

	ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
	if (ret1 < 0)
		return ret1;

	/* Read vendor specific Auto-Negotiation status register to get local
	 * and remote receiver status according to software initialization
	 * guide.
	 */
	ret2 = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STATUS);
	if (ret2 < 0)
		return ret2;

	/* Check if we have link and if the remote and local receiver are ok */
	return (ret1 & MDIO_PCS_1000BT1_STAT_LINK) &&
	       (ret2 & MDIO_MMD_AN_MV_STATUS_LOCAL_RX) &&
	       (ret2 & MDIO_MMD_AN_MV_STATUS_REMOTE_RX);
}

With this we will detect link loss in polling mode and read the realtime
status in non-polling mode. Compared to genphy_c45_read_link we will not
immediately return "link up" in non polling mode but always do the
second read to get the realtime link status.

If we are only interested in the link status we could also skip the
remote and local receiver check. However, as I understand the software
initialization guide it could be that the receivers are not ready in
that moment.

Regards,
Stefan

