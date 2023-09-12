Return-Path: <netdev+bounces-33220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447FC79D0C4
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F6281C7E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A29477;
	Tue, 12 Sep 2023 12:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E69134AB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:11:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC310DF;
	Tue, 12 Sep 2023 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hUL28D01nERK2lfT4r829XFQpOyVQVst5T8T6Qa+ny8=; b=ZaE8e076/wjzs/CKz7w/+ayioi
	I9YQhHBM2Obnc8uiRVWmFbQonn9X/lJqB6o4mCXsHX075x7/aVPeHf0uZRrACmvHhKhoCTC8qjZSt
	tZuLkDs/DU8r6wN/Awhn2AeqE9Y4BgFQvfh+D5Hi4AkS34qdWF97C2vcW3UMSL+2Jf60=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qg2E6-006Dtv-Ab; Tue, 12 Sep 2023 14:10:42 +0200
Date: Tue, 12 Sep 2023 14:10:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <66aafc68-3bf9-4242-8f04-a4f3988129c4@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <5f434392-0e87-ecbc-9c9a-ad08a809206a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f434392-0e87-ecbc-9c9a-ad08a809206a@huawei.com>

> > +int oa_tc6_deinit(struct oa_tc6 *tc6)
> >  {
> > -	kfree(tc6);
> > +	int ret;
> > +
> > +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> > +	ret = kthread_stop(tc6->tc6_task);
> 
> kthread_stop() will the result of threadfn(). Here mean that if threadfn()
> return non-zero, deinit() will fail. But the KTHREAD_SHOULD_STOP already be set.
> And oa_tc6_handler() will end. Please check it is what you want.

Hi Ziyang

Please trim emails when replying to just the relevant text. Otherwise
you need to page down, page down, page down again and again and might
miss parts of your reply.

     Andrew

