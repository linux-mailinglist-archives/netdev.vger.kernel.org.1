Return-Path: <netdev+bounces-257736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG5iOXnGhmkNQwQAu9opvQ
	(envelope-from <netdev+bounces-257736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:58:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA98104F7A
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB363026143
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249C2EAD10;
	Sat,  7 Feb 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDiqqbhM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97827F75C;
	Sat,  7 Feb 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440309; cv=none; b=dt3LeITh5z5mRKsg6osxSoZgUS6fcmmc/0ln6vsajSievzqAUX5xC35TEa0YD26/lve0i1F3m4/jSN5ZAMkSDMdYsfRm7STM8KTzsVvlR/Mnu4sbhFUeJ0aj7+85WlFJSf6gn+AEoL2IOO99RTyAcZzuHQrtFlx1KjUJEJvwZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440309; c=relaxed/simple;
	bh=Ex5KF5PCMHlYLqzcICn9ya/MIfAwzyWKzw2WzNHii7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbPojjQ5+SxZqbmHTURG3wS6M11CLry7njmgZA+L18on+BNERqLeLjAWfqwbAgMdBpfo0Bxwu00AuWxqUaUUi1xIWfxr4y4NS4FJ7DDiIghiHVXqr48MWTIeP+pRn3wwwc6Lw5N7W0JLFQsA5TyjDfxi/a3iBL9LPHqzV5LB7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDiqqbhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A891C116D0;
	Sat,  7 Feb 2026 04:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770440308;
	bh=Ex5KF5PCMHlYLqzcICn9ya/MIfAwzyWKzw2WzNHii7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDiqqbhMbURHakdL9t+Jvdy6Cmv4m3FqfrDNKMATfPH/+G0Fg3uf30/Umf4gFwyZN
	 1IquWzQbi268Z5phc5XhvdqMXRb9LX17LICiGIzatlWaeq45RT7Z9m8/6MzPxqbwbc
	 UC4JRrDcjI5e+9hLK5IIS4JF1Paz3RnZYru8zqGkkHTqQ/UuPn1H8rFE37zLknnx+7
	 BWM+d39D0ZY9BGb+eeC8milNweFQZlsXOCSgk2sb+nQeObSWmIGARER1qI3ecNlAqQ
	 xV7oD1VLoUD/J0Pc+VHKAH44M/YIWnxI69zj0i2l442Br2CZZV05vodAOBoTynwtk/
	 MG+WZPqlyvB3A==
Date: Fri, 6 Feb 2026 20:58:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <20260206205827.567f1c25@kernel.org>
In-Reply-To: <20260206030123.5430-3-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
	<20260206030123.5430-3-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA98104F7A
X-Rspamd-Action: no action

On Fri,  6 Feb 2026 03:52:08 +0100 Linus L=C3=BCssing wrote:
> Before making any significant changes to the internals of the Linux
> bridge add some tests regarding the multicast activity. This is
> also to verify that we have the semantics of the new
> *_MCAST_ACTIVE_{V4,V6} netlink attributes as expected.

shellcheck has a bunch of complains here, including these two warnings:


+In bridge_mdb_active.sh line 124:
+	if [ $ret -eq 0 -a $state -eq 0 ] || [ $ret -ne 0 -a $state -eq 1 ]; then
+             ^--^ SC2086 (info): Double quote to prevent globbing and word=
 splitting.
+                        ^-- SC2166 (warning): Prefer [ p ] && [ q ] as [ p=
 -a q ] is not well defined.
+                                                          ^-- SC2166 (warn=
ing): Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.


>  .../net/forwarding/bridge_mdb_active.sh       | 682 ++++++++++++++++++

Is there a reason this test is not included in the makefile?
--=20
pw-bot: cr

