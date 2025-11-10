Return-Path: <netdev+bounces-237223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62996C47816
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC83BCD40
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CC313546;
	Mon, 10 Nov 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkTTL9wG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8A314B75
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787626; cv=none; b=UVhIx7P0ojNE6b3NdBPb6c5vnOOJBv9gw+SS5xQew/KldLFE630b6y296ZlBYClSSPym6Xy5mw2jXjzChWUG7qJwNFf8KHjYL7ZwAK/J2nwPeFPcp7ydJ75X3z6pv8NNCsy0HGZYKSnceAZxbj07p0KUOa4v6ZegxCMz4jYKy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787626; c=relaxed/simple;
	bh=25kg4Lfr0fhTZNGgSn6dy2gqmvtndaAGHB3uI2sd1/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeARyoBqdPI7wVz8kSELrKNnALEK31VkFyk/3DFhhS5TUYVVSrVjl1pC0XGCY6GFsX4siC5tN/xzX604l/hN3+09OailcaGAZYwgsN59hBvrLhbvxW+b1oUPWkbrSU98OuC3Tlw54DM85rJTpL8z7CacOaLJ+2u5UFnd7V+gRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkTTL9wG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e88ed3a132so35510721cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762787624; x=1763392424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25kg4Lfr0fhTZNGgSn6dy2gqmvtndaAGHB3uI2sd1/g=;
        b=rkTTL9wGAZjEpVkI7b7TSc2n6bOUZ65OaUKQoqEkYtBkKk91wFdCrAMFSEUtXVFC9/
         lpCTV1jkq4WkM9WHEwNobzxcBP1uVoqbtcnpD3ScRK7zPOhx3p4DJLSnwwqa69kzlBVR
         F598i45uNcQiDsuXDiWpvVhYR+DdtKKVoKPf563TAe0SsSeca9Cg/tdpUUzaTDXe2e9a
         koACfcf48gsxsPkI49oqy6vG5ROyVarsK/XX4hTlVBqCRf0Q7FeojalAPIRndzUuWiYU
         7eqSfYUaAqhctH3DSj2APVC1w3k2XMfEvnVpDNxEUNGgGMOWCX5cX66IV4qRRPOHADRd
         FUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787624; x=1763392424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25kg4Lfr0fhTZNGgSn6dy2gqmvtndaAGHB3uI2sd1/g=;
        b=jEOLZzzpaQKyYM2IVxEAZH7WrOx3GemFdbMtf+wayns23IzoFSWCg7H542q6llqunk
         8jttbK/oUKIVhqkJig3i7X4godLFvdpCce2foVYEszVpHdN3caTyxU3aknSHK8PU1Ivl
         tRttVZFTyjQTdJw3a2U20gVbud4JAQvyqPYPzoA+GhHK8OHtkDIH2N5elc6DaktEIMXg
         4R0/qDsZeQQYYTaKmS+ciL+fZfBbnmdIlTpSO9HUIDz6uTBwKGET2Q1zvK6t+7C546M5
         CjB1XG+sEBqvOLZyGqx1sHVSi96+IvIEV1cspukhjLX/Btq43uFaEBpItI4Dc/S5ioSD
         mI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW53X+XaIFxg/+Ru0UolaN4Wxf0Ft3oel19+WM/Fx4mQh8+gBLT9dV5HWGpY0Xi6ERvrWNsABs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKetCatlrHFwCSXckNE7U8kXF0A03Bu6zgz7NFn3Fhr8viKyPf
	6crxa8hH/HbGZq7wUA9ZhL0NHQsceygVG72z/qhU1AZqbjc+y4XO+1AlPvb08SKR+mqu7S1WBGI
	tu/bbfQUqLcYcQiqnjp95/mObbn/jxLZS+bEGoDlf
X-Gm-Gg: ASbGncsEIb5dF5NhuD4/wNGuP2ATy0byt/Y+A+jeWR9qtPpLEySAGy73iVqfJD5n3d8
	zc8y6t8v5gOdI4Rr5bRdh6hYFfIaIYDGSCWGoIoNOPlKdsZbJR3GJozj+Ko/Kf60opbsCWLnqxf
	jMqvRqjcKQGcB5qK6jBSBC2tbFxw1CSuenFSMW78fB7nTTSWjUFni6BoIo+kkYno7twKHxfcRly
	Pa/tAgE7vk4HRlcoFwlAdQ7BPAMrvdJfkTCyoyXbuheYuIkxEU1VoSI7/OkQ6YpbxKT6Js=
X-Google-Smtp-Source: AGHT+IHBXMZv1Bp/UySHMcA+E4BYEJlOOLGSVWQx82msjaQTd7ZDlV43ffpNtadWDINITS3JEoAq5GVGG8byxZBVqiI=
X-Received: by 2002:a05:622a:4d1:b0:4b4:906b:d05d with SMTP id
 d75a77b69052e-4ed997f396bmr139371821cf.29.1762787623719; Mon, 10 Nov 2025
 07:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <cb568e91-9114-4e9a-ba88-eb4fc3772690@kernel.org>
 <CANn89iJtEhs=sGsRF+NATcLL9-F8oKWxN_2igJehP8RvZjT-Lg@mail.gmail.com> <4fc5d598-606d-4053-887a-d9b23586e35a@kernel.org>
In-Reply-To: <4fc5d598-606d-4053-887a-d9b23586e35a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 07:13:31 -0800
X-Gm-Features: AWmQ_bkdJsDFw-ZK7_g6m61G8z2anjKG_osgOXailiedM3FPqQMuws8qM_kZY2Q
Message-ID: <CANn89iLUYB7UEvHVaa9w0M=kyDkbOHWQGyC3fh=Nq7yNTaV=og@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, Jesse Brandeburg <jbrandeburg@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:04=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> Thanks for sharing.
>
> With these numbers it makes sense that BQL bytelimit isn't limiting this
> much code much.
>
> e.g. 1595568 bytes / 1500 MTU =3D 1063 packets.
>
> Our prod also have large numbers:
>
> $ grep -H . /sys/class/net/REDACT0/queues/tx-*/byte_queue_limits/limit |
> sort -k2rn -t: | head -n 10
> /sys/class/net/ext0/queues/tx-38/byte_queue_limits/limit:819432
> /sys/class/net/ext0/queues/tx-95/byte_queue_limits/limit:766227
> /sys/class/net/ext0/queues/tx-2/byte_queue_limits/limit:715412
> /sys/class/net/ext0/queues/tx-66/byte_queue_limits/limit:692073
> /sys/class/net/ext0/queues/tx-20/byte_queue_limits/limit:679817
> /sys/class/net/ext0/queues/tx-61/byte_queue_limits/limit:647638
> /sys/class/net/ext0/queues/tx-11/byte_queue_limits/limit:642212
> /sys/class/net/ext0/queues/tx-10/byte_queue_limits/limit:615188
> /sys/class/net/ext0/queues/tx-48/byte_queue_limits/limit:613745
> /sys/class/net/ext0/queues/tx-80/byte_queue_limits/limit:584850
>

Exactly :/

BQL was very nice when we had a single queue and/or relatively slow NIC.

For 200Gbit NIC, assuming being able to run a napi poll every 100 usec,
this means the napi poll has to tx-complete 2.5 MB per run, if a single flo=
w
is pushing 200Gbit on a single tx-queue.

In reality, interrupt mitigations tend to space the napi poll delays, and B=
QL
reflects this by inflating /limit to a point BQL is not anymore effective.

