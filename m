Return-Path: <netdev+bounces-265881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJh4KP2Jr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568124492F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D39303932F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17F3B585E;
	Tue, 10 Mar 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQWR9FM0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sWr0cte2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA73A900B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111793; cv=pass; b=uVPnC+sLv2mg4xeo7+515AbS4JatpbswQtZcdFS05+s3LxOnmtX19jRxLB2w0JaMU1v8FJKww5xArg/haaVw0nqkNuK1bykiUbYyPWFyjEo9uDz72kbW0w1QqgRpESIow1YBUsd2gDb9jlYgLUFAY94xCdqskH8e6nzyWdqo/tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111793; c=relaxed/simple;
	bh=0v2K0W2zP+AM5y+fHVEDnet++UbxfEr4lS8iB4tGChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrNQ0O8aut4c4LgVPcIA5jh52bLoJhpqUw4Hlyg52KAxBcVpOYhICu+YujIx7ThGLlXT5yVRVLApooSLywwCtU75rXXmfh9CDpOFRylrgo0TrIhTc6xjf3sy3ZooiOk21RbVNQUrolfxkHVuGL6xjf1MpwvKrKMtgEdLCz3VGDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQWR9FM0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sWr0cte2; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773111790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
	b=cQWR9FM0esD5lI0x/aP3m6oaLBHZ4tqcStDW8lA/ktl5VviQdyZoT+jqB1mpQrckMWnKCk
	kgImWN/SsI0ziJRCChFZlVpzNeSSQtzHrN7iWAHecx95/1Uae9HYXwMOMJNtH4DoZLzKdS
	9XXyL+jVWB1ldPSfBYTkQ5zQaK48yyw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-N8fCSn8FO4Gm_HfShRwBhw-1; Mon, 09 Mar 2026 23:03:09 -0400
X-MC-Unique: N8fCSn8FO4Gm_HfShRwBhw-1
X-Mimecast-MFC-AGG-ID: N8fCSn8FO4Gm_HfShRwBhw_1773111788
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3594620fe97so63165257a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 20:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773111788; cv=none;
        d=google.com; s=arc-20240605;
        b=PXSph4lvvGzWxOx8CQ5vi1qJMOebUc+vZhOLa1g2K9bnVGcOHmljVtThL+Fe6RkuX0
         g0IfT0smXF3zGUFbxDm+Z/cs9GrU1QDOngNf6aoxcn8oJpbGN1wnXebB860+ty9KJfd/
         ntQQhS1kFV0w7tD/lNUVThP+cUwBN2Ex1tihku2o+60toPRDOSoqxIoBvfrqnlCS3CAc
         7rFTS3TGWWK0wNz7hKiM35fM37MWTQlUZedu8VVEu9RvQ78T6O9zpWYxsFLF3YqoIqQL
         jRTFt2Wbonys0JdppPtuOEyrcDMowC3udBcOXeb/4a4qVFuJMLezd70KrOqfyzPg6onm
         iB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
        fh=r5EDM4cMToJYj3lBzjewKBt0WGY0DWc4IQrMuphvRhA=;
        b=dLrGz+BgTW5A0GGqLgSJbFmywqSAtbw7wY3I+AOI/HyLiV3XT9EtqMlvQ1kRuwmdvY
         8F/6IowyWvrP1pW+bABPHMrg/DauRpEmpI5u6/89fdEByKkkf9ooWlMyEyNO0rT80ftr
         RwtXX7MA7wXVYse9Kqe5a01FMMU2SBrMo2inrND77V7KQKR/Esq3xElz2HAf7rPgII/b
         um0DgglqGTGaPhChnbrcWJkxhprFZte4a8rFXYdgr25Yi57n8ocWlswU47n41pUQHUYq
         C0s5TNzcIIe3adLPmW9GH0tDuxEiJ4P88Nhw6nhUJePfxgC1vhvoSabEczjoh1WjlDl2
         uYTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773111788; x=1773716588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
        b=sWr0cte2dZHlh+FYl3ipIA+g4m/B4wJSqYBczc8laO/y6LCliSWBMqjc377i76/AYn
         awSy2R6y3fvX/TO5WqZDi8FpWWWaT4sy5j4NdVADsict1/+emGmADP7wcI31HQfLETCX
         SPDeVJS2qzaAdNmh60WTKMpW+c9SK0fkWBz0J/xELtvtXfl8u9R94jMIrSMIF0DkqvG7
         DSiQ1bN5oomCiSBaVfbN7VwoNjkI+0CktyEmcsmQOpZxr/ljp/dO5eD/mn1ZmpEHzqRV
         4mk/zLwZqJ2fEP0jZWb5OOB9IN5OywjE4lt5fsY8SuVlCK6z+TLvdWOfTYhzhXkqnbQp
         AC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111788; x=1773716588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
        b=u6JQJG/bprrK6osmnW90g9UDxl6GiLz1yal7oMUMJqgntZDNkSlThigUFQiqtZez01
         La0vYPw1n6DVkpXzOjqMz4nQ3fScVLfXv7/vKGXLzAs3aUMxiqdwrhwyn6VaIMeyPwcV
         krCzBgM+k0gyL9r9XElalMp1hWK4APju0bzRVTTW+jCT7YPx+SJVYBISYtPza9HV1qoj
         Xckk67NiNlGbvNu/TC54501Bcj8T1w93ayY3iC281m5iacjhqWs7Uiilvf77ZSY8L4LV
         QPNEfRTgK6mWfpwMSpkUjOzPixMcNnnCX6CrbeXeiaBA/vdK3qWgBkjtAzLADYvcL/30
         ObXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+M4QVbLpGqvycmdI6i5sCC3fVDszgOv/SFMnByS1oKsK7B6H0KYbHQOPtcYiKfLvrFbh/80Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5/exAqJfDgwS9HcwPHxY7fL46AZSNA5jLK6aX7aTPg+dnIvL
	4/n9qIuokmrLNJtzQFf+pwrLXs8bzdqF8BE9KJd/UhtWJpFihMsgOeFT8WhgGh/Ga/Kg2HsXEXl
	9wJeub1LJtFnadwpRbipqANEquPQ7Om+nUe7Hv8EC9Q2ZKiHYzV1tXGXVdGXOPmlh4tPNNUEFDJ
	i30cZON6/AxmdEeaMlDtlfhHFESAXQ2e0M
