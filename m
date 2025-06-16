Return-Path: <netdev+bounces-198323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D882BADBD88
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A653B0CBD
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2122D9E6;
	Mon, 16 Jun 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Se34lyxP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8221FF5E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116331; cv=none; b=ZkNuU7INSq0vNaQBydsRCXhp6iZJ0DL0m4i65TA2zru25xEp3mTKfTSZmSeJCdysFpDbbsSdgUqmlL/LIwhuzA3iqR8L4BtnmKJOtgNboOhiYU/WQDpOdfG+/vUJLMrrpzjJTEheeVnxeJkzlFKaod/sw1lRtgPX5KfnH3oFZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116331; c=relaxed/simple;
	bh=XJOZB+IVtVV5Fzg4VNhb51A3rHsEjRH540doiWQtiW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsGCStiqufaRbyUDH74jt7iZTJw09Sa181v/zwu76CKbX12Nw2/HVH33SZ4eamYMp6CO16s0bejxrQkgC/zIiuAfoJ4q9xD0nQZh1IdtIiXulltlTRh2jQZW+dobhar3J1Ki7n/9//BtntmJy0v/HiglR++Qltr6whjajXRbHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Se34lyxP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2348ac8e0b4so40005ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750116330; x=1750721130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5/lOmjyyHT5vJ7/xBgHtX1GoT1b9SMktBmzQn9y1zI=;
        b=Se34lyxPdTJp4P7ic3EpbcIl9lugUUM0Okaeig4GsT/FhUDER1OXKRrnDNXLO5iCRs
         4rZ60yLI1/P3tzpJ8YmpUlcxYQ8llIU6UFU9cuaPSKFc4rxV5EpKEwYtz0Khfu9U/uP7
         C0uA99BZ52EfC6s1gTfrI5rMrlIb+KFRQTlbjIR9uxw4S/rmJv47gwg/ddmVlRZRPj2h
         a5uF5W/cRdQWpA6Xt3fIyJIwsiR5WpQu7pLWMN0JHojgIlQXsabnZPSW+oWSjtaoPvii
         b+1Ba1fmJKGL3xLvtcIh1AEzo5llDCE86LeUdPABqDyOGlTrIEfxFjo/mMo/ssIXDJw2
         pGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116330; x=1750721130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5/lOmjyyHT5vJ7/xBgHtX1GoT1b9SMktBmzQn9y1zI=;
        b=fO4h7iHo2TMblekWhC/H1f1cNLrFTeD5rH9o7dyZec5Uiigtkvcz3J2HqPPnO3u4C/
         Gqk8FvotwKDZfd9sRyOeAGNrUC1M1dBpRGvtL0qp9IP3xTXYR4bliB6ejkXsjg3gZp9v
         deLF+fPcT98OZAUSovojIBVXBItFWo1Jye9GP1EbNDOtFrwJ3it7PkAI/VGHKg7uyfy6
         3kpVa1hNMd88MNibewNhG3YAEtc+jNzQyPO88WwOmbhkOs6T6qGzyTLn7isMvN6jmAS7
         mfx7PHoIpf1lVSyEwVPVzmLMocUZAfQ6yBGwFJpz2MGkY4bH1lNaFPMI7oCi/tC77Vea
         rvPA==
X-Forwarded-Encrypted: i=1; AJvYcCVgo1ne9vqwnHhhHETg4QJM4CcdFjAqrCR4/lVFazMdSQF8HgCyh8Z8ME2GgFR37LtDEGYDT8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSz0Anv/19tp26rh8cBg9ulKIKxLR2ia4gJ323JKMeY+PlsZir
	lVFKaBvT8AluYiLI13WghQJBWe2dujAnUNXilgx/FOVkHK80c5ybZrm5g1BX42nkkdyorDTtl5Q
	Rk3EELM+PxjrcEJfTRfOlmhMiYag3G5hz933CDSiM
X-Gm-Gg: ASbGncu/5ycy/ici6u0FSBCkk1igy7rA7CrpQ+MTQTrnwo36CeGUZ1YHM9VsRooKDoh
	eIjMbyJP+Rxk6ZS5xaFhX34TywANRXXrZ2FLhodTc3onn9BagsbyEWN6vPUXX98fd+kg2Q8I6h6
	pLKqrkOa6KvVhw0C+tWHWA0yp92YV5axMpa89tnpwPxM8r3eHK7aEKoCI=
X-Google-Smtp-Source: AGHT+IG+8jTrmeV9Ab1gjFTi49osSJNtC3ZPVT/sN+6a6pwpAnDvQS+htP9Bfnx4NBqktMaO4FtmK+YhuC9jHy1qm5o=
X-Received: by 2002:a17:903:19e4:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-2366c4c2c44mr6831135ad.0.1750116329324; Mon, 16 Jun 2025
 16:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Jun 2025 16:25:15 -0700
X-Gm-Features: AX0GCFtBgVnzSUEF1LVDmR3nbbQD73Cyw36WOSVGWFYNzVaqpDiAniKUKs5Wawg
Message-ID: <CAHS8izOCsjM0rLRvF7jq7eUNiFQDLS4OLt_AHN9D9ncPVZS5bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gve: Fix various typos and improve code comments
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com, 
	hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, netdev@vger.kernel.org, bcf@google.com, 
	linux-kernel@vger.kernel.org, ziweixiao@google.com, joshwash@google.com, 
	willemb@google.com, pkaligineedi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:45=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.=
com> wrote:
>
> - Correct spelling and improves the clarity of comments
>    "confiugration" -> "configuration"
>    "spilt" -> "split"
>    "It if is 0" -> "If it is 0"
>    "DQ" -> "DQO" (correct abbreviation)
> - Clarify BIT(0) flag usage in gve_get_priv_flags()
> - Replaced hardcoded array size with GVE_NUM_PTYPES
>   for clarity and maintainability.
>
> These changes are purely cosmetic and do not affect functionality.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed to make sure changes are indeed cosmetic and don't affect
functionality, and the spell fixes are indeed correct. So, FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

