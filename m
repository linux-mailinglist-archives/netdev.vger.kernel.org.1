Return-Path: <netdev+bounces-268855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCh7H9ALuml7QwIAu9opvQ
	(envelope-from <netdev+bounces-268855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:20:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775F2B5261
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73E4304D965
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A826ED3F;
	Wed, 18 Mar 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcCEPOFo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7F26C3BE;
	Wed, 18 Mar 2026 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773800389; cv=none; b=WeiY1L/4Gk7TiZudHtJ27vjfrRYfZjx528nfwmCMuv5YcIia/RXWnROspHvP7wu2a3FL11YNL0aXvoIRxCzjNVReN5noiCLV7NpFyq5x53i6dpk2WzGOL1Ja846Md5q3kEwGvHfp+luomOfLv3rxxyFZwcVAKrZaHjcMTO1UxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773800389; c=relaxed/simple;
	bh=5AMRuC9KN5I6BUZQ0uNCL0Bhon0H67blTHq06NTIBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVIhAdRI0wtzOCdlbyNBQmjUtXOvz1891h5WzNSqivTd9y8JxjXkuPvyajYOFIeHcAybq/JFHaC6NHjp6sgl73aaUC3T7gL+JyTu+lwnRATNKwNjae3ab0wCn+3Jfh/xxgMtYUA09dZgGUt3oa4XLqmu8yUUyiozrRFjGkboArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcCEPOFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06883C4CEF7;
	Wed, 18 Mar 2026 02:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773800388;
	bh=5AMRuC9KN5I6BUZQ0uNCL0Bhon0H67blTHq06NTIBG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GcCEPOFoUPxdSjc2oAMq34tuEt5NKWU0QRfDmQsoE7otQmLwYx16btWbkHWMPZV8R
	 i0L0Ck36DdgXgGJGpwAlIeTbR9TZ8cmSgTB1lXew5UDQK8auk2EiodhFgvMvNfJzhQ
	 kcbkCNlG2x6eLftxjk7mXxJ8H3o35Ri8mPU66gTX1zIYRvVdIJ7NWHx/isF0poeS1f
	 YFpY7jDZCM0rBofkDh3S5SyVrf89O1m8KDRA66eL/bcIs3y7a95ymuadk9rd3N4Oou
	 OL/nI6o6VRxPAAVFUSZ86isAD/cw8dG0maQpycTkpQT1Wr9bQpejxwKHl8iSvuApND
	 gsZlZuBDEbW6Q==
Date: Tue, 17 Mar 2026 19:19:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/dns_resolver: clean up and simplify
 dns_query()
Message-ID: <20260317191947.40fdfc49@kernel.org>
In-Reply-To: <20260316213846.1049655-3-thorsten.blum@linux.dev>
References: <20260316213846.1049655-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,sony.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268855-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4775F2B5261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 22:38:45 +0100 Thorsten Blum wrote:
> Fold the name length checks into a single early check, and use
> kmemdup_nul() for name-only descriptions and snprintf() for

would be easier to review it if it was two changes but..

> "<type>:<name>" descriptions to simplify dns_query().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.

.. we have a policy against encouraging trivial cleanups.
If you can't even test this let's not bother.
-- 
pw-bot: cr

