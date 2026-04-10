Return-Path: <netdev+bounces-277211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPgHLXdm2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:54:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA863D1971
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 981C13003497
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2A30BF5C;
	Fri, 10 Apr 2026 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UouIHPOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6653002BB;
	Fri, 10 Apr 2026 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789678; cv=none; b=o59XP/rqSvpjd8r1QkY7fogn1AO/dEt0iLp67ARHKNicnDdIqje/6clL1T9IMTCeelKjpWkJiNEVS3S7tjQtFOdUFY1yBK15c1YT+2n5faIyXPJZ30Bx1To4764atVEECN2/pMeNV/VAOOxUcMbcTlvGPpZnBw74r8Ga6D0+N7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789678; c=relaxed/simple;
	bh=XulLFiy5oushOKNQcaiKGCszcW4xIdFuY5IE7YNbm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxkSeGFlwgk7mBcUXRiKZwHaJR7s45iEUVbPknc4WRmFpqdqcz6SG5ow/34YfV0r8xqjHaAc0Ay1zkFEGQshD6uGxmA3EcZ7XaLFLUryMUrzxpf0h2Sh76AJ0GfSz+IcGjV93Szgf0ZCdrkybIh0NJ4qeKUYZx8/TbXtaPcgNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UouIHPOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA12C4CEF7;
	Fri, 10 Apr 2026 02:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789677;
	bh=XulLFiy5oushOKNQcaiKGCszcW4xIdFuY5IE7YNbm5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UouIHPOjD/TgkbO9pz9Mlhl+08Vv7g6i/CDUXtmMlITDi4FZb8GC8h0CSIwCG9ieM
	 RIs1T2ZpYhUbQw8a2/y9WP1wkXaJPW5HB4cOuGTDYA/WI2adLl1IZblV7asXl1w8xu
	 x+rNz4MuoJDeW2k8HR+TSZbqNarmge+fAfwTxTSh8aD8O/10iNxO6GSQuD88nZQ8l6
	 YO1rRSqqHaJeskGOq24VjqiIWDduvyHU+yHaAAluJ47YZcXJ8Xe42d1w8WDQCV1HDd
	 PWTrCXM/HbaLYNPz5/5LZsRSeKLPRiMXBIAm08/ND6vdi8pPC7AQApcYm6OM9VIwj3
	 9KjYocQtcCDVg==
Date: Thu, 9 Apr 2026 19:54:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: netrom: fix lock order inversion in
 nr_add_node, nr_del_node and nr_dec_obs
Message-ID: <20260409195436.3d021e7f@kernel.org>
In-Reply-To: <20260406114904.89088-1-mashiro.chen@mailbox.org>
References: <20260406110643.82577-1-mashiro.chen@mailbox.org>
	<20260406114904.89088-1-mashiro.chen@mailbox.org>
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
	TAGGED_FROM(0.00)[bounces-277211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6eb7834837cf6a8db75b];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FA863D1971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  6 Apr 2026 19:49:04 +0800 Mashiro Chen wrote:
> nr_del_node() and nr_dec_obs() acquire nr_node_list_lock first, then
> call nr_remove_neigh() which internally acquires nr_neigh_list_lock.
> nr_add_node() acquires node_lock first, then calls nr_remove_neigh()
> which acquires nr_neigh_list_lock.

Can we please merge nr_node_list_lock and nr_neigh_list_lock
into one instead?

Lets try to simplify this code as much as possible.
It's a maintenance nightmare and has fewer users than syzbot reports
(i'm not joking).

