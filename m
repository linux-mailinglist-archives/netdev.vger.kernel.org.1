Return-Path: <netdev+bounces-267559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNQoL2hYtGlbmAAAu9opvQ
	(envelope-from <netdev+bounces-267559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223C288C6B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E102130C664F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5C337BB0;
	Fri, 13 Mar 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCXF5YQk"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18131B83B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426718; cv=none; b=pKPiZ/ZDmFLmzDc3xA3BSu5qqf5IIzUVPTy8NjyM3yWiiiNXIoDrkrxKgmlMVTXiLdQZxfXHMsqOHkbrlo77tXaLCJ/jeSyNTzHQW/I5lO0Fy/iRJ+JCEXI4CBsdkCOy9kILVlVVslbNxXiG0pF9PtI/6d/BTg/hM1N0bM7LqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426718; c=relaxed/simple;
	bh=AaQFuMvnjyDfkeAZUTpVvS2snrH40JPIo9mAFraFUFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHRxflZLiEcA7Dlvo6RMAXCoUeM4Nza2A+TqibcHkKy95RBZkIru0kEesQWr6wlrTuW7pit5ssgwMyDMiPx6GSQOhEuGoX9/IL6/8Sjklhks66EGm1qUUgBuzttdvIx9KoO06Enm6QQ4oe8Y280hJzOnEeXAiLqddxRC9WG61PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCXF5YQk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a370fae9-ffcd-4713-a2a8-1b9df5c51da9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773426714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fk82VMnZFWi3o0UqGB57eiM3JaDB+xZIyM+NQYIb1U=;
	b=ZCXF5YQklKw/C3uYEzHN1YytSfaJbBQzUiaPNwM8A9W5Hf1eEbkk/fERJHg1jpEWwli4nv
	9YwwGQk4M7aVGQvKERRrcwFHf8FSBhziGkqbzQ952NWE+WsnZ1wYFXAZZ+YqxjFqX3KPwQ
	bRX7914VpPsVOqB57hn4aTq+zcr3IbY=
Date: Fri, 13 Mar 2026 11:31:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] clsact: Fix use-after-free in init/destroy rollback
 asymmetry
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, Keenan Dong <keenanat2000@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260313065531.98639-1-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260313065531.98639-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mojatatu.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-267559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2223C288C6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:55 PM, Daniel Borkmann wrote:
> Fix a use-after-free in the clsact qdisc upon init/destroy rollback asymmetry.
> The latter is achieved by first fully initializing a clsact instance, and
> then in a second step having a replacement failure for the new clsact qdisc
> instance. clsact_init() initializes ingress first and then takes care of the
> egress part. This can fail midway, for example, via tcf_block_get_ext(). Upon
> failure, the kernel will trigger the clsact_destroy() callback.
> 
> Commit 1cb6f0bae504 ("bpf: Fix too early release of tcx_entry") details the
> way how the transition is happening. If tcf_block_get_ext on the q->ingress_block
> ends up failing, we took the tcx_miniq_inc reference count on the ingress
> side, but not yet on the egress side. clsact_destroy() tests whether the
> {ingress,egress}_entry was non-NULL. However, even in midway failure on the
> replacement, both are in fact non-NULL with a valid egress_entry from the
> previous clsact instance.
> 
> What we really need to test for is whether the qdisc instance-specific ingress
> or egress side previously got initialized. This adds a small helper for checking
> the miniq initialization called mini_qdisc_pair_inited, and utilizes that upon
> clsact_destroy() in order to fix the use-after-free scenario. Convert the
> ingress_destroy() side as well so both are consistent to each other.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


