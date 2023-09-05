Return-Path: <netdev+bounces-32074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392779228F
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8B1C204BF
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E1D2F8;
	Tue,  5 Sep 2023 12:23:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC02CA75
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:23:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08B1A8;
	Tue,  5 Sep 2023 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mH+z1pBMdYARyiLQ+raRnOwLNOvDHlI+88zIddX6yI8=; b=TrKg0pZmkW7eG3RHN00Y9V1gAj
	b84AX0OegIp9znWXHtAtCT4w0yM8wcLutk7hlZ6MprBXMQUau6kCSEtYE8sQ++JQbJSVRHRs/GcAI
	gUezTQpM9nb5EwW+YxmKuqlxuJVEqrPcBNcGH725DtZ+G/4MMOgBPVM03nxsnmIlZlCE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdV5d-005nyR-QK; Tue, 05 Sep 2023 14:23:29 +0200
Date: Tue, 5 Sep 2023 14:23:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <583cd9b6-06e1-4ed7-8a24-c977b2001e20@lunn.ch>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
 <20230905132351.2e129d53@wsk>
 <20230905120501.tvkrrzcneq4fdzqa@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905120501.tvkrrzcneq4fdzqa@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > And then we would have one port with SW HSR and another one with HW
> > HSR?
> 
> No. One HSR device (hsr0, with 2 member ports) with offload and one
> HSR device (hsr1, with 2 member ports) without offload (see (b) below).

I just wanted to comment that offloading is about taking what Linux
can do in software and getting the hardware to do it. Linux should
happily allow two HSR devices, working in software. If you can only
offload one of them, Linux should continue to do the other one in
software.

So please do follow what Vladimir is suggesting.

	Andrew

