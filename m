Return-Path: <netdev+bounces-299703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t3+yD6qsMGqPWAUAu9opvQ
	(envelope-from <netdev+bounces-299703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D768B596
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k1fwelov;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44AB0300E17F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542037C913;
	Tue, 16 Jun 2026 01:53:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698D248886;
	Tue, 16 Jun 2026 01:53:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574824; cv=none; b=uHNMVcvrXGgiHCqpUFaJ3ggglXHVn5Y6hjBKUyLnfaTh7b8LqUC+rG8jS2EzlHEWneqZZnG3hw+B+aXfdweL21St/dK/r3AVn4WGjp4Rzjc1ESOgo4wvNIQS8979MH37HmunC4z3bVnNaiTtdXKERtWDh+4RpXJ9oORokgQEjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574824; c=relaxed/simple;
	bh=kNeCfqEenlY04WlHne1AA7F6OaLYPtklWk5bpmTB1Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTOi71oxTXwyGNNaTWG58uAr1yo/V+8Z0DK95oDJlVH38ADm6pooTkHU8eT5XgRdhTqdbANVCi/RCAlUSiBaN/TUi6/GI9BCMBCYj5Ua+PyltXKx+T4tYuPl98yY3jKnBr7dv4BetMqbPJmuyX7XyJ/ujnPpcYRP9eTrwfIl40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1fwelov; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439FD1F000E9;
	Tue, 16 Jun 2026 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574823;
	bh=cC/Qq17Q/gmbCF8jfLZDR9hb9OX1RM4b10Kgps4ijI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k1fwelovHEcxdGS4GGIR0EPViVWaXXA79N1xszdfnw4umHPw9c/8FiwX3tB3vG5UI
	 NanEBVxW6cIstuX/34IHyW9Q/GAduANP0rFzwIM/em6UzV7JsaP3+oWYH3tneG0ANj
	 yE4cZyzE3RsHdIyR/ZPCQXEWnzzeWW78EynuAyXfyCfWXrM/Eo+5IG4NNQdq0OXQjV
	 L36/lMPQLL3zP+689zpC14rC/MOuK4yLsS6LPGyj8kkc8eCpDJLZVLd8z3WsWNU3hY
	 AH0VdMLa6yXC8wMAFRWDfG5ohMI8pDpwuo8u/rrpWdAn7+9FFrVgPH85EmT8geOsoR
	 SNWHPyAdFuC2Q==
Date: Mon, 15 Jun 2026 18:53:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 simon.schippers@tu-dortmund.de, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Chris Arges <carges@cloudflare.com>, Mike
 Freemon <mfreemon@cloudflare.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@toke.dk>, Jonas =?UTF-8?B?S8O2cHBlbGVy?=
 <j.koeppeler@tu-berlin.de>, Breno Leitao <leitao@debian.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL)
 support
Message-ID: <20260615185341.339a4dd8@kernel.org>
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299703-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:simon.schippers@tu-dortmund.de,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:carges@cloudflare.com,m:mfreemon@cloudflare.com,m:toke@toke.dk,m:j.koeppeler@tu-berlin.de,m:leitao@debian.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,tu-dortmund.de,davemloft.net,google.com,redhat.com,kernel.org,toke.dk,tu-berlin.de,debian.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA9D768B596

On Fri, 12 Jun 2026 10:35:23 +0200 hawk@kernel.org wrote:
> Subject: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support

I'm calling it a day and dropping all remaining net-next patches from
pw since the merge window has started, sorry. You know the drill...
-- 
pw-bot: defer

