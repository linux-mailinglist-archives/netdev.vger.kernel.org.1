Return-Path: <netdev+bounces-267314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DmIHRLCs2mEagAAu9opvQ
	(envelope-from <netdev+bounces-267314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:51:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FA27EFD2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 277323038FD7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E0366049;
	Fri, 13 Mar 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMLo2P1W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nQA7E0ib"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0312344025
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388302; cv=pass; b=OSU14gPlWwGpIV9jRby1u6RUM4NRRCTjT1KOfIffP9G7ukRwHEs5J+7urzsEmInjXuqXLPNC9erO1LSNnD/xfSvUcNlalKTyFXvy66QYOcmWIfP5FbKSi37krUQRHjtMz23LgosTP9p6JUx7vdJJCJbj30S1NqDXnLpGmcIUDGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388302; c=relaxed/simple;
	bh=T6Q7cHdOuLNx8lTf/pJKAIpbor8o/njzpkKvIBKvJ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es4aKr69d7BLbuZ3rsZoBM9plI4LW/Zt30CgXb8N8hF5M2PCocmjJQcFgmP6EnqskqTr8ug8MpfIXml8ElY5+JFBrgbibUMAFwsXycPfIOPYV6hoz6xvtOKlecYNCRVl4kz3g0jKfRwmwsCjnjAg0NzPJYPRCJWdiWW3n26vboI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMLo2P1W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nQA7E0ib; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773388298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIEDktAUiZbn8fWCsen+nbvUpLuTk8HCeUfqrdpkPcM=;
	b=XMLo2P1WL6r+zvsbuE5/UIBGcEWp6WrNzvQpOAx9z/y0eENMNmQ9+TAOW3GmSh2UEAOoFT
	TfmOGc1j6lG8BKP9crBAsOva7TzhwUqKPMmhn8+/jZCmyU0TPrdAmXX6qd2bb6ttlBN2NF
	I+wXAJGTqxXPqZwk4WXKJjgtf+pxC50=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-gfrEw4zmMZqokVsGHnnV9w-1; Fri, 13 Mar 2026 03:51:37 -0400
X-MC-Unique: gfrEw4zmMZqokVsGHnnV9w-1
X-Mimecast-MFC-AGG-ID: gfrEw4zmMZqokVsGHnnV9w_1773388296
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4e9577ceso139949215ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773388296; cv=none;
        d=google.com; s=arc-20240605;
        b=SLE078T4/RbeTM860wu72ju5BKmrIcJIu5XY9Xgj+hror0pcgboLzTaQzbp5Tpbrii
         SuYyVUu+cg/jEDwFkFQCxHw3yllu2xAIPhtLpSIEzAXcFZRizYBQ03a94yjnYtpuRJBh
         5N6ZL2ZgHntz9HUjj/awxvW3py4VVHCyfmvKQTs4CEmEv2sjwfo2HiXpX7d+eIaLzFWU
         K/UecXd6G5tePYBDPLmAAd5DIDgh85ICRJp9J8QS6koNxt4Tgv53An6TbnpCsv+1x0X0
         Iy609y2gzEpxtAeeKGPPmlJEmAdp5cj2YP8fZfheXvO8VDvKAEDPT1IwL16xByEpK4hs
         H31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rIEDktAUiZbn8fWCsen+nbvUpLuTk8HCeUfqrdpkPcM=;
        fh=xy0A2OJRWb3ZfxSeUTEp+98brJoIz+dRhkzUz3tkLZI=;
        b=YpoI1GgM+GqZ566eWm1z9lZMXapsG37OUrHZuDX/O0xpjzHx4JKtmICfgojuaIpe+y
         z35X5BlM4ATqVU75Ya290AJ4BXadMg4q3g1b8Lb0NXcJ9GJXR/W5Z1E5HrJSBqwMc0aU
         geI9hWiUpG8rrWBPsGar4g+jRoPNeeCDl34t2keZJJZbfi9wv/lSRYw6Vcb6LOn3Ec3f
         Mbs638L2fyFrLVtZhGymTrr7YRApl6pDru0e1hbaRseA5a7Vyqgp+SrqUfMLsLZN6ZXP
         wgyIW1Fl6JiLa1mJWXoEAVCDufMpGla/OicMcgCRCeWhwql4+imnFm0t4hgsz981Sc8S
         efng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773388296; x=1773993096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIEDktAUiZbn8fWCsen+nbvUpLuTk8HCeUfqrdpkPcM=;
        b=nQA7E0ibwf3OoGrRcGSMdq8P9No7c0DH3hOgyVbP4LlbbupzJ6asElHIU3zIEbrdfZ
         2vH+MfbkMEpcjHXfzlzF/HehaWDJntSf1w0dPG73jITYvzB+0qsiIfTenngPnZSPOhvX
         RzrpLde8W3EXd46Cw42ej35ChDxOg9qn+FuW01fGk5lIlbDAVCSDS8TbREI35gQ9oMPc
         qauH2qMAbJqPHYD2a68DTCmbhKZN4AAIIDB5TrkqHUlv0IKVrfjf5I2WHL7sXrrHSN08
         lBKXnwMMXT6q4SDPaO0PN8Y9El+aCYNAuo6v2dYCjFb4Hrdcx/nAO8ZeQH76WC3CIFiR
         8DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388296; x=1773993096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rIEDktAUiZbn8fWCsen+nbvUpLuTk8HCeUfqrdpkPcM=;
        b=blE6sAXHGEni4UH5V3dXS6C6X5nxAvcWhmz9mt4WFfjYAwY8oUDsLnQUQTn8CcLiwu
         5Si5mptIS9UomSNc3X3lS0AOYNedJSLTFt92HuA516inEVwk652g3PzQvQTU6Uy+mdV2
         gBT1EPsv14Y4w9z8+uVwizZIBXP9CdeefLAAJw7XSzFp4SF/REhL2B6UBGAt9+g4IdO9
         EuiflPt1lkePXDsoEI3Zl1doODJfETneROg4TnbGIxF8msBa8vm2U3kICiQQZfkn1ObN
         BCuaspagckvmX90ycAWNnIxqYEpTSJaV9fjPEKzRmzl4b0+WB/BeSySljwRzhoVD1P9b
         xtKw==
X-Forwarded-Encrypted: i=1; AJvYcCX5dF+Moh6izNV8XzYGy6fNsHUFYEcx3Bzd4eI2LQdr1Crr7/IqQu3NaHKD1ezBfxh9TuwPRxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSLWF/rfNAWLGjKgMHJP2kKLUdKlbVoabTACJOPctMdd7Sa6f
	qJS6czYxT79AtT5LJH5I85WIEYiGksLJ2rZAwacsy/RyegEYnkExtRnmt1TxXmnreRpnWn0qO+M
	NyP1GFOW33yIiUtBRm/Xwwo0r4t2nRchkMKW0hH1VFQ6tXzqBLRWQPohSzg1FBnOJpX8MxSP0+N
	620yildB8Rr7iBphW602IKvJiGBtQx93ek
X-Gm-Gg: ATEYQzzTZBgoJAIlms3Jmz191Hc14nAtn2ukAPBad8zjjfzTDFSA3fQoBcZ7TdYeO5+
	K0Lmyl6kKpDOL46DhhMgsnBxi6HueGRcRF65q61GJ5VdiWMR+0QciRScZ/X2mNhw9Az2ndcyUPc
	yEQjVCRV5g6ukAHjKxrkSyNPnJbqnPV6+iAsTQms28V0I3JdcySsvFCIBF8Jo+0DXgWx9426m3W
	Ro=
X-Received: by 2002:a17:903:298f:b0:2ae:cd8b:c418 with SMTP id d9443c01a7336-2aecd8bc575mr16316105ad.10.1773388295941;
        Fri, 13 Mar 2026 00:51:35 -0700 (PDT)
X-Received: by 2002:a17:903:298f:b0:2ae:cd8b:c418 with SMTP id
 d9443c01a7336-2aecd8bc575mr16315895ad.10.1773388295425; Fri, 13 Mar 2026
 00:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310183107.2822016-1-vishs@meta.com>
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 15:51:23 +0800
X-Gm-Features: AaiRm52dfbYC43osKTv6Z0WZ8HxJjaQC-jwwzIQ0y9gWrui_GIULMPEdpzzdV9Y
Message-ID: <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267314-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E45FA27EFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 2:31=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.co=
m> wrote:
>
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
>
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
>
> Implement conditional DMA premapping using virtqueue_dma_dev():
> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>   handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>   submit via virtqueue_add_inbuf_ctx()
>
> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> support as a prerequisite for future zero-copy features (devmem TCP,
> io_uring ZCRX).
>
> Page pools are created in probe and destroyed in remove (not open/close),
> following existing driver behavior where RX buffers remain in virtqueues
> across interface state changes.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
> Changes in v11:
> - add_recvbuf_small: encode alloc_len and xdp_headroom in ctx via
>   mergeable_len_to_ctx() so receive_small() recovers the actual buflen
>   via mergeable_ctx_to_truesize() (Michael S. Tsirkin)
> - receive_small_build_skb, receive_small_xdp: accept buflen parameter
>   instead of recomputing it, to use the actual allocation size
> - v10:
>   https://lore.kernel.org/virtualization/9752a952-195d-4da3-bc7a-5a4a1f2f=
d2ca@meta.com/
>
> Changes in v10:
> - add_recvbuf_small: use alloc_len to avoid clobbering len; v9 feedback
>   was about truesize under-accounting, not variable naming =E2=80=94 misu=
nderstood
>   the comment in v9
> - v9:
>   https://lore.kernel.org/virtualization/20260302041005.1627210-1-vishs@m=
eta.com/
>
> Changes in v9:
> - Fix virtnet_skb_append_frag() for XSK callers (Michael S. Tsirkin)
> - v8:
>   https://lore.kernel.org/virtualization/e824c5a3-cfe0-4d11-958f-c3ec82d1=
1d37@meta.com/
>
> Changes in v8:
> - Remove virtnet_no_page_pool() helper, replace with direct !rq->page_poo=
l
>   checks or inlined conditions (Xuan Zhuo)
> - Extract virtnet_rq_submit() helper to consolidate DMA/non-DMA buffer
>   submission in add_recvbuf_small() and add_recvbuf_mergeable()
> - Add skb_mark_for_recycle(nskb) for overflow frag_list skbs in
>   virtnet_skb_append_frag() to ensure page_pool pages are returned to
>   the pool instead of freed via put_page()
> - Rebase on net-next (kzalloc_objs API)
> - v7:
>   https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@m=
eta.com/
>
> Changes in v7:
> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>   calls (Xuan Zhuo)
> - Add virtnet_no_page_pool() helper to consolidate big_packets mode check
>   (Michael S. Tsirkin)
> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() whe=
n
>   use_page_pool_dma is set (Michael S. Tsirkin)
> - Remove unused pp_params.dev assignment in non-DMA path
> - Add page pool recreation in virtnet_restore_up() for freeze/restore sup=
port (Chris Mason's
> Review Prompt)
> - v6:
>   https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@m=
eta.com/
>
> Changes in v6:
> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_v=
a();
>   page_pool_alloc_netmem() already handles internal fragmentation interna=
lly
>   (Jakub Kicinski)
> - v5:
>   https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@m=
eta.com/
>
> Benchmark results:
>
> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>
> Small packets (64 bytes, mrg_rxbuf=3Doff):
>   1Q:  853,493 -> 868,923 pps  (+1.8%)
>   2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>   4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>   8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>
> Mergeable RX (64 bytes):
>   1Q:   766,168 ->   814,493 pps  (+6.3%)
>   2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>   4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>   8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>
> Mergeable RX (1500 bytes):
>   1Q:   741,579 ->   785,442 pps  (+5.9%)
>   2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>   4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>   8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 497 ++++++++++++++++++++-------------------
>  2 files changed, 251 insertions(+), 247 deletions(-)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 17108c359216..b2fd90466bab 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -452,6 +452,7 @@ config VIRTIO_NET
>         depends on VIRTIO
>         select NET_FAILOVER
>         select DIMLIB
> +       select PAGE_POOL
>         help
>           This is the virtual network driver for virtio.  It can be used =
with
>           QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..a85d75a7f539 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>         u32 max_usecs;
>  };
>
> -/* The dma information of pages allocated at a time. */
> -struct virtnet_rq_dma {
> -       dma_addr_t addr;
> -       u32 ref;
> -       u16 len;
> -       u16 need_sync;
> -};
> -
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>         /* Virtqueue associated with this send _queue */
> @@ -356,8 +349,10 @@ struct receive_queue {
>         /* Average packet length for mergeable receive buffers. */
>         struct ewma_pkt_len mrg_avg_pkt_len;
>
> -       /* Page frag for packet buffer allocation. */
> -       struct page_frag alloc_frag;
> +       struct page_pool *page_pool;
> +
> +       /* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +       bool use_page_pool_dma;
>
>         /* RX: fragments + linear part + virtio header */
>         struct scatterlist sg[MAX_SKB_FRAGS + 2];
> @@ -370,9 +365,6 @@ struct receive_queue {
>
>         struct xdp_rxq_info xdp_rxq;
>
> -       /* Record the last dma info to free after new pages is allocated.=
 */
> -       struct virtnet_rq_dma *last_dma;
> -
>         struct xsk_buff_pool *xsk_pool;
>
>         /* xdp rxq used by xsk */
> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp=
_prog, struct xdp_buff *xdp,
>                                struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
>                                  struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +                                              struct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
> +static void virtnet_del_vqs(struct virtnet_info *vi);
>
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
> @@ -709,12 +704,10 @@ static struct page *get_a_page(struct receive_queue=
 *rq, gfp_t gfp_mask)
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>                                 struct receive_queue *rq, void *buf)
>  {
> -       if (vi->mergeable_rx_bufs)
> -               put_page(virt_to_head_page(buf));
> -       else if (vi->big_packets)
> +       if (!rq->page_pool)
>                 give_pages(rq, buf);
>         else
> -               put_page(virt_to_head_page(buf));
> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf),=
 -1, false);
