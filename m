Return-Path: <netdev+bounces-147667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EAA9DAFCE
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F48164DBA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE811990CD;
	Wed, 27 Nov 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKZ0ZkkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D78192D76
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749701; cv=none; b=a7vd7CPpxUfFWlyOJEF/RIv0jD50tgMeATb0Af1QmlQYNuBCmGMqrpc+mblywVeq4k1QHMFLHM+FUK5s/lTyBuunbibd0o49AvWQYDUdBhgme6AIbcj+YskGSD3EC3/xApDPX8rearhWhI1VDAfd+N5am8qvivsIhMR53TfrqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749701; c=relaxed/simple;
	bh=Vi/SX3JTjpjmfswC3/FbkGdskaDiBdboG6X7+DY1cbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ceQ9XGAxh6nJpg9YKyat5xq17/u2REprv5qEChyFEJb6Dgld/yrFaL0E391cWAJ23Ew1h0ekBskInRZIKoe6pYnSYGaKjeeWuefbASFxVbo3Ox2AVSG00wvRyuDcA5D5bvvgrovzd4AfuLydS7HpeRdBBBpi6rufDa7ed/PZScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKZ0ZkkV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725126e7da0so249592b3a.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732749699; x=1733354499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u20pll8VeOEmkG4npMdzaZzjnGDg+tlkbbf8/K18yaA=;
        b=GKZ0ZkkVxAoj2CUa7myJbwDl33CmYl+D4MJ7bYGNXQtaih9NvSwdm4aCzrNoSksyuN
         YBqvCBKq8CTrOOVIBq2glISCIiE7lAhGTx9nLZ+oE0aBLRH38pbsf1kPNcVVahgas7Ul
         jXLzJyxjjx30ni+5gRAUmkicn6H3Wmlwu10W7lu63Kt+pN4sIYRRs/KPIaGzTVS5xKRA
         5Wvbfi332DkSynfrTXajbxxlQFKUvV6f9gFpKamYGBp7erS94vDZqiiQPyEeS9mLhuNK
         qqy55QiCCOKpxKFVizHScF5dcbQCpyaVIhZuNlnHmUqKOeduXcurdQxEEB7rhOmRYfaB
         GP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749699; x=1733354499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u20pll8VeOEmkG4npMdzaZzjnGDg+tlkbbf8/K18yaA=;
        b=VUF/PvTfOPBifhPZoqso56dXBns163UTY19QncgLj4/7t+fV8KpUjXLYUTsm4/KuCd
         zqxwSg5xmG+3/IpgMhud295CutarODthsI1Fj8rNhHoRl+xPLcDjIpm2q0uFo8Yd8pIC
         k8SLQY1JP5s9RVLQx1ZPv3GRadq3e9L/DWawiZBV5pvx6AZ9APGnRA9c4fRJd3l9Pgch
         q1e6FSpLjjHKMmiTiVrC1bAeICoz/NdSvO5KQCf5zJ+HAOZhd4zF7De9IWVp/eiZZ6E8
         bAdywedqJcHwAxH/4VI6geuExfLUWA1mTSui9olfEHQNvMH9J9+5D+PPNl9Qyz3/+WPk
         Jv3A==
X-Forwarded-Encrypted: i=1; AJvYcCVQtualJgO/kYINGHxumb7ONEIk2t3smQzhfpZU889Hb4kx3S973VnHbYM5ZKmFVJNyKm111IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywssv/bRDk1GY5fXyKdBnndbDoOaursDfQYFHXasLABjse20Mbb
	k4R23ewLGKWxa4FZPQeCfvLHqvD/qmMQZwdPnIIMwBYzC7ji3QeExPNzoPGJ+EYpLEGTsa16xA=
	=
X-Google-Smtp-Source: AGHT+IGdqHAFyXe8UNth15Wha1d0C9WQ0r4xWcwWi3yujdz0WVs368myT4JyWIp7ZAc2PFuEv/H+Lq7cYA==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:724:f1f4:cc72])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b81:b0:724:fac6:35f2
 with SMTP id d2e1a72fcca58-725300107f4mr5451899b3a.9.1732749698863; Wed, 27
 Nov 2024 15:21:38 -0800 (PST)
