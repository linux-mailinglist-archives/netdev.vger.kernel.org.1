Return-Path: <netdev+bounces-288347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPf4MgxAB2oCvAIAu9opvQ
	(envelope-from <netdev+bounces-288347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:47:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E115525DD
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C45B303AF83
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4053F9262;
	Fri, 15 May 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TeRb9AF3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F53F86F1;
	Fri, 15 May 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859365; cv=none; b=LxXj35cW74vEgHFfZvbePkPs67DkTVWOMmba0yqB9k2FJH5yrhsIdz3NQ6aupiAiJpBGD9KTrPks98HVDG77CPlWFE+5NN2Vcp2nVxqBbokTjVDPSMt9UQwFA2jqJX21suk6701t/VTIoj0JWl4wHyRfWKCajFG5JiM0aK5C/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859365; c=relaxed/simple;
	bh=l8VkPLld4hjvvdPlQLvoSP5ZeyUBY7LslnUOfwHo8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3uTuZSCw4IUsJhXkhGkZT4r4FA8udKacvPSCguQHByF7SB0g/7vkgNlK/FYZCo3Dl429Sz3+03YSp6BWNknM0TL47oi3ANzSbpDDC0tD/G7+Pl2dELlWj5hXPhPHJzD9hGEa/oaaMOIsREyjhrghtC2Eq8kmFWpNjcFjkyNvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TeRb9AF3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3mNCRFoPPfrcZYZiojI7XDP281Kb6OBeB+IePmQYfqA=; b=TeRb9AF3Y101W9tklLe/NluDbt
	Thn14LpXFk9VHvLBdQiVmdQAzFC1XnVAcVtElRBlfCJqZ+TS4wEO385bPOKD9DNW7eIyBWEuV8CON
	vSF7gtb7sJ+BOLvIbef/9L6fpT42lzHFs2qV0sE7A+OAYO2PWsYOb/HDb5oYBxjjmOEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNuZn-00359q-H6; Fri, 15 May 2026 17:35:47 +0200
Date: Fri, 15 May 2026 17:35:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in
 setup
Message-ID: <ccf88f9d-9617-4ee9-bece-d2e41081bcd2@lunn.ch>
References: <d979651d-bba0-4042-8e72-609b56121682@lunn.ch>
 <20260515145042.3091827-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515145042.3091827-1-fidan.aliyeva.ext@ericsson.com>
X-Rspamd-Queue-Id: 72E115525DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> I have one more question; now that mv88e6352_g2_scratch_port_has_serdes()
> never returns a value smaller than 0, should all the callers be aware of
> this fact?

You could make it a boolean function.

Shall I change the checks for return value on this function not
> to check for <0 ? All the callers except 1 will be refactored to use
> serdes_get_lane function later, so it might be unnecessary.

but if the code is going to be refactored, it is not really necessary.

    Andrew

