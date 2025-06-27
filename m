Return-Path: <netdev+bounces-202063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EAAEC25A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B171C462EA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82EB28B513;
	Fri, 27 Jun 2025 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WRZpRtoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9A2BCFB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751061340; cv=none; b=uw3MWSGWDjAKtAktimg3bbOHJtV0LkUrUZnFhYi+J52++zjwKWnjXj3we6se0xgxmX96QzEgUxuuSZ25eNClyMAlR0n7i248yvlbxo1enaFbpA6MFTBWO8WFfzqae8a4ZrvoIWId8CV2ql+Bv1snUPIk+eqo+2jOnrN0lphCiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751061340; c=relaxed/simple;
	bh=KGuy2ZMa69sl9PmrGD/ebUfrW45+ImbP8+ILwoEN5CY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmme6c9nPDY917cM0gNYLbg97zAE9/tIdN5jEsD8b5QWE/heC+eb06AVYwQhUa2vVuTu/4BHeKRDNzx5A0Z8K56zvJRZuiL8og3HIl84N2K4pSOrroidgiHM7ydAu1PYJbA8ICEplmVUfufxiO2zmgxUSlDmdFt7XDuL/7bU0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WRZpRtoD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a745fc9bafso42554311cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751061337; x=1751666137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC5wJoRsmKwzBPnxWwAHtsKNXrjyKauqL3H0zgk3Efc=;
        b=WRZpRtoDcZCQh+nZGsgJzC6oxYkMKNtMEgd0UJGZXWszOz78EdcyTmua85vYcaZU5h
         PbcrfjgMHuJQcYjeoUa6jQlJzQ1gfdF6RvO3m3+vetMhFHpMmEgre6z619bJ6K5TuyON
         kAXs29QwPiP/xFH6OYgxmmHcD7yD+oLutBkVswW5DrHJ+iE2ZvTwtfArrPa4/8WDIOer
         /TJvg+n9HoyXXEC565Q41Ivxe9LIJbQb2Kbj99dkdKeMOOm6CkufqJfRCkSyduH3TNR+
         iHlKbpyUv7so7dEK/vdsez3gPNntUaUxO8Fox4w+6JwASvDZ7Ob4FHe+kfSzB4kxpDoK
         2h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751061337; x=1751666137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC5wJoRsmKwzBPnxWwAHtsKNXrjyKauqL3H0zgk3Efc=;
        b=EeF0+5RciEkBU7038d8qnkS+bvuGLny9FVQ6ljhuGxmTkWRnHRCyfT0UzgMi9g4clB
         kyDQtd1Nnx0QEcRrFEPhMYPnMOWc94WQjrp3sPic7tglcwug0u7QqB6QCs+LEj96qZCK
         3q7PisKzZSonUykPHKpIzwUI0aXJgGp7kZsLspK85lxZmaKryHmPAKCHjPkObdvyZSG7
         ssdsK6lMhJehXVIN/XQ+8r2UCAnmqdMA2lxW7IBrh9UZ8T3OEa3+jHfTi/4aZ0YpiLpv
         Ev0u1YXBrTe4biH4sRfUZCpsvam75b25LEhu2fXhZHhYFfqfqkvC+vbF1Ud2jQXRhDbD
         9F7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4ifEzx+GVw7c+8heA6ZcYCEvsqVFsJlHE7pDL7Fen2kVGIa0C/irzPDPncJX5LrbV10marxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4cmqHIsX027PK4iIpp0LFCzDqCdnHt9GmWoan8bn7mSWs6oB
	rZIO3EELhWleJMfaMGYhfjMpA/kAC4XBTOEegG/u5hSAccMjoGNV6Jord5SnSFFAnIk=
X-Gm-Gg: ASbGncvqaWZELo2B/U2JtnLt/RW3eee5jlcfQjhIwmUv3kjyxNuvZC5LFYbZYRMfIlu
	/J2e9IhCLFHK7AhIIkDYu/KOTsYlWqMTXe3ca0gONGJnhkxoe9Y+3FueDhmAIFLBZWpdXbtf73t
	mvqpMY+vZgGRcT8NRv4yTAurn2UhiKbXFA98WX4ciQErpTC8jyeOC6JbkTSBw6MVY0vNsZMvKyd
	QS5XSUXXEO69IlFe5U3sX58N6Aj/kO0tShN74wM/jdKFcLopda+fbwpE9gNjqHsaksPYrM2tVzD
	IMlSuPIq8BD5snThKQeTct4uBYwfan3e4AUukZ2UGzo3DrVwOfv7iFwfh8H38NTyyFt7Gr+4xC7
	NUAP3gFayEda+Iox8TgPYDpR8do9L3uOXPcj7HDE=
X-Google-Smtp-Source: AGHT+IGi/Y5nLA2PoK1TaePxqFlL2ANRSv5muWu2Sb5N/q0pF0WOFl5Ds55Wa5CFerfYES8wWsIlhg==
X-Received: by 2002:a05:622a:a19:b0:4a7:23a3:c562 with SMTP id d75a77b69052e-4a7f2ef862cmr168223571cf.22.1751061336860;
        Fri, 27 Jun 2025 14:55:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc105a86sm19633201cf.11.2025.06.27.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 14:55:36 -0700 (PDT)
Date: Fri, 27 Jun 2025 14:55:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@openvswitch.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Ilya
 Maximets <i.maximets@ovn.org>, =?UTF-8?B?QWRyacOhbg==?= Moreno
 <amorenoz@redhat.com>, Mike Pattrick <mpattric@redhat.com>, Florian
 Westphal <fw@strlen.de>, John Fastabend <john.fastabend@gmail.com>, Jakub
 Sitnicki <jakub@cloudflare.com>, Joe Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
Message-ID: <20250627145532.500a3ae3@hermes.local>
In-Reply-To: <20250627210054.114417-1-aconole@redhat.com>
References: <20250627210054.114417-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 17:00:54 -0400
Aaron Conole <aconole@redhat.com> wrote:

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 429fb34b075e..f43f905b1cb0 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
>  #endif
>  
>  struct inet_hashinfo tcp_hashinfo;
> +EXPORT_SYMBOL(tcp_hashinfo);

EXPORT_SYMBOL_GPL seems better here