X-Gm-Gg: ATEYQzxlzYANr1nJ04HiWQzKvAwt48NEcFvtlkk/PhJc4IkCKYsR4o6E3bm/m5acXi0
	V1iYRxUmLZGg2A0xVtjTOf0iDCR1qW0Y9Eaii0ZBCu+oI56Y9kQMMN7cVCpYR3kNdEIij1eZT3h
	phpETBXdYM6hQvxBQ3Y8jz+5mB90eiMxNOtZQrlLfdUbih4CYfT2WSM3yAmNyiTHULE1egfSCPe
	qYDtdg2
X-Received: by 2002:a17:90b:5410:b0:352:ba0f:fb28 with SMTP id 98e67ed59e1d1-359be23398cmr12298990a91.1.1773111788400;
        Mon, 09 Mar 2026 20:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5410:b0:352:ba0f:fb28 with SMTP id
 98e67ed59e1d1-359be23398cmr12298960a91.1.1773111787935; Mon, 09 Mar 2026
 20:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net> <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
 <4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net>
In-Reply-To: <4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:02:55 +0800
X-Gm-Features: AaiRm509qPpH0vS0k_Y0y1HeOHRnsQKlnDDd-ndbgXxaWrw72LfUJL_pWWgEATA
Message-ID: <CACGkMEuguforqrFH+wy2eG-W+ufHmqA_6+LSRPTyxDC-4UYFAQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6568124492F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265881-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[yeah.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,yeah.net:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:37=E2=80=AFPM xietangxin <xietangxin@yeah.net> wro=
te:
>
>
>
> On 3/9/2026 11:42 AM, Jason Wang wrote:
> > On Sat, Mar 7, 2026 at 11:53=E2=80=AFAM xietangxin <xietangxin@yeah.net=
> wrote:
> >>
> >> A UAF issue occurs when the virtio_net driver is configured with napi_=
tx=3DN
> >> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> >> (e.g., during the configuration of tc route filter rules).
> >>
> >> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network =
stack
> >> expects the driver to hold the reference to skb->dst until the packet
> >> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> >> skbs may remain in the virtio transmit ring for an extended period.
> >>
> >> If the network namespace is destroyed while these skbs are still pendi=
ng,
> >> the corresponding dst_ops structure has freed. When a subsequent packe=
t
> >> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> >> It then calls dst_release() on the skb associated with the stale dst_e=
ntry.
> >> Since the dst_ops (referenced by the dst_entry) has already been freed=
,
> >> a UAF kernel paging request occurs.
> >>
> >> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> >> the dst reference before the skb is queued in virtio_net.
> >>
> >> Call Trace:
> >>  Unable to handle kernel paging request at virtual address ffff80007e1=
50000
> >>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc=
1+ #6 PREEMPT
> >>   ...
> >>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
> >>   dst_release+0xe0/0x110  net/core/dst.c:177
> >>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
> >>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
> >>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
> >>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
> >>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_ne=
t]
> >>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
> >>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
> >>   ...
> >>
> >> Reproduction Steps:
> >> NETDEV=3D"enp3s0"
> >>
> >> config_qdisc_route_filter() {
> >>     tc qdisc del dev $NETDEV root
> >>     tc qdisc add dev $NETDEV root handle 1: prio
> >>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to=
 100 flowid 1:1
> >>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> >> }
> >>
> >> test_ns() {
> >>     ip netns add testns
> >>     ip link set $NETDEV netns testns
> >>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
> >>     ip netns exec testns ping -c 1 10.0.32.1
> >>     ip netns del testns
> >> }
> >>
> >> config_qdisc_route_filter
> >>
> >> test_ns
> >> sleep 2
> >> test_ns
> >>
> >> Signed-off-by: xietangxin <xietangxin@yeah.net>
> >> ---
> >
> > This is needed for stable I think.
> >
> > And do we need to fix tun_net_xmit() as well?
> >
> > Thanks
> Hi Jason,
>
> I have analyzed the tun driver and concluded that it don't suffer from th=
is UAF issue.
>
> The netns containing a tun interface cannot be destroyed until all proces=
ses
> holding the tun file descriptor have exited.

Note that you can close all the file descriptors but tun device is still th=
ere.

> When the file descriptor is closed,
> tun_chr_close() is called, which immediately free all skbs in the tx_ring=
.
> This happens before cleanup_net() destroys the dst_ops. Therefore, no skb=
s referencing freeed dst_ops.
> Unlike virtio_net, where skbs can remain in the TX queue even if the ns i=
s deleted.
>
> I believe the fix is only necessary for virtio_net. What do you think?
>
> Best regards,
>
> Tangxin Xie
>

Thanks


