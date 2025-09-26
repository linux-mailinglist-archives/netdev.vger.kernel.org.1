Return-Path: <netdev+bounces-226735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D858EBA48F2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ED93BF1A1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8923D7CE;
	Fri, 26 Sep 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtaFTZqg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9A238D52
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903017; cv=none; b=gZ/nusEIVOF9KJjwXpD+/OyTI9VMDFZjzADrK4Qv5xBaK7MwdMU22wkpnyllNRxT58HgAhjE3rqHznhReKSmUnGx3M5fwsDKUffQZJZVc3+LbmRU15uIQKt/tS7PPM93wB2T9BQQgJGDKvvIpickBkdpKnmzaedVnmLl81LLSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903017; c=relaxed/simple;
	bh=IbqNZnQ6qBOiYNkLFSV9f/t+U4wjpwCDpH/C2sL850Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAB4QiQk+4AJjjPIzZb9zDF1mKLqDzdCBxQFxERss6RZDsEBn59P99n4QfaxaMZUmf579AhrtRcoxzU3aj/X5VyY7rGmzqmPsjqoyomns0kLp9/VSZ2UJIHUBvF7fOJV8NyX2CqABip71lFY/dvA/ffhySPBYDyzQYOMbRJlA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtaFTZqg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758903013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Sc05YyUFs8eev4smgakT4g9mLlt8ucAW7NryFeJuHk=;
	b=gtaFTZqgbls9FgQUZbDy20ea8TUS2u8nDrLk4z43qan+nXcVAEMNO/5fBAdZKjzy/wcoWg
	r0eGdy4DaF8sO26w3qzUVKCRiF2pOGSev2pOCTkDaJZaUM3OmoDHZx3yoXoAhEAPA40A7a
	c7pEobZpLzJVgookvOMXl6gTPV27pCc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-FgXuA2jIM7669UsjT2Eyyw-1; Fri, 26 Sep 2025 12:10:10 -0400
X-MC-Unique: FgXuA2jIM7669UsjT2Eyyw-1
X-Mimecast-MFC-AGG-ID: FgXuA2jIM7669UsjT2Eyyw_1758903008
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e19f9d18cso14406595e9.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903007; x=1759507807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sc05YyUFs8eev4smgakT4g9mLlt8ucAW7NryFeJuHk=;
        b=M+m6cEDt24ifXNSdcYJdPkbk+WLK6/ZyyoaWwlsjSao0IB43+mowyYX3MCEMMrjFuv
         Rgn8vpKWSremgHSd3dsgXTNiySJCRjGRcdhBYr+lMlv6Z+A60BLlWWe0ngTo1FdGTLWf
         7GiRfocB0lWCgzG0PvyH9hm4h8PgV5RP4XC4IQ+GmkVaou4GCIVxukCSolzcrMTa22d0
         dyOMNjNCAxJzBokk92CYobLpuP/0mr+xVP1Od/9p9zUGEb33lZf4cnaIXNuGBoELsPcw
         ay6r2+TB+EQCNVr0L8nZbbyyCSx/Ky+13dQYkdK0Vn9pyx5DlbYIgihGBeQCPqCHXua5
         i4kA==
X-Forwarded-Encrypted: i=1; AJvYcCWOPvOdOOwMUSqX6rOEWZ5HoENjOIMicHqsUE1I9CoBrfJoPY/HdGuBwteRJZLRJmDgZUKGviw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiSWFb1kFQvRwm35uWJTtc1fl1FjFmyz7x9UP+ESQXOqjGOpO
	fB6v5h5FSgqWVpjdq7CZv96oCjhSXwofEvRY8wk1fv6duCV+37j+q0yw/UgbxNFvKx7lX4xaJtb
	Ridz222JieV71n2N8a2yri95dWMvjJ/Vz4HeaOrG83v+Nxw24nA9Hhj2sUQ==
X-Gm-Gg: ASbGncvEbJkx+MbgenP1K06N8m1efnIag8koD0lnQHJTn7Acf9E8sy62K1VdyvZpzOR
	eO1yIZWIAxKWSUX9oz/o/hS1FdonkjpzzU9Mp6ka2shtYWdVumOqFfsz2q4ggZHhAkffzz96kl2
	etuJBhcy7LpCGZ4pXFLPCrUVbK4MGlf7ZHWaDmse7KRwvGEXkqOuvfh6cJFH/KE7mOZQo/Y15hq
	HabinAOCqiiyerTs+az++cBf/1IcHjGFgamisGzvTz+JQmXpB9Flztb9PllfhcXWzkvEyc+XCi7
	9wvPfs0TfQafjLtwpXElZmzEU3cW5sFLHqxftXlM
X-Received: by 2002:a05:6000:2c05:b0:3fb:6f9d:2704 with SMTP id ffacd0b85a97d-40e46ad02e6mr7131291f8f.28.1758903007500;
        Fri, 26 Sep 2025 09:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFViVdCy79A3oTvkyW7XNCB5TCgJypl+aC6OQKJjOod/Xo/GpsRVtayfxUD8jMTLP47LqpK2g==
X-Received: by 2002:a05:6000:2c05:b0:3fb:6f9d:2704 with SMTP id ffacd0b85a97d-40e46ad02e6mr7131237f8f.28.1758903006949;
        Fri, 26 Sep 2025 09:10:06 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm8192690f8f.2.2025.09.26.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:10:06 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:09:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 1/9] vsock: a per-net vsock NS mode state
