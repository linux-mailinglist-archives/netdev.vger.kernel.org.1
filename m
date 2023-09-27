Return-Path: <netdev+bounces-36520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF27B03A0
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 81A61B20B38
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7742868A;
	Wed, 27 Sep 2023 12:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47C27EFA
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:12:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A270CE5;
	Wed, 27 Sep 2023 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d5tO3SJe0PbhXSHcNIaSFxP5tmPTcC6s9xX4wQoAzZ0=; b=ZablrPU2QM8KpWRjlgYITy1Ms6
	Qh21MIe3GVHTRiYyahZs34c2IRIM0yVs4mCf2Dbe3m8oWACYw2839DrDwpLotGLIzRPyjA2m5Y9Ah
	C4Nvtp4I9EMvxnpBLXFKrtEN5txZh59RL6soVOvpFDtPz3WXtWMqclIgPUYqdPduoh6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qlTPD-007dgP-5g; Wed, 27 Sep 2023 14:12:39 +0200
Date: Wed, 27 Sep 2023 14:12:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	l00g33k@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v3 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when
 EEPROM is absent
Message-ID: <3f3acf78-f4be-47ff-a976-b60b327c2c28@lunn.ch>
References: <20230922124741.360103-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922124741.360103-1-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 09:47:41AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done
> before HW reset") the following error is seen on a imx8mn board with
> a 88E6320 switch:
> 
> mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done
> 
> This board does not have an EEPROM attached to the switch though.
> 
> This problem is well explained by Andrew Lunn:
> 
> "If there is an EEPROM, and the EEPROM contains a lot of data, it could
> be that when we perform a hardware reset towards the end of probe, it
> interrupts an I2C bus transaction, leaving the I2C bus in a bad state,
> and future reads of the EEPROM do not work.
> 
> The work around for this was to poll the EEInt status and wait for it
> to go true before performing the hardware reset.
> 
> However, we have discovered that for some boards which do not have an
> EEPROM, EEInt never indicates complete. As a result,
> mv88e6xxx_g1_wait_eeprom_done() spins for a second and then prints a
> warning.
> 
> We probably need a different solution than calling
> mv88e6xxx_g1_wait_eeprom_done(). The datasheet for 6352 documents the
> EEPROM Command register:
> 
> bit 15 is:
> 
>   EEPROM Unit Busy. This bit must be set to a one to start an EEPROM
>   operation (see EEOp below). Only one EEPROM operation can be
>   executing at one time so this bit must be zero before setting it to
>   a one.  When the requested EEPROM operation completes this bit will
>   automatically be cleared to a zero. The transition of this bit from
>   a one to a zero can be used to generate an interrupt (the EEInt in
>   Global 1, offset 0x00).
> 
> and more interesting is bit 11:
> 
>   Register Loader Running. This bit is set to one whenever the
>   register loader is busy executing instructions contained in the
>   EEPROM."
> 
> Change to using mv88e6xxx_g2_eeprom_wait() to fix the timeout error
> when the EEPROM chip is not present.
>   
> Fixes: 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

