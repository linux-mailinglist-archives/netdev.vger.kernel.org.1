Return-Path: <netdev+bounces-298360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pfW4MFsnK2o+3QMAu9opvQ
	(envelope-from <netdev+bounces-298360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5B6756B9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H95vImIr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F732307F52F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48199377EBF;
	Thu, 11 Jun 2026 21:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEA366066
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:23:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213017; cv=none; b=ka5YDYii0OBcklc8xnchCo+jKHPMQu/MeAby7nIK5DNznMS0sS6AtDD3wjNlFhoGyiMA7hR51uz904Ac0fp5r8/9p9+f66oaZOg7VkzCJgDnIfUVxqKK6gm/+qaLfmjMWxJtSiFvD1duQ+DVRu46U2tZH0eisXuwPNisG7PNhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213017; c=relaxed/simple;
	bh=j8Ae9c2TI2acGrdjjx6wYRViV7N/j+uErXjyesTBpgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Muh1gXqibsXGreEYoLsnRzzBY8JOs7TYpxCOplSg36lp/s0DEu9Z5BM9ooWRhlZL4UbWhOplZWeYYoDqcF4etTJgmz6bZbNlDDmiRL/Vh3I3EU9pCl/Cgm8C+q4oq0ZFtt3LYz2KXE9a9GU9h92GM0dbCOaVpIUudFJPHtOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H95vImIr; arc=none smtp.client-ip=209.85.214.196
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c0c35980fdso2649175ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781213015; x=1781817815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pf4hM3mtMXeX14ohE4XQ1BSat2dxo+IW9rTwJbBXy14=;
        b=H95vImIrcdxt5SBXRJDGoxJuatqe5DcA8886Q6RoMe6UQakx7GED9h7uh8mOTXQfW5
         Bv/JxAt8MWuJa4ycWqAQJ4uGSV3KIOEbYl/DG3IbvlMWLrT1Y3e2rq1JhtHAAi2npBh+
         /l898b7zMS5F4COjv1AvJqMpybUuHHJSx9jy5prbSr472M9rysFkYUcA3A2OeOCYBmFb
         l8DhKAFdzS1j/PCJmK1K6v0ZcJbdq241JwzmUV1uKiE73ODcy9DRLcLkHcH0jzUDQmjx
         M5eXaL+9MXAmRrJ1yAUmM1t5jgLmzSFKVk6diY/v9qMh1G+vOOpqRNcF8dWgb04EkaDz
         Uq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213015; x=1781817815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf4hM3mtMXeX14ohE4XQ1BSat2dxo+IW9rTwJbBXy14=;
        b=RHJHxAz6U83W7LtKaWlIlQ9+Ah0PKZrInyZcHYDV9xXmp1JTG3pj4A4MjQw7ywTT19
         u7/G2QNQTHPauy5Szq3sL7YCqczX63YL8l7EFzigcUYNcmGBq3h0oPrU39Rbe4aiNOO7
         QSikfEs9thQp3c5qhPU1j3YWl0pF1wFVOm5JKy2wOE2SYwfsOAtw6nDSrtQCUjp4TpcU
         N9iB77xRmEV2pU9UgJoIxCuaCk6POXY4kNUfsyD3WweF9jQPfMOf7bimMQraIiiSfxQe
         5U58q6eB/xnBzwGDEuW/jr01m0Dr4oK4DEOIk99DDr7NE5IOR+IXpZeUR+XCXuoK/NkI
         262Q==
X-Forwarded-Encrypted: i=1; AFNElJ/8L95IdY2qRM3YAwF6/qR4jpARjFPFsSnf7FB2c5J09ZHAVVt5dXwEX9YQhTL+LWtnkBSkz8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjoarn77UqMlFZ15x/9nxI7+LIe397M0PueJIW/ZY6MbqRddHs
	V8QjmO+UUWW/tB1+iXd0sCId7LICEBHP0SXU2jR/t4W3GKYvLyYb+UFD
X-Gm-Gg: Acq92OGpIw2voocG1lbcN3jyM6kdi4LyXsvmbxEfIlQVZdBO+GsB+vcdSWqWawQ5Tr1
	Gsw4kI5dZYi2R9vz9ShdS6O9UArYftgl1TZhhlAmwllMuq5b+8AbBHh4l+o9kKAlo7ne7bA+jlt
	jVVz3L7eX6InGLgNH5rYXCkgvcUVz2AoP072OieDnPkjMt2iVp2pV7ojKPl0b9CUGDYczqK9BTZ
	niLa0FZcXRCSshSOn12RnFmdZUIhSx8lxEChm6wPt1G/0S1fa8vPBYuycDqbiuEsyML1fwE0M/o
	JKq2+DKorFY1f0dng0c3ttvC4WnnUQHVDYQIaae8ol4bS+x1E12NKhXZnxBroEnP8kEhlf72HaT
	SmqPrC6/W9grkaR/rLD2kWLDxrqx4SNN8a7r1k0ye55t+7t9NYmaLr1+ub/M+4Xf4vpn3CErpFS
	LY3XgSSqZT+9oTYTIx
X-Received: by 2002:a17:903:4b47:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2c41235e35cmr1293665ad.23.1781213014941;
        Thu, 11 Jun 2026 14:23:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c415173581sm347535ad.79.2026.06.11.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:23:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:12:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, sdf@fomichev.me, 
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com, matttbe@kernel.org, 
	skhawaja@google.com, dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 1/4] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <aiskekd4GCLIhC0E@devvm7509.cco0.facebook.com>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-1-ee2bf15e7523@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-tcpdm-large-niovs-v2-1-ee2bf15e7523@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298360-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,meta.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16D5B6756B9

