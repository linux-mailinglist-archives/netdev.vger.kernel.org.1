Return-Path: <netdev+bounces-258668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KI+Kqt9j2nZRAEAu9opvQ
	(envelope-from <netdev+bounces-258668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:38:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063931393E2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BFAA302A05F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E31A3160;
	Fri, 13 Feb 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="K6clRyHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150E19DF62
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771011483; cv=none; b=GM88ANepJxBFaQFgvyzZAedxmXAAFNyBwMJ7YpFh0kqic3k6bcKwrkJJvX3qcwdavqmP5HC9WSu5dpS2gDF7rdun82klT0uQAEo07VzzftlMHUIn79G4d8uL+c0q2O7dMjqikGBLTuyY/n7GXDLkeA5LKUqEZ5I4N60Xri7PLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771011483; c=relaxed/simple;
	bh=U7sI/xkyuRgahYXuvR8Vo0aIoYwBUu+TTBHsxFMgfCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyKf6nSNDGDA/tMVnFmKSNpqMfzVn6X4SntbSGT3+4K7d7V6IW2Z+4dXZVVlTReAiXUXGvI6epCwhqcsLDX7YssZN/Wo5Kx8AZUvEhOpakF/2T0AzRrsuQzERHulmmF8z+4ML53tzxz2sMHpncT2EQ7JrFT3djz3TBxXVDwtAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=K6clRyHi; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d15b8feca3so1332218a34.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771011480; x=1771616280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxY2oKY9sqeIWzMz/A1TUVWjLExOrW3QXCJCx5a7Wm0=;
        b=K6clRyHiND77dZ6nyw1tTZlmvwcxhDEbXTr+w16Rrm9SSbq8r2Ko8zEVC+HdJcJsT2
         2CLp9flmIwHi80BaS5qk54BBPQwEG9EcgyvVAo1k9Em+bdmSe285fzD3hfriX/PVRSxJ
         wBMCy2btaOaM/MrOvwT5Th6WUiHxrCOqvtfC1n54Y0QZNny5z7jU3WX6WFvMpvNwVAFH
         w2A+hongkc3l5XKGC+HdU9p5aqPJmcoxSNP8sCNipaTZvUP+J/oeRz3NnNvAvK9eDqbK
         udN7en13MPOXsXtp/+L0wSwRBkza+U0Yax4+xe9JN8LpAyZYY3CPMTIbrL1MMfKw5SHi
         KqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771011480; x=1771616280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxY2oKY9sqeIWzMz/A1TUVWjLExOrW3QXCJCx5a7Wm0=;
        b=Z2W6fpBRaInkOFiy0Bg9eQvZ7zGv1zZrgNY8b6OxxMbIJVJLDspaRTcwfoGReY9tkM
         ir8JGhlBRwumVMIkxULLeUg/jdxR8LuKRHVcchkcFJeE5243igbV7j22wqurLupdyn1N
         XHiW+6x6WfFTlYdqpjvOkToIy3xI+riy54Cji5D2IzxYfrXjipSAlPWdzRoP+M0FfwRg
         NDmumb5DNUtaY6ld9JDex6qM6DN2j1YpZsDpcnkawXpo4byoezJ/627KTuGZK/G4sAZs
         Y1qzJMSfr/GAar79Xp3mQLHvZXx2EhUNUoPNOfPFXcIkcOnIOA5jyv2eDlaXQLGFUgDb
         gAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtt1JCOPZ2rSVRAdxhFnx3PlPYVhsP/bnFj93GhfEhdY6n3e/QB61qaYPQ16NXTdkbwMNUA58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc+UDITWc2f/DRnUxd2VBq/se0EYmwMuOKC7xVU05wpDt8O1u
	a0tca+uL8oqOahRaVSzALboOef71O6TPVPGqOGSGw0Jsl6YtjYiJM/C3nKosr64JHyI=
X-Gm-Gg: AZuq6aIc0SIo2ylYoAInLmmXis+18UIhQEoLSpg8vIbzCr3ePOnju3H0kMhK7UP8W3z
	54A4JL6dy/QHvjzSYK/t+3kx3L1DPgxUv2ebh5izcubZ5DDZHMBRU6pmJO3eke4f/GuzCCiX7Ww
	dCRPgSPhcSo0R2I1on3enYoDoz/uhYd8on+56S77Qc/tG4+qP32FSM+yVyVm1FTcx6P3zn5b6Jx
	VIpC3Jij+PO+Oa1zmLmpoXyrv6GZL4HfdQ8iBBruHXx9dKfQNV8FePFYNvq1CvkAlVQWY5R0pGi
	Dfj/gJS/MM0irfQi7OMKCTvOPIQ0hbX6yYaqV0hf4ChMWJugNHko3Qk6DlP/XqNWychdUQu18Fv
	CD3B3xHuu7p4JaV697lwh+uCEz26mA6/WNnVFsQRb5KN/gvJoU1lh1U3NcWH7oupRbh9hH6/fWd
	9Aiorx5w==
X-Received: by 2002:a05:6830:700e:b0:7c7:62d0:b462 with SMTP id 46e09a7af769-7d4c49fbff3mr2239479a34.6.1771011480505;
        Fri, 13 Feb 2026 11:38:00 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530a8bsm7240663a34.4.2026.02.13.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:38:00 -0800 (PST)
Date: Fri, 13 Feb 2026 13:37:58 -0600
From: Chris Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com, jbrandeburg@cloudflare.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Message-ID: <aY99llj2HmFNrR_5@20HS2G4>
References: <20260213192449.1294830-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258668-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,linux.dev:url]
X-Rspamd-Queue-Id: 063931393E2
X-Rspamd-Action: no action

On 2026-02-13 13:24:26, Chris J Arges wrote:
> This patchset adds the ability to use an XDP program to extract the RSS
> hash of a given an xdp_md context.
>

I see net-next is closed: https://netdev.bots.linux.dev/net-next.html
I'll re-send with proper target after Feb 23rd.
--chris


 
> For example this XDP program extracts hash and rss_type:
> ```
>         ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
>         if (ret == 0) {
>                 bpf_printk("XDP: RX hash=0x%x type=%02x", hash, rss_type);
>         }
> ```
> 
> I was able to test this with a Broadcom BCM57414 NIC and verify that the
> rss_type and hash were correct for IPv4/6 TCP/UDP and ICMP traffic.
> 
> Chris J Arges (2):
>   bnxt_en: use bnxt_xdp_buff for xdp context
>   bnxt_en: Implement XDP RSS hash metadata extraction
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 ++++++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  9 ++++
>  4 files changed, 77 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.0

