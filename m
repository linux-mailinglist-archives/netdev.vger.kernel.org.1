Return-Path: <netdev+bounces-289245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEFKBya/C2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 770DA576213
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 295F43014A37
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B22EAD1C;
	Tue, 19 May 2026 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5ga2gfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502519ABD8;
	Tue, 19 May 2026 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154719; cv=none; b=EYLREYHZjziigcXxY3X/M0C4Okyr+EeXPVTyD0qOl/yPFeLT733pFEIkmYdqPNWDtLz892UH6NLAM70CAFbuhjqCP7IWOWk29ApGQ0aGx/9ZGoKk31WUH8cRZO992pqCHyQEPzAAYBzIet1ytQ0nzyQ+2Xy80A5gRUeSu9lIcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154719; c=relaxed/simple;
	bh=roM10kMm5YyVGLdhjR8TXyPP9G5sDoWThExywBhzVPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amQGKzcurX/8mrwJ9rfNDWBIH94xKfuWy1uBN3HYOqqV67OG5IRwdmw8u/eZPAmB/Z7RFayPUaM3mJI2ZH7Z7Kg0PMu0NwBRQ6Dh4vxPruMd/9CMAKl0adytnOkre0Z1w5uk5cyC8zfQ0kNNGHDuKQVLFIqh+IT+FR1AOSDgJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5ga2gfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41044C2BCB7;
	Tue, 19 May 2026 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779154718;
	bh=roM10kMm5YyVGLdhjR8TXyPP9G5sDoWThExywBhzVPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5ga2gfAjP834pYGD2728uf2yqbij17Mgx+5WAv4+A78SSFjjdzQf0r4xfS71mEsJ
	 ZTcqn84jP4J7TUlkUUrH7cZbo1AT0SNuLBfdIYA0FZGgHtPV5hmD+VMpsdOjhiSZ/N
	 0QZKyhI9ARPLwFOwYrMwhBEZVlI2nyPPmUEqak4asTt/LVUIV7KauDZ74HBaHPX0PM
	 mhBwt+m8qg01n2lSWJ1XPxH8umEPElCgAE4lFdbr5okjqY0AnisIjvOtcEuMjzh1uT
	 aiJfezRmDtDUvOtQvy4MAeZ5yHQa4bBrd9hpu9fFrTd1PzhgfxLYZ7/d9vGKBzhAs5
	 ChqxdUIeKFotw==
Date: Mon, 18 May 2026 18:38:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v7 06/10] enic: add MBOX core send and receive
 for admin channel
Message-ID: <20260518183837.39ee83cb@kernel.org>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-6-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
	<20260513-enic-sriov-v2-admin-channel-v2-v7-6-68b9f4141f4c@cisco.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 770DA576213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026 08:15:43 -0700 Satish Kharat wrote:
> -		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);
> +		if (READ_ONCE(enic->admin_rq_handler)) {

Why do you need the READ_ONCE() / WRITE_ONCE() on the handler?

