Return-Path: <netdev+bounces-282964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDlUJtuW82nO5AEAu9opvQ
	(envelope-from <netdev+bounces-282964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4004A69AD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830BB30262CC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DF47887B;
	Thu, 30 Apr 2026 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nY4RuW/O"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650F477E37
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571442; cv=none; b=AE6/o8Ro+aA8NnYo/Li6APEf6CLLcKFLCapHuozXB50bmO+w5zIHSJr+ZLypd0acSGFdtY115l6Vy33nNdgBRI3gCRctYLEBB6JVKAupJo24kA+zEo7DqQZj8ytldOJKfFvbWqlS+Pe9SNgSS6/VFYLBbQI2SsQPYB3mQwM0Btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571442; c=relaxed/simple;
	bh=kEdW7EIrFjhtlqsPOdgL64/jkA4ADvKNvNxeaOjLL1I=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=izPGyIHmey5PYFVp5sfK/ggLdPvI9GyySXLJZeOGA6MwAvWSEY1qjvKZ6s1qP4AOkfNLGUFM/vHmFl8SRipqhv0WXvuQMVmaovRiklkSH4+8DPXl8/aKDOfk67UOhOKJYHF4pAO3HUdFHMveoxiyC3gg053nUdutSgH9HcdpFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nY4RuW/O; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777571429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nw/7KpLkvKo4TFF8/HeokXiwpBf9w53SwvYgIfr+UD4=;
	b=nY4RuW/OKLGNb4QSU9YL8m53BIZgS9aLj42bOOsWrTWp7FDttAC4l3TsMTdS0wguWMUYeq
	Gd6vrCmU1p8G7Vj8J9vX0bm0bNanTBeSr6e9Q85uZl6SErNDOiLRCmxv7ugyJYfrEWMDEg
	ufWY/k8cIaU/xQyEUtBBpYf9Pw6l4Xk=
Date: Thu, 30 Apr 2026 17:50:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f3778bc7e9dd3b2f213a847cf9229f82dd70507c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 6/7] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 "Alessandro G" <ale.grpp@gmail.com>, ast@kernel.org
In-Reply-To: <20260429222944.2139041-7-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-7-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0B4004A69AD
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
	TAGGED_FROM(0.00)[bounces-282964-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid,queasysnail.net:email]

April 29, 2026 at 3:29 PM, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@=
kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:


>=20
>=20After bpf_exec_tx_verdict() returns in the zerocopy path, the local
> msg_pl/msg_en pointers may be stale. If a BPF program set apply_bytes
> such that tls_push_record() splits the open record via
> tls_split_open_record(), ctx->open_rec is replaced with the split
> remainder while the original record is pushed to the tx_list and may
> be freed by tls_tx_records(). The caller's cached msg_pl/msg_en still
> reference the old (now-freed) record.
>=20
>=20This is triggered when bpf_exec_tx_verdict() returns -ENOSPC (BPF set
> cork_bytes > remaining data) after an internal record split: the code
> dereferences msg_pl->cork_bytes on the freed record, causing a UAF.
>=20
>=20Reported-by: Alessandro G <ale.grpp@gmail.com>
> Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> CC: jiayuan.chen@linux.dev
> CC: ast@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  net/tls/tls_sw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
>=20diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 600e13effaab..d086b43fc675 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1157,6 +1157,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk=
, struct msghdr *msg,
>  else if (ret =3D=3D -ENOMEM)
>  goto wait_for_memory;
>  else if (ctx->open_rec && ret =3D=3D -ENOSPC) {
> + /* bpf_exec_tx_verdict() may have
> + * called tls_split_open_record(),
> + * freeing the old record. Re-fetch.
> + */
> + rec =3D ctx->open_rec;
> + msg_pl =3D &rec->msg_plaintext;
> + msg_en =3D &rec->msg_encrypted;
>  if (msg_pl->cork_bytes) {
>  ret =3D 0;
>  goto send_end;
> --=20
>=202.54.0
>=20

Reviewed-by:=20Jiayuan Chen <jiayuan.chen@linux.dev mailto:jiayuan.chen@l=
inux.dev=20>