>  }
>
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -876,10 +869,16 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>                 skb =3D virtnet_build_skb(buf, truesize, p - buf, len);
>                 if (unlikely(!skb))
>                         return NULL;
> +               /* Big packets mode chains pages via page->private, which=
 is
> +                * incompatible with the way page_pool uses page->private=
.
> +                * Currently, big packets mode doesn't use page pools.
> +                */
> +               if (!rq->page_pool) {
> +                       page =3D (struct page *)page->private;
> +                       if (page)
> +                               give_pages(rq, page);
> +               }
>
> -               page =3D (struct page *)page->private;
> -               if (page)
> -                       give_pages(rq, page);
>                 goto ok;
>         }
>
> @@ -925,133 +924,16 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
>         hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
> -               put_page(page_to_free);
> +               page_pool_put_page(rq->page_pool, page_to_free, -1, true)=
;
>
>         return skb;
>  }
>
> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 le=
n)
> -{
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct page *page =3D virt_to_head_page(buf);
> -       struct virtnet_rq_dma *dma;
> -       void *head;
> -       int offset;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       head =3D page_address(page);
> -
> -       dma =3D head;
> -
> -       --dma->ref;
> -
> -       if (dma->need_sync && len) {
> -               offset =3D buf - (head + sizeof(*dma));
> -
> -               virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr=
,
> -                                                       offset, len,
> -                                                       DMA_FROM_DEVICE);
> -       }
> -
> -       if (dma->ref)
> -               return;
> -
> -       virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> -                                    DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_S=
YNC);
> -       put_page(page);
> -}
> -
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void=
 **ctx)
