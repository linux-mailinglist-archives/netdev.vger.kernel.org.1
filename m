Return-Path: <netdev+bounces-164723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98FA2EDA3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC483A217D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059082253B2;
	Mon, 10 Feb 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z5QisoNQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAB225384;
	Mon, 10 Feb 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193877; cv=none; b=JhUcAjHQ/nFNOn/kt2HsR4bTHueW1iebTKschGv1qDrbMc88ky4ykoGYjELN6M9P6tuuTfnPIr6q+slFmvxKJWA+RL/YwnOfNZZp/dj/c0IR4EiT7O7+pTV6NQWhKpGfeMBa4jpMNs2iP2AXPVcJEBY+LEQb1IfKqEikW8BVEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193877; c=relaxed/simple;
	bh=3vTa1OmPa2IbVNIroF/LkJXvrC0UZYwWBhaau487Xxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkqR0og1N2ZHU9fxO3+/CRBzsJCb1KFLE61AsLuGaH4S9LjxXZMP1CFVpq3Fyn/hLwGwemvIN3yyW78UZOGWYjP589XG+uXCHIjMzE43ckJF3PdZgtUqMjoIZ8NWDYCeILApSbn2KIIh4qMF8Dg4gSr8eWrgrLV4ByZwYTnUgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z5QisoNQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jt6pQHoQVd00iFlOT0zKR71VJA5KHbXP387LWjI2wQQ=; b=z5QisoNQ0/YrhBAPBpWuEN7Kad
	nBuGUOEmIWDpWL4KSa+eVE00GHWoPktI4ietdBcYAILpJsvmQszRnQAX5ckDMqvC/8KmNhywc28Q7
	JCvb5nUq5gUvERun7RIXKSzqFRaDoN6NhP3CtEUbaYSD7RXWHWc1mk2Hofu+BPRQ2Zuk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thTlo-00CiYV-0K; Mon, 10 Feb 2025 14:24:16 +0100
Date: Mon, 10 Feb 2025 14:24:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ixgbe: remove self assignment
Message-ID: <a9070724-b4b7-4a23-8ed4-b6464175b660@lunn.ch>
References: <20250209-e610-self-v1-1-34c6c46ffe11@ethancedwards.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209-e610-self-v1-1-34c6c46ffe11@ethancedwards.com>

On Sun, Feb 09, 2025 at 11:47:24PM -0500, Ethan Carter Edwards wrote:
> Variable self assignment does not have any effect.

Hi Ethan

As a general rule, it would be good to explain in the comment message
what research you did to find out why there is a self assignment, and
why just deleting it is the correct solution.

There are somewhat legitimate reasons to do a self assign, some older
compilers would warn about variables which were set but then never
used, for example. Or it could be a dumb copy/paste error when writing
the code. But more likely than not, the developer had something in
mind, got distracted, and never finished the code. Which appears to
the issue here.

If you cannot figure out what the correct fix is, please just email to
the list, Cc: the Maintainer of the file, pointing out the problem.

    Andrew

---
pw-bot: cr

