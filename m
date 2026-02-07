Return-Path: <netdev+bounces-257787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A7bDcOzh2mRcAQAu9opvQ
	(envelope-from <netdev+bounces-257787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:50:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 826301073B3
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFE53011BCE
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C233A9F1;
	Sat,  7 Feb 2026 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HV8lL6fs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0403002D8
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501056; cv=pass; b=T36apFBGXbFdmwRVFJGx5M2XXKM4rdvUPatc1lSYlm/oADBBQ5PmKwUSuF7bth6q9+Wc7moa1J3glIHk0V/BQaXVkvge2oT8gfJUPLD81zkvjKmatm2bB38vZRWqI4xDZlEWGxvbffJtZM5bNkn4/jBY3wXoXRGStW4t6Zm6i8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501056; c=relaxed/simple;
	bh=95gSqWJc+Ti12m1jJURD7KFONvPd9eDs7+qSuO/OEvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvvc6na13VAJHJwypIS9rZM6MsUYUpQAwV44eeGEwUO04OCMvkfJMUNGFO5t6Xj8fn+j9z4ytgu3GIbSW32AEC/GswmLGyfHvYbIcogOW20/1BMIWFsvC4OuCHcI+Jq7wwVkR7zYB+7LsRoImkVF+mAEek4a/Q4rcIj7n7+b7Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HV8lL6fs; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1248d27f2b9so3798110c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501055; cv=none;
        d=google.com; s=arc-20240605;
        b=AGZtew5TlcZb5aSNDXJfHatVWyb8IOX1yb4rra6GcpOU1XpMRwomNeai1YtNk3ioNt
         9wBrXjVMYo8uLqO5LA+JCeUU5gV7BS4qyKNwfEorTCXMFsFVwS5olytQbB4ppPX1lly9
         CLGvAZaRVVkNsxpllzD1sf5XeKcjpP+k+dJ0P6dxH7Spd8XXtmCCnHkbAEbk3tBT2cS6
         XMwJ7HQqyQz5iUdB2QJFSotrLuR5vivKJQ56pvFfs3Jix45xbCRkblmZUboXM1BTQA5K
         koHQzEKL7dYhqHiUotfZpj7h5U6F3QVuk68HJUxGXng7RrSsZAARgqzRxv/XyI1vsb2G
         pBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95gSqWJc+Ti12m1jJURD7KFONvPd9eDs7+qSuO/OEvs=;
        fh=p7B9e8B3xiIiCkCGjtzt46m0S1aFeR9jDBM26st+Bss=;
        b=QTfYg/a2kHSpXLTcVAGG7fnrCpvwDjTtHf6kh8q7wps3aefWEyuwHCt+w2f3/OrNTH
         QbNfS8p1jNsTn/HRJvmP8PYhEyZh1tLqbRleaOJZYP0R21qy5+i/zwslVSi5SC/kM/1y
         3caa3BQNebYVpu7dXlsPLS3+eKJsvMcjAvFJfFXv7Z2dKxnihnPZXH49xZChI+edMgGC
         y+mG/8HdTNboAzSmSBkttn6x1ayadCWdgFIWqBk3tBrBFXTHRij3hJckFm28XUdGLAaE
         3P0i0vi9vYb2SI9d0MQXS1rlrHx5TsZkPy3couT7fh2itPv+uzezBgmBVvSYrS7dNU38
         pjbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770501055; x=1771105855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95gSqWJc+Ti12m1jJURD7KFONvPd9eDs7+qSuO/OEvs=;
        b=HV8lL6fs3huo0TyvXcgpuEgAsoA5bZBEFWoF81Ilowrku34w8FjpKdgshoJjYDR7DM
         WBpDLMljqNeL11ec7Y9vIwW9wuOBfOvNb+QKqo8EcBlA6vNUhLpm5h4pkS2xubweC3v7
         Ci/jOZfWJL/fOsaERMTYr/EBtXHmyaIY1CNZWy0kRCFfV9+Q2WsqmcJ7jWEbaT44k36M
         jqkQEOOEvny/SvvCSzc1WJPCxZCCqBpetURo9hF2sM+A2mkkPI5IMgjXVWZuPu35GknM
         ibCM08A9z1q3Oly5dfl5w4hIug6ceF9Bz0QlStJGO6ZyXrB5bez057teSorQHxEftc1S
         4WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501055; x=1771105855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95gSqWJc+Ti12m1jJURD7KFONvPd9eDs7+qSuO/OEvs=;
        b=msxmWVguZSX+aJP3eBA17Ivl0hI5YLWhSIIlEYWOeXl3gstkBkbv+d8m2iok+rMNzp
         gYL7NFhrhdxW6GZOm5++RHAYCc5wmO3Wa7Ea7SrtfUAVYb0s33PMpB3XtiZEZ8EhI2Rp
         8FlKTrERAx+lHJZJITMzrU44BiFG+JtGtmcSW7pAKlZzqa3JZ1uVcYcdckyyKqG1R5Qj
         lkFZt2CePZzdX2B8vJIoVyDAIZpd5n4rOQU/+BSD8oiccWP5rkSKuxStSeNDwymV4SEB
         GyizaQQeO8OidzS/dYjg6KNAv7wH7FC+4g1FCI23wvA2TsiwJsi1yaePCfHZ8+XksGuo
         p5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWXMlZl97EOQ8dc0YClYUxmIYY41v7VkwXAtbdaQEKj9zGXpuSNVBMvYcIM5xAYj35kIdu3NQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIjTz11N+PyoBBZfWWzv0PSWR7SGM6N7WeUKzngkyt+Os2ufF
	iUU4gZNej0p2rgfl6SXoY8Bos+BlsH0ImqiC/0gTCReXSIZZwTiH39kUGlm3gpN7+fhju7iHen2
	qxVB6UieI6r2CSszJUF0XElZ2ylza7kZlt7bQ/xXe
X-Gm-Gg: AZuq6aJEKXvA5YTHaNmk9zgvK8PwzcqrWQrvS43VQGISXvVX8uVJUWKxgcaNajwhO4S
	8YQsxENo2L4kf+M/QSRgC7K/k1gFwTPPfqsCExMVZbkjyfR4tH4TGUJLAsbbs5D1A9MTtPaFkRK
	f6dJs/YOAsNdiSJTNyJp3piKpQV3GDkXD8BwMeSwvggJgMREGkxGaJ6a6bT0/UcskEC9kXOnmGc
	IKg0uPk4XiaXEq5TC84oszeBqAwddJHvBpiz3hkqJMyRS70CzReLw+Tci1Q/1/H0bwH7epSKH5b
	KHRKhSraqdPlW1855CzyvpxulFeIMB0+WFQXuVdCMZmQbdTY65FED8Fz9s5B
X-Received: by 2002:a05:7022:fa6:b0:11d:f44d:1863 with SMTP id
 a92af1059eb24-12703f858e9mr3980148c88.11.1770501054788; Sat, 07 Feb 2026
 13:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-8-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:50:43 -0800
X-Gm-Features: AZwV_QjnERkcxGYF7tM1AhAPZjSgeIygMUAAdOEMLu5ImhJw9m0_5DQkmdolhoI
Message-ID: <CAAVpQUAmYiXb=UHLQp2h9pTzGHyrH+ni8kk+2FqkN7dAvJ4dzw@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] tcp: inet6_csk_xmit() optimization
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257787-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 826301073B3
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> After prior patches, inet6_csk_xmit() can reuse inet->cork.fl.u.ip6
> if __sk_dst_check() returns a valid dst.
>
> Otherwise call inet6_csk_route_socket() to refresh inet->cork.fl.u.ip6
> content and get a new dst.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

