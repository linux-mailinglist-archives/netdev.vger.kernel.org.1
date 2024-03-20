Return-Path: <netdev+bounces-80752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEB880F22
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43161F222FB
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737E3BB36;
	Wed, 20 Mar 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pTJEczVg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEB3BBC2
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928535; cv=none; b=lCI6Ti+NWg0+C0oZoiQOWYg5vjQv8/J31nvHz7CyGbchiWUopWGnjF4WMwEz0eXI5PsL8fLASUkaeB6YytTmZDXt6PZJQ3t50y6DnFaIRW+PlfbWO2Gsul9mxoakpwZb9tcnfCUvkiRjXPJq9DyjQunJNK7ZXX0sutj0gN2xdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928535; c=relaxed/simple;
	bh=RvclKl8Rqj3HBT62SsXBgQzH4UkYuHrXMT17GL20sQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTBq0Fn8E9DT6pYXGxZcUAOoS+mCmDbAvtZphvP9Kswu/MqGEjrrNGPGSuyzt8/Fe6zuF9KQaqJtaHjW4of1zh0QNB6GqV0YvO5pINSjcffZsxQs50f8ZaND5Pw0up4Ym2xqGzRVgPQGCFi33ERbGZQWbt5lcsinV9KYgm0ZRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pTJEczVg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NThhcO8JXkWvAdXtQu8DwA40Kmyu6UPsUrs04jfSZwM=; b=pTJEczVgpSerrqTGF3W0pKrbCh
	r1EuEXfWRELHgm5G1580g76GOykthWpNyHSbWZV8zGlbbEar6zYl44MXEIct0hJksAolgVP+tN2Bh
	YAWP4YAQfm89szk3po7d0g58C1Um1/Ml77QiUEGBi+DqBsn0aJRVYOe74MiRBkfNwahD28FiEzPAT
	HE4dj340n0PzFv4l6rZNshWDUw61zT7x6XjuTr0xea8zE+WsHlNjMetkJQIaRGgOJcx2SF5DktfDE
	VJmRzZA+KVrZf/fCvIkR9uReNKcMYYV7c4KjY8GyGjFp5MWHhZGJBWaUOBK2uAIvlcmFBEb5LLSj4
	mtkHzjVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40344)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmsf7-0006OB-28;
	Wed, 20 Mar 2024 09:55:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmsf3-0002Yk-Rm; Wed, 20 Mar 2024 09:55:05 +0000
Date: Wed, 20 Mar 2024 09:55:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Message-ID: <Zfqyeebvr0B3GWpo@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
 <673510eb-21a8-47ca-b910-476b9b09e2bf@loongson.cn>
 <yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug>
 <ee2ffb6a-fe34-47a1-9734-b0e6697a5f09@loongson.cn>
 <034d1f08-a110-4e68-abf5-35e7714ea5ae@loongson.cn>
 <3djgq4zsafxdiimb236gvbipwkgedqvubhuyorgvgpz7gqf7ae@4xjsdtrvg4hj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3djgq4zsafxdiimb236gvbipwkgedqvubhuyorgvgpz7gqf7ae@4xjsdtrvg4hj>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 19, 2024 at 05:18:14PM +0300, Serge Semin wrote:
> How come almost all of yours recent replies have been formatted as if
> with no inline messages? See
> https://lore.kernel.org/netdev/034d1f08-a110-4e68-abf5-35e7714ea5ae@loongson.cn/
> It's very-very-very hard to read. Please never do that.

Please also trim appropriately your replies (that goes for both of you.)
I tried to work out whether you'd provided any content apart from the
above, but I really couldn't be bothered to page through the message.

https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

