Return-Path: <netdev+bounces-182798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBBA89ECE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED58E1900848
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AF2973C9;
	Tue, 15 Apr 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="utNpLyac"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015828E61D;
	Tue, 15 Apr 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721866; cv=none; b=fNvbsWM5DVlfHjyqaghmo/CDA+LWsxbGAMcMpoUO9J9lDPrT9B945vNciUO0zOP3Rr8FdLtHL1OsdUQIqMd8HbyLoYIqowljKcgNA84NMyT+8ZpvnyAmDr7Mb8/sSKEgo9o3bhByENJpmNce2m8/lsn1jhlXE+QObEl+DIYtswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721866; c=relaxed/simple;
	bh=2EOO+sAkwFqCxra83O6A2BDPgugA7NN6ZkUL1xXLrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyy2K6Q48HZvngR1JjR12rQ5uh6kQf3Zw1Bf/FFKP5jXsjQDAjLMyZUjpypq5ePi4qr9mA6wcJ/9MIgKhGrUzJ5vEbLegvEu2sP96B7x+5m0i/o9fAVhFh+frvBA0CCHYBKz73tT4oMU9KB4GLAkt3MJ2Inn30YLXipJMfnU0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=utNpLyac; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/zg+4LuvKN2MfsYaYQDPTMDY3vRum1BuvjjkEVMSOMM=; b=utNpLyacBxVYcE4VG7k4ynrztr
	ZBf69qa3y5t2IoS/iSjBwfypRhUnM3WBelKCWR4xODoRhm5+CZk6ukSO3TpymSQdE71yemvFAi49c
	kmH2BrBhX4cgKRtWcDskgGDDpmfpX2xT/loN6Ucwmp+VuXQnUPSac8o1YhnyqNskJMBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fr1-009RZD-DL; Tue, 15 Apr 2025 14:57:31 +0200
Date: Tue, 15 Apr 2025 14:57:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
Message-ID: <e1389e78-ead0-4180-a652-5dc48a691548@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
 <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
 <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>
 <8c5fb149-af25-4713-a9c8-f49b516edbff@lunn.ch>
 <9de10e97-d0fa-4dee-b98a-e4b2a3f7019c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de10e97-d0fa-4dee-b98a-e4b2a3f7019c@redhat.com>

> Hi Andrew,
> the idea looks interesting but there are some caveats and disadvantages.
> I thought about it but the idea with two regmaps (one for simple registers
> and one for mailboxes) where the simple one uses implicit locking and
> mailbox one has locking disabled with explicit locking requirement. There
> are two main problems:
> 
> 1) Regmap cache has to be disabled as it cannot be shared between multiple
> regmaps... so also page selector cannot be cached.
> 
> 2) You cannot mix access to mailbox registers and to simple registers. This
> means that mailbox accesses have to be wrapped e.g. inside scoped_guard()
> 
> The first problem is really pain as I would like to extend later the driver
> with proper caching (page selector for now).
> The second one brings only confusions for a developer how to properly access
> different types of registers.
> 
> I think the best approach would be to use just single regmap for all
> registers with implicit locking enabled and have extra mailbox mutex to
> protect mailbox registers and ensure atomic operations with them.
> This will allow to use regmap cache and also intermixing mailbox and simple
> registers' accesses won't be an issue.

As i said, it was just an idea, i had no idea if it was a good idea.

What is important is that the scope of the locking becomes clear,
unlike what the first version had. So locking has to be pushed down to
the lower levels so you lock a single register access, or you lock an
mailbox access.

Also, you say this is an MFD partially because GPIOs could be added
later. I assume that GPIO code would have the same locking issue,
which suggests the locking should be in the MFD core, not the
individual drivers stacked on top of it.

	Andrew

