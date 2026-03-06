Return-Path: <netdev+bounces-264821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAJALwHlqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:30:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62602222B3E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF4DA30420B2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1B39FCB8;
	Fri,  6 Mar 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjmg1dbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F83ACA66
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807366; cv=none; b=hv6uJnRwQGjevgDHxmYgPzthl9hnBDuP+dnGDzPXHnzc4CELY90Xg8Zm52NOpjFS6y/SeoPLD1ALmzw1a3AiCBLvo0lBaLfCVpQELQ+ajtZPZAUuhnp/d6YLfo9j3y1iw961ws+4Ft31Il60mwwOLYWJ7qnxwL2WcwE/lNWhZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807366; c=relaxed/simple;
	bh=qpc/PNFyLGSy0wVjdecxNagU/70l4dij8x1DZ5JiMVc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=kHZq6Ox2M2yBREoBFxk1WpNdo0kAWvPeISunHDrfGGBmryJRkx5TDS6Um6opaSU8k9eEh1d0UstrpZ98Px08YlEclAKCKrPW/IDmgTJWlu2GxWYNk7/d9XIETWLruKXI6pBgSd40puKYMKlrZbV7LKyHJ2WBo4iXOL+LRpc0Rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjmg1dbs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b6d9c981so4047832f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807364; x=1773412164; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhWtiMjf5+O1tAMyGOx4KwdJWT7a8YU9k5/s63tBa0Q=;
        b=Pjmg1dbsoqkINuGc8wQEEKBtuTmjqW79dOGarOFxJyorBZmArC1KzqhyKB1b2TwF5S
         LylfVSh2dhc/NmxAu+qsD93G6JeTbycDCF3wVJEYCB2edhqFujk9BgxN9BPGIyGC2lF6
         14Ewtrv/QRA2g+knYJ/TXIHek1HdSVQqCWuJR2m1FYC/OiTXxheuqYVnLJXq9Eeqien+
         Nj1GnbV8je+sLKUvEhAkwtWgmFwWPCzVpdQvmmQfVSVFuew8uJDN9Yty5GBIjFWYus/a
         RSd9mucuHJRASj+5yW1IEotpQblc3wxAHGst6/mXUkeGwFNDryvYVzwOY8IOtfWl6HvR
         f7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807364; x=1773412164;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhWtiMjf5+O1tAMyGOx4KwdJWT7a8YU9k5/s63tBa0Q=;
        b=HEZkbJlqk6zP7OgNKU2+KK9Wilhj1AsUZWMWcDC7WnC7E3fXDiAr8B/u1bkPpuXBG9
         Uop6TX/qPtV9RSYTVUA067FvfCBkKfxDx3YXNM2yaDV6zRy6ex7SYhltbpVsFv+6EohY
         eXO7GadC7SsSsRqfG/gsCKVZsoEkxFPHC8VwMlLfbsApy5Y+/82Cv1CHKet4AkuEy0oI
         adCdEfIy7WRuxk/rebGbg3uVi8YJsXU7duE2zIsUcx+iQho6O+gNc/AKjxI4bpwIzsMF
         b5/jE/pv7ahIQzUDpbTthTbVQFUV2EStFRPFgA7bgokTFmHu99mYebmWWnmVh4VRVZBy
         1ynQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDd6Zh3AIYwIKPdp5+hBW56H0+kd9ZwOAQ9AEMb17zmQJfAKngrBOzf7rgJ6S6/PSdWOX6RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLE4Vu+g4m3Ib4xDBGhDNzr6AM3uf66+fkGVtOVKPRhkK3DlA
	ykyBuwHVURskBW0zVmFHesJtW74ho9ljNBre4EhXjmIxB73l+YiSBSL7
X-Gm-Gg: ATEYQzy9lV19I409uiNtiABTjNw2gpGqPPNQo8jPHjvIO2Qsp1OgpLlBkNBpUUf6wRp
	X4DKT++PJdDRc2FdV08OmwnSKwXl1FDy1M5hVOmhMNKzN9QR91nUEy+XOGGxu1b/7GmtZSLfSAq
	9ab95LGDJNXDT3aJ1vRFnYVVTn0P7oHUtlPlZa5iuDJKrd5wGn0Bb0a/TxJSC28Oi1VBrvNBCkG
	gsexZSyKndoG7WUkfLByWMrnw+R4mmBrKNWvCt0/swLT8eR1Aj9CxUwiwdgOtJi31+veDF9XIHp
	UuQy69JkfuQa0A9vuBQF1O65PwWRsDLx+yq3HDIRUa3ULBqhyKC2pMjyoVh7Br0uMfzTl9ZCc0i
	c8I1AYce3Whd00iE3GyEI7CcuseLYlVy1FEJD+x9hkHM8zagfAYMhPHw4uNB5GQYK76W16BmJZA
	qsmdLf2pDW5rAwV6daKwxyg6yX8Q==
X-Received: by 2002:a05:6000:3113:b0:439:ce30:5b84 with SMTP id ffacd0b85a97d-439da327d13mr4238890f8f.2.1772807363559;
        Fri, 06 Mar 2026 06:29:23 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dadb29fdsm4421539f8f.16.2026.03.06.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:29:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 02/10] tools: ynl: convert netdev sample to
 selftest
In-Reply-To: <20260306020901.524105-3-kuba@kernel.org>
Date: Fri, 06 Mar 2026 13:45:41 +0000
Message-ID: <m25x79hy0q.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 62602222B3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264821-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> Convert netdev.c to produce KTAP output with 3 tests:
> - dev_dump: dump all netdev devices, skip if empty
> - dev_get: query first device from dump by ifindex
> - ntf_check: subscribe to "mgmt", create a veth via rt-link,
>   verify netdev notification is received, then delete the veth
>
> Remove stdin/scanf-based UI. Add rt-link dependency for the veth
> notification test.
>
>   TAP version 13
>   1..3
>   # Starting 3 tests from 1 test cases.
>   #  RUN           netdev.dump ...
>   #       lo[1]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
>   #     sit0[2]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
>   #            OK  netdev.dump
>   ok 1 netdev.dump
>   #  RUN           netdev.get ...
>   #       lo[1]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
>   #            OK  netdev.get
>   ok 2 netdev.get
>   #  RUN           netdev.ntf_check ...
>   #    veth0[7]	xdp-features (0): xdp-rx-metadata-features (7): timesta...
>   #            OK  netdev.ntf_check
>   ok 3 netdev.ntf_check
>   # PASSED: 3 / 3 tests passed.
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

