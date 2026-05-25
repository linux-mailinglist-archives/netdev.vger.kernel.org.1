Return-Path: <netdev+bounces-291249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKFGNDwAFGquIQcAu9opvQ
	(envelope-from <netdev+bounces-291249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0E5C751E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B5B030041D9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171D3D5244;
	Mon, 25 May 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="mQlvtdKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716003D47BC;
	Mon, 25 May 2026 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695672; cv=none; b=d0CVF91up3PcEDxmIZTGJH0bxytWCLYKXpIs+VKy2lkGotNerkaGI3Z9J5iOWfQ04MOmOussfB98CDSV9ZNb4HR5CiIKmNHAlro+mBHpeX+YnnZTidUkIarFvOdgrc+SlXd4AUUe6eCwfxaTw+13eTg2XBxRRWOnS8xOf/0KExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695672; c=relaxed/simple;
	bh=z3s+3mtiHXvjvJIGmXzB2KzAuvB/LPu3m0L7bE8MPSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyumFHWZS72cnzbkoco9sSdsJDVfc6nFpjkfZ86Wo5KxCT+J7+HMp1T6NBWZk5itjaPSz5XWmTm8sx9/4K/PQMVbJiH/if0H0lw8NarE/BoDmTjILcrCD42VQzuHx3A4OnifQRwzbF+rXJfnwwd8+Eu5R5zvc0ypBnqO7YoSmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=mQlvtdKG; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [95.24.33.248])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7065045F79BA;
	Mon, 25 May 2026 07:54:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7065045F79BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1779695666;
	bh=rXa482hr69dDQ/zYomBqIFITJAqauAmp4jj6G9d61nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQlvtdKGtkNzEWaX8J2D3xqHiWnsDACeZieg/YlGaIOyBmzukRPeEWmJyXJpUoPW4
	 sZzj4XTC3REjyTHJdx4IRQm6tCLiX46eANV+Am7gQJrdaS/8+L59fefabyU0hxoXHq
	 g7wdEH25Bcg2TbSEYbPKIty2ofxwNDcbG/94vu10=
Date: Mon, 25 May 2026 10:54:26 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jie Deng <Jie.Deng1@synopsys.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net 2/2] net: dwc-xlgmac: handle hw initialization
 failure in xlgmac_start()
Message-ID: <20260525104653-40cbf946df45605806df91aa-pchelkin@ispras>
References: <20260523104740.295650-1-pchelkin@ispras.ru>
 <20260523104740.295650-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260523104740.295650-2-pchelkin@ispras.ru>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 92D0E5C751E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23. May 13:45, Fedor Pchelkin wrote:
> hw_ops->init() can fail, thus leaving uninitialized TX and RX descriptor
> objects.  Later when they are updated in xlgmac_dev_xmit(), there is a
> NULL pointer dereference.

I see a number of AI-revealed issues either directly related to this patch
or concerning the surrounding code.  Will respin the series.

