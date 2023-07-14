Return-Path: <netdev+bounces-17950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462E753BCC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353CF1C215E5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30803749E;
	Fri, 14 Jul 2023 13:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FEBDDB4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:28:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7030F4;
	Fri, 14 Jul 2023 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/ECHFNZrgtTJV8ui4hGBa7LqmL4xWtdtw95/EPxl764=; b=3o/D3zjVAqE8MJJ2RANnv4DmYS
	bdANk8Y9bMdmx5NrfSV9tumNfr7UWOkpWwhnSVqvgzjAhjud4Yh7v64modEbmzx5COSTau4BdSiIC
	zqLBQ0pQVfP6cWSjpz6+w5Zt0pbE4nrs9dpNxZr7YsozR+Io/d2hzHd3+PZvJfnP4TEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKIqL-001M7e-VJ; Fri, 14 Jul 2023 15:28:21 +0200
Date: Fri, 14 Jul 2023 15:28:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <570d32ad-e475-4a0b-a6ee-a2bdf5f67b69@lunn.ch>
References: <20230714114717.18921-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714114717.18921-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int mv88e6390x_serdes_erratum_3_14(struct mv88e6xxx_chip *chip)
> +{
> +	int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
> +		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
> +		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
> +		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };

Please make this const. Otherwise you end up with two copies of it.

> +	int err, i;
> +
> +	/* 88e6390x-88e6190x errata 3.14:
> +	 * After chip reset, SERDES reconfiguration or SERDES core
> +	 * Software Reset, the SERDES lanes may not be properly aligned
> +	 * resulting in CRC errors
> +	 */
> +
> +	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
> +		err = mv88e6390_serdes_write(chip, lanes[i],
> +					     MDIO_MMD_PHYXS,
> +					     0xf054, 0x400C);

Does Marvell give this register a name? If so, please add a #define.
Are the bits in the register documented?

> +	if (!err && up) {
> +		if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X ||
> +		    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X)

6191X? 6193X? 

Please sort these into numerical order.


    Andrew

---
pw-bot: cr

