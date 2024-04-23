Return-Path: <netdev+bounces-90435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF1E8AE1F6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512BAB21639
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7260B9C;
	Tue, 23 Apr 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f5f9jauX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B1605CE
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867488; cv=none; b=ie00rYBfzufGuSRFWojYeEv2ImAXkt5Sdk9aXhN72tk2m5SgBNQgp+K69Hi5nPbnmJekyc7r7pbLMxFwsd8qwO4u/VI2trGB+EgUOP4QsWjGPNd7TB9Pdrg/CEgh53LoC54A1Ta7kOFJ2SRy9Dbs8zTDBFjnPt6jiKSroPCZLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867488; c=relaxed/simple;
	bh=kkqIE0Y4DRPtCUs/sSOoUIPS1FebsbAyD8enDcphis0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl4yOmUY7o/8ce2/uvueq39/EolRI4wmKCuKSSAXCnBwCPA+frQBlHJ4JXp1gHKca53VmMiTPUg5YR8IivMRWCLI+gaAUZhaT/qY09hvBeDt0P/rVjJUTmRe/7xuQeR9JKkNIVNuUof0ZHwuAfrkwG77FM5YJ5mgip7j34EH7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f5f9jauX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso6565885a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713867483; x=1714472283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjAI/u9aTsfeTNEAGphzTSvRCRRtKSx3dGfB1X7fHEM=;
        b=f5f9jauXNOz/gru2x9BtyCzc3xPSpxK0wdkHcIVjZS7tOhqwA7fngZGyCt7wVUhrQO
         Tvpz0TO9i3FbqaCGBSUNZnZv+ekkE48aGQqdE8xXtbAiMmrGraeet88809kJj/lyofn1
         rSEyuhN8bJ+dTLPgeksXpCCT9gzxzJd01MYouG3maUfeUC6DB/Zt9DG5IgaHYKSQLLgP
         z9c3LbL04ScIo25DAL8kjA7qHVyeZuGBeozyq0ZflqkFh7a2+J/Lq3EF8IaMJb1RQ6ev
         ssINnJQitcvmJCj/wkUCs+rKzhlXI72RSgfwl42KuVsrC5L4zrUEs2F1AvnaFFPvUDfI
         4OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867483; x=1714472283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjAI/u9aTsfeTNEAGphzTSvRCRRtKSx3dGfB1X7fHEM=;
        b=YU+UDQbgXYkW9iDtFWH77KTYnuaEIbl+QILrUytNeIcJ3z1ZloWueL/PLAJhKoY1N2
         zacAWUxODXoTJK2JrCZmhu+/HWxl1T9QIVNarPNfBGaH/OWBL9ha7PNHnV5kFUF0cPyH
         DPpDz4EB40C+dHvEho42UGC0GSjxgMfWZGNlrtjW7dA+DOEZB0vtThGSW7jgTRJtgLvS
         Lqui5neystATRDwVKVczKoAb4cbspgb+onLOrHwVv5rmtGIv+aw1MW5V/G04WFEuwRzs
         lEURhlH+apO60LeN13NjNzKQy4113WItC2gLw0dSNKMkzam9DH5e/91TzSYJCkenEhWm
         Vt9A==
X-Gm-Message-State: AOJu0YyyWyKYqDrK5D3JivajjgT3ZQ8bEqf+KmLX+qzDIfpqOxyOkS45
	o5yulV8MHMx1iL1RSTjDnYRpSLqpHfkhr+xhYyJe6PSDhKfmXjUSutvWas1YDpo=
X-Google-Smtp-Source: AGHT+IFrpUA9BGDfzOFgMoFt6BOHOhg8GKgTOgeY0r+LlC7dYpKajZym1moY/r+ox+cVnvAc2GZjxA==
X-Received: by 2002:a50:8ad1:0:b0:56e:428d:77c1 with SMTP id k17-20020a508ad1000000b0056e428d77c1mr8244269edk.36.1713867483066;
        Tue, 23 Apr 2024 03:18:03 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h4-20020a0564020e0400b00571f140e6b6sm3548863edh.97.2024.04.23.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:18:01 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:17:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio_net: virtnet_send_command supports
 command-specific-result
Message-ID: <ZieK1lmc0czcEXWk@nanopsycho>
References: <20240423084226.25440-1-hengqi@linux.alibaba.com>
 <20240423084226.25440-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423084226.25440-2-hengqi@linux.alibaba.com>

Tue, Apr 23, 2024 at 10:42:25AM CEST, hengqi@linux.alibaba.com wrote:
>From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtnet cvq supports to get result from the device.

Is this a statement about current status, cause it sounds so. Could you
make it clear by changing the patch subject and description to use
imperative mood please. Command the codebase what to do.

Thanks!

>
>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> 1 file changed, 17 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 7176b956460b..3bc9b1e621db 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>  * supported by the hypervisor, as indicated by feature bits, should
>  * never fail unless improperly formatted.
>  */
>-static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>-				 struct scatterlist *out)
>+static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
>+				       struct scatterlist *out,
>+				       struct scatterlist *in)
> {
>-	struct scatterlist *sgs[4], hdr, stat;
>-	unsigned out_num = 0, tmp;
>+	struct scatterlist *sgs[5], hdr, stat;
>+	u32 out_num = 0, tmp, in_num = 0;
> 	int ret;
> 
> 	/* Caller should know better */
>@@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> 
> 	/* Add return status. */
> 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
>-	sgs[out_num] = &stat;
>+	sgs[out_num + in_num++] = &stat;
> 
>-	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
>-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
>+	if (in)
>+		sgs[out_num + in_num++] = in;
>+
>+	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
>+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
> 	if (ret < 0) {
> 		dev_warn(&vi->vdev->dev,
> 			 "Failed to add sgs for command vq: %d\n.", ret);
>@@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> 	return vi->ctrl->status == VIRTIO_NET_OK;
> }
> 
>+static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>+				 struct scatterlist *out)
>+{
>+	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
>+}
>+
> static int virtnet_set_mac_address(struct net_device *dev, void *p)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
>-- 
>2.32.0.3.g01195cf9f
>
>

