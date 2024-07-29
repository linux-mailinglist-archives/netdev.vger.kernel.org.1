Return-Path: <netdev+bounces-113765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790893FD5A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987EC1F21BF1
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0D7F484;
	Mon, 29 Jul 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJgRsrN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A197603A;
	Mon, 29 Jul 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277867; cv=none; b=AWDGY66BnSGi2++4ntA7JSHm+NtER//6uAEDdYT1MZowDoPS8Fi8b+lU1A5D4xMv7RzLRFiHMJxZNXpsZhBkNEQCcR6rFOqTEFeSkPuxFKxyn06MjUFfVV/C/qJa9oQMtsgBvVqJJxIptVdK28p14qpEUhcQNa6eD4txrUQvdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277867; c=relaxed/simple;
	bh=fiEkvKXNIQd3n6B5sAlgqleRceqrBpU8/u2J3GfGbXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWzI46GuyRJE5dqhr6W16EV7Jo8aHCyydSbw8AUf1UO8wC6oKQaDhWSOiycwCl6s2lIIwlgDYcsOWXhpY4Cbfw+QFJHIC/hq8WyLO/6xPIhHy3o0lFl29VGQVDI/rdbn4/qLIAUg0sJ3bgjsJwC8OKvT4UDHb+kURx+057FzYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJgRsrN4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3685b9c8998so1454671f8f.0;
        Mon, 29 Jul 2024 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722277864; x=1722882664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jssj0R5WbBD/D0bXekdzCX19Oz7kjShtw75YWSFqWPc=;
        b=UJgRsrN44KHnsFMi2UjMa5thZ/RjHQVgHxONvs8znr0SgP/PbhkTtetBwY6wMVkFnY
         fxThB5xJURyCDy2N37mYhsFclbduJMFa4oW2nbXZDhuIbV4uGa9Wx9/9xnUvOhbJbQy/
         hwr7eZP2PKozbABR2XhqPndUsh5AuvOwwrKJZA5i5KPu7OY6dyiVLIeWW0NeiS88n4wg
         gtiUsnEatsxnoRSP1WPQvzx5htLHXAHjmzMieO7ajBAt1qwkzFIbX5jTmQ3mNLuDguCx
         3kbW0mzVJ9RdWmLxUjsTEBpOP9PX4fTmP88i9bEeOFU76JOYCZ8ds1e7f94LeviRmRjt
         sYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277864; x=1722882664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jssj0R5WbBD/D0bXekdzCX19Oz7kjShtw75YWSFqWPc=;
        b=EQ1aVMk5WT40BxAj4iwq/iWXD7x1BmIgn1f7+a895xToVXVMqcLNc40kver/MnCUpY
         HJ9UJncAvSy2uE0+QK43IyzIyXXB07Y+8YdV0h7lzKF5Og+VSRDds1gx2I+c9XHmAtfb
         NA8kz7s9seIdbcVoVREdZbmafTLNyL8lBJ4lirlnpYJsRsSD8r+U9oRM3SNfdcwYTT1O
         WJLn9HONZwIHJC3MMiFV5N7lSJk39h/z4IsaSeW8mIz+XsSk9NPJVoay5Iwd5wdCmXfE
         eR+56AnK/lk/5xc/zQA6flPAPb3ijiMmXBgdE+tY7Xi0EyJmdSIH7F5HGlDiGpfB+UY/
         LCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4+LzZyeU+h/QWwfyYpaWmDE0leunCs6TdUkBoz0XwLOZAvFqujM7rGvBPw2vYuzDBqmxl0b6+O87lZtMXuwJ63pm9H3izkJAKLuA+0FzTibuf50iEoNN2Zpvl17nKWqsn8NR
X-Gm-Message-State: AOJu0YyMh0TptMYSiunYHaatA2re7lqEEORiFb6F4Tw665VL5Q5/RUcO
	Rd1w8ES4n/BxG7QPIXJOEcVZDF1ZFeYgy15l66/OdbEy9uuiezKt
X-Google-Smtp-Source: AGHT+IGckqeV7E3QtAQI0Wo2goxFEwu/asovTfRvWoVzIEz3+nSxwluR1w5l8j0bg8XNacAX40nuXQ==
X-Received: by 2002:a5d:62c4:0:b0:368:7f58:6550 with SMTP id ffacd0b85a97d-36b5ceef410mr5313692f8f.15.1722277863270;
        Mon, 29 Jul 2024 11:31:03 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0aa1sm12800165f8f.21.2024.07.29.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:31:02 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Elad Yifee <eladwf@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX performance
Date: Mon, 29 Jul 2024 21:29:53 +0300
Message-ID: <20240729183038.1959-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This small series includes two short and simple patches to improve RX performance
on this driver.

