Return-Path: <netdev+bounces-41005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F287C9564
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A191C20AFF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352716405;
	Sat, 14 Oct 2023 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wnaCPFMr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD018629;
	Sat, 14 Oct 2023 16:33:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001DAA2;
	Sat, 14 Oct 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TjAVZYOAlTDsq6THI3zcjFMik6gUWLNkPKCfTAqhtwA=; b=wnaCPFMrPWEzcN/LW3jAmjbDQZ
	BnKxKa029DVc0URndS4SSeojnZvinQTIKAk4ZJS0IxAxd1EVkA00JLJc4jHQJeM4kUIC+22RmylrU
	w/wnMR532YDg+V4hO4cwcXgemHnJE+3CxiHaE+Ru/kqv+PmiKIf+BOZxkJ3sXcghUWV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrhZi-002Bf4-BN; Sat, 14 Oct 2023 18:33:14 +0200
Date: Sat, 14 Oct 2023 18:33:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lan78xx: replace deprecated strncpy with strscpy
Message-ID: <f415394c-a760-4020-a83c-68332cb8d17b@lunn.ch>
References: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 10:30:54PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Other implementations of .*get_drvinfo use strscpy so this patch brings
> lan78xx_get_drvinfo() in line as well:
> 
> igb/igb_ethtool.c +851
> static void igb_get_drvinfo(struct net_device *netdev,
> 
> igbvf/ethtool.c
> 167:static void igbvf_get_drvinfo(struct net_device *netdev,
> 
> i40e/i40e_ethtool.c
> 1999:static void i40e_get_drvinfo(struct net_device *netdev,
> 
> e1000/e1000_ethtool.c
> 529:static void e1000_get_drvinfo(struct net_device *netdev,
> 
> ixgbevf/ethtool.c
> 211:static void ixgbevf_get_drvinfo(struct net_device *netdev,
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

