Return-Path: <netdev+bounces-289216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCIkEmWrC2ojLAUAu9opvQ
	(envelope-from <netdev+bounces-289216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE43575710
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E046F301A996
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508D5B1EB;
	Tue, 19 May 2026 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYlLGu/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29832AD0C;
	Tue, 19 May 2026 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149664; cv=none; b=aiIp/35JOTl/Uyv7xiewJisN3TVi1q1XAThbEomkSEHCztXTPjNhT1AIZ+4fOks/CpT4s1hNzpFuut6FfDRrVFrjYW2Zmx2OgkyHlq8biPyCws82kHfr6zV46/MwuauT9LV6WK4YfvSuuMgh0NRy6Y+ganORfJW+iN4tO2epWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149664; c=relaxed/simple;
	bh=PQY+cECJ9DOxPHMncgqIMlR1QqMUkQDxCMSXGbdzrOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTT+DU3nhoLqSmES+dLEFP7UHExM8IjH+m+6wGBEdk6lH4/V2Gn0Dx3H5+SQgDZOjlVc4QpprpDl/S0TsAhtEz/ZxcnqsLPis7lYOoZ3QIfsyWuZ3x2ZFlYIX4RIWSvl2D3uXJnEbIjOBVhK3lQt+du6ATP8Xpy0Ph1aBnFWU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYlLGu/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DDDC2BCB7;
	Tue, 19 May 2026 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149664;
	bh=PQY+cECJ9DOxPHMncgqIMlR1QqMUkQDxCMSXGbdzrOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYlLGu/5rT/Y/1bqQapiOiudPQHgDm2ap1SD8q0wHLFVszCspOM8x/bUmhq/BjsS6
	 EapAkH0T4kMQGj2oqAF4BxwRHrPJKO8+UScPR8/0A+Sez2XmPw5jr8I7SZnXTxX3OG
	 AdOkOc7lijIF8Dl1SmXHNhjRx+bNBzDiKlmf9yIzw56dSosvKsCBsqI3tyIMy0qMU6
	 O/v6Jk016y3IeCX7plx/DSI1ypFc/Grp7Ro3VcD7IQPXEGaD395G4o22BkGzwev0Lg
	 Os4S/Ubd2g/rXTC5Y1iQY1jO8MxBPj2KkImJ4KYvPpMaGIwP22jRA1JclPs1547mkO
	 30/DBYi0ZUAFw==
Date: Mon, 18 May 2026 17:14:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv6: route: Unregister netdevice notifier on BPF
 init failure
Message-ID: <20260518171423.2ad15470@kernel.org>
In-Reply-To: <20260515130517.779406-1-dbgh9129@gmail.com>
References: <20260515130517.779406-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EEE43575710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 09:05:17 -0400 Yuho Choi wrote:
> Chages since v1:
> - Unregister ip6_route_dev_notifier directlry in the bpf_iter_register() failure path.

The goto was fine.
You're generating the patch against an old version of the source code.
Please use
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Or for networking fixes better still:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
-- 
pw-bot: cr

