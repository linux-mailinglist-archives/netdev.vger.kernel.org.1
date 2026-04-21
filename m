Return-Path: <netdev+bounces-280133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q399I8eB52ls9gEAu9opvQ
	(envelope-from <netdev+bounces-280133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:55:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDB43B976
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87301300BEAD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE43D6CA5;
	Tue, 21 Apr 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="EwBxXn8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5335C193
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779715; cv=none; b=pMfphBOT+1WUwv2QA5i2Nl1XM9QQ7+5v/4m7BwGgvXgEgdjiw/8LfFu6w5pgYcRPgAF8vB6assPwI8BCnW5KAMZvS4f0I6DmQX+4TBOx5wn8vADmmu5ouKMRSVbwbF1FlQIhNGRKqxIxS4A0Jhg0IAUjI2au84XJjpi4Ir/32cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779715; c=relaxed/simple;
	bh=+lhCHGdZe5sRkv14NbUtNb1CaGQkWDl1MwUJBssQYzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRtd4X5dKExRncS2im/r1iJAWJ4xbpm8Idc0Z11tX0lx9H+mXlmMNIUOqZM2JazycXoeMjB97uIK05tL5+TQei3WBMjb9uO8Zs5Z1G4mR63VFjzRJaiTP3317hn8FU5+CE9Fr7zcsRaMVKXi6yxM7jNiv0XD1d7kTJkX37woQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=EwBxXn8i; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so10084324eec.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776779712; x=1777384512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kvvKapHsTo/somY7xq84QOUPdxSqeCZ5hcFx8xE2MI=;
        b=EwBxXn8iG4VALcxHUCe0hi23ctgNq9/G1VT4ilVQ5hcXapjMzhUfUIloVkTwOP8uOI
         OjJHxixt7SvgB3kBpMrXO8M7jyj2qv0hBfkJ3eycWdv0eGMb2baUTp3gVPqTBOzd9Mhh
         3ygZkyGdJSbFuoUHizPgT8Zs2ZADInWf8Sxfjqd59ZxjC6jEkB4A9XVbuFCr2UAq7hWw
         sUgJOjk5yT2mXS9zwjZNCuAUe2jfpxKyBkfoB6jJnDz3AbA2SzsS54FjqK7zLlG92p+r
         TkzCJltBdz/hpDj0WS4KEFwPtuEnv+9L4TtL0Ff1Ah935sm2AyUrisg2yqJfTz0jkEul
         l+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779712; x=1777384512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1kvvKapHsTo/somY7xq84QOUPdxSqeCZ5hcFx8xE2MI=;
        b=bXHj43IlRvKNtx5kjtY5WSh51nIGHvQ0z7ZR52WjV9UHvla+Jy16HecTtyKx9yVYaA
         qO8Lq/tX3g/t+mHjGQoZEwE9RTv67OB5Qi16rYDQjIs5iT49/5mtYDY0bMtBXQdCr3xD
         5YA+vM3FRYOhQt/T3CRHJE9zM9BanON00ubOSni0j6KM8eLKHmlLQSL4aDGeDeuJCIxY
         QNKRxU3SyFKE/67+9ZSiXdTyeuQGo5X3JU4Gwsi2m4rKl38pNTlvn2xV5tOWpb4ErawM
         zYk1fwycdNO25tOnkO50AD0hIsry9ZBo/cyn+MtYfDy+76LffLQ0OgTpX7MDY9KsZeQl
         3rlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Cliw9+uZUhxxCwKLY5PUpxvwsQFxs5KNEN9tkcExkRpuulajWvu+jBK9uBRMVdIUsuBKUUss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPWwMYrnfrIPpCNZLrtcwyL1rE598jL5nh8rrM84xaK5vpy1H
	iBQ1scZRDsOIDS2RPdO1zkNztJEgykm6xKctdAQCNX87OwtgAdjlALc+mw4WEe6t9gM=
X-Gm-Gg: AeBDieuFNFF8Me6l/2cVX1mQTQ1yMw/RhpAX9ZxYE0IvWJd7SGO2oF6wIFuClUoIFPI
	8hDlF4Dc4Rx2x1NiDPtZqgj6peF0P0e4OEXhiDJ7ZPOSFRK71aafB0eVXzDYJ+QAgh8HDXbU1aC
	b0hFWZP8MCmEadLOQtBX5ZLwISMHs4sPgRrVpXv7xmdPBNZuv6TIQPJy55Zj5Ky/Af5xZgAfh3R
	vAba8JfZRQQ0JdJZuPQoEIgUytigFRRkktgtxP83ARMxJZBYY4SSkduUzk71h6wwhJ/gvZvKvQp
	RxyWWDNgbApxkUDTau9dq2n5f+JvDKeAXCdgAvY9x3q0Vl1MTapd7RcBbTrTtLiTQkVwAUK0rVK
	qcR61g0R9d76Zey2mr2tBT+L596bzU89acmk7IGODOAyScKxYsXzlq28afmehlMHbgH0qtybnTP
	XcF1Ma3VU1eRq56nRldHS5KKxC9QWMPUnCpt/nTuw0xZcSjA==
X-Received: by 2002:a05:7300:a49a:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2e478e0c684mr10198611eec.23.1776779711654;
        Tue, 21 Apr 2026 06:55:11 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm22753545eec.1.2026.04.21.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:55:11 -0700 (PDT)
Date: Tue, 21 Apr 2026 06:55:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, federico.vaga@vaga.pv.it,
 carlos.bilbao@kernel.org, avadhut.naik@amd.com, alexs@kernel.org,
 si.yanteng@linux.dev, dzm91@hust.edu.cn, 2023002089@link.tyut.edu.cn,
 tsbogend@alpha.franken.de, dsahern@kernel.org, jani.nikula@intel.com,
 mchehab+huawei@kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 ebiggers@kernel.org, johannes.berg@intel.com, geert@linux-m68k.org,
 pablo@netfilter.org, tglx@kernel.org, mashiro.chen@mailbox.org,
 mingo@kernel.org, dqfext@gmail.com, jreuter@yaina.de, sdf@fomichev.me,
 pkshih@realtek.com, enelsonmoore@gmail.com, mkl@pengutronix.de,
 toke@toke.dk, kees@kernel.org, crossd@gmail.com, jlayton@kernel.org,
 wangliang74@huawei.com, aha310510@gmail.com, takamitz@amazon.co.jp,
 kuniyu@google.com, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
Message-ID: <20260421065507.2c5e3ba7@phoenix.local>
In-Reply-To: <20260421021824.1293976-1-kuba@kernel.org>
References: <20260421021824.1293976-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,vaga.pv.it,amd.com,linux.dev,hust.edu.cn,link.tyut.edu.cn,alpha.franken.de,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,netfilter.org,mailbox.org,gmail.com,yaina.de,fomichev.me,realtek.com,pengutronix.de,toke.dk,huawei.com,amazon.co.jp];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,phoenix.local:mid]
X-Rspamd-Queue-Id: 8EFDB43B976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 19:18:23 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Remove the amateur radio (AX.25, NET/ROM, ROSE) protocol implementation
> and all associated hamradio device drivers from the kernel tree.
> This set of protocols has long been a huge bug/syzbot magnet,
> and since nobody stepped up to help us deal with the influx
> of the AI-generated bug reports we need to move it out of tree
> to protect our sanity.
> 
> The code is moved to an out-of-tree repo:
> https://github.com/linux-netdev/mod-orphan
> if it's cleaned up and reworked there we can accept it back.


It would be good if these protocols could be done in userspace
or with BPF?

