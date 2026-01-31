Return-Path: <netdev+bounces-255378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLRcEF6kfWkJTAIAu9opvQ
	(envelope-from <netdev+bounces-255378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:42:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BEC0FBF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB343008A5B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F992FC004;
	Sat, 31 Jan 2026 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnv8Cgyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9428D8F1
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841754; cv=pass; b=fmOYAPgEVK2A7oU0um4f2oWTbdvVTBpf+9CwLBv/fT9Wj59krkKjlKJ9G/RMtvsuAfRIS8n2gjT0Mgh9xE9HhJ9hJpRU2Ty04E8uNThYzxd1aavg95o8HiRYSGfFTrE8BThZ5QjMgfwB2Vv8JGex+Mw1tOXCMnUTBiMOIM+XdkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841754; c=relaxed/simple;
	bh=MwJrs3YqGKzfaWYsOAfU6npD0cdWs3KdwH4meoyy/iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a25JjFu40rDzmDftSE2TfMCmMp7ptH5gNFiAbz9RqJiRr/NWnn90WMWC2F03jErjwauL7FTu3yVV3TNqI6kw4/iIDyKzjtmL7osBw/Tl2x1lM9PCvtkZoTq+ul9z/Y3JOTWXZkalqVc5KqZPVZN+qCt8EhgXJA5K0QrhMDJZNEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnv8Cgyx; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12331482b8fso4035421c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841752; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAjBi1FxQSffg+2M8jwpZEKoqaQZij2Xf4RIciShxWooHyp8PbsKZXP7K+AgFGbMsJ
         QmLYJtPYJ9171+yfJrhDUXKZExtgVN0hy+x5DbrKqtLHGHOxtR/BY3QQNx5WC45mqFIW
         pU1NnUhZ8rbOTR6bOEZ3DprJL57dN0cjUvN6AgpPavUhko742S8+E6VK0lXlZqVlTDKm
         lx70oM3gBilZG7kX9ys2fgFpPddRGCtovIOwuj7dCX77/bJCUwPyipnu5GXqKMg4vM+d
         SjZ58QjmMl+cTQQeSwczZRZId5lg+/bMKtS1EkY2r2gXzMAxClN/Ns50cZ3QF8lStQAJ
         GQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MwJrs3YqGKzfaWYsOAfU6npD0cdWs3KdwH4meoyy/iU=;
        fh=IYpXndPqozrNlE7hqXlWjnUCmLYs/27xU/R+wnFPPIk=;
        b=OBTY2hoAjntx40HKvO9pZ8x1e9WZOzDqWip1HQcXldwpwtCf1HIcWoax2c2RBGaYhP
         0i5BLYja9/sxVj9WC6pinF4P2Ua4BWXNpz9tNsgw+xBLHUQxo5EOUJs0NTxq51q0LTFf
         x1IbcQ0JF+wu/icUpUAi22MmG9x1hwWjUYUUXlZIep9kR6coBJnEyFSuWUNoe8riMiRx
         UzGHzY0lSEJMY3ZW6VJiAgb1yW1EueHKnqWN2OeRGvV+gGVeCE4+mXJ9VU5iU3+J90ov
         TjGUOgXjCByATSyqxic4gEO13FHLWb5NzjUMnJ8T/CDrhJ70pK/RGvU81qy3QfRMSSs/
         B6Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841752; x=1770446552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwJrs3YqGKzfaWYsOAfU6npD0cdWs3KdwH4meoyy/iU=;
        b=jnv8CgyxosL6q58DKBhtjTThJfmAWjXXNaW9InztB1opbawtQgtO1ijK/lmCmly9Pf
         iKF/NRivw69hmOLsioiOWEx65PVzl9U/7m0nCEbIL5p6FRnpAJDkfzgLmxVFOSnFgpqU
         V0i8FejhZejZxgGH2UO40gcSQE+OP/xcstlby2bCL/KTZWxk3qcO+6UDV4foAc+DrQKX
         hTjUhqOWp+SsFmMWv45joQlNfIwMOsYoIhBE3e9HjjKMMAyXnG9t20CeT+NTRoHUR/W+
         VwFIy+Q+XkxUI3HaamNMiHzdE13+hyA1yN2AYvslZP0OoyEr9DxZqvoGBvBP4i+WpJQL
         oGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841752; x=1770446552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MwJrs3YqGKzfaWYsOAfU6npD0cdWs3KdwH4meoyy/iU=;
        b=a1okI8YooIw3bvoubOxxjxJG40qLYklsT5QdlVXN0aoiDFyW8e+KE01aaQGkdsrjft
         H1VdSgb1p+XtaL+Nc8Wfa2dw4807vpQqvW6ZVub7d+4D1DuJiJ/S+ByL4BLXceD94gYK
         O3xEL0YmHgeywtWQsFjxXQO24Pvt5EeOqFVSQFXRo14fUBlftABaO71dQPyeMu7U+CtX
         6r3aCKqNluzHGbxbzAaQiEkkTYIAD16PYzQ/PTZ/ZNQCyEqyUrTpvANT+jIbNnffOHMU
         ScLDNkvAaGkJRswCjlMYYaeV5nJ3l/AqLSUwxy4rgABYgijXJwBSj8WlYU3GCwwZYpen
         oKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvSMFfCPl9jIoUC8+D4L9BDXIAhSplnKPt0u3X5bxp5Zb+xMqQ4/iKYVtUei6j2amso9Bn78s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF4CjFKyFunWEIq1F58vi3dvZJ5E2KJS/+AYIjlopz81qqocj6
	s4pTwnNZYtuAPqi3BQfJ733JefILDqUy6qLhlb9oQ8tBdQ0O3IfZnDPgZixcj6P/hbwDcFI6Oi5
	y/EWYIiE2zg8md23LEQUr28JfTCaFxMHR+07sDeFh
X-Gm-Gg: AZuq6aLYl7lnoWhik+yUB0cSvMcCKWeKJGGkNtO4eCBpvsQ5/RLey2u+HPGDW4qIsHt
	7NgrWmbwubB4T6xUpFWI1WZ0RgsmKxka7HTCOJdZntljcOWgMlRtAnXOUvL4TiSCL41y6Yh3JNA
	RMsLcQsTsy09c1+jG4a2NX8gZg9RlgJorEpA02R5g9wRcDzuMMLgRGbAbanf27dKTmGv3f21dpZ
	rhXlLkqxruj2qhPam7gXExHTbrerJIN+pDnW+Dc9gXN0XoQKgg2/TXPccaKGISyYOMjTSnXE7sC
	UGcQdMmpWbcgz2VRqgirR0BgW9WOdxnOPtl7PjMiu+V2VGYdFg+cjj6cKlOH
X-Received: by 2002:a05:7022:2513:b0:119:e56b:9581 with SMTP id
 a92af1059eb24-125c0f79782mr2891733c88.6.1769841752117; Fri, 30 Jan 2026
 22:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-8-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:42:20 -0800
X-Gm-Features: AZwV_QjofZ_eF3Z1auePVHNJd8EDnUW7u7YdLDSKRJe8TA4BlHa-sO1Ov39lLyI
Message-ID: <CAAVpQUCpba=eiKmpddVSH_60U2734Y8DXLd05GGcA1pwZCNZNg@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] ipv4: use dst4_mtu() instead of dst_mtu()
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
	TAGGED_FROM(0.00)[bounces-255378-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E6BEC0FBF
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When we expect an IPv4 dst, use dst4_mtu() instead of dst_mtu()
> to save some code space.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

