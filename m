Return-Path: <netdev+bounces-205549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C3AFF2EE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A9717B9AB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781F242D7A;
	Wed,  9 Jul 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ5MIaOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903321FF3C;
	Wed,  9 Jul 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092714; cv=none; b=sybmvK8yw9eOWNffMxNrdj4wQIhMjoW7tvg0NgqDi7XEb6tan1l8hheapcJpql+kL1ZYXSfj29XzaaYD7rkVsEOhG6D2BTbaSdBwEG8gA1BUGx5PSB/H30eDFIJ88c000JjNzGcbNLEwNBzCh8mFVo/llwu8eVW7L2TVeaAfd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092714; c=relaxed/simple;
	bh=dtJCWT8DbA8qju0zpg/P8rUCpINaNAVIYLZTCR5hjew=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version; b=abcYJFkw2/1Gosq1bdoMndWU1z00l1GjChsZe79mEnHni5vfnbS4rFdEm9qjbUHqpnfMxoXPb7CN3iLXYSAJEGaN4SXbl6DWpN6rKyMm7/juOYmcyXwcMkkEaFh+1DQqaCdKGitG7oVKsUaZAYFXLRr+V9eFYnaMu2NjaAL28t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ5MIaOR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso405640a91.2;
        Wed, 09 Jul 2025 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752092712; x=1752697512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:to:from:subject:cc
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h44TQyIh+bQ9fx2uSlxLOVz88FHVUWVzZyQ3OX/k0ag=;
        b=CZ5MIaORwLiuh1goFKhXXxx/lm1xaQUx678OYi+/3MUZ26QaQhE5THgWYdDAsNksTJ
         T0Enrh30T8HhNZSJZzUyZKUrzMm+wPw3SyxVyuUklkt75cFIQbN+SqcSyK6PhvfrBjyc
         6B5+wxw5ypJOdkChAo6j9LYBgsZDUcFJcIqnYa81cOvxCyxMuB3qQAS9cFWWlazSbxyA
         nQy5FtKzQ8YNLmnV2u4Xye5VoBpFoKLe6OXVFAm56FhrRQvsIlGF5NaI/0OKWZUGbf7d
         kskCu6c1If3hc+eX8VfrlCP+N9dJKGJrdEk+IJHJRv6sGFkrZMzDiKtUePZEYD70EbGe
         /7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752092712; x=1752697512;
        h=content-transfer-encoding:mime-version:to:from:subject:cc
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h44TQyIh+bQ9fx2uSlxLOVz88FHVUWVzZyQ3OX/k0ag=;
        b=pFZjrXeLHsECKBmN6AvtXs+5Nz897gLWcp4zxo+bp5jKXyvQD0l6d6MG8i1wk0r6vH
         qj2CkHwB0xTNh5Lx6tJ74xaTLGloIMqqlayFY9lWEWtsHXTKG2OWFIe3ku3XFh6vt5yr
         zwk1FIJfCjW5ktUjtpVLPWrClzav3RTBgtWqYVAlG08ehBsfPYSKpOOr31GjkQABIsPD
         ePla9yB3UCVlH4LUC5nR5vghrgxxVbswSYzjV35V9smKXvfkXy7h32aKM47w1crTQbBF
         gCGtjN+0s9kYS5NJk+p3US07v8It4vqWGmUCfA7wH1AVV9LrJwsMb5tEMayTx8bdMmDh
         267A==
X-Forwarded-Encrypted: i=1; AJvYcCWOK+w17iSvEhsloRnCMnGs6YbYj3b1uaLNyphSyFWng7K1U33LXxFDBFJ3swLqgsFPZ+GR4diM+PIS/Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/qbjGFYIeLy6R5af+1esDw8W3ndFgS/KHeuHbJ8Z4FitQgll
	Qg4UkPtSeno9PRXNJijMyBR4A1bwNoJ6oPSSmMT1bFrIUtNLhHHjHrhx
X-Gm-Gg: ASbGncv2Z5lMQ4zwnpVFC67/dQyMcfJdutyQrksRYoeN0CUBxKnaR7k81MkCKnfia6k
	TrzAfDhoGRTY7XeNDW4BqZLWITVFf/lo0nuLyFa9YfMQzCVuqPN5QGV7q3f15I5P0YuedpfvJJI
	R8+AaW8wbSMKO9b7bbS9lAN4sZtw7wwZ0FmFZ8BgoGrcosgGf6zanRDSyV8gMVf7dUmP3u41Hj2
	Mgk7TFoPntWy1l5R19RYqrxzMLW98siJe9UeLZ2j9SQnWOX28zbTZoEdTD1AFb11GyleoPLw1Gm
	XPoRNqXHDZfKzYUdwgys3kRXFk+ro3yG9ErhWCuw0MTbRocMcgcfmumI
X-Google-Smtp-Source: AGHT+IE5TSsHwCU2K5HT4mIVFSX0TviUB/DZQUrpE83siXR81h2wLPe4K7AQVh4l6YLmcbMvnRRRnA==
X-Received: by 2002:a17:90b:33c3:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-31c2fb9aad1mr6794550a91.0.1752092711792;
        Wed, 09 Jul 2025 13:25:11 -0700 (PDT)
Received: from localhost ([121.153.54.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301eb658sm2997264a91.45.2025.07.09.13.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 13:25:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 05:25:07 +0900
Message-Id: <DB7T1297UN2E.20SHSTO9HWDMU@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] On macro usage for ethtool stats across netdev drivers
From: "Yeounsu Moon" <yyyynoom@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While working on "[PATCH net-next v2] net: dlink: add support for
reporting stats via 'ethtool -S'", I received the following feedback from
Jakub:
>> +	DEFINE_RMON_STATS(rmon_rx_byte_512to1203,
>> +			  EtherStatsPkts512to1023Octets, hist[4]),
>> +	DEFINE_RMON_STATS(rmon_tx_byte_1204to1518,
>> +			  EtherStatsPkts1024to1518OctetsTransmit, hist_tx[5]),
>> +	DEFINE_RMON_STATS(rmon_rx_byte_1204to1518,
>> +			  EtherStatsPkts1024to1518Octets, hist[5])
>> +};
>>
> Do these macro wrappers really buy you anything? They make the code a lot=
 harder to follow :(

I understand that such macro usage can reduce readability, as Jakub
pointed out. That said, this style is also seen in several other network
drivers (e.g. `intel/e1000e/ethtool.c`, `broadcom/bnxt/bnxt_ethtool.c`),
and I initially followed this approach to keep things consistent and
reduce boilerplate.

Given these differing perspectives, I'd like to raise the following
question: Is there a general consensus on the use of macro wrappers in
netdev drivers, particularly for `ethtool` stats? Is it encouraged,
discouraged, or left to the discretion of each driver maintainer?

I've seen this pattern in several existing drivers, so I'm wondering if
it was considered acceptable in the past, but has since fallen out of
favor in current developement practices.

Link: https://lore.kernel.org/netdev/20241107200940.4dff026d@kernel.org/

