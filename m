Return-Path: <netdev+bounces-222721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09879B557B1
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510651D62F06
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07A2580CA;
	Fri, 12 Sep 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ornA/hVk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D72DC76D;
	Fri, 12 Sep 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709550; cv=none; b=YnHYlkLD5OwpBciRr61B92vG86lmxXOJE0EOscS9mv9IKJyDOBs0Z07fOv5gSco+q+XIwGiNEqzWSULCsSom+IUi2VrJ2hB1gbXXJtVp68XKDzYZftcPzLDKRZqkQ9IZsPHZ6eAg3xbhiTgacNwxKdcqbtpxX5GgMCd1wMiMnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709550; c=relaxed/simple;
	bh=XjlzbxOPI9k4HJ/nt4qvHCfNeSL+KPbMyK5is1V3w98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ++fbO88GCDHDIdzzmohlA3Rt1s06du0Yv9DQYellNZfC7Ontyoxt+8KRsJ2rUxFwONU5pYGL5kiZ6obOML1LcIdAgXQnGNPEEmC+1fV/voQHti6mP13+fuy+UX8R3dFlu/0+q+TdBI3Og0camGrgN40hImfnqjHyUsy43juL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ornA/hVk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RoWkU4gWBG8S5M3j86BiHNrtQVTCkzI308KAVYRZnWQ=; b=ornA/hVkqies3qUnsXJy75cbao
	jS9S6Gz3sIatOyl5f73NbNxTIDaiVaLAUAMXJAOXUhmzPHd52KDypu+qyfq1rW3zlHveHcr9In+u8
	SAgo9dNURUFhmePp1BqVBkkHXXZQegXOyGvpE5klIkcDlQF/3LkTe+sNOI2+AtSlCrn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAXu-008Fpw-Gr; Fri, 12 Sep 2025 22:39:02 +0200
Date: Fri, 12 Sep 2025 22:39:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: handle copy_thresh allocation failure
Message-ID: <57d58296-c656-4dab-a2e2-faf2452fb4de@lunn.ch>
References: <20250912145339.67448-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912145339.67448-2-yyyynoom@gmail.com>

> -				skb_copy_to_linear_data (skb,
> +				skb_copy_to_linear_data(skb,
>  						  np->rx_skbuff[entry]->data,
>  						  pkt_len);
> -				skb_put (skb, pkt_len);
> +				skb_put(skb, pkt_len);

Please don't include white space changes with other changes. It makes
the patch harder to review.

    Andrew

---
pw-bot: cr

