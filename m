Return-Path: <netdev+bounces-255375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGGJFWmifWnoSwIAu9opvQ
	(envelope-from <netdev+bounces-255375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:34:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA35C0F89
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4731D300C01C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654B305E2E;
	Sat, 31 Jan 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdYhEUMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDA2EC0B2
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841223; cv=pass; b=RmX/6mEtIA6372bVxXXBrtE6q+BRFrItd+EGUnxI0o/PIdlexbKGw+Aek8PWtraiR8Vzdk6zUl1sJ+m70otDOLVDpnRGf3CfNhNDleorAS6+kdnb0frfKFewslFEQuhRFvZkYPOiY5mvCLmpfKsrjZbPuJ1umI5BT1cZr6s/k4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841223; c=relaxed/simple;
	bh=TwcBJp++1/vvXtpq/3gC9f/UWHAwqlOCgLwutPewJKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4+FFO9pXenz+Lm1nN03YkIBx550UJgsneSToPl5bXNviSyQne3mF7eQwKRV/4Zq/Ei3UjIoj6HPAmu31JD3K4tK7XV8lrTlHufBYpAIVv9Tcmsk7CF6zhTST/8pc3ZqANzspf7I3pi2k5dYZTMVRRmJXSNHyC8iiu/S7iQRisk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdYhEUMB; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124566b6693so3099300c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841221; cv=none;
        d=google.com; s=arc-20240605;
        b=HQGSKqhTUWV/AhTkG6naNIxFjI3MqKoM9IfxZ7reBTRWbK/Ox22tUH/VzQvljp9oOk
         PLwRhmBvud5XH4/MsyEH9q7g7Voff212zrWgQsUaAlkMXxJTk2GUl+Szaxu3nd1phyhx
         Qt/P9ZDF7BwMaAeyfyLpXIBQ34EbybDXgKx+blQhlVMDOlRsNZ7bc4GhMnebDNfDiIol
         QjJ2GH2Zp5HwHsqRcIQTvU7fR5dBliJ7U53HzX+cGSoFWW/yXn96NeQNPJA23a3IY4wZ
         it8jy7PLeH0n32dmTmhjUP5h2Jt569F/8WRbpO7R7FkdnDm/eM4Q6FiruMAJLKO02V6y
         rWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwcBJp++1/vvXtpq/3gC9f/UWHAwqlOCgLwutPewJKk=;
        fh=6UYvW1MojnuQHAId36v0MbTNMydMlWIgmLqxNP9n8Y0=;
        b=EhlAppeBu20YFcjE5GPuuWjxXQy66thZUB7cmI5Ffq8vkQt8rimMSLV5oFLdAUT0/H
         gxNqwLR3OGSBlO+Q8vpxnJlCsKAMFir3bGP8H0oFl7tv52L98cQbi7/kAZH/44qWSYzK
         OYuOtKhFVfpNagRcFh6baifUqItGgv27l7xxlEsCOXmYIDxBSNN7YIGHjo6KT3V5t8fT
         JX1FixgrqKlkoaSF4j+VJV0FRjfkuADrm/A+qHw/VlK1vQRPaa18V0PVgPf7Rv00qtG8
         3Ailw2G6y7EXivETGxkE8QCW+URbxdE8PtcI703UzDVs4zqHay4SirBdpnzi4pOudteK
         Ljfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841221; x=1770446021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwcBJp++1/vvXtpq/3gC9f/UWHAwqlOCgLwutPewJKk=;
        b=hdYhEUMBwb0eWwf5ss2iMrDWjR6YacUSzS5mH57iappzMPKlUYkhdoJ6Ymgh0/UyJ8
         2jMimK1LzlhHE2xL56K7Ps5m7QHlTdGPhByjsXaNJ3i4kBUPq8rOuS3bDL9Y615JxMLZ
         4GLWgTw98e4W/heIBSfndwrM8mu2jmiTetmWggWEOUd/aOBk52exyhWuOWVltNwd7w/n
         F0afTFbhtsRkn4P/1+/XY6nNwuF2MXTyyn9REzTl5jeSVUvjBmJpvK2cL/1lYt6HEKgs
         fiK0h0lTpgLyvv1gU50GTRJisHVh5sz8vcyWdf0ODfjt1e88dIPdkrsanNJbNp/mg3F4
         uRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841221; x=1770446021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwcBJp++1/vvXtpq/3gC9f/UWHAwqlOCgLwutPewJKk=;
        b=QxVfc9YFK5FwvcgdMaUbzXp66U4XZIAz/qfbSl0fm3Kgq468jkY5W36pPXPrRt7/BL
         03AvdTMQlYp9zV1Y4cJZlj10hu1FhJPPgmdAzETqQKOsIOSS/LYWx75hCp2udYaxe83L
         OBWKyB0a/TNGiVyLKFeHW0uWjzsmB2YP9rCnjl4AS3KYGXdInuco1FTcMSwKRZyozmfy
         3jUziNz6Xp0OThfMEp2A7UIIMoE6zpnOPw9XLIRArncRjkua0cw9whsCSlFSO3p5+2St
         Dph1fuW6qt1W3nIQNBKTg850fTKyk39VIGfx9900VPAkgEo3NGCcWzace+tj7Kxq1u+h
         MsyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMOeNu8j1UfOA5jS2Q/tEhBtlyfuLDk6l8ToM44eRL+Achaqs8jqGICWl76qehEestDh34So4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnSX1GiEafuVjEN3X5mVE08a4Zz9TNGC6CryFslH1IttKcQzq
	4pxsw5gG7N93cEyctLmFAqeMSqsphITWxhICdBeAs1Mfhj7fMvWM87Y5rNi1S4IgWy7aV6XRD6l
	IqYYwLydWCO+5uqUi9BqcT1YDvn1el3xQrUZ2ufw9O52QGfaf0TEVYQ==
X-Gm-Gg: AZuq6aJTh5XxjJcL1xXsqkZ5yf5Sno2Vs1dY6ZHTP/dwHOlXDDWottbBoZyHAUCXAwZ
	J/hQkYCE0wbPJIgCvsvlggpv0YOCLZDoxZU7BIWhEsySaaMEZvE+ok3hXgyAaM3gMr6H2EmvVuF
	PufH/lpQa1eMXTnjNEExSQGV7VGgynQ92GR3REH37HkU1gB8Bb0XZJXuX08zJLd/6xIa3SYGwI+
	t8r+00y91MPX2blrb/2IoxaTqxhI4eS6ZicdECJsTVNlx2Mm5aEkErehb36wg5qFMFMQD4H8tnx
	RmfGxVJIT/CPygOtRglVL8sqQvzmU9ScC+DRe7wMgCRbz7pNQbjDXoCKvUZZ
X-Received: by 2002:a05:7022:602:b0:119:e569:f262 with SMTP id
 a92af1059eb24-125c0fb4bc4mr2393991c88.11.1769841220918; Fri, 30 Jan 2026
 22:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-5-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:33:29 -0800
X-Gm-Features: AZwV_Qhgc4W4DBQfVYYPNFLSDl_0EImMCqm2VkaeHXCm2QBsoDjnTPcKFIgBBLA
Message-ID: <CAAVpQUD_uev_3N_3yQXkVO7Bwac-8x-b1riJVj04YeoTfpphzw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] ipv6: use SKB_DROP_REASON_PKT_TOO_BIG in ip6_xmit()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255375-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ACA35C0F89
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When a too big packet is dropped, use SKB_DROP_REASON_PKT_TOO_BIG.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

