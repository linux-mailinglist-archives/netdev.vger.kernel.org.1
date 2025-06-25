Return-Path: <netdev+bounces-201033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02FAE7E86
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63267AD812
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4529B21D;
	Wed, 25 Jun 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai2gFx90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AE29ACC6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845969; cv=none; b=rzWWk/Wm7oVU9z2csxcdWnoZsh//0ovwi71xaR5K7rZLBBKavcfYRD3JQ/95mYxo+KQxhbJKwpD0uZ7ZDD8MA3pFmfTFXQSc3dNGJMjdhVqGlXcsLlh/3YPKq/2pxe0GJb9r2rofjUg9ZQiA2nDDyS62sV6oZAKhWusyNlmW134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845969; c=relaxed/simple;
	bh=IwnrghPY6WQH/6xZ5SO6WEcd9uqWXCfK8OQzBuTBSMQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lkBpzD1Dc+DHzwdoTG9XPa22nmK+ZtmyYWfmD6wUkUPoFKzFLKyk2eVCJAD4/KgUkEry+GBYLiURmA7ORBsFkpEMOK9yUKhvmYCTb5RfUsqk/g3Zy/70dP82i4X09zwy+K4S1lg3/5wQLKrXxOIi67yrTF2/dbOos5xfbElGuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai2gFx90; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so5354730f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845966; x=1751450766; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwnrghPY6WQH/6xZ5SO6WEcd9uqWXCfK8OQzBuTBSMQ=;
        b=ai2gFx90rd0/Zbo/1COTb5rHoKDQBkkNRm6fpVP5IY+5IuQPI/hubfWkkbQN9WBvxe
         M3or1Hrq/UoPqZPpax46smbIPOc5NosiIWMvxGKpcdAmfnu/R8dxaANm88u4miv0V2ll
         2nEqXFkYImWxYIvWd+EPhV5zQEngKHJ0hy2PGKMoSsgcTsOKOXvjzyRNcLaYqUUl42uB
         6CWBsehMyZLo8oLvsxzEAlZYD69G79ZFVpSbtSgXcrRcdXKbe3LJtbDJO5Wci6ph+B2I
         XAcPKLjHT/YOwJbvEM9Oz9uk/2pQ5ahpBLD6ZY72cdfvE9FERRNtKqxX5F0Lao1iQeQN
         2oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845966; x=1751450766;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwnrghPY6WQH/6xZ5SO6WEcd9uqWXCfK8OQzBuTBSMQ=;
        b=LACCNVK+As6vq0uX8TN2mnIe0qqF8pTg+LnZobyukSUm2UQnIX2/GS7sFSLuZ0vgYb
         B12XuqCLO/jcqu7JGSaI5sB+aDJTH5KDW0YO3ULQSQbCq5P9CQKqpHb1TT7I8O0yzJ+O
         48+rBSxH54m1ozVDjcbYpRSUux0+UtR2Rqn9miJgCtxwByYyVKW21GYpwhlaZr3EYhG0
         EJzJy5OYEDbZE8U84FfJAQ1Q9+v2Uwb98BRfe/R9a0w2rlufL3lxiXm2XsbQk6ERPblo
         7PhzFr/LRkww6YAk9MxbF70M8xdDVcYSRyVjbBTXNKqoH4f3K9slEVM3PqQoMZFNGomN
         9Yvg==
X-Forwarded-Encrypted: i=1; AJvYcCVisDC680zcGEW7B7SAr+m/01r1j14vfSKMJWfCRyu7J7WBzTRTdTsJWsJqh1N+0Dv92g4slbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkUtekkSpTnIY7mD0+owxC0MVPh+vs3X9hB6+z6hoNzyqW/SP
	bS413xlar71+94T1NwWlLch6nzKhda2+yjMopaeiFWGokVLoVaaqRSxF
X-Gm-Gg: ASbGncs+8m0T0gS56cJiDfLPDAVSl04jNZcXVvH5fzzDOZvCaC3zB2uvRN9FXhRydph
	tp02TVyfozL/kHh63d98fZa+LK1gU+5+rfNbFfEHOjdaUXzzd4P+gb4VacGgRr/Vpu9ZrTdf/1b
	9dnuUaTL66itcIcZaMsPNpxDuEBvS/QkVbBzScIuI1kF3pgnljJFgEezyaLxBSNfLpg7uWMK6PZ
	pTrvBQ6PUrunM+sWmdeJwCReAVjSIi9RSNMbICNGSdAulnxaNRHGyn5Zlt91QaU8PoByIWedB1m
	SOt5iO+GbqKLtotAfoxQ9VnQbPuAAE38eFyC0VVU39wGNu88JeI0S+JmSvkfm4oGar60y4h8f3Y
	=
X-Google-Smtp-Source: AGHT+IEgggrsjfKh39UMJfTn0PktoRO8A2rracknK/vgaDiMl5/Bu/mQiEY8ysO/61cVaI5/HMxHBA==
X-Received: by 2002:a5d:6f17:0:b0:3a4:f7df:baf5 with SMTP id ffacd0b85a97d-3a6ed56fdc5mr1975038f8f.0.1750845966153;
        Wed, 25 Jun 2025 03:06:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f22efsm4138319f8f.46.2025.06.25.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:05 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me
Subject: Re: [PATCH net 02/10] netlink: specs: fou: replace underscores with
 dashes in names
In-Reply-To: <20250624211002.3475021-3-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:51:02 +0100
Message-ID: <m2jz50cfp5.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 4eb77b4ecd3c ("netlink: add a proto specification for FOU")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

