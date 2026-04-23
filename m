Return-Path: <netdev+bounces-280574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DqD9FgiC6WlbbwIAu9opvQ
	(envelope-from <netdev+bounces-280574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC22444C40F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 542A13004F04
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776823817E;
	Thu, 23 Apr 2026 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPlylZQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FE20C00C
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910852; cv=none; b=ekg1tq/wKe5cGvHPJ3ID8cZLEhNHoNSS1x31wM/kRTkhWMwa5tztA1s0uI0xYF4+W7kZdDmc+9ecUNGbg8pfL5DlYNVHrtFeD/nMmkdulFmY7kx+uFGSa29D3t7FKQP7SiQozgNcrzwGWEXbuMUrBnIl+zlNZoC9Dm6OxqwLZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910852; c=relaxed/simple;
	bh=FwZYiq6hcAiIspx1Xi0htTl4+gP/1VfUkE1SSkVmTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+t7R84A0jyM4vUVQHlDPOQnFw3oBm3VoDyZ0PjZcF3x28kuRh2qcE52MIpGWAGDJMcwnHbFAxYSA0/S47d2xh9Hu4MQTlCIyehFwhEKRILYaceH7cKiXbfgc8UWwD5paQJpfcaQ2VMJ6lRrWz1jQDaRaCsdtOeFegedNgFv38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPlylZQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBC1C19425;
	Thu, 23 Apr 2026 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776910852;
	bh=FwZYiq6hcAiIspx1Xi0htTl4+gP/1VfUkE1SSkVmTkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPlylZQkLAiQkw7F+RcdRkuI9PAOb3btijHgCXvzK13FZIaZWWh4LXllYIGt+eLwB
	 fAdqftVEJPdbIrc+MiTIETtzF03tLK1U8+v1Ny9+f6rZDsANFKA4IswTv++bTBjocW
	 TTM6JhwpIX69n0iTdhcK0MAslQjkIZOwuCveSblx+R0gYyNm1nxLZoWK/wkEZ+dc7b
	 vgPf2LyXgKPSWzH9nmuJUrvCZp8SfohHu7KISyvd62F6LNcV0VDmA7tdcmK4XZf8ry
	 +BmyBPTE6a2wjFsDRmxQjTJ0rW8EeSMMZzx9189k1kxS5445l/J9orGpPga/lj7VKE
	 grGFzT5qMQwuw==
Date: Wed, 22 Apr 2026 19:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260422192050.7c4ca760@kernel.org>
In-Reply-To: <20260422123242.530882-2-antonio@openvpn.net>
References: <20260422123242.530882-1-antonio@openvpn.net>
	<20260422123242.530882-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,queasysnail.net,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC22444C40F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 14:32:42 +0200 Antonio Quartulli wrote:
> +	/* Prevent adding new peers while destroying the ovpn interface.
> +	 * Failing to do so would end up holding the device reference
> +	 * endlessly hostage of the new peer object with no chance of
> +	 * release..
> +	 */
> +	if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
> +		return -ENODEV;

AI review suggests wrapping reg_state read in READ_ONCE(), I think
that's legit. Also nit: I think > or != REGISTERED would be more
idiomatic than comparing >= UNREGSITERING ?

If you agree make sure Sashiko doesn't complain about anything else
once it's public:
https://sashiko.dev/#/patchset/20260422123242.530882-2-antonio@openvpn.net

