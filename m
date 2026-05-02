Return-Path: <netdev+bounces-283336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KVPqBKJO9WkDKQIAu9opvQ
	(envelope-from <netdev+bounces-283336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:08:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A515F4B08D6
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2CC030090BD
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077C277CA5;
	Sat,  2 May 2026 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdKJhbY3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9F21B191
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777684125; cv=none; b=iDPfTXhViVwvSkBIWtoQJA6Mg0ueEuyQ6yj4hSoSSMxyLCaSjMfzdKMVCa2wMhozZOL0jm1GD1ZtMwrcZFATnLBnxBE0s4KoPYRrjRgWvK4dbPlKEGahYrCefDyW8aJPnC6rU6vQ0MtK0MYPhm7sMCUan4JV5it6J+n7NtzYs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777684125; c=relaxed/simple;
	bh=GE7ayZZUnp1+H5pAYeXAy6WshAkBccp/jibpYS9WOQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsaRAwn9V/okHVi2iCExceo5IXaWk7RfpD9frKZCVlMmMvogStyfvUVh0m7EQNhZsfPd2RztaPDMYHjbqulIkQz/WVq2dpaq1JbWP5K5FgROxh2V/XaHXrLyjN0xnJv/r0Q83zWk7vop1LcK6zw3cLsDHmAHWMOjEEfAgZTM6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdKJhbY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA547C2BCB4;
	Sat,  2 May 2026 01:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777684125;
	bh=GE7ayZZUnp1+H5pAYeXAy6WshAkBccp/jibpYS9WOQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gdKJhbY3EH+xSFrApv2Ujvp9eXLClNlnoaLsDRYTTpew5AG1azLVai0NyjX0Tu/fP
	 JE4IKsgQ3A5D2bbxvZZnFXCVaCOVkP+0QX2TJ+9e8QPGwLSfS4VgIrUo665qL7XeRq
	 wGKIIuBdfwDFB91+uhcCeRvpK/nKzahVHyPhq4FMg9ZSGXiaWbC4mwYBsAHM6UQm4G
	 P6UEQyOSEMpenyGYSl9tIhXJkkef2S8Pnms4ftgqallP+51hYwwgdhRTw8Y8reqxcF
	 7e6kQP31BfQRP/tIH6i1U1xG775TYMkqIIjgJAPo9Gd7C16k4HR961GBcZKjxEdg5R
	 QzWja4y3+2j1A==
Date: Fri, 1 May 2026 18:08:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 1/3] net: Do not unconditionally turn on
 carrier when clearing protodown
Message-ID: <20260501180843.069635aa@kernel.org>
In-Reply-To: <20260429124624.835335-2-idosch@nvidia.com>
References: <20260429124624.835335-1-idosch@nvidia.com>
	<20260429124624.835335-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A515F4B08D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 15:46:22 +0300 Ido Schimmel wrote:
> Solve this by adding a new NDO that allows different drivers to react
> differently to protodown being cleared. Change the core to invoke the
> NDO and implement it for vxlan and macvlan. Maintain the current
> behavior for the former, but for macvlan implement the NDO by
> transferring the operational state from its lower device.

Maybe just me but an NDO for this seems like an overkill.
Isn't our range of options for the callback either follow
lower or carrier on? Do you expect more complex logic?

