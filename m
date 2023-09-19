Return-Path: <netdev+bounces-34968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DD7A63EC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FA52810BA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A582C37CA6;
	Tue, 19 Sep 2023 12:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571271FA1;
	Tue, 19 Sep 2023 12:54:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441DF3;
	Tue, 19 Sep 2023 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Npvrzyz+/TZN9YuhYrSAlYVBkFpFs1Wg2sTP1rKTzM=; b=XXl0VR2tj8IyKUOHxyeVKdBQ12
	QbqTt8W+/Un78rkZaHzfMrIOQfiPRpMR423vSz4l8tSzehXttY60c+iOpNCet9ysn7EAbYhBdUPyT
	KKUq+vcVhFuT4suCzdVfZvc1mfP7pWTaeatTbcKuDD3L4r1sYPzuYMaYJzyhP0c7UuQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiaFb-006uYS-1A; Tue, 19 Sep 2023 14:54:47 +0200
Date: Tue, 19 Sep 2023 14:54:47 +0200
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
Subject: Re: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6
 configuration function
Message-ID: <d2d26c6c-0345-46cf-b806-15834ba8b40f@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
 <dd0a6cd5-91e5-4e13-8025-d6c88bdab5a2@lunn.ch>
 <46fab729-4c5a-1a6e-37d0-fea62c0717f7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fab729-4c5a-1a6e-37d0-fea62c0717f7@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >> +/* Unmasking interrupt fields in IMASK0 */
> >> +#define HDREM                ~BIT(5)         /* Header Error Mask */
> >> +#define LOFEM                ~BIT(4)         /* Loss of Framing Error Mask */
> >> +#define RXBOEM               ~BIT(3)         /* Rx Buffer Overflow Error Mask */
> >> +#define TXBUEM               ~BIT(2)         /* Tx Buffer Underflow Error Mask */
> >> +#define TXBOEM               ~BIT(1)         /* Tx Buffer Overflow Error Mask */
> >> +#define TXPEM                ~BIT(0)         /* Tx Protocol Error Mask */
> > 
> > Using ~BIT(X) is very usual. I would not do this, Principle of Least
> > Surprise.
> Sorry, I don't get your point. Could you please explain bit more?

Look around kernel header files. How often do you see ~BIT(5)?  My
guess it is approximately 0. So i'm suggesting you remove the ~ and
have the user of the #define assemble the mask and then do the ~ .

     Andrew