>  {
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       void *buf;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> +       BUG_ON(!rq->page_pool);
>
> -       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf)
> -               virtnet_rq_unmap(rq, buf, *len);
> -
> -       return buf;
> -}
> -
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
> -{
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       dma_addr_t addr;
> -       u32 offset;
> -       void *head;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       head =3D page_address(rq->alloc_frag.page);
> -
> -       offset =3D buf - head;
> -
> -       dma =3D head;
> -
> -       addr =3D dma->addr - sizeof(*dma) + offset;
> -
> -       sg_init_table(rq->sg, 1);
> -       sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> -{
> -       struct page_frag *alloc_frag =3D &rq->alloc_frag;
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       void *buf, *head;
> -       dma_addr_t addr;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       head =3D page_address(alloc_frag->page);
> -
> -       dma =3D head;
> -
> -       /* new pages */
> -       if (!alloc_frag->offset) {
> -               if (rq->last_dma) {
> -                       /* Now, the new page is allocated, the last dma
> -                        * will not be used. So the dma can be unmapped
> -                        * if the ref is 0.
> -                        */
> -                       virtnet_rq_unmap(rq, rq->last_dma, 0);
> -                       rq->last_dma =3D NULL;
> -               }
> -
> -               dma->len =3D alloc_frag->size - sizeof(*dma);
> -
> -               addr =3D virtqueue_map_single_attrs(rq->vq, dma + 1,
> -                                                 dma->len, DMA_FROM_DEVI=
CE, 0);
> -               if (virtqueue_map_mapping_error(rq->vq, addr))
> -                       return NULL;
> -
> -               dma->addr =3D addr;
> -               dma->need_sync =3D virtqueue_map_need_sync(rq->vq, addr);
> -
> -               /* Add a reference to dma to prevent the entire dma from
> -                * being released during error handling. This reference
> -                * will be freed after the pages are no longer used.
> -                */
> -               get_page(alloc_frag->page);
> -               dma->ref =3D 1;
> -               alloc_frag->offset =3D sizeof(*dma);
> -
> -               rq->last_dma =3D dma;
> -       }
> -
> -       ++dma->ref;
> -
> -       buf =3D head + alloc_frag->offset;
> -
> -       get_page(alloc_frag->page);
> -       alloc_frag->offset +=3D size;
> -
> -       return buf;
> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -1067,9 +949,6 @@ static void virtnet_rq_unmap_free_buf(struct virtque=
ue *vq, void *buf)
>                 return;
>         }
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
> -               virtnet_rq_unmap(rq, buf, 0);
> -
>         virtnet_rq_free_buf(vi, rq, buf);
>  }
>
> @@ -1335,7 +1214,7 @@ static int xsk_append_merge_buffer(struct virtnet_i=
nfo *vi,
>
>                 truesize =3D len;
>
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, curr_=
skb, page,
>                                                     buf, len, truesize);
>                 if (!curr_skb) {
>                         put_page(page);
> @@ -1771,7 +1650,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         return ret;
>  }
>
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp=
)
>  {
>         struct skb_shared_info *shinfo;
>         struct page *xdp_page;
> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>                 shinfo =3D xdp_get_shared_info_from_buff(xdp);
>                 for (i =3D 0; i < shinfo->nr_frags; i++) {
>                         xdp_page =3D skb_frag_page(&shinfo->frags[i]);
> -                       put_page(xdp_page);
> +                       page_pool_put_page(rq->page_pool, xdp_page, -1, t=
rue);
>                 }
>         }
>  }
> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct net_d=
evice *dev,
>         if (page_off + *len + tailroom > PAGE_SIZE)
>                 return NULL;
>
> -       page =3D alloc_page(GFP_ATOMIC);
> +       page =3D page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct net_=
device *dev,
>                 p =3D virt_to_head_page(buf);
>                 off =3D buf - page_address(p);
>
> +               if (rq->use_page_pool_dma)
> +                       page_pool_dma_sync_for_cpu(rq->page_pool, p,
> +                                                  off, buflen);

