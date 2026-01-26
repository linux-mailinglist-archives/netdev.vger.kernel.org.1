Return-Path: <netdev+bounces-253309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD35ExbTdmlsXQEAu9opvQ
	(envelope-from <netdev+bounces-253309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:36:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED5838B5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08F1D3000FC7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87F1A9F9F;
	Mon, 26 Jan 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4FmDsQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866992AF1D
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394961; cv=none; b=XIphsnSCQCfox0HlwetvTahe1OEkAKeUjK1KU5ojmwlHBELrXMA9njs3P5AmSF2elliJYEuVbdQeLzczyqC5hceJcr2bKK6f0Vns/0DjY+fKjTlJXe/XXL4jBzfjz1UW1dg7lHpQcCx+SVIgKfLBPG0Gt6KS9K9P9C8SNV7qrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394961; c=relaxed/simple;
	bh=10UDNIO0jdI0YbXilxQXPKcYJR9ms4AK1Oj8smauf/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjS7DtJLSHvh84QSe6/nxgsspGnd+thppGCUoTdfYdl3nylGOrXkD/HTmQ0+5Os6PQBncmRROmAVJV8eJyyx4ujKtYaig2Koe8RUt+PJJiOvAsPUgDNOV7WX8f08s+H2hEs9zrbrCEk1C8LOemc83QLqgDHNF9Pzp8M1ve0NL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4FmDsQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C1FC4CEF1;
	Mon, 26 Jan 2026 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769394961;
	bh=10UDNIO0jdI0YbXilxQXPKcYJR9ms4AK1Oj8smauf/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H4FmDsQiDT5xOYS3xgrOeFuYECwKAmgEIm8rqdGxlOAArEnbWSNvtpmiIYfCeT7tw
	 UZ1T/7aUetmFccOZI8Tx20MfkutKT2ZCXEjus9OIxNN23d/68b4TQpqfcOEBXFO3K6
	 Pdri4T7Sx4kB2XQt7S+iPpo6qII3+jippIAYCpeeMWY9sbfcY94EiLQMuLtE+yXkvp
	 pcQX8Che05ttUEJjQifKzAK0DLTJ4oIi/NGzuELf1ahIwF3hdMus4AfNd7t0ovpLa3
	 xuWjj4uDWcfcG30ylktkWTYtRVIaV/aHEy/cq8gN7OuNns8ghgxP/Dw8sMA+8eK3fK
	 iPkUhp1hF1kdg==
Message-ID: <64f626f4-5432-4335-b6aa-af74b49b4a5e@kernel.org>
Date: Sun, 25 Jan 2026 19:35:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering
 slave
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
 <20260125121551.GA83275@shredder>
 <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253309-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2ED5838B5
X-Rspamd-Action: no action

On 1/25/26 7:35 AM, Tetsuo Handa wrote:
> syzbot is reporting
> @@ -1330,7 +1330,13 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
>  	__team_port_change_port_removed(port);
>  
>  	team_port_set_orig_dev_addr(port);
> -	dev_set_mtu(port_dev, port->orig.mtu);
> +	if (unregister) {
> +		netdev_lock_ops(port_dev);
> +		__netif_set_mtu(port_dev, port->orig.mtu);
> +		netdev_unlock_ops(port_dev);
> +	} else {
> +		dev_set_mtu(port_dev, port->orig.mtu);
> +	}
>  	kfree_rcu(port, rcu);
>  	netdev_info(dev, "Port device %s removed\n", portname);
>  	netdev_compute_master_upper_features(team->dev, true);

same logic as bonding, so a netdev based helper that both drivers can use?


