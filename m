Return-Path: <netdev+bounces-256941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iInfHbcIhGnvxAMAu9opvQ
	(envelope-from <netdev+bounces-256941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:04:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC2EE2EF
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62369300383B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5423A562;
	Thu,  5 Feb 2026 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1juI19I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E27189BB6;
	Thu,  5 Feb 2026 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260659; cv=none; b=dHUHHnqPHA9Lb342UTM6eMpQw+tSE2ePnclAeMmGSvMH7u979FPD8rL4s8pLOGfNY02O61AQPCcDtrf2hX73TMPdXIK5tHOU3UWJU03M7SfeZSHOU8MjjPivCb4ADR+BUoHnNcohfd2lyAqCmRhuvlt6Ye8IFCsnjtP0Upl2UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260659; c=relaxed/simple;
	bh=itAwqI/HnZEER01Cdd5m/gLyxM9oIubnur5BPHr4LLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsaASGgYg+FJi4gN39NUJHQLlDAyyB0wjTCkYd8UbnKCd60r8NN1am/vNt4kJjdmStrIwF4aW2bLGXPyCC72iMx905keyrbQjvvFDwRVJzSdEY6UWJEfpVH4w4grRSPsyfnTa3JkHiHZZ680y1lV6WO56kSrUxV1sOXzY4YaLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1juI19I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7E8C19424;
	Thu,  5 Feb 2026 03:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770260658;
	bh=itAwqI/HnZEER01Cdd5m/gLyxM9oIubnur5BPHr4LLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1juI19ILsIB0sw+mrYDKS9iCmXLe5RPoT+X0C3A/9gzsfFXwNK7qKNekai2EU6do
	 N0RXR5bu3jpmQnKUQVoU3boqaSpy5ESHelYoqz0GsWHLHImlB/6xo2XuIZSSEx/BDy
	 SvKGYs8zFoG1LaUEqYyhiRwZIBb2tiznXqhli1bVFJxWhsWFKjrmOWeUUDShBj3aNV
	 mgRMGHyQ2dZDjawS4sg+IYGhHOEkb3e6X32JI3U0MwgahqYoFngRaQWh+L+kEVcZD6
	 76IhDiWVVg9GeCjswk2HSQQcYbecf+ByBmlgnXOcawdwCLFxvxaBV/duG9GjyEHqqd
	 jy9EgYE165icw==
Date: Wed, 4 Feb 2026 19:04:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 bpf@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
Message-ID: <20260204190417.110f5498@kernel.org>
In-Reply-To: <177022452988.1827734.5121740962985640333.stgit@firesoul>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,kernel.org,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96DC2EE2EF
X-Rspamd-Action: no action

On Wed, 04 Feb 2026 18:02:49 +0100 Jesper Dangaard Brouer wrote:
> RFC: Seeking feedback on this refactoring approach.
> 
> This series refactors qdisc drop reason handling by introducing a dedicated
> enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
> layer drop diagnostics with direct qdisc context visibility.

I like this!

It will presumably require existing users to migrate over 
but sooner we do it the fewer users that have to move?