On 06/11, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
> churn for large flows.
> 
> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
> lets userspace request a larger niov size. The value must be a power of
> two >= PAGE_SIZE.
> 
> Measurements
> ------------
> Setup: kperf in devmem RX/TX cuda mode, 4 flows, 64 MB messages, 60s,
> dctcp, num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov
> size, mlx5.
> 
> CPU Util:
> 
>    niov        net sirq %        net idle %         app sys %        app idle %
>   -----  ----------------  ----------------  ----------------  ----------------
>      4K   62.38 +/-  8.27   33.40 +/-  7.51   54.15 +/- 10.23   43.67 +/- 10.53
>     16K   58.91 +/-  5.35   35.23 +/-  5.88   41.05 +/-  8.87   56.42 +/-  9.24
>     32K   64.12 +/-  0.68   31.09 +/-  1.48   44.54 +/-  3.51   52.63 +/-  3.65
>     64K   54.69 +/-  5.54   39.67 +/-  5.81   35.47 +/-  3.11   61.97 +/-  3.27
> 
> RX app sys % drops ~19% from 4K to 64K.
> 
> Throughput:
> 
>    niov       RX dev Gbps   RX flow avg Gbps
>   -----  ----------------  -----------------
>      4K  300.63 +/- 53.21    75.16 +/- 13.30
>     16K  321.35 +/- 28.20    80.34 +/-  7.05
>     32K  347.63 +/-  2.20    86.91 +/-  0.55
>     64K  332.11 +/- 14.26    83.03 +/-  3.56
> 
> Throughput seems to increase, but the stdev is pretty wide so could just
> be noise.
> 
> kperf support (not yet merged):
> https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  Documentation/netlink/specs/netdev.yaml |  8 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/devmem.c                       | 51 +++++++++++++++++++--------------
>  net/core/devmem.h                       | 13 ++++++---
>  net/core/netdev-genl-gen.c              |  5 ++--
>  net/core/netdev-genl.c                  | 19 ++++++++++--
>  tools/include/uapi/linux/netdev.h       |  1 +
>  7 files changed, 69 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 49862b666d7d..395eaa0f9580 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -591,6 +591,13 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: rx-buf-size
> +        doc: |
> +          Size in bytes of each RX buffer the NIC writes into from the bound
> +          dmabuf. Must be a power of two and >= PAGE_SIZE; defaults to
> +          PAGE_SIZE.
> +        type: u32
>  
>  operations:
>    list:
> @@ -805,6 +812,7 @@ operations:
>              - ifindex
>              - fd
>              - queues
> +            - rx-buf-size
>          reply:
>            attributes:
>              - id
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 7df1056a35fd..180a4ffffd60 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -217,6 +217,7 @@ enum {
>  	NETDEV_A_DMABUF_QUEUES,
>  	NETDEV_A_DMABUF_FD,
>  	NETDEV_A_DMABUF_ID,
> +	NETDEV_A_DMABUF_RX_BUF_SIZE,
>  
>  	__NETDEV_A_DMABUF_MAX,
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..3ce3cc14bec0 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -46,7 +46,7 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>  
>  	owner = net_devmem_iov_to_chunk_owner(niov);
>  	return owner->base_dma_addr +
> -	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> +	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
>  }
>  
>  static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
> @@ -93,13 +93,14 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	ssize_t offset;
>  	ssize_t index;
>  
> -	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +	dma_addr = gen_pool_alloc_owner(binding->chunk_pool,
> +					1UL << binding->niov_shift,
>  					(void **)&owner);
>  	if (!dma_addr)
>  		return NULL;
>  
>  	offset = dma_addr - owner->base_dma_addr;
> -	index = offset / PAGE_SIZE;
> +	index = offset >> binding->niov_shift;
>  	niov = &owner->area.niovs[index];
>  
>  	niov->desc.pp_magic = 0;
> @@ -113,12 +114,13 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>  {
>  	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
>  	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> +	size_t niov_size = 1UL << binding->niov_shift;
>  
>  	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
> -				       PAGE_SIZE)))
> +				       niov_size)))
>  		return;
>  
> -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
>  }
>  
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> @@ -163,6 +165,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  	u32 xa_idx;
>  	int err;
>  
> +	if (binding->niov_shift != PAGE_SHIFT)
> +		mp_params.rx_page_size = 1U << binding->niov_shift;
> +
>  	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
>  	if (err)
>  		return err;
> @@ -184,14 +189,16 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       struct device *dma_dev,
>  		       enum dma_data_direction direction,
> -		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
> +		       unsigned int dmabuf_fd, unsigned int niov_shift,
> +		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> +	size_t niov_size = 1UL << niov_shift;
>  	static u32 id_alloc_next;
> +	unsigned int sg_idx, i;
>  	struct scatterlist *sg;
>  	struct dma_buf *dmabuf;
> -	unsigned int sg_idx, i;
>  	unsigned long virtual;
>  	int err;
>  
> @@ -213,6 +220,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  	binding->dev = dev;
>  	binding->vdev = vdev;
> +	binding->niov_shift = niov_shift;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>  
>  	err = percpu_ref_init(&binding->ref,
> @@ -248,18 +256,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  			goto err_unmap;
>  		}
>  		binding->tx_vec = kvmalloc_objs(struct net_iov *,
> -						dmabuf->size / PAGE_SIZE);
> +						dmabuf->size >> niov_shift);
>  		if (!binding->tx_vec) {
>  			err = -ENOMEM;
>  			goto err_unmap;
>  		}
>  	}
>  
> -	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> -	 * binding can be much more flexible than that. We may be able to
> -	 * allocate MTU sized chunks here. Leave that for future work...
> -	 */
> -	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
> +	binding->chunk_pool = gen_pool_create(niov_shift,
>  					      dev_to_node(&dev->dev));
>  	if (!binding->chunk_pool) {
>  		err = -ENOMEM;
> @@ -273,9 +277,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		size_t len = sg_dma_len(sg);
>  		struct net_iov *niov;
>  
> -		if (!IS_ALIGNED(len, PAGE_SIZE)) {
> +		if (!IS_ALIGNED(dma_addr, niov_size) ||
> +		    !IS_ALIGNED(len, niov_size)) {
>  			err = -EINVAL;
> -			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "dmabuf sg entry (addr=%pad, len=%zu) not aligned to niov size %zu",
> +					   &dma_addr, len, niov_size);
>  			goto err_free_chunks;
>  		}
>  
> @@ -288,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  		owner->area.base_virtual = virtual;
>  		owner->base_dma_addr = dma_addr;
> -		owner->area.num_niovs = len / PAGE_SIZE;
> +		owner->area.num_niovs = len >> niov_shift;
>  		owner->binding = binding;
>  
>  		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
> @@ -313,7 +320,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
>  			if (direction == DMA_TO_DEVICE)
> -				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> +				binding->tx_vec[(owner->area.base_virtual >> niov_shift) + i] = niov;
>  		}
>  
>  		virtual += len;
> @@ -430,13 +437,15 @@ struct net_iov *
>  net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
>  		       size_t virt_addr, size_t *off, size_t *size)
>  {
> +	size_t niov_size = 1UL << binding->niov_shift;
> +
>  	if (virt_addr >= binding->dmabuf->size)
>  		return NULL;
>  
> -	*off = virt_addr % PAGE_SIZE;
> -	*size = PAGE_SIZE - *off;
> +	*off = virt_addr & (niov_size - 1);
> +	*size = niov_size - *off;
>  
> -	return binding->tx_vec[virt_addr / PAGE_SIZE];
> +	return binding->tx_vec[virt_addr >> binding->niov_shift];
>  }
>  
>  /*** "Dmabuf devmem memory provider" ***/
> @@ -454,7 +463,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>  	pool->dma_sync = false;
>  	pool->dma_sync_for_cpu = false;
>  
> -	if (pool->p.order != 0)
> +	if (pool->p.order != binding->niov_shift - PAGE_SHIFT)
>  		return -E2BIG;
>  
>  	net_devmem_dmabuf_binding_get(binding);
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 3852a56036cb..4a293a7d1149 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -71,6 +71,8 @@ struct net_devmem_dmabuf_binding {
>  	 */
>  	struct net_iov **tx_vec;
>  
> +	unsigned int niov_shift;
> +
>  	struct work_struct unbind_w;
>  };
>  
> @@ -93,7 +95,8 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       struct device *dma_dev,
>  		       enum dma_data_direction direction,
> -		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
> +		       unsigned int dmabuf_fd, unsigned int niov_shift,
> +		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack);
>  struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
> @@ -122,10 +125,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
>  
>  static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
>  {
> -	struct net_iov_area *owner = net_iov_owner(niov);
> +	struct dmabuf_genpool_chunk_owner *co =
> +		net_devmem_iov_to_chunk_owner(niov);
>  
> -	return owner->base_virtual +
> -	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
> +	return net_iov_owner(niov)->base_virtual +
> +	       ((unsigned long)net_iov_idx(niov) << co->binding->niov_shift);
>  }
>  
>  static inline bool
> @@ -175,6 +179,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       struct device *dma_dev,
>  		       enum dma_data_direction direction,
>  		       unsigned int dmabuf_fd,
> +		       unsigned int niov_shift,
>  		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack)
>  {
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index d18c89b5a6c7..447ed06d8c74 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -106,10 +106,11 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
>  };
>  
>  /* NETDEV_CMD_BIND_RX - do */
> -static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
> +static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_RX_BUF_SIZE + 1] = {
>  	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
>  	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
>  	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
> +	[NETDEV_A_DMABUF_RX_BUF_SIZE] = { .type = NLA_U32, },
>  };
>  
>  /* NETDEV_CMD_NAPI_SET - do */
> @@ -219,7 +220,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>  		.cmd		= NETDEV_CMD_BIND_RX,
>  		.doit		= netdev_nl_bind_rx_doit,
>  		.policy		= netdev_bind_rx_nl_policy,
> -		.maxattr	= NETDEV_A_DMABUF_FD,
> +		.maxattr	= NETDEV_A_DMABUF_RX_BUF_SIZE,
>  		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5..8709e9c94389 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1012,6 +1012,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	u32 ifindex, dmabuf_fd, rxq_idx;
> +	unsigned int niov_shift = PAGE_SHIFT;

nit: keep the Christmas tree? With that addressed:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

