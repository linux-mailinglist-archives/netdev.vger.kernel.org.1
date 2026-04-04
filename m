Return-Path: <netdev+bounces-275393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOutOFYq0WmUGAcAu9opvQ
	(envelope-from <netdev+bounces-275393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C414339B8BD
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8979730065DA
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCF313E3B;
	Sat,  4 Apr 2026 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i91DwLtr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42A313556
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315536; cv=none; b=bOMPLe1Xn00ce5KSPvphzNr9dAZ67dr5PhdDNGs0lY3TtWN0UhcyRF3Sf9GrhHCRMocfr6KMIRRLrYcuiqJfIixt17Or33R+1t375iF2V50KLPlz5YFy5K2vUjCQTmD1q3nBHpUD55iZ4NIEa5F0O/M1gOo8UPnGbxwY7XWHHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315536; c=relaxed/simple;
	bh=5ZyF59ZxzU0MHRhnzMMPYi0/pcrH5x4OiJ3htf6hZEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+Ubk4weHnK3mExO590ccppDzlea2VITfl563eMDBjc22n3rW2Mh6+XJnprWmV1e11G1kx5oiSCwAAVLMX7Xq2GimJJTT6KrbzLwxIacOrPVFHWy3XDw6k84Ht9+a7IXbw+itpiZ5kT3pUMBsfdr7Rz/+VPoCGRbk3/NxeUvDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i91DwLtr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso23556755e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315534; x=1775920334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ0E1vtl8+KJd2CsoGkXmwbqSSzfsxHVVFD4Oqi1ZdI=;
        b=i91DwLtruvpNkZealt8kwV3QqhA4CMAJcxTxVmcAzWMRutQ9GOa+XyaScXUjnaFKSl
         6ekifGxZt4bF6i+xt5uvWbz13iZJWou1Kbtr3qBsvbpi8hvPRPqcMuHqAGc8jbHirOPu
         zpYLY2bPK/VRz7NGwJ2rNdK7oPXYX7hWypgc9tKTLl1XaxOG04NEiKdvlGKJs1m6S7H5
         QQSZ5csGs4BqWOJn3IXuWY9M+RcUzrxqUwBjQCGAncNvI9dqJkHzkBerFGpjym3gMnd8
         zWxl8NtfyOxWevs/3FPvI13lHvCRzjjjcA/OJJznEpTTMZnOfdUZjljEPFX8DV8X8Mhj
         yXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315534; x=1775920334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ0E1vtl8+KJd2CsoGkXmwbqSSzfsxHVVFD4Oqi1ZdI=;
        b=UhL7gKRJwNchZa/ocsYHC88DfqqY+lm2jAJzUPdiWLOV27FVDaxAq4GK/zFQ2rkmgS
         waKyTcJ7/+SapXDhsAJAxjErdUEKIEVlvmaHcbQK6T/JihqMk+gW/OBzuSDP20pNoZf7
         X+NH2IZVoOG7hSmBk/Trc9bgMjkeeGOAJTMZR2/YZyh2F38IjMxx2Drbz3rL27Of+UB9
         cREz3QASj5BOKwXyTFF90knoMDK6REvziRrur4LXd1qTbcgcPiSxw55O29NVJVQsOiBn
         KoMfzzz0zSTzPWtj2pdHt4FsjUYxMZ4EHZBf64GwgUewa+xWkX2YyTF5TrJEo+ZpYGsP
         azPA==
X-Forwarded-Encrypted: i=1; AJvYcCXshPndETjqZ617FKooQ7EAQN0OMLpKLeeWyUU+qqoEY4+DXqQfy6exn2AvQgJ0wta2Hh5j+HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eJKbmBh6QEoKrZIHJb3lTYpRr4rZAva8VZn1wj36GrJWw/bm
	zSNhbfqdJiDIkW2mnjWM/g1kCPOqkFl6TfcLI/QPfud3GUPZIm8wI4Hl
X-Gm-Gg: AeBDiev/r9BB0+ZVuHlTrNUe7QUFFGB9LEgK7I1Jc/D9cKtzc+NBRkyYNGsCzizS7pj
	bYycUIJVys3QSd4yZi6ch6jixmHo3HuD7VHrbp38n4qU8MhDCb4xmjs6sfAn3zICkmyLAZ/CyzS
	5qapPqWcp7IOsIX4IQTaeehcJS0X1ZUZ6TQ5IGtktrOC307C8lBcZWJbP1xqHIJGScITeli+7G+
	6mUMZjMFELaE1Mz5FDARwaGhmmJd9bp894kNaaynRSDEfRJAUqUs4i+6Cs5YoBCyOY6COir0iVm
	39sBfnhjiuo/M5VB3pBpOFHBr5960gJSo0E3CEYmfgE69t70/A7MClxTHbdUmOCaB334Mq7HJWc
	2BdzKwtYWu4jDsTyLsQcsEs/sueKP80D8zP+xclGy1qFFRJNbZEg6u4WUIrU5+r8DWNLGQqsz3O
	6ia1/3O8G5RlwO2/rAQmZmVN5yJFC4IA==
X-Received: by 2002:a05:600c:3f08:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488996d22f4mr113542585e9.1.1775315533554;
        Sat, 04 Apr 2026 08:12:13 -0700 (PDT)
Received: from pumpkin ([31.55.121.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899eccecasm44440915e9.34.2026.04.04.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:12:13 -0700 (PDT)
Date: Sat, 4 Apr 2026 16:12:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <20260404161211.47d8a05b@pumpkin>
In-Reply-To: <CAJq09z5kMu4ANp3n2Q0C1j8TULdCKW_yPM=nN78mNupAt51YGQ@mail.gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
	<20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
	<acx_1dOF3EjvGt4B@yury>
	<CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
	<20260402102717.5eb48393@pumpkin>
	<ac50sX3MZAcVSNJo@yury>
	<20260402232126.2e74631e@pumpkin>
	<CAJq09z5kMu4ANp3n2Q0C1j8TULdCKW_yPM=nN78mNupAt51YGQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275393-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C414339B8BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026 11:09:30 -0300
Luiz Angelo Daros de Luca <luizluca@gmail.com> wrote:

> Thanks David and Yuri,
> 
> This patch was originally intended to reconstruct a value split across
> multiple registers. Originally:
> 
>         vlan4k->member =
>                FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
>                (FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
>                 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));

That calculation isn't even really correct.
It is only right if the low bit of the last mask is set.

I'm not a big fan of FIELD_GET/PREP - they have their use, but get
overused.

	David


> 
> However, as Yuri pointed out, I can use FIELD_PREP() to align the bits
> into the final struct member without manual bitops. While less common,
> this pattern is used elsewhere (e.g., drivers/clk/clk-lmk04832.c). The
> updated approach would be:
> 
>         vlan4k->member =
>                FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK,
>                           FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK,
> data[0])) |
>                FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK,
> 
> FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]));
> 
> If this use of FIELD_PREP is preferred, I will drop this FIELD_WIDTH
> patch from the series as it would no longer have any users.
> 
> Regards,
> 
> Luiz
> 


