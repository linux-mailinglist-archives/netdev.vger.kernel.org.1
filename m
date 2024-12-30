Return-Path: <netdev+bounces-154496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF29FE378
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AFB188248D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8CF19F43A;
	Mon, 30 Dec 2024 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0i9Mg4y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45354155345
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735545118; cv=none; b=KWFHRsHXvQDfnJ5jmvRx1GEjg8SDY1WGIMiMP3nTDenVXGuTphnwBLJc9yn7JQHkFs9xkivBTJUKeT+DjFXLl4SCXNnfnNm6ZbFWtllKFFXFTBAaapBSa+X9IU3zQqsjjcSV97vDRJug9xYlU2Bvj/rMIDyYhPsGfJ79PlKk8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735545118; c=relaxed/simple;
	bh=Ty0odp3SjgUTqexMbjUfQ7REoC5DutDQisZcBKmlUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdibpM80UfA0Di5nH2Y8rMXV3iAnrst9tKsVSKDktmh7Ik9sd4frq+TmSsK+hTq/Z4w8hwW1xjHAt03tdaVCZGeGR6Bnbsh4qNEVv0QJuLLH6QEDs7226ooAw2p5Xsyk3mD9/00PWizSnTr/wPwSO0kae5+P4qGriD8GtIyKjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0i9Mg4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735545115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0J0AYhxmNDrE+hV/0WPbQ41cTnDC3xZnCg8iwgLqFn4=;
	b=H0i9Mg4yA0miPbw3d9UsHgDmZqS2pnMhBqGarKWxGBPc7ZQ1gsramiUjDLtBIcEIzAVVQE
	iydxYqtcQUaTaxztu29sTxqeWZHzmtHxdyKHmet1NyaPOiC8px7+8q99yaOwkmhT7mVvOA
	RFGRV6j8pdJGEWMaiatsI1pq7DpX+WU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Xk0zmB3RNpKB3CBocajkdA-1; Mon, 30 Dec 2024 02:51:54 -0500
X-MC-Unique: Xk0zmB3RNpKB3CBocajkdA-1
X-Mimecast-MFC-AGG-ID: Xk0zmB3RNpKB3CBocajkdA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso12366601a91.2
        for <netdev@vger.kernel.org>; Sun, 29 Dec 2024 23:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735545113; x=1736149913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J0AYhxmNDrE+hV/0WPbQ41cTnDC3xZnCg8iwgLqFn4=;
        b=Z9WLhgsdhsIBi56NBZVOjpB/1J2xLdiUfVvT25wN8qlNHQNhoDuS9/tjVICyCP7C3O
         C27s3X9HzM/M9ZXPywhLhIor6bd054a0wJ7HEotWrsJH/dmt4KWHozQZra5Rbek9vLo9
         eDNVpIZr28dHAECS1NZkSW9fzAODvoMcA+wRGI+2r5fdIY4Hem3vzxtcDSiiU0tEcP+x
         ESKT3GkP/AERdJMW/G+vhG2s1won4bxTozFWV2XfXnzaVd5AqIHZBheC5S001/J26z7R
         VAf57re66wBmG536ogwQqnX12I/8o/186cki39r4ML2rqWL6Ru83avuTXmAMNKs6BF30
         2uJg==
X-Gm-Message-State: AOJu0Yy9953gVe8zOlqSytnBWGoun947hrHxqKLkIDNbt72cZwEhyPbU
	v+UUHjSOw9Oy9LC6agFYUZ9oS2ojq1iZu6KAABxKpEZkjIbymxJea+Cf/eqBWbcpOJXK20NTRZG
	05NgX6FQ99HH1TDVUMKIP9LbpMQQp4Ll96bnjNeZ5BaZxItwr0hWnDLz89hdNz8JsFSw7j2rDcD
	QylmhO1sjd5mH/45YT1edWdUp93ecd
X-Gm-Gg: ASbGncvFDO1MAJzsq5r0zfBVyz7iMAWOtP3njY3oaX4/cjb0tUIjPIxJMoQzte2sfiM
	rgBrOELgQfbYKX0Deddt/wQ3u3srgrLkA/Szx
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-72abdd7cbaemr60529602b3a.8.1735545112947;
        Sun, 29 Dec 2024 23:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrRn8WcYwv283lLqZw/U9xGQjtM/ypQuHSDfUoQ2eSZRdU4bKS9WRvBDuEhHDV4a2t6IovfqPmrMjsRDPQDxs=
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id
 d2e1a72fcca58-72abdd7cbaemr60529579b3a.8.1735545112567; Sun, 29 Dec 2024
 23:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com> <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Dec 2024 15:51:41 +0800
Message-ID: <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	edumazet@google.com, dsahern@kernel.org, pabeni@redhat.com, 
	joel.granados@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, 
	horms@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 3:13=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE
> field to count new packets with CE mark; however, it will be corrupted
> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by
> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
> changed within a super-skb.
>
> To apply the aforementieond new AccECN GSO for virtio, new featue bits
> for host and guest are added for feature negotiation between driver and
> device. And the translation of Accurate ECN GSO flag between
> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to
> avoid CWR flag corruption due to RFC3168 ECN TSO.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  drivers/net/virtio_net.c        | 14 +++++++++++---
>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
>  include/linux/virtio_net.h      | 16 ++++++++++------
>  include/uapi/linux/virtio_net.h |  5 +++++
>  4 files changed, 32 insertions(+), 9 deletions(-)

Is there a link to the spec patch? It needs to be accepted first.

Thanks


