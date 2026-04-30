Return-Path: <netdev+bounces-282968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEYhJn2Y82nO5AEAu9opvQ
	(envelope-from <netdev+bounces-282968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:59:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F14A6AE0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68C63007357
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4E47A0C3;
	Thu, 30 Apr 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZ8wyOb8"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC146AF36
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571935; cv=none; b=nRYGoZ7nWiMxP2pe5gbS+MyRN2zgRViMXe5oRmEml8GVkizXbKlrDnXBG58NzjK7eX5bSOBbLyjHFapdyW6moR1k6bycqwlHQQ9tP1yuLzIt9l7PX2l53+2vO/yQifb+WlPUyg+tevfaU+1fdrToTfIXYKN49RaMgHDCjG5p6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571935; c=relaxed/simple;
	bh=Kcg8W+ZTOQE+8cA7HvSd25KeCKMT9zrWl3FRkgAmEEM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ENUgQBsEv+JwXuQaGBhbKdV3n/P3gCi5bEnNs6j/FrBQbGJtXew4hBxRc5rDTDAi2KxFMhPlPTzrtWFrKfjE5dMxQF2Xv/m3Nfy3or7Cw7VuEPmBbwVyPP348sYy/MwTZVWQnoKq0QnOEAEn/hIiddH1drzqWqBUOFU1oUrGSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZ8wyOb8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777571921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRR2X5+N0mws7NhlZiDaLMl7yupCWnFgOdxSvhMHF1c=;
	b=uZ8wyOb83tUgcddITbF9Vx34FdPW9/eUEGYzcPVNHSLnnedSTZoEFIVmaEc+COVClkF0TU
	tI/HWfCfiQWd0J6Qywj45V0OnmMVXFI0vslhiEKDhEim8rHnEhvPf7J8+8xsXy+m5HAV12
	lTLGVS4kbEyJax8ftJMBcHNgxc+122I=
Date: Thu, 30 Apr 2026 17:58:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <ddc93184e197c3f4793aff5ab72b5ead782e4412@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 5/7] selftests: bpf: cover wrapped sk_msg ring
 chaining in ktls TX path
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 shuah@kernel.org, isolodrai@meta.com
In-Reply-To: <20260429222944.2139041-6-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-6-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: EC0F14A6AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282968-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net,iogearbox.net,linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,iogearbox.net:email]

2026=E5=B9=B44=E6=9C=8829=E6=97=A5 15:29, "Jakub Kicinski" <kuba@kernel.o=
rg mailto:kuba@kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.=
org%3E > wrote:


>=20
>=20Add a regression test for the off-by-one in tls_push_record() where
> the sg_chain() entry count was MAX_SKB_FRAGS instead of NR_MSG_FRAG_IDS=
,
> causing the chain pointer to overwrite a live ring slot when an sk_msg
> scatterlist ring wrapped (sg.end < sg.start).
>=20
>=20The new "tls tx wrapped sg chain" subtest:
> 1. attaches an SK_MSG program (prog_sk_policy_drop) that drops the firs=
t
>  N bytes of a message via bpf_msg_apply_bytes() + SK_DROP,
> 2. splices 17 single-byte frags through a kTLS TX socket so the ring
>  fills to sg.start=3D16, sg.end=3D17,
> 3. removes the socket from the sockmap and sends one more byte, which
>  wraps sg.end to 0 and exercises the wrap branch in tls_push_record().
>=20
>=20Without the fix the kernel hangs on the wrapping send (the corrupted
> chain pointer leaves the sg traversal stuck); with the fix the test
> completes cleanly.
>=20
>=20Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: eddyz87@gmail.com
> CC: memxor@gmail.com
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: jolsa@kernel.org
> CC: shuah@kernel.org
> CC: john.fastabend@gmail.com
> CC: jiayuan.chen@linux.dev
> CC: isolodrai@meta.com
> CC: bpf@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>=20=20

Reviewed-by:=20Jiayuan Chen <jiayuan.chen@linux.dev>

