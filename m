Return-Path: <netdev+bounces-302280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +lPdM1wSP2qdOgkAu9opvQ
	(envelope-from <netdev+bounces-302280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596016D0960
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:59:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=JRtSHPTL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302280-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1B6A302D4CB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F337F8D3;
	Fri, 26 Jun 2026 23:59:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997D36EA8F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 23:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518360; cv=none; b=Jdz1MiVKBn/FgG1J4HOTUelBO5qRejhM07rVMXTmqJqxFI3vekxtkTav7SAfT/pUwxNLuegHtD+3Okf9MBpJnbJwatPsWvbK0Ga4+KUAz9mbn7ojKjghwv91vaTekrEC8DHBxQzb4K5mg9h+ooPTeAPiTO+Gde5WFWUBXHPSdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518360; c=relaxed/simple;
	bh=Gfd485bhR5fKvi/LzOB3NX22vOSmLFU7qv2mJImeU/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYPisNJ4uBa1bZm66akd+PHgHZNWgwld5RJ3XXBtbHrbG37VSh8+EfdXrYl7n8IlR7WcyfmBxs7AyF7rSUbwLUoeqOCltWWwDzMt9IYjyQfQAiuGMnNmbmNKq8WgR7OoeEWed1tzODLQnbHisIwIth+i+dvTGCv0ANewkoL97jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRtSHPTL; arc=none smtp.client-ip=95.215.58.183
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782518357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gfd485bhR5fKvi/LzOB3NX22vOSmLFU7qv2mJImeU/Y=;
	b=JRtSHPTL/ayleQUHEeFKDkG7IZcfvOz0cJME993edNVisaN7rsgrn5k8kKQ7d4PT76+F7J
	F1fdCpwM2lZEM2+2zEinvTINgi7irVmX+XnzsV75wP5bwUSmueCTLhGc5offBieLR2YF/X
	9Qbtp2uSk8IeDV4na4b2hhMY5VSHo9g=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,
  alexei.starovoitov@gmail.com,  andrii@kernel.org,  daniel@iogearbox.net,
  eddyz87@gmail.com,  memxor@gmail.com,  martin.lau@kernel.org,
  shakeel.butt@linux.dev,  kuniyu@google.com,  kerneljasonxing@gmail.com,
  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/15] bpf: A common way to attach
 struct_ops to a cgroup
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com> (Amery Hung's
	message of "Tue, 23 Jun 2026 10:49:48 -0700")
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Date: Fri, 26 Jun 2026 16:59:02 -0700
Message-ID: <87pl1cdfax.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[roman.gushchin@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596016D0960

Amery Hung <ameryhung@gmail.com> writes:

> Hi,
>
> I am continuing Martin's work to support attaching struct_ops to
> cgroup.

Awesome, thank you for working on this!

I'm going to rebase bpf oom work on top of this patchset and will give
it some additional testing.

Thanks!