Intresting, I think we need a patch for -stable to sync for cpu as
well (and probably the XDP_TX path).


> +
>                 if (check_mergeable_len(dev, ctx, buflen)) {
> -                       put_page(p);
> +                       page_pool_put_page(rq->page_pool, p, -1, true);
>                         goto err_buf;
>                 }
>
> @@ -1905,38 +1788,36 @@ static struct page *xdp_linearize_page(struct net=
_device *dev,
>                  * is sending packet larger than the MTU.
>                  */
>                 if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -                       put_page(p);
> +                       page_pool_put_page(rq->page_pool, p, -1, true);
>                         goto err_buf;
>                 }
>
>                 memcpy(page_address(page) + page_off,
>                        page_address(p) + off, buflen);
>                 page_off +=3D buflen;
> -               put_page(p);
> +               page_pool_put_page(rq->page_pool, p, -1, true);
>         }
>
>         /* Headroom does not contribute to packet length */
>         *len =3D page_off - XDP_PACKET_HEADROOM;
>         return page;
>  err_buf:
> -       __free_pages(page, 0);
> +       page_pool_put_page(rq->page_pool, page, -1, true);
>         return NULL;
>  }
>
>  static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>                                                unsigned int xdp_headroom,
>                                                void *buf,
> -                                              unsigned int len)
> +                                              unsigned int len,
> +                                              unsigned int buflen)
>  {
>         unsigned int header_offset;
>         unsigned int headroom;
> -       unsigned int buflen;
>         struct sk_buff *skb;
>
>         header_offset =3D VIRTNET_RX_PAD + xdp_headroom;
>         headroom =3D vi->hdr_len + header_offset;
> -       buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> -               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>

Any reason for remvoing this?

The rest looks fine.

Thanks


