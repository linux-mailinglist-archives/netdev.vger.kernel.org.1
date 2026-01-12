Return-Path: <netdev+bounces-248892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E810D10B7E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C638B304D8D3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516B3112D2;
	Mon, 12 Jan 2026 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dyOpSzdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5A30FC38
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199933; cv=none; b=Ivmdc2Dt1nUeCYXl4821aspIAUE5Pxwu4G/LmQDHdnJ/Owb6YHkfiGaTSJd1nt2Bw6gJ9qkGzIskgP+FPnk8EZZWv/kGc4CyFGT8VS4p7MRa1WeUw9U4Ma6fxYK+sao8CxLb+GEiZIYUHo4Aw/WQMCwtj8wMWwoZ1rrKwyhldw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199933; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB0cMo60TuZ+gYU98r1wZpi8gz+xYgllSXkkmoIqcm+smZ/zG5gx5l1j6cRhjk6yH7j1e7+WOw4idmtstbQH1iwzTyGNlWAZA8EGKXWLHW7+ydoYUCSNNwlcS2miGV6+eVM+oq7K+horm20EdO/k4BrgjSjIR5aADRF1KRii2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dyOpSzdL; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a08c65fceeso11533215ad.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199932; x=1768804732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=bdASH3/fEMRShFUP/U9WiBSBUUhiD+X50x4+QLpKveV5yjjXX8Bezq5R4oZbL7miju
         UmmF92V0dYDv9cKVHQhCF2R+0lfhyUuIT96DQShqbbGPkEMvdmRw2k6xI6dDYCw2JA83
         hp0JcSvGvezB/5mEE2Kjw+jOMnZBbc5ebELPpb3UzEybXuRvOXCHL1mYvcs8lQzhi4Xg
         UcFox9v4DyC5qpWT6nwtz2qfi1BdGaZdRjYpy0CKiignskNwJ4GzsDtpAWzNqYRwzmLM
         oJBGlQ9K+L5lpu+dzOMs1TJsRTzsMT6e3b2WIv5bNY7F1T2xz0b3wakwrQYBq1kALBHs
         yI8A==
X-Forwarded-Encrypted: i=1; AJvYcCVqMHif/uQ9POYBW+sGK6esyHcuuHj/Y1OqUs+FUdICcLvik9Z6TIr19mTNdBytLQz4nJUn4Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG64Rv43OoAEODIWBaHyAF1oQtOIfvAdF3eP0mNJ8ZvxAb+jG
	36YnzQ6Pv8FKY0aAADM3pNCHoW/zMRu6c3HwpoGavUQcKnhdAVGW/Z+CwlwhBOEtizCMA/Lmzji
	Yfn2zvs/795iGTheYN+5ols9lGmqoQ0Uwq6vTUmEeTc1sN59ZN4qb73khkCg6id8KBzYk2wYetR
	WAG7gvK5/1Sfko1gqaRD72i4cnVtFWWv7T/LxoQeE4KQ8epdTEC81QcSWU6SwQlpCt0NIDptsoY
	ntl2kryHLyq+W86tYW2IQUXjx38Gw0=
X-Gm-Gg: AY/fxX6G7g3JUyLOlNl/Ym7S/jLdinTKJEUasTq6h6C1lThOAKqHndaL9I0+evA2rw3
	Ut0KrMVk5flxS2IcApV1O3vKhSWbmFxMfFklxZ6bwfAaJckbtqnGLfNvv5TXMEGmk++9hnYC9TP
	sfxHjNZkjQFsHWxlNsW82cjjoleuiuJYAfRSpKqhgqpEGf/IwuewHLdfxaFH/shW3RKcwxTisrV
	fPWtjnfrqDdTMf0KhT1zSvxNCUYMmP/TAkdquQObCvMEi04ds3/lglcpaCa7ApMYa/fh5JUr8+t
	KSzW3vRi/++dUcSYF2cGgoRINZ9U4/A+9kbqpQuh85MtreYjwqGT2fQgSIUdNynmJ9qUEaGZ5f/
	cL9ynXjewRxWiAy9Zli3y9lDWWJT5kHHjxgQT4OaOj9y2n4PkpdgWhdDScPfjT87CzJLoKKNCoA
	P0b+2m48r6hroeZOLfnDKgAVXaFRFvFO38jqkuwod7UuQi4iBHzU3khl65xNQ=
X-Google-Smtp-Source: AGHT+IGMoj8puLJHPXtlfdAF+k3hNrVQ0GB02ODWsu82J7ng1WsDrDTqZo6qQK687Hkz6I/Nx8hD9BWoEZIo
X-Received: by 2002:a17:902:db08:b0:29a:56a:8b81 with SMTP id d9443c01a7336-2a3ee4e2e1dmr125439175ad.8.1768199931659;
        Sun, 11 Jan 2026 22:38:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3ccfcd7sm19846785ad.59.2026.01.11.22.38.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:38:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88fce043335so25095916d6.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199930; x=1768804730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=dyOpSzdLYKn6aQCombk0oR2K02LLwJ+NCjKCgNfEkXiPLN4uIyHfOuYdTqo+A0Q1aK
         uB/spBP3B9VE5eBuIunGO7VSPNNJzGJreCk2MMEWfZpXyLWsP90QOgyHUYHhFUirZcRp
         Xs4reIhPZe7DdWC4+6dpiEuHhCjSCqPgppZsI=
X-Forwarded-Encrypted: i=1; AJvYcCUYQ9iAFAGsWw+rm9owyF+j0ilLgne9WvdRkdp6NGhJ6hqrgVnT/aGnCxpQWzKcS/THmr+6m3k=@vger.kernel.org
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189420981cf.11.1768199930624;
        Sun, 11 Jan 2026 22:38:50 -0800 (PST)
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189420811cf.11.1768199929671;
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:35:44 +0000
Message-ID: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


