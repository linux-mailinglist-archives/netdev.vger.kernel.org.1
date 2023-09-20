Return-Path: <netdev+bounces-35267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EE37A838C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7421C2048D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520637CBB;
	Wed, 20 Sep 2023 13:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D875328C2;
	Wed, 20 Sep 2023 13:37:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E400AD;
	Wed, 20 Sep 2023 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NYgPqWlLR9OmoskXgzlKZX5/4oCw4XqQIUHPbq6Tcs0=; b=fNRPN8813hhOtl2h7GqhhE1rLz
	M7f3uLQvFM+ALO1BlDF93jgOzYIKyUAHK6baOwoPHd00yiPSI17Hosp4W/E7ig21g2wyADu7otOZB
	/yeX9BkKYB34voDMVHNkC+D+cjSorK/NEsaVmLc5PjhaPXPYPXHVxUteWvrB+qdgiZLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qixO5-0070hz-Le; Wed, 20 Sep 2023 15:37:05 +0200
Date: Wed, 20 Sep 2023 15:37:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Ciprian.Regus@analog.com, jtm@lopingdog.com
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <52685909-ec92-41b0-957f-25da8a9be9eb@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
 <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
 <deff3e64-a10f-4d07-9651-502442a86987@lunn.ch>
 <cf23ed3c-d1cb-61fd-a305-e2787ef70cb1@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf23ed3c-d1cb-61fd-a305-e2787ef70cb1@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Ah ok, I think there is a misunderstanding here. This is related to OPEN 
> Alliance protocol. Control transactions consist of one or more control 
> commands. Control commands are used by the SPI host to read and write 
> registers within the MAC-PHY. Each control commands are composed of a 
> 32-bit control command header followed by register data. WNR (write not 
> read) bit in the control command header indicates if data is to be 
> written to registers (when set) or read from registers (when clear). so 
> basically it indicates the type of the control command on the registers.

OK, so this clearly indicates the names are bad and documentation is
missing if i got this completely wrong. Adding kerneldoc to these
functions should help.

	Andrew


