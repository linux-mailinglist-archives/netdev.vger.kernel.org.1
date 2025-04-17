Return-Path: <netdev+bounces-183746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDDA91D40
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFD77A7957
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AB245036;
	Thu, 17 Apr 2025 13:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1224501F;
	Thu, 17 Apr 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895020; cv=none; b=DTocFpICiWmNteYWLwZjfrT8FSm46Ap/YgjaQyBpqBbzLcgZo5GARgXCpRnAbIBz4+8Vahk2AwcWdjeQ17iFVrN5S3bB24Aud0LVCEiOL2AS5soW1e0IMF9ktpwTcAyUM9NlTsEhcUYxsQG3RLDHrv8ZP2GImnNTnKnmn+elW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895020; c=relaxed/simple;
	bh=T+ps6p7M8ebPsM11Xfj3wVjAN0VKOEWdhkwtXjUccAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sabBt0MDrQ91l0Cq0G3Ylq82YeH6bUalMNXFfkQy8sI5R9l4is9w1T/+yCSYyVsNKl45oEsPlptx4bzVsjYLXf4fEkR+FlrEHi72yg/z6kjaOd89AtCdrCqmhFfPVp0Fle9Kzkc9Q3OD1dFMFTyKsen8+st4GK8RXL8LcPhQV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so1323101a12.0;
        Thu, 17 Apr 2025 06:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895017; x=1745499817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1EkkU34BT5hACl4uOWIOXWOLkG9A0MlKIENWBE2PKU=;
        b=dMvYhTuCVg2TpBTjWujW4/6xDQQsaRf9cxq4kW4urqscw9z1VkhgPeqDMMXHLTaZlh
         OC5ocSrQMxY0NdoCqQXf8STMbQKWQtWSMrnyWDEdwjoYjsq4MjxLAt6ML8qZNnLARB72
         LWpfdGoEQDVQkc6+8IWUa0mISkyyp6Vao7v5sL2ypG+ZWL/dtzlSKDevNFX10EBZCK7L
         vWEI+Z8VGQI6BA7gtRawRGHwENa0PXZEZFB0ZXwrHZ7jOx+AZiu8ZwMurRFnLgN0VMVu
         EIediPCBuO0dra65HxqheqOIdBbhEj5o1MDmdHDtHrQPaWYgtICkFMd3ny2PNhvpqtDK
         Y66g==
X-Forwarded-Encrypted: i=1; AJvYcCU6vYbrpm+ZW5OC/E6k0niAVE3Y9OJi5orvZdr5wTkLY52JR7KDzcJmJ7XCMmSgT4bWlf8V9J/U6YuhKBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IQbXbm9mprKJ6XSq7FcBW7cNqRKUAtRM8y6l/iS0fngkkK94
	hUk+kitpw8oV/RhAVC1KsA9WKrbBBzXWASLLsGFvpV50Ukr7JN9l
X-Gm-Gg: ASbGncu5KDy/K8yVVD0iGiMCk9dHmQR+CYRa83Xn+SQCAmk7/Xj6GW2I5bURoQdEAJw
	ZPffzcC3xO942iOeRBu59V4tIuofXF6LmjqWIrPCW8is4z3oU2Hl7lFaGr5NcA79bbmLVc3Oi+A
	dOuxUehi4bBR57pKSJ/wiabYULBUCXCSOBvQebHcyR+KhlTbNRaa9SGIPbPJrvUhtu0uwgdy2tV
	v3/3EyQXabaGQ3LQRYkdjFV+hCYBrm5Z5oowHuQFWu0F6vnca6jNAPVl6gu8vFaiXmbvgfN5Opb
	BMBAI3+BDfhS/iqB/oOA/umrE+C/A5Q=
