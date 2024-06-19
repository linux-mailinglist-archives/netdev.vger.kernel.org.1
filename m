Return-Path: <netdev+bounces-104782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51590E570
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614501C211F5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423BC78C89;
	Wed, 19 Jun 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk0xJELf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBD78C6D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785420; cv=none; b=JUT4f5BjTiF6TQsqlWwAp+w5uak0g7SjQI+UZXmNR+AtTqn7pq3psVoUbKhoJMdCblYuLp1v7+v5fZoVr7n9WXiMxO0PmQwqRQYJLz99O2zZwus+H+dl7qA8iJH95xAF3Jsi0/octugrW4wpgr+EPl6w/UNlGa1Jp0f1vbgT1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785420; c=relaxed/simple;
	bh=1r2r1mo809XHPfX4nFBHYA2qqwgkRP6qRQkzKgL3468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQUXpwfyqXzV6/io/jAzJtAEBi24fRjwXYCX4NmGLVuzKZstjBKDA61TwFq6ZYVgyfyUCwH3lX5vYQ5UAT0hKJbNHZYPukLAGQ6ZhsEny6yYhPTg1boRJBU5p/+OqTZZIWOzYPcS+kMOB+iruTLjj8ZEWDaacbe7P098UfSrtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bk0xJELf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mv+7UUQxiQBs1YPoD5zt8EOL8V4BVjDfcl2HJp8+ARY=;
	b=bk0xJELfS5auuXOJ60tKTiZU+0x3D3g+6sRNaCmDm2iK4jZFAIrAke5wBsAJLMRsC1DBCV
	kADrRnQ1SlnMe8pR6awfQvlzsCbnCt3ruAvDAjipMvFmTm5by4aJDxxlTYrFD56VFY206r
	ibnzxm+wuAn6RTfyRXH9VlAF+ZAm/Hc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hFCccwDgNAu-HjYgwqsOng-1; Wed, 19 Jun 2024 04:23:34 -0400
X-MC-Unique: hFCccwDgNAu-HjYgwqsOng-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec3d6c2cf1so5275951fa.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785412; x=1719390212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv+7UUQxiQBs1YPoD5zt8EOL8V4BVjDfcl2HJp8+ARY=;
        b=XbrG2NHgQInB6YA2t+9Yx7CDG5xZQ3ta5mRail8BL6DLvqu/JTeKwA1GlYxDcSPoyA
         M1BBJdQL5ZYvdX1bIEmuqrpeVArCYsnzLv2fgmqBpdFrBuv6VmY/YxxTtV5xIQWQcxCK
         Y7SAgHHkdMD87zJdvilftvii27ialSbxdk1BKC9XZdRdVP/33oPrF0N+NvHZ4pVdoGT4
         kCihKkw/xwYifIMCoflDpzimMXGOaoudEg3O9BxFoVhknBrVZVWhHVJVuQjb6e3IQsB2
         TTBJgNwAU0CtKnCSBLMdKKIXbSkBufsoHomFBC/JOOd4VVrk++dvZpBoQRK92kLrXfMI
         +2ZA==
X-Gm-Message-State: AOJu0YwQ4fqhg9keaNzfep5R9EsYKnocPdaiJZFe2rfBnRGwgOwM8IUG
	wJ+ZbgeWvAPdJV83bIl0pFGsvK6G5KilxeqrfThXgxv23Hs8xxRcr3D5lNWG/bmTjNRgLGDRdsC
	WnmPmPerMBMAQ6hIINMWxV7zAsOx0bZvKyjD+CIw8sfWaQNpSyPIkig==
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr13011111fa.52.1718785412563;
        Wed, 19 Jun 2024 01:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhobomt5nQneEV52RdktjcK4sr2LisHRIHFSb0MJ/6597zjHdM0Q2o7umWKIPsMzzOnHq9Og==
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr13010391fa.52.1718785410630;
        Wed, 19 Jun 2024 01:23:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm257535715e9.7.2024.06.19.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:23:29 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:23:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619041846-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKRVS6fDNIwQDEM@nanopsycho.orion>

On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >we remember not to call __free_old_xmit twice in a row
> >without reinitializing stats.
> >Or move the initialization into __free_old_xmit to make it
> >self-contained ..
> 
> Well, the initialization happens in the caller by {0}, Wouldn't
> memset in __free_old_xmit() add an extra overhead? IDK.


Well if I did the below the binary is a bit smaller.

If you have to respin you can include it.
If not I can submit separately.

----


virtio-net: cleanup __free_old_xmit

Two call sites of __free_old_xmit zero-initialize stats,
doing it inside __free_old_xmit seems to make compiler's
job a bit easier:

$ size /tmp/orig/virtio_net.o 
   text    data     bss     dec     hex filename
  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
$ size /tmp/new/virtio_net.o 
   text    data     bss     dec     hex filename
  65760    3892     100   69752   11078 /tmp/new/virtio_net.o

Couldn't measure any performance impact, unsurprizingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..c2ce8de340f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	unsigned int len;
 	void *ptr;
 
+	stats->bytes = stats->packets = 0;
+
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 
 	__free_old_xmit(sq, in_napi, &stats);
 
@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;


