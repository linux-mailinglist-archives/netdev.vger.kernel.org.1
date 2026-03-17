Return-Path: <netdev+bounces-268808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDCaJdDiuWmnPAIAu9opvQ
	(envelope-from <netdev+bounces-268808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:25:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253E2B44E0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FF03326EDF9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471B3FCB0E;
	Tue, 17 Mar 2026 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxqlXgul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92D2D7DF3;
	Tue, 17 Mar 2026 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788990; cv=none; b=FemcwoIbciK8uh/Haw/t59Hpv2TZFhZyYzgZbUaxWY7zPhKjJ2o3fXLjrQrYtPCSgYdWgDdB1N6ZIBKsCZGglvt+VOQzM0FM+tDKOznvwhMJ+EbfgQiHpml5WlY0Nv/Fuxi4litMUCt3Ftfn7aeXv2/8Zfxb651QIStBbXp99KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788990; c=relaxed/simple;
	bh=iC20zC/9D2U2kbeHwnm4GeZrbhM0rOArXLQNcEKTaEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ0D+QT/9wE58jw82BPDiNmyL6fZ5SrK0oLWRjJOJu2tcIqQhuZ5MAsHYQQK7ubBMsfIU/hrleQPATxsXJiBMsYBKpLfa5HpV92G2lSFs7qz8l2knLm7Y2BwMHqykfxtMPwBj97nJMe+GJ9y/VQs6CAFM32AgkM9Dil1IcBQqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxqlXgul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA22EC4CEF7;
	Tue, 17 Mar 2026 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773788990;
	bh=iC20zC/9D2U2kbeHwnm4GeZrbhM0rOArXLQNcEKTaEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YxqlXgulEx/NSJxOOYUI53/0UcSZaX5txvgdzIuDJk0DC8FStWgSCbLIkI+ie7QZO
	 Q15U+OsdaNEQkRaLV1lbgdDyu5oIqaT3cfToosl0LSisg/VD68cBR7eYhx3YmMnPTt
	 740NQVTW113gVfklFGt05lM7A780XGZkQGXQkulWkmfVqZR+VweSKgD8dgnOA4Vlzn
	 Z92Q1YNJRYwaiPva+bpx4yg4kXtaBdR/7ffh9fvxvuuO7qiBDNWzIRvj9D5EokEVC2
	 oT2S9ZgtP18k+3qLUIrhrsRbh5fw8p6fgoXf2KfuCc1+5zInDC5VvdcXnJLHYmE/hk
	 XHQAraCWgejjA==
Date: Tue, 17 Mar 2026 16:09:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: donald.hunter@gmail.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: rework policy access to support
 recursion
Message-ID: <20260317160948.5a358df0@kernel.org>
In-Reply-To: <20260313232047.2068518-1-kuba@kernel.org>
References: <20260313232047.2068518-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268808-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2253E2B44E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 16:20:47 -0700 Jakub Kicinski wrote:
> Donald points out that the current naive implementation using dicts
> breaks if policy is recursive (child nest uses policy idx already
> used by its parent).
> 
> Lean more into the NlPolicy class. This lets us "render" the policy
> on demand, when user accesses it. If someone wants to do an infinite
> walk that's on them :) Show policy info as attributes of the class
> and use dict format to descend into sub-policies for extra neatness.

Hi Donald, you promised to take a look when officially posted?

