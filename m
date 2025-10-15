Return-Path: <netdev+bounces-229457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85536BDC983
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4673B98D5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8730214D;
	Wed, 15 Oct 2025 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpmNLQMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F324438B
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505873; cv=none; b=EzTqxZuQI0hgGAs9uD1bceH0Mp/p6P6OyhentCOCapSlF/OkTTEiBX2kkxOyvz0fU0kKCTh7qdXz+J5OIG2fzEG/NPQpafNH68JZhRnKOrxBwO9NmmTZkfnwUyFf0jTa6KVzVYGU7SRWK0VX6PIzq1fVopBWIP2o1CQ0TGfz6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505873; c=relaxed/simple;
	bh=KiIczi1SpiBWlFL/Rfu9Nh+QFskj5juUmbFcPASbzI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIwsERGSNhdebdwiFGbUR89pIQQADK/LqPHtYW3g6j6QfFQp++6fdPKHAT1pD45TzgnNNpc5arl48kZHo+uc2vtIrLMwVHwTmRBAYXeAIt5hWkOUOa6xz1hWhJCFB7NvcrEgC+1baeubk+RVSWgA7TiitqRoSh0Utj4uYTwXW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpmNLQMm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550eff972eso4090670a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760505871; x=1761110671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiIczi1SpiBWlFL/Rfu9Nh+QFskj5juUmbFcPASbzI4=;
        b=GpmNLQMmumhfTRGO2kmJRM3NMPZaloancDyni9qwo1wjfkBh+AvSG+8V+2s/UilG2Q
         GhYOG3y/XXIIVsj93RpxY+CO/F9LREzsSKEh+cinS8JzRYHVQO7HoDpg9YvmcJHtHvjp
         Z/Li55sAXtbIto1RBAcrIVJhrcvoB2P5lmJ9+ERzXk3fvc3oh0k5AXz723SfB/QCEXbI
         22qQ+zgu5YTQsrM+/Lyc7ek+pgn0mfTB2AIVB3tuL0ke+3UIsaTEJezWG9bENgh6eeDU
         1vnDEflJASiUVtp9SVIA+3NFu+6+I+BQASWaTdu4L/Uu+mfTxA0ri0JwBuMXGf0cqfEY
         GvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505871; x=1761110671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiIczi1SpiBWlFL/Rfu9Nh+QFskj5juUmbFcPASbzI4=;
        b=lBG6rpX4n3Oei0Z9n/GVD0yOhRXNRkXWD+g48hDR4Bm7+D7tyLDXX3vdDQMyMRKKhK
         OnfTCPG7sYw0DLDXFXV7Smh/379brXFALAXVOK/MkNZsBbZWo7+urk2W3mJ7JmtuzFY+
         D44W6MOU69fzSuNRvUajzL16mpEwfomJ/F6hMlejlWQjtg2+4JlIG5PfwIt0yYX1+YwS
         0Zr8Nq7csnolUggygtiFOkDe3b7O0KCQcNRrf33IeEr5/uxCDveQAFuFq5SWhEZfQ4Dm
         Qm16YKvXgOQgh4uFIVfGYlMvwYRKYaIgbhtJJ8zJrwt6bNT4qqWyk5aBKChUMzMvM8LT
         /14Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRb82EO9urMbrjPvPC1WKCyZSy59BeK6hc+P79JbmErYto3AdzMAnW7q7GAUvudXbyBdPlzHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHbG4t6qHq06By2JlTya307GdU/Bl8+3H90EqeXGZZrO+u8QB
	a+0zesDGlegyM1VPGT03Xywv9YD2xZtz8mfx69KCGyC7WQ4lA5faq5hcnkLl8bCvsdF5ta7p3x8
	Wfh8+tLsXhbYyuT2KpjJKhatNnaCumU93mJIyE4Rx
X-Gm-Gg: ASbGncujYznTKBjrhRT2efOKAlP0YQliNGMcqaKmrTfkJHGQf6EJXnklXH6NUCXgRD9
	vGoNhYv2BcILNfu5WMvFyUUxwzi0Z/rngGtQJ67O3NfSs8mT0VHYYlCWCzco+p8vNQ1PIh4fkIj
	I2/ql2+zckWP7XQKYR+6OKvftIAmsiMuvhlfgoJC40JUxtaksD0IhbrBBmyWXKMtm5QQSYBX3nB
	Xb4arFaQQQ+RtTqaSQjYcWZS4FX3nQSTSEH3WlxFnxrXEWAiXt5KynYoHPpAjl2
X-Google-Smtp-Source: AGHT+IGvkAxpinatKAt/wsOpd9LQIpLbYj+tiJBcH+kIDLEGEASgBxldzY/TA1P/4J19ghmmAGPVWwx8Ij+QTFndnJ0=
X-Received: by 2002:a17:902:f612:b0:269:8072:5be7 with SMTP id
 d9443c01a7336-29027303931mr347109785ad.56.1760505871123; Tue, 14 Oct 2025
 22:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-4-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 22:24:19 -0700
X-Gm-Features: AS18NWAHoUBmZ46w5FWpmWg52K5wMjDu0Nfe3q5aikfvI4KIhm56WnDzUrwMI-Y
Message-ID: <CAAVpQUCmQWBUM6xNhz_oznOUXJOKV8Q8h_w-oLTZnsN6OaBnXA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/6] net/sched: act_mirred: add loop detection
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursion"=
)
> added code in the fast path, even when act_mirred is not used.
>
> Prepare its revert by implementing loop detection in act_mirred.
>
> Adds an array of device pointers in struct netdev_xmit.
>
> tcf_mirred_is_act_redirect() can detect if the array
> already contains the target device.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

