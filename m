Return-Path: <netdev+bounces-281062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH/VBpfi62kySgAAu9opvQ
	(envelope-from <netdev+bounces-281062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41D463862
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3221301A2A9
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A5382290;
	Fri, 24 Apr 2026 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elJ7JsCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2231AF2D
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777066641; cv=none; b=FR5MVRItjgkMtDBkTRiTGGsKM9mCOVDPc65jJNmtGxww2V64111R1nfNy2fzgP8avFMKtU5buYINM3irrOsmGYlbMAMzMBgqHytmJM7mdMluU1Bv098SqvuiYaqhiHD6eT7Sb1xu6NQOwEwkl8Nij9V20i/wB9pwCzK4+5ezV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777066641; c=relaxed/simple;
	bh=id1+Z0RiZnu9fcpdygHTv8Hyka13BoEKIX1ryJU4/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWgOttN8iAyDeGUDxa9MRISTEd7NqL58aSZuB0VqJOu8HIZ8nfEGh6lssiedju0GXogdOiJRkMWHasn5XLANVHEfrQM1jd3jRZssUjWMH5aEr5GCK1zIALzfPdZCDoLP/crIO5twTxRfqIwqJC9OD3be7txlsT2xdU5+b5Be3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elJ7JsCX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48909558b3aso78431745e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777066639; x=1777671439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ykeieCQiiUZi3J/2eeufITWyJmr5d8BX3l3RZUjInI=;
        b=elJ7JsCXqJWdvJle66uJiCMSLgrZivJZQPqvHT4akq6ynIrF3JAgq4mnxu4Uldqux4
         o3I/nDQBUtCVvt/YtDSGFbETohJ2ZKIonzDsMw9xgSt8kO+SzM2fWx0LjlOUr3kIj2bI
         4sVcyluttCkHiI0LgAq2e6JWRgrZOA7/u98ec6iic+yaYZo76QRDrYhwrNHAGgYj01pG
         oZ2caMsOXZdOic6AzK/dGarNuw2sMbil2PLjwEw/Jp05/QMgNPdjWS7mf9smswjbZ0z7
         F7vNG3QDUs4jgo9/EXZWksIJO1YeqOJbBuBmr68UjYC5LQrSwPvwQ6I5lykr0uVEtJU/
         RlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777066639; x=1777671439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ykeieCQiiUZi3J/2eeufITWyJmr5d8BX3l3RZUjInI=;
        b=l1mYlmdQlOjr4VARIPrspFdoh95i1oFFRspUL/0AA8PIzfZdeeverlwfiBVNNNPRVY
         FiHb/5JW1us//fY2r1Zt1kYjbNOnFgr19kk7Z2ZQ+KRLWbJkTpIg7PkLmyQ1LorWFBSY
         b/XbMCkPBKpQ1S24aSSPCJJZyxfKEXemYlAKyGtiZjGPKHQTJmH7RCsgMboRl3QRKy+z
         Dcmi1OuNTcVSpJkJAki96U+r/B9Z9n1w2TtjbjpWOEDjwpTHkOgoduCE4MS9pl/lLKNy
         koH+xDke06PpbKdxA1YOqz54lLWpejPnAv9RJHtnJGQ1isbdUQJdQkLvVWxYRBxP+jY8
         mb+g==
X-Forwarded-Encrypted: i=1; AFNElJ8Nxs/x3mueC8nLy6l3YvMkOIsaXCmf9j9ag3/k2FaV9zPO7SIV68iv+k2uDoi7f7nYKtYPWZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYUnMfpNz4E1VahADrjqafZYlw7JIyK1Ph5GkcFsGSr+xb04X
	L895gA1+SDfH1ScDJ2QP01Usx5R1ybeT8mim3sd51HBRX7DU3kRZLQ5R
X-Gm-Gg: AeBDievvZMMOjFzQRPn++R9QoPs9Fb3KWOx7y4uCgqlN2cOzjQ76QvVY04VNl2m6ODl
	hq6s1dXLSxrwqN0ozH+D7j9jVmb8Jn0E4C3YvSWOCNp7t2tdspKmASvXTIWqWRwQq2YrDZbI1Xc
	IfcjLigywhiIVw8tzHIWa9E/zjmE1u/jidN4HGiOCcaZAklxhQEiK2X50qY1xDmxOv3XDNs0Thm
	lQTXU2YPAe3keww08e2PE/tDNfTYtYTkPlqSOppTVwMTZ0VZVEue2lnf64GsguiDMzPS1rcvRng
	4g2snZA7VYcKmtyDHCksgGslXYNucMJ1UP1LN+WU18rCzPp4hGKG6kuzjeLJdALv8OIGOCKalmJ
	pntJeXNYdqdUTj5D6R9H2wWARL52O4RQsHXbpS3ScSiW30JFGfynIbICxZ64kWNOD5lcuNQEAUA
	0/TvfgC/WBZtHIaLDSuPWaNKKsq4H8MG+maZPanrTQVtabSY08M76EtHmSsXIgYF8vu8ydvKvIr
	fA=
X-Received: by 2002:a05:600c:37c4:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48a55017b71mr283475335e9.18.1777066638544;
        Fri, 24 Apr 2026 14:37:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm424493425e9.12.2026.04.24.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:37:18 -0700 (PDT)
Date: Fri, 24 Apr 2026 22:37:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ping-Ke Shih
 <pkshih@realtek.com>, Richard Cochran <richardcochran@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede <hansg@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260424223715.077288e8@pumpkin>
In-Reply-To: <aeub59FBHbCy-KKP@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
	<aeub59FBHbCy-KKP@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE41D463862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281062-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[sipsolutions.net,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 12:35:51 -0400
Yury Norov <ynorov@nvidia.com> wrote:

...
> > Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> > be especially useful for le32_get_bits_signed() for example, to have the
> > endian conversion built-in unlike FIELD_GET_SIGNED().  
> 
> Maybe this:
> 
>         x = FIELD_GET_SIGNED(mask, le32_to_cpu(reg))

But if you are going to follow it by:
	  x1 = FIELD_GET_SIGNED(mask1, le32_to_cpu(reg))

you really want to to the byteswap once, best as:
	reg = le32_to_cpu(struct->member);

	David
	
> 
> Thanks,
> Yury
> 


