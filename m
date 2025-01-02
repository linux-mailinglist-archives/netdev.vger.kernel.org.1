Return-Path: <netdev+bounces-154828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B19FFEB0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694CB18806D5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA201B218C;
	Thu,  2 Jan 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05VvvzlB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420019340B
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843416; cv=none; b=KhAVVCFy0Lsumz40JFIX1RQB+09ANqnvlku943hGdzW29LSlYSM7r2wJvuWCSBbU17c+rpPLtw2JJXBhd0vwCpfDWvCwUFWFFLBiXbxrKFvQ+3iMLL6/v4y7ZmsLgu2iDdn6wr2j3y6NjikX/FfsUo9JDin2vDdAlh85I56xgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843416; c=relaxed/simple;
	bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAry/OObeM8Pw9SpmOrpCOAXK3Dn1x1xT6BHYvxGhjxJD5qT6Mpibz8FXrJ/emE5XCnlBqdw7Rqia684BnqwlgFgiF4nxvowQ/s18DtO+TxqAIGuE2bcjzQZojp6mJujHe4jxG+ngo5WkAC9aUzMOe5tiGtqqClIV0VKJ9lGbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05VvvzlB; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d92cd1e811so107550866d6.1
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735843413; x=1736448213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=05VvvzlBImTVfWoF+IKInLEEpnshPPdwh8HxISJVnMz5jnOEdW+MgcPXiT7Fwqg+Ct
         dE48JYCjKkhtGWBvZudc+yAuUP3z+MuiYePm/N1nIkf5QLBmaQwmD9Emx878y5QITGtn
         XgSqXGsheeNLvty627Cc4Chz0nAups9jbzcgZAOvdL0WDSIhOy97pJ785EO7IA0onxP6
         8kWaLnpTaZjb5cBjbNufhkCBJp4m8DTdXW1GhYB9i14D/nErYthIw6shB0shxR8s/dPO
         fy2WYD7vYSpgtbIqO7v3eQi5inA39UGwL+YP26sYuFvgqQrrA5VeOkYIGSB3bpTmEPQH
         Av6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735843413; x=1736448213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=mZqB4QFkrlBHC6DBP5NLc8IBbrgWgRzFxQ98pJ3vHPhr5mFxl6Cwq9gby967Sfv0lH
         1GBaEN9XM7PeNH9CGD2pQeUC+7wLCfIcvs15+bFniGloZpWVvz3j66XTjszKoD+4zJ5L
         LBknPP48//oV6u6HVWaoluK/u+b1x2uTdUSOGfxSCfZ7pofMob2sJ204Zh3/XLaNd9Vh
         iMzLyA9sCuduAZdn4McekdDBNQpLeNACpwS7tTQgb7EGfgITht0lCEi45/EyTTovVHun
         zi+BihwjzhFN9U+IaXoynjl2zkBZ7Xj2wLge4g7JPV1hvQN/++wZv7JLsyskpcINzgYm
         Quow==
X-Forwarded-Encrypted: i=1; AJvYcCXpuii4kekfVe+YMptwqfvoHOE7Reqy99Cobcs7sA4EYf2BqvvtgUUvge42ZoiQqggGvbz501k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/VxcGFuk+Hd4ByF9N/xCQTGe3pRZfCnr6EVKjLJkleZOle7x
	YfQa84HpoJRQ3ZUjxqyKbnFPH5gghHUVOyzAyDwbtMfvaFntpgTKrXJ3MfWQhnQK+RbuGBvuoFS
	uzFeif901ZDptkASDlH8J57fhnXZBT2ZiMZ62
X-Gm-Gg: ASbGncs/ddJTeSO0plw5z1xQBct/Nrhv3unZwQZlmBKXlaH6mkY6JW/VwvxHTi+FZyp
	rqQlxjlZjEqYqStydB9ujSoLq86wIT1cHSciu
X-Google-Smtp-Source: AGHT+IF2tZXZGzK4SR62kPfJyDlYZjAffFvMlSMw7+NG+gQt+geLbrrGjOcGHqDzqV0Ly6l7e8fT7ZNqEBaPAWkEaVw=
X-Received: by 2002:a05:6214:5bc7:b0:6d8:8a0b:db25 with SMTP id
 6a1803df08f44-6dd23618b5bmr751231406d6.21.1735843413422; Thu, 02 Jan 2025
 10:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
 <20241218133415.3759501-3-pkaligineedi@google.com> <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
In-Reply-To: <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 2 Jan 2025 10:43:21 -0800
X-Gm-Features: AbW1kvYJhRQu9jWJ1-H0lGB_jEU0IWP-wY0jRAO_aZNMsIq7HMjjdk9-3POyjeg
Message-ID: <CALuQH+W3TK4Kvgbf1d+eFjR8W45_84M7T=aD0BeAdbGQdm5koQ@mail.gmail.com>
Subject: Re: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp queues
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Wouldn't synchronize_rcu() be enough, have you checked?

I based usage of synchronize_net() instead of synchronize_rcu() based on other
drivers deciding to use it due to synchronize_rcu_expedited() when holding
rtnl_lock() being more performant.

ICE: https://lore.kernel.org/all/20240529112337.3639084-4-maciej.fijalkowski@intel.com/
Mellanox: https://lore.kernel.org/netdev/20210212025641.323844-8-saeed@kernel.org/

> You need to use xdp_features_{set,clear}_redirect_target() when you
install/remove XDP prog to notify the kernel that ndo_start_xmit is now
available / not available anymore.

Thank you for the suggestion. Given that the fix has gone in, I was planning
to make this change as part of a future net-next release with other XDP changes.
Would it make sense to make those changes there, given that the patches as
they went up, while not completely correct, should at least cover the
vulnerability?

Thanks,
Josh

