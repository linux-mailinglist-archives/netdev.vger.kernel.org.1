Return-Path: <netdev+bounces-284071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PVyF2Ah+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 627724C4847
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A593009392
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956838657D;
	Mon,  4 May 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgjxUrbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A276368947
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934680; cv=pass; b=oC/aOqfAEfhQEHS5/dBzE6jOd9LUjKXyU5eKTaE6DkPGrnYHYybSDt7Bc/X2dP2IiJ3s6iuuftYXwrg+kgGdrDPyWigGmTqdtMhuFbHwn2AIizYt9yW9FyS4uoGZpKFffYnWRlK5oYc4m19hzUZPVruTm/sym3Fqa+6JBhs+glk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934680; c=relaxed/simple;
	bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsnP1BktmGyPpQidla6g1kswuuFiEdcKNKv2U0npJkeL9VVEqLG0Q25IgvYbdScUPne8IMRWQ/LejNFEzeGhGazsIQxSEuFAzAGXeP0EKoSqlI0A9A5483xtRl1QgG3rao1FUdMUZrhyJ2qLemUOrmfnqcQ2NDI/DfdIsXk3Sm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgjxUrbz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso2142a12.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934678; cv=none;
        d=google.com; s=arc-20240605;
        b=VSlOconj0DyZSkkLPGDoYRrQ5QULOzSvWhffqLuF1TD7zMhdpQExf+ZcB9QvZ+62OF
         DqGj/BDI5NFa8uXFGHRN0DMImyknHFU6+uy/rnRr9idydZffGNLORKc9zP4B39UyxLQY
         ds2pDW61V+GAb5BrELPpD/ZUAC+32mWxjidd6J/JeRqxnVWxMBz8ezsl0pXfZzU7EBCM
         +kT3K6dtTXc7ov2rJWZXuMRybgdd0XEq1YuvJA+EScQKMSPj/BEcHwEgqGuk8xaJ+zkw
         nOnDXcX3uj1f4nnTZCCNgTUkWXFJfq2gaFH9GMqKTZCHj40fssgCP0vezdAyfPbDL/XO
         ePDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        fh=ykIu+IOCroeLOJaMO9uNIMg9IYBjMb2u3OGr95dKA94=;
        b=WiNQfm+PdXn3qIuc8rbBsYiz2R+K62IYmusTXh0TKBJc/nQJAH64RfqUvDAqe1Vf/k
         HhLnagIGbH+jvZwNAAcg+oC1IpiTrr/b5sKFZRwuKbpcnzX3erw5RJWrXW+coZDbKmMv
         +LsOtAH2VBa2vfQudxBeIcJbAlzTr5ikKOMIdEVZ6SofSjrXRs18nUpE4L49/zkIugMD
         wGzCbNK0IxcqNmwH20fRnSxO2fmi2P7Qz/4My0OENtxxCh6PNDlMCunbun0dwZ5AbRbz
         zhNm2bnZWGpusjQP8MAHgFyhr7ckD8W05dYeskWvaZDZQQVVm+QhDc3N7BHyNiW5LZ2a
         00qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934678; x=1778539478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        b=JgjxUrbzRxZJnFoxwn+lkGfk9p6dyi2/BALGU2HDZARuAtdZT6q44GpYulSPolihSB
         6J8UQcN3es2bbnn7oeaWECe7mkGp4jPyQW9rEn8uC85TIZIhqSQzlEwNkYMiyCcH8Lfz
         Y23E2hwhegi/KLE7q/o1CkUUa5qogMoPCi18YCqXiU6hnct8pbCxdBqLMF5XxhUlDN2s
         UYQyFf/8X8zXlZq5rwteIJ6vkZzVVYjOVynO1M0rSM/G+066gwDGWcAqVGzFB6QpQrq7
         5NNBm8h3j05y30RJOVvmo4xvUd8mIi9lXiBFpJ3bCML/t7W/v9MYViO6CzjAuBMSxVuI
         e4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934678; x=1778539478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        b=NXAMokQaEbTqVTGYWnoowqk34QV9kbS/GudSowtDX/K1r8GFR1EnU4RkbGC/7zWdzD
         zwHX2i8OziR/AZbQNkhDnj7Vvfy/4x0KlGpCcf3sKE3UHsVn+QeZD6c4/WVNpkC747ce
         +/rvSmcE+vs8gRtkg9fa+/mAban/+G2AqhGrkpDlCiD2836dmoeBNIMgVwWm2JlnIxp1
         sX3X/qeheQj0D+pPb11BGF7SA83LImZ4U2jn0BM1e9J8EalEVTq1silopJ2a+Z1gOBsj
         QiYggdSF8kPwy5w29IXUC2hHRRcgXyBvJQtIkrLkyIpzsl+u7Lr2cGlkuYLrX/cuvmSG
         7amw==
