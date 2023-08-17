Return-Path: <netdev+bounces-28588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D177FEAA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C05282163
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE31AA7D;
	Thu, 17 Aug 2023 19:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E120F8
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:44:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25245359D;
	Thu, 17 Aug 2023 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1ixeOe9GGtjbMNgtFir4oRPvY9H4IGw3hGrf3Yr2iv0=; b=UfL4DouLW2DM6tWq8gDQk4jGLZ
	nU99k69t3veYApdn8lwpgxMMIvQef1sLF6kTxXhMPnFA/1RtLjtC5HgdaAgGlEGFpN+WXmDCNMBtg
	qS+XgInJdafgVUEJMUTU8iMMJy2OMkX8ULZlZZNzgF1xZbZ1DNPlLIJf4dpMrRXTNeqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWiuZ-004QKa-2n; Thu, 17 Aug 2023 21:44:03 +0200
Date: Thu, 17 Aug 2023 21:44:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"Verdun, Jean-Marie" <verdun@hpe.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <e8b7a123-f542-4a22-b463-122970922535@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <DM4PR84MB1927C6684845A9AEBD9F934F881AA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1927C6684845A9AEBD9F934F881AA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > +	if (length > 1514) {
> > > +		netdev_err(ndev, "send data %d bytes > 1514, clamp it to 1514\n",
> > > +			   skb->len);
> 
> > Than should be rate limited.
> 
> How is this done? Is there a particular function to call that
> will handle it in the backend?

Sorry, i was ambiguous. I meant the netdev_err() should be rate
limited, otherwise some user space application could DOS your system
by sending big packets at line rate flooding your logs.

   Andrew

