Return-Path: <netdev+bounces-142792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F89C0607
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9931F237DB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36720EA5F;
	Thu,  7 Nov 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BM/02SW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A820E335
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983323; cv=none; b=Gtnz8JbyqqKSvxcIizK2aZCr90lgK9EfZ/ZKvbFS0UNFPJdXydO1HutBhQ+IHCMmTT/2bMbgLADgFzBRMYYn5XQD4M+gIrlK7lbud81ZsmwkOpJufjPbkTgjh7EEKbY3VcSK8ss2Lgv8UgrbASvY8XOTM71UuECd9rvX1m44JVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983323; c=relaxed/simple;
	bh=eszVer7v5MZOo9DIIYGY54udjtPIR+aDB9DkBBxxPlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMGO2zB1HP2H3MGVSq7iydk75qNx1URjC5wp5VDW9va39nlI9f7cvdgiYOpKc35vLhvyRCSXAPLDxCp6HaZReDgfjfxYxjHTrjPLLCnKwY6QXBd5v2p2PVQEgfnbF0+mXUwFwjCOYdJGkQPod/9J5u3TwcR8Pp4zNLt+mwYLEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BM/02SW9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1279792a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730983320; x=1731588120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eszVer7v5MZOo9DIIYGY54udjtPIR+aDB9DkBBxxPlE=;
        b=BM/02SW9Q2TWDfyfzNzCko0eNNQs6Ze6FC8cafjxc7/gZecBTnhXIiPK9nGCxWWscC
         eSp8zmFzlMrZIALbYnJSkiq5xV99Ybq8FDzgrMt8C+KacD7rvBx3UZewczDPyGT7PPmU
         X3IeN9FxrHXV2TGIqP7ulim2QZTUa/fUJN8HtGqmuYHbt7Hv7yQq7d8TW690UyqYpVVZ
         oLNAtCWXlRITPFproY0VI+bJ0/u2EiW1psDgnb+iyOG/CDrDCN6teqUWqFjLUzTYgbeW
         X8iWG8ig/O7iB7haw7thlzr7AJFm71/toPU/6fgYJNEoFkIG/vTV2pj0tMYpxvg+SlAV
         5tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983320; x=1731588120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eszVer7v5MZOo9DIIYGY54udjtPIR+aDB9DkBBxxPlE=;
        b=NATBX9zZziui/WET+hw9u+S1BXntvRNmELoeag4Pjgk2rqtmgIgtuXgFOCYdY8R30Y
         YXG36HViF4Wo52+Rvs7QNnH26jgIjFBcQ0wWFRZtApOFEm6MV+8CUh05VrXyCQpogE1E
         TE7cXSwLqF7pwLmfSvJB9LTtkFv+4cMg6fs7yyUcWEebEU5T0HPUL3DrHyGZOu5uiUuL
         cKOWrS41dshQzzkauaduow2HnMCwIf8nhz4HGO4Yh/Sd7s45u762XWnI8yLZUzQhR23c
         k4Sxp2ux4GdfIheYsoiOvxrOybrhQNhaarIPVQ3PilJ0h9lkfD8j/cx7WfPlXDX/GZ3O
         ldww==
X-Gm-Message-State: AOJu0Yx0JaEhhpDF/TzIz9jhGNvCkwdJCBp418KvyDBPD/5rLSbhYNJN
	/wRWswfm5eqoO3uFzxjBewrGxXmdVJ09X/FTmZoBewIpukJ/noh3tTB6RxHUBYNBwmMrdBOlPQK
	37eisR3/wA6H6ndJp/riP1iEVQWV7Au0XiX6O
X-Google-Smtp-Source: AGHT+IEL7BA48iGiB0onh6CZQgBTepxdP23ToRimZkZPRQGzqbCFprp2kxPExb0PKC2m/vGnut0zUfqphh494iJlqjI=
X-Received: by 2002:a05:6402:d0e:b0:5c9:76f3:7d46 with SMTP id
 4fb4d7f45d1cf-5ceb928c9damr15768331a12.21.1730983320099; Thu, 07 Nov 2024
 04:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 13:41:48 +0100
Message-ID: <CANn89i+wgm3DQafFygTQgqwX8p7AGmrBz1b0nocejrw-=xnhDQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 08/13] gso: AccECN support
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Handling the CWR flag differs between RFC 3168 ECN and AccECN.
> With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
> starting from 2nd segment which is incompatible how AccECN handles
> the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
> With AccECN, CWR flag (or more accurately, the ACE field that also
> includes ECE & AE flags) changes only when new packet(s) with CE
> mark arrives so the flag should not be changed within a super-skb.
> The new skb/feature flags are necessary to prevent such TSO engines
> corrupting AccECN ACE counters by clearing the CWR flag (if the
> CWR handling feature cannot be turned off).
>
> If NIC is completely unaware of RFC3168 ECN (doesn't support
> NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
> despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
> with AccECN on such NIC. This should be evaluated per NIC basis
> (not done in this patch series for any NICs).
>
> For the cases, where TSO cannot keep its hands off the CWR flag,
> a GSO fallback is provided by this patch.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

