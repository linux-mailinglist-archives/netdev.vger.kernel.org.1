Return-Path: <netdev+bounces-297266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvJ3DpRwKGohEwMAu9opvQ
	(envelope-from <netdev+bounces-297266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:59:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6E663FC0
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:59:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=Y1eJWGuV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297266-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C012D30082B8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE13905F4;
	Tue,  9 Jun 2026 19:57:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C03C1086
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:57:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035070; cv=none; b=JCMn6prErJnT6VTOgGWJkLdqlr4lozaZa0wzBZQSkG2R+4qtiXPJJzrYyxCklx0WacO6XLfmCvcryEJ9DNTnksUoIDuhtsbgmNZG0yZB3HbUqWZXXVjzIfR1ytFigiHnA5AyzHSb2Ice7c5CJl7QfCyGUwskpIJaK0IS1ogOPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035070; c=relaxed/simple;
	bh=a7fCv5wLIxj+nCM/Qy+1dxrARWcpekkkFpLZu9MR3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFzQ5hrrD8rR5FkCwaPL+TjEFbt2mjv9hDq9fmQRMarnE+PnXpcrtqtq45zr8PEnKqeuTdjz2ZK4Oeo8IPWdj9vtpU3F9E7/FJ8pj7G4Dbk479zA+ElStaySGXUjwavAW3p4GSqHVzEZs9N4kONRHTEZlM7vqbN07f5tQb/Z1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Y1eJWGuV; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6031631a91.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781035069; x=1781639869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y+0/kZrwWOWyWxbKYOC/B4QSO4pDLATi+5VWTxBV0U=;
        b=Y1eJWGuVFSdLZQQ/2pouuVufar7RgnC+Gyg3BApTZg6OuKNwDClR8tsn9gLTot2mkl
         WdAvoB1ShZgXDyypC49NayCGgftxbOE80bboh1h+zlCgd/pfvQNHXUssPxYNX5z0r0A1
         CDurHB2ka+Dnh0KgssiPD6hrPCqfd5H246epzOw1Js5O9r20j2v3V33lLRlm7jxGQ1as
         o18HDrQGi9fNz+ZS+E2vsXz8m3YeiHATTCLqPekHn2Nw9H7JMQPpSKpSwab8knk9gZct
         6oqzxQu0VxJ/A7g/3NaD3LvkPkR9xkWNeQO4elKGt0MEpQZPxw7BCuwASJ4yOynH96zh
         2yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035069; x=1781639869;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y+0/kZrwWOWyWxbKYOC/B4QSO4pDLATi+5VWTxBV0U=;
        b=ehTz6oY8K1RgMMnVlNhLeCY4mw2WKck07nVyTUJlNSh2TAIqqOWAC1NzFGB5E2xB8R
         49ta0eeRAhgoC4I/D/lVBt8ySzvKyjXWLkeX5HFM/XBit1BS0oW5mkPDMQotVbGP3i9Q
         /Glt6lToSu053RRsaRMbEqKUe4PxM/eumjoOy7YTWXaspEtTF5b/u+lARELRDC8Uz+cI
         0MbBvnOctLYTkYmujjHbpSmwpDKtIHNIbb5jIjs031WSds5NwMc2Yl8HGW7Gisf/z4nR
         hLyQ1GB9gh8YbhyKw148tLxsw6f0CP1Kew/0y1WTi42q3gE1s+pRSFjqirtQP+V42Nfm
         5HCw==
X-Forwarded-Encrypted: i=1; AFNElJ/o3/ezdiPVgO9A9OPd9jDdVH6PNm9IvxiTXRnqy9YcaGrIHX14yiUkd/S2ZbnEGbud6CWchbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtm9swocReIJfGILkRtbzTfb+MqaA68AIrAeIUsdNyQiL5FIE
	0HDV7gfC3W2cKK0lHlE9/i+JQcbXpfL3oSyqEFpmt0BqxP5BnWB8++wImY9N+jlyJzQ=
X-Gm-Gg: Acq92OEQGzgEW3TGZ6XFS2/FLBV9mYBO0aH2ghZOknqFf8CywUxbsvoE+qquSxU1f5A
	E5E0RHZ4fff44NmkOa9/Pj31IwVcJv6BxaEYO32Wqlofok5K65givTjH/b0AvEjSaSnG1rtCv/o
	EiAgVjh+sZ5l/chug9UnAzl5K1ei0duWnZK120K81/1EIl5Bye1UAWeUjgwZI6lphRvo+GIgPMH
	xSNlj7WfH/aMDECokc8ZjFNqlTkgXLi91pH7SYXIOS8ftp0tnKRcHpI2s6O6t1o/KWeTpS67fmm
	O/m3AQj2K3j8U2NmXpzpuiUIDhb2O5GuQG9+EJyYfSJj2f03Iw9apGqk+hpP+mzmMtrV7gvCpuo
	TxS7vKRYi/Vrh11GqU6b3/d6fpF19ePQIrABGjLA4Ic4GMqIjK90Zum/BeOGSQiLawGKiMoc7zn
	HqwL/yCncGPwvc0Xg=
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr22972729a91.6.1781035068744;
        Tue, 09 Jun 2026 12:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376246afe56sm239789a91.12.2026.06.09.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:57:48 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:57:47 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 2/4] netdev: correct error code in
 netdev_nl_queue_fill_lease()
Message-ID: <aihwO25sIpuExEsR@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
	daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
	dtatulea@nvidia.com, bobbyeshleman@meta.com
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-3-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:from_mime,dama.to:email,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADD6E663FC0

On Tue, Jun 09, 2026 at 12:08:02PM -0700, Jakub Kicinski wrote:
> netdev_nl_queue_fill_lease() returns ENOMEM on nla_put failures.
> This is wrong, the error code should be EMSGSIZE. But it doesn't
> matter, caller of netdev_nl_queue_fill_lease() just checks if
> the retcode is zero or not, and uses EMSGSIZE.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

