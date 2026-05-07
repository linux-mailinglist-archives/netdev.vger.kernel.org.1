Return-Path: <netdev+bounces-285413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJHZJ1a3/Gn9SwAAu9opvQ
	(envelope-from <netdev+bounces-285413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:01:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 402894EBBDB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C78D3300CFC0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636253F166D;
	Thu,  7 May 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKLH0Y8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411603EDACE
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169477; cv=none; b=CZyF4kWA9X2M5sRze1/aQMrXPvuGQPlD57099AA9s0OXzk7tO3fZ7ihy/fGpMv8SRrl9DvG9H0TxURUPrFveB3lUIQbzdQx0EXM+PXSxt8zQ4xXr0Wk3wgvA4CFbwvCOGJ4QQlY+CIIYcfV7kwfhBCF1H1toDjcV0Z9X6+uCkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169477; c=relaxed/simple;
	bh=Gf+QMZ1/yY7+JHZoQhr2wmvlD0Ar6Dya65gRQEh5iyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODw7RAA7rcCQeGzoiJMj0Jv1Mp7VTHKAbeUh2bI2HEVFvxpiCRKGDmaSBPk8hYAgkGYUlD3saSomWkjujjSFsjJbYrMPk7+bTUwlbLEqlsMsZy4gKRt9ltzd1dNxLaF5bPJJT5a59YLho7bqPfMjrEGZI43lQIIgSllCFwvgFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKLH0Y8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFFFC2BCB2;
	Thu,  7 May 2026 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169476;
	bh=Gf+QMZ1/yY7+JHZoQhr2wmvlD0Ar6Dya65gRQEh5iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKLH0Y8M2smyyDLPCsz2FVHtlyUbwZE3lgrxEpqKau5LplpI9Rvh5eQHSHoxlu8hb
	 WXW5QLm6MDG86IYhfo88rjScgIzhV7+Ztlx/9+gCvNjYpGQOPN4oTYQZ4gDP1MywMV
	 KEQv2sbmyq4khKvnBsNDIVyHQcWHSpQk+cOirXA0Iicjn1sQ36Msoix7asLbXByhuL
	 oM/zjetsjssemPE5LyU/ew/VoF5KnHg0IxL/IOR9pTXOh0g++Tga7UuRBUW8uvplYY
	 CKav8OGHzQluAwGED2bqAQTxOJL8S1bQs7zaH7BjHpk2IQzCyu+w3sUwvUHfF2fESV
	 MvbOK35rUWX8Q==
Date: Thu, 7 May 2026 08:57:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/5] ionic: Allow the first devcmd to trigger
 deferred probe
Message-ID: <20260507085755.3717cf80@kernel.org>
In-Reply-To: <20260506035706.12373-2-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
	<20260506035706.12373-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 402894EBBDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 5 May 2026 20:57:02 -0700 Eric Joyner wrote:
> There's a chance the register signature value is set before the
> firmware is ready to respond to the driver. This doesn't mean the
> device isn't there, but just means it's not yet ready. If the first
> devcmd fails, then return -EPROBE_DEFER so the device can be probed
> at a later time. As part of this make sure the reset devcmd, which
> is the first devcmd, is not so alarming when it fails by printing
> an information message instead of the standard devcmd failure
> messages.

I don't think that's how PROBE_DEFER works / is supposed to be used.
It re-tries probe after other devices have been probed. So if your
driver is the last one "one the list" and the system is completely
stable afterwards you will never get another probe attempt.

At least that's my recollection. IOW it's for use when you have
dependencies on other components in the system. If you just need
to wait for you own device to become ready you should simply wait..

