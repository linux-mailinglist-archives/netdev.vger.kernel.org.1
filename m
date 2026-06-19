Return-Path: <netdev+bounces-300759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H8eUH5etNWqB3AYAu9opvQ
	(envelope-from <netdev+bounces-300759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:59:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E56A7BD3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:59:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300759-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300759-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC0B7300A7E6
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28623CAE94;
	Fri, 19 Jun 2026 20:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2D3C3C00;
	Fri, 19 Jun 2026 20:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902739; cv=none; b=VMEpMg52QNy28pYsSNrHkN52gbF1T4uKkYB4F6HOyK3wt2nfPbYQgMXuEa6IgFGVaJtrVYsRnC6BIYrcbujhgmcRfiI2phVNipdziwB4kQVBM27TW9O2i/KakaKOVKATMkHmNMQWlmBKWw2VnGOitdghiZAvYgyC6OpY8bU+T5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902739; c=relaxed/simple;
	bh=oooXo17agqt59WPLk3K1n2OhubOgja7s+KkLia3OLv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXJYqCBhLujql9CdYB63c6wPUY4M+p2bWoqnnP53I8AOdsYV5puR4BnE8jH3a7rGT1HYx73mdBlWSpt5/atLk/EHp81E5tuFyGTVbV4/rqjm0S+YTN0YNVOxIFHWX+AJG3TlEXFxnJJb2ByGCOUc7MAv9NfYYmx+AVxz6qjXPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 041FEC0879;
	Fri, 19 Jun 2026 22:58:54 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in mac802154_perform_association()
Date: Fri, 19 Jun 2026 22:58:49 +0200
Message-ID: <178190268127.829220.6513673834040282671.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com>
References: <20260602054133.470293-1-robertusdchris@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:miquel.raynal@bootlin.com,m:robertusdchris@gmail.com,m:stefan@datenfreihafen.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kernel-mentees@lists.linuxfoundation.org,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[datenfreihafen.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FORGED_SENDER(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-300759-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[datenfreihafen.org:mid,datenfreihafen.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 049E56A7BD3

Hello Robertus Diawan Chris.

On Tue, 02 Jun 2026 12:41:33 +0700, Robertus Diawan Chris wrote:
> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
> 
> This is reported by Coverity Scan as "Unused value".
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] mac802154: Prevent overwrite return code in mac802154_perform_association()
      https://git.kernel.org/wpan/wpan-next/c/649147cb3f8b

regards,
Stefan Schmidt

