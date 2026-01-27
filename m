Return-Path: <netdev+bounces-253822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HqxEUWgeGn4rQEAu9opvQ
	(envelope-from <netdev+bounces-253822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D985C938FD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D89A3004F31
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97D346E46;
	Tue, 27 Jan 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+6BPDzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE67345740
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513026; cv=pass; b=atp1v4MSSdaz7l0dZ6VtW73WR8eHWpsWDjh7GEc4vQ/3bBg46/5mNOxJWzLj74txqY2ruMOhtDTae0nEZk52V2pJVNiqz05vd8UxayVPBh5Ou/DmP7NsEsPjjNrJOrZg34T8GmrvqUOEjEpwIkwos8aTtEI+1HfVVtmXtSTAsjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513026; c=relaxed/simple;
	bh=HrWfwvYHG+lp8lBanydsMN+slzlGPV0oN36crkRHcLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtusM7pQWJtyjWuFFL+pEyLlFkeYnz9LLFhbQ7Y2cPiKUlD5wvELX9ze8rr606g031IvBPKb/RFMxxyAzwF+2dwDm4/6A1yk2PNcAmFHQN3WBAffx2RXW/Nc8OZB3SXX0mibCTY8xSRX1r4jSovScpaZs3UYifcDhfJb0V3SHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+6BPDzM; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de77e2e30so4593239e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769513023; cv=none;
        d=google.com; s=arc-20240605;
        b=fqP8jfaRazSo0NrK5IxasLR7ty4S2Pb6ZDjfz/6oJLkQqNHNA7yNxOyTHj9Rqc9zPF
         d63tap9O4gwYCgFjEqFnzyfwirUIKYUg2VkSBcQnmd0tA/C1NAJM3WPG/haaX/vELs5Y
         Xw8ri77kpgK3wYFLx1P1Bz6GCPI303Yevhcsu5IGbe974y+HalP3jR3B3oos36OOScVj
         Y8smWkgaYdMCOSMkJvJU5MD+FxonZERLsWCWHSLfz+vwmAa1gUk4TOkL+09f7vf325Ah
         lWaMssNKM4Xv1MNSgLOo/STplGARDvVMg2KV4vfjjVY8Nf2K7brtYNd/TxQGDGv2glXn
         8Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HrWfwvYHG+lp8lBanydsMN+slzlGPV0oN36crkRHcLQ=;
        fh=OtosOsfq6vVmkpsbxNLFWkVoo2kJwYtzGzPo8GmcuGA=;
        b=KZPxpUyGGNvVofQmjVh/9XAtzch9MiPzGogy4lk5Shb7r3ILRzA5JhXvb+EX1578NU
         TgEPYDozCfN2cpI196ldavOA3plFco2L+4zc/0uq9O/umF3I2NM0tETyst3of9HnFBCX
         4pougBdkkFFML/DGt5GQ9dIFA6cxZ9KyiHZy5XAkRMIZrAojnaXnd+LxgncH/pfd9Vca
         jqTZzRyr3rfBFTBQZUUtkYwXC4En5ztrJZRJc1g4nonEtpaorQHbMZFhqGSFQNC9aXSF
         MORmkoCZn/yivAeqZ4QgB6NwY3/NvNMBTm/jY4pR/zzHRU+kAUhb+RCw2lMyCnY3xrx4
         cCxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769513023; x=1770117823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HrWfwvYHG+lp8lBanydsMN+slzlGPV0oN36crkRHcLQ=;
        b=T+6BPDzMAIXgcwSHD5LfziPrNhCsdVNvTeYriKGBzhhqdQVHTiIQAjTSgG4jGdXLRn
         j0Pt+aaUrAdEXWZot1cuP1LI8KalVClIKNSqt3Sm+lXzr2k4FRvoxI61N6rV3zU+y+uW
         wmseFlY/PGvxc7EZcY+L90Ahrps6r5429nurDTJdcyevONvLd1QKhXERu/Fj2+20Ec1J
         9bce2xMSMIgTYyM8z8842f1TScS4+Cx/q3PMjZ8aIF6V2xwf7saWZxqeWOSLW/EZE38w
         Nuc6NPEDbFKuV9ZiCwM3skyGm6pKpPimtKNZKfNR9I1DpYIk9Uu2RV5RrdvCN54XTPE5
         yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513023; x=1770117823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrWfwvYHG+lp8lBanydsMN+slzlGPV0oN36crkRHcLQ=;
        b=KgwviaMQRi2GvYF3JiInw4qxAXXW0IUoR4g8ATEM3ozEOyplwxFf0zKFj5mOCiqKnn
         JkLaQ7WisWwT6k/bh31Q06LlXUL889Ec6qk0bsMYIWjmbOX31PlRVaIhkSRGaQ+Ytzqp
         hILkncROuTtar1Cu2xSD5TCnrHWVJhcqDhlVNkrzZNSkrE52Dm51dXeDI8XrNhxs0E1t
         tqM5Y+1n2l1Wc+WHQi2oF+LifxY/0WKnORqW7R22SiZnDdF7wKz7tRe7QG8715gaG0tn
         3yhtZ/4crSFYcP4VtJOL9TqXftat+p1g2zJRhO9dvnAvAgdcj0HAu1w9GF1lNvPKuL3p
         9z/g==
X-Forwarded-Encrypted: i=1; AJvYcCU0GEuLRJz1bjrUcBlhqj71G+4YJKcFZZOuMEhGDTSPew+XwaZzt4IED90ES113lB87+LMzyow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZ7if3LFkiO/Wef/FtVulP8JnF0S+WPMHwgnx7dnZkmYdclhb
	+rxAbqmzcKhaa4VXqzqGMmKgW3NFZOGPsvxxBwdDI9P0V6BBcQ3bJ609WriCCSHVHw1/y1JMpbf
	sgXhClcWQ7VI4dBhInFstsV5RQ+xgDSE=
X-Gm-Gg: AZuq6aI+035vywQHH4gHHsj3F+JsIW2H4NcBI5eL6yE78NSN7f7a4ZnspqJmd5hvOgK
	pRGTAPRfmXZNgbrXTcRR3iRrc4MFWZYdjQu4BMqGfY/0hAz8PQujOQo7h+wcIFiPYtfaHJYvGbw
	O7ebgBqkH/emDbLV9DM5gLlXTroHxHpyFQX/tLBPSownuB977atuAf+JPGw/b5BT/8ccG2GyOqV
	IRmmJVdfi7xJ+uypCC5yTiHtJsGc1LVuVshmH62WWlKFAcYzit6PIKNwppujnA6q1wWVIFLrDu9
	o9DG1NF62vp6ncgrxAU7aLW+eA==
X-Received: by 2002:a05:6512:23a4:b0:59d:f3c4:489a with SMTP id
 2adb3069b0e04-59e040153b8mr580196e87.6.1769513023391; Tue, 27 Jan 2026
 03:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com> <20260121184621.198537-4-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-4-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 11:23:32 +0000
X-Gm-Features: AZwV_Qj6aiETfCOD944jEASzrWR6auE_ZCpfK6dMNt_z6sx3Hpco322dSmLyqOQ
Message-ID: <CAD4GDZyMtxz4EjRMqAiP2wR+csLEY61gDhBO=3HUWt=rOgZTTg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] doc/netlink: nftables: Update attribute sets
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253822-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,protonmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D985C938FD
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> New attribute sets:
> - log-attrs
> - numgen-attrs
> - range-attrs
> - compat-target-attrs
> - compat-match-attrs
> - compat-attrs
>
> Added missing attributes:
> - table-attrs (pad, owner)
> - set-attrs (type, count)
>
> Added missing checks:
> - range-attrs
> - expr-bitwise-attrs
> - compat-target-attrs
> - compat-match-attrs
> - compat-attrs
>
> Annotated doc comment or associated enum:
> - batch-attrs
> - verdict-attrs
> - expr-payload-attrs
>
> Fixed byte order:
> - nft-counter-attrs
> - expr-counter-attrs
> - rule-compat-attrs
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

