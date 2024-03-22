Return-Path: <netdev+bounces-81200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDB88683D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316E61F21808
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690BC8E0;
	Fri, 22 Mar 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jiGAIr/H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD681A286
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096406; cv=none; b=OWC3zbblonjNF8mSdBUUZCk39rFkpN6lP2lssfOVP92ZGZY2Na9gnHD7BiZlnZyRczuFXMbZYiVxfMniEb/qRb39IVFq0VGk/NvFsHplHBQRtRZcJ5edlvyPldcM85OvUqXD1KLhWCb1xILL4Ec1H6hj9vGI2TPeBa0io1vZhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096406; c=relaxed/simple;
	bh=jwepGp6x+RksumqDKyWNRAJ9td8pEdhIVg8wHM+RFws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwFE1FohfESZbhnYQpq5h8/qkzyyG9pK0RU5WIXU2hU2nmg1UN/d4TpzfX9Q5vL9F+jr+O1+073r3TjYlIiM2qz95rliN20MwEtlTG/FA58RshSy/gEBAyXHi7KlaihqITkCag83qvcd1F6IaabH1CdwHga94bxp7Sv5DR617bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jiGAIr/H; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC4FA3F879
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711096402;
	bh=jwepGp6x+RksumqDKyWNRAJ9td8pEdhIVg8wHM+RFws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=jiGAIr/HPTsGXU66HN4BpyowBPTmonbHvWSJiw3DhBwZRp/RK++SWQ0Ehm/BAw90q
	 zlv9bZchNClg7UxRsA3zs01qhP+AieJ/AFF33Q9Wlm/y9rXtA4QYsWAUGu11nCSpmL
	 2HDVbePYtRLosHp5IkEjNwocVdZJtglrf2Ri71u/WicEK3S0ib8x9A8yTKxmLXqpIm
	 A8wu6YaJKdda3u8ZtYLyX6UAexNbrc50Td1DEnrhGVKqZ+TciaC2GkD0TAETWJIrjT
	 TAEj1/zKOQF0ZDr9cNHghQLqdee5m66enMs83YwrgJghqwwwN5dn6+IXkrdl10ZSfl
	 deZ1sySFyIWgQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e004445facso14868255ad.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711096401; x=1711701201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwepGp6x+RksumqDKyWNRAJ9td8pEdhIVg8wHM+RFws=;
        b=xIfNAIg5baysrp40/OXowzApEPhVBUSap5B3iiYNTPPcSH4PveMxFDE3ww/Y3oK+XZ
         rQkdgFSV3Laz+hYYbVBMeRrZ7cw0NCXB74t8ypqYz1mxWIRoxA5mtxN/1PVcbB4fSNeo
         B+gQu2NSHNuNX/Wod2Xz7Y9/IbcmFb9/MYA9fqg/PpcocSXX25lCllOYZITZtpVPpf7J
         O39Dx5WoJqg/p5CXWGkYSeIzTuZbZMv1cSv0syTY7GVuVp8F1YVpMjNM1RPwJG/4YdEk
         2bkZZRIwFqIv8gjuCd6K58rU1A+f9hNx+K8+Cgt5O0JpVDi+9L0+8I0GQQxDTpGb5rgb
         YpBw==
X-Forwarded-Encrypted: i=1; AJvYcCWOGcwXZ0J750TgUBh4oaEosX0FlSJNZMO+Yx7l1LaiJZnoyE8d17u18l26QiZHpxPGmGGorhkgovpuBi7JUw4DO6k2AzXE
X-Gm-Message-State: AOJu0YxHFsmaw40WyYMu6iRzIuR32Zbx3sTDeuehsIhHe8+6L//rkZU7
	miptGDcbZm64Gn56SmflNCw8UM/BJJ56QfSF7196T+Ka4v6C2KIf5b5t80s1o5cM5cuTPwnpfbr
	kgrXciFUWsh7derkHHBhgiWabV0k08ZjS+eK7ksnlkT3wwwIzFwUNiR+6DTHTF6OG2wd6LA==
X-Received: by 2002:a17:903:18e:b0:1dd:df89:5c2 with SMTP id z14-20020a170903018e00b001dddf8905c2mr2047399plg.22.1711096401145;
        Fri, 22 Mar 2024 01:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHwzxNHVJFJs2RlWijgfTEep4ty7wbQYF3qSwCgHnVP0B8rJ9r0ITjcFwwAo5CvLhD9yt2YA==
X-Received: by 2002:a17:903:18e:b0:1dd:df89:5c2 with SMTP id z14-20020a170903018e00b001dddf8905c2mr2047374plg.22.1711096400837;
        Fri, 22 Mar 2024 01:33:20 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id t3-20020a170902bc4300b001dd4d0082c8sm1290723plz.216.2024.03.22.01.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:33:20 -0700 (PDT)
From: pseudoc <atlas.yu@canonical.com>
To: hkallweit1@gmail.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: Re: [PATCH] r8169: skip DASH fw status checks when DASH is disabled
Date: Fri, 22 Mar 2024 16:33:15 +0800
Message-Id: <20240322083315.47477-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>
References: <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Fri, Mar 22, 2024 at 3:01 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> To me this seems to be somewhat in conflict with the commit message of the
> original change. There's a statement that DASH firmware may influence driver
> behavior even if DASH is disabled.
> I think we have to consider three cases in the driver:
> 1. DASH enabled (implies firmware is present)
> 2. DASH disabled (firmware present)
> 3. DASH disabled (no firmware)

> I assume your change is for case 3.
I checked the r8168 driver[1], for both DP and EP DASH types,
"rtl8168_wait_dash_fw_ready" will immediately return if DASH is disabled.
So I think the firmware presence doesn't really matter.

> Is there a way to detect firmware presence on driver load?
By comparing r8168_n.c and r8169_main.c, I think "rtl_ep_ocp_read_cond" and
"rtl_dp_ocp_read_cond" is checking that, which is redundant when DASH is disabled.

[1] r8168 driver: https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software

