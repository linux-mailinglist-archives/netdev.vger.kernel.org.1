Return-Path: <netdev+bounces-139559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D89B3099
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577321F210CD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF71DDC02;
	Mon, 28 Oct 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T8+F1J7D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C11DD88E;
	Mon, 28 Oct 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119314; cv=none; b=KaSjlM11tYGAx+bC2uWSBuTIoYXpDTdtw1Q4FVTrObFVgV8WGjS2GqYfURsU/IR4kVz86DMtf0BeuT4JOTufySEA90pcX2hIB+Rl6RP3arD1MzdS/8IHAb9Sr/k77sX1tna5L12n2b6vJN/kd0KlKTJR5BAkTogZqDw6oB0tGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119314; c=relaxed/simple;
	bh=ZnNnyY4JIBLkUWhHu22Z7KS1AqmIVw3NB0GckTgsKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShrFBbLDvRBsogFhjTR5GlaweKd/YGl5nH+VhM1naDNOULR7MBahaqGnEny0nSneyjTXrCpFQdeJEqoqNr3gGenqZuv0IDgalk3YkwC5MVq3kmWfziprT2D5B5nxxQJ6W4cWnRRZT0UyiKHxfkikvEgFW8IyuozNfovKWSVFLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T8+F1J7D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UalDViA3yaDlhxM27mCslpLgsREGyijfzPfoJVZi8Ak=; b=T8+F1J7D6FlB7VF3f9VkqSn+IJ
	dZuHmTkbE4emk7+hSHQCf63cq81OrRQT3xrEVc56xyPgTcs5rrU9CX8bNtsKEgF2XjEPeQN8AMl7m
	siMBygrhTnKkepPl067drbzc0LVE2VKJJB3xTk0BymMjsL9pPoq4SN/I6fXKM5Yzqf8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5P44-00BRgQ-GN; Mon, 28 Oct 2024 13:41:44 +0100
Date: Mon, 28 Oct 2024 13:41:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Sujuan Chen <sujuan.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix path of MT7988 WO
 firmware
Message-ID: <8dea87fc-c37c-43ac-a541-9ac67e351319@lunn.ch>
References: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>

On Sat, Oct 26, 2024 at 02:52:25PM +0100, Daniel Golle wrote:
> linux-firmware commit 808cba84 ("mtk_wed: add firmware for mt7988
> Wireless Ethernet Dispatcher") added mt7988_wo_{0,1}.bin in the
> 'mediatek/mt7988' directory while driver current expects the files in
> the 'mediatek' directory.
> 
> Change path in the driver header now that the firmware has been added.
> 
> Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

