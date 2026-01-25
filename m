Return-Path: <netdev+bounces-253249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHrBIScdmmOTAEAu9opvQ
	(envelope-from <netdev+bounces-253249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:43:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6569982BAC
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89DC30048FE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58FF30EF65;
	Sun, 25 Jan 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ184WkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28932FFF8C;
	Sun, 25 Jan 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380992; cv=none; b=U2MtKOmp5HwLreF8/TgbDDAmI9o+7rPCEyAUFxWQfRS2Lkd1RLZVrQ1t6xIvSBTqsarXpKmQtKXa3v2gV1zdOtAb0Q8W70TQmvtmkBLpKk30wResIzJcrwz4eOP79QXKWRcgDYKg2+Nb3WACSH3qsYm+fu8pfacouvB1A34Wm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380992; c=relaxed/simple;
	bh=xLj8gmUGn0nz+0wintHMgOMQ5HTotjYBI1iIPOGy4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIclVwSHymMWxKg0HuhBMafhPXn8kqpbSngPGvUgytgWeJrtVFSCMdoRDORO4NvpMmWjY2bYjZ3FoyfD/GiT0SHY262hPY1qHh8oG1ioXu4UFTnn93IoUlCpi7jvRTAZoqWkPr26KeVpiSnFYpD5J084T4OueM6ujGqFgx80H9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ184WkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B943DC4CEF1;
	Sun, 25 Jan 2026 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769380992;
	bh=xLj8gmUGn0nz+0wintHMgOMQ5HTotjYBI1iIPOGy4m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FJ184WkTYh8WfNoRVvyOdo7fCvkMH91VKIRGW44w2NVFb7tw92X1OE3QJm4VRY1GY
	 FvBaN7mf6zyJ9+AKEG4/y+AELDQI9tU8DprJGFGhvtwaG3kL+grclqvOOGw7VAcfLn
	 lAbSyy6oqQSd3Z41rxe2K8w79a/McQ511nhRG2mh8ROtWBMko1nAy00cjb2FMoP1lf
	 k7hPFhwxjEDUb25unPE3/zllK3xTORyWNBFNwkt3aQquS2sopsQUFxlqVTUztUJ4k0
	 ldtSd5x/7vFzXCzSWLDuoT34buCQgA/exhfyTtfJoX7rZTlwA2Pq8tLS4x8q34RV9y
	 7ICF+e1/gybsQ==
Date: Sun, 25 Jan 2026 14:43:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 johannes@sipsolutions.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: fix potential skb->frags overflow in
 RX path v2
Message-ID: <20260125144310.75d08fc4@kernel.org>
In-Reply-To: <20260122170401.1986-2-qikeyu2017@gmail.com>
References: <20260122170401.1986-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253249-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.intel.com,mediatek.com,sipsolutions.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6569982BAC
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 01:04:01 +0800 Kery Qi wrote:
> ubject: [PATCH] net: wwan: t7xx: fix potential skb->frags overflow in RX path v2

Ugh, I think I got confused and send you the AI review for v1 again.
The correct subject tag is [PATCH net v2]
Don't put the v2 in the patch title, please.

