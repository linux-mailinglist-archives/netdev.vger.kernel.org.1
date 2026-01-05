Return-Path: <netdev+bounces-246851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D400BCF1AD6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A733E3003079
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAF280331;
	Mon,  5 Jan 2026 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdcU4cGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C92AE99
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767581519; cv=none; b=m9bKhS1A0PuneSsV79K4Kn64VtsxQIqhRkg/ZHt5hSO28e2LAMVZUW8Tj+CkD01UGhE/wKBe76fFs/SMIwU+Z1XS/1ywsJI9U7YSWBBdMBrixmv1v0waJTgkQTPLNYARRsFKD6qbmzZNf3hcMuYhGCHtD1P9GRcRL6FFjcfSH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767581519; c=relaxed/simple;
	bh=UHZ/FPXU+VQZlVeKz1Jh4u82PvhOAlXFRnbgwfwarOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtddLik5ft9gCUpR188Dmd51zV2xzlo4lMd2Nl27ditHESOdKMJyipZv0j00xwblTguFHSigyUcdJDClSJurDG6/+Fr2LxdkR7A0trsWXL6FJg0+oBGBinBF1B8z4qZC/DboOfX4MsqyyE9TDx6T1nSnm/wS+gSdxYSBf0x0XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdcU4cGw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso7790823a12.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767581517; x=1768186317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHZ/FPXU+VQZlVeKz1Jh4u82PvhOAlXFRnbgwfwarOw=;
        b=kdcU4cGwGBvLJZlva2e8egSUnX5JIrOvpFBg3ZB/7MLRnTnQy3UI4o6Smvoy4dHihw
         8BOIMbKxrV82F8bGyO/GpZaaI+2yMywnGCbYdraJhRSs5fJiIQWVPVy3nFuMsecMGQ2g
         zV0nf4C+AW3ofZ0mVRaEns48H+XyfwIHT2MsT8yl0EARWLwHMYVxrLyZUkj3fC26lWzA
         LW2Qze9g/di1tNu1ImQMiVPu2Z/WXG4fEk0L9AjGj1K7A//+dI2N1s9TBRiZJnnuXgGs
         5T6MUSl5zaG69FZW4Mx8ghP5A24zbbCjSRg7nFREJtrGWgWj35B1tcXdsGzel/Yo1LRC
         NC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767581517; x=1768186317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHZ/FPXU+VQZlVeKz1Jh4u82PvhOAlXFRnbgwfwarOw=;
        b=dhfm2+N8FkFq/3rNtg+oQbYMSIdPj+Ov75cUsAa/hHSjSp5JS8mnBPxH3SAkzhWmz9
         Yih8efe/YClt7pokm1h+UyX/YptnWiKB78hEGP4ad0+ZYv0OTtl+06F5QTiQUTU2c/4F
         WyUV6u5WcdbnjXwyq2qzsZh3j7OM7gyKeUlEWZ3Z3pQgfwHqmdLxMAmncsiWg0kTBiqT
         bammx/LOo4ftm6xiGxvoIsHzKKpuy1MNfZAqquwMfLucaVeOoKCzgHXgib8zgfr0yGVa
         to/unecvbv6XLO6PYhIs9uKOyD/DSeRdboB6iNk9OgW7pS3ejXICTzXn+IHCQrEE0QhR
         CKkg==
X-Gm-Message-State: AOJu0Ywc9riPcdISUnH7pnaekVA3tO+af4cA9FiKFQHQibNgvQGNzcAq
	owjMePQlxt09puJfppJY9C0hoWNxuoPsyjJp6l9sM8o6qZEUCrd4w0Gf
X-Gm-Gg: AY/fxX6arqHI3MkEFwg2FmQRPrRR3vGgamiPEooJyBfcmlEzQwO+/nnSzbV5HfPtkbE
	zcntW1tLFeZuRKiKYxm/KrV2TsmcCgumHxeScpzY8oPGphsm2DjY/H9/8eK6BsDl52xAGQNUorK
	0ECLojYdkY7eO8cyPMCUyC8FvxgLv62Jq2NPu6qCeQPLCvPOQVn0lj4Hyue9VGMQSwm1kcboKj9
	ZjaX2+mpG6SxcBQuVvAtMvNgh5ck1btMPR/mslIfY2sjwwCaMdOPpZohWQS6JpMh3ixJcTTF1bh
	Qh1dmHrldmXfhx/DPWqFUzzVqr0Wt15cI463O90k0hrGOKpSY+yrNmFYo0aPaCm7eL60Qx0eyM9
	glFEPAOZz46vxoakuNEnPFmVDEv8IkkY7FUxskUG7tmmZLWgrWUG7cxw2DoR7NUo=
X-Google-Smtp-Source: AGHT+IFXvOJ2HRQ/ak8rer6QeFk/Bm3/VX88d8mLYTC10wc9VIMvqdV1KV3aBpX6VOM+Pqe5oLZw6A==
X-Received: by 2002:a05:7022:e11:b0:11b:7dcd:ca9a with SMTP id a92af1059eb24-12172302438mr54322378c88.34.1767581517469;
        Sun, 04 Jan 2026 18:51:57 -0800 (PST)
Received: from gmail.com ([2a09:bac1:1980:20::4:33f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm189959924c88.12.2026.01.04.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:51:57 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Protect MIB stats with a lock
Date: Mon,  5 Jan 2026 10:51:39 +0800
Message-ID: <20260105025139.2348-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105020905.3522484-3-mmyangfl@gmail.com>
References: <20260105020905.3522484-1-mmyangfl@gmail.com> <20260105020905.3522484-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Mon, 5 Jan 2026 10:09:01 +0800, David Yang wrote:
> 64bit variables might not be atomic on 32bit architectures, thus cannot
> be made lock-free. Protect them with a spin lock since get_stats64()
> cannot sleep.

Synchronizing both reads and updates with a spin lock is an overkill.
See include/linux/u64_stats_sync.h for a better approach.

-- Qingfang

