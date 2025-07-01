Return-Path: <netdev+bounces-202735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18CAEEC70
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF23BFEEA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75AC195B1A;
	Tue,  1 Jul 2025 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5L4qYgK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0741917F1
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336617; cv=none; b=mKTG4Rgn62+OIu4mdTrNkALWj7urEx7Vlqs/tEX4ofq8TVwCOQEZXDPH7J7cRnUObGLxhusMGxcA2o8udLKX3oMbhYzD/gFQXxUPWSYL8LKFVsTxBJN7PO0DUElA41JHIDxxHcTDb4Flc9sAkYYSpCHrr0FwTHHUwZ4vXXGm/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336617; c=relaxed/simple;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjemfg2LYsFTcsojYTgNhGYbc84eAHvZ8zqoEjUEO55R8lxf+EHHAetj8sf9HFIKjA/P8rRlm8mWI/40RD6X96XT3ZDRCXgKRhKZ3tyUEw3qzBfwT7fKtfgD7MYvhuH9uvmWTIpABl4iK3YuPfRJ/tpXr/7BeO372ERXUXjy1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5L4qYgK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	b=W5L4qYgKUHdMS7tTnseih7wI75H5KFxdByNKNoT2XPepg/5ctgmf+1Rv+eyQQzl5ozRVN5
	PjDDliyQ0sTzq1T12U3KbA9pTb4duUiNmlfJ9ydgdmpcokZrBEflNhFPG/ZIfowambe0Lh
	lgPD4aDLj9FQm1JByKSZbl4lxIKBxFY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-rV2P_75hP9O4jQEvCKXJUA-1; Mon, 30 Jun 2025 22:23:29 -0400
X-MC-Unique: rV2P_75hP9O4jQEvCKXJUA-1
X-Mimecast-MFC-AGG-ID: rV2P_75hP9O4jQEvCKXJUA_1751336609
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-531566c838cso1555084e0c.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336609; x=1751941409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
        b=aFYFgD7IFP414PenP2mDdK7l9TBSQUqNRj5fvSulcSL3R1pfYzNes2vNiTMFfY4HGx
         DJrPHgP1WYYCWf/frrUxwbeunrZwvQP+fPfbo8DCjehnmk6qlu7fhw62cjb2D+daTM9v
         D3DeDThq68ShuWcvCFNxa4M56nQCMJ1OLFpsUnb4+88Dj3Ckqg1TGRANMyGbiZ8d1BbO
         2bWHfBdpEOIPI6pCML/ENdNNLBkgwJmADcgBGvW1ozg8dCaqPeDVMiABdINWfs0Lm7Sm
         6aeYGoF4si5/CEuhH60q6E6gnAR2FrUrSZf/ut6CKCF+evWcaT6U32evPRnPRnMnK8I8
         XrFA==
X-Gm-Message-State: AOJu0Yz5rPeSNlGEYK6Vec/3wY0vFeGQ5GSwQTWpdDthOSZ1+y+D2F+e
	FDmlnhhCezYSCrgvA4C/Q7RunGyv3q86dX9XBYOfHXg4IwUxMutRQRi7Tx2bZ6IceHCL9CK4m/v
	tz8+r7IDUsXkTc54kvwHSuqy8XeCjjZMtfi+ae1sn/hTDlAc8bscfeAC3cwxPRGXe5MYzclGJpR
	PWLGt0dEDnsuE4cUQ5sV7goZsHy/Hyu23f
X-Gm-Gg: ASbGncuhQ3YbKCmLWUbea0YuIqDTyXe1L7Y1BM59hAfWAJsM7LE45OHnaCk98Gss3jM
	7KffZHZQ5wrCYRKiuqQlPmOrRvATbr0JQKyBCLnjpbSeR/VOc0Baxs/HQl2Ih0h8ava/Wc9DwSQ
	/1
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id ada2fe7eead31-4ee4f55fa28mr10132605137.11.1751336608770;
        Mon, 30 Jun 2025 19:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYUKosjg1xV3/2kEIImXNwrpXMZl3+XgrJg900Mb6VAWhQ1VVykJLy6Rp+l/68SJ/VfW9TfhDDb0JYqP7DqAE=
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id
 ada2fe7eead31-4ee4f55fa28mr10132595137.11.1751336608477; Mon, 30 Jun 2025
 19:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630151315.86722-1-minhquangbui99@gmail.com> <20250630151315.86722-3-minhquangbui99@gmail.com>
In-Reply-To: <20250630151315.86722-3-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:23:16 +0800
X-Gm-Features: Ac12FXwmRMP0wrScNXo4jLviRavx1GRKuzUNyZLulsaizoOGTdjbvUZnQk8mBA4
Message-ID: <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 11:13=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.

So I think this should go for net-next not net.

Thanks


