Return-Path: <netdev+bounces-202050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A9AEC1BE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C041C44B39
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E92EE266;
	Fri, 27 Jun 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqkrPAKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E52EAD19
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058564; cv=none; b=ub7S6iJGka1WsrOzk8v5cwIbo0euZhtfLxhwZX1iC29OUsbqiaWfeTutjhPYRGQazkW/uu4dgpCcYLLsZj1xKaUtVFTpeFmTevH/OLtjXwRyRxGZZr2NZ3WLTKTtP3yL6gap6g94otwd5MlQ9z7Cy9eoaEWEIS0iaO/68Z8H88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058564; c=relaxed/simple;
	bh=mOvayeUfMyeZOw9fmCMRnv3U3DWoZRY1SWGX9EqaxEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNDWTy7aH0akGu5CMJsdHyVd22RsTc5GDGpE1XH5NZXjZlXUQXr91z7DqfbWjylMnd9DeaZ7UguN9JmObGmxwWUd888jep3rgt6/gxbLz+p63mFr4FAYduiOSV8Yc2ptsrrVB6cRK7jdqCvBmAe3gTXxfC/v7lJi0k9rXbn9Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqkrPAKm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2350fc2591dso22630445ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751058562; x=1751663362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOvayeUfMyeZOw9fmCMRnv3U3DWoZRY1SWGX9EqaxEg=;
        b=mqkrPAKmQRaT3hPKN1ecu6bv68rqM6+JjOOsfHJkRUBExtMAqlA2v0LkLV+38yRuOx
         FEkTq5Ua2RvrFfTyHj7JCkMU9Rb8MdjmOu5o+9uOIeDypK/PF71UYJUFyaUPkoWptN4g
         TcvOTjLghUYmloUXg/7KQq38b/Nzj8qdW0fX+aGDONePR/4l/ktzMsoNc4x0zl3KKTMa
         S6ebQ4gKSneDYbvINcdW1QBuTxmCGZkX2fko3GrtBUzWEjXksohRBmd9Mj5UcQxdWJMZ
         4HkbOmBlK3ahNNuprlKaFH1ZBn79sEtutQB3s56I/tOyE/1LRqlhZ9IRBBooLSK+vWwa
         c+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751058562; x=1751663362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOvayeUfMyeZOw9fmCMRnv3U3DWoZRY1SWGX9EqaxEg=;
        b=R7Lsk2uZwFOFoF+VN2g7hlCnrltz6hgeLVHKfiYbQuvwOyvPEan++yQ+cG/Z2M7sBH
         CBs74HFIqmXaOl52puxzunodBNDMbh45T3gghikGdNvCWg7f1E8CoN5+njnxPfADEzBq
         eeftnkEpUNq6TakjK6awqBXDugeohFwONhSsXGK01DqdK+FkTJZl1zrrbQdFLmvZmlNi
         ZMQa6zUkHk5kGJBWVBtzHDoTeh+gPcP/VXtHaymgec93earge/wbc4AZ4i/BbuQgIl2h
         +f4znxuq8BmkTsRWoP99qnw+joKfkmi0hsC5JuHKKGbS6fMwTsL1QnWPq3DP1fUE2rwc
         aV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgi7MXBA7WV6pjEmyr37im5VgxXHhqE0HbSFN4N9fOkw6qVUQw/oJiMvPfCV/Cc99kAopM1ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzvrAPB2M1GmXPSilSRg73OxxAoTWNNlJB960QXbWNWy1mmsV
	Q7vjyfMWglJw7Akny9XCN7GklBX0KlcAYbPD9Rlgmt6GrOW/RJHE4d7Lf10QJJa02s6DNfop8pR
	3sNKrgAc/r/w+I91HCJtaxqWC4hNXbQabwW+M3K36
X-Gm-Gg: ASbGncuIEm/T8UueQZ+2HHR6eQBT5FYj2DjYGDVUyKrS340eMKFZmm3CqV0EfoQWKuX
	pDyRU/X6X7Kb9I9k7lxH72BS9RKcx9Bzp58kNcHExXBnl+1oFZdeuq3/MyKwLWladwYeabYRI/s
	ywsLuCuDyiZg/EGIiAc0F4RKTIf/y22HN552zrxbnQiiGW++nFa/eFR2XyZNJvXVaU/8A+LQZhU
	IPs
X-Google-Smtp-Source: AGHT+IFqUu5UveGJbNDHpzCuf5rVTyhR87P6QChLeLZOdMlN0fsn7OWJSpLBS29bN5TwbxfhBQSZtsX01czjuwVWR0s=
X-Received: by 2002:a17:902:db02:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2390a4a883dmr136317875ad.16.1751058562276; Fri, 27 Jun 2025
 14:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-11-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-11-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:09:10 -0700
X-Gm-Features: Ac12FXy9OPwfp9lR4Oj3f_ks1jPe8jrweEps_fzHIgj5vH3H-LXLuUL69KVZm8Y
Message-ID: <CAAVpQUBqsB7Pb36HV2AFKyrUOJFwYKMjsBEHxvreps-oseFXaA@mail.gmail.com>
Subject: Re: [PATCH net-next 10/10] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Both functions are always called under RCU.
>
> We remove the extra rcu_read_lock()/rcu_read_unlock().
>
> We use skb_dst_dev_net_rcu() instead of skb_dst_dev_net().
>
> We use dev_net_rcu() instead of dev_net().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you Eric for this series :)

