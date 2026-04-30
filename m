Return-Path: <netdev+bounces-282965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MyiCKGX82nO5AEAu9opvQ
	(envelope-from <netdev+bounces-282965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:55:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F34A69EC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 263C3300E721
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363A478E5B;
	Thu, 30 Apr 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwXb0oTb"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A6478E57
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571741; cv=none; b=ZVXulsYbwyqRGK8HtxlSOpDi3/sp8GpjCbdTNzicb7wj8C56A+kso+I0RdeiHM9Sazg/kIVSsCf/nqIxhNYcsL/zjwaq9okvHCIPePYNB3msJVTq4Ym+WtfkkwnRk3GTj4zEwxdlIxftCEgA/beXopYC8ESM4lIR7ECK/iqgu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571741; c=relaxed/simple;
	bh=1/BYTLuQnuyCXrg5nKytspUZa792KoAurTFKD1q5RTI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Uf+DIngJYasBCUg/VG4SR6tFLXSy2QwilxK1JOjVot122Bn7HCTddDHLrrWpLZywqK+BlkzMKCRDByr3TfGsU/2GqqSnZszXJIn66nE8spyDZARh4Q2W1JN6ofCKadtYFXbgrPswfVRcoGZvVXBkqnBAaBrWELqOsW64/lkRvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwXb0oTb; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777571737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/BYTLuQnuyCXrg5nKytspUZa792KoAurTFKD1q5RTI=;
	b=xwXb0oTbLigxB8Qu2nn8YW3obA4hsBsL2ihzabs0wHOa3RKhSYgGM/vkn/4n0hncMvYHgn
	smtzrEwunS5JvqVXCBoj/ZZkHBGnsElnodtNzMWL1vdHxAkzaXFDcAFYdZVfjAsmJPPQpn
	60cFW5UQk2TmHyuH+EkA4vJ0Jr1UgC4=
Date: Thu, 30 Apr 2026 17:55:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <64a92a9ced3da39212885fc00821b5a0aeb719a9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 7/7] selftests: bpf: cover tls_sw_sendmsg UAF after
 bpf_exec_tx_verdict split
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 shuah@kernel.org, isolodrai@meta.com
In-Reply-To: <20260429222944.2139041-8-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-8-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 730F34A69EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282965-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]

2026=E5=B9=B44=E6=9C=8829=E6=97=A5 15:29, "Jakub Kicinski" <kuba@kernel.o=
rg mailto:kuba@kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.=
org%3E > wrote:


>=20
>=20Add a regression test for the use-after-free in tls_sw_sendmsg_locked=
()
> where the cached msg_pl pointer becomes stale after bpf_exec_tx_verdict=
()
> returns -ENOSPC: tls_push_record() may have called
> tls_split_open_record() which replaces ctx->open_rec and frees the old
> record, but the caller still dereferences msg_pl->cork_bytes.
>=20
>=20Reusing prog_sk_policy with apply_bytes=3D1000 + cork_bytes=3D800, a =
single
> 1500-byte send on a kTLS TX socket in a sockmap drives the split-and-fr=
ee
> path. Without the fix, KASAN reports slab-use-after-free in tls_sw_send=
msg
> and the kernel hangs; with the fix the test completes cleanly.
>=20
>=20Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrii@kernel.org
> CC: eddyz87@gmail.com
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: martin.lau@linux.dev
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

