Return-Path: <netdev+bounces-265560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mInXFfvQrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:54:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E492123A184
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8255B301FB80
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FE3BFE2D;
	Mon,  9 Mar 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x1Swie5i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3B1F63D9;
	Mon,  9 Mar 2026 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064433; cv=none; b=czlVjJhwpOuieQDdWeYNvjmLeXX0+LUPQftTIevAoJD8sN7nkLPmbrwFTZQR2kMV01+cgOTv6/KHeJJfRWUQAuPCC43O+R9dzfWYrwAU/zrLT0yF72VnsiUh9NpGP1epRuUc4YA5z4N1MKkUJQJNRgmB462CgKaiTQoscy0OaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064433; c=relaxed/simple;
	bh=Mfd4iO1noQXPtnG//uexNXdm8nYzeOXS+33r5GU1V30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRuKL3+jS1673PiK1X0VlOgvl4YHdKrAlVrngfyrA2YLnfk2G3WNRuTLBu0Ld6OpmUaZQDT64RtESOp3gz4h47ukUF5G5s9XLadtPy3TBqg62DDmEZTi1DWaaujgK1wq4u4TQXagHpS1d1AM3xLSZ7xLLMzCsHMYPtfzn6yfwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x1Swie5i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ER+LBnfMBOV109rdAYY/rcfnHDt99STW6FsM8jpfTAQ=; b=x1Swie5iENhZwo2ZWItamlfzeg
	g9KIwxwLoMlCVAyOwqh/vGPIou/Ldczxvz9J1r2zFOqx1k2UlvMYHVtg+XPRwnh4KiEv26e8juYq9
	A9ML7Q5BdfB0Qdvvcyn46+MYrvZsn8stKnl7fNbR8eOhCi+DmwDho1EMbHZmKgZH3WEo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzb36-00As3H-QR; Mon, 09 Mar 2026 14:53:32 +0100
Date: Mon, 9 Mar 2026 14:53:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Cc: rafal@milecki.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bgmac: scope bgmac_enet_suspend() and
 bgmac_enet_resume() to CONFIG_PM
Message-ID: <b410053e-9b3d-4f6c-91d8-f7ebf5f796f1@lunn.ch>
References: <20260309090238.719428-1-pengpeng.hou@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309090238.719428-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Rspamd-Queue-Id: E492123A184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:02:38AM +0000, Pengpeng Hou wrote:
> In current linux.git (1954c4f01220), bgmac_enet_suspend() and
> bgmac_enet_resume() are defined and declared unconditionally. However,
> their only in-tree callers are within the platform driver's PM callbacks
> in bgmac-platform.c, which are already guarded by #ifdef CONFIG_PM.
> 
> Match the helper scope to their callers by wrapping the definitions in
> CONFIG_PM and providing no-op stubs in the header. This fixes the
> config-scope mismatch and avoids unnecessary code inclusion when
> power management is disabled.

Please use pm_ptr() instead. You should then be able to remove all
#ifdef CONFIG_PM. That is better for build testing.

    Andrew

---
pw-bot: cr

