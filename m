Return-Path: <netdev+bounces-21262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8371763089
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10975281C99
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC117AD36;
	Wed, 26 Jul 2023 08:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF31849C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:54:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8752F3C34
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HqTbDSl6lVCzKMHgp7Qle2oQYUV2F8EHaoVW/EDRIW4=; b=w6
	E4/7IgqbIi5uJ9SyAn40/QKqvJKIIjEhS+Td30B+8gKSZ8wDN8DI1I9pb12LvccOnrXTURk20bv28
	Nf7/d3HNJs0ZjnB/zt7butyNAeRpZnuvyEOVJuVH1/qRiWyndnQ42FdJBqKWSa1qkeBHu/8tHgIcW
	NgsnOMPrbhrKmLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOaHp-002LAD-29; Wed, 26 Jul 2023 10:54:25 +0200
Date: Wed, 26 Jul 2023 10:54:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com>
 <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
 <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Now Mac and phy in kernel is separated into two parts.
> There are some features need to keep data connection.
> 
> Phy ——— Wake-on-Lan —— magic packets
> 
> When NIC as a ethernet in host os and it also supports ncsi as a bmc network port at same time.
> Mac/mng —— LLDP/NCSI —— ncsi packtes

As far as i understand it, the host MAC is actually a switch, with the
BMC connected to the second port of the switch. Does the BMC care
about the PHY status? Does it need to know about link status?  Does
the NCSI core on the host need to know about the PHY?

You might want to take a step back and think about this in general. Do
we need to extend the phylink core to support NCSI? Do we need an API
for NCSI?

    Andrew