iperf3 result without these patches:
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-1.00   sec   563 MBytes  4.72 Gbits/sec
	[  4]   1.00-2.00   sec   563 MBytes  4.73 Gbits/sec
	[  4]   2.00-3.00   sec   552 MBytes  4.63 Gbits/sec
	[  4]   3.00-4.00   sec   561 MBytes  4.70 Gbits/sec
	[  4]   4.00-5.00   sec   562 MBytes  4.71 Gbits/sec
	[  4]   5.00-6.00   sec   565 MBytes  4.74 Gbits/sec
	[  4]   6.00-7.00   sec   563 MBytes  4.72 Gbits/sec
	[  4]   7.00-8.00   sec   565 MBytes  4.74 Gbits/sec
	[  4]   8.00-9.00   sec   562 MBytes  4.71 Gbits/sec
	[  4]   9.00-10.00  sec   558 MBytes  4.68 Gbits/sec
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-10.00  sec  5.48 GBytes  4.71 Gbits/sec                  sender
	[  4]   0.00-10.00  sec  5.48 GBytes  4.71 Gbits/sec                  receiver

iperf3 result with "use prefetch methods" patch:
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-1.00   sec   598 MBytes  5.02 Gbits/sec
	[  4]   1.00-2.00   sec   588 MBytes  4.94 Gbits/sec
	[  4]   2.00-3.00   sec   592 MBytes  4.97 Gbits/sec
	[  4]   3.00-4.00   sec   594 MBytes  4.98 Gbits/sec
	[  4]   4.00-5.00   sec   590 MBytes  4.95 Gbits/sec
	[  4]   5.00-6.00   sec   594 MBytes  4.98 Gbits/sec
	[  4]   6.00-7.00   sec   594 MBytes  4.98 Gbits/sec
	[  4]   7.00-8.00   sec   593 MBytes  4.98 Gbits/sec
	[  4]   8.00-9.00   sec   593 MBytes  4.98 Gbits/sec
	[  4]   9.00-10.00  sec   594 MBytes  4.98 Gbits/sec
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-10.00  sec  5.79 GBytes  4.98 Gbits/sec                  sender
	[  4]   0.00-10.00  sec  5.79 GBytes  4.98 Gbits/sec                  receiver

iperf3 result with "use PP exclusively for XDP programs" patch:
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-1.00   sec   635 MBytes  5.33 Gbits/sec
	[  4]   1.00-2.00   sec   636 MBytes  5.33 Gbits/sec
	[  4]   2.00-3.00   sec   637 MBytes  5.34 Gbits/sec
	[  4]   3.00-4.00   sec   636 MBytes  5.34 Gbits/sec
	[  4]   4.00-5.00   sec   637 MBytes  5.34 Gbits/sec
	[  4]   5.00-6.00   sec   637 MBytes  5.35 Gbits/sec
	[  4]   6.00-7.00   sec   637 MBytes  5.34 Gbits/sec
	[  4]   7.00-8.00   sec   636 MBytes  5.33 Gbits/sec
	[  4]   8.00-9.00   sec   634 MBytes  5.32 Gbits/sec
	[  4]   9.00-10.00  sec   637 MBytes  5.34 Gbits/sec
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-10.00  sec  6.21 GBytes  5.34 Gbits/sec                  sender
	[  4]   0.00-10.00  sec  6.21 GBytes  5.34 Gbits/sec                  receiver

iperf3 result with both patches:
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-1.00   sec   652 MBytes  5.47 Gbits/sec
	[  4]   1.00-2.00   sec   653 MBytes  5.47 Gbits/sec
	[  4]   2.00-3.00   sec   654 MBytes  5.48 Gbits/sec
	[  4]   3.00-4.00   sec   654 MBytes  5.49 Gbits/sec
	[  4]   4.00-5.00   sec   653 MBytes  5.48 Gbits/sec
	[  4]   5.00-6.00   sec   653 MBytes  5.48 Gbits/sec
	[  4]   6.00-7.00   sec   653 MBytes  5.48 Gbits/sec
	[  4]   7.00-8.00   sec   653 MBytes  5.48 Gbits/sec
	[  4]   8.00-9.00   sec   653 MBytes  5.48 Gbits/sec
	[  4]   9.00-10.00  sec   654 MBytes  5.48 Gbits/sec
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bandwidth
	[  4]   0.00-10.00  sec  6.38 GBytes  5.48 Gbits/sec                  sender
	[  4]   0.00-10.00  sec  6.38 GBytes  5.48 Gbits/sec                  receiver

About 16% more packets/sec without XDP program loaded,
and about 5% more packets/sec when using PP.
Tested on Banana Pi BPI-R4 (MT7988A)

---
Technically, this is version 2 of the “use prefetch methods” patch.
Initially, I submitted it as a single patch for review (RFC),
but later I decided to include a second patch, resulting in this series
Changes in v2:
	- Add "use PP exclusively for XDP programs" patch and create this series
---
Elad Yifee (2):
  net: ethernet: mtk_eth_soc: use prefetch methods
  net: ethernet: mtk_eth_soc: use PP exclusively for XDP programs

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.45.2


