Return-Path: <netdev+bounces-285097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPi6DW/p+2nEHwAAu9opvQ
	(envelope-from <netdev+bounces-285097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:22:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A30304E1EC4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D852E302A7E6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FD2475CB;
	Thu,  7 May 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaOK8f/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AD23183C;
	Thu,  7 May 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116950; cv=none; b=iow0c9/gmbO2K8CdGSatHKPkuFeSIekmSgm+NQfN1ZiBr4T8eV3pha3icM8oZwxIIW+Er9+g7Pnp3bwpSUXhqRpJEV4KmmBQdNn4grZZuNKHby8ihiVh85KswX4W5u0Vw4nDFfZDCyzaz2Hu4/q/QafZF8HSm4IqS1PwSvFB+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116950; c=relaxed/simple;
	bh=xwORKowaxjuo4NhXFRj/zliM3jrO13CzQdxT7viE+jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM7R6dFCN/Iy8OlcG0NnE0fu9fuFIt+8KwgOdsIM50cUpoHT9TbwXELA5SKeUgdFkaPBbUOgMusQ16INh+uBUU9MDUKfRRRj/lY38ca/x4sKHcX1FC6F9v4bU/YvI9ikIYjZEmMTKO5GLj3tcrOo7wLyyJeXssxOJ17STKK/DRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaOK8f/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26284C2BCB0;
	Thu,  7 May 2026 01:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116949;
	bh=xwORKowaxjuo4NhXFRj/zliM3jrO13CzQdxT7viE+jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaOK8f/1k5Ese7y43owYdudJe8Tpen+IwWuqK42TCmzTTAGJPhtlNCioJFbEvGVGj
	 TRQ5jDAi0RNgOvGHiRnbyss/xyQGjjeq3WlN8PTSvafH/M4TgGuaJqJzbOSj6Hf5b1
	 /VQhhD3FNXtK3CDCYUlM5CuixtT0o4SH6FfPZr1T1D5V6kxLsg2QZTm/p/QdJphe3L
	 SvDmj3MY+0qo76UlyB8opxcYEIlKNCQXhFo4EDZbORd+9BvIqHaSUEE0RwYZgSdt3k
	 z4/FeKd5VJc1GiMmd7tWjF7aMLnIGZiVNazi+jqHv12g47lAxjqKoV3lcAJ01vSa67
	 ZlycQwnnoOCuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Wed,  6 May 2026 18:22:25 -0700
Message-ID: <20260507012225.2187535-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504101258.1608004-4-mmyangfl@gmail.com>
References: <20260504101258.1608004-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A30304E1EC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285097-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: yt921x: Add port qdisc tbf support

This patch enables port shaping and adds support for limiting the rate of
outgoing traffic using the TBF qdisc offload.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 42dca9617fb1..dc38e0dd22ee 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
[ ... ]
> @@ -1378,6 +1390,112 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
>  	return res;
>  }
>  
> +static int
> +yt921x_tbf_validate(struct yt921x_priv *priv,
> +		    const struct tc_tbf_qopt_offload *qopt)
> +{
[ ... ]
> +	switch (qopt->command) {
> +	case TC_TBF_REPLACE: {
> +		const struct tc_tbf_qopt_offload_replace_params *p;
> +
> +		p = &qopt->replace_params;
> +
> +		if (p->mtu || p->peak.rate_bytes_ps) {

The userspace tc utility unconditionally sets a default MTU (typically 2047)
when adding a TBF qdisc, which is passed to the driver via p->mtu. Since
p->mtu is never zero, will this unconditionally reject all offload requests?

> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Offload not supported when mtu/peakrate is configured");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (!p->rate.mpu) {

Does this code miss validation for p->rate.overhead?

The TC TBF layer allows configuring overhead to account for additional
headers. If the hardware relies on fixed wire frame sizes and the driver
ignores p->rate.overhead, could this lead to a silent misconfiguration
where the hardware shapes traffic at a different effective rate than
requested?

> +			NL_SET_ERR_MSG_MOD(extack, "Assuming mpu = 64");
> +		} else if (p->rate.mpu != 64) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Offload not supported when mpu is other than 64");
> +			return -EOPNOTSUPP;
> +		}

