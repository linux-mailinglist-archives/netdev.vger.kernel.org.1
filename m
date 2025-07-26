Return-Path: <netdev+bounces-210260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59037B12807
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126D73BBF0C
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B654764;
	Sat, 26 Jul 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fog+JGJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A91D555
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489922; cv=none; b=Yrl9GXJcV/krm63WA9l2P8UZqvDdRqENte1/o4Kwo3vDMYs0zAlpIAo9e6Ua/zq4C5Zf/aKLDu175V3NLef03WdX9vliImM52J6jj41TqtKGmb1NFju12UoxvHymA2Lz+rTN/5gYs2aqZ5VXHCxzPvrz+nJPklHToT/eEx2jNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489922; c=relaxed/simple;
	bh=RF2a2zJTItHvGbtgDHUbf89FxxNmR2AieNC7XRPy3IE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu9NU7uL1nYqDXvl4otVQ80sOYA9c+D4+OP7Ic2dvwtUSCjG30XghhKq33YTglg2TvQc1X7HHnAOXmJ/EtnPWyF66MyowVQ+C3kCA5wFGFd4EfLkwamSd2OXQzTXR14Hv5JsReK6HmafPnIFq8izIeVsWAwdY+YKkvke8MLNZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fog+JGJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F566C4CEE7;
	Sat, 26 Jul 2025 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489920;
	bh=RF2a2zJTItHvGbtgDHUbf89FxxNmR2AieNC7XRPy3IE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fog+JGJ/Qf/O8eswX+V6UKtHNazr60J9xBIhXJvIGkn7fo3V4HCEtddljHbA4WqpR
	 3yqezi7YMwuKGkosrhJPnfXLAkj+7fY3yp6UFRbBRdq0Z9SehWIbg4emGJSX0v7zxI
	 dVGYHwLa5/tp1UyLXGVhzwQ2bZYHkW61XoNQr6M5qJ1oBF9vslD/5pn+/R4zGdbIKZ
	 jiIKcpBm+aFf/12wLLvaQ9REIU8S5ZRjpocqSR9FBFA3/vqCUds3VzfaGgLjBmx7jF
	 xATWL6eXXpLdErihk7SedsfC2pwwOAvl/5/nk2z1dACWMrzBNlzkxQY6qNZGPhBmhG
	 G/wEP0ei66lLg==
Date: Fri, 25 Jul 2025 17:31:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 2/3] net: wangxun: limit
 tx_max_coalesced_frames_irq
Message-ID: <20250725173158.7d372bb4@kernel.org>
In-Reply-To: <20250724080548.23912-3-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
	<20250724080548.23912-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 16:05:47 +0800 Jiawen Wu wrote:
> Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535, because
> 'wx->tx_work_limit' is declared as a member of type u16.

okay if that's the case then..

> -	if (ec->tx_max_coalesced_frames_irq)
> -		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
> +	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||

	if (ec->tx_max_coalesced_frames_irq > U16_MAX ||

? why create a new define if the boundary is basically dictated 
by type width?

