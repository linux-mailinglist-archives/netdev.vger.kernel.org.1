Return-Path: <netdev+bounces-239653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B3C6B195
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98C2A367D21
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE73590A1;
	Tue, 18 Nov 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6H3zGbR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="evV/cxnh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA622D839F
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489052; cv=none; b=uMv9jjPvdhNcOKLuP5tj7IHn4i0OLCl3+/Ed6sKOD9ZNWI8Mt2P5BgpoPEQPIuVa7x5n2LKWQ37q+7IvSmDVaQ9GQAIeTa8awucxDh9diQH0PpMLI7ysDMVuFbRCTE/pgf1pBrWTWs/GQRFvngfqGevKVvMUelVV+Ev0p46pyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489052; c=relaxed/simple;
	bh=s+cwPXsVLSNo1ubmatgKVj1SDIBuFfEsEXm/mCHspCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr9GsExNTx0NV/gD58QJkhhKT32kddriWw5MCTlM7g2eEisB4yb5Qly2+ZdZM6Bli+7DPavRVU5H/kJu8IKlTjdmRMD5y5WWpi96xBpEMScZQIoUYQED2Uuze8mVjSJ3ecR4vxRAqArXoTUtTh9zPnPLY73j+kDO0MMa6Op6J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6H3zGbR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=evV/cxnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
	b=d6H3zGbRXd7TAcZzrP3j5XhXwrfw3SnGHUVYJdPfKVcSv56MhXcq4u1de+JdhkB30UQz9E
	RFB9GbK6BC15awJeyZX1EPBPEMYrnTxpVj/M02vR+R9XzaQsuHDemwPjvayDUdrsuuiSGD
	qtbs98MDKzMtXm3J/g/WhHxxzCVuiUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-DcdazBcQP6io1F_fNCYGmQ-1; Tue, 18 Nov 2025 13:04:06 -0500
X-MC-Unique: DcdazBcQP6io1F_fNCYGmQ-1
X-Mimecast-MFC-AGG-ID: DcdazBcQP6io1F_fNCYGmQ_1763489045
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so13219955e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489045; x=1764093845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
        b=evV/cxnheMWoOirQOpUw+X+GXIklPNKjJ/xchSPLDp/xDkAYSeU5X0Na9+CWP7v2HG
         pOgARW7PeCV0nmNSUDYbNtGPK5bCfWcZEIdrp+dAW9wMxG1Xy6Sz42aQc2o3SqM7JpFF
         FhmkUEgZxm5JI76mSYpHYJp9LMEzg/r2rTyhvgDBDg4x51ejnL/My/Wa6Qu0rz46DnvL
         nBgi3ZNqpsN5EasuyNAtFiqhDx9j3ViMk7wU+ePAmRBJ3WgnbeuwvGT46rQ7MU1YRhSB
         +WMxWWkN9yaPLf8PEphQ13lmKpRB5Eo+bkjMRDJRtqdOiL80no2t6fJnPDL1eo/usS1r
         /e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489045; x=1764093845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
        b=NOjbzRn867qnJGKYkzWdg3EoBc85VOT2Y+nywSiFDUiPi8iqnRzUS5H/UTcH8GCJW4
         ce7PqumCWq4M5tKb3hepGgyA2cRfQKqWnUInl/7AIWunqXZbTVZ04iU009TS9FcrCad/
         PzEqtStuPGh8zTmZDTl7Q8i7qK4NSua8bAbroBbWcTl6vA1jbqTxza7t2VCEQjlNkz6P
         crZE4saAkYQkNCmOssROdc3Jhi7Flkx5Liqty/uqp7D3hPyFNdRoJgV9zJ74q6Beg8GG
         aH32dSvEBSmcu+PdDLgoRiLBeFzNQlkKtr57o0iqNlLQ3u5snA5YOx4cgTRdZw8NbO0G
         Zbiw==
X-Forwarded-Encrypted: i=1; AJvYcCWqg4XVpPYLJ4jpGZIz01smxKMgTlI2CICrUs/Qamz9KxH3t0EedAvA7tJdurHc2FW/fHaemjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKmwDrqzZQTG3WD/lk+TxHEVryKyqj/5n7uFFGk6Neb/fy1vH
	m9v9XkrDXJSfTT6dMeeqKV5NfAWw4/H9jv1OpG2gL5+do7IrZfkG2vV/0N/j9IgYAQZds/C4ZYN
	HvwdIVk+qjz1QcXBN7gNSSKSNaVbPUQFXO4Y3uqsrKtfZsUmW8Fo3ceFuUg==
