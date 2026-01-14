Return-Path: <netdev+bounces-249764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC441D1D5D1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9031730FB4F0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8A38734E;
	Wed, 14 Jan 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsmucC2k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+7Hvj8L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81413806B0
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380832; cv=none; b=k0YuAC32Hxj6xoI00JtEEOiaStf/4jmVIbsLaxVi97ywb31kxdS37yi8Gk77wAebESUCKsfZcZ4R6XxaI7/GXraQe3K8nImPI2hBDR6vdnsoJo4H74Mlhy0PJOp7mQuJQiCE23GjGTehMyeemSXlI2iaUNdjo7jbwEnAZxZg/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380832; c=relaxed/simple;
	bh=eZ/xPxHf7fjSZecBeCp895uuqc9lBzIafLMnDn+UmVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opsNVGteWXQxbW71HODi+HZDyJQ3T5c38JUQlVHfGhbaRSSu91HifNUsLOPNqRi02qhoMedaq1L8BTqNQIL+L3Ph9N/Nm7GC66bHKoY3Aws204bJsQ7UNrq0N2gj08Hxv9kAO/dzA9UiXhHiRghJ1rDfT8BOD+bJaK5H/kbCb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsmucC2k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+7Hvj8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768380828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
	b=TsmucC2kWB0ChhoeKSZ1nsJpEdt7bVfm7MN7ZZPkrfNKL2zKGisB+p4MM+dzmX463lM/hm
	fbQCZwvZ+l4UboprMG77Q2+46r+fCjfkKV5xLYbxpBAnXh5nWHzTH3lIKMHjSdzp940C/S
	6akAh8wWcLWE19EHkm87iYLb23eLWJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-D2q5KM_CM5Ocopz2vIBFRA-1; Wed, 14 Jan 2026 03:53:46 -0500
X-MC-Unique: D2q5KM_CM5Ocopz2vIBFRA-1
X-Mimecast-MFC-AGG-ID: D2q5KM_CM5Ocopz2vIBFRA_1768380825
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcf10287so6845037f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 00:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768380825; x=1768985625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
        b=J+7Hvj8LUnDg9YNj/n0MhkSABu39Gm+b4EOmRfJi4slevja5Ps0iHxKuu6xBtOrvU2
         KZZ3N2LX+5WC73fzzM7B+MeXN2AkVMUauu0dNElZGHWL79pXzDV6THPhAchqK/uia0M9
         AKHm7M7sP/Cv2buBiMXtY6VEpRRRyAKFgdW/2wdCNJGcsl4IcrIAJvkYlaplHNsaL85O
         w/0ExxmGOF8iymJBnTmGTCbmi619Sw6DQxPv74eegAOh1RQZa13U+DoNAS1ObYxaOv8q
         tIfziXdJth/xpdoCpE4nL6VHu4ge1N0/bVMonNk1D6XO/5mYKvZWICF3AXa+oG71pi67
         4YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380825; x=1768985625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
        b=aHRTLQBB0s+CSXDOTKdFATxsH0HxBxK+ctxof+wsWGO+KvjAxx+FF0zHFdXlDdgaMo
         XkUjND19nXHBu0vW4gJB156ym18tMWXVPhIZFh89btMoZZeWarGRz0k1e3NO7vMCNHle
         +aqRlrxkHQnxvRUK2sdWjwi7f967dTUt7wL4RCzEONgXhmSgXk7gd6sNdNk/aI0KJzMn
         xEe7CvX6+SaW7nTOUZgF03oELclt2xOK+xgy/+X2piJBfs3cA4J5H12mFqRd+CZWPhhN
         zoXugl+Qi70HRrCc4IeTI6SpSkND0ukkXe9LDsaBsUYv1A/sPbBrXb/gkvfZMAEzCVAm
         iQuA==
X-Forwarded-Encrypted: i=1; AJvYcCXB5gMBanZVgpg2eLZb7+zD/7qiR1P9hn/quObbJtORizaE6xA4mRW8D76RMjm/oGWVLOfcNiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvkXpGLsEkiZoC50X684+tYEwsxV0d9kLuOCO28xfdyFJ636c
	Orcaqy52jeUoQ/9E6ShXHyOmd0xCBpawYmhfL/eMS/C81EDz6srtLDtKhiAkGDY6pF3KDbT2N48
	utksafln8Huz8qus9+PK0SEaDWom0KU7ApQ9JZqwi0TSeIOjRSbsLNadYOw==
X-Gm-Gg: AY/fxX537deK9zNoMf5sfMAFyQOeLtFjuyCVtDjawY0Z+u0DTn95TLSeaVGlKb3iTo5
	2YLG7RPiS582lJXsZPTlJGROEp8ttVHe4nsm5NfisBpH0O5ukuNd5kuhSjcjfbL84cfjoXQT1zV
	bhRYwJU5/pF1yIKT9ehHQXnh5G+RvOHDL2R5va5WjEX+dQaroQL+/me/oUwMyC1BovwxzQ64umx
	FNVUlvhflzpQg8tFzrUb98LHWqUJCUbreq6rv/K5pGVvIev2FosBdDHZEypANH5qEn41aI9KFZH
	vt6qBfbOGkW1yx5HYNijeUcG4sW5uPXWDT8vikb3PP+fjOQPKOt5tjzf1SZu7TQiMwh5r+KsCRw
	lvf7HQhYoQSB7uWMwoLGGyjICW1Xv+vg=
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16789125e9.16.1768380825317;
        Wed, 14 Jan 2026 00:53:45 -0800 (PST)
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16788915e9.16.1768380824817;
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b90d5sm17411505e9.2.2026.01.14.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Date: Wed, 14 Jan 2026 03:53:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260114035310-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>

On Sat, Jan 10, 2026 at 05:07:17PM +0900, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a result, the RSS key passed to the device is shifted by 1
> byte: the last byte is cut off, and instead a (possibly
> uninitialized) byte is added at the beginning.
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Seems to belong in net, not next.

Besides that:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
> 
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 22d894101c01..5cbcc9926a23 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -425,9 +425,6 @@ struct virtnet_info {
>  	u16 rss_indir_table_size;
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
> -	struct virtio_net_rss_config_hdr *rss_hdr;
> -	struct virtio_net_rss_config_trailer rss_trailer;
> -	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  
>  	/* Has control virtqueue */
>  	bool has_cvq;
> @@ -493,7 +490,16 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> +		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	);
>  };
> +static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> +	      offsetof(struct virtnet_info, rss_hash_key_data));
>  
>  struct padded_vnet_hdr {
>  	struct virtio_net_hdr_v1_hash hdr;
> -- 
> 2.43.0


