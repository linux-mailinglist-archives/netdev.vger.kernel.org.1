Return-Path: <netdev+bounces-246594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5BECEED8B
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5C923001E08
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C8261B96;
	Fri,  2 Jan 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPxmJ7EZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC825B663
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367245; cv=none; b=El3zs/+/AZsU/i6ecTkEowuORRW7uFm7nIpiLSkzp42nXOh3QVoi9T2uqtuDd3mRB1MM8vx6E3d+sOEyq7gUr/bgltke1ovaHlczKBnj4AOV8iiIA8mPP56R34I/tsP8iPAutfYXTwGtCE6c6u8pHzp4q7/fSaXxcRx7HHYscms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367245; c=relaxed/simple;
	bh=bEfI9VdyBfyGoJu/InKuPX/XT/uFeqFxXXZCS+SC1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4vf/LnqaWZron2PDro2nVkaUxEPXSuDQ2DqatvIVScvx6YRxPtYtjgfFwvGKLW1cVqeKcPAAOHwbQzj4Mf1AuyPmSoJ3iHQkswxIdpUPg5tXSMgUVY5fZPOeySCFEqzZEtAury0zjuASW9bQb7IuBwX8G6m7DaOd3XAWksWG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPxmJ7EZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so108506395ad.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367243; x=1767972043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=LPxmJ7EZSxyn0N9JalSZFqsmiWvfbF9PvA06JZqPjEiuD14+NGohm4zyVYKnXAtH3u
         kFPD3mxVxTv44vCizwO42ZtmsieRT31DhMNejzRf97iuf8DuQ4K1216MQDfJ8H8BeQnx
         sehoQtpySQzQ6giZ8yGVebt/HHMtlwJgdO+KWRdxXdxu2fh057ozNdzdUXTnlQPEEeVs
         MmQLeS023u69900tECYJlyR6iPnrsORk/eJUTM7ZL+VhC1/S2JZsZfgTXd1GmERo6zsb
         82P0FWlIjRZWAoRah7SQ+ZlFtMciaMahIaeIlDOdViIYfnaE9XaYZTJ6kN4P23+cP+U4
         h9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367243; x=1767972043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=PPWceteYafKPILiF1RjdmUpmgaYDQKFM1NKc2shenNbXYa7r9cQQfWoHhZp5eMTqQP
         Ggm46IVxTjy8Vnwyn4FarsW6WjYEpAOBqzq2K4dqv2L0HV1J6cVJSzBJk64N4Yi62Jso
         XUG9JCN/2Pa4GGeoG+civP6EO+LF1O5gi9Q6C9c8hBpEsNyJEVdGGai//Rrf5pJ2zAUR
         DMaLOeRwL50oZLJMm41Tk208cFa0vFkUZjlPS2HgfwybW+ymhkXkPvk8lW8QXzLzF36t
         SM21j43b1IIA+kpXYqgd2FXqW5iluEOKzHH0FcvZ8U3e8vz1hYw14Y7kV2EO4Wi+crsF
         geBQ==
X-Gm-Message-State: AOJu0Yx0YkRnfG/YE5I2vjopuDATHULwSQqXMEzxcXWm0dpVs+JSnb8w
	9tDEh174v1KHrRjbO8Z81p0C5kBHllydbOXPUVGkKIG5rChfzAY0gWOP6MBMrhqu
X-Gm-Gg: AY/fxX4rNUhADzeqAyS3lPZUTiu2i4wSq2SDEyIYzEw4rPLakLa24/3ZSJz+KJBPCiH
	GGOxNvkhXgEgdy8iq1zp/KhBgmmVxUIOxzUI6QV1keUvWSfJKep+jEU7hyh0SCEL+gV5q6OX8uk
	rYloC5ggo343ifdSN1zQ5eYg8peC5dMZjac4DXByQvJ0BTCeFTema+7a/ZDj24UifaCh50K2Ij4
	MJu1hDHYJaR1Vqsu77oqEf4AopBEp7ofvFJfTe8izSi+AVnYMMiYsjGFvrqv8lIXlNytEdvanZz
	UvSGGKVZKwwIGpecLzvCd5A52JWXA7RaA2ud225KnYek/6PcOiyD00dsIYf9WyTrNn1jkt/a8RV
	nLdMIzsDJGwCbqVmPWi8zZrCLFKCxTcUFsQgSTJ8y56zd8SzCADO7LyufheAL+gRBjyYPAQWj/W
	nkrMxptZT2onjE8weXREQD36w=
X-Google-Smtp-Source: AGHT+IFMmIn+2/J2pbEHZ9vcoQ6zTgkAbud3TeSk4TfYXDj4qwzEgISl47tpMlZjJUNUzJ74kzK3hA==
X-Received: by 2002:a17:902:d4c7:b0:2a0:d7f6:e030 with SMTP id d9443c01a7336-2a2f2836757mr413049005ad.29.1767367242912;
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Fri,  2 Jan 2026 22:20:20 +0700
Message-ID: <20260102152023.10773-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

Due to the complexity of delayed refill worker, in this series, we remove
it. When we fail to refill the receive buffer, we will retry in the next
NAPI poll instead.
- Patch 1: removes delayed refill worker schedule and retry refill in next
NAPI
- Patch 2, 3: removes and clean up unused delayed refill worker code

For testing, I've run the following tests with no issue so far
- selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
without providing any descriptors to the fill ring. As a result,
try_fill_recv will always fail.
- Send TCP packets from host to guest while guest is nearly OOM and some
try_fill_recv calls fail.

Changes in v2:
- Remove the delayed refill worker to simplify the logic instead of trying
to fix it
- Link to v1:
https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/

Link to the previous approach and discussion:
https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: don't schedule delayed refill worker
  virtio-net: remove unused delayed refill worker
  virtio-net: clean up __virtnet_rx_pause/resume

 drivers/net/virtio_net.c | 171 +++++++++------------------------------
 1 file changed, 40 insertions(+), 131 deletions(-)

-- 
2.43.0


