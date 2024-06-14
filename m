Return-Path: <netdev+bounces-103439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F9908089
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4671F224DE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E5158D84;
	Fri, 14 Jun 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrulnHbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3B2F2D;
	Fri, 14 Jun 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327608; cv=none; b=RhTrNMTHeqkydaSUoqIAQAX9plK8aTKufThHkjk1nCQbjePcsFQZ9afDad7J7BDPD7rYmZgKmTlcESEQobPEEDLCr0+kdUmQqJgxTtCcFpzz8Fx6Yji7QIJ+55GR2tBdR9xfx/P85jVLM3HDQ899ckEf8kE/zYp+N3DmIrsnLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327608; c=relaxed/simple;
	bh=Jks2OG6bzc2bLod6lfT5SvpLXqyBjbxR7OYwPE96dXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsXAyN8HwbQCjfbBEP7hZt04vC3eBPQU5W3w2hdgF20QauX9RshXtD3wSMXCcOPodvtnqmIfAr+YCKcgUBTnXz9Kzg2qyRVOCFg8yaM+7cu60Y7csVIn/f2IHaIHNuwbPvuY7hGMMsmtKgfO0hfw9VWi6RE0YxXh4Pl6uHXXeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrulnHbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53290C2BBFC;
	Fri, 14 Jun 2024 01:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718327607;
	bh=Jks2OG6bzc2bLod6lfT5SvpLXqyBjbxR7OYwPE96dXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WrulnHblhArEaHO0Np6NBt99Ml03h4HKeVRDldktGWL9z/EwgtDVJAtVQVevZoQsU
	 CeePLfUN2gjEBDWFIHYSJc4pZC3hpaOVX07mKVr1lWLu1WgUlsNMivOopPV/7sBlfn
	 icPKxVhHUwQLZ12+RcFqbUk2MdnH9Nb0TW0AUIGpi652NlK4aS7C+KpzhkV6BR2PAE
	 b8PY1mkyYZwrrifGhI0O8i3k0sJib9591Bl7QJ7RQBCg3wxHiFE1aYA5/fH5/mjvZl
	 Sg6XC9QQxPNU6d2uACgdX6OZ1UVFTJGXUYwzBOZcKH2QnbRSlFpCz/3lRJBErP7srH
	 iJjsrYS3ZwwEQ==
Date: Thu, 13 Jun 2024 18:13:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 04/13] net: sfp: Add helper to return the
 SFP bus name
Message-ID: <20240613181325.75370535@kernel.org>
In-Reply-To: <20240607071836.911403-5-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 09:18:17 +0200 Maxime Chevallier wrote:
> +EXPORT_SYMBOL_GPL(sfp_get_name);

Russell, there are no in-tree module callers, do you prefer to keep 
the exports for completeness?

