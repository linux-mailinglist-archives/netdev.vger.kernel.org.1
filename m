Return-Path: <netdev+bounces-32276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F43793CD9
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899F0280DCE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CA8485;
	Wed,  6 Sep 2023 12:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B61368
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 12:39:45 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734B173F;
	Wed,  6 Sep 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xb9J4LP3xZ2oCJfCq0aBcb0/gSpvzJwkl3eC5fo8Ixw=; b=wCTDDvJsjAgurjMV1TTkETRul3
	bt+Rb+7CCIOZv3qLD75tcy03T6a64UzqtcVwKUMlppDnJW+WF7hG6rWHYI3jBhGDexZ3pDOb/X6vO
	nO/sNhTrZ1s466RjBDwf+p6uY8L8TW6+zhfQsYKwz2qxmrdPmNMvhSgT/ILGi0Wc/hSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdroE-005u0C-0Y; Wed, 06 Sep 2023 14:39:02 +0200
Date: Wed, 6 Sep 2023 14:39:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, aford@beaconembedded.com,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
Message-ID: <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
References: <20230906095143.99806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906095143.99806-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 04:51:42AM -0500, Adam Ford wrote:
> Currently there is a device tree entry called "local-mac-address"
> which can be filled by the bootloader or manually set.This is
> useful when the user does not want to use the MAC address
> programmed into the SoC.
> 
> Currently, the davinci_emac reads the MAC from the DT, copies
> it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> it by reading from registers in the SoC, and falls back to a
> random MAC if it's still not valid.  This completely ignores any
> MAC address in the device tree.
> 
> In order to use the local-mac-address, check to see if the contents
> of priv->mac_addr are valid before falling back to reading from the
> SoC when the MAC address is not valid.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

There is the potential for regressions here, since behaviour is being
changed. But i do think what you are doing make sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

