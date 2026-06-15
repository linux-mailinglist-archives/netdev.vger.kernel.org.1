Return-Path: <netdev+bounces-299405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kSjNAwnhL2pwIQUAu9opvQ
	(envelope-from <netdev+bounces-299405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9810B685B52
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=QtP4DHFH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299405-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11AA93008C30
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0523E451D;
	Mon, 15 Jun 2026 11:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF33262A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522693; cv=none; b=Y2HO8z2a/jBQtlagmDU7zonOOHRtTdQw/aAGssykk6yLfw0yM6oqpMQxJZisbpwn5V3f3D0cz0ELX8sVFa6nX/pqH3pn+Sr5SlUqJoxq1ZdzaJ5i6WZtopoY442t+h0bsTyw5pLAzUXkZVbBIikuVLu3bwbMWnFmQQyl7K3Zkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522693; c=relaxed/simple;
	bh=/LsWDg8Z4r4/aZq1N5Rgf98imEnctVngbdNq714rESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCn1QY8GxDXaVz5rCCr/xA20hQVDQWYvmjg5yA82bM8cxkDYyLadaTdkKB8ZmcpoCgrn4SjKAR2w63brUtWSzEDIPrE4iyPUJE/RvZL0WWJvY1/NW2OyY46gs87I+cDvgFFZQWm9tONXZzebslJm6JjlmTlN7tBI9CaKbGBjiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QtP4DHFH; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xnl02vDl8tHcP3eFvIi31Hf07qNa+r6eqOGMBuYfG0A=; b=QtP4DHFHIbs4gmDgs1H51B2vKL
	E7J96FoWMUJ4a+J8DPaffJbc0eceCkXYgPus0GbAvu+hXyIQyn9qMDvYPcn1ISsHCGBZc2tMxavDO
	HS619o7RXsYp1ogwysOzg6tzOIT2NZFT+XT5lpgnRCZiDi/bJutuaGLO/og6aN+izI3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5Qi-007mxk-Jz; Mon, 15 Jun 2026 13:24:36 +0200
Date: Mon, 15 Jun 2026 13:24:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rongguang Wei <clementwei90@163.com>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Message-ID: <df2fe788-34b4-42da-9f46-274abf5eb9ff@lunn.ch>
References: <20260612080331.120096-1-clementwei90@163.com>
 <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
 <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:clementwei90@163.com,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299405-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9810B685B52

> > Isn't a cable length of 0 also unexpected?
> > 
> > How does this patch actually make the situation better?
> > 
> Uninitialized variables may be initialized to 0 by the system, explicit initialization
> is performed to avoid accidents. 

That is still not an explanation why 0 is better.

Maybe you want to change this from a void function to something which
can return an error code?

But also consider the history of this driver. When did anybody do any
serious development work on it? Does it makes sense to do work on it?
I assume you have the hardware and can test the changes you are
making.

	Andrew