Date: Wed, 27 Nov 2024 23:21:33 +0000
In-Reply-To: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127232133.3928793-1-jrife@google.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
From: Jordan Rife <jrife@google.com>
To: jrife@google.com
Cc: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

> I think the challenge with WGALLOWEDIP_A_FLAGS in particular is that
> because it didn't exist since the beginning like WGPEER_A_FLAGS, there
> are kernels out there that have no knowledge of it and wouldn't have
> this check in place. While I think it's a good idea to replicate this
> check for WGALLOWEDIP_A_FLAGS as well for future compatibility, we
> still need some way for clients to probe whether or not this feature
> is supported in case they're running on an older kernel. If we want to
> keep the version number as-is, I see a few alternatives:

Forget about all of this actually. I was under the mistaken impression
that an unrecognized attribute would be silently ignored by an older
kernel, but it seems that validation is strict.

	if (attrs[WGPEER_A_ALLOWEDIPS]) {
		struct nlattr *attr, *allowedip[WGALLOWEDIP_A_MAX + 1];
		int rem;

		nla_for_each_nested(attr, attrs[WGPEER_A_ALLOWEDIPS], rem) {
			ret = nla_parse_nested(allowedip, WGALLOWEDIP_A_MAX,
					       attr, allowedip_policy, NULL);
			if (ret < 0)
				goto out;
			ret = set_allowedip(peer, allowedip);
			if (ret < 0)
				goto out;
		}
	}

nla_parse_nested() uses NL_VALIDATE_STRICT which sets
NL_VALIDATE_MAXTYPE, causing __nla_validate_parse() in this case to
check that no attribute types are greater than WGALLOWEDIP_A_MAX.

The WG_CMD_SET_DEVICE operation simply returns EINVAL if you try to use
WGALLOWEDIP_A_FLAGS on a kernel that doesn't support it. I tested this
using a patched version of wg that sets the WGALLOWEDIP_F_REMOVE_ME
attribute when using an argument I added called "allowed-ips-patch".

Kernel With WGALLOWEDIP_A_FLAGS
==================================
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg set wg0 peer xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4= allowed-ips-patch 192.168.0.3/32
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg
interface: wg0

peer: xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4=
  allowed ips: 192.168.0.3/32
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg set wg0 peer xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4= allowed-ips-patch -192.168.0.3/32
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg
interface: wg0

peer: xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4=
  allowed ips: (none)
jordan@t14:~/code/wireguard-tools/src$ 

Kernel Without WGALLOWEDIP_A_FLAGS
==================================
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg set wg0 peer xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4= allowed-ips-patch 192.168.0.3/32
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg
interface: wg0

peer: xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4=
  allowed ips: 192.168.0.3/32
jordan@t14:~/code/wireguard-tools/src$ sudo ./wg set wg0 peer xK7O/YnTb8W/fgPA4dwAshEV06rMPMqqmy3zZN0NPS4= allowed-ips-patch -192.168.0.3/32
Unable to modify interface: Invalid argument
jordan@t14:~/code/wireguard-tools/src$ 

The second command fails with "Invalid argument" (EINVAL) on the
unpatched kernel. This simplifies things, as there's no need for
clients to explicitly probe to see if this attribute is supported. I
will do the following:

1. Revert WG_GENL_VERSION back to 1.
2. Add a check for new flags similar to the one you mentioned for
   WGPEER_A_FLAGS.

        if (attrs[WGPEER_A_FLAGS])
                flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
        ret = -EOPNOTSUPP;
        if (flags & ~__WGPEER_F_ALL)
                goto out;

This should be sufficient. We might want to consider how best to bubble
this error up to users. In the case of wg, "Invalid argument" may not be
very helpful in determining where you went wrong. We could always detect
when EINVAL is returned in response to an operation that sets
WGALLOWEDIP_A_FLAGS and print something more helpful like "Operation not
supported on this kernel". However, these are details that can be worked
out.

Sorry for the confusion!

-Jordan

