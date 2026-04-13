Return-Path: <netdev+bounces-278181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKF4Isc53Wk3awkAu9opvQ
	(envelope-from <netdev+bounces-278181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:45:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6A3F235B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF3C301FA8D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F667371D0A;
	Mon, 13 Apr 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa/en2xx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AF3101A7
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105925; cv=none; b=lPW39AgVj0VvzmHHeuBTRKiq+M6FN4AgyzHP5NbqB8MxuxJJYCaHRjQuDqkfgeGFQO+S7pQqkGqNBFUhdRUqCKc5vQSCDoMzbRwAcRkJW9i8vX25pgNL93JglZsM/QDu9q7F0vZzymyaHRxXtKU1CyC6uYGn53mID0elKHuOstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105925; c=relaxed/simple;
	bh=NAj9UH61tEKwfYR1yC5klDKMjuaRvkkasqyob3K/Qmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGOj/rWPsMcQ4d6x2mySRiFC5seUzi6i5ghayyJbgiaR809Iv1/p5pQHWwVgJMmb2WGKm1irABNaEXI0h2E7vI9KRvQTP8Dz4HfvjkBC6CwcthlcIroqYeu56Qsql7s59q9LnBNcmC6DKvchBOl6ABlJg+LT/2QFRp369W+7hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa/en2xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8920C2BCAF;
	Mon, 13 Apr 2026 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776105924;
	bh=NAj9UH61tEKwfYR1yC5klDKMjuaRvkkasqyob3K/Qmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aa/en2xx7HtzTiYK6w+WlhHXj0+o+Bvzwcrx23WN3ptX7q/vJ17Y9q/SgF6Uobj7/
	 /JuM5NRiKGFNQlmXEJvjvnBfZgxkPbCSoEp/xJLrObHhyBz4+woE8quMrwoxqn1pOs
	 FoCZrloyQxJ3+Uu9CF0IZeIQj6kTPTCk2E3N2F+vErzCBJ5XV91ydVrS08ILC8Pgpg
	 8XXvZN42DP6IxCj2blbJ4ScUpIsFrC4KOP/QBz4b9ghX/GT4B0fwNKuYsC8MJGHmz0
	 WMoLEsH2SBEp+1KPU8kyeqBeQaN+xZhOpX72YWp1zionEizhx1zLH6KOUHafJUMBGB
	 PLIVJK9cWyXzQ==
Date: Mon, 13 Apr 2026 11:45:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 00/15] net: sleepable ndo_set_rx_mode
Message-ID: <20260413114522.3e8e1b6d@kernel.org>
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-278181-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AE6A3F235B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 10:11:16 -0700 Stanislav Fomichev wrote:
> This series adds a new ndo_set_rx_mode_async callback that enables
> drivers to handle address list updates in a sleepable context. The
> current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> with BHs disabled, which prevents drivers from sleeping. This is
> problematic for ops-locked drivers that need to sleep.

A note to other reviewers - I asked Stanislav (off-list) to keep working
on this even tho he's targeting net-next, because the patch set
addresses a syzbot report. Chances of hitting the issue are low but
this is a fix, really.

