Return-Path: <netdev+bounces-286684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5aIMzmAWqemAEAu9opvQ
	(envelope-from <netdev+bounces-286684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49612510149
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2699F302B04B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B43FD135;
	Mon, 11 May 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sHp0LQMU"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474703FBEAC;
	Mon, 11 May 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509207; cv=none; b=gpO9Nr5+yJuqkppeZywH8v9D7b1BJJQpRdSy7y3Ps4E7T3RnzWOd4EV8mLGBsnXz509/NEH/9m+YTCz/qRF9YtO1rk3nmpDDbEojDm4scfdKox/UsasiEj8+U1ucy4y63tDAcPckLdVZck0NTuurYEQ8ZD3Tg29MPRNO74E4at0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509207; c=relaxed/simple;
	bh=vbogRMdR9OUH7DCV2N4+RVbNkjefHZiazkEXy1KYeuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFVhyp+Tji6715KVZS6Hm4kzkhRAT1wTX5ZwsbFQDjZ7RhPLbYTZCrtg7fKG0wV3WLwuQihJoCYlNgKu65sYLQZpdSORtNBhxyChndnRFy8Y/OBbfooOuie3c+W0R38EwwDnl31L3ysQ9c3syjVysIPPm+PAC8QnBYbDQ1Qn/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sHp0LQMU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o7m1iQPEWMTmTOeyzulh1g+n1fA1cwkN0Gd2HkUrqvY=; b=sHp0LQMURu6gNbu7zWA7wS/9n1
	ZiNVJ5naWWfvHvaGfQwuGEDSVA133mm8ZWtvRGV39R1DN8YL8oUOtGrv5VJWc5t9CP3FzQRW2emNi
	aZqk58F9ViUYjsFuRIEe3zH4BQ/YcGAH3A3tZ+OOumIqkqalIo8nM1eBuASlncDdOnMxGe29HbHb1
	A+04lyEfOYuZGWP6umwPOMswduHr7VxSNxhMC08YzggdLy6xlEZbhBxXzEFO+8HKA+wgDA9LYo1Rn
	URREoJrYvc/6i43QdGEufzbqortylb46jAq3A7acKgQBIkLFJA0ANYPlMYgGsLIOhvk14m0eGejXv
	I/ENCbeg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMRU8-001exK-34;
	Mon, 11 May 2026 14:19:53 +0000
Date: Mon, 11 May 2026 07:19:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 6/7] selftests: net: getsockopt_iter: cover SCO
 BT_CODEC conversion
Message-ID: <agHlZ-J5VjqJZTE4@gmail.com>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
 <20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
 <20260511064729.11c507b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511064729.11c507b1@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 49612510149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286684-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:47:29AM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 03:41:51 -0700 Breno Leitao wrote:
> >  tools/testing/selftests/net/getsockopt_iter.c | 65 +++++++++++++++++++++++++++
> 
> please don't add Bluetooth tests under net/ (or at least they must
> cleanly XFAIL if Bluetooth is not enabled). Also Bluetooth has its
> own tree so not net-next in the subject.

Sorry about it. I will update.

Thanks,
--breno

