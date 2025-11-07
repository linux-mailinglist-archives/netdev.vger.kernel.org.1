Return-Path: <netdev+bounces-236770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6FC3FE3E
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 13:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65DB04E1531
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF32D062F;
	Fri,  7 Nov 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NoXctJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9D299A94
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518531; cv=none; b=T7NJj8zXPVPYXZOwTpOhOfzoZhXLiyfhN2D3oSvNNk2uWynV3q8NJkp8SQBBYWUmkHgW3XxBimlt6k2IhGSbYDAD715kkWX5OG1qpFkO6jRtxAOTJS8C8pApOFAq5ypj/LDVlU6lWrLqFS9ewIFY8HqYvQ5arBcsclntlqPli3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518531; c=relaxed/simple;
	bh=u/AQ2dLPqloBHb+l0NlkIxT1yNRlgXOd+F2Ku7n6B68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5SYMhONE411wmmcYgNdG3ljmMvtycbDfGSyMV0i0qajn1gPLzkgOYfp7JHe9YZvhUYiGqqZQ2VDYh2P9rCSUh20yN9HSWUfmnrph3H/yHFqUZyPYKIhrTo7wJT+YNH13qmAndJc0AUKwKRN1y2b0XOhmNpx9xxwe95M8GUGnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NoXctJV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e89de04d62so5654391cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762518527; x=1763123327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/AQ2dLPqloBHb+l0NlkIxT1yNRlgXOd+F2Ku7n6B68=;
        b=1NoXctJVLg9Sa2AUyrjg+plC6p/VxS1hl4KBapSCZmgGCoEPFVuIzLT6cHPJ+9aH3v
         YGZwy9eZG4XEJ4q8G9vHdn3WjqdeozVW/jMQC00zTgbLkxDCl2UDFzvVqFDBGQmnHIH3
         FvKVdvd5SQw1OlEpdEmVtj/OuIkuPVScM5BfiRYUdyVMr6WPc52PHRDX7U12xD1by2Lk
         u9X54lfXCt/k+iMFPE6sdxLZr44KcpCWXQNR+feoCvjNFSVRMXXKToezSE1IEkywKrPN
         Q5hJyU8ga2ZEnkkt33fD+mQhtTyukpxKqI+E339tmx1VWGsLOWAg/rHIyIy4k7iwLdy5
         1jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518527; x=1763123327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/AQ2dLPqloBHb+l0NlkIxT1yNRlgXOd+F2Ku7n6B68=;
        b=B0bVSZ3HsOcrlIuWlf3tJ5CzgV3Tbpb65Qc7d3Oaq8XzYz4/cu9xY4BIArS0oRr4eh
         i0aHzdN7rAwpCSvypIMCKmg4o0XBKZ5Cq2UEz4xHT9+sboLvkzjBD5eFxlIHX941BfII
         hz0DYneZlaF+TK5MGaE+8n0+lFMiMqByx1O3V/TXZxuwu+K/RWJl46pjdUrdhIxwYZzK
         rcORmtv0Wn10tERrBVRJn62zXqlDQI980YbStOuXlN7PPKPKfJHD5g/zOxogJxCTfgoO
         sndqVBpTyE9/2jfpBiBFUIgQdM5Nd3pEzW+LFLzOS9s0znkFLdDga7qgO90HIeS2V940
         skRw==
X-Forwarded-Encrypted: i=1; AJvYcCWtNBAjT10WAgAIQPFL264MJciD8az5uVR5Vuqb+wZY9DzFRCl2in+7gIs+Z0ABDSJqndBijVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicEC3V5j1VXlpmvXrkqVf4YVY+qinPdDdJI2YM0/N5AX1l8lt
	ZIRAx3Y7wXTy6og3vszM6EibTwgynOVZg+m2kNNNbj8wrBnGSS7a47Zx/zEgEMGjvEr6wxFkEDH
	FNgKxHuMFKO2aW0pnptyibz9c+N8EUJDwjvHTBAXR
X-Gm-Gg: ASbGnctyuRJND3HwS2gicvUurw6H+COFQ0lz0SXJEPRJUaJ+S/gUObPneYsDNcyyTJV
	qzyrh/dPqzB08IFZ3CZnPF+Q3vbBsDKm+MoUh+gcHeOEK/IbulHIqfOrK2+zGhGjNuC72kg1FIc
	eWgOgJyQZK97lRuhjkpzEMVAPlfFMoMN8Ow5P5X4EL4xW+nbOrNOtsbUVP78TJLclnPHJkZHms8
	k8Z925C0lhcR85e5lgtMuBfffZVOctvzJ6YScoup1WBwAN2y5eT+v09HBjnmVgZyTBw4jub
X-Google-Smtp-Source: AGHT+IFe9Gh0/m+VkoCvK4OKuqq6dN1QEE1387pHlYjy8VUbPAVoGhX3oSZ4yy6zEvn43yBrQCfw8ngHX15EXesmWdc=
X-Received: by 2002:a05:622a:190d:b0:4e8:b288:7b6a with SMTP id
 d75a77b69052e-4ed94a83c9fmr30802591cf.82.1762518527099; Fri, 07 Nov 2025
 04:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <87ikfmnl15.fsf@toke.dk>
In-Reply-To: <87ikfmnl15.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 04:28:35 -0800
X-Gm-Features: AWmQ_bmKgFrQduf5kNqowahqhYwG-he0F8L4rTKeIMYAum9GRffPg0zmuAQYegE
Message-ID: <CANn89iJsH3iGuFct0DrLfN8tiga5hNKBQXsX-PgOWNERgHwqMg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:

> Impressive!
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Thanks !

Note that my upcoming plan is also to plumb skb_attempt_defer_free()
into __kfree_skb().

[ Part of a refactor, puting skb_unref() in skb_attempt_defer_free() ]

TCP under pressure would benefit from this a _lot_.

