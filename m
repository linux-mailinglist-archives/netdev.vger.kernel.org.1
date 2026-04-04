Return-Path: <netdev+bounces-275383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q808DCAm0WnoFwcAu9opvQ
	(envelope-from <netdev+bounces-275383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944139B69C
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A08F300D317
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626E231A23;
	Sat,  4 Apr 2026 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5rA/eo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D1A0712
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775314461; cv=none; b=O/0h5r77kiwtlZIFan8WG9VGUFmbd3iVkVetUpVdSIX119Risb5qHYxHCpBFHRERBHbRuWhuq7O2F72KBgzWEMYhrGB1mGamW3Y8R0t117/NRRACK7kyRljYkHWKYFjBOKNm1smsHBmWm2vX0CXzTbm4c7Cun8Sfe5YtY6ZfCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775314461; c=relaxed/simple;
	bh=Ti4D8fNQQON92+1KM3xPGEd+sei+hAQKlm2rGC8Hgk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5TiGE3WExGCcgGvSxqM/RfgPMPWb5x5+QYXX4cidg+YWtwux4wg5/VEJsz0fdJAiZ300hlbCP7DewyVhucjmVh3p9zObSdEwFin6qpsIjOHSYv9fYJmz1LrgrqeMQtxOfEwLJZ/dkU4FEcXUgPFv9+Jv7Z8c1FcfI2GAPPR7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5rA/eo5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b9144790dso1519248f8f.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775314458; x=1775919258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HplI2qR5BeHqKQelXsplsD6MUiqnukn5Ida5y1aUhU8=;
        b=e5rA/eo5L5EiUk6E03KlO+XTVdVTG4yozkoWv0HvbnuQzAVP6ru1Wk1uM1In5nCxTE
         w2NYfxWQFHiSQkw2vOWZV8kLacG6cHdOazlgxuJEOPXg3uX0zciO3k87UKjgLzwLiDOh
         xlGgtELQfSeaRrc6IfmpgW4dYjRV0r/zWNhIre8m3YvvOD0qJPdj7lZoJLJ30cf4q9xu
         HBKy/WqJXux8Oc0zWTcbrnv6FdbL/0/H7mXbivO5SLaKh1koVRFGX7H5MNFeD4B/aOMK
         QKUifUMcwdL5OQRKG7w9Xw51/fxk7uOJDVeg5RBflw/ojyahZXdYusAT0EdX2ZRqmjeq
         gJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775314458; x=1775919258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HplI2qR5BeHqKQelXsplsD6MUiqnukn5Ida5y1aUhU8=;
        b=o+ZXEoODLYjZWpeSbgbs/7sc2yahvV4m73QGF1HaCVZgnDCBafBbHd4hYt7KracV2Q
         B9CLZ1j+nw6cdwfJUaSKSzpusM1AaEm6/93okVoFw4YT9VEvexLQMKiuXW+R3yOPhbaV
         QFunznxt8DIEZE6/wzx6a9UFQKp3csE6T9wiGrOZ+uRwCBTbqmuuXMtk8hQ5HZDceXxo
         CTsU8cA9RteUZFmit1wGhs9GnJ3eEj8+RCIUyvNKR7Obw8Out8ISpqFH58cMafh3aXww
         e6pLQevbUq9KeNbnekxmv+Ae0JONqqBBuXzjufBSTeHMYBQSquqhFqzIVoLqetK8vu2u
         QaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXglZR0DT3A4qUt8XsuU3mm6xCbm988FCXCX85ZOQ+GNOX7IOGtrJAYvmk9WZRj//7YT90CGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynH4HO50M0tNCUS/hj8vC2U/kj/oM+RJqDWagJ44HC4Qm+UK0n
	vavLJBbnl7PW/Ykgb9oaxWDmfFkszLy/Fw+IMPN/RMVqQqpL/SfUZHnQ
X-Gm-Gg: AeBDietTssCxXlqA9CxLM5ckRTCcSEBYHpzzGdxA9Ux+KRyF3frAIa9n70DcW9k5m9M
	BR4M1UEPaL8O4lGMoY1HYuAvfhsThnSvhS6Dr6JAi5qbBHDiNctULoOkJOBAWUmVlbNN1XQ5wKU
	lxP7HEkKV1YIdsOZInyRqQJi2bcAmZ4VJYw8L8orSk/i2b/Yxp7svDwlP1Xhkq4pDHxQ4ucKuzf
	sKRq1EGtz/o5S6m3JRuLzjf8dUU22KP/d/ZGHpSZXI3fLdiDxrNAzevww4dxhGBwdNArefpF1YA
	bBSc3ZBxFjEwsnek4EMLXiz5t3l9mmNyddD5ByfFOe/7BK//C7ey82SqaqZWdA6KVprWqyMjgNx
	HY3fuGKaHC2QM72ctGfIsZjNDbAk3QYuKgf6jhy56HnON3nA81Hab0EjgGMT/3jFsn7mjHRn8T9
	TS7R3hLzFQMridnZ1jZ5G8/L60Dp2acA==
X-Received: by 2002:a05:6000:2489:b0:43d:1c7a:8b5e with SMTP id ffacd0b85a97d-43d292daa3amr9603231f8f.35.1775314458090;
        Sat, 04 Apr 2026 07:54:18 -0700 (PDT)
Received: from pumpkin ([31.55.121.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm23747880f8f.26.2026.04.04.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:54:17 -0700 (PDT)
Date: Sat, 4 Apr 2026 15:54:15 +0100
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
Message-ID: <20260404155415.5b98b794@pumpkin>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275383-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7944139B69C
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

Q: does the line make any sense to someone reading the code?

I'd also generate the .i file and look at output first.
You might find the line doesn't fit on your screen.

	David

> 
> If this use of FIELD_PREP is preferred, I will drop this FIELD_WIDTH
> patch from the series as it would no longer have any users.
> 
> Regards,
> 
> Luiz


