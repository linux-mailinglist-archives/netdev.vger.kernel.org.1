Return-Path: <netdev+bounces-31936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D379194B
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D035280F35
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5BFBA42;
	Mon,  4 Sep 2023 14:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3215AB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 14:02:34 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4699CD7;
	Mon,  4 Sep 2023 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iA9dWLzNwmWgeVruKfWYQm9/Fv8+bNUF3EphUHboovM=; b=J/6wblO2pMDEzIC/YsObv6CEKC
	pefWd2u72eNAJUyYSlk71pPSSmj989fSEAAaSScqLgjSolpfXoTRw0Jy/WmZwvaXnOfhzetzRYcRe
	6KhV0Py7LNNKETCrilj3wV4PGA1pZuDUvZhKoWdZyvGJJ3Y1s/EPd1+WDbPjlcqCbOBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdA9m-005kBI-9E; Mon, 04 Sep 2023 16:02:22 +0200
Date: Mon, 4 Sep 2023 16:02:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	r-gunasekaran@ti.com
Subject: Re: [RFC PATCH net-next 1/4] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Message-ID: <edfbaf8e-16df-4a25-8647-79b8730dca08@lunn.ch>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110847.1219515-2-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
> +		       struct mgmt_cmd_rsp *rsp)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +	int i = 10000;
> +	int addr;
> +
> +	addr = icssg_queue_pop(prueth, slice == 0 ?
> +			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
> +	if (addr < 0)
> +		return addr;
> +
> +	/* First 4 bytes have FW owned buffer linking info which should
> +	 * not be touched
> +	 */
> +	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
> +	icssg_queue_push(prueth, slice == 0 ?
> +			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
> +	while (i--) {
> +		addr = icssg_queue_pop(prueth, slice == 0 ?
> +				       ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
> +		if (addr < 0) {
> +			usleep_range(1000, 2000);
> +			continue;
> +		}

Please try to make use of include/linux/iopoll.h.

> +	if (i <= 0) {
> +		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
> +		return -EINVAL;

Using iopoll.h will fix this, but -ETIMEDOUT, not -EINVAL.

      Andrew

