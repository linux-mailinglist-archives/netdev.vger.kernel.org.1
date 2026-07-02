Return-Path: <netdev+bounces-303926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8CxSNefWRWrMFwsAu9opvQ
	(envelope-from <netdev+bounces-303926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF446F32B3
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:11:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=d1lkL5qb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303926-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303926-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753073007512
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BB30DD00;
	Thu,  2 Jul 2026 03:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C8431E53
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 03:11:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961893; cv=pass; b=MnzSlPkjDBnnGilrZvUrv/XKYp7Z4Tmstcb4cUxstUFWxu3T+V426L6WazO9F6Z6gbkoV/AROpMAFjKzWa1vAskBWyGt65ayUafO+ZsH6kXsSlzB6Rh6JlJsBHQKiEk9VQvvqjC71pebnr9OmT7oJZY40DFYtjRf3IWGLNc5TU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961893; c=relaxed/simple;
	bh=VnNytJv6VnTEIdEjmt+c5DJy9TzEzsvYHbh936H/bP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYhjQ27VcdRsmU5CIMXnO2qDvH3WKLsF4FpbtZK/8ZdcOSCy8/gVj6Yjpf0mrBZzkBdnXh9YCmMrgWQZgieaZkXuQ0br6BGlRUzwHbuZw+qDadjWyIeszovvmE8kn2Xq37Jk7vA26uTmgriDaSnZULGB7DqRgUJyIyu+uf192RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1lkL5qb; arc=pass smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so13191375ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 20:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782961891; cv=none;
        d=google.com; s=arc-20260327;
        b=FYvBVRWVTU2hpUBJveIumEZC3uFTfv0iSgwGu43BhfhzDosxJqOX34EbaDeoFtsTN4
         vvD7kvi0kz7UsuSkajMYozM9uNPBMeI3O3hkMHT51CJRugMUpbkaLZtdSvjGEmk0xSPh
         KpdcPok2CNOnhry4qK9zHbPHLmdZpYsT1aLC/MpwlVXAFoJQY/L/AxfMxlVrdU2CR/6c
         9n8jCvNv8TrrVxgVcbLL+SmOhxusKBOR4VNrwOvntOdlJyqIO2gPu+3fRGZK/np/jMTN
         81NtZD7foikGWy288OIXt250AoHC3asObLX3fCZOZWmUZrBuhXUkOhCtqpRVq+NsrSRn
         uvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnNytJv6VnTEIdEjmt+c5DJy9TzEzsvYHbh936H/bP0=;
        fh=tU5YKhQMj5APFAHf2+7TZ2cOkyJPAnX6rt28e9OJakw=;
        b=pWSm/g/DHRvRZ5cx+BPfo8chgj1r/HKfqG34PeIdIqzYDnb5FbO1QZ1B0NHw7iRt2c
         a/IcwzWRKsiUKLTBFWDZr/O/m3wgnlvifBpAYwkw5RFaXgKeU89fCE2k5UKSixKuF81e
         ZiPHLRJ3bqZ23MFsWsTr9NUx1rwKJKY+dx8GutQrprEm0MCilbXgxAQjeT4pBREOUjUT
         /m4ARlM/JyA7X3BqryyjrnQHfDW5EIUqMYUJhtPhqYkcBQMw3h9aRvh3A36Sb9Ip89TG
         3FiXntpARwelrxn9udnLthKV6p5kScgAl37h10plYpKpAuXbInZ85U1oW4Nr6WKLcvGZ
         nnvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782961891; x=1783566691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnNytJv6VnTEIdEjmt+c5DJy9TzEzsvYHbh936H/bP0=;
        b=d1lkL5qbOlGWX7o3DjOUzb+A+oR68KdT9HI8a/Hz/N12vkK9zFJUfKESgyge+xg48t
         pF0M1/i/PwrWMhcjps4cx52YXu6Ea6QSx0p499QnMBQsQ6Gar0uFXmlI40WB0GmPIGFi
         fK1mkJYAlmkOp/1noSE5xPnaLhKY2NcXDXRo8U+YwlXQ4Tc/msb+v0xXwcNQB5wcJjpf
         6mZufEhJEi+Oe96RZ8g6lPcCK8HQz5jmuT9o5fl1oFb6ZKW8ygBl4awG69K2FCk15EPN
         0U9PLYTFb29pkOko0vkJhvA4nG8a/MHBPB/QbfEYunaicklR0DcNxFCEk51MxRz5WzaN
         kQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782961891; x=1783566691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnNytJv6VnTEIdEjmt+c5DJy9TzEzsvYHbh936H/bP0=;
        b=outVoYDsdn9ZMLari9tHMUQg7U50B/DpWMHj8SVeMPxca6RGCWneRR8sE1dy/mGuGe
         w3PC+Hkn3nD9hSxvJTJ9OEHRm/h0kb9YkTIh02Y8p47LiOf438DFIg233VIdo4vAFnMm
         ITpHFxJl4yQd2JkyRghyxlJZdNBQaN4f5BG2TL8pLRKyoVPaCV3tOaDPTbUAmvLApct4
         PC59tjKY0/+G2Hst1xwf3vx6hGIxYCJ0N+kHrRPLjumbkhdG5AdFjcbpHdDzW3iJRVNe
         PEToCbuZ8Mhhb2BzEaPqkoRufxO1ymTyosNDhZyRyRpxGuI1rqo+mlzM6/DwUId0nVFX
         PGgg==
X-Forwarded-Encrypted: i=1; AHgh+RpecLajNJzgZqotznThKjmdpiODwRP0ue0uHyR9Q7TCe1W4KZdqaSZJg+HE8iXsLKXo1NxrcVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCYZ9l1eEjsmJiltjTHXDzdIAwfQ2AdXZnoKJpq15Y/P2GFXs
	KgZThmQgFzBkHZAbtaDSo4QWBZlP9McG3Uk653TJ2T0qZJzw/NDl3OusuasJF0ISg9SYa9pZ2O8
	TDQMseVTdWIJgqAWEJROqPahN7gzGDeHBPiCzxjol
X-Gm-Gg: AfdE7ckM9EvgmyTKhYbxrEMnx5iDRSu/StT02qU0ydG6WYb/T/evPIh8mQdf1nY19xj
	mSghyHRdATKG57e0DjPnfEuZ5fmNzhSjV5U0clUeMh+Mjn/DEa4/HvYynVQgUudvPUqjC0sPAhD
	p03cZzbvN0LKC1iwqzj0ZR93tvA6z29BDyk8sCilr2nnVLV71KrS98U7J3suYHZZd6pgOQrYnI/
	ulM7NUojqHu1lfBbv8jgR/W9oriH+Pvhp2hib5Hv3buzBUJKisFE0+C2ccwMjPSRxFPArrVbexN
	Sp4cG9jPs0S9AWMdTyinhr/tt7sqM4adtDGyPVwNrVNncGF4EaasC49W/EwzF4h57sY/xxpvTzc
	9IraYD8uIybk+wV0ZtNF8nLIOKBsOm52lf6omF1PoPQ==
X-Received: by 2002:a17:902:d4cd:b0:2c9:bd64:8c81 with SMTP id
 d9443c01a7336-2ca7e6d9f27mr42065095ad.18.1782961890804; Wed, 01 Jul 2026
 20:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701155135.3962058-1-edumazet@google.com> <20260701155135.3962058-2-edumazet@google.com>
In-Reply-To: <20260701155135.3962058-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 20:11:19 -0700
X-Gm-Features: AVVi8Ce9-_aqTW_pzcwYLuhzwHOssnw4gXAiPAdYHJTSURopRhxj5UXgeH876Aw
Message-ID: <CAAVpQUDHsCHGM575KJpN6Zrg-TyptsewK1MRNbuFdjDgiUqQeA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BF446F32B3

On Wed, Jul 1, 2026 at 8:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Update ip_tunnel_encap_setup() to use WRITE_ONCE() when writing
> to encap fields (type, sport, dport, flags) and hlen fields.
> This ensures that concurrent lockless readers (like fill_info)
> do not see torn writes.
>
> Also remove the unsafe memset() on t->encap which could cause
> concurrent readers to transiently see zeroed fields.
> Removing it also fixes a bug where t->encap was left cleared
> even if ip_encap_hlen() failed, resulting in partial configuration.
>
> Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp e=
ncapsulation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

