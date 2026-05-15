Return-Path: <netdev+bounces-288140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ0qJlJ3BmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-288140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407855486B2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953AB305E354
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1D36922D;
	Fri, 15 May 2026 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRNECyVq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11795369203
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808408; cv=none; b=UGBsfHCijjuobwvwZ2n6d5ib/PCnFL138umFRHX7BNq/uMJronDFbjIkfmQbjToJDZy8SrUYEO2l4wMlB7yJeS64cZp5Ywq1iUXhD3Q3e67yaK9s6+4w9qFhy6FIhmVbw+WAbF8HUGTe/pGDgKL2p6BG4SzRYhoMX50M9SmDO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808408; c=relaxed/simple;
	bh=NApG77beOxax8zNaPhifSNX9XvyxZgmWpj+AJ2b/Q5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxPDW49kOem3Pqvcx73039pvGaR/dpbBED8BlbnxJ9MVIrwRFPrwLe8sRc1K76hjXBWILk6WAmTG/IGXX0XfxQjpvStF5B1vzZ3Iky/qq6tt01N1nyee7F1XjHxbOBbWmgDoVhCgJrxiYbp8NVRqOmWmNBKBzM2BKhaiX4IHcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRNECyVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C2C2BCB3;
	Fri, 15 May 2026 01:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808407;
	bh=NApG77beOxax8zNaPhifSNX9XvyxZgmWpj+AJ2b/Q5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRNECyVq8AY0bCkX8p2H3RLIUr2BMd7xEWSk/xRUdn44FJRQU2CLSDPGzcDpn1vj0
	 phBk6v6pYKC5RpivU5k9Km9K2qPPP2jLjoqQk7jCmbzcVRNhSrk+Y3kWuKXttRpDsv
	 GPotEgjtl0K2RkcHJjCpbWAetPMAzf9P6rZyYSZ9fIlXkCkqDtKVQSYRwxCQ4FwkPO
	 mO7kUqaSBsVvXDw+fSaCHAHCeBv9toOWMFYIExtvO7irNwZPC3noRS+lniW1DY6Z/s
	 3oAbs8nRHxTjV5F/7YbAK7HnuaK2RlquIQKt/2uCwH/UbOsCvB3FTE6sQqacA9WJhZ
	 C6AKRD9MkMA+w==
Date: Thu, 14 May 2026 18:26:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/5] ionic: Small improvements in devcmd
 retry logic
Message-ID: <20260514182646.16f8ad33@kernel.org>
In-Reply-To: <20260512224421.25236-2-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
	<20260512224421.25236-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 407855486B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 15:44:17 -0700 Eric Joyner wrote:
>  Another commit uses this return value to help
> signal that a deferred probe should be performed due to the firmware not
> being ready, which is why it would return EAGAIN.

Where can we find that "another commit". Reading this I was expecting
it to be another commit in this series, but I don't see any EAGAIN
later.

