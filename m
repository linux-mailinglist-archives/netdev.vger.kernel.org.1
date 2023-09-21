Return-Path: <netdev+bounces-35521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941F7A9C1F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000E01C20A5F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2142C0B;
	Thu, 21 Sep 2023 18:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737E41E5A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F8AF95C;
	Thu, 21 Sep 2023 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZcZ6CvS508r428h2XRFuIkYdLum6Ry+D8UPk9663CHc=; b=KV924Ig6YmYwVQ7iLK5PibHLuv
	8L+EQdN/eVu9JmB+e6x1uTdtJy58t9qTdEm8pI6JBorWubxwzIZHT9pa03LPTxXkY5f6Jv9q1gVa3
	aBs6DfDiLXgkvGVWjxTfYX9bsGY9iNFAOKqMyUnMaTK18/2Cvf1WrpgKZGw21wkxnaF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qjMbP-0076ay-2H; Thu, 21 Sep 2023 18:32:31 +0200
Date: Thu, 21 Sep 2023 18:32:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, vladimir.oltean@nxp.com,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <c0ec8d22-534b-4962-b5b2-ff6391b32b1b@lunn.ch>
References: <20230921070031.795788-1-danishanwar@ti.com>
 <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +	if (!netif_running(ndev)) {
> > +		netdev_err(ndev, "interface is down, link speed unknown\n");
> > +		return -ENETDOWN;
> > +	}
> 
> Do we really need this?

The error message suggests it is wrong anyway. netif_running() being
true means it is admin up. But the carrier might be down, and so the
link speed is unknown. So maybe this should be using netif_carrier_ok() ?

     Andrew

