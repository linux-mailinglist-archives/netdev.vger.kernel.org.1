Return-Path: <netdev+bounces-279092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MrmJKsN4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E580411B1A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B690330197FB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ECC39B974;
	Thu, 16 Apr 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awK++3tG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DA38D684;
	Thu, 16 Apr 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356776; cv=none; b=Rl/ukc3qlNhFBpIre6dJ/1MY22kFE5tJsUPQB/9kdZT51pv3f0cpmvUvhTXR41AbSDrX0hKrr9OZCoEHleYBxaa39Q3zEzSTSrIGXgHvVsqaKynZKixCso3S3Tu+ucBibuXVzyyx3CaAjfQjEkTtLepfXoynmRWzCqpEL1caz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356776; c=relaxed/simple;
	bh=PnVEvj6r4sM2KRt+fmf1YQaMJvfoFChBTj4QPF/SHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXWD6To43nEDy2xmv5Tjrg1Rzw+pfuLJEjDOKR1ix7b/2C3PVAYELruGtvDOtqRSWHYRou+jx3kOKPZ7S/ZgQdzDs+3gAoA+9DnpzwdzlHQqdJ1qxnQvD/xgTnfwHZJITq1YoOiGbOIEriigFzy47AjNefbFPcu8B7eXBbFsAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awK++3tG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB78DC2BCAF;
	Thu, 16 Apr 2026 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776356776;
	bh=PnVEvj6r4sM2KRt+fmf1YQaMJvfoFChBTj4QPF/SHdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=awK++3tGXqBbiNzli2NJpfp3fJ47bQKsWqv8FDORt9kIcO9bomb9QBkIKKBBOMBJp
	 8opXAkfh0eNNGiBSW+SDgZJ+ZCPbc69yP4/Os7JS80fE6jH7RET2l1mbQZWYXAb+w0
	 gB5ld1Bape/Rkxk+RGP0Trly4jd0gvaAa3fmdv8HqlUUnV/uFt5e/GRX8mAqb5wgi0
	 XL5NVnKd3XjaakaDSkkF7TjsMH3QU8wTkMU2zxna4QrnlGYxswewbyCLDVt96v6XmK
	 ofVPGqTfSA2jKdXhPY49nUuHfndip2XJhI8HKf+0DXo1YWlQh/Kf3tNg5b/QE/C3PD
	 kKzjwcouW/c2g==
Date: Thu, 16 Apr 2026 09:26:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima
 <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
Message-ID: <20260416092614.3d0e3408@kernel.org>
In-Reply-To: <20260414035931.45692-1-nashuiliang@gmail.com>
References: <20260414035931.45692-1-nashuiliang@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,fomichev.me,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3E580411B1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 11:59:20 +0800 Chuang Wang wrote:
> Subject: [PATCH net v2] net: reduce RFS/ARFS flow updates by checking LLC affinity

"net" is for fixes, I think you want to target the "net-next" tree.
Unfortunately that tree is closed for the duration of the merge window,
please come back in 2 weeks:
https://netdev.bots.linux.dev/net-next.html

