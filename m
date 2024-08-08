Return-Path: <netdev+bounces-116656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014294B51E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6192839E5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F7D530;
	Thu,  8 Aug 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXEYT8Uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A049D502
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085035; cv=none; b=UcwJFzkl4Lzzm01A2gIJ/vNU0Yu5X6cGM3d6iXWMzt5U8lSzP0Xei6fhdsFFzLuACxUs/pzb4kPcW8Vo+06EHKlTs0Qg1IDhbHT2hElhiL2c052w+COir0BP/77WWbMM0mkTkpwjtePtGR5GaWDzNRqANUn2Z1N/oT+N+edyQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085035; c=relaxed/simple;
	bh=I1LCI7uB5dI5s+dJB8Eoeupe4Vx2rltEuOr1siT21Js=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ekSB6FKaudXI7vRW0VbR+GuZfb1YmVfzjXjTTblSpzzHG+tpQ7z7bATaNw23AescAkTfROWbpdWRrFFjZQNIq6lrXLrRBi3U/V5ORUXX1yfDObI8neWCXgoFzsDKcAhJRqndnpfRhwSrzRe6fklgZ32xHcC/N3xvl/9JouNbZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXEYT8Uq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-682ff2f0e67so5435907b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723085033; x=1723689833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC9s0kyqdNYIleYolRemaJKdcEyOgm4Kz5+pCnRxWgc=;
        b=aXEYT8Uq4H46xyzdzmRoSadEpsx8pZM/QWQYAij9RTxvP5sr2zm+gb/jZZcZRm+7e4
         MURy+hJ0z7GoXLJF3fYnDBIopEuog87v9khwHmNB5K1n4Mrj3/+7wOR4y/9IUh14UKy6
         cSWBwO68/qcv3qDKadzGmDxIBt8gXaRoSjrqNBrKz2UnvQg6B+pfj0BDjZflJHMGdR5Y
         lKsHsbGYqExHP0EPvQpIN1Q9NPjGIEVhIXwCR+V8zEUaiGF/rtlX33BoU7OF0773odHd
         zzofRdJGNMN7Ti8kVV/tr5rLO7ymRUezwOQPHlEJPvj84yH9YN94cCUW7Rtdn5lByjvG
         Z9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085033; x=1723689833;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yC9s0kyqdNYIleYolRemaJKdcEyOgm4Kz5+pCnRxWgc=;
        b=EoH1SrDLLddWr4aG5PPh3Oi/hQ8K633uTXjllJuEdrH140aK2ee8am9br/Dr5ry2WR
         CFTKTip3sYy+5zhF5LGYNWNhZQZlzOJAG8MDQimD0tqpce0sKrDc5SAq/giB3Crp1xNA
         1xxsGEbY6jlNslPFrjorel27zyI05Dy95o7V28p/u43rBbh4nrejAw2NZd3t16vjVrtf
         JI1z/IdRqwzUIKnvvotVifVuJKvKAAjeSE3YtLWl2dH1BKXTBouWGgbxHLH7+GMzXio7
         OB6rAb8lHDsO/aVEWnxJ5Q4oeShk+bVIm/tgbpvbIvflRIMuhQu0YS3Q3a3LRocz0SL5
         OrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP/bCWj82tNHEVvIbupNEJnL1g0yM7llNxqXdkds/xmMLRH2x9lpxp/mGWGDG3AXmtKH9iqEwdz6M/1kPK3oJB/ypmGFMH
X-Gm-Message-State: AOJu0YzW4buL3sQuk09Ycn9+Z6+T2eLSUaE3qDXd+1W/QyCI+f7qdaPR
	hZZXmJV9PVN1eipsJIkg+8NrnfT04huSTy5CKdc0CXJDGjhm62R9
X-Google-Smtp-Source: AGHT+IEw3mZ+dyVzTVfv58wQywJ6UTQNXw+vQ+wcHxMU5v5BzGDiqFXM2m/DxLADgrfwbShQFiTzug==
X-Received: by 2002:a05:690c:92:b0:64a:6eda:fc60 with SMTP id 00721157ae682-69bf71677f2mr5633937b3.4.1723085033141;
        Wed, 07 Aug 2024 19:43:53 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f4301sm114260585a.69.2024.08.07.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:43:52 -0700 (PDT)
Date: Wed, 07 Aug 2024 22:43:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <66b430e86ec85_379e4429439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-3-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
 <20240807-udp-gso-egress-from-tunnel-v3-3-8828d93c5b45@cloudflare.com>
Subject: Re: [PATCH net v3 3/3] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> After enabling UDP GSO for devices not offering checksum offload, we have
> hit a regression where a bad offload warning can be triggered when sending
> a datagram with IPv6 extension headers.
> 
> Extend the UDP GSO IPv6 tests to cover this scenario.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

(Accidentally reviewed v2 for a second time. Meant to review this)

