Return-Path: <netdev+bounces-34647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0F7A50A1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988F1281DF2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1FC26E1C;
	Mon, 18 Sep 2023 17:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F826E19;
	Mon, 18 Sep 2023 17:07:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70390192;
	Mon, 18 Sep 2023 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZDG2UZigKOWJ038WXoUKb1KefBm5hAW9BvHKmAdM9gg=; b=O3jBt7mEzv4sgCXD4Zd78Adiw3
	o6Hn7tyP4VgDXPkAVVzD9k5+bgLAIHEcMw8zfb0c2JOPFhNb2xw4SV9wjGN+zQiND/552P92Wad8b
	mYQEA2h6ykcLgLtRDQ7G3JTZBlIq0PXomnUADenREWD+ikLKrZKPFKT67B2m+J6se5KE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiDsc-006nGM-ME; Mon, 18 Sep 2023 15:01:34 +0200
Date: Mon, 18 Sep 2023 15:01:34 +0200
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
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Message-ID: <51d1565f-e43e-4906-af65-2ae672309b89@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
 <e874dab4-e701-44f8-bbe0-ce66784ecf5c@lunn.ch>
 <3900f818-9ff1-cc19-f545-fbb3e2db4d52@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3900f818-9ff1-cc19-f545-fbb3e2db4d52@microchip.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >> +#define MAX_ETH_LEN  1536
> > 
> > Where do 1536 come from? Maybe this needs an OA_TC6 prefix to make it
> > clear this is specific to this protocol?
> Ah it is a mistake. It is supposed to be an ethernet packet size which 
> is 1518 (1500 bytes MTU size + 18 bytes overhead) and it is not from OA. 
> It is a mistake and will correct it in the next version.

Please try to express this using ETH_DATA_LEN + sizeof(struct
oa_tc6_overhead). Doing it like this will avoid errors like this since
it is also part documentation.

   Andrew

