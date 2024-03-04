Return-Path: <netdev+bounces-77114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C998703EB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C58F1F24F51
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B03FB28;
	Mon,  4 Mar 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3GGOItv0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEF3FB0F;
	Mon,  4 Mar 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562110; cv=none; b=PNlhDCkcVn523jLXjyeMB9/dOt5TTbJoUm5ZQqSEekicxU15OA+V+epiA5VcC96+o81ClJCxPAqbcc3CiVaXjomQ410b+0mYBRTVDnpcWvMyhJh81LHi80KTfKSak+BeNenPeXRY1jYP9UG0n5TyrHEY/1cgZLgm9N7s339KJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562110; c=relaxed/simple;
	bh=zZT0cmO/66bD+ZDQQKiN4DsPz1NU/xkUGFceWCJydN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD6zWlKO0ZLC0ybaMK7YEa4S+zqH2byuYlHhJ9BsSG/IjBHUybIv61XbDXvM8/+Oy4OL1h35lZ4qc7CedCnmLgVy6gi2Yt6c9aelfNHMEDD3p9ApQSRF7d1oy6BZeQUTFoGVo9j2+otH8/mIL9AUkFd+7hP9OrS41HweJAj7GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3GGOItv0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JIN8y4O7mW/tfP/yj2CUKARqOiw3PB7vIKQNQWOqQ6Q=; b=3GGOItv0lEPkfxKpYVSFfaAur4
	nP/lEhux2TM3ZpooxAbmYlyKTjm4jRE1U4L3hx0PTOCEMZ/qiEyhECndZiY9IDIJ164AM5Fv36RkN
	TYAkVWYnLVv28HqXJMsZ1XoqTxnvKBJ7qKB1v/A4n9fOoOEUAV9wOcJLXQWXrMUfWMyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh9CF-009KaP-HK; Mon, 04 Mar 2024 15:21:39 +0100
Date: Mon, 4 Mar 2024 15:21:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Use full string description when opening HSR
 network device
Message-ID: <c984e6c2-b79a-45dc-8930-31c61e2f23c2@lunn.ch>
References: <20240304093220.4183179-1-lukma@denx.de>
 <8d92dcbb-828d-17f4-d199-c625505e7b0c@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d92dcbb-828d-17f4-d199-c625505e7b0c@ti.com>

> >  		case HSR_PT_SLAVE_A:
> > -			designation = 'A';
> > +			designation = "Slave A";
> 
> "designation" is now a pointer and is being assigned value
> without even allocating memory for it.

"Slave A" is in memory somewhere, probably the .rodata section. So
designation now points to that memory.

	Andrew

