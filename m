Return-Path: <netdev+bounces-138492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F749ADE16
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B928E1C258F5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90734189BB3;
	Thu, 24 Oct 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HOPrWlWd"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5408189917
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755942; cv=none; b=F43Z7FzjPm7oIQNXQOCJ39ce1N00MAeelcRCMkOYswBcWLRIwSTuFOlBcr4tgut9rZXMrYz7eULat9ZhqZCpv73F10B1pI1AKGVU4ItE+A8ZOBkO3iNMpCqvD95SEvmwSoAqY44fPEh50A7vmBOT+g8mQqqRlEccRGpfIuFQSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755942; c=relaxed/simple;
	bh=hh3ShzjQRDawnLSpjqv2Gi7JMOXL/1xuIK4PiSoGO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQiePZ5xA8vl2Lc9AiCTr/FT1GbpoYj9KZIuRIMewohEUuWo0QDUTIm7qv6IBRpKtlzX2kBZxhjCVd5YtOkq0mEWW9W8rJqKvvUudLPnl4bBdjzD9vBUbhRSI/4vMEB4eWLWBWRTGctDy0cpggJ2GLibFNZLCNfsGFxRaBUcmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HOPrWlWd; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A227A1BF203;
	Thu, 24 Oct 2024 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729755937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh3ShzjQRDawnLSpjqv2Gi7JMOXL/1xuIK4PiSoGO+8=;
	b=HOPrWlWdUdEKMR6Qx7waQc+sTRtxT64dj8kwPkE58uXPlwdYc6nrdMyFpOI2kjyaW2HY5L
	EYc/5e+cR5tYrev4xTCan8qiLnQk1RNJp6McRehvk7jg/nzcO0Ax8YrVW9tBy82hvV45dB
	/qq1Qr3C8YHEry2Gjse6E2j5vsCnYx8UnZiaEG4cmpA02dC3bvrdatvQF3nmsn8qs/Nxr3
	OJlLJV3KdfJTMY92V99726WvZ/z194yXGQghxutXfRW1t5ykA1gfTnzgePkc7FlC5OTM/w
	rifWx/4GymDbJxSeZNuZs+Ap1xplvfWZ+781KM2BdfemI6EEOn8RDDJBpqW2mQ==
Date: Thu, 24 Oct 2024 09:45:35 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
 <horms@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <chenjun102@huawei.com>
Subject: Re: [PATCH net 2/2] net: pse-pd: Add missing of_node_get() before
 of_find_node_by_name()
Message-ID: <20241024094535.70118377@kmaincent-XPS-13-7390>
In-Reply-To: <20241024015909.58654-3-zhangzekun11@huawei.com>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
	<20241024015909.58654-3-zhangzekun11@huawei.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 24 Oct 2024 09:59:09 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> of_find_node_by_name() will decrease the refount of the device_node.
> So, get the device_node before passing to it.
>=20
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

