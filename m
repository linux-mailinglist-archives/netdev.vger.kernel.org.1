Return-Path: <netdev+bounces-208199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D1B0A8FB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A170517BA07
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B12135D1;
	Fri, 18 Jul 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EJI6T4j2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B61C862C
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857982; cv=none; b=ABVDB5It/yg5e2SgcKcQsiLL53gPTIEQ3dW4wRDx3wU93Zph+yJWZ6bp+Dj+sXFp1b0VlZpocP0Nfbh+ukxXMO43qucezCq10yNYblcsQaxoSZLwImCYVCu+M5BZgAAX9iZcrv7gVmxvtHFBz9QAYexVDX7kVrI5xYOXcOsaIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857982; c=relaxed/simple;
	bh=6SqLEtUqDD5/BzXbxtgrbLx7ALuw/QQKXBCTlqM0Iq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogAxvrtVahvVjmZquijLQu/jkvRyvgJAeVJjtOYfOphKUj+EjAcOLe6atYSFS4W2EUVOGYeZlHHVjYA00uE3TW7AiSJKjKkicPm6km5b45BHQI1hJOTR5LlRSVMrdYzHhxqXdy8LFG9RfmDE0tfq8/fe7bdd9Z96YSoh8l0qNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EJI6T4j2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WRkDyy57U7Cb31/cmiG2E1pEbzORxnsJtuw5hKbmRIU=; b=EJI6T4j2yc16oZOMO1gpL4QJRn
	HaOjCSNO1Cqh4E9QhP8BzdUfcQcO/067fQCHp0IostKyMKTtomB2Jr04EkSf4rcZy/q5ZtgaDe44x
	YEN5PjU/5bKOJXNY4ekajc2Bw0ZYMlmSowQy2xiBDqNkURzFB/rUscHEKiJifSIA1kY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ucoQm-0020xr-Rv; Fri, 18 Jul 2025 18:59:32 +0200
Date: Fri, 18 Jul 2025 18:59:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <9e208e97-23ef-41e7-94d0-0a391cba9b59@lunn.ch>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <7b957110-c675-438a-b0c2-ebc161a5d8e7@lunn.ch>
 <1752644852.1458855-1-xuanzhuo@linux.alibaba.com>
 <322af656-d359-44d8-9e40-4f997a8b7e0f@lunn.ch>
 <1752733075.7055798-1-xuanzhuo@linux.alibaba.com>
 <161e69d8-eb8e-4a5d-9b4e-875fa6253c67@lunn.ch>
 <1752803672.0477452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752803672.0477452-1-xuanzhuo@linux.alibaba.com>

> We have our own distribution "Anolis".

This driver can be used with any distribution. So it needs to work
equally well for all distributions.

If you want this feature in Anolis, you can take the upstream version
and hack in the feature in your downstream kernel.

> > No module parameters. You are doing development work, just use $EDITOR
> > and change the timeout.
> 
> Our use case has already been explained. We will set a long timeout to help with
> issue diagnosis, and once the problem is identified, we will immediately adjust
> the timeout to let the driver exit quickly. Honestly, this is a very useful
> feature for us during the development process. Of course, it seems that you are
> strongly opposed to it, so we will remove it in the next version.

We have been pushing back on module parameters for years. You should
of seen this in multiple review comments on the netdev list.

	Andrew

