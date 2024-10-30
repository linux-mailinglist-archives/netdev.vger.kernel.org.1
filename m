Return-Path: <netdev+bounces-140452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D438B9B68BF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1210E1C218E0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0701F4700;
	Wed, 30 Oct 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2g94pwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055D36126;
	Wed, 30 Oct 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304076; cv=none; b=NOQB9/lYhlUYnfiZ1oV0m+KMXIVhp2kpNgaRxVEYvPtRCa6Fqy9JEVrX7CkfFwzC/L0hculcljY3smKKlRaU4ZCJyC9SKxlF9JJuyPYjw7mcWk9IyMXHHmKJZ2vhRLrTuLokyk+SGeIE2PaTCO6Ap82oT3ZrgqQdjA1NS/hRl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304076; c=relaxed/simple;
	bh=zxSt/cKFcoAWpo+73TfuR/yadVCk9iMi3er6GwJJT5A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qJ2heE5KM1uU1YHfj6lVR+AAyOCmgT4W4XcH+QUl4XN7CZB7v4i/1mIyvgsrcdo3aCWU6af0hQMKbMYIuyj6YE8IFKZDb3NfcjLO9iZ95LHtyVSA78Klg9bcrVQmYyhdnhRshTOs+nOuyx5q8OU5ek9GCFhJ6NSc8EL4bl6MrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2g94pwP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43159c9f617so63321805e9.2;
        Wed, 30 Oct 2024 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304073; x=1730908873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8OJQ24DPV4G1yn5B7zxNeki92edP5+Wx7P/c1L2gO6M=;
        b=P2g94pwPFsQF9XW1Xn549XXEZ8f1H4Kv/ZqI2zZngv7WjU+2AJQYaHHxsUqwLUJVFK
         82rowLiCZWNQO69HLfo3689obCY57aeZ/Oxaa+35dUoTOQJSQ6FtOaH/2+4a/A0uhlf3
         OcZbBnh9ttTDDwQlqQqm1JdPkNcUbZGH/WKwT8QQ6y7JjQu7Tl+q31SrmeZwye6k2tu/
         uUIYx36W3bkswohjU/P2e2ogO7MeSj32bed920MG5jdrM2CSdxh6MEygptGbKCvpkiaL
         DZ02VOLX22h3ZN4iMVJIuQIh2D09nqJ+WdA5yWDQV5d3c8FmHBhXVKcAxPIcp5rvLWRW
         hrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304073; x=1730908873;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OJQ24DPV4G1yn5B7zxNeki92edP5+Wx7P/c1L2gO6M=;
        b=l8tG0QZpLcrYbHS+AdlSs1vGV6D82uU+wJbjgi8aNmUC1dRtQh/Y2hvNHhB8dH5rsZ
         ecNGQpM4yJq5GnuLKbdwXjhio+ys7i4xG7OspegsoWTNKlhOJ/kLrjHoZKL1vpsaoXpa
         X1WoDypk/vEEQ3QKD211qk26tx7IdL/BgJSaObVah0F8LpPZOL0qnZOyEjwNVgR8f+aD
         JNhM1DdBVhyFylNJqFJCkNpkkX4uQYepoMEEvUFkAPRoIl5dWIYg9Bv62UkQUrWcN0Fv
         gXepXGlnX8om7RcIQH9klAk+v+Q83VgTbWjMCdnIB6f8QFzLZ6EC9E7UKnX3BEaWKU+f
         ychg==
X-Forwarded-Encrypted: i=1; AJvYcCVDohRVJnCIH1MRzr/vMmKfgO4UZzAxe36IZgDzOSUXLNBm6AEymyaKRy8ejXY9uVdhhhQL5/3owA/QyKs=@vger.kernel.org, AJvYcCW5+646OKePAtHTMHIxE9ebZb6RQKTQci2ZrBnbh1qY7K4SqFd4/v/8bAl+cPV8d2WFQpzcbmjz@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5rCqW0ojRsKxPpWRcWbtRcNVkW7/Z23XCZJUycPkWuYs6M+J
	XoHh1tK+ZlenVBtLLKXtXHefDaKDr6plPOOpCYz9B/VdRhgxfT6x
X-Google-Smtp-Source: AGHT+IHxh2nE6c3Hr7lmx5tE2SKF5626IT4Q+yXSUh0H84G7Mh5lChvyrTVjCjQ+//VF7d9p7QA2/Q==
X-Received: by 2002:a05:600c:511c:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-4319ad24423mr137434895e9.30.1730304072471;
        Wed, 30 Oct 2024 09:01:12 -0700 (PDT)
Received: from [127.0.0.1] (217-175-223-26.dyn-pool.spidernet.net. [217.175.223.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd74f132sm26045035e9.0.2024.10.30.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:01:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:01:07 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
CC: ruanjinjie@huawei.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_v2=5D_net=3A_wwan=3A_t7xx=3A_Fix_off?=
 =?US-ASCII?Q?-by-one_error_in_t7xx=5Fdpmaif=5Frx=5Fbuf=5Falloc=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241029125600.3036659-1-ruanjinjie@huawei.com>
References: <20241029125600.3036659-1-ruanjinjie@huawei.com>
Message-ID: <F9E73DD2-B898-440D-B35D-B6B10B8BC0E9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 29, 2024 2:56:00 PM, Jinjie Ruan <ruanjinjie@huawei=2Ecom> wrote=
:
>The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
>allocated and mapped skb in a loop, but the loop condition terminates whe=
n
>the index reaches zero, which fails to free the first allocated skb at
>index zero=2E
>
>Check for >=3D 0 so that skb at index 0 is freed as well=2E
>
>Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
>Suggested-by: Sergey Ryazanov <ryazanov=2Es=2Ea@gmail=2Ecom>
>Signed-off-by: Jinjie Ruan <ruanjinjie@huawei=2Ecom>

Jakub, when applying, could you drop that suggested-by tag, please=2E My c=
ontribution was only a small suggestion to avoid an endless loop=2E In all =
other meanings this patch is original work made by Jinjie, and all creds sh=
ould go to him=2E

Besides that tag:

Acked-by: Sergey Ryazanov <ryazanov=2Es=2Ea@gmail=2Ecom>

>---
>v2:
>- Update the commit title=2E
>- Declare i as signed to avoid the endless loop=2E
>---
> drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec b/drivers/net/w=
wan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>index 210d84c67ef9=2E=2E45e7833965b1 100644
>--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>@@ -166,8 +166,8 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpma=
if_ctrl,
> 			     const unsigned int q_num, const unsigned int buf_cnt,
> 			     const bool initial)
> {
>-	unsigned int i, bat_cnt, bat_max_cnt, bat_start_idx;
>-	int ret;
>+	unsigned int bat_cnt, bat_max_cnt, bat_start_idx;
>+	int ret, i;
>=20
> 	if (!buf_cnt || buf_cnt > bat_req->bat_size_cnt)
> 		return -EINVAL;
>@@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpma=
if_ctrl,
> 	return 0;
>=20
> err_unmap_skbs:
>-	while (--i > 0)
>+	while (--i >=3D 0)
> 		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
>=20
> 	return ret;


