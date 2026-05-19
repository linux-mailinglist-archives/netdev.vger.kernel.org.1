Return-Path: <netdev+bounces-289230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GauC8O1C2q2LAUAu9opvQ
	(envelope-from <netdev+bounces-289230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0B6575DE9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85EC230254B3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E08286D60;
	Tue, 19 May 2026 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb/kvHOL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A361A9B58;
	Tue, 19 May 2026 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152305; cv=none; b=FECvJPrS97mi5jBS1XTTPFf7B13AeJDRGP5pMC3b4YSrlbLfR9fz8JDtegr3B6Yt/X+7WZl4bgRqPCXwUppYr7KPzdREneAoNKQnzTZntilBBmTTBxi/luoo/nE/rEZCMmm5tD2Qc7ZPuba9pti6TARGPzQmEECTXwRzmnPJCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152305; c=relaxed/simple;
	bh=n7u4bAkGOXBc8shaS84XwmlZ+TXMezxcBwm9pa5FPmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfPt2RBPIicSIvB1gznnM2k/ieGI2GjhZheV4QuC7dONs3sCkre//yjle3QtBPaCYg/iVXf5hzZaxAT1eehbsRqSELb6fdzfBd5t4Fmc3IGFvsxlsRDsg8rjBZtmxhAP2fB6/+YBRb+5wSyQUp4E0HAsOmDH/E6B1dFSEiNfRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb/kvHOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B46C2BCB7;
	Tue, 19 May 2026 00:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779152305;
	bh=n7u4bAkGOXBc8shaS84XwmlZ+TXMezxcBwm9pa5FPmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qb/kvHOLim4Zy7yGFVPkNFW7GogyWMn4jhONKadJWdHQ/tg/TFXSjUdWa4xOn2uVr
	 mD5auGuIyBVIZS2AyYVl9xgmIgUXoTSjKdImc40aDb1MD7zUGHV+YjuO06avEEInj1
	 Yz0aVp7RkiT21pbKpP961gfE2SHTp78NtRRtP7za4a+J0EKdixpHYt2DVZGcDZhdoR
	 /1q8xOUmKzlbImrMmdHKtlVzkaqc1z0WslQoVDdh80L39RfRWMm7KMdyqy5l8A3QiL
	 8t1B//IDLWD9NN4Ky/ZCmWmRqxzdc4PD2dNESAT34qxK1UMh5NlBbqEWqdw+ZZA8wv
	 Nl4OBiRfK9ItA==
Date: Mon, 18 May 2026 17:58:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kartik Nair <contact.kartikn@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/llc: fix UBSAN array-index-out-of-bounds in
 llc_conn_state_process
Message-ID: <20260518175824.5d0c0433@kernel.org>
In-Reply-To: <20260515174904.28575-1-contact.kartikn@gmail.com>
References: <20260515174904.28575-1-contact.kartikn@gmail.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,628f93722c08dc5aabe0];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC0B6575DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 23:19:04 +0530 Kartik Nair wrote:
> When a timer fires while the socket is owned by a user, the timer event
> is deferred to the backlog via __sk_add_backlog(). By the time the
> backlog drains, llc->state may have been set to LLC_CONN_OUT_OF_SVC (0)
> by socket teardown. llc_conn_state_process() then calls llc_conn_service()
> which computes llc_offset_table[state - 1] = llc_offset_table[-1],
> triggering UBSAN array-index-out-of-bounds.
> 
> llc_process_tmr_ev() already guards against LLC_CONN_OUT_OF_SVC for the
> direct path, but this guard is bypassed when sock_owned_by_user() is true
> and the event is queued to the backlog. By the time the backlog drains,
> teardown may have set state to 0.

Looks like the wrong fix, looks like Ren Wei posted a similarly wrong
fix first:
https://lore.kernel.org/all/5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu/
So I'll let them take it from here.

