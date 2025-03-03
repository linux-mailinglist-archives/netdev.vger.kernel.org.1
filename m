Return-Path: <netdev+bounces-171095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3BA4B7EF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8163AE916
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709491E51EB;
	Mon,  3 Mar 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr1sGQ5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A31DA60F;
	Mon,  3 Mar 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984062; cv=none; b=BdxlayVwU/HIvc8SjnejNqERGU/ksXVCuJ9T+0yVT5e/h1yy5GExC8lUzjazmo+bImnBH/yhLmv4MMjuR2MX4refMgfbVsQ7a326AvVqXW7JLVroVJIWp/xYLoNsLGGjauWC6ZM2axHRcgkJmYT1cfm/zBQ/io/R0tFXc4FSQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984062; c=relaxed/simple;
	bh=3DPoJ+Z1SNuR/KkpCY+uheOaeDu2g+cbdEMwuj+D5gU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PnolMAiNvYK1IE6gJ++/u7hLiY+C3vV1IaeiHKatri8GTPgFqO9kYWcnkFvZcTDe/Ql80vYOoHny2ifygVXWZ8dL23A3A+jqXco3U9jcsuzO3069Qmve/WoZBnjaOen4RsE5usMdl8gUXUlN0Bh8/YWkQ1gpM1W6YlrT5UQ/qFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr1sGQ5D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22349bb8605so76655095ad.0;
        Sun, 02 Mar 2025 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984060; x=1741588860; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYU92NSFBZRKwbwQxofn8usYPW9ZYolv8EQ17z3D3Dk=;
        b=Nr1sGQ5DgtHDi0kjZwwCkLE7fDeJjZ6PINpuIPIGjjcgUm0AH7A11ZE62d+Lr4GpJf
         MlL2hzszeAWKw8L6zDtg8LIErEZNj+4s8681QiXrPTmE3zV9whjqa8gG2Q+pThcye3Nl
         dAK7nfLwNmjVL78EfL+6O91vW/6Sh6SfoW6QivMB1SZ1f52jRsazAJ1McFvylURaNksA
         +ulhiEjCVmaby55GNLtYHcpFaNdRguQSneMqilfTwVApK+BprgZMBHFkO54jQ2kuOCyQ
         dpShhhi3LiD+cj86i/VuieAq/bt+jD4UWF5Q9wJ9GC/h6faBgTuwuHA2GrcQ6egAlugW
         DsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984060; x=1741588860;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gYU92NSFBZRKwbwQxofn8usYPW9ZYolv8EQ17z3D3Dk=;
        b=GlUvAvUln7ylL1DKnjQP/JYZvw5cPsyep6dTceoOoqtDZpv7rKKZetnHHSEWiFPfhW
         Xk5wUn4zvZ/AfeqaSjJFyEgEJTD15FGuZ9MvSZmPDbNZTtdJD/m3vAnVu9il8hjYJMV/
         IlvcF5r+wbpgN3IqiZXoLvXxDjkdhKELJGZsQmQWyHx8pD9aEeYhfov9f2wFyEi/oFh+
         s03EhkUh5mF9naofBM5J1dbsnn6UpDgCMRi31TkBralUVP9ECdjOhadvnjQTyUrGC86o
         6qYCQWPxfS5q5q6ECZBEYYGO8jQYQ3sNYdDTmTG0wERU0F+I9rDljq5XsIJ0kw/GPM75
         ad5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZmPAuirWpURAiT74A+R7kFXLlZqJB6hFwnMGxyqiBoGAltm0/6meW/hjiw1CHRyx+RBJsWpv/80KqJHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNZKXYKJg7Sy/i3NbmZhSATkz2A0dcp2xYlLwqO9Eebtfe9Pq
	1R/cTIQa5pDzvgw+xRXUN1EWpkUg3uJ/bIh/+xWs4e/V78orjJikWgYgUN0Z
X-Gm-Gg: ASbGncshxvyNOqulIJEc/GW3lVmx8YqtH7HMecpicfqemxJil/dGJQm3MnZ7O4KEnKb
	dhqNKQ3Bbz/58EIY9H5Krzwq2wD8ugphOyul+2fqEqM0yGfepOw/5VGhYVZtGYG3R6qy5eZncjN
	ywedUtN8fGH6FvxiwaQRQz1mmDf15wE+w/b3TvENQKUY3hoMq+QRyaYJ5YNxcThq3FR+w2Eitr2
	Hclo6Q1gXEBWNgLFqxUlxbNti4TxX246aqsL5NeFsdHiX3KqsQenWQODESqufDamFoxdLjptY1w
	rOgdxzxgtgqf1h6szesKmU3Bj/+4XF5ATKMRae//fYnUSpaVVdiP8T0=
X-Google-Smtp-Source: AGHT+IHs7B/z3MyKZatR94inMLA4+7p2dS1Vlg5WIEqQEWbOiKVYEtISJcubAC7Lk7mpXxE50GLhoQ==
X-Received: by 2002:a05:6a21:205:b0:1f3:22c0:89be with SMTP id adf61e73a8af0-1f322c08d25mr4067724637.14.1740984060187;
        Sun, 02 Mar 2025 22:41:00 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af242e9fc1esm985857a12.23.2025.03.02.22.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 22:40:59 -0800 (PST)
Message-ID: <3e620e1e-d3e2-4243-a355-0874bd25775d@gmail.com>
Date: Mon, 3 Mar 2025 15:40:56 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: Divide-by-zero error in qed_hw_get_nvm_info()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

It seems that qed_hw_info_port_num() reads the value of num_ports from MMIO
and then qed_hw_get_nvm_info() performs a division opertation
using this value, which could lead to a divide-by-zero error.

The following is a call stack example:

 qed_probe
   ├── qed_hw_prepare
   │     ├── qed_hw_prepare_single
   │     │     ├── qed_get_hw_info
   │     │     │     ├── qed_hw_info_port_num
   │     │     │     │     ├── qed_rd (MMIO read: num_ports)
   │     │     │     ├── qed_hw_get_nvm_info
   │     │     │     │     ├── MFW_PORT (uses num_ports in modulo)

In qed_hw_info_port_num(), cdev->num_ports is read from MMIO:

cdev->num_ports = (u8)qed_rd(p_hwfn, p_ptt, addr);


This value is then used for modulo operation in qed_hw_get_nvm_info():

port_cfg_addr = MCP_REG_SCRATCH + nvm_cfg1_offset +
	offsetof(struct nvm_cfg1, port[MFW_PORT(p_hwfn)]);

// #define MFW_PORT(_p_hwfn)       ((_p_hwfn)->abs_pf_id %	\
//		  qed_device_num_ports((_p_hwfn)->cdev))


Could you check this?

Best regards,
Kyungwook Boo

