Return-Path: <netdev+bounces-41438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BD7CAF2F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182792813F9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4F30D1E;
	Mon, 16 Oct 2023 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0H5vCEwn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13427EFB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:28:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789111B;
	Mon, 16 Oct 2023 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qn8pjkyvMjlHnGF7bvQJKDrfyyM9Efa1/JCaDoN/WGs=; b=0H5vCEwnQj/P2x0kDiHQc87Ppv
	2+L/CGodNbhCTiYpl7byMQr4Ilz5dRxiH2pCw++3q3SYJbhBRL56w5XM+0gwndVoepmS7acekr4U9
	KG6gEON5so1BqUJQWPG8jGHRsxDwRgOORhVa+8yKQC6w90fOh2QNRWd69IdCSFsnodxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qsQRz-002Mgn-VL; Mon, 16 Oct 2023 18:28:15 +0200
Date: Mon, 16 Oct 2023 18:28:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Message-ID: <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
References: <20231016161525.1695795-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016161525.1695795-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 09:45:25PM +0530, MD Danish Anwar wrote:
> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
> in the ICSSG firmware REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.
> 
> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
> EMAC_PORT_FORWARD commands doesn not work.
> Update r30 commands to use the same bitmask as used by the ICSSG firmware
> REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.
> 
> These bitmasks are not backwards compatible. This will work with
> firmware version REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05 and above but
> not with lower firmware versions.

Breaking backwards compatibility is generally not allowed.

As far as i understand the driver, it loads whatever version of
firmware is available. It does not ask for a specific version. So you
should ask the firmware what version it is, and then handle the
bitmask as appropriate.

How many different versions of REL.PRU-ICSS-ETHERNET-SWITCH have been
released? They don't appear to be part of linux-firmware.git :-(

    Andrew

---
pw-bot: cr

