Return-Path: <netdev+bounces-293338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DwfFbfDGmpw8QgAu9opvQ
	(envelope-from <netdev+bounces-293338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:02:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B893E60C50E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20DA302292E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646723A8759;
	Sat, 30 May 2026 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amGc4pmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A539E175
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138867; cv=pass; b=U0JhXErBEFhzwjg/rqzNXsbPWukgmXHX8lA1n7DKp4Cp4F0PXquXwbjoN78fxvB3GRFBChorSQjxLWE17LQtq/Ejgrl5wZ+r6QiIZkzQwGVCGlFdoCPolc3S62XmXXyZg+3dJ2Wja+ODJ8ivkfhXo90M2vmolVZtmNEZm7G0Qic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138867; c=relaxed/simple;
	bh=ybVBKI8DM2lMXpchgAZMZBpIjHNkIiTRMS6bngefXNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkuzd68rhfbwCaQafWe9tn4GhB3x/yebB5wx4l58oO8AsFg44tyKxeDFIeY1vvHau0zRJuvAJlPOGf/1SJIRCiOL0eimhv+e1hiN68/Pp5DReqOfMFv3mqY1fWHBYKilqBdHP127yzAZ1dRYqgwgW60SOcg3RLiJr9nP7qTxQlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amGc4pmG; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd0209f25c1so2202511566b.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780138864; cv=none;
        d=google.com; s=arc-20240605;
        b=OV5BWKXdcbbZyT+jFP4DDbchDaQPiCESlp9DurmsIPNmSsR6Otnx8gGXI+G2v91j2P
         1T5AK48bHhxAnvscDB9Gwn+MkQMQ5yM2qo8xkltLro4wAEXkUqsBDSYhSARrExAoeeju
         6V7RWTAwaUYPFNKQIbr2lz9pBYiYui6h7V6DM1ghlovoOb3SePpYa2AcqY5dEzIKTD1y
         gEYDWHDgWBxO0rrK7OglvS+3Lk+wUYby26eMSF+A5bjNYcU0UfE/uq2Re7Zr4saALl9Z
         Xv68+BsAGi2uB0C4UPMHj3uzRr68hGhBu7TH/uYy+LivZndVyMVQxVBTWJC6YAOYK1Uz
         hS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ybVBKI8DM2lMXpchgAZMZBpIjHNkIiTRMS6bngefXNc=;
        fh=P79YPH8ys4RXjt2JINLKqz2jrOvetxrE2Yckm5rFbeU=;
        b=I/r59lyIG4459qgm8yO2/wCRzWFIJqTeLO+9QJ/J7jJzeKyxLRSSnk/OveUIBQ7u5H
         dHQW+bWdzwUr9xpZ/c24j0jUyadxYMCuyhkVyL55Ie908UPsgruiXq02Rhx5j/BU/Pjl
         iARJ9QbEM025AzEaFhwrWrh4KUnjLUgVK2Yg5jZ4UTb5VDmjN7YYUXedm95PAvCJ6drt
         4iy9m1xbgsk/XUfmwc/Nrtmmcsy4xGbRMoHhT4Hz7IWJVuUrtFPfPaTl7sZCvGGTv5Po
         n6Zn+BpXHU2BSp6GovdLIe054QQR+DU/PupgvxQrRn1TqVSQuai93ZSZZBGA4Xu8UJni
         LYrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138864; x=1780743664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ybVBKI8DM2lMXpchgAZMZBpIjHNkIiTRMS6bngefXNc=;
        b=amGc4pmGwSCOrvuORPXE+fr+FMy2LNPhmjsnxa6/HVr9qMcJDp2PKVGJd3zA+QFY6e
         TQJiuV7xPjwY9eivN6EJm5TTxzO6yazLGA3oTO/b79N1nFmyX6ydmYNuBuv1cx7IjkyT
         7GYgk80yQbh+x98BB54o3ot6zpREW6B48Pfv2m0C/b2T4eDFcOjp1ZwzyWWGGbshlDmD
         4+w72xztVlzKG8vrvjiEbqnf3IvSaAZmfKvLCa4Wc5LpgEf4+jNvdpnSy2jwyNZ6hYno
         vXpB+CLI5syvL+2y29y8HngT/VqyDYPp9jiQQYEgvG/pVsUeZ9UOFcTyFvPdeGslaYPB
         nSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138864; x=1780743664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybVBKI8DM2lMXpchgAZMZBpIjHNkIiTRMS6bngefXNc=;
        b=ppRGHdhKJXG+XhQUSlJwGme9t9m/NiGFG1TZhEUZ/9XRKpUml4iMYYK1KsAZuqK5td
         V313au7NU8gwfiyx8I4NMVe+wMsFfKi6L2wIgCOgLfznohr4jX5P0S0uOp0ZBp5l6l4n
         blL5BqhtloiW4xHywyj6v7V6TpFyJ0YGJ5RouxeoaMupJYhwQnkVVxfp/f7U04hRSvHI
         2AWGl+ytBGsC2FA4cmSWf6U1/5VHX9oYdIxStDKdFLVxlq66RxR7lwGD/w9At9SkMMLp
         RHt/PXxXz59E02LzEb9+v3R6RaDuOe48WeirARbUV3eECGAyzpnKYaDA1r5K0K9RovxL
         kzFw==
X-Forwarded-Encrypted: i=1; AFNElJ/C+f9ZrkTM+tkRTXni8xQ/562i4+21Cu0BFQyc60HWKeReQW6+DIbhnDRRWtB2V008ID1DGss=@vger.kernel.org
X-Gm-Message-State: AOJu0YysragC5byYpMW7WoP+uzufQAtnrs6beIGAjE+145R146/6XORS
	H0S7Y35RwynxM7AQ7jfZnPOGWJYjS7dMSivlMvwQkHsXmbFM0rWTlWBiylp1v5GNiBLh6jiAygc
	tkg3T8G3YLgWcObd41RpJxmOmDmBICo4=
X-Gm-Gg: Acq92OEugrf+KJaR6hudcnbolocCRPGjN/aOQ+pX0Elx6PqXJKrF003w1vljLTtBnv8
	66QB5yt/BxbnOBIMnPDirNFGosXkoqyPcpo1AxgThDNLqMS1AjdjbBIsgY7MtmC46ibuiWLHKSJ
	sf0cbDK3gx272koffGZ/xT6P3Rewh5LAJI97lXkBDLelVV2/bS8dwcW02ZDFB4TKdRjKIbTk13/
	eeh36yhMcBFLkhRKSULtODOr6MBI5rXkvPD1G3DnV9R6ItQzzMmHj3rbIGn53TAfVDVsUfGPGRv
	t9uqp9TQ70799m9CqmyluUOI4+TiSwQSJPFAYNfPMgKWXAXWgA==
X-Received: by 2002:a17:907:3f87:b0:bea:4c62:c2f7 with SMTP id
 a640c23a62f3a-beaafcef58fmr162382266b.8.1780138864064; Sat, 30 May 2026
 04:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com> <0c20ceb5-1cf7-4f83-9623-b5f5018f44af@yahoo.com>
In-Reply-To: <0c20ceb5-1cf7-4f83-9623-b5f5018f44af@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 08:00:51 -0300
X-Gm-Features: AVHnY4L1xk1GZD33eHumsthGmHMR8soefFEOlixsWzRtNz7srFWcfNuiKEhGWxE
Message-ID: <CAJq09z7JJVq=0g_-yau4Nh20G8gE3TAcy4ipwjmQnfwrUm512A@mail.gmail.com>
Subject: Re: [net-next PATCH v9 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293338-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: B893E60C50E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Sashiko found no issues in the v9 code: https://sashiko.dev/#/patchset/20260529-realtek_forward-v9-0-e7c61872d923%40gmail.com

Finally :-) But there is another instance using Opus/Claude at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529-realtek_forward-v9-0-e7c61872d923%40gmail.com

I fixed those issues (and a small mask bug I found) and sent v10.
Let's hope neither Sashiko instance brings up new issues. Sashiko is
quite good at testing the recovery path. However, in most cases, when
the error is from reading/writing a register, whether the error
handling will even work is mostly a matter of luck.

Regards,

Luiz

