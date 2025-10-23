Return-Path: <netdev+bounces-232179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0CC02143
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AED9188DFEF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F633858C;
	Thu, 23 Oct 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="j3/oQ74H"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF9333736
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232871; cv=none; b=B8+HNoLPSGBkkj2L/UZlI/uAsmxqsK1Nr8MRrY8oS49A2PxiunrIBx+kMbHorat84YuUweG9DiRpdueLy7HmQazsMVPZY2tPE6+n29EUb6UqIXxUbHTSvGvOaNkqjTG5o63rl1oSMsQXGoKuqswX0cK00MNxqpLxiSjR0Opycjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232871; c=relaxed/simple;
	bh=G3vVaD7ixpd4+xuP9GGFwzUQu6SiNlgz1X5/g/M73So=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cef5Gl5ZKl+ezHoVr17YhciHqbTSii310LGb5wvlMnhZw7dCBa60VynaPAieaeroITXgT007fd3KlD35D2xhL54sk7nf6OWQ5VGIpsJXLw+Zu67N9W30R0/HwOdOzoRtwOc9jWYF+nO7eJ+kB1xJlwO0pKMKNONEWsMlhSM6mZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca; spf=pass smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=j3/oQ74H; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4csqJ31X9Gz71d;
	Thu, 23 Oct 2025 17:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1761232307;
	bh=G3vVaD7ixpd4+xuP9GGFwzUQu6SiNlgz1X5/g/M73So=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=j3/oQ74HQhySFFhlzZWg0365cAlnfEWVMCe4W/nMfehHl2Rsv74BYrJtHkFeuB88R
	 78WpgT3IuJHUvODWMVA9wpWinXKYFI77oc5aBkP/tLwPkPBpQgKd0TBLzU16d6plax
	 2zYsOlxhhZpJVuI+7hqN/XxtFUDKkbr1pVd6/s74=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 1.206
X-Spam-Level: *
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id 3JMFke1VBXZh; Thu, 23 Oct 2025 17:11:46 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 17:11:45 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 1685E177A1D0; Thu, 23 Oct 2025 11:11:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 12D5E177A1CF;
	Thu, 23 Oct 2025 11:11:45 -0400 (EDT)
Date: Thu, 23 Oct 2025 11:11:45 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>, 
    Andreas Steffen <andreas.steffen@strongswan.org>, 
    Tobias Brunner <tobias@strongswan.org>, Antony Antony <antony@phenome.org>, 
    Tuomo Soini <tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>, 
    Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
    devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] pfkey: Deprecate pfkey
In-Reply-To: <aPh1a1LeC5hZZEZG@secunet.com>
Message-ID: <a8d32543-f783-9039-56af-ceb5e45e207a@nohats.ca>
References: <aPh1a1LeC5hZZEZG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Oct 2025, Steffen Klassert wrote:

> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let config NET_KEY default to no in Kconfig. The pfkey code
> will be remoced in a secomd step.

No supported libreswan version still uses the old NET_KEY PFKEY API.

Acked-by: Paul Wouters <paul@nohats.ca>

Paul

