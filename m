Return-Path: <netdev+bounces-296389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id blxKAqBuJmrDWQIAu9opvQ
	(envelope-from <netdev+bounces-296389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:26:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B0653856
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=TWoLZun7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0F53301FF84
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCB38A739;
	Mon,  8 Jun 2026 07:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C0378D9F;
	Mon,  8 Jun 2026 07:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903384; cv=none; b=f0Yhcr6LiyVPlrJQLVzmfahbNOUDAOulDgVZ70yPAisgU7p4BH+bLdVpZDYh7RQm1TM7KDW59h5nUedG3DHPFCRr8Qk+V8TcKSAF2vwblznymj288GyYdikHHyT3WLPCgsom5phm5gfv2e5+PbsJR9JqZJRtx2q72pmC3YrxL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903384; c=relaxed/simple;
	bh=kKGitt0wwl5B4OQ7dh4T+3ojyopcbEz25bPRkuVE29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNCMHVUiKfFUg+fr3EbcVN2GmnRAsL5GXFQIFWPJmO6YwV4dFrtcBjLfiU165VT3mbvPfaXwTtuJlSxPh4BRxaEdoV9kstpGhFPx/fi+Ne4cE4vWxn6Hzq0Kz/bBOIsN3Lb8NGHhJSvJYScdhluhfkDSrY7vjYpSr+qqeGMuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TWoLZun7; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ISh6jAJxakG5bT3u90PueAZOMiPTvwaHF+917dlM7t4=; b=TWoLZun7Tb/W8t7R+XAtl9kGoi
	aQdT7YaKTZTBhn2noZ6VpegpeEchLhrhEQ9sYgodZZoEC5syRq+8E3ilnxothCISoLgiWvM6+zwKB
	jPScMFaVIgmO+jz43MXKCq7qXBlaHbLUoJaCGap1tt8ENnFueIeloeVBINr0GkdgM9qE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWUJo-006Zqb-Vn; Mon, 08 Jun 2026 09:22:44 +0200
Date: Mon, 8 Jun 2026 09:22:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Message-ID: <42edaaaf-af15-4855-93db-493a0fd2d498@lunn.ch>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
 <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
 <CY8PR02MB9249DA24FC3E3292FC2D7628831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <DM4PR02MB9263A6240C8D09E368B6F980831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR02MB9263A6240C8D09E368B6F980831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296389-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:rdunlap@infradead.org,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[infradead.org,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8B0653856

On Mon, Jun 08, 2026 at 05:10:23AM +0000, Selvamani Rajagopal wrote:
> 
> > Subject: RE: [PATCH net-next v4 16/16] Documentation: networking: Add timestamp
> > related APIs to OA TC6 framework
> > 
> > >
> > > Hi,
> > > These needs a few additional blank lines to avoid docs build warnings:
> > 
> > Will do. My bad that I didn't verify with make htmldocs after editing the file.
> > 
> > >
> > > Documentation/networking/oa-tc6-framework.rst:554: WARNING: Explicit markup ends
> > > without a blank line; unexpected unindent. [docutils]
> > > Documentation/networking/oa-tc6-framework.rst:561: WARNING: Explicit markup ends
> > > without a blank line; unexpected unindent. [docutils]
> > > Documentation/networking/oa-tc6-framework.rst:566: WARNING: Explicit markup ends
> > > without a blank line; unexpected unindent. [docutils]
> > > Documentation/networking/oa-tc6-framework.rst:573: WARNING: Explicit markup ends
> > > without a blank line; unexpected unindent. [docutils]
> > >
> 
> Randy,
> 
> Though I fixed the issues you pointed out, I couldn't reproduce this issue with either "make htmldocs" 
> or with "sphinx-build" commands. 
> 
> Am I missing something with respect to how document generation/verification is done?

Try

files=$(git show --pretty="" --name-only HEAD)
./scripts/kernel-doc -Wall -none $files

This is what the CI system does.

     Andrew


