Return-Path: <netdev+bounces-209265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB52B0EDAC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02B0189116B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD926B09F;
	Wed, 23 Jul 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="MDyW6Mpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFFAD23
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260815; cv=none; b=RhenUyz9lUo9iQWZ6BWCKq1Xct37mVBjNpijLptqijKX9dUEtV0PPaTvNd5UrvDWMG9eKQwjovFoZ8bJ719hgqyen3M+tnpMc7+kMH8wcxgC+ffqw6zG7SL4UgGHZiBdtM3+NQ84z9yDOBiWZ3rBFDCcZhPcHPULn8m1TkPZgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260815; c=relaxed/simple;
	bh=0AzoBgOdjVr1dfBQ7ulLOHt6g5o/IV8g+lDS3TVrgYA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=lPAssZCHLT151F50mzMt2RCh/+AuXcYqN13leOaV1V59SUa1xP4/kKbsO+8YQQ4eo1d9mvrumZVukXE1MLdFkv0tZ2+yanF1qnRmhIJb9WJta+V2d2CFnApUyjLttgo7HHcwPPbXX1YO9zMI7ZwCJrYlbzxvSYQkMoiTP1E6nYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=MDyW6Mpd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1224053666b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260811; x=1753865611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z65j03WrO/n63aEHTvzMDd01RGJ+Quvw3MkBxukbbRo=;
        b=MDyW6MpdzVKk1ERubmy5vo1B2IXE206da71GrLaEuHB+Exa9CwAuiKKEIYsPe//3n6
         dfPDK7x5H9H/f/i1FeaaP5/+EwdJVowF+JZ7IqKxXKN4q8hqYQztHiQevjLQNrUxAMgt
         FA5NsKvhhQXr1kpWO14nWHqE9UFSFloe4wd0C2yPfldvvw/4KLDlOUhrM/XvDX0vl3Ff
         PT4nJTAAQTv4eTb8hGCb+eDmr79WgR9oKcEaTY3I4Uyg2UB1NcQU8ECiAAJKvBdsPaFm
         KTMGGscwfSH5sqs5HCjlWSoGXORrRuFc6YVKZ+TiOBt4DN47VlQ60mgCLiCSMq9j2Yar
         XSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260811; x=1753865611;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z65j03WrO/n63aEHTvzMDd01RGJ+Quvw3MkBxukbbRo=;
        b=dstzEjlqdwYAMr9tODVeVSCX7fI2nDyxJe1bfIjDFpGCDGJbG2cDktwS5ZyBoHIaO0
         rdujWbEDlP7dwXoKsH5iAMaSph8fAwbocIedhZQj4kw1uohU4aSQAXbapPm2kyMgvMMX
         hDC8T51Bwa/a/M6nFOyWFmD0v5uNFyRqRtbeF+BdEFntA+UIg8AV/EdOvD/VkSSPFJ0q
         IQ1k26itqCjxN0vDa/ZAVHRHF4TT1u2uueXldQJoyf7OKHBG5LP7Ola3aiQC8aOy4fat
         Na0j8dPEGKXbHoyx0QM9T1EMOZcgwm4GIpJKj9NL9hNW9j2UTWmvSmvzQLc1uNm6d40a
         1ALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXxaBHGtjdhx49O3JS5ZwISH9nBOypDsmufU7DAK0YMOnB9mgxJt5sxCN/BLWTk0bV3zT2gvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbO8N6/wmqa6wQ1Y7ZQTnXofXsd2BGD8OLdYfzeDzajWcpPYN
	1+1xQyH/FqZ5rfqlbKn6K2SLW79d0BlSkLYjBomfTSI/GuTGAlj6eFTGT+4wKfrQlA==
X-Gm-Gg: ASbGncspXlio7Ue3quIXG7UCnY+LeLc2mywZGfOX4zkMHobPJ2o4fjKve13OFon/HQe
	NO4KATIvZTGzcblAUqFZNtX1pKihHU03l4eMj6St3mBkBNS9K6qhKuk31e+WKFAuntiAmCi+mJe
	W78xmUWNwerOM/LTJb8QdfKchNoMSam9Ac2cRQs85+/RCLH9vSLndgqvInEYh0RKB+ZuHiRtnxb
	TeAZ0jKFgi1D1TDOFzKl6deOsmpkEKuDGUEU/BwdliBrYtXeRSBQg5KaNxnbdCkwQ3Tav91VOyq
	jmgS6LQWg9dyiwyFvy2S+cN0B/3xkOmULB5hEOeL86GJJbFqtcoolYCiQExZlBy8iQzBu6ufSoM
	m3r4HKSLGk0sj+ca2jC2aRqEi
X-Google-Smtp-Source: AGHT+IEAKKNfk8z8hc+e0fC3ZbDRCqVmoShe8CkCXPCmslS/ifB1iVUmtn6ibbbWnqxC+LicuSBrgw==
X-Received: by 2002:a17:907:7f0c:b0:ae0:9fdf:25e8 with SMTP id a640c23a62f3a-af2f8d4ecf2mr165925266b.47.1753260810410;
        Wed, 23 Jul 2025 01:53:30 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a089sm1007376066b.20.2025.07.23.01.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:53:30 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Date: Wed, 23 Jul 2025 10:53:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 0/5] drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As requested by Simon Horman, here's the patch set to drop casts of
constants to u16 in comparisons and subtractions. Changes are applied
across all Intel wired drivers.

Per C language specification, arithmetic types with rank lower than integer
are automatically promoted to at least (signed/unsigned) int on comparisons
and subtractions. There is no point in casting to types smaller than
integer, i.e. u16, in such code paths.

Additionally:
- drop casts in "return (int)checksum;" where checksum is u16,
- *_MNG_VLAN_NONE constants equal to -1 that are cast to (u16)
  are now set to 0xFFFF.

v1 -> v2: drop casts in subtractions as well
v2 -> v3: update descs, rework *_MNG_VLAN_NONE, drop parentheses

Jacek Kowalski (5):
  e1000: drop unnecessary constant casts to u16
  e1000e: drop unnecessary constant casts to u16
  igb: drop unnecessary constant casts to u16
  igc: drop unnecessary constant casts to u16
  ixgbe: drop unnecessary casts to u16 / int

 drivers/net/ethernet/intel/e1000/e1000.h         | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 3 +--
 drivers/net/ethernet/intel/e1000e/e1000.h        | 2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c      | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c       | 4 ++--
 drivers/net/ethernet/intel/e1000e/nvm.c          | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_82575.c     | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_i210.c      | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c       | 4 ++--
 drivers/net/ethernet/intel/igb/igb.h             | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c        | 3 +--
 drivers/net/ethernet/intel/igc/igc_i225.c        | 2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c         | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 4 ++--
 18 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.47.2


