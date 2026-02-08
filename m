Return-Path: <netdev+bounces-257820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2byDHMB4iGk5pwQAu9opvQ
	(envelope-from <netdev+bounces-257820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:51:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A910892A
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC73F3006533
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F2350297;
	Sun,  8 Feb 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwCBA5Bf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAZwi/pI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A8346AFB
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551484; cv=none; b=UTipgiVX8M+tpYCqITXvEnhDHv4V4r4u/eOAgiK7Og1QhpH2GhmHTKV9zXXK2oj7ag+kJ6lQSHhyY/fCT5s2m+/TLpZXUyt1GR7ZV6KrtUAgHdeq8I8Q4YN7mrTzOBU4pvO5HMxDo7zxk8mubjVkWOcTm2HCEu8iMDvJtCY9tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551484; c=relaxed/simple;
	bh=szyZEwcbocJlsixgDpDBc10mU9mA4Zxai2/gxEWEvY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Rbml5V130STxBtyowf0JKwIrssYKJcSxG7j/ttHfx0LG9Zsj+7ejgm4akkQciUsA6OtgZ4XImb5hszlXFtB0AOz6HsDULNurGG4ytBykbTFjo0JZzFKByZz7/Ws8ZuH2FF1xgIdeNzzC4KPjgOsi/8Psx3fuHg0bRss8n83ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwCBA5Bf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAZwi/pI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770551482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG+K5u1lYcIh7RSsdcTxsBa5qtFgqh0djxKHgXGJsPo=;
	b=WwCBA5BfOfKXq1M81jleKc9QMp3VCIELt0Euy0yJ3OFtQTgVkktZeRvym/6PBTikO6zjy6
	oi0+D9gsJpCpE33bEclKclgzNoQyhdADds9cKKj0xBW9jtADAcnSY+o+YWuDMoepW32uk7
	nZgiYrtJ9EtSbEbAq5CjICXXgW8fONM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-K4U1_VgaM3CjpAgtUf5VEQ-1; Sun, 08 Feb 2026 06:51:21 -0500
X-MC-Unique: K4U1_VgaM3CjpAgtUf5VEQ-1
X-Mimecast-MFC-AGG-ID: K4U1_VgaM3CjpAgtUf5VEQ_1770551480
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so42932595e9.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 03:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770551480; x=1771156280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG+K5u1lYcIh7RSsdcTxsBa5qtFgqh0djxKHgXGJsPo=;
        b=aAZwi/pIVTS17LBDK5FGClWKk2WjvBPWSiL2lgYUbw6jb5WUNB9jF9uncnW8rbeRF2
         KUFFtGm6tFYL195gZMsgN7r7ANOTEgOXHQ7UqgULPyQfZysy/1/fbsWjCEGdL/tO6vxc
         TBfG+scqyq7mXBix7g/8rPnkQm5AE58zrWoDtp0OucSNFOfj9yBtGvft5Ap6PD7gHQoE
         y5c3xN5UKsYx/edtdG1G17PBwtWWA50PZdA82qP0x+ZN+1NfQVmM283QHViOwRutcs+Q
         s/zcCDo9/L4KcOS366/fADtG1wcO90nI2/JZeLej8yAaLjr9mdoKkFcm2hzZV6ce0oRH
         GWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551480; x=1771156280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG+K5u1lYcIh7RSsdcTxsBa5qtFgqh0djxKHgXGJsPo=;
        b=sQwti9/8cmFX9H4sLZTgnTZvc3uj4Oa1jjlh1j6egnQNH6w+uehAVBSFAWtHmn+Szb
         dyDA723U8ZJtHJ0yyH8qHZbVRskMu/JcO0rTxgFVgYXfB/D+AuFjhJ/oWmHrqjDXQout
         dGNNQyRGB7717GcZNLnFIuBhYuLjh9HYoc2h84qWE7Jot2RsBs4U62NPYPsc6krXN/nj
         c/SpdjxpEXNHiPdx1XGv9L5xFeYyqqTEEw8eKW4sQwtMnzd2ftQR5dI962m8NR917VoZ
         q84EsLKwOSsoXryGrk54xyV4EngArk/dbwXIebfFmmxWZFXaeL7MkKc7kuBf17mObFAx
         5RXw==
X-Gm-Message-State: AOJu0YyAnsySgkqeE3F5MujC2Yd8h6Jvj+ZBmE54nef9P54cV/3EJKtU
	z3rMDekhbuj+2qG8i2syClZ1LGcGMrsbVzp+G8kjMSoNqAAANSJ+/sj+IOk4HkvF1ucDv3URkEW
	nOw1lRzE6wqqp11lHkecxXBmGm62fG3Eod5TNX5klnWIiCci9Il1yf32LzQ==
X-Gm-Gg: AZuq6aJuM+iMFrAJOdqA1Y2vKUK+wNfM67j5Aah7dp7dJ3g5RkdPAPU0VBqgb6BaR6+
	AHyMv48yYNVk98duOkFpmBbiAD21LE0gE1hyDOFECKu+Su/6N1MdNH6zId1tnl7hOaZfrdoHyG4
	vDe5V1PZX9+tzQQ26ezFNpLUhyNpGesLDd3bXGrWDPn3TzRss3fXCVbkw2747Tf309cpSYMMTF1
	Fq7A1lHWb0/jgjaquY7p9bmSFkh/SPIIpNMkX0LLIGa+uDqOAaNl8wcpWm3inQ45xvWJIvCtbs+
	63NkVnakRt7wAXzJmSIGiqc1vRC80MWIwrWnW/MubAPrXAkaHtHwEY6Z1Y1fPX4q3TH1RdAoKyC
	vzR+xD5QtlG7E6XI98cRVZ8VL6hhxJ/MwhA==
X-Received: by 2002:a05:600c:4748:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483201e4947mr123272475e9.12.1770551479859;
        Sun, 08 Feb 2026 03:51:19 -0800 (PST)
X-Received: by 2002:a05:600c:4748:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483201e4947mr123272095e9.12.1770551479293;
        Sun, 08 Feb 2026 03:51:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320736953sm186928345e9.15.2026.02.08.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:51:18 -0800 (PST)
Date: Sun, 8 Feb 2026 06:51:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20260208063807-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257820-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: CE8A910892A
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:47:00PM -0600, Daniel Jurgens wrote:
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
> 
> This patch adds uapi definitions virtio_net flow filters define in
> version 1.4 of the VirtIO spec.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> ---
> v4:
>     - Validate the length in the selector caps
>     - Removed __free usage.
>     - Removed for(int.
> v5:
>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>     - Use new variable and validate ff_mask_size before set_cap. MST
> v7:
>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
> 
> v8:
>     - Use real_ff_mask_size when setting the selector caps. Jason Wang
> 
> v9:
>     - Set err after failed memory allocations. Simon Horman
> 
> v10:
>     - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>       Jason/Paolo.
> 
> v11:
>     - Return -EINVAL if any resource limit is 0. Simon Horman
>     - Ensure we don't overrun alloced space of ff->ff_mask by moving the
>       real_ff_mask_size > ff_mask_size check into the loop. Simon Horman
> 
> v12:
>     - Move uapi includes to virtio_net.c vs header file. MST
>     - Remove kernel.h header in virtio_net_ff uapi. MST
>     - WARN_ON_ONCE in error paths validating selectors. MST
>     - Move includes from .h to .c files. MST
>     - Add WARN_ON_ONCE if obj_destroy fails. MST
>     - Comment cleanup in virito_net_ff.h uapi. MST
>     - Add 2 byte pad to the end of virtio_net_ff_cap_data.
>       https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
>     - Cleanup and reinit in the freeze/restore path. MST
> 
> v13:
>     - Added /* private: */ comment before reserved field. Jakub
>     - Change ff_mask validation to break at unkonwn selector type. This
>       will allow compatability with newer controllers if the types of
>       selectors is expanded. MST
> 
> v14:
>     - Handle err from virtnet_ff_init in virtnet_restore_up. MST
> 
> v15:
>     - In virtnet_restore_up only call virtnet_close in err path if
>       netif_runnig. AI
> 
> v16:
>     - Return 0 from virtnet_restore_up if virtnet_init_ff return not
>       supported. AI
> 
> v17:
>     - During restore freeze_down on error during ff_init. AI
> 
> v18:
>     - Changed selector cap validation to verify size for each type
>       instead of just checking they weren't bigger than max size. AI
>     - Added __count_by attribute to flexible members in uapi. Paolo A
> 
> v19:
>     - Fixed ;; and incorrect plural in comment. AI
> 
> v20:
>     - include uapi/linux/stddef.h for __counted_by. AI

AI has led you astray, sadly (




> ---
>  drivers/net/virtio_net.c           | 231 ++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++
>  2 files changed, 321 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..2cfa37e2f83f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,11 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
> +#include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/virtio_net_ff.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +struct virtnet_ff {
> +	struct virtio_device *vdev;
> +	bool ff_supported;
> +	struct virtio_net_ff_cap_data *ff_caps;
> +	struct virtio_net_ff_cap_mask_data *ff_mask;
> +	struct virtio_net_ff_actions *ff_actions;
> +};
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -488,6 +501,7 @@ struct virtnet_info {
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
>  		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  	);
> +	struct virtnet_ff ff;
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
>  	      offsetof(struct virtnet_info, rss_hash_key_data));
> @@ -526,6 +540,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void remove_vq_common(struct virtnet_info *vi);
>  
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -5684,6 +5699,192 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
>  };
>  
> +static size_t get_mask_size(u16 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return sizeof(struct ethhdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return sizeof(struct iphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return sizeof(struct ipv6hdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return sizeof(struct tcphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return sizeof(struct udphdr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{
> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> +			      sizeof(struct virtio_net_ff_selector) *
> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +	struct virtio_net_ff_selector *sel;
> +	unsigned long sel_types = 0;
> +	size_t real_ff_mask_size;
> +	int err;
> +	int i;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return -ENOMEM;
> +
> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +	if (err)
> +		goto err_cap_list;
> +
> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_ACTION_CAP))) {
> +		err = -EOPNOTSUPP;
> +		goto err_cap_list;
> +	}
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps) {
> +		err = -ENOMEM;
> +		goto err_cap_list;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
> +	if (!ff->ff_caps->groups_limit ||
> +	    !ff->ff_caps->classifiers_limit ||
> +	    !ff->ff_caps->rules_limit ||
> +	    !ff->ff_caps->rules_per_group_limit) {
> +		err = -EINVAL;
> +		goto err_ff;
> +	}
> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask) {
> +		err = -ENOMEM;
> +		goto err_ff;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);

So ff_actions is from device and ff_actions->count does not seem to be checked.

If device somehow gains a larger mask down the road, can it not then overflow?
or malicious?


> +
> +	if (err)
> +		goto err_ff_mask;
> +
> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
> +					VIRTIO_NET_FF_ACTION_MAX,
> +					GFP_KERNEL);
> +	if (!ff->ff_actions) {
> +		err = -ENOMEM;
> +		goto err_ff_mask;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);

So ff_actions is from device and ff_actions->count is not checked.

If device gains a ton of actions down the road, can it not then overflow?
or malicious?

> +
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;
> +
> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = (void *)&ff->ff_mask->selectors;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		/* If the selector type is unknown it may indicate the spec
> +		 * has been revised to include new types of selectors
> +		 */
> +		if (sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)

do you want to check sel->type 0 too?

> +			break;

but count remains unchanged? should we not to reduce count here
so device knows what driver can drive?


> +
> +		if (sel->length != get_mask_size(sel->type) ||
> +		    test_and_set_bit(sel->type, &sel_types)) {
> +			WARN_ON_ONCE(true);
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		if (real_ff_mask_size > ff_mask_size) {
> +			WARN_ON_ONCE(true);
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   real_ff_mask_size);
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->vdev = vdev;
> +	ff->ff_supported = true;
> +
> +	kfree(cap_id_list);
> +
> +	return 0;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +	ff->ff_actions = NULL;
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +	ff->ff_mask = NULL;
> +err_ff:
> +	kfree(ff->ff_caps);
> +	ff->ff_caps = NULL;
> +err_cap_list:
> +	kfree(cap_id_list);
> +
> +	return err;
> +}
> +
> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
> +{
> +	if (!ff->ff_supported)
> +		return;
> +
> +	kfree(ff->ff_actions);
> +	kfree(ff->ff_mask);
> +	kfree(ff->ff_caps);
> +	ff->ff_supported = false;
> +}
> +
>  static void virtnet_freeze_down(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
> @@ -5702,6 +5903,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +
> +	rtnl_lock();
> +	virtnet_ff_cleanup(&vi->ff);
> +	rtnl_unlock();
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5727,10 +5932,23 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			return err;
>  	}
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		virtnet_freeze_down(vi->vdev);
> +		remove_vq_common(vi);
> +		return err;
> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> -	return err;
> +	return 0;
>  }
>  
>  static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
> @@ -7058,6 +7276,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7073,6 +7300,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7121,6 +7349,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..552a6b3a8a91
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
> +#include <uapi/linux/stddef.h>
> +
> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
> +
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +	/* private: */
> +	__u8 reserved[2];
> +};
> +
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[] __counted_by(length);
> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: packed array of struct virtio_net_ff_selector.
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[] __counted_by(count);

This looks wrong to me. count is # of selectors (packed entries) not
bytes.




> +};
> +
> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
> +
> +#define VIRTIO_NET_FF_ACTION_DROP 1
> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
> +/**
> + * struct virtio_net_ff_actions - Supported flow actions
> + * @count: number of supported actions in @actions
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
> + */
> +struct virtio_net_ff_actions {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 actions[] __counted_by(count);


this too.

> +};
> +#endif
> -- 
> 2.50.1


