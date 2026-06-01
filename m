Return-Path: <netdev+bounces-293768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PJnGrCIHWrAbQkAu9opvQ
	(envelope-from <netdev+bounces-293768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:27:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4181620043
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FC430062D3
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBA3A6B82;
	Mon,  1 Jun 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rWZQKSHF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43F3A5E9E;
	Mon,  1 Jun 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320053; cv=none; b=rfpfj5/Xwoxp9/miocddQ8Ze3ccZKGcg3ji+ogkZXmaqiZ2JMXtBuO/FqoHjQiVRHRz/IWp9kjtJz4YJXTph6xsNYjav6pq0Gi15b/HxCTO0F8EgdjR14yTrj6ShpK3aCYBVDid41fOIvZPcnEGadmkgCbKzyWV1VF9L3ZPTR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320053; c=relaxed/simple;
	bh=/8WkXXBGMNEjos4GqsQdobIbnS0G82uy0k13iPEouOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvFXg0zCBjb9jN2dU0DRMCbEl3AoingiQQ/ydiii0Lw4wsBxQy1O17JsxQvj6vppgWsIdhNsiios95ysDfoLv/DVTn7FiPsdkrg99QkE4SPd3bpgJTHiTCo4yjl+Fp13EsUYJszR8bXwAmMmw++3XAcp0bB5gVCx/aDwl8tQ0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rWZQKSHF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z6befv/w2S3YI3jUKKvENhs9c0aQYEba8+yvsdx11L8=; b=rWZQKSHFCS1Cq50pVfvYN2moZo
	ZrzwEhk3BIB7Myu361X+lqjWck8WtANPHxWycXJyQDauLVMW6BALxmIJ56mjb8cfAVAzIerPs01PJ
	Q+04TqExqq97UarpXfTpmsvad1gghMNBjZ/ojpLIJV6N4vCVMKI3BIwaXTQH4Tc7BI7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wU2ZU-005Vnc-FK; Mon, 01 Jun 2026 15:20:48 +0200
Date: Mon, 1 Jun 2026 15:20:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Message-ID: <5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601062341.63981-1-justinlai0215@realtek.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: C4181620043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:
> The hardware parser incorrectly interprets 319/320 in a short
> IP fragmented UDP packet payload as standard PTP destination
> ports and treats the fragment as a PTP packet for further
> parsing.
> 
> If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> remaining data is insufficient for further parsing and causes
> hardware TX hang.

Where does RTASE_SHORT_PKT_THRESH come into this?

RTASE_MIN_PAD_LEN is 47, so matches all packets which need padding up
to 60 bytes, plus FCS. There are not many such packets, so why both
this all the complexity and just pad all small packets? Do you have
any performance numbers which show the complexity is worth it?

> Pad these packets so the transport data reaches
> RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
> hardware issue.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Is this a Fix? Please add a Fixes: tag. And base it on net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