Message-ID: <iqkgyjncszycflptyrmnwfn7bvrkjt5poig5pnlwbjf3rvdka4@ermxt6v6nvqs>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-1-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-1-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:45PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the per-net vsock NS mode state. This only adds the structure for
>holding the mode and some of the functions for setting/getting and
>checking the mode, but does not integrate the functionality yet.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v6:
>- add orig_net_mode to store mode at creation time which will be used to
>  avoid breakage when namespace changes mode during socket/VM lifespan
>
>Changes in v5:
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- change from net->vsock.ns_mode to net->vsock.mode
>- change vsock_net_set_mode() to vsock_net_write_mode()
>- vsock_net_write_mode() returns bool for write success to avoid
>  need to use vsock_net_mode_can_set()
>- remove vsock_net_mode_can_set()
>---
> MAINTAINERS                 |  1 +
> include/net/af_vsock.h      | 55 +++++++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 20 +++++++++++++++++
> 4 files changed, 80 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 47bc35743f22..bc53c67e0926 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -26634,6 +26634,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..2857e97699de 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -10,6 +10,7 @@
>
> #include <linux/kernel.h>
> #include <linux/workqueue.h>
>+#include <net/netns/vsock.h>
> #include <net/sock.h>
> #include <uapi/linux/vm_sockets.h>
>
>@@ -65,6 +66,7 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	enum vsock_net_mode orig_net_mode;

Why `orig_` prefix?

Maybe I need to review all the series, but it's a bit confusing for now.
I guess it's related to the new behaviour to not change the mode of 
already created sockets (which I like), but IMHO this variable prefix is 
confusing.It seems we will have another field with the "actual_" mode, 
but if it's immutable, I'd avoid that prefix.

>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -256,4 +258,57 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	enum vsock_net_mode ret;
>+
>+	spin_lock_bh(&net->vsock.lock);
>+	ret = net->vsock.mode;
>+	spin_unlock_bh(&net->vsock.lock);
>+	return ret;
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
>+{
>+	bool ret;
>+
>+	spin_lock_bh(&net->vsock.lock);
>+
>+	if (net->vsock.written) {
>+		ret = false;
>+		goto skip;
>+	}
>+
>+	net->vsock.mode = mode;
>+	net->vsock.written = true;
>+	ret = true;
>+
>+skip:
>+	spin_unlock_bh(&net->vsock.lock);
>+	return ret;
>+}
>+
>+/* Return true if vsock_sock passes the mode rules for a given net and
>+ * orig_net_mode. Otherwise, return false.
>+ *
>+ * net is the current net namespace of the object being checked. orig_net_mode
>+ * is the mode of net when the object was created.

`orig_net_mode` is also explained in the next paragraph, should we 
remove from here?

>+ *
>+ * orig_net_mode is the mode of arg 'net' at the time of creation for the
>+ * object being checked. For example, if searching for a vsock_sock then
>+ * orig_net_mode is arg net's mode at the time the vsock_sock was created.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct vsock_sock *vsk, struct net *net,
>+					enum vsock_net_mode orig_net_mode)
>+{
>+	struct net *vsk_net = sock_net(sk_vsock(vsk));
>+
>+	if (net_eq(vsk_net, net))
>+		return true;
>+
>+	return orig_net_mode == VSOCK_NET_MODE_GLOBAL && vsk->orig_net_mode == VSOCK_NET_MODE_GLOBAL;

nit: I'd rewrite in this way, just because it seems easy to read to me, 
but again not strong opinion, this is fine:

	return orig_net_mode == VSOCK_NET_MODE_GLOBAL &&
	       orig_net_mode == vsk->orig_net_mode;

>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>index 025a7574b275..005c0da4fb62 100644
>--- a/include/net/net_namespace.h
>+++ b/include/net/net_namespace.h
>@@ -37,6 +37,7 @@
> #include <net/netns/smc.h>
> #include <net/netns/bpf.h>
> #include <net/netns/mctp.h>
>+#include <net/netns/vsock.h>
> #include <net/net_trackers.h>
> #include <linux/ns_common.h>
> #include <linux/idr.h>
>@@ -196,6 +197,9 @@ struct net {
> 	/* Move to a better place when the config guard is removed. */
> 	struct mutex		rtnl_mutex;
> #endif
>+#if IS_ENABLED(CONFIG_VSOCKETS)
>+	struct netns_vsock	vsock;
>+#endif
> } __randomize_layout;
>
> #include <linux/seq_file_net.h>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>new file mode 100644
>index 000000000000..d4593c0b8dc4
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,20 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __NET_NET_NAMESPACE_VSOCK_H
>+#define __NET_NET_NAMESPACE_VSOCK_H
>+
>+#include <linux/types.h>
>+
>+enum vsock_net_mode {
>+	VSOCK_NET_MODE_GLOBAL,
>+	VSOCK_NET_MODE_LOCAL,
>+};
>+
>+struct netns_vsock {
>+	struct ctl_table_header *vsock_hdr;

sysctl_header, or sysctl_hdr, or sysctl_ctl ?
I'd remove `vsock_` prefix and make more clear its used for sysctl.

>+	spinlock_t lock;
>+
>+	/* protected by lock */
>+	enum vsock_net_mode mode;
>+	bool written;

I would call this `mode_set` or `mode_locked`, I mean with `mode_` 
prefix to make sure we don't need to rename it when we will add new 
fields in the future.

Thanks
Stefano

>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>


