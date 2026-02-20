Return-Path: <netdev+bounces-259670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0W6fCwQemGm3AQMAu9opvQ
	(envelope-from <netdev+bounces-259670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:40:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44B165D34
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F24C43007CA7
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CA3164D9;
	Fri, 20 Feb 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbD6US+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6272C1788
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576832; cv=none; b=ZDv5a3oc/Kds0H/I6xfa2zZzutw6rX+dNEcSKFOGOUoRw/kubkqapEeQKsc8r2fMn+EMOH8K+zIrSRq9JhtvJOSOEXrFvXV1cS6ulF4tsE5e15+V0UCJM+2enn3OeCuVK088QUMWi2PuPYXMlunCXCAjl44idq9wIMJQNg3M6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576832; c=relaxed/simple;
	bh=cwpGuMn1KdvSvNgpU8S5spu0pCHspmC3uPRaHcV292A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeGcAvbT03v9/674oSQWXNYVdWX77Dbang9QD7Eop/x9HTWIpVgeDPB7R93JLjeTVsRHS72mma9/9XAYM4eVSFnsu5GNvj0Sd3QvVPekzkV4Cy8PcbUEJVgC17Bv5OcEfNiAHB2zuTzGAvaxUW+2r1z7tWFqVGX4M0mIG8PFOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbD6US+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9541FC2BC9E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771576832;
	bh=cwpGuMn1KdvSvNgpU8S5spu0pCHspmC3uPRaHcV292A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dbD6US+35B1DTaFeHFhukPBKZRCujlyRinsXovTJj8scp2d/lRVJK3BZQUt9i2kw1
	 xcPmrgkZ6ZRFkZXNJxrYcHzQgOGZ02pYN7g4Ye7uugq3TAHrFi6ipTsh+5BseQJV1b
	 UMQTOaDmUpowCwuiV3zabeAStnYsp4VC6Tfqwc29R6K6Pfh2gb7dxnhQENHL6T8TDx
	 Fe3IV/3GUMef5Y1wYbRMaxq1y7HFG06kzQanOlcbDKpjjqjRVDBvRRpIe95I90Qckx
	 HO0j270rX1yLYD8hqMm2n9qOYhpvdMXRGRaHge9ZNOFGNO310quzMzYdmWo+p+0m73
	 rKW0nIWlpJtcw==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649b1ca87ddso1536937d50.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:32 -0800 (PST)
X-Gm-Message-State: AOJu0Ywsryo7zdrD2Ju+WQv33Zfp86jnyan/+JGK/zMZzmdtEA/JGCQI
	JniWr5yrsP6zUWU1gN1QVE07whe/zmFKCAPaH5Blh3xccYAvKAjnwy9vYR3yZal9qpFLp1PSNuH
	0HX6YB0KmBpStXQLPP3dEj8XMq/dPofc=
X-Received: by 2002:a05:690e:1444:b0:64a:df3a:1533 with SMTP id
 956f58d0204a3-64c555625c5mr5986104d50.19.1771576831717; Fri, 20 Feb 2026
 00:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220021949.40817-1-rosenp@gmail.com>
In-Reply-To: <20260220021949.40817-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Feb 2026 09:40:19 +0100
X-Gmail-Original-Message-ID: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
X-Gm-Features: AaiRm52J3bhw9AXp2v83yIbHN0n5WyPOfRj4AQR_C4rA1PoazwTXCOblWRlv5eY
Message-ID: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: support deferral
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-259670-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A44B165D34
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 3:20=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> When using nvmem, it may be necessary to defer probe until the specific
> nvmem driver is loaded to get the proper MAC.
>
> Rosen Penev (2):
>   net: ethernet: cortina: use devm to enable clocks
>   net: ethernet: cortina: fix nvmem mac addresses

Net-next is closed so you will have to resend this:
https://netdev.bots.linux.dev/net-next.html

But I like what I see :)
Reviewed-by: Linus Walleij <linusw@kernel.org>

What I actually most of all want to achieve here is to support loading
the PHY as module, but I suspect that then the ethernet driver has to
be a module as well so modprobe can do its job.

Yours,
Linus Walleij

