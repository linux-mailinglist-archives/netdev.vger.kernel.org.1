Return-Path: <netdev+bounces-297711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tOxaNnl5KWrSXQMAu9opvQ
	(envelope-from <netdev+bounces-297711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:49:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878266A658
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OvoB3DhY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297711-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530C43084475
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54EA2E9730;
	Wed, 10 Jun 2026 14:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC633D512
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:33:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102001; cv=none; b=V+7O9rTzZqBH8feTn4WDRvXKbNfNAf4Q38hJW2L3/uI7AUQCkfb/8L7D6aMFj2D/U4CFqU6Scz7/YQqxw8c9IMpJx3T5Z9hQughdBkMw92D0IHvc11SQgrVYVJOGrVXPqUJ5IJqhPM7/zHh9V0rQQ1ykZyo3G9V6mDck8MF74pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102001; c=relaxed/simple;
	bh=KtLqtw29AM5Ta1AihRVyjUJTyXQ+b+M7+YM7RlpLZTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE/tQTxlVJ9B9bUEx5VJsNx9mJkRvapeWEM+JWnQAaOW+KSMDbBkLeLf073TR6iryfZok815W4yOyzl4l5JD70duFQXPAltBglSJGfOryAFTpVmmXyWvHbvB8fepouE8cOOMod4F45CIjty42DpatkCBA+QySKD8THChseHr06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvoB3DhY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECE1F00893;
	Wed, 10 Jun 2026 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101999;
	bh=Fia8PofUXKD2hlmVvWSxA9/AR8mvTDrBL93VXEWtVU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OvoB3DhYOGe/3hJLc4FpwRXLA39aJ9je9c6TluVLLy91v7Qo5Jd1CKpvZMitX+Mri
	 gLNNjLJDvrlMTD9fCXXDeuj9V6h8DFpukv9sJIOuCoaZD3wNDFNnuDjWy+TjuF9J7e
	 wF+BDMhPBlLoMxVjYiuYj/ZDcMEDkEWiARLgyBgwCej/JxbnKXPwD+PFFhvmM3m+wR
	 AlMRRhzhtlgsfk0dcbN0Y+WGOplaxwcSlzi+F8FTGXYbsFiaijnih8x/jCF80VEtmI
	 JjuWriyOHIVS7wXh7j4Y4zs7lIgb1LVfSC1JHY45pnWQhd7tyE35CwkKEhtcKZxsee
	 mafobteXgwJ0w==
Date: Wed, 10 Jun 2026 07:33:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 0/6] pull request: fixes for ovpn 2026-06-08
Message-ID: <20260610073318.4a28ba31@kernel.org>
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297711-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2878266A658

On Mon,  8 Jun 2026 17:07:31 +0200 Antonio Quartulli wrote:
> Please pull or let me know of any issue!

The SoB checker says:

Commit 588d0d2cb66a ("selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()")
	committer Signed-off-by missing
	author email:    yanlonglong@kylinos.cn
	committer email: antonio@openvpn.net
	Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Commit b19512620b80 ("ovpn: hold peer before scheduling keepalive work")
	committer Signed-off-by missing
	author email:    shuvampandey1@gmail.com
	committer email: antonio@openvpn.net
	Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>

Errors in tree with Signed-off-by, please fix!

