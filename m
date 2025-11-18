Return-Path: <netdev+bounces-239507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697CC68F46
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 972572ACC2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C42D978D;
	Tue, 18 Nov 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="aEVpzY/S"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779DEEB3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463673; cv=pass; b=Lj9hkhbFThLopTfni/uoMT5/bH3wVhKPYPRnOak30pBlvDxViSmEp6ezNTFg9YXjX4yuHZ9f/oxi/qRkXdyYTSXCwHctrvxf2LjGtYqDFld+ecpQRhoyhozBMzbbamf92Fio8lMXogHSTAeCjiv7K8qrJdxeDYRhuQDxjBO1T1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463673; c=relaxed/simple;
	bh=IUNUMAVe+omibHWRcimXmSoMKQtlhtj9ipHTjfgpzzQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pVuA7Hh7OhNtwOCQy1QYizdt1h2yZWoxAlgYZT0brmtND8Lbkqtn89haw9oKY6YXi0QMP8F7279Os/AKSuRmaUdpHOA4jfVo30SQSJPAqNT8fLJJe7ZIR5rOmag00huIUZjwJsPFlJXVykZriFhffM+lY6c1wU41JG44JgTwdP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=aEVpzY/S; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1763463633; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IPFBaiuxgZp7VhDm/2Yv9CoOKHQDfL+b7loQh96oJRBx+HNkm45vKHHSVGH1a+agYr8Eu0T8raGaXbjSjEFcVyaT4Ko/NBkjBOihnQNIr/J6mTFLEqxrGVVA2cvCOPFstVyqLZKJysPDJugkO25T0JYJqLet/gsr5nbXq9Ftxxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1763463633; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IUNUMAVe+omibHWRcimXmSoMKQtlhtj9ipHTjfgpzzQ=; 
	b=F6CJMTar3pRty0Dkgfh9TcfDXibVogdhOHNUoB+6tCBC9plUjOqkkl8QfCipZ7FMiAxaxcdTtNefhyTWQfPNr21xdY6OFERf0POdJqfmdF0m+u5yVvMZ5kxginCMheoxTMqOXFmpI3uLd4AZkQHO4hqdNL8c5rAY+nno8YMrcR8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763463633;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IUNUMAVe+omibHWRcimXmSoMKQtlhtj9ipHTjfgpzzQ=;
	b=aEVpzY/Si5iehy7j9pXeiOt+iRa3K+hFe/DY1RDaSbbiXcBzvNoSWHrSMzVUkJZy
	FSDdRd9+J57nJ2xo1pTmYUpQ3yQjYFBSg2Jqa0iIa5fgreUX4rhHM0D8C+wr1VGmEQ9
	Sh1HtkX/y+i/HEv5jZqHyZTIMJQEzf0rqQ2TB+X0=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1763463631338149.69069901999615; Tue, 18 Nov 2025 12:00:31 +0100 (CET)
Date: Tue, 18 Nov 2025 12:00:31 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19a969f919b.facf84276222.4894043454892645830@azey.net>
In-Reply-To: <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org> <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-18 10:05:55, +0100 Nicolas Dichtel wrote:
> If I remember well, it was to avoid merging connected routes to ECMP routes.
> For example, fe80:: but also if two interfaces have an address in the same
> prefix. With the current code, the last route will always be used. With this
> patch, packets will be distributed across the two interfaces, right?
> If yes, it may cause regression on some setups.

Thanks! Yes, with this patch routes with the same destination and metric automatically
become multipath. From my testing, for link-locals this shouldn't make a difference
as the interface must always be specified with % anyway.

For non-LL addresses, this could indeed cause a regression in obscure setups. In my
opinion though, I feel that it is very unlikely anyone who has two routes with the
same prefix and metric (which AFAIK, isn't really a supported configuration without
ECMP anyway) relies on this quirk. The most plausible setup relying on this I can
think of would be a server with two interfaces on the same L2 segment, and a
firewall somewhere that only allows the source address of one interface through.

IMO, setups like that are more of a misconfiguration than a "practical use case"
that'd make this a real regression, but I'd completely understand if it'd be enough
to block this.

