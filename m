Return-Path: <netdev+bounces-13730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6DE73CC8B
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146572811B6
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE56FDE;
	Sat, 24 Jun 2023 19:26:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8B3C3C
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 19:26:45 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F07EA;
	Sat, 24 Jun 2023 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UnhCsxti4Kmc4ZZZ2TxRZ9Y2VLPFx3yNPFmbrJP3yBQ=; b=Law8fp0efH0cWdGx0CzpWd4o5j
	EL7+q7d6IFAG6eynHh8yfj09hFjLHG0du9uxL0ZRiSf/hazwTO132dgYLiZ6uw22Ge2jgJ2WlgYHC
	+4gXFzUjdC73+uFoJDHrfUnktrgIIC2u93uNBXLek1jW5XNNxfnK8USV7/aYc6vz/Hys=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qD8u0-00HRZF-1T; Sat, 24 Jun 2023 21:26:32 +0200
Date: Sat, 24 Jun 2023 21:26:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH v2 06/13] net: phy: nxp-c45-tja11xx: use get_features
Message-ID: <6655fb6a-0b28-4eb7-a5f1-9a74be3318e3@lunn.ch>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
 <20230623074123.152931-7-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623074123.152931-7-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 10:41:16AM +0300, Radu Pirea (NXP OSS) wrote:
> PHY_BASIC_T1_FEATURES are not the right features supported by TJA1103
> anymore.
> For example ethtool reports:
> 	[root@alarm ~]# ethtool end0
> 	Settings for end0:
> 	        Supported ports: [ TP ]
> 	        Supported link modes:   100baseT1/Full
> 	                                10baseT1L/Full
> 
> 10baseT1L/Full is not supported by TJA1103 and supported ports list is
> not completed. The PHY also have a MII port.
> 
> genphy_c45_pma_read_abilities implementation can detect the PHY features
> and they look like this.
> [root@alarm ~]# ethtool end0
> Settings for end0:
>         Supported ports: [ TP    MII ]
>         Supported link modes:   100baseT1/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  100baseT1/Full
>         Advertised pause frame use: Symmetric
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 100Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         master-slave cfg: forced master
>         master-slave status: master
>         Port: Twisted Pair
>         PHYAD: 1
>         Transceiver: external
>         MDI-X: Unknown
>         Supports Wake-on: g
>         Wake-on: d
>         Link detected: yes
>         SQI: 7/7
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

