Return-Path: <netdev+bounces-280821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEFiJItZ6mmgyQIAu9opvQ
	(envelope-from <netdev+bounces-280821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12B455A28
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1D9E30C7439
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79953A872A;
	Thu, 23 Apr 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/oE30wg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484E3A7F60
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965790; cv=none; b=RaVNPBasfDvw5KfXzBt03KTBtXOT2OSYMnxFutrqOsfI8P4Ad9G56qkO74Ue8/UHWtLHDll51DbrBnz3jmoaUaJWQn6ehOoAllqhwQhFLWefEhPQ1WIwqsVYs58P7M4QJsMqfgQ2GgHM7Y9OlyFsk1hJEwOmJbI6L0jqdHak7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965790; c=relaxed/simple;
	bh=bIZFMSMGAQM+2T3qmWbdwI10bDMC1V46VUgJWTmMx6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGJGZhb4jqix0A+wJ5KjaVz25dSqH9ALMVfbLzm6mdokT9qNg7WAD42R3v5e9WIz4eLH+YKHUTjWhnHjI+L5YmTZZzRtCCyqbUOIm7/KsRMuRzaCBqQEUV7oho5GbEPSLzWII8NwQzKagOuiF2Lu4BDGZpugZtLG0//yiAPGOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/oE30wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07951C2BCAF;
	Thu, 23 Apr 2026 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965790;
	bh=bIZFMSMGAQM+2T3qmWbdwI10bDMC1V46VUgJWTmMx6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/oE30wgS5BzbtlihveBd+oQsXr1tG9cIo3DN6XgwloDEYXlUOytniIpCPyHDdkp8
	 5Dk2D/5IYIBRJJ4S+kXM+TlKNq91vkL4YCMTGbIdZKfVv8Uh8hoqdeJuXufJczk+w7
	 m7JAlkmr9zvQnknlVsYyDNUsImv5LHLxkKTgjS4vR52xGhzuMlwUn5iDGvf1A53rnB
	 A9krGIbWfEV2VIlhIBmAuo54r+vuNmTLPE5uavE2+OByguonI6vAkf4L+6nzpt+Zke
	 UF0YisZ5Et9tNCSj/L6eCUFVU2tsFcVpoqcLMEMXDF6ekSwJsGGSooL95MofkA+Chd
	 GFz6mk6Mfje5g==
Date: Thu, 23 Apr 2026 10:36:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Ralf
 Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260423103628.4ce6fc05@kernel.org>
In-Reply-To: <aepK3XXc8IFemb1Z@krikkit>
References: <20260422123242.530882-1-antonio@openvpn.net>
	<20260422123242.530882-2-antonio@openvpn.net>
	<20260422192050.7c4ca760@kernel.org>
	<7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
	<9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
	<aepK3XXc8IFemb1Z@krikkit>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280821-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C12B455A28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 18:37:49 +0200 Sabrina Dubroca wrote:
> We could also wrap all of ovpn_peer_add (including the new reg_state
> check) in netdev_lock, since we can't move to NETREG_UNREGISTERING
> until netdev_lock is released (then I think we wouldn't need the
> READ_ONCE(reg_state)). But I don't know if that's an acceptable use of
> netdev_lock.

Yup, fwiw it's a perfectly legitimate use case.

