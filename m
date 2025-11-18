Return-Path: <netdev+bounces-239743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1397C6BEFC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7EA9366C15
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37D302CDB;
	Tue, 18 Nov 2025 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTyXNwzA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIRxIt/J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB7370304
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507035; cv=none; b=EEJQYU3HPG6QAUTWPZvH9v7TSlb/k3HyvHtA+A7zv6GjYYDqX53wAZmt8ekqa5rYx9J5KanOKMet7P6XEihtJguixuqiMWbvg7Cgl1pohXVSJZNV2BjbJcvfV1PWvVL2Scg/YXE71NgCaKbs5RcotYqlccN5f2tfVaYcOT5Rm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507035; c=relaxed/simple;
	bh=npYF6+AoUb8b1KIGpdUB0fhvvN8s8pNeq8v6fSg+u80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSwPvMyzubSvZFJo4hR8toqlWcbtW+iemkKAXsnm9SOmqtc7xEwU/X7CPtEoHKiuSDlFmFiTWGXP0tneiFbweHNxEjzMENfUqncLpXWCN4Drn3qiiv4vl7XhIJHpfr/aG3zVt4jMSgJdGi6HObjrBK4O0o9ny4UExT85J+NH5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTyXNwzA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIRxIt/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763507032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8udVISHoFxlp3Sg2p6zdhaYur6w2cog8DmQ4evuWtRM=;
	b=aTyXNwzAOYjAkzLgitEyke7DR0EHbbqnrMwH2wfWgZ4H99r48awLVlwga/6oVlJOdnVMp4
	YnnVslOQSOnFs1jelLpAxPSx0tBEs2sagDMHUJ1bQoH6dW7jkGUuWywkqebRgMaRgphDhC
	Pu+thasATAAV3E3hu27M1AKXP1k0EFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-kDhPlr33P4GsSQTEB7UWDg-1; Tue, 18 Nov 2025 18:03:50 -0500
X-MC-Unique: kDhPlr33P4GsSQTEB7UWDg-1
X-Mimecast-MFC-AGG-ID: kDhPlr33P4GsSQTEB7UWDg_1763507029
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477212937eeso39280775e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763507029; x=1764111829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8udVISHoFxlp3Sg2p6zdhaYur6w2cog8DmQ4evuWtRM=;
        b=IIRxIt/JARutKtgsTDqZwfuhBd/CRsXDeh8183aUFALGfw3WdkqP4FSMGs0B08U7+W
         MFwbH0Fw9dKJPjhjg4HoR0S8ds1AF4f0OzV8H7acSZS/YqtSEjuxb7MR4lNaB1bmpWIV
         ekQdvqM/+grF7rs48OL0045UXOp8KcV9edHxCsurdN714A5ePu6pw86hq6GyPv58yJma
         UAJnlp4mo9CsqfUVgzn76fggfu5B2gK31Ln/ymlENdQy8NmKomBGm5Jm18fi5CZnoC0F
         mGKrIKb35DXUgxDZa5K8jLkhAZh1NGccKeCZ7hCOA8k2etiv/B8pJJp0fgyQWfHwxFzV
         5lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507029; x=1764111829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8udVISHoFxlp3Sg2p6zdhaYur6w2cog8DmQ4evuWtRM=;
        b=YzJhxULrrK8rfFDZw8euOQ7rxnTcztaWP6Ep83Ea2D0gBi22s6YQXzOJgXz8wDN0u8
         ZWVHs3s86vrobG8gdiE2k76OrucUx1STOzQW3RLYp/eIKfSCKT1ageVDBz5QdLSuyYqu
         7HSAIFu2p2dKFmrvbS6Ahk1U++ErSBWko4t4tY+DQmGdMy6RkZ5v30BkDhohj7YCe6g4
         xxwTp4V9hfxXoJsxVG0qrc/DZh7YpprSM4iRRJzpxKR/9sNbizWMklVtaNXVFWsqVAbS
         y788QkxWfBjcjBlm+CbqM9rbsPWLJZCa4YgBVa9Mc5f5kl5af8Y2Nzp9RfHfN1zV/CzD
         cwqA==
X-Gm-Message-State: AOJu0YzNlmsL0dvd8VkiwfjXyUz3BI6u+uLAojGEvMUagFOAQAhBwoTl
	R7jOOJNV/X+mf/idQ2jocwiXCz3WjZWqkGKnlitE+1kwajXEfMspDFoFyzATtvzl640ZjFEUpXw
	Measjfp9J+tYK7O4E8Wn6S8MsqW+fY9sx7j4IV1wrwnA+mjdpp7L/mg4ZsQ==
X-Gm-Gg: ASbGnct4sJMfwBa5q6I0s483YM/qyToE5b+w+r/pLTlzGlvKoKzVJ5bRvcJ4ezK8KsJ
	qzr6GdUHsbF+DhCunx7mHipjtuqspIU/npiYIOLAI3tByYgaMKeVsA7jI6dOwPiyZfmeaWJF6pw
	90Yl/HuLpWqaXkkW46nG90+BVPmSWnWK59rRridBFltUy5dHo2GK5UXzHWubIXw42vxIfHCX0Fn
	tSWZWE7V8rMjpx15fdrzq0aRiqgeQbEke0v7eG/ivf97CJmqWP1GwLF6EnVbvYUNlYqfGzHhMBt
	SKedm67Tsm4C64/vxl+/scDM3+IR+CZyWhg57cnPDcI/F23S6ifNnWWWHpObrOn4E39g+yewA1R
	/UrFGPCF24DHkgg4Zm2kJbiCK49J1Lg==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr160602035e9.20.1763507029275;
        Tue, 18 Nov 2025 15:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZld3jZdWSXwYkOZHWyxTAJsgVq11Sy2lh9ynZa5otsTbFN0s4UdFWsFrFpbfzJjkwOGFgwQ==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr160601765e9.20.1763507028810;
        Tue, 18 Nov 2025 15:03:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1013edcsm14301225e9.4.2025.11.18.15.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:03:47 -0800 (PST)
Date: Tue, 18 Nov 2025 18:03:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251118180127-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..bd7a194a9959
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
> +#include <linux/kernel.h>


I do not get why you are pulling linux/kernel.h here.

include/uapi/linux/virtio_pci.h does it too,
and I think it's also a bug.

No other uapi header does this, it happens not to break userspace
because userspace puts a completely unrelated header at
the same path - uapi/linux/kernel.h .



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
> + *
> + * The limits are reported by the device and describe resource capacities for
> + * flow filters. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
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
> +	__u8 mask[];
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
> + * @selectors: array of supported selector descriptors
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};
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
> +	__u8 actions[];
> +};
> +#endif
> -- 
> 2.50.1


