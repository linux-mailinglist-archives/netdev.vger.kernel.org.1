Return-Path: <netdev+bounces-92599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544C8B80A4
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99171F246F3
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C97199E99;
	Tue, 30 Apr 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="eW5L7EfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA8199E88
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505717; cv=none; b=QdgKFT1USlUlxXKEkcmC7+uypjD3+foeFIHoUKTeq4K5k9t6XPQiSSrbLFT4+IfBPrrLKWDlJnWdmFGZkpIYyvS0O1ODkI+L4am2n+CxJgoomjkON8k19Qkos5zZ4Hf+cBUk0nRKBW4O7PCkt6xmZOZTfe400BteLj2nMVmOUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505717; c=relaxed/simple;
	bh=8VoMAvq3zO3JVqiphTJGZqYC0YcLa4T9AVNVLehqUQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fdn6UojHF/jsS2ijSQQCg54kYxK/yjleisss7RhkS1AvbRb62hxfADB4f7mYeFu2Tu9qarDW17Y5qEc+4A8/cv7QoF1GY7X18iWmzu9As3V5cW8axTbppKLdqvwU68eW5YdpauoUHR6cVt2Gsc4T6i/jqVrpwwphMkkS/7jDNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=eW5L7EfS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b9365e584so1408846d6.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1714505714; x=1715110514; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=eW5L7EfS+DZQQuw6+gpxz+aI9APHdEVnOIubMZqG6Od+J1aaZ5fi4XEhZNCC+pc7Z3
         y6VpTW7S+0kK9zGw7l/kVOUBMquLGzNy2XiTNAqxIsP5tizKES31HLbmGO9tks4Ed43B
         T1TeQP3Xotp4TmRCNSentvpRne9GOIyrZXCP8nVjgFpGOITWkD+QCVhCynFI7ayCW2ZS
         0CkqURMOdG4XEXVbgr/J4uLyxc6+69APgh5CI6POr8IsoR8UzNeuvgBq0gcePZHvicHK
         Wv1TM50JVB5g+aOwdnqLrC7s/eHrYK349UQUKepEd+vcsMNZI56sx+8wuhQrdbjv/dhG
         +JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505714; x=1715110514;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=WQirci5lmqg0BZ2oRkgZYrmYtIsWF/YIoeYuKyulM0oZ6CJ5qIUxftqBzAZUdG3mzd
         Y5IYFgs6Hn2yCaMx9I/8Bi5s00yjKVZlIuJ/OeVFrrkVRP7wTldIyeVWLIsEfc9qfnHr
         YABf8lww0maet7go9o1KFzixIlooIBkkrdPn+NGZIE6rhx2lV+4kbo9kY4MyuyxoaMuA
         EfY5E173ycVBQ0OTLniCBsABociiIV4gWdpeXT5O3tABa8zNIyysoAgFMXO4mtY+lL9d
         39AjPieYEKu7rO42ARUr3KO1qtlV4bOISgqrlINlB6EtKsv2JQpVLFuLoG6clXYYpPYS
         33Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXu35ERwq1nN37trnGw7R2pYMWpJ7dn9E+8qBUPd9Uk5PqbEenI/He3qiqa7E0iERfhc/cqQjoLv6Ofb6yAFHSTHJ5ft/i8
X-Gm-Message-State: AOJu0YzLksPOwdMAMNHZGCrZJnt8zNzia+P4gKf/+AF+Q6zTm8ylxtKF
	WWO9elYtTcT+WSx9pru+N6K6LZHT/xdOvxhJLh8ggSkLYxoS4RoXtnyQFFAF
X-Google-Smtp-Source: AGHT+IGBKXU/7tRSFz93Y1xzcjPZPQaoRweolkwmfOyZ1X1BJG2s1+KA1acju3jrin1dLUxC2l0LEA==
X-Received: by 2002:ad4:4ee4:0:b0:69b:6b28:f941 with SMTP id dv4-20020ad44ee4000000b0069b6b28f941mr7236867qvb.20.1714505714112;
        Tue, 30 Apr 2024 12:35:14 -0700 (PDT)
Received: from localhost.localdomain ([102.129.235.205])
        by smtp.gmail.com with ESMTPSA id mg20-20020a056214561400b006a0cf4808dfsm2100850qvb.45.2024.04.30.12.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:35:13 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:35:09 -0400
From: Darius Rad <darius@bluespec.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: Warn if insufficient queue length for
 transmitting
Message-ID: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The transmit queue is stopped when the number of free queue entries is less
than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_MAX)
is less than then this, transmission will immediately trigger a netdev
watchdog timeout.  Report this condition earlier and more directly.

Signed-off-by: Darius Rad <darius@bluespec.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 115c3c5414f2..72ee8473b61c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 			set_bit(guest_offloads[i], &vi->guest_offloads);
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
+		netdev_warn_once(dev, "not enough queue entries, expect xmit timeout\n");
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
-- 
2.39.2


