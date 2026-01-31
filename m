Return-Path: <netdev+bounces-255374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id elVvBx6ifWnoSwIAu9opvQ
	(envelope-from <netdev+bounces-255374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:33:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA3C0F5D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CFDC300BDB1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4C2EC0B2;
	Sat, 31 Jan 2026 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDuxwy11"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95073EBF04
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841178; cv=pass; b=Dc0C+YsnTZxvaB7S8zWE01bp4+vRyYs7PukjIv2HpYab7kC1M6P4eosMsjaNBBvSfcciNvuRj1qW7cQFx025FgZI7usUEb/qWtnS+7omzxJUxmHYffjNBD8Q1c/o1cVN/71j9VJyjjH5ldGZBakiST8cXwB5i5FJ+SQM9GG5bks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841178; c=relaxed/simple;
	bh=+kK3S60cnWLRDtn3inf0K3gUFcEPOOUCAvuaYsCKFy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYOHnsqPQZx1oMhWREJ/7ko2VJIGHmKtXN+o6hImVUgif3ySI+o6hrR7K0bDKsoAnz2XitxFgMvAqFe4Bdzw/PawLwd/wHVN/ND9wPNxJ4oPFURPGQXfySo2/i9G8XbkkV19LVpriGgCyBylsIYdvM3X++NfFmW+dw5CoDv+F2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDuxwy11; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a1b4dd40so3004713c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841176; cv=none;
        d=google.com; s=arc-20240605;
        b=N8Wqa0msZafqBrfhMN6FmfSinrcm/sjf8uf3+G7qcLCGPIaII8aYeQICyom4gx1fEr
         b+jpFbE/QrmYSJVbmCsTyJOpaMRyYSBD0hv14uZWDpIl7oLeKmJjsJue/vMLlt9j3lwd
         9P6kdovdSjWcwI8kYd+Q6lPgfaZSWTpYS5m4DvZn1JoDfKIz79iCHmWo4MVsvmSQzBO/
         XrB7MZPHacSCUzoJSOr9PU6GGWavlq76XgLOMG1LqantXNl+TCx4v177QtcRf0JvEc+f
         5LkIWV1D1djMU6iRsI3EMUksMj+k+UKXBqW8JC0rnMUQYLEpeAdd9W31eLyTOYld+cdL
         BWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kK3S60cnWLRDtn3inf0K3gUFcEPOOUCAvuaYsCKFy0=;
        fh=zm8/toCx3DBdu2xJRvbeof9onMYAC+xouZCi4kgE3lQ=;
        b=X6Hv0IGEHsZH+FQhKfQQL4U9bjxqKg+LGUnRQ2Tes6rdA9E6NKnZWU/G+4XDV6kgV0
         4XOylw/N6e96VXxhPF2D2Cst9XJJ/5w/unpAnUatBwFxT3cmo4FhKRSh9/1+NUd6nLcE
         vSsEboWjqiCLqYGlzemlTk6msTooMER9pygWnYCnbD7040EJ0YCFouRoLL6imv7hPqNR
         dul+Wj1Dtm255WqN0r5wqPgvYlpXNM88qtkjJkZ7RP4yKJbafDOr5kd3/xTsVHUjLmK/
         RUr9UJgHrJ3KRhY6WEHrJ0zGjnhxqmi+GT4xxn/CWH5JVPmoGbZpjuS908QZeZynj/1F
         vQyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841176; x=1770445976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kK3S60cnWLRDtn3inf0K3gUFcEPOOUCAvuaYsCKFy0=;
        b=rDuxwy11XKhVd2pVAQFgirJQwjJYFDGc9G8ZFbITxJ7vTYdWgk43fYE3stWK2g8u7z
         P7XkAAMfC4uW8KK23u1wE7Vi707AgwaZ7TAGS7BzsITwbcZY4zMH0pVtKmEnjumFJ10J
         7mndE5jgRhJn60dbkdwLr0iHZMWkxdB2iQerI9nJ6xzWnXOKq9brjdZdakq83aW8eWpd
         M0nb9GO5G4ub08DTuo7wu4YsLgx7bWpZGLXjxs5jLs/TBvgBW4uAFzTumadJtaTgMevq
         /9uOEtJ1pRTZGzb/aDnrv4sgob1QFNLHIBSewOOIbhcp/AOjH9OMSRES5hFjTICTplgY
         Ej8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841176; x=1770445976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kK3S60cnWLRDtn3inf0K3gUFcEPOOUCAvuaYsCKFy0=;
        b=gX7fWyhrjTgoxRlivL3rfWLYILXq1VPblnRudDNVPxRNZJi1Mde2E3viA4QvZnhZJk
         Ri+GdrfP6F3LiaBiBdlrpdfaVrA3LxeOe+grVDK9qKPcJdpVWgh7fyyzp6/SPn6MF1w9
         gSkvEmhIadMEnlMdi3CxenR0Visp9/xluiliNOSS3g/SyDmxcIPos+Mm2jF/JxUVDF3c
         5GrPHQolEWgln92aCYpMuR2mbs/f7xiaqfwLqx9c23EZcr/rigQPuSB3+dVL+Dv4KcMZ
         Wj6PUCyTCMmVkNqvG5iX6qSrXmbZMvO+p2n0axnGh1crsO+IdIpRsE1nZJSkJAj34XP+
         /V6g==
X-Forwarded-Encrypted: i=1; AJvYcCUE0znEfXHK1yy5t/DPq8UFKbpB+jw4VIQNGtmNDbZhvO/Q0moqf/o3DPCupLwaCicHn2vjUl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjiFso0qOuQstzRY30PZDDrybROwzUSVUKOb8uKjHDyW8rl8p
	a0dyqT8HefXsCrrSHf4aMPZTVP1fndxFpdOSfvfqAjIFkYNP1Gvqfi5AhtD5Y4ND6WrWf/5BhW+
	jqwpziV/Octsc/PNr3U1KTh1EwfVQ+Bc0u1n1uoUT
X-Gm-Gg: AZuq6aIqYoK8s/boO8N0pILVHtBYE7ygWaO5aqARk9Lv5HlhM/YYFq5KlMrZS5DQrXP
	8NmtwmWBp5UQ9uYjER+aUE1HhVsnmx+qtciNLCg5417iICWoFUqDN7/PG1FWgfZOVTOFAbeMN8X
	YDAgB+/VVLDTi08sFuj/FLWqBoKdlk7Pi/+axbpGRSlFvoB51KyRLhqxcEp4hv6aElQ98LKkG93
	pdZZ+Zr+V71KhKtdiis4Umvie7PcgP3QMg2zxaD3iIvscfaTNaLDkaP2BzcGEwusblZpVIG/CG+
	Y97zjkXGoDY8SnchWo1mfUSrD0R9nCe0BmwhltfT8nNs43dZHQ8VrGB6x4YO
X-Received: by 2002:a05:7022:68a7:b0:11d:fc72:e17f with SMTP id
 a92af1059eb24-125c0f97b39mr3380143c88.18.1769841175721; Fri, 30 Jan 2026
 22:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-4-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:32:44 -0800
X-Gm-Features: AZwV_QigCJ5ND1ZrxaI3fL_TX2r5XvH2toJP-R_IlcJ36EtJNS2-ilbZHGafr8U
Message-ID: <CAAVpQUDAEkezpNSVkmy7-beHVdvHePKodnXhbC3NpKwjbV_jTw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] ipv6: use __skb_push() in ip6_xmit()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255374-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 54CA3C0F5D
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ip6_xmit() makes sure there is enough headroom in the skb,
> it can uses __skb_push() instead of the out-of-line skb_push().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

