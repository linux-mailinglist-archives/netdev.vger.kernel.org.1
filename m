Return-Path: <netdev+bounces-95467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2A8C2516
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0FB1C220A4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54938127B70;
	Fri, 10 May 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjoqKFIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613F7BB17
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345454; cv=none; b=s8kYLPdro+gqe0rdMVwfLIwFNUd9zwr71rNeqRZU+DjgFeKHgdZkp7wS8bIltPGPmLk52oIuoerZImU0e3R5yDo8wYqIMyNsc383+w3emLI8DB8Tvxbd4VGCW49fYJaKSAv5KEk+sUGOmSJ66tQPsRUod1GYr5QhKm8mhJwbKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345454; c=relaxed/simple;
	bh=ko3uVA6VJm1NSJB8YRJHTV6RnbG8NXS2brijGf7c8Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPT0G9IcELCl0B86XRCmmUDG1apYVh0cBFGGDAzk0EcMOYN6LI5Uv//U2rsnjFvXv2KI3fkxW4omww9kgXOXZPLZANNabnI+8w0FHoiN0Q9vzgoJUHlhAQjq3DKRW6pAGocWi1umEVLoEyGA/o1SZzJnl2blRHfqP9PdhLIG5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RjoqKFIb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59b81d087aso498200166b.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345451; x=1715950251; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LM/odI6j/fMx3udtCezmjdbmQwQqNuohmtxS/7GVXYY=;
        b=RjoqKFIb+ypWZs2vOOmjq96n9WZETO0/+s0paF0ALSnhdSQP5YIoBBD9DMHq3rVMzK
         YUOQt6icneD0DJEuZahSncPsHK23mjb9wE2HX5lAOLW/j/BzU45zfNqo3iayjdUHWisN
         3zeLVJsL/Ygoe0HnzyMnLdpPC81KdFjJwEK3P+1KXBBwxsFr3kYsGwFzvNARdngyW7NZ
         OpWLR6BgvlmWK+yy9276m3gF+DVXALevXZgxzflub3WQoe66hPEMKdib5FTerCMKzu8G
         jnwPY10VMnqJKGcxRbffly7ajd8quzynBu8kOq5HdgSfdmKTmE/wMIi/hiDPMwNbIGEh
         zd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345451; x=1715950251;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM/odI6j/fMx3udtCezmjdbmQwQqNuohmtxS/7GVXYY=;
        b=s3AelUdPdUmulp+scYRPWPUb8yXmgYtxAc2Q9v3vuRG9fyjRnFuLwCo/89kX1xnpfR
         3SYXqq+D0eed9Ys0EKjmAc8MXfP+lPPKYCA9iT02MrInrS21Jiq/d7mCGLT1ZQrbkajr
         wE8jC2OCQB6sN0Y2B4nVEIkFdznA5CRAiv/lyIfnf+ejDGqgYegwiYv3pPgEkx6So9Gc
         9rCgZXxwV5KkcFx/ZeLZR0FjxfoK7ZoUXDSNpX8qrGjkR0jX4Qt0Mx0d00tiO1tAgt/J
         UDlNiV+eNy0DIzgHOcSHLOm3Dk9gggMqFe3MQO8zeW63cy1B2gbautn06aFfTgcKGlE4
         hVig==
X-Forwarded-Encrypted: i=1; AJvYcCUkYbW3t/tSTSqzJLQ4PjD9Epl+x/e/TrS6jnzz7e+y8QakH1wefCkGbvWmNCmpi3qZexiJWMVJs+sAmHPax9sA5sOgwzAO
X-Gm-Message-State: AOJu0YxrYZAusY7RRxVho3R47scxBeEMPOhsRY/o1GLEryeELnr+/3jh
	t2R7RQSfyR5Ab64VGljunAlqw2r9ZKsgJz4GaAVctf9jliNLC88y0GV03nUFt2o=
X-Google-Smtp-Source: AGHT+IEp74LXPMOrN4jcdcnJvpP4z0aouu/s0LV8Wdwfhk/MAZjj1kgHFHoHWXY/x0HaMZmy3440fg==
X-Received: by 2002:a17:906:80a:b0:a59:b784:ced3 with SMTP id a640c23a62f3a-a5a2d676b2emr194516266b.77.1715345450478;
        Fri, 10 May 2024 05:50:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c814dsm180050666b.118.2024.05.10.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:50:50 -0700 (PDT)
Date: Fri, 10 May 2024 15:50:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The virtnet_send_command_reply() function returns true on success or
false on failure.  The "ok" variable is true/false depending on whether
it succeeds or not.  It's up to the caller to translate the true/false
into -EINVAL on failure or zero for success.

The bug is that __virtnet_get_hw_stats() returns false for both
errors and success.  It's not a bug, but it is confusing that the caller
virtnet_get_hw_stats() uses an "ok" variable to store negative error
codes.

Fix the bug and clean things up so that it's clear that
__virtnet_get_hw_stats() returns zero on success or negative error codes
on failure.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..4fc0fcdad259 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4016,7 +4016,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 					&sgs_out, &sgs_in);
 
 	if (!ok)
-		return ok;
+		return -EINVAL;
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
@@ -4053,7 +4053,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct virtio_net_ctrl_queue_stats *req;
 	bool enable_cvq;
 	void *reply;
-	int ok;
+	int err;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
 		return 0;
@@ -4100,12 +4100,12 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	err = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
 
 	kfree(req);
 	kfree(reply);
 
-	return ok;
+	return err;
 }
 
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)


