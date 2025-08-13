Return-Path: <netdev+bounces-213189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B633B240D2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EE31A255C1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B542BEFF9;
	Wed, 13 Aug 2025 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQLx4lhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6A2BF007
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064553; cv=none; b=pNVu8Nhb8yHUtFGNyuh/LcohsqWEi6EXKHcG0Lh/Mj1XcadVqXe9fpq4taOXz6qbDR9s2TPjMf7yevhftXbS2U8OvKGDZX5OCOWaFpi6EFTxVqlkd2dMjJLYq/6wd/uiHoIKtXu6Bh146iTa0d6wp8Jn4BEJDGvXLTHfsTvIybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064553; c=relaxed/simple;
	bh=ZCrNgGejmOqVj4XFPaXw8CoNIHxHwb4RQH/AZeUJnCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RyutCgsseXtMIvWbAw3FK5vh3tReNQ/obtke7JMrmYFp50Qwi2IE/1T2kl0tIjc3MNPiDRe8Vbhxnz/aDTVWQHe3lU8FZwyyozpbrxJJ0dUqdKc6yhP4USbQlOTa1sj/QQ3iQEE5BYFMiE3UU0NdxuiJyBFN1Iy9ov28/r4l0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQLx4lhc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-243049e6e1dso21560145ad.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755064552; x=1755669352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BRD/FiSa0hIxPhbV2v5R9dmUKhZt4vQoKPKl+drGfw=;
        b=wQLx4lhcTlnU+/K657a4iWEN68/lz4lFvhVH9EA6IVgd9iEPZU9np6HNeHWttl9uxz
         ykKZpVNo+l0QDVcU/8LPE1ObGYph354TaIWmMxYvdkynaoRIjuEOHzbWsd0WMsXfX8Pp
         IveUDRkJ/nzhLmU5azQXhnlra/mBZAnP79sOXxx3GQm2OUXtKT5FiBcV73ODw5Tz1+vR
         ZLIyfSFgTSIdKnuFYQ1WE0B3SmtejIh0MDZKg3bNV3VmxUe1oL8LrrZD6fmMoCuGG9x2
         IybPoFlFxvSGr+az3UBuy3Sw4CFl3YHFRgNx2P7zT38LlLrIOHQvrLO+3Wc/jkBZ7tMR
         4e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064552; x=1755669352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BRD/FiSa0hIxPhbV2v5R9dmUKhZt4vQoKPKl+drGfw=;
        b=rNdEse+1Qtpt0tz8p/t80oa7tiyMmK7Koh0NZ6V6YiPDuEWcRaX1zzMSF0E1JPKOIs
         VBZ6QJywefy7w4GSi+MVPTcmpYNqPSrHQFdQbSnr+nnqS/Xoms5tKOlP9+aB3LnQa0lE
         RMeUmgfbYSdPQCIkxmZxL9v1omxpGJIrKhuh48auxUUqOZNBGIPo5jDhidDlnpGQnbUs
         u7xMtc8KHAVfrwHDPNUiknpN2h9sfgHLoiPTT9XSp0YNfIalMlDDe269zjTURUYM4RC1
         hlJk/NbsL43zmGc6FEOwySx4/padcT8W3N5orQwh8CWZhZ/c9zWyr7pOFrulhnQRjgA8
         KW/g==
X-Forwarded-Encrypted: i=1; AJvYcCXrtVkZwl9tYZqWtoEoDNGVCuCcX1dIitZJmhmtypJumefx8agPWLw/L/1MJbby3Stx3/aRLTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xenPdKVsxg54sg6yXwaDMrPNpur8Cjq5wp8p5lJO6BB8iDhO
	q/BSerIUIemDBbqkBW5Zui5DPkGXJnX29A5RXGZbb1mG8J2hYBfjplnltvEIlwS2x9Kzh4MMyTs
	sNMdv7Q==
X-Google-Smtp-Source: AGHT+IFoxYNoLghmdpptP7tDhzLk87CD3oeZhiQZUU42sNUj217+eYJVUow5Fo+S87ldA3ZHGB6RAPq/1Sw=
X-Received: from pjbsq11.prod.google.com ([2002:a17:90b:530b:b0:321:c475:716e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e812:b0:23f:c760:fdf0
 with SMTP id d9443c01a7336-2430d1f71e5mr29923185ad.45.1755064551813; Tue, 12
 Aug 2025 22:55:51 -0700 (PDT)
Date: Wed, 13 Aug 2025 05:55:48 +0000
In-Reply-To: <20250813014819.262405-2-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813014819.262405-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813055550.98488-1-kuniyu@google.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
From: Kuniyuki Iwashima <kuniyu@google.com>
To: dqfext@gmail.com
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, lorenzo@kernel.org, 
	matthias.bgg@gmail.com, nbd@nbd.name, netdev@vger.kernel.org, 
	pabeni@redhat.com, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"

From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 13 Aug 2025 09:48:18 +0800
> Ensure ndo_fill_forward_path() is called with RCU lock held.
> 
> Fixes: 2830e314778d ("net: ethernet: mtk-ppe: fix traffic offload with bridged wlan")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2: New patch
> 
>  drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index c855fb799ce1..e9bd32741983 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -101,7 +101,9 @@ mtk_flow_get_wdma_info(struct net_device *dev, const u8 *addr, struct mtk_wdma_i
>  	if (!IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED))
>  		return -1;
>  
> +	rcu_read_lock();
>  	err = dev_fill_forward_path(dev, addr, &stack);
> +	rcu_read_unlock();

This should be squashed to patch 1 or reorded as patch 1.


>  	if (err)
>  		return err;
>  
> -- 
> 2.43.0
> 

