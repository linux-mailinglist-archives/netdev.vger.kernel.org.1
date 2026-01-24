Return-Path: <netdev+bounces-253004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CZyDIjEpdGmn2gAAu9opvQ
	(envelope-from <netdev+bounces-253004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:06:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4F7C2CD
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C9E3011C76
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD56202F7C;
	Sat, 24 Jan 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7147oqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279184039
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220397; cv=pass; b=iajVmMBM3VUDyozsimEGfyH8EhcrS4dWSnJQC8oaOqJh6M3Gye0t7DoGxLnk8vaOCf1zNk1PVOgEFSdz4mnnpiT/EP3Y4kRqn1NUjZ9Udk/4Z17RjqjLOETkZt7PAi7X+M4HzB6k0LKQ1WOBR0oz7aojoEgCw0I4MfRHk7x93sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220397; c=relaxed/simple;
	bh=I5skE+ABsT6tS/BXtKehLM5YAm90QurIOytf0NErr0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/jXjD7vJ3qEFOvvz224OBGEl12T++XGsUvmcuVigpMGOHcqjZgGdO31Rar/Et3X48iyKM1H0exsGG5Pml/BZbhSUxz8N2MULWmH6+2Z5HzGOeYoTvKzXVgC1A/j3+Q0jQKavTijdsl3N20DXc88wFD8/NX3pm7I2J72+KUYKz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7147oqc; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65e94e128beso1807649eaf.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769220395; cv=none;
        d=google.com; s=arc-20240605;
        b=NzgOe+IshkLlv7D7nF+ymzyDRxpLY+Be3H5b7NJUGFAKQdji5IAEf5sJGLfYin3+Yv
         eEpPMTUTcevjobfZmfBaxjG6WPVU4YQIlrH7UGDI8reJp2xpkUEQecxPuYcnRjm2gSpK
         PK+lxKyDXVsC0RiyfVfbWjNkglGsh/Ybg9UWQqKSW1SF0JAyiJNbogcKG5+O5qdtAD31
         P/aXsec2+St6FmPAZc9gVpIIJr468QbEE9GwxFqxTrYzWSx5vmyWd2w5PzlNPz487RFm
         xzc++KX7tSaTdwXC10bFci64f2JNuS7Th7waTWyZoYyxQ7R6s9j88FTDy4k2yUoS74oa
         Au6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I5skE+ABsT6tS/BXtKehLM5YAm90QurIOytf0NErr0U=;
        fh=6DShqPjHOx8VkyDty2spVz1T7c2d+8cjzt4hrSav2HA=;
        b=KPhCBtO1yg+LNkouw9k9aa/Kk654w6Q9YxQYAJMRmB3z2+SJgiWp6AOc1tI/IZ+OLc
         pF4MMR89Omk4VT+5vabm+PWqVCkd+u/2hSIQF4vPAokRVng8R4Mpkn3BLZDkPre3IU8o
         X1lkX5BV3a3YUQvP/FTz2Md7xXsi6runf1QfbIIoP8BH7gW2klOG4aq9ygY3dVV9+Z/6
         8BeA3o+QK9Z57fBfaI9gUEezZoCfPy3tBZ6MMcqDOJggfsyQoUsHmoMHnFx6SC3AIWus
         mb5xKQlWOjJmzq+mnXd8ZlMmK3PDsj96V/+rI/JBQSUH7APDDcnXm1XqZ2J8kXA/omos
         qnIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769220395; x=1769825195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5skE+ABsT6tS/BXtKehLM5YAm90QurIOytf0NErr0U=;
        b=I7147oqcjAZP6xLgStmzdItVOLCZKPUT0nLaFHZxfWheppHRf92zsCt64MRUAAktbU
         /VZOSt/ZScjfolm2h5bjPt6yopbcOcFgh5ZNmfjGcQcXgvoJqocx6oYN0IZKK/A3o7yN
         UGQRFCVf1VCL8G0tyIxJOQu3Y9kD2p0LNPvIfvMvUjfbOMkH8eXLgk4RBfBWi4A4zsZK
         CRvD6QQNqE/lSg4mTVfOyDoz5kCo9mJUvwfUchQCNDIFaZLG5Zl/yblnMMC40m8c93ot
         8WjEKJl/Lt3Mpb0nhe8B10p2lCeu1uX9X7Skh6COiPNkMLEaY7RNioeMMCyoDs7ycc1L
         /hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769220395; x=1769825195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5skE+ABsT6tS/BXtKehLM5YAm90QurIOytf0NErr0U=;
        b=vbgpY8dU6Nsy3X3wQXoCiQDc3oTJ85UPnKdkCeSbacyFyxuNu9i5cvO3ktCjJvF1i+
         NcJ7TET12YuB7gIl/iw42sRNVKyMllQgVtqOHEMY6GuKfE9jeBSh+aTT3zqcT05bMrQt
         RF5FtfSUrqrq/X1hkSur/p4x5e2Ib8bcQil1OVlNuCvNRxU/kkuYn2wEVxPahtMRFen+
         L4GQhWzsLP3KVr171085ec8cfgkWR8vDj4quPROYuBzgGbBBNa8N9eZBHB/OzaI03ORJ
         BShxj0RQfNkubC5DVGyoS+DTkx1+zS69p8Shvky8ABC4ifk6t1JT4mRtoY1cHbaaoQ7l
         9awA==
X-Forwarded-Encrypted: i=1; AJvYcCWKE2KEod+Po2EA8vhZDwXxrgITo3vQ3omgoPUSmy1YV4cQgC3Bpfs5F7nuhlW/lVGblGvsvZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW84J5Q8I6F8TzdiBED00MP9ErdUQHvjp9g5wqEx3YyuV3G8Rw
	EUqeNxd4cMpH4kacvTjPSQV/VC+O/UctMyCqbL44H2BPdXhtgbza26bwfv0pmTjko4QUGmYnwi6
	D+ef3yPD1kVRyFCOqdwFxJE8SoQgV+aM=
X-Gm-Gg: AZuq6aJSgulPZ8RM4bMJiQpHKVmHcdyI493ol2vSjyFDGrkMdeJzzrFAbj7HUe80ys1
	8wpQ5p2WDETjLcPKg9zZP432B1qfqswMjm1cTeOUogtMm3aQi2w9yhKe9H4bKeLuECGwQsV1KVS
	taO1u7mpgSV0xdXN3V5J2WQaqSuutB/hGDFFg0y8rR35tvYIvy5w2nb/LjQUEpi1UoCHUIT1/Ze
	sa2xzykNmo5P/QglFoqDa9ZcZGz2bvKW7zDnFRns7Lsitk4OpMEe+Z3qqw4oEjH6CzSq443IzUq
	gEOxsDaRRXM4BPCOgBLkQaH65NTdl1Rf4ccG4lr551rQfj5zmXeoyIiQbB7D+W9nxBa36cM=
X-Received: by 2002:a05:6820:480d:b0:661:c66:5fe9 with SMTP id
 006d021491bc7-662c1c10ec3mr4245883eaf.31.1769220394849; Fri, 23 Jan 2026
 18:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122194233.2777550-1-mmyangfl@gmail.com> <20260122194233.2777550-3-mmyangfl@gmail.com>
 <20260123234759.bj2gik3oobluyjs4@skbuf>
In-Reply-To: <20260123234759.bj2gik3oobluyjs4@skbuf>
From: Yangfl <mmyangfl@gmail.com>
Date: Sat, 24 Jan 2026 10:05:58 +0800
X-Gm-Features: AZwV_Qg4Mvhc3OyrNMkAB2b5QVsxEkUCmaOcsPTHl4vzLQlwHgcqLPl8IawjW2k
Message-ID: <CAAXyoMOfMPzSAqePyiFLRx-Cth3LDq2f20TY+GpXOaVW-p-vRg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: yt921x: Add DCB/priority support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253004-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: CBA4F7C2CD
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 7:48=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Are you sure the "port" selector represents the Ethernet port default
> priority? It seems odd for it to have any other trust order in hardware
> than last. What would be the use case for that? Sure it's not an L4 port,
> which could be mapped over IEEE_8021QAZ_APP_SEL_ANY?
>

No (with the "port" selector) but I'm wondering, do we have
corresponding port prio methods
port_add_stream_prio()/port_add_dgram_prio() or something like?