X-Forwarded-Encrypted: i=1; AFNElJ8q9wjQC126wUX26ecP9UCFSpLNyDyuMr36gSwenL4RYPCuvDqUyBFN2orlVKlu7/tvxbG7LbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxpBVVAdsF1daDV1KOSKas2Pp6R4FSdWbMLG9Ihv4rb5IWyT3
	3sw1+GfZCTcaS6gHr2FvYY0ISwvDeNgVHUgzeMyXX/sLO/QG7cbIAk/y1wHHpHxQ9nxsxQsK2ur
	87AaphpPK8YZbFcf10kaOHB4oeCY6XUxjyGvELHKBSPWal0Gxp1VUV5Vt
X-Gm-Gg: AeBDieuyfo9WSljBuba7Khbe22a8EE88pvAzGcN5PuTA1WtNh7HzjhW3MDZ3a1+Urg4
	NFrlzqf7vKitWCXBmHWb2F0ZsODXkbX+FqEe4Jmk3GlZaoA6bk/Z1pS2jdvJxc41cMMsXbXH+9a
	8BCuyhAEvsWrmcsrjWedMM4T0pL+g/KPpNpGw4aaDubBQipEbq8SwE5r12AHMRrnUxbkzAvISVK
	seB8pFcj421F5fzbHznp6c3B9iosSbyAxAJBQemHJyv6NBKcKIslCEkCxDeYDiQcrJDcybBJc1j
	drJYMf24zRoosFpGKGzA0c/YPFZsGQT78oRt3cWPBbvXjgHd2LgEz7l93Rb7ATeMS+osyKhtdbb
	2sN8KJ2Kj+hLn5L02amhRyrGgAg==
X-Received: by 2002:a05:6402:71a:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67cccf0f26bmr7665a12.3.1777934677562; Mon, 04 May 2026 15:44:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org> <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org>
In-Reply-To: <20260429190150.417b0302@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Mon, 4 May 2026 15:44:26 -0700
X-Gm-Features: AVHnY4J3w0BS71H3Vp7F7zgIqkv3XQzUGxKzlNG30V6pti40qOkOAPp-uV87PII
Message-ID: <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 627724C4847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Are you aware of NETIF_F_RX_UDP_TUNNEL_PORT ?
> I haven't checked it does exactly what we need, but I recall there was
> a ethtool feature for this..

Thanks, I didn't know about that feature and mlx5 uses it. However,
mlx5 unconditionally sets the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
flag, which excludes port 4789 from the entire UDP tunnel core offload
management (see `__udp_tunnel_nic_add_port()`).

So using ethtool to disable `NETIF_F_RX_UDP_TUNNEL_PORT` will not
disable vxlan offload for port 4789.

I think a better approach would be to just remove this static
automatic offloading for port 4789, mlx5 is the only driver using
`UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN` anyway. However, there might
be a reason for this, such as some supported hardware offloading vxlan
on port 4789 by default even without commands from the driver.

If mlx5 continues to use the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
flag, then some change is required to fully disable vxlan offloading.

