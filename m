Return-Path: <netdev+bounces-141011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C69B916F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DACE1C22568
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAC17C7BD;
	Fri,  1 Nov 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pqCqnkab"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF06487A7;
	Fri,  1 Nov 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466052; cv=none; b=rzr1vhGYkofj75u2JemDXgR1d6/K/4S7G79Hb5MsmSqWBuB4/LvE44RAFnzfG+XMrnyOut0HHQIU8LfNv7IUwpUJY/9HMllmn+aLAP+OiF/H3gW0ACylM0cDALfbXr+2roVxtuRZg8bIf4pjdTLhIFGvZq4op+5mbYi32T1ZHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466052; c=relaxed/simple;
	bh=KfUW9Uu3no2Vw8/UiSr/G5ZLwr3NM84gzJyhXC6kOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da/mw6yXfT1jpZZrzejOz3yZiq0cw4qMLQI5XFp/gBa6o7YWXpzn6LF44d0GYnSwBgK/Rphb4H0QLLbhNOgWFZiX04YOjj4KadAb7T57oHZzrrddyvuQQ66yLd/nOxuft9fB/+H67JYlp9gVYpqvpoS3vPU2eh/S5u2+gsdFbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pqCqnkab; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bN97x3CR9BhFWdKel6Cibx5eIIwEaZnJ7AACIT8nZKI=; b=pqCqnkabKeDEY3jT4YgmpXWGQR
	+xOzW6U8Ssh2FNHYljrRlzGTbBfFPqrtGcpZoPZsx2b8E0HdDx/SJhOAUYTtfoMQaX+BNO9/2QpQz
	EZf47juF1iTIGWwsN8xCL51JjmrIBJgRO1SaI/ayNwQE8Wq15ShQEIDtj610gOOkpJF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6rGQ-00Bscb-0Y; Fri, 01 Nov 2024 14:00:30 +0100
Date: Fri, 1 Nov 2024 14:00:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 2/5] net: pcs: Add PCS driver for Qualcomm
 IPQ9574 SoC
Message-ID: <8f55f21e-134e-4aa8-b1d5-fd502f05a022@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-2-fdef575620cf@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-ipq_pcs_rc1-v1-2-fdef575620cf@quicinc.com>

> +config PCS_QCOM_IPQ
> +	tristate "Qualcomm IPQ PCS"

Will Qualcomm only ever have one PCS driver?

You probably want a more specific name so that when the next PCS
driver comes along, you have a reasonable consistent naming scheme.

	Andrew

