Return-Path: <netdev+bounces-248888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE606D10B4B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762CF302A390
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC830DD2C;
	Mon, 12 Jan 2026 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PDtcrf9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F841E4AB
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199628; cv=none; b=b/yyktpauo0ZVjIOvLV/aHnuOJg5cEB8fMBKZzfSjdY/HE3PwssD7jOSV+ggpev7GpBJdKlRm6ESjDA19AQAggcQrtRWWHI8cbLFIF4DXlwo0Dn/Di1Haixw4O7xfpJcL9R3kfWaORJV1OAGn465SZCmE/HfFuSWTpS3VKe47pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199628; c=relaxed/simple;
	bh=hADIlBZYtdDPX5eqQOXYz6UWY5u+6lD/06flIKFJ18E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwE7n4CpHlTDfA+IxO60bbpG7Q9e0aqHNemIrGRbs4msmQLq0fwPql18W4cEX6q+HV9e5XaKBE9YS4Q2IaCSz8CFTNZrpkszfYG0f9wzfSUMr1x40GB94XQrbsyxMQ2zOF7ciAQzYygFzDMz83qn3fwKb09cl8eGxU9xt9AJmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PDtcrf9K; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89001e04908so3811016d6.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199626; x=1768804426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=c0JbnyZUWxvDTH7HLZiO1TcpXJ+d56FsQnKSVdh2rnTLcv8MH+u/h3ZP38VnashAq3
         38mLGtGCc9/3HOHFbxdrC/5aC18xQgwf5nOYwTIUEOCR2C0j9qKts8lnA0bvXOAsBUE2
         BV371pewx4hbrqMPTP9NUtChMIwDZaqS8mT71qMCBAJT66q2PUMjX2k/4r65ZFcx9Qja
         i1NWMH8KhxapvBjh6AGodm9LuZF9qALDSSKfCdYJ51na3pYi/5scO440rbCYzykuGkZ5
         9we+YOcn+BegBPtanGRu7pSx1mvbDouHT+fYwpg88wjM6RbKuyY5SqvGX/Lxy8qxvC+I
         lWBw==
X-Forwarded-Encrypted: i=1; AJvYcCWwStyycKFKpO9r/J74EmP+9vx+AggBxfXs909aO/y7y5fLIorkLlP9pWZgo8cHos02F0u5AbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6Lg7z2OxJMrH82voGRVsMWXtIiEd6pwzsUjx5kN1W/98knlk
	mEU0aBFKanRghUn1NAbVjJG6/29bogLr65K6GodDs3Vd9x7EBDuJ3yGm67gqCosCFlRW++ntDgT
	JzfYKwqm4w6TdUvDwMTMHwWzWNISi7q3XgMCwaZiuAOgGMWoK+4xL44zr5oz0MwpxvIMk4eVvRA
	JpOCsx05tTzkgu2w9a/y7gphyhW92ii1kYJlqhHvYtFVvHO+zenBsoAC58sT4PnvwkDYyXd5DoF
	tOf4RieCKlMVtnVnWscKoNakG6aAN0=
X-Gm-Gg: AY/fxX7duEzo2kbgq/uSKbPmCIkL4hT7zJRgRXvRIE/JNCMcb2JpOuXQqOi4Usd6mI6
	Vyhwk+g+PhkKpEEmc0J8i1l0GbhJ4s/2w73G0S0QfQzJRStoffdFfeZwl3GnZvtCe8zibK/rWjJ
	yfVSxV1zMO2X5ZlzJCH//YkIh11Cdqin7H94Alh7D+AqJLNNeny2mn2GkfCxvNNfV0EEUfO+f88
	Ovd3Hl/LlKnflBdYFfuOSIbMcF4hKgXLBsDuZssaeIRV7IV23bGq981GczmCr9wTS291OVWcTMj
	G0nKFCRSHd5FHYglKJk1kkbmZRxcEvn2J2DwWpoEuCmD/WjNA2n84DjbO8WpQysE0Jrw6sgueNz
	QcxiggrduBhKGtIo4+ItMGvLXzuSZhz6hC3R1UO0K0jw8A/mO9J2R0/ZouMOVzg6M0f6gWLZ8KK
	Xy9iJlwP6lchwd0cJH0fUHKHRHGFwrXb0PpeVT5p3HhOP98K+bOO0xKus6j2AFOR6C
X-Google-Smtp-Source: AGHT+IFYopA2qZEIpo9BsOURm31mQlPkXZJEuToxOeiLG4IG1D0sT9Du5Q3sWj4opNfmnQNelW3xfVvnMh3t
X-Received: by 2002:ad4:576e:0:b0:880:55fc:c984 with SMTP id 6a1803df08f44-8908429cff1mr186765946d6.5.1768199626372;
        Sun, 11 Jan 2026 22:33:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077179352sm22060926d6.32.2026.01.11.22.33.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bbb6031cfdso203313585a.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199625; x=1768804425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=PDtcrf9K48QZouWh/jc8Jyv+vI+NJmSzWdZqx0yT4OYxAAqF2bYXW3ADnZdzn7nsjo
         pV8DEVowtk31eC1D/IEF1PsjiOihIARUtaQmahj37NZy7ZQtkIxomt4OwzUlHfT387oA
         JGgDvjZXVwT00UZCD5YKvFVyEjptyVa/DANw0=
X-Forwarded-Encrypted: i=1; AJvYcCVL5UVeNQ+r1KIOa9/iiLAJoBaJlpMLFgjFkcNu6g97KH3C7lzxorfeEgJ4Nvn4dTZMNKDmcpg=@vger.kernel.org
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930991485a.2.1768199625708;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930988785a.2.1768199625102;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:44 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 0/3] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:30:36 +0000
Message-ID: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commits are pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (1):
  net: netdevice: Add operation ndo_sk_get_lower_dev

 include/linux/netdevice.h |  4 ++++
 include/net/dst.h         | 12 ++++++++++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 net/ipv4/ip_output.c      | 16 +++++++++++-----
 net/tls/tls_device.c      | 18 ++++++++++--------
 5 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.43.7


