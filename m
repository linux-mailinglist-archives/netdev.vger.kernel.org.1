Return-Path: <netdev+bounces-260833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGw2IrDBnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D79195092
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E4D8305766D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCE38B7D5;
	Wed, 25 Feb 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yWlss9bZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2EE38E10B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011333; cv=none; b=fXQnHHkbnB9d30oH9ahuNF5IacdyoAWvS4uMvwUE/43ryZPkbBQn7ovEDRSh6vXqH44CNhlxT9MEKm5CTklgavHOoXDhoO5DW1zA+Olh+e/cZu5xgTqj4KtAMKO4CCoqQoUOz0fiUC5vSiWevEVBlwGKz6mSW+I76KCDv9y80v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011333; c=relaxed/simple;
	bh=usJdWGjdVWHyoeOFLpeq87JVlSPKqO+60Ixrrf+Cd2w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HtFibpqwL21fVN6JeKCxjSWDV7TTui70Vkee8bP2ektDR6GF1PRNVmRwGsuoF9dekAepLZogl0JyeTDGeY66jdRcZdYwiBaChAwqT8JIZQANzIJSi2d4qgsJpSFnS5iU5WAdzey2KnFhXKPI66HGmsxZF8FJNynf4xquFJkRAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yWlss9bZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772011322; h=Message-ID:Subject:Date:From:To;
	bh=Jij/vp1VmGg7OCxxZ+6UMDbKQTv+EwP6Pty7TdVomV0=;
	b=yWlss9bZB1aI9+tW0k6ICUYUgnMs0LTF+W2p5TCp91YEbokbqJQsir9sIU+/wKk7mab8rz63LoxjGIhIukf86PpKs31DtF2Fs1BVjHgsuh1cSSuSnVn34QwzmnBK//2HtFeBIj6O00umXmvGfT0pxO+O26uatGzJk/uu0TtC4SI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3MxA_1772011321 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:22:02 +0800
Message-ID: <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:11:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Srujana Challa <schalla@marvell.com>
Cc: <pabeni@redhat.com>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <ndabilpuram@marvell.com>,
 <kshankar@marvell.com>,
 <schalla@marvell.com>,
 <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
In-Reply-To: <20260224065850.962826-2-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260833-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: A6D79195092
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> BUILD_BUG_ON to enforce the limit at compile time and remove the
> redundant runtime max check.
>
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eeefe8abc122..768ad5523dfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
>  		}
> -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> -			dev_warn(&vdev->dev,
> -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> -				 key_sz, NETDEV_RSS_KEY_LEN);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> -		}
> +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);

Do we really need this check?

If I understand correctly, the intention is to cap key_sz at 256. However, since
key_sz is of type u8, its maximum value is inherently 255, making this check
redundant. This is not only limited by this kernel code, the virtio-net spec
defines this.

Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
the future, this check would no longer enforce the intended limit correctly.


Moreover, you should add a cover letter.

Thanks.





>  	}
>
>  	return 0;
> --
> 2.25.1
>

