Return-Path: <netdev+bounces-264440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDSRG62aqWlxAwEAu9opvQ
	(envelope-from <netdev+bounces-264440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:01:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6A214116
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916DA3137793
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77403B52EB;
	Thu,  5 Mar 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrTBc+ZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C13B4E9E;
	Thu,  5 Mar 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722530; cv=none; b=p2ralmVcHM6LfRwnXkEI4Ue7Ie0VGzonYPnfUhGW3c0004R7WR4A2kJCtVOVlQ5e7FQpRjkiTgPgp0ETWpaW1DljXh6tRtP1WYupzBx0z4hKdo3zP5LyFCQIn3yW8UGvwyIOG4QSE6+Urgh4YIK9BrylYQV03hGeTONrMC2oYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722530; c=relaxed/simple;
	bh=hwbQin0Tef4LX8Pg5w83uqaNkL3z0iQ+7p4Z7zta4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBAh4i5a2G7hL/nu3nYo152vaZCagIUIppx7uHjlMMvU3UADyoygod844QsrAk4FnkBf+wPL8uwpRof+ddv7SmrBh0/u8eDt2UiRBGq4Cm7nXDV3eL0mlPQpBjD5daruW44yF+2yHn1FPM1gxBXQEKun6b2Cki7lbXPYX2d0aQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrTBc+ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F05CC116C6;
	Thu,  5 Mar 2026 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722530;
	bh=hwbQin0Tef4LX8Pg5w83uqaNkL3z0iQ+7p4Z7zta4zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrTBc+ZAmIYZuAfPiZr8JCBX3mjfysidtKK/W2hFgiapeDRmpsNn0kUzBKtdaO6Ez
	 EZ3O1ZwiapAwnJagpmZRVrQwDCmPbXbz7OF+cg58FQcmRscJ3R/a5yb2qh8ORPf4g/
	 txSzxzN1uwaqK5qAubF7rvIhIS9AeaOuh8iBvHToGe59yqq3PbfWV1VtsXWknLCm0a
	 vJ/eEN5/V63qdbAi0YuYB+TVhEg1u2RvPq+QjJ2benYolH/eFILtMP0p/lYMgdzOTU
	 yvuz4QTvf2UOXQCiR79xpx9+6iEbxVdPF9ZdvL+biywaZ/r+DbSJrMUHQENQtBR5ho
	 zsan0XmmCudUA==
Date: Thu, 5 Mar 2026 06:55:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>, Christian Brauner
 <brauner@kernel.org>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH 1/2] octeontx2-af: siplify rvu_debugfs
Message-ID: <20260305065528.314871ad@kernel.org>
In-Reply-To: <20260303185507.111841-2-ynorov@nvidia.com>
References: <20260303185507.111841-1-ynorov@nvidia.com>
	<20260303185507.111841-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97E6A214116
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
	TAGGED_FROM(0.00)[bounces-264440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,lunn.ch,kernel.org,marvell.com,fomichev.me,linux.dev,vger.kernel.org,weissschuh.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 13:55:05 -0500 Yury Norov wrote:
> Subject: [PATCH 1/2] octeontx2-af: siplify rvu_debugfs

when you respin - please also fix the typo in the subject

