Return-Path: <netdev+bounces-179416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C450A7C812
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779F87A7F09
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F51CBA18;
	Sat,  5 Apr 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QhnZebYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD174634
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840590; cv=none; b=akOG5ltg1fpnzaF17YVSZNwlIzgvrC3KUkdy2bTI1zcKovMq1oGMs9Lo7oir+c6/pOCraWnsa4YzkDJlHJfHUad33/oU+KPub3+JBs85MNXrju9JW+FoID+rrjifKS7ZU42VPHVqprjoYb/8Bv4J1mOIvMNE5sPgymb8TOwZlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840590; c=relaxed/simple;
	bh=xpYMAwtnNfE9chsuIaMja5VW7WUGODl8F8mPADK0ESA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAZQNxG5MsM8jXBU44ioGxGbZ4qXr/6oignlz1XfJ2k53MwgSOH1igfuU8WRm6l/Ta98UFYbEaX+/ebj43s3SFMw3EMsqdLw/z+UqNsx0zeKamCCkPtiLBis5LoDqH+WnkIP4kqnMo68hHmdBIVeiG7YlRegAUt/0/w6QEpTAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QhnZebYv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so1646649f8f.0
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840586; x=1744445386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QZsIuICHFoqyu64ZjWWku6z9fVSAzGTu2pQOtSacSA=;
        b=QhnZebYvfDeV2b4ILAagTGkiuWwI9ZG7Db8hbnxraAfcAvKzaD1OlbWoJvZKERDPT9
         8jLML4/gNTNhpLgNV7c3OxT2iQlnqjFG1YrW6mEDVQ7vWLovVNUx3OkfiB3JGSQJ95nw
         zCPC/z+Pc4USt0QFsfrEUoLniNsBnji9ThFK7/i2vJvGlAi3muoNl+JUo53KnzWc7iD7
         xsiOMXztdiSRZwXpdogNOdmWjsqHepBNcvms5Wvxv7IL6LKlzys8IQYgmCfugBYvHOX0
         WLif55iHi2NByiuLuzdJE/PCchCiwU7QhssetVKdk5bD6G2YssGqRSYjCtQd+8bTXaz/
         BK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840586; x=1744445386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QZsIuICHFoqyu64ZjWWku6z9fVSAzGTu2pQOtSacSA=;
        b=nt2+MFwesOT/SWQUjz0raoF9mTDwvrrxGM63F4CCb/PnLEqmGEoKv/6ptpw3TdiZAO
         AmDvLk+ShKY1muSaOGcJYvPZKVRojLrsuaqg2GTPlzM/1GnRwHfvXIn1YhywrBoguEGk
         pUWWiv+q4eO5O3XuVTB20ZQo9ne/pFiToTiBvD6SoeY/gODz8X3Je/sSt4BisKkm5g5y
         VZUQXNdrucykdrA/tfWAyv11j2hx9U6SYjQ661uE+37+xG3v17eI26nXN+4Neh0+YUhp
         Aj2LhspWZ1PLuRuhmwePNSuOhRGRx9dBhw7ENIq4mmywQJJwEyEfJiGvZJRyzTwv0vG5
         wQVA==
X-Forwarded-Encrypted: i=1; AJvYcCV1VHwZceegwl2+El+GReu2iCw+btxMIIvbQY7f5fGVY/TNLVTtNwbacuKRTIV+o/Tl+wo97IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaENAFnv7zqsa2EhFfGViCxI8dFaj/YrUjduAGO7QTkNxSwqfk
	Sv3QpmFBbQmAMyMh97xvhqOGaUyKzqgZKyFPvfk/zW61q3aScjUc7gdpr47bLOc=
X-Gm-Gg: ASbGnctpX7bcBWLAXlSuv/yBh3BqYnIcSid/essd1dE611WMxmu1Y+N3i+5yTcF5+de
	ccgBN5S3L4WzjvLOHE1+DOkIBL3InO7vM74dK5PgFWkqwuJDxljvX+umpujrr1BDoWDW5Q3mhiZ
	ntEiyF6OORdxPlUkzjuJ9Pss/9/y9A3doy9b1R1s1nM8xy//EQJ/WPslwMwvHfUlAnIzPLM6VtO
	GpXS9gaeaWULggYQqzce7gXS5SLjfv8J6lZzHfOuZlgewJw9P7Lwgy1/ymXkIbDNFhZzhHCuw9a
	mA1xD3wW7pcEBJF6gTGjE/A5D02Wi6IPA+HgkAZOEZI3YpfoIka6qNfsFD+o+y6uD0u/JOs14T7
	i
X-Google-Smtp-Source: AGHT+IFHXyrO4duwB/8ct3hbp2ZVFrHLWPnHZ+LzJPJBWsvwvWdFic7KtYfCRYh4AG6VhKDgfHE1gw==
X-Received: by 2002:a05:6000:270d:b0:39c:1257:dba9 with SMTP id ffacd0b85a97d-39d14762337mr3053384f8f.57.1743840585714;
        Sat, 05 Apr 2025 01:09:45 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm6325826f8f.39.2025.04.05.01.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:09:45 -0700 (PDT)
Message-ID: <0c42671d-31cf-401d-8c40-be43b9c83ab3@blackwall.org>
Date: Sat, 5 Apr 2025 11:09:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250404212940.1837879-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404212940.1837879-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:29, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  9 +++++----
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