X-Google-Smtp-Source: AGHT+IGiqpGlwXUdGelyy0NvS+TlZoScu9aEQ85awOeVl4i6U0V/rmW0rDD5wfIPRBFLytGdR3ryWg==
X-Received: by 2002:a05:6402:84c:b0:5e5:bdfe:6bfb with SMTP id 4fb4d7f45d1cf-5f4b748b5cfmr4061377a12.16.1744895016764;
        Thu, 17 Apr 2025 06:03:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f068a5asm9940239a12.34.2025.04.17.06.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:03:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: Adopting nlmsg_payload() (final series)
Date: Thu, 17 Apr 2025 06:03:06 -0700
Message-Id: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAr8AGgC/x3MUQqDMBAFwKss79tAklatuYqUUvRVF+q2JCKCe
 PdC5wBzoDArC5IcyNy06MeQJFSCYX7aRKcjkiD6WPtraJ29lzI9touLw41NF2r6sUUl+Ga+dP9
 XPYyrM+4r7uf5A9Fbke5kAAAA
X-Change-ID: 20250417-nlmsg_v3-2c8e6915e0d7
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=leitao@debian.org;
 h=from:subject:message-id; bh=T+ps6p7M8ebPsM11Xfj3wVjAN0VKOEWdhkwtXjUccAA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoAPwmfbYz2PYxEueKJG17zwupQL3zG0w3yttZL
 f25Zt0BBiqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaAD8JgAKCRA1o5Of/Hh3
 bf6KD/wOssjT3oKonCAyEcBgZ9rEIaIa6BChVDxQCGhhZd4UXURDGg287qq7K3I2SSbKe2z7GtA
 EFiKqGoQVUgojZkVF4acL7ZCdh6QC60nv15Oa7So7NpkTE+xQxWFwH+V/aERDdC/941p1HWZ1ci
 7j2718nNGQcSacgNg+ejUCepp8/xDU07DaIKFeK4nfZHe9UXHxCO98GEW29rc6FslmbrZgVLej1
 pFo9tyQu0vPGNg1XoAVgGCjz2WLHre2albKrcl3luCk1odZIh2uVV4ZtbB3edvK23QEWZN50ugg
 C6wuvgAUfbA2cwt4ffLEwHPZOYYI9LKnWcef7tbGPAizePBh+6wNb9GOJJoKrrxT7SVHmkuSE1w
 yqK2HIPKY0M4afIKaYe38fnQi8UpIQ95IfPHeRM1ny6FaAto9c91bwOCXPHOnSoubWikzc4V0rw
 p2mPudsCuFIXVHL3v7Quyoc9w/0DjRqNgptUElRoa/po4f7DY0CtALgKrtR56l8jG95N/BysOEV
 XHq2bC5+02Yzst/WdL5Ed1C86AUOBVD7fKCMs72pbjVty8/KZdnacWvad0r2eYF2RsW7R6P7UUJ
 5ijbvLaCm1UTECQ2MsnNhiWNSJFUyGIfPflXgkHNZqaN8s/V+XjbjJASjTb0+iinKJdjSFuFQ9a
 kPu0mPJdvDRgFRQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset marks the final step in converting users to the new
nlmsg_payload() function. It addresses the last two files that were not
converted in previous series, specifically updating the following
functions:

	neigh_valid_dump_req
	rtnl_valid_dump_ifinfo_req
	rtnl_valid_getlink_req
	valid_fdb_get_strict
	valid_bridge_getlink_req
	rtnl_valid_stats_req
	rtnl_mdb_valid_dump_req

I would like to extend a big thank you to Kuniyuki Iwashima for his
invaluable help and review of this effort.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      net: Use nlmsg_payload in neighbour file
      net: Use nlmsg_payload in rtnetlink file

 net/core/neighbour.c |  4 ++--
 net/core/rtnetlink.c | 25 ++++++++++++-------------
 2 files changed, 14 insertions(+), 15 deletions(-)
---
base-commit: aa5f7b9bc025408a84c4c1828501b42335b8fd68
change-id: 20250417-nlmsg_v3-2c8e6915e0d7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


