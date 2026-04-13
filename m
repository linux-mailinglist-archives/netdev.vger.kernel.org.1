Return-Path: <netdev+bounces-277939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EujAZ0z3GlMOAkAu9opvQ
	(envelope-from <netdev+bounces-277939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:06:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5A3E6743
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E877A300334F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D0125D0;
	Mon, 13 Apr 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ScsfKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA41DFF0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038809; cv=none; b=Bdd6xoEQ0jREC3q+hgjObfvld7FY5InuFNG422kQAskvwCHiVDU+oOI60oYk0qplvzbJ8hUscqirp8YgIAqZ+lPinlZ2X7ln1ANp3Wmo25kc+BfJHjU1AkvvzPkhfiI4So/nXdbXZfAjAveH3HhU8XFpn1VtDfs6M21/aZGG97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038809; c=relaxed/simple;
	bh=DthFOMLc2Mv6YnNW0QLRZ7pCzEt8OEiySSjyMCuBaZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMTrO1zMJo4Uimutb93U++sldBnL6tCMKwASPSkcGcyYnRNFHbwwqJV5bR3eRCuegcOrfDmxiHsRckFxlqlmLbNgnF+5EBAJG3in+UHsaaUeZObJuR09vn2/gRRARnrJ4wZ6uw4lwUUqHgfORdHP2cPVCOFQKKmG3UeUtNShezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ScsfKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB2C19424;
	Mon, 13 Apr 2026 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776038809;
	bh=DthFOMLc2Mv6YnNW0QLRZ7pCzEt8OEiySSjyMCuBaZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/ScsfKQQB6t0ZkxMSDDKpG6ZdJApnHZ0QtHVL5mVDt+YRENC0P0YKOdKVuyzIxGT
	 AyVROEOc0TP8EkcZxEBzqXgpmGiVwvYi2FD3JonlY508ower/0KqSKLVUl3V7oKjhT
	 w49lfKjP14ooOMjDeyil+pCWjQNx9tlioVXjRRbpvs22GvAkZxTKmEuSDvtf1VOndm
	 UUzs0Jfmtu1sXCJtyFNGPXY0+FEwBzYWFh5b9BBWCIqM8kKtGX2sASoAm5NRAFQF1v
	 ucGHskXMnFJdv6nKWuGHkD5SzN7pN7BYR7o1plAvy2IkG2HadaKS9CjyAj6SWovj9Z
	 dRhUB6bPoTvfw==
Date: Sun, 12 Apr 2026 17:06:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Vollrath <tactii@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 hkallweit1@gmail.com, andrew+netdev@lunn.ch, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v3] r8169: Use napi_schedule_irqoff()
Message-ID: <20260412170647.37e73644@kernel.org>
In-Reply-To: <20260412232914.31463-1-tactii@gmail.com>
References: <20260412232914.31463-1-tactii@gmail.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,gmail.com,lunn.ch,realtek.com];
	TAGGED_FROM(0.00)[bounces-277939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92F5A3E6743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 19:29:14 -0400 Matt Vollrath wrote:
> napi_schedule() masks hard interrupts while doing its work, which is
> redundant when called from an interrupt handler where hard interrupts
> are already masked. Use napi_schedule_irqoff() instead to bypass this
> redundant masking. This is an optimization.

Linus tagged final v7.0, net-next is closed. See for more information:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

