Return-Path: <netdev+bounces-252193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMOKKgajcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:09:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D6619D6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7310C500F59
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7738F941;
	Thu, 22 Jan 2026 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt1CGfZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E97195811;
	Thu, 22 Jan 2026 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054681; cv=none; b=rGXE+AEp/iqdIglgyVEG6uGemzOBR0TIlzMdtpg/ydXv1Kl30UxEaNxufd+9YjOHzpE+4HziisCJ9BXus3pi0z6utKu3IE5ekmjzPvjSEVLFzaxKhXe2xQAYRaQChNtffc/FkF2vdMfuRASzlRdReyI3pY76GDqVmsINjb/xPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054681; c=relaxed/simple;
	bh=gNw4Mn93YzCI8oJeAeU0yYtwdWCHimW6oGNe77uKZa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBvKeljzNmazAY2cQtudfXo5R1eOugG71L2LX5Dmh2zH2s9OZNNQVKDQTVJnuYTeQMH6luempRs915yY7B0rCWVu1PwN9aHa6p1Yum+nBVLLRjDG8sC4YeoVxfcfEp8vvdxfcuZP3n1gZnPje3wAoX1GrCDMfhfoq1pqDDHp+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt1CGfZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42ABC116C6;
	Thu, 22 Jan 2026 04:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054681;
	bh=gNw4Mn93YzCI8oJeAeU0yYtwdWCHimW6oGNe77uKZa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pt1CGfZ0vyBhrqFG0Gn5nrZ09yl5Sm3aBudEWgbbxzlxNpYaBja7iES2Y1J8u6fSQ
	 tQ/CbI9RwOnn/Lf79757S7W7G0X5PTI6+NcdPKsT6pDxvsKjaD0Kjv372N97PTZaDM
	 jHtZ9G2uaTHZHuVurk28yJiEiu3ccbQ7KH9FMghVgq9rP7GVKU2IqpAtGxO9zVVIMO
	 aFyJ8OotAKGg9SalUec5uuSLQhF2btQf5o1xDeI2FxM1GK/t8R6FSDYqS5Z2hzO2z7
	 GhPKpIcFkd2XStdGbLia0x0ukw+x+USb9o54HvqHis3iQEA9NqZdG8UOs1VsDNbvpV
	 MJp/yB0X9vCGA==
Date: Wed, 21 Jan 2026 20:04:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yixun Lan <dlan@gentoo.org>, Chukun Pan
 <amadeus@jmu.edu.cn>, Michael Opdenacker
 <michael.opdenacker@rootcommit.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: spacemit: Clarify stat timeout comments and
 messages
Message-ID: <20260121200439.64c22125@kernel.org>
In-Reply-To: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
References: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 485D6619D6
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 10:17:18 +0800 Vivian Wang wrote:
> This patch isn't a fix for the problem per se, since it is hardware
> behavior. The new message and comments, however, should direct those
> running into this on new hardware towards a fix.

Is it not possible to improve the situation?
Is the refclock disappearing because of power saving?
Or because the link is down?
Because if it's the latter we should be able to skip reading the stats
when link is down (still racy but better than waiting in cases we can
detect?)

