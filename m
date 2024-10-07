Return-Path: <netdev+bounces-132890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A71993A16
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AD51F246A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03718C92C;
	Mon,  7 Oct 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8R3otWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19A18C92F;
	Mon,  7 Oct 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339796; cv=none; b=uoohjK+UM/wXobn4XGGhWCs2CEu1C7DUru7wJOBpepYykW6iameVx1Sa5i0a21Tk77S3XQ2DmLg/r2VspUqv+FdFkK0avKKbXeks9AwuSpCdn13hfQHascqP525i3Noe2f7fSWYARwwVhlzpv4BnXpzA3I+JOeOg2FID4sPKEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339796; c=relaxed/simple;
	bh=AC0Dccq5xgCZT4/TPD8LTCiX7UKO3mRUVSaLtJCrGjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCCmDQm1AhI96B91yrOYivxXaNjEbflz12Hr1dN/JIMSQ4+a0a+mc1DjkcJ2IybfMLCfxcR0LcFmbyYbD3ZDAs3AEsfdUA+4pgeiIZygc6+jYhfOV1er0fBc0XGXyAbX1LvdxoHMWGkCwcs9EBM49fTSxESyNqGN1QH1lU5BJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8R3otWE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so4054951a91.3;
        Mon, 07 Oct 2024 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339794; x=1728944594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ds3+MZ1OE3AHMQqWFsJnReFd0eQo7jl53K1pA+Q59o=;
        b=T8R3otWEq4auZGP5NcgAw8SvHx/DiECbnhs5IZkHATE2Ew0IZ0g4/4ukAQiDs/Wcic
         /Q6GFi9GJuZuezUULiGxWC4uWaWS84aV9/C+5zVLesSGgmHlQRm6r+cjTJkha/uv35kK
         Mq7xiwTNjMJ7Ww5E2eFCDVETZuAMH488TA1RrlGvOo+zzDq3+95tPODM3JtdzUmIBfWv
         RRuFD6IfPdA/49OKar/9Ybf4l+39qE0RHKH/VeJE69nWPTAH0CMdX+aSHsQPjPFV2h6X
         ZPTiz7/gtLgCt5Vc7Z/VYuQx/ZGYD4Bh28rroSas/P/ck2bW/Gbm6GrVMd+k5O0exkWz
         BqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339794; x=1728944594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ds3+MZ1OE3AHMQqWFsJnReFd0eQo7jl53K1pA+Q59o=;
        b=fsnlBFuXFcw3m+ttB02RmItr11/wPL3v4fcYRJojfGzeGjGhcTPMV4JqXlCVSsIQnw
         o2sYjX0y2K25gwnqV2vzLiJ6TWfa0Q4SxLr44xBdsFciE4IO6GpWwk1+NZ0n7u2NPL3c
         /WKz+cejy3t1vqzGVmehutFNm9lGajJhfZP6tzRSYonV7to4682AIaNeV6EPLWkO57Z1
         ReqrWzCEWQW2kWzE8m1pJmftMS1KehOFM61xWryoWXjOr8nnxLWtFAvGhsGUHFLqN06D
         vryf8yxLLmvh2F6ZIphGyMXn93YfxuhUpEj2ZDyKMYktrzmqY9We1B0GrhzxDgVWUtAC
         D0KA==
X-Forwarded-Encrypted: i=1; AJvYcCUV90bQpwXeU/4v/7Ry1uikcO+CgG+tBVN8DXL3mdC5bqpsMPN2k6xbp6xrxuvPaJchGPmALszI@vger.kernel.org, AJvYcCXQTx4AkP85Zsn/Fdz1jQ9GnD4B8xNj57XVtFmqoE5nIrb11uCT7XE2HqpdvOQf2S/wQM7LqHEoKKmzoQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRQXrGwNqH9zP0A/28CV8rEkRrae/rwM+ntfx843023PLkdjZ
	N7wIC1xe0fNon3cDIf4tS53dflmwBmnUb7b2RjcaE6nwgliMEb/U
X-Google-Smtp-Source: AGHT+IFtL8e33XTiVLgcfnml/74MtfCvSj76De7lU2Ssw9kai7EttlBYkg2Bxfrw71wLCuj2r2dIuQ==
X-Received: by 2002:a17:90b:19d6:b0:2e0:855a:ab31 with SMTP id 98e67ed59e1d1-2e20e07b04dmr11559770a91.12.1728339793811;
        Mon, 07 Oct 2024 15:23:13 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20b13beecsm5993328a91.54.2024.10.07.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:23:13 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Tue,  8 Oct 2024 03:52:59 +0530
Message-ID: <20241007222301.2622-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZwOiNQSNJ7CzqbO1@shell.armlinux.org.uk>
References: <ZwOiNQSNJ7CzqbO1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apologies for overlooking the previous code. Based on your 
suggestion, I’ve refined the implementation. Below is the 
final version, please let me know if this works, and I’ll 
send a new patch.

int phy_ret, mac_ret = -EOPNOTSUPP;

phy_ret = phylink_ethtool_set_wol(dp->pl, w);
if (phy_ret != 0 && phy_ret != -EOPNOTSUPP)
    return phy_ret;

if (ds->ops->set_wol) {
    mac_ret = ds->ops->set_wol(ds, dp->index, w);
    if (mac_ret != 0 && mac_ret != -EOPNOTSUPP)
        return mac_ret;
}

// Return success if either PHY or MAC succeeded
if (phy_ret == 0 || mac_ret == 0)
	return 0;

return -EOPNOTSUPP;

Thanks!

