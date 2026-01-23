Return-Path: <netdev+bounces-252909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHyCAtq1c2liyAAAu9opvQ
	(envelope-from <netdev+bounces-252909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:54:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626877938D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24A0C3081766
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF787264614;
	Fri, 23 Jan 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkKG0+FA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9895224B0D
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190811; cv=none; b=SW+0xO5EMJTdWi1cXL06yfs+n4jVYhKtjJM8S3X5lIv2S01Mbl9S0X0k0mbM+QCdmlfaJoMlDEaRkElD8T41EUTpIqzWnut9PWdFlT1rH8OFcuIgFHlG3GrH70XfF50W+UHL5HMs5uwvEwQ3YAyIW5PnPTTOB2IOu2OpRTfGNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190811; c=relaxed/simple;
	bh=Ngb198EaRQZj/Lg9qxhWgPLIQsS9y/RdrVTIA6oMmDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUxCX2Yff+Qw+mSU03OSnZPrCj52/5KTPcByanKCk5Uhy6pgPY9UAJW6zm2FE6v1clNMqRnVT63eODg/ymjmW8GLrxSaZDheXSeyuGLFL/r6pgAXca3gI3+kPZBuHc+N82v+1PAvYYy4GJwsW3hJyjHaw82wVnrInDkSNTUeVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkKG0+FA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA701C4CEF1;
	Fri, 23 Jan 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190811;
	bh=Ngb198EaRQZj/Lg9qxhWgPLIQsS9y/RdrVTIA6oMmDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkKG0+FApRLMqBGtcEXIIlCVjuJofEluYjTmc5fHRUyTAy5pNTIn9wljql+s/H65Y
	 iLDDBtXXkbbhGOa7jM10SQuuaqWYe+p7bsmqTBMuD5pEsr26vud0eljCA5+mcBnv/o
	 4pStLO1EnL4CAgKL4TMEa3Lxk/cgcvEUVoD0jDQM1p5pqpYXVKfLbqr6k4v9FGADo0
	 Fq27KWjf3EQWcAJDSARgs/E4tnFWZ/uCksmXu1X+S2AWFJm6dG5BdNTufRVSiGgZLk
	 ZAWXaVtFF1PkgYebQ4MM09e19e6x8+OINJHnew0NtD5ONVl54bkG2DZoycXKHsXa44
	 oS+sKcSf+8flA==
From: Simon Horman <horms@kernel.org>
To: pabeni@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	idosch@nvidia.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	donald.hunter@gmail.com,
	razor@blackwall.org,
	kuba@kernel.org
Subject: Re: [v5,net-next,08/10] geneve: extract hint option at GRO stage
Date: Fri, 23 Jan 2026 17:53:13 +0000
Message-ID: <20260123175313.1286366-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
References: <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,fomichev.me,davemloft.net,vger.kernel.org,lunn.ch,google.com,blackwall.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-252909-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 626877938D
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
geneve: extract hint option at GRO stage

This patch adds helpers for finding and validating a GRO hint option in
the geneve header and uses them to extract hint info at the GRO stage.

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index a4c23240d9e3..2e1f85b8af4e 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c

[ ... ]

> +static unsigned int
> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
> +			unsigned int *gh_len)
> +{

[ ... ]

> +	*type = proto_id_map[id];
> +	*gh_len += gro_hint->nested_hdr_len;
> +
> +	return (void *)gro_hint - (void *)gh;
> +}

[ ... ]

> @@ -541,13 +700,13 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>  					  struct list_head *head,
>  					  struct sk_buff *skb)
>  {
> +	unsigned int hlen, gh_len, off_gnv, hint_off;

[ ... ]

> +	/* The GRO hint/nested hdr could use a different ethernet type. */
> +	hint_off = geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);

When geneve_sk_gro_hint_off() succeeds (hint_off != 0), gh_len is increased
by nested_hdr_len. The current packet is then validated for this larger
size via skb_gro_header().

> +	if (hint_off) {
> +		const struct geneve_opt_gro_hint *gro_hint;
> +
> +		/*
> +		 * If the hint is present, and nested hdr validation fails, do
> +		 * not attempt plain GRO: it will ignore inner hdrs and cause
> +		 * OoO.
> +		 */
> +		gh = skb_gro_header(skb, off_gnv + gh_len, off_gnv);
> +		if (unlikely(!gh))
> +			goto out;
> +
> +		gro_hint = geneve_opt_gro_hint(gh, hint_off);
> +		if (!geneve_opt_gro_hint_validate_csum(skb, gh, gro_hint))
> +			goto out;
> +	}
> +
>  	list_for_each_entry(p, head, list) {
>  		if (!NAPI_GRO_CB(p)->same_flow)
>  			continue;
>
>  		gh2 = (struct genevehdr *)(p->data + off_gnv);
>  		if (gh->opt_len != gh2->opt_len ||
>  		    memcmp(gh, gh2, gh_len)) {
                            ^^^^^^

When the current packet has a hint option and gh_len has been increased to
include nested_hdr_len, the memcmp reads gh_len bytes from gh2. However,
packet p in the GRO list may have been processed without a hint option
(even on the same socket, if the packet itself lacks the geneve hint
option), meaning it was only validated for geneve_hlen() bytes.

Could memcmp read beyond the validated region of packet p? The socket can
have gro_hint enabled while individual packets may or may not contain the
hint option. If p lacks the option, it was validated for a smaller size
than gh_len.

Note: this appears to be addressed in the next patch in the series
(566c51bcb23e "geneve: use GRO hint option in the RX path") which
introduces geneve_hdr_match() that recalculates gh_len = geneve_hlen(gh)
before the memcmp and handles nested header comparison separately.

> @@ -580,7 +759,6 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>
>  	skb_gro_pull(skb, gh_len);
>  	skb_gro_postpull_rcsum(skb, gh, gh_len);

