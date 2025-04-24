Return-Path: <netdev+bounces-185705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D9A9B6E6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B0B920348
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866DC290BBA;
	Thu, 24 Apr 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eEcj8RSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3B28A1D5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521149; cv=none; b=W2QGDWE+Mvq6PGV3ygKj0lv1q1v+00Qfj7Y22yyH3Eilw79fRkbhhVTIYikba7HVoeoGyE9F6tDoWnTf1jHlJlJHG+J05OhPstcCJcSc91PO4VVdFufCij4QRklFXgH2sK6qCyFrWiEG5zAMMbDHYhyHmEN/5NnvPic+VKusvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521149; c=relaxed/simple;
	bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URymB1V8fnQfdI8Nn5d6Yf64GQQFINHCHv8onEnvl7w2ogzx4H0F15qMrG/9QBOFmETUIy983x1FDUaWqitTAYsl3uKk2jnsp5GEEWDZuixIxbQXzPHc4W+kxGu+6QHSq1cZlhHKsERv/leTAG9EB0ZgrGWBnTE+KFalD3g22P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eEcj8RSz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac7bd86f637so497882366b.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745521143; x=1746125943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
        b=eEcj8RSzy/N/ftU8FV8WUpbEg23lf0GKlw8FpdcGADRGIojt7dVQ4UdWydyAYlc/xO
         7kTubFJIG/iEo1KOI0zZPWcg9/3TiWaVVJVgMXR3XDK6s8KYG1CIiUCcrdUWhIqAGWyU
         TjQ/BCm7UVb+Yy4mH/Vl7uKbsu8A6D+Q1RD8c+e+POFDG/Rie+azx3WZSb/H5XDjfXZq
         7Ng2OTJzggopUc17E/Xg/VDVHnf8cMEjh43H2lFI5F9c0C24EJJxd9MINFw4/c/t4uFl
         ZEig2Nb9szj6SPokEZMx+CGTyiqg5BzN/6pDJwx3rxnzC3IL7WKPuaH/W5dt5IQvNnHG
         oxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745521143; x=1746125943;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZja+27Dkbmbix3QZDuohuCssm2ow08ngePhEHO3fD0=;
        b=Z2gjK6or4ZZTl+pR3wyKhAwODiUccpk/C7SQOprhX2KzhxZtjJuB/vWQ15IGOalDQj
         UgdFl93vRtYkOeuEelA5ydII3n+gSRzFxDXiU/Aj50OTkh9nGoC4fwTDBctnkZg9NEWG
         mLALBdF0StetxOTaX8LNsYPg+mcu1eVGhXrfs2v1MVN2+UFIvQiRczxT3Bb9XLxD3WZk
         cZbxIjaOEC9CYcLI3OVXQKYnfbdZrsG5q/mnXoarU32OzcN2p507gTWViEWch0aVlOk2
         p10GOi4QmcPlQtQlmDGBsGqaorb+FeKGl5hNi58rXFzm40SmnIu4Kc57zC6EFBAR75Gt
         aEvA==
X-Forwarded-Encrypted: i=1; AJvYcCW8X6JdIhlSiaCi6T3EIokqMeAApA7eXJEzyr/XwfnwmTlsZLu6u4Dt6EdGTwerEfxhnTqUCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkbgCiM38n4q4oQ/T4Kd23DHRjElLfQR2E1+tc2ZOSnk11PrA
	PSMRqtMyJfLH22F/fl0PmhCuxBV0eHSz4RVbyEthUi8r8lwmjlFroZgiz53qpys=
X-Gm-Gg: ASbGncs+ZIA1ImOTi7snk5RzcbKxcenPHBY94DMaGQGZMYS5QoXVQmY9HKzwZ/YLZZf
	YJbkBkdIPvemR3E+J4kLbttaR/lknhy3/GyRB3c0O+GgVa+EswG/hCd8LuEQRq440rBA/iN/jgy
	HyvK6qusoja+WgfCE6IOIJdd1mf5m7lIZlSAb4Pk8gwokmR92Sktn4+KpisOS1sJsWFgw62olYN
	8lLvQL+5QdAdnyk8tUCb2kMLhteSrFVRT2o2hUa/t2njvN3gy7ufJhGpKB/iv+6VFC5GOw0nW0k
	vfaKjd1DJKP7s89iEvMysnywNj6M+TBrNA==
X-Google-Smtp-Source: AGHT+IE1WfJB2yNHVG6dN5YP24a45RQi+2yyfaZDzZalpZ3qP62lfwp2ZK6hXPfRQCwsO6Nbp9kfIw==
X-Received: by 2002:a17:907:60ca:b0:ac6:e29b:8503 with SMTP id a640c23a62f3a-ace5a124436mr310160866b.1.1745521143004;
        Thu, 24 Apr 2025 11:59:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7a25sm7201166b.52.2025.04.24.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:59:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,  Arthur
 Fabre
 <arthur@arthurfabre.com>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  hawk@kernel.org,  yan@cloudflare.com,  jbrandeburg@cloudflare.com,
  lbiancon@redhat.com,  ast@kernel.org,  kuba@kernel.org,
  edumazet@google.com, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
In-Reply-To: <aApbI4utFB3riv4i@mini-arch> (Stanislav Fomichev's message of
	"Thu, 24 Apr 2025 08:39:15 -0700")
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
	<20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
	<aAkW--LAm5L2oNNn@mini-arch>
	<D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
	<aAl7lz88_8QohyxK@mini-arch> <87tt6d7utp.fsf@toke.dk>
	<aApbI4utFB3riv4i@mini-arch>
Date: Thu, 24 Apr 2025 20:59:01 +0200
Message-ID: <87msc5e68a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 08:39 AM -07, Stanislav Fomichev wrote:
> On 04/24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

[...]

>> Being able to change the placement (and format) of the data store is the
>> reason why we should absolutely *not* expose the internal trait storage
>> to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
>> The trait get/set API very deliberately does not expose any details
>> about the underlying storage for exactly this reason :)
>
> I was under the impression that we want to eventually expose trait
> blobs to the userspace via getsockopt (or some other similar means),
> is it not the case? How is userspace supposed to consume it?

Yes, we definitely want to consume and produce traits from userspace.

Before last Netdev [1], our plan was for the socket glue layer to
convert between the in-kernel format and a TLV-based stable format for
uAPI.

But then Alexei suggested something that did not occur to us. The traits
format can be something that BPF and userspace agree on. The kernel just
passes it back and forth without needing to understand the content. This
naturally simplifies changes in the socket glue layer.

As Eric pointed out, this is similar to exposing raw TCP SYN headers via
getsockopt(TCP_SAVED_SYN). BPF can set a custom TCP option, and
userspace can consume it.

The trade-off is that then the traits can only be used in parts of the
network stack where a BPF hook exist.

Is that an acceptable limitation? That's what we're hoping to hear your
thoughts on.

One concern that comes to mind, since the network stack is unaware of
traits contents, we will be limited to simple merge strategies (like
"drop all" or "keep first") in the GRO layer.

[1] https://www.netdevconf.info/0x19/sessions/talk/traits-rich-packet-metad=
ata.html