X-Gm-Gg: ASbGncvi1aziappOg0n0qtB/0Et1FmGaXl87B9v78NFv1MufPCW4o6clIBbriDyAxR7
	+Qq9jdAVqUpnbABBFRahb/3n/YVRftKLZEO83iPYmoJegfZZLDhjtLWsjlcox422iCN8a3YvGEH
	5vbXebSU3B81WYiKlaIOf4ylBQNSrB3k7PlIxKU5t44fyqqLPKurGTklC7PJXaCX578rQ+S5+xA
	FnqmCqKJJwgVYgbbAy7LMhzVNR1aC4FeddBw9eyUL+7nFqw5nplSaut7AH1k8jd24cmD65z/9ma
	EJw6Ly/eDbw+6s2ONhF0D+yp9XlAHCcSOpT54uL0IQjdUcP0AKI4PXyUm3YQzKqEJunW8CuCIGQ
	Ff4SIb81zrdvfcX/Ys+cQn7I3r/ma7IZzhZsnBkGct4sVDr8w
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81418885e9.11.1763489045223;
        Tue, 18 Nov 2025 10:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpBG/2sJMbhkzpQOcxnTlmbcbHN4RuL+yQSZxX8aLutRGg8XkylL+hIZNfpXYQY2Dh7dA7sA==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81418715e9.11.1763489044753;
        Tue, 18 Nov 2025 10:04:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm3864205e9.5.2025.11.18.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:04:03 -0800 (PST)
Date: Tue, 18 Nov 2025 19:03:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 01/11] vsock: a per-net vsock NS mode state
Message-ID: <7qu24adya4hyiu6enzgflua3nac7o3d4ymrhzksjig54p4vh6n@n4ehmhlbh5wn>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:24PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the per-net vsock NS mode state. This only adds the structure for
>holding the mode and some of the functions for setting/getting and
>checking the mode, but does not integrate the functionality yet.
>
>A "net_mode" field is added to vsock_sock to store the mode of the
>namespace when the vsock_sock was created. In order to evaluate
>namespace mode rules we need to know both a) which namespace the
>endpoints are in, and b) what mode that namespace had when the endpoints
>were created. This allows us to handle the changing of modes from global
>to local *after* a socket has been created by remembering that the mode
>was global when the socket was created. If we were to use the current
>net's mode instead, then the lookup would fail and the socket would
>break.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- change mode_locked to int (Stefano)
>
>Changes in v9:
>- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
>- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
>- remove spin lock in net->vsock (not used anymore)
>- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()
>
>Changes in v7:
>- clarify vsock_net_check_mode() comments
>- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
>- remove extraneous explanation of `orig_net_mode`
>- rename `written` to `mode_locked`
>- rename `vsock_hdr` to `sysctl_hdr`
>- change `orig_net_mode` to `net_mode`
>- make vsock_net_check_mode() more generic by taking just net pointers
>  and modes, instead of a vsock_sock ptr, for reuse by transports
>  (e.g., vhost_vsock)
>
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
> include/net/af_vsock.h      | 44 ++++++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 17 +++++++++++++++++
> 4 files changed, 66 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 37f4278db851..e1e0e2092d0c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27101,6 +27101,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..9b5bdd083b6f 100644
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
>+	enum vsock_net_mode net_mode;
>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -256,4 +258,46 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net,
>+					enum vsock_net_mode mode)
>+{
>+	if (xchg(&net->vsock.mode_locked, 1))
>+		return false;
>+
>+	WRITE_ONCE(net->vsock.mode, mode);
>+	return true;
>+}
>+
>+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
>+ * return false.
>+ *
>+ * - ns0 and ns1 are the namespaces being checked.
>+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
>+ *   the vsock objects were created.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct net *ns0,
>+					enum vsock_net_mode mode0,
>+					struct net *ns1,
>+					enum vsock_net_mode mode1)
>+{
>+	/* Any vsocks within the same network namespace are always reachable,
>+	 * regardless of the mode.
>+	 */
>+	if (net_eq(ns0, ns1))
>+		return true;
>+
>+	/*
>+	 * If the network namespaces differ, vsocks are only reachable if both
>+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
>+	 */
>+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>index cb664f6e3558..66d3de1d935f 100644
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
>index 000000000000..c1a5e805949d
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,17 @@
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
>+	struct ctl_table_header *sysctl_hdr;
>+	enum vsock_net_mode mode;
>+	int mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>


