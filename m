Return-Path: <netdev+bounces-295316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHCdNkejIWq8KQEAu9opvQ
	(envelope-from <netdev+bounces-295316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F4641B5A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Gr4A+RLO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295316-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A572D3073A1E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387C39A4B9;
	Thu,  4 Jun 2026 15:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6A239E7F
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:59:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588798; cv=none; b=WFu802t9t2kp/ktTok6zz3wI+FHyVS6Vrv0I45Y7WfWemTOQhbWbSAD8+ZCPJ56CLbOvAQbqIFtCdNzaQmNO737NSjOVF7+78EXAP8YhO7C/YUcH1fGTfDb6nMRB8rCN7tQeNBMEiye51mwRqFeqZMoCkC2L/syASvSYZMM3TCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588798; c=relaxed/simple;
	bh=PkBQf6/m2Tb/nKtrhOagLm6wr8LXc5iMTcJU5kSDYPo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QAiPJpCaT01JNCjv5cfvjL+zhygzhvI0CYsdEgsHGp8xDLgTifw0R1tFSPE17WkBGOvroo28aMUPxCarK6Ee0W+e4HlfEYXhuZfBGeh7xmMFX57J5McT/Elz2NMVkD8B6d2HaXat7VzCO3ds37pVzav3jsJzAtCffOEwUtgWw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr4A+RLO; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so10419375e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780588796; x=1781193596; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAYg5oWM0VhHaA6FaWfIENucykRBhNBMHKz1DuPcFF8=;
        b=Gr4A+RLOMjXT3hXoP2cMbceDbiLbiUdYx3EXvgEGC/MtPTxdzPxVBc2PUuQgwzOa6R
         aj6qsLfhl9wKTcju/8QTEzb2UfGxhZeZjE0YmGQB2iC9zuC3s1n//CIdEVveAHTyXY9E
         7fiPBOay+oP/bfUFMibxCt/umsaaggEJkU3/6Ghe2tWoZNDRoqok7ZbKXaTae6t1X+xl
         ona+E9ipf/ahVZRv4E5zqEL1Yem+UeBlFvZvc4Kr4SKQqru2/HLh6nx+V4HOS663cGL1
         042nwO185dz2jNFM/WCzBT4o+KlO2ucilBQLYIATdVP95lkMtz0pxrgpm532a/W3u2px
         OeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588796; x=1781193596;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAYg5oWM0VhHaA6FaWfIENucykRBhNBMHKz1DuPcFF8=;
        b=rF5dV06/cHbHkN7LPetsVXglaLDJljG3B5NHNrM4uifLCTaLAOUnFrbvqRjiZmu780
         93aR5h5ReWQTCsy4M3sSf2TGUsdvaziqD9KuCdW7G5i3mEGf/EVtPBHNCGqQJ30xn+Jq
         v3D+NQZ/isEFornD6LCzTa/ZL5dntl8iZJw59c+NJUKgPse1d2VzubqvEw1PZc6DhYij
         /seFBorTcGthIDRB+jLt3QEC7mntCx652BA2dJEVQVPeBWzobBUcbDeLChRuu+/VZCsN
         WiSszGX3kzNECrilsofCp6qj4QvKzwZCSGtNjcHG2vR+ZymYYNvTdFcWmprhVhxzDnfs
         321A==
X-Forwarded-Encrypted: i=1; AFNElJ/p1q0jyNmomFH7AsAxo2AMHHukA6p2GExD9HO6kj7oKE2tampa8XCjfFdRxfaVIQPt80wxjEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj92sKaul8UaZdL7PAxBBemP1QFyeCVSTHfNxXKOZzlq+vUw66
	RG6gfFGsIbbJn8U7zMUUpuPO3WtsJq+io4zsxqK7/aEIf8mvEvYfmAio
X-Gm-Gg: Acq92OFfiATXWzdUjduVo4If/xZpc/5WSV30g+h0qRAJ2wRvpN2r4I6DHH1satEB2me
	cvrupSYgEygrPamSEohr18Rc9KkBheRFiRm3nhoXRa03MM506YBDhtnr0KtCCfc7xXTwUiidA32
	DU0EByUtzoFeisxrRFY/B0vEjG+c8xwWtTL6hUHFzbWI9gy9uPiEBTIpyiuMpqaBKbXjhUZFg06
	1h9CA69FRZMIqQEQS2MO5X6wGEcVSkXHwKZHE7RCB/2FRXJQ8Z6DlH4PZVenKOkWfq7rBRDsPGk
	xfQHPfLBixtjOUFMb7+z3ZF9Fu/H20sI6+83Y66E4EnjPtyvM3iPAPekn9XAYTyMTYt/MEx6Ihu
	b/1IID0Aq980+0ATlv/THs+J/vNmoXwIAUEcm8gZfo1IWZj7kkGq2n7uOTPi9a2Ebownl0KtrtG
	NI3qmHIaBwM6yCXvlRUy1svTlDB/Tlxfd/GgpzbcR+Rwttem6LO/QqGw==
X-Received: by 2002:a05:600c:8b5b:b0:490:4ee0:82f9 with SMTP id 5b1f17b1804b1-490b5e73dbamr139887345e9.7.1780588795497;
        Thu, 04 Jun 2026 08:59:55 -0700 (PDT)
Received: from imac ([2a0d:3344:372:fd08:b141:2042:3ad9:7342])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm93697605e9.1.2026.06.04.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:59:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
In-Reply-To: <20260603210810.2636193-1-kuba@kernel.org>
Date: Thu, 04 Jun 2026 11:41:03 +0100
Message-ID: <m2wlwed1vk.fsf@gmail.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295316-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 463F4641B5A

Jakub Kicinski <kuba@kernel.org> writes:

> Turns out Python YAML defaults to a pure Python loader for YAML
> files which is a lot slower than the C loader (using libyaml).
> Try to use the C one whenever possible.
>
> The avg time to run:
>   $ tools/net/ynl/pyynl/cli.py --family tc --no-schema
> drops from 300+ ms to 115 ms with this change (40 samples).
>
> We could drop the load time further to 85 ms if we "compiled"
> the specs to JSON. Slightly tricky parts are that we don't
> currently install the specs at all on make install, so it's
> unclear where to put the conversion. Also JSON has questionable
> support for comments and we need an SPDX line.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

