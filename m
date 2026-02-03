Return-Path: <netdev+bounces-256294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB8zEV/2gWljNAMAu9opvQ
	(envelope-from <netdev+bounces-256294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:21:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB59D9DB2
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8595E3015FE0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D83876C2;
	Tue,  3 Feb 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DSo22puK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF0385EDD;
	Tue,  3 Feb 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124582; cv=none; b=jrbW3BAk0ce2p+syCfFDTQjN/s9+gI5Sqrl1RBUxpayaXWyR2zl1jjdSeKCkFz9sN3Ta/Mwl9BIed9ntoVQaIeyLlBe8SY/+DZXgqYwCMhdDGVgVXpDAHI1jOwDf4oxgmGNgukeqLD6Wd5L24Ok8E0dq0zILqdwQy5rRzualQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124582; c=relaxed/simple;
	bh=HDPneb55qtgvNu3+d9TVk6u81VfL16ep3qPvTyk+8uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTPtJW39ztqwkaK59gzDlViQj+5s24jKfFUaBROKuD28KLUAdHK7r6deGEa9fCinjEPD6hkMBQPzVIqiEpBB0eOxZzWtwiABiry02MPOzy0dwHSLQNELvRhxhn6ZAbCta3m7AOy/pE7lgX/qyHXpsleEvJ5OYAGH1l0GoXKGWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DSo22puK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DqEfoVQW+S/wbK56us6FBxe4eLE4pqP9qq5Ho+feXg0=; b=DSo22puKAJc6J757xa9dy+juua
	N2WMkIep7hEbXa7+auSowaMb+3Peyv9KGFR2dXunWxoLrJXF/S/oH4DKNVPhbrNaU6mZsXsHSW6Ro
	8VZqdy47XMKB+Hfk2dnd/1a9YbYeN0uX0b3xS9wAIgPckBzrmrj0UGRGAi1XF6tpE0/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnGGB-005wry-Ku; Tue, 03 Feb 2026 14:16:03 +0100
Date: Tue, 3 Feb 2026 14:16:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Min Lin <linmin@eswincomputing.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk@kernel.org>, Bo Gan <ganboing@gmail.com>,
	=?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <dd8e35c7-d7a9-44d1-9929-5a6a1cfb4f05@lunn.ch>
References: <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
 <009aefc4-fbc9-4f91-9230-23d18c281bf3@gmail.com>
 <73ea5619.2b71.19bf847c80d.Coremail.linmin@eswincomputing.com>
 <aXeydXuWEMDz-yVM@shell.armlinux.org.uk>
 <32a1f814.2c79.19bfe173225.Coremail.linmin@eswincomputing.com>
 <973f2b4b-bf8d-4a77-a27a-47495bc21ff8@gmail.com>
 <5c835fe9.2d60.19c0325df03.Coremail.linmin@eswincomputing.com>
 <43c97440.30bb.19c221bd137.Coremail.linmin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c97440.30bb.19c221bd137.Coremail.linmin@eswincomputing.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256294-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,gmail.com,eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 5BB59D9DB2
X-Rspamd-Action: no action

> Do you think it would be reasonable for eth1 to have another different compatible
> string, such as "eswin,eic7700-qos-eth-quirk"?

I think you can argue the two Ethernets are not compatible with each
other. But i personally would not use 'quirk'. Maybe something which
says how they differ?

     Andrew

