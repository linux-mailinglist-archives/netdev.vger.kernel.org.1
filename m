Return-Path: <netdev+bounces-244466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC7CB839C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0F98302218E
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2829D28B;
	Fri, 12 Dec 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DEeIdzzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244E7262D
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527548; cv=none; b=VM0peJAz68uAl87QVuEsYWgvLQJPBWM2uM0FGz9wqm6vd6PIm3xO5y8y+K/S3ghJsCwurm1RSXfo4Fp1yvzbkwGI6k/GNpf3MM2qDQeu9GUVE82qylr8QSfPYXQvzeURYesM9vLtEpgSGpVDgvXIQP88TuQ66HiNO6qelxD7ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527548; c=relaxed/simple;
	bh=fmJI4/5TmXpT6DXotL65l1JNJDy2I/Z3+PjBjW5FkF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuDxuQZkHnFiFtQzuJV79VMCiQqylxXc8mmQpY1SH2VOda+Hr30klIIjA1rHl35S3Ngv2QNHVmYxGbztRLhznz1xDTH6hc0cTJq7Wi6+mSbWPSBwyEH+V26oI2085dzd8DdLUGMPerCh6pl4AMrCXBRk6oH6ncbohIP7qDuHrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DEeIdzzn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297d4ac44fbso4844715ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765527545; x=1766132345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtnpkCxVaDsH6BE62saGRGgY6S36MDYns0SM3Wt7w1c=;
        b=DEeIdzznqu3NuGIiVQlm0w79GTONcxAg1ws57kpu+34uOgJGbcR+QMfgS3UqUoiD2Q
         +aM6pGfzaMcwdzjCbcbEGrzs1nVfig9rmtH9rUwuu6PauLodIjH7P3f6hDDOfCCGUPEZ
         iM8yDS7/LMs0nQtBUz74zV9gDoRhzSEhHv2CxuzHoKeE1ao5dBzkggxuCvF114vXY0Qx
         KRl5+ElmzaWQXDRZ0a0epzcDdSuyZa00Xz7rQhFSg+IRAgqOPU2a9xyDtVHX2XCf6RbW
         TqiLkrwPM6t1wMaS4zYEswUJ/S5M7YpL4H/UmxawTyoUJiV7nDREArXaZZSTh4rw6rQF
         qcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765527545; x=1766132345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtnpkCxVaDsH6BE62saGRGgY6S36MDYns0SM3Wt7w1c=;
        b=Xn1aqiOIv++vK1btQlerR2RAYS2hmVYH613zKb5I0nORdTevic+1Bzij1Lu+0iM5Ku
         Td8kUbAqq+gmT4Z1yUuxCCPtE6qBj5l1fbUGXxO/mANYeDafN4tje4MgK5Cmd99g9Ezn
         eRSnc5YPEpeFEglTa8QC6ORzn9blpUgnatAX+CzJGVizSeVgOJ7i1C8jKT+O7s1pssZR
         A+BLIn3DZMhaN2DzUDvXGRCE0e4p5fHe20RFeFQkZDlfFg3Fm7i1mqQWKkGkIoD5fE05
         GWYuMxUOQNL8rs+v58jt4kD5WzC+qSxNTm2cenQRhRG4aafsMPW0e81oIdRk26xQNJ+V
         geag==
X-Forwarded-Encrypted: i=1; AJvYcCWTDAE330zT2i80mJlFTD7Cu2o/CoujhtO2CNtxNcRj3A2sTrdcyVHOywoqM15ydM/DiU4dJWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSbNDNfkqP+NrFR232JAAwE6JULG0hZn0JTgjQXw9LdmlgugI
	uIDXDs+kaj24NCy0LHU1lmCwM5KOVB0jLiL6mKTEHY6C2rpExrxFW5QErGtwG97f7dY=
X-Gm-Gg: AY/fxX4EfmfIobj+yZHijZnwXNAis6YQeqfZmqEKiOrY42nFG+isjPedniYV0hukyiK
	c5c0XFjUcpk0IpwgGNl1yeB/6I1TbX7ckfmYkQZsgXNytn73FUUsxYpPwGKrL2pwfhH66o6kTJL
	HraUXwn7O03q1VMtL62OCelsnSmIzArJ2g7RzjF+CbfXWolfhAtd7ndg0zSQR2XFoEvCMvGej+M
	eTDiAqCtAKwepdNPX/UN3pJ8+563p63hpxxUdXZhAeIEN3QOMu210Dn6xkjJSEnAmhL6uPieO+E
	Il3FvYxBj7TaWS4Z1ts+/kgfiRtYgL+Ctl+y8hvWZyjf28ldUQSzaV4TAbdBHvo5aJ6cwp6qNBW
	qQnm5css5HpC0xDBhvl4Xu3hGTIfhSgHw79OtvqNtzmufoq0dW2zQVp4iGpEgnPTzLI3DR2Fyzx
	YwvBp7pPinIvEjh+++iuStAp5+iNGTq/tECUC14iF6y3DoMiOfKkKOHQbZ+hs=
X-Google-Smtp-Source: AGHT+IHKhlQJ2f8pTlCd5r5am05ne32vxFIFuQUfaWncYQBi0oCEVvx5+ICIXVQaR/19b05sUr0xFA==
X-Received: by 2002:a17:903:32c1:b0:29d:67f8:38b5 with SMTP id d9443c01a7336-29eee9f2bf1mr54666315ad.3.1765527544720;
        Fri, 12 Dec 2025 00:19:04 -0800 (PST)
Received: from stephen-xps.local (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b374a9sm47201425ad.11.2025.12.12.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:19:04 -0800 (PST)
Date: Fri, 12 Dec 2025 17:18:56 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manas Ghandat <ghandatmanas@gmail.com>
Cc: xiyou.wangcong@gmail.com, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: net/sched: Fix divide error in tabledist
Message-ID: <20251212171856.37cfb4dd@stephen-xps.local>
In-Reply-To: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
References: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2025 23:36:32 +0530
Manas Ghandat <ghandatmanas@gmail.com> wrote:

> Previously, a duplication check was added to ensure that a
> duplicating netem cannot exist in a tree with other netems. When
> check_netem_in_tree() fails after parameter updates, the qdisc
> structure is left in an inconsistent state with some new values
> applied but duplicate not updated. Move the tree validation check
> before modifying any qdisc parameters
> Fixes: ec8e0e3d7ade ("net/sched: Restrict conditions for adding 
> duplicating netems to qdisc tree")
> Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
> net/sched/sch_netem.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 32a5f3304046..1a2b498ada83 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -1055,6 +1055,11 @@ static int netem_change(struct Qdisc *sch, struct 
> nlattr *opt,
> q->loss_model = CLG_RANDOM;
> }
> + ret = check_netem_in_tree(sch, qopt->duplicate, extack);
> + if (ret)
> + goto unlock;
> + q->duplicate = qopt->duplicate;
> +
> if (delay_dist)
> swap(q->delay_dist, delay_dist);
> if (slot_dist)
> @@ -1068,12 +1073,6 @@ static int netem_change(struct Qdisc *sch, struct 
> nlattr *opt,
> q->counter = 0;
> q->loss = qopt->loss;
> - ret = check_netem_in_tree(sch, qopt->duplicate, extack);
> - if (ret)
> - goto unlock;
> -
> - q->duplicate = qopt->duplicate;
> -
> /* for compatibility with earlier versions.
> * if gap is set, need to assume 100% probability
> */

Agree the netem_in_tree error path is incorrect.
The whole netem_in_tree check is problematic as well.

Your mail system is corrupting the patch. The whitespace is messed up.
Is this the same as earlier patch


