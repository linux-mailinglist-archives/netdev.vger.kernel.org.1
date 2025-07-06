Return-Path: <netdev+bounces-204423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9CAFA5FA
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B8C189B80D
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F82139C9;
	Sun,  6 Jul 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaEfWGV2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796D2882DB
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813167; cv=none; b=GXPZlmSbFcf9YM3sCN89qGhWaRJDf4cXBmvT5GMkg6AF0tt/CSnuQj/QbFvDPHyNzJlltC7I8J8gbAzhlbXxWs6rmYoAs0/eX+Wm8/1jqIK0SN5NVUj+f0xZGqYMOjZTjUJbeS8CVv9Og8qX5yJrz5Do2xC2OZXdwKq6F4ZXMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813167; c=relaxed/simple;
	bh=NRX6TsY0R5HiN7UVAWH0kXCVFWR79iPR/kTuNj+e1Rk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DGNYrXzgkVkCjCfFndrGtpnJRLe7GJxMe1TMo1TUy/SnqI/7QwmgbGzhGmwHfcmLGyFgk0AfRerV9joEQUWJ517waLm/Gh3SKIimPRqRyFr4k3I+/WpmoIiAxkyzmvRHbMP3YkWQxws1u3P0jBaflyNwioNNNRZ0hUCn4jLOAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaEfWGV2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso1638723276.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751813165; x=1752417965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH+ftoszW+cuzTrAChdteAPbIklO9o/nfCQo4V534sI=;
        b=RaEfWGV2Ju1aL54cfuBPSYGov+IVQLTwhUktVygcdeOmsaJLVPJLofwd3yM6QIJ9Iw
         elzjzbMne0z2EjnNLcbrH7yGm6NLSy/AOvLyTMrwZQuz5KHEOdO7jHAbzwTxn7BPo88h
         YEtqy7hnIey4U1rUaTnb0+1UG3kg2o04/+r/bpE0E1wy9vDGIEg6oqkLFfwRRhNP5WF1
         nkjs+qwsB9ylakChL/3eHDj0OedV3AzTCmQyYHpmw+XLXH5kPEJBVnOrMR/lFCkEPbM1
         Bz/XKnelHvPfO7V0xIt+ORCyyncpwXUOFv2/IJ80T7IZrUfiOqftxZ6Hwz1kl/iMpqzZ
         Vhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751813165; x=1752417965;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gH+ftoszW+cuzTrAChdteAPbIklO9o/nfCQo4V534sI=;
        b=wQKPJS2qa288AIPy06YWWqTACVzV+VnU5Qt37IOn+Z+/pZZvJvHhjC1Dui6b61xZCg
         fq4sX4adMWMsvR7ZEgQYHxUAaCS+nbycwz03MVHPFrEG02nwv36EaAI/2HVTibJThSM9
         AL7hv6VVG0xCnd73N6mPpNTEshqoHtwkga7gek9sFhkhPOfofQsJgJrMAAAXkmbLDtEn
         mzDZuGZeg/E37Z5WZYKDIqZyqXcvUO96feJKX72vAGX+5BRCZHaLR3MGHNLp0XAAIAjf
         y0O4/TX0rzHIpTnx9klANQvfs1PFJCD1URiIZkJEQZBLIX8bLVfyImwos8jTJF/yTZEM
         Szzw==
X-Forwarded-Encrypted: i=1; AJvYcCUo2C6rk6657XHv6n5sjZDWCOhNeY7wivWAhtucrZhePKhSsEakSuABAE38AmbCm9dylN81ELA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXK08Yy8maGedRq1kZsoEVQabLIIhvs8kHbhdX76SVmqVj3dB
	QzHhdi4SWfMVYiCfzoN2+LNbVmh5KG6b82y3PyGG3HA1bKmC4tv85Tud
X-Gm-Gg: ASbGnctHoLDxWDC78c5ws2zRv6hDg8Iuf/3nOsxMXDRjQ+xygcXtA/DSsg6JSUMuRE5
	5DC6WhnkcH1PnJn/W/8O7ySyIJyyqR+XgbPnjA2PzaToDmaduvKig0BkgqWH0nFzr2bIVsv/cJ0
	8v+EzCeHwRkIgjTaRPlPqBueS4VboQuMRJy9G2SQ415bKV8Q8U4JwkyjKcpRe0JcTySDQATocjw
	sD7IH84ZCQ1WO6FM7DOg4yS5IgzZQzS8XOx4OHrN9xzRIu6YqfCQNX1snl83EtMr0yTGXxYkrAt
	OIAK4UNC0vTuq55/M39SMVJvi7pF/j3xGd3CWN6FKQu3qMrlchXfgUOFjLPAdPnwEuZ1zrSn1eS
	8cdc1d5/a0/Ulmjod/K/bHavXllOCx3anK/dn0Vc=
X-Google-Smtp-Source: AGHT+IFwp31m1fKLMssfZmpus5q+D3YlEXy5lKEF41cNlcYDqZOoLirqagiN5e/3KxX2hQhuEh9LUQ==
X-Received: by 2002:a05:690c:7483:b0:70e:142d:9c4e with SMTP id 00721157ae682-7166b699b0emr117101467b3.26.1751813164955;
        Sun, 06 Jul 2025 07:46:04 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-716659a160asm12458657b3.42.2025.07.06.07.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:46:04 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:46:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686a8c2be2ed8_3ad0f329423@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-2-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-2-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 01/19] psp: add documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add documentation of things which belong in the docs rather
> than commit messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Very clear and detailed documentation, thanks!

