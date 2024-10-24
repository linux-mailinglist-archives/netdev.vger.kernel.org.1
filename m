Return-Path: <netdev+bounces-138598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF69AE437
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB3AB2180C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271551CBA12;
	Thu, 24 Oct 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mi9fzW7l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFF1A0BC4
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771012; cv=none; b=XYdxZg+55awEGwqWscKUPFIz0uu76pIikLx1IfvxDU8OhuekJUabSU4E9y87Ka60UsHjd2TemKQ7nmOAzBX9bsIUQTcz6V8xa8FDArRlUAnc69zMNyw7121G4qsOd2Nyd9QEsQ64cGxAcI9rx1fzNCURhg8xBz5vhnOMJSviee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771012; c=relaxed/simple;
	bh=ofE9I3vjiUQ36e71FDLUW1wNXvWL66Y7E/oJmLyDGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8NFOd0ljHvC69Mam6GuEJOx4vf35VeXkpSbz/i2S60pyv1bLcBN/OnoeLjtyiigJ4qJXiHc7l+78gv9vuFMhbjJGCphl7Co6G9rIBUq68O+rYvN7UeBu5gSqkonLB+OSfe4ergadgd+UgLQQb3+n3Mzm7tlBhYut6fSgNy0EOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mi9fzW7l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BbsxK2PB4uXCf6KuoGXUyUOFAdbgpmoF0pKiK04h4bU=; b=Mi9fzW7lKycK341J89BTbzPMuL
	ESSh/kfC/70/gVD5H6Da3r/1T6FGnJoTw4TN5tEF+A7ulCT+OZnPtJpCxXGSR+vDpXR8ASyUL7z78
	XgUq1tF/CJyNZzBO/MQQDFYOcZRQ5hManpzqHXqc1B1IHa6dWF18/OTPuPj8WOkkUHv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3wSB-00B6p8-PT; Thu, 24 Oct 2024 13:56:35 +0200
Date: Thu, 24 Oct 2024 13:56:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, o.rempel@pengutronix.de,
	kory.maincent@bootlin.com, horms@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before
 of_find_node_by_name()
Message-ID: <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-2-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024015909.58654-2-zhangzekun11@huawei.com>

On Thu, Oct 24, 2024 at 09:59:08AM +0800, Zhang Zekun wrote:
> of_find_node_by_name() will decrease the refcount of the device_node.
> So, get the device_node before passing to it.

This seems like an odd design. Why does it decrement the reference
count?

Rather than adding missing of_node_get() everywhere, should we be
thinking about the design and fixing it to be more logical?

	Andrew

