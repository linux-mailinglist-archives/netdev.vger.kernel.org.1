Return-Path: <netdev+bounces-297102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXtAHW4xKGqF/wIAu9opvQ
	(envelope-from <netdev+bounces-297102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDFB661C04
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yx63kkd8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297102-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CFCF311A533
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3144B666;
	Tue,  9 Jun 2026 15:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A435E1D7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017882; cv=none; b=icPaL+UAjenZNfztN4iE72BASCi4x0DdjgTpBhlEt9lLj3eeORlp10Jsx5VzqkvSrpvC6XF//KbvAPF5ffk45gu7TjBVPck+8lgvqBlFdxsNPApU8CYt0v2e+1zy1iN5R7Q1cXxDqX/PzJaTzeDMzW/27rsI1d4ebg0WuRlMfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017882; c=relaxed/simple;
	bh=YRz3C09HHFQwJgk+f8A0j1QarUwz5seOCWSC/l7H6eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNiyDlzfX3UHf8p6zp1XQfhVC46Gkt7R/0ouzZnZjQOJnEheoJheXIkn3AR2eIgKwMrUu+AxN45Lodk9pqq6mbPb2e+d6pFdhYqkTlPSKK0WWUID8Y2StBnpLd2F0SXxwp61b1LCXar4narXgK8SxtllzuyvEH9i58yXlmztfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx63kkd8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2041F00898
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017881;
	bh=gqXVbXFvhdv0+g0BZgMRmcIkQT6UBvHykZVhpi0c2PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Yx63kkd8Nq75de9UWtAPUXIOT1TOgNralSvFRagazoGBbzSrXzjXXIFWsLd44KWCj
	 LTSLHRwYvGJpcor6pLf0sGh9xannjx9EzgvK5FcC/jUHwKRyy+DeBUSGFPmNQayAw4
	 duSv5zpeu6ookMXCazzS6CaaW0wy1RAPRrUdOpJ/bSvghqRSsC+wstIvqpSLeKJ5FT
	 jrctLLpily7y7e5u7tm77cBIj4PscV1sz3pQ8f+0ZG0xRBSTDrNY4asTxCC8dnbp+x
	 x0FkKFaH1VUqcdfOxQ7vJkWlXxfD0IZO9cWiL7zJQY2JfMQ8C6G0b3afCeOOj0Nv9C
	 8+/5z7F6wIDwQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e2f3646c10so68763057b3.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ftvOqcRpbDmuWIgTZZSB7Tq9fz8LxE5XtenTHxrOZevLKiGq6Z5tVQOn4TdbBCMp45LPZ4xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDLA2LKPLaQvY9HnGLad07YHZzC+O6PJemuP+Kh7gaNFNfoWC
	sYhu8XIxcfB5aKNb8EACfstxjqdePm0jr9hB1wYoSprM60AtvNqJZ2rS0jfltQZ17cpA2Cdegq0
	f4swt8rQjryZiMFM5SXUFuW5G18UyAlM=
X-Received: by 2002:a05:690c:c525:b0:7dc:7764:3e83 with SMTP id
 00721157ae682-7ed0c4270e3mr211319037b3.17.1781017880612; Tue, 09 Jun 2026
 08:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-30-david.laight.linux@gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:10:44 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXNTeJPveUQ3x2TKtN3i6WE4gEJVWcJt+DdHSgVxwHrFg@mail.gmail.com>
X-Gm-Features: AVVi8CcTwaYD_5pMAVDBGikHR5l0fth37bpDUX9vlXLgZY6OlWBYcLyT2tmZ8x0
Message-ID: <CAOZdJXXNTeJPveUQ3x2TKtN3i6WE4gEJVWcJt+DdHSgVxwHrFg@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297102-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:timur@kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[timur@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timur@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BDFB661C04

> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> index f502db9cdea9..ffc300641aac 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
> @@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>
>         switch (stringset) {
>         case ETH_SS_PRIV_FLAGS:
> -               strcpy(data, "single-pause-mode");
> +               strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
>                 break;

Acked-by: Timur Tabi <timur@kernel.org>

