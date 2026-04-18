Return-Path: <netdev+bounces-279477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKj3Oo0k42naCQEAu9opvQ
	(envelope-from <netdev+bounces-279477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 08:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCF4202AD
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 08:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740B73047513
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B334F48E;
	Sat, 18 Apr 2026 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGBaHZPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457F33CE80
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493677; cv=pass; b=R7X2GVHeBTaRq2PWVdXmZ80UjqIJXIbBewSFD66mN/cXixE7MCouG8v0XbJEEYt1rWRVQqpXVN8VMBHiMoS7e3QZ3bZJbmbAqOFOADp71/mzxSR07Kytlsv5Tuc91Q9dBUCqoPglPGPNESgZsyWgBEMWmj1d30YY1T3BSuv/Dao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493677; c=relaxed/simple;
	bh=hxCjzk4K0sPjhYyblUWrxUR/OH0u3SE421/QOr9YvLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2OoejLHf+HPhlN8XRXjZ78eiHjs14xo/D/JGosBiWfM6sEPTACtAKfIZ1058UAn8aDuOWQT/1N/wnZ3MAMsRLTAYoIhBY1OYzg/FLTEn5Hq+83coFyQopcMdZ9V4dO/MyJ56y5R6Cq3XubTIBamdOmO4ujMcA4g0BO9EVTexIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGBaHZPF; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50bbc41677dso19807141cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 23:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776493674; cv=none;
        d=google.com; s=arc-20240605;
        b=Ja5p3wFbQV/wuHegDLwQhUFfEmMF/7MAnKuJyQ/oRssQt5YQW3HlVh45MbVJIkogAE
         0OtvJ9uGBb/rx/29ZdvGwlNTtB6jkgUUgS8wZcqu4gRPJ0KbKh6lkR9lw6ErElK+5x+4
         ti5MZTr6q1PGUJlk0acilfu6DTlO7FynyFFqchdv9vLA8DX9TrOCffL7Q/4UzMeveVEk
         uIomv7t5+WdRBPhjs4dcB2IareNYtbIb24xts/zfY+vYF8K+kfTnKCbN3WwJBbAMaP7c
         o9g5FrU1kQl/VVBoboB6Lorvp1RtU9yEOXhe0I8WBk6ecSoxNwni+a26TrZIRV9Ah87l
         4e0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hxCjzk4K0sPjhYyblUWrxUR/OH0u3SE421/QOr9YvLY=;
        fh=feIr15ItyZJOSx80UKdLwgAY/Bf+/TwEWj3702ebsTU=;
        b=IHEoogbR5m7GBBA2Uo2vDS9+v5I0eNOTaBfqNJjffUuVYqrJ45rnnn+VUYem7G+bjj
         jp0f8EcSJXKG54teHyWVZ4uhuHAliHex/XSIC28/TD7T/WvqVj5XEb5gQKF+m3GLJ6+1
         1Mvq/b2utIMpV6ux4PfMLTeKektjpfod9kB6ZaThy1pvO8MzuqqqPBRut2F6Tz5LhDG2
         cVnwbBonjusES5xM/wtvGBIdTXZipLIz8Xw2aEgWkNkZnsohLmqms6HhyqHLiG/Od0b/
         w1nLK7LNIlo0k4XmelWyVYandYlGdSBqyE8v0hdIMvFLATSJGS9lHyIcCSOZY/jGmbet
         +VJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776493674; x=1777098474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxCjzk4K0sPjhYyblUWrxUR/OH0u3SE421/QOr9YvLY=;
        b=XGBaHZPFJjCttSD4cSZ5myNbrWAcCEfK0ZpGyIiIIvaGv3U+nckRK3UACbNC0FyTAw
         8hWrtY8IvSrvKxbfkJKTrWPAsPEE+EUCTunxQ9TvTHSjPx9EJxlWU20h51gSygJ4swca
         OmBioNNvwBOyLOyTImBeoyhdf1vZNGxj2K/vZULrdzTH3sCjZyXFYW99phpfTgwVH0Nv
         Hs6JGai9nv1ceWDamEroVul0BdIRbXJSYDtE2q4ZJleSlwfqCujozJnI8siA4MP4epue
         kLp9i5f4qLacLoXlWpbrpsj9De/x2Cv0pVir3mcmGO9V5Prp7Tm5oH+gzjD2aAa60TyH
         SRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776493674; x=1777098474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxCjzk4K0sPjhYyblUWrxUR/OH0u3SE421/QOr9YvLY=;
        b=gG3TPaJtjRASEqzlgGAw+Hyagr7cNrfE8wQH3n+Nz9YDWdvZBJyiHCp+nN6udroH5J
         spxhqG2rHpv5PRUJXeDc/lJkz8BQhhSsYy/FNMJVoEZz7bjAv63XegZDPCqJqWf8ZdWK
         cXXhRCbR7JkVTV0Y/uv1zjM2xicwDrWV47Eco62KJ2NZfcA6mzE5ARdUZHqo8X9/os2V
         FYMUtjOKjlm4X4FkETKp7/ReYFBRopcpQHWlDujL/YfHY2F4QGWb9/MlTZIa5Gx6y/f0
         /b6gKA8YVfHKCOBjbh7nIA26DMbum08EulNbbz5mrxh9oba2VCDWU/zrFHqys31Ht/eU
         vSSg==
X-Forwarded-Encrypted: i=1; AFNElJ/zhW0jUZBUMLleFGxGWfSSpKeZhbyiNOh9pd6XvPuDFQZv+hp2H83vUOCWJipZ8ngRRz1Dico=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWDDjzNwifTx2CPUeaxGatWveX8ZSs0v0uGWudUqgVIQmX5Gz
	nP0U7ThhXeZOwaVBYzJbvI6PsdxbEAI1ZT1WPlGHi85/zFDrfel6cppKpRvE4XcRbhybNAieiGE
	73a+vD+F5Xo7B/OybT4x67oCjoSrdShxUxKYLA7Zl
X-Gm-Gg: AeBDies8vsXJ1OzcB/UDQXYzazukN3g9jSAWnX3FO7GXsC5JqItDtukd0HMdcDcSj5U
	Gzc+5zfABrUGO6IXRKqdwL46wEGQY+NQMVJrOuA2EypPR7nV/0Kdmo8Jx9BWon4zIAyuzSKqTMc
	Yh8uvfRH6sUOPwiqg/13dC2HJFxpXsVu/xrOCzvAXTI67aQni3xao2acKCqt6LumSAJl3GR+n1R
	P47iyaGrkJkqTjQKaB4fHz2AGdmbIUQeqZrmVClIXLXgSBXtJB0JwuXsnBRj+LTLrAfz1Dc7YuD
	Q00rNHl9+K7CKV16wh2goeE3q5gjAkleXCFlJez11/g+e8GyW7uB7YbUD2jRRcaefp6w5tvGvOx
	joA5LPAgi
X-Received: by 2002:a05:622a:1e14:b0:50b:6cc1:38c6 with SMTP id
 d75a77b69052e-50e36e9aad0mr87674471cf.55.1776493673735; Fri, 17 Apr 2026
 23:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418021232.5425-1-dev.gustavoa@gmail.com>
In-Reply-To: <20260418021232.5425-1-dev.gustavoa@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 23:27:42 -0700
X-Gm-Features: AQROBzDDt3oVFKU2-Tm1qAl0VPNwWJoaTvqHgPIKohE20cwRP4JPWSmPiPoeHzk
Message-ID: <CANn89iLVSU=2=Gs70RK93ostNUBgyrqyhEdcZo3YsbuLVer+gA@mail.gmail.com>
Subject: Re: [PATCH net-next] r8169: report per-queue statistics through
 netdev qstats
To: Gustavo Arantes <dev.gustavoa@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279477-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 87CCF4202AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 7:12=E2=80=AFPM Gustavo Arantes <dev.gustavoa@gmail=
.com> wrote:
>
> r8169 maintains synchronized per-CPU software counters for packet and byt=
e
> accounting, but does not expose them through the netdev qstats interface.
>
> Add netdev_stat_ops callbacks and report the existing software counters
> through queue 0 for both Rx and Tx. Provide zero base stats so device-sco=
pe
> qstats report the packet and byte counters as supported and match the
> existing RTNL statistics.
>
> Signed-off-by: Gustavo Arantes <dev.gustavoa@gmail.com>

## Form letter - net-next-closed

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

pw-bot: cr

