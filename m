Return-Path: <netdev+bounces-63832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B882F9A6
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8874C289CC8
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279361474CA;
	Tue, 16 Jan 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmWa/MAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038E1474C4;
	Tue, 16 Jan 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435012; cv=none; b=dJMK0MV8S1cpc4C5qf6b9izeBK0UC5DIFHjTur6qJH5s/jpGffycjzP6N81oZY2xOfExizBavwnQwg3kiPMAznK101A+GoDK7nJlKAyQkZ2uuwewapvNuUP/jkrvyz+Q89sxpVOYAda6eNNTOeeZ4vziVATptHwh2RsA+E9BoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435012; c=relaxed/simple;
	bh=y4eTy0OYL3qe1YUIm7vwjJt/28mMWOkdOb6hBk3Qpyo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=jgxBf+PATc1yvJghKLVhNcDkPDYNSDRX7uoHEzWV6OwH3dV/IX3d9Tc56ut/xAeo+BqdAwFxI3QVBsPQ9gUKb5qF6NHq2w0+BdPbTWFWm9N7OUUtakD/Gr62+TuSaXwiWt/ciEKqkfCrfQaSOyjjy6QVOi7x0je8pdDtnY9Zm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmWa/MAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F217C433C7;
	Tue, 16 Jan 2024 19:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435011;
	bh=y4eTy0OYL3qe1YUIm7vwjJt/28mMWOkdOb6hBk3Qpyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmWa/MAqMeTXtxBaEfWJov7N5/pwhRtiiBzKryCv0P4OzT3imln9bX7Ltv/WwURIs
	 1vQNSHYzny51Kymb5TNuurB7ByV05gkZqzAVrIpKbe04rV3vf3kTTdkWjrMiutty6L
	 CL+lED9FEeDh5URDXVygIuILLLTp6d7a2nz2SMV+GFRUf78nLQWlomYa+UUeb0/jHd
	 gY0zugl+NIyysd0Yr8Y934H0ooN4ScNv1Xh8PyVL+0StwH3Nlb2/nkWTff0kaam/xg
	 B5O2mDTuKo38H4krkmtroxyhX39zrLftqoe/a4QDUm+5bSzRnfWPHef17a5i3z5u7l
	 vdZCSs7tAPcRw==
Date: Tue, 16 Jan 2024 19:56:46 +0000
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of
 dim worker
Message-ID: <20240116195646.GF588419@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>

On Tue, Jan 16, 2024 at 09:11:33PM +0800, Heng Qi wrote:
> Accumulate multiple request commands to kick the device once,
> and obtain the processing results of the corresponding commands
> asynchronously. The batch command method is used to optimize the
> CPU overhead of the DIM worker caused by the guest being busy
> waiting for the command response result.
> 
> On an 8-queue device, without this patch, the guest cpu overhead
> due to waiting for cvq could be 10+% and above. With this patch,
> the corresponding overhead is basically invisible.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

...

> @@ -3520,22 +3568,99 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>  	return 0;
>  }
>  
> +static bool virtnet_add_dim_command(struct virtnet_info *vi,
> +				    struct virtnet_batch_coal *ctrl)
> +{
> +	struct scatterlist *sgs[4], hdr, stat, out;
> +	unsigned out_num = 0;
> +	int ret;
> +
> +	/* Caller should know better */
> +	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> +
> +	ctrl->hdr.class = VIRTIO_NET_CTRL_NOTF_COAL;
> +	ctrl->hdr.cmd = VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET;
> +
> +	/* Add header */
> +	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
> +	sgs[out_num++] = &hdr;
> +
> +	/* Add body */
> +	sg_init_one(&out, &ctrl->num_entries, sizeof(ctrl->num_entries) +
> +		    ctrl->num_entries * sizeof(struct virtnet_coal_entry));

Hi Heng Qi,

I am a bit confused.
With this series applied on top of net-next
struct virtnet_coal_entry doesn't seem to exist.


> +	sgs[out_num++] = &out;
> +
> +	/* Add return status. */
> +	ctrl->status = VIRTIO_NET_OK;
> +	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
> +	sgs[out_num] = &stat;
> +
> +	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> +	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
> +	if (ret < 0) {
> +		dev_warn(&vi->vdev->dev, "Failed to add sgs for command vq: %d\n.", ret);
> +		return false;
> +	}
> +
> +	virtqueue_kick(vi->cvq);
> +
> +	ctrl->usable = false;
> +	vi->cvq_cmd_nums++;
> +
> +	return true;
> +}

...

