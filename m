Return-Path: <netdev+bounces-246046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEACDD730
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 08:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7EF301A1FE
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEB2F999A;
	Thu, 25 Dec 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsFJiT9+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSCsE2df"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBF2F6930
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648028; cv=none; b=CjPPoRZTX/gEYE9P7JTv9jd3xcZ8GZj7KcUU1hqcPMWXZe9cxnhnHxy+pEXD9FhnXSHbuDDpukZO0easNz0h3Lu91XnI4LumyWbCAIkOAupQ+OOOBQFYOKfTduV9ZRpnXQXvmT74/MlyT5CTYATPmjs/+LEJKrPd7xGZs3666z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648028; c=relaxed/simple;
	bh=+iyjwmBV87ktkSqNEIqB4ESqTnXUiOMV88fHerMRrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW56YXzhzK9rmsBmwIc1Wl6zDzGnc1EZWMTXMMe4nclhx5NIZe/2NzdJE3nkVKFisUCspJdkXyqAe9e64lW6NT/r8Q+DxwgSJoqV6vfsE2FddWguSGMdbxdytfLLEAtIdRjXLUO8Ee/puSkvtBbu9XFtOt/K30rxo1V9SMlei7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsFJiT9+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSCsE2df; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766648024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
	b=gsFJiT9+1e0vHTCKUAVGUoRD13YnAk3RcyVRwulmy5xqCT3EvB+osoLDuX/uaYVRdIXscH
	qFOaah88X2sMPUbd34pp0OwN3agx4mrmultP6SmsJUZYDaT8cNCY595oFI4kJJHr/qOIh4
	gNHN99UxZ5awNMc+hASQqU9I2Ui47+c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-z7zGSo7LMC2g_sP5i27tRQ-1; Thu, 25 Dec 2025 02:33:42 -0500
X-MC-Unique: z7zGSo7LMC2g_sP5i27tRQ-1
X-Mimecast-MFC-AGG-ID: z7zGSo7LMC2g_sP5i27tRQ_1766648021
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so13848145a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 23:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766648021; x=1767252821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
        b=gSCsE2df1YPFNh3vhMEMnO2ZSm2F2w5G3zYWQSca7AbN31/FwKjU25cnGDQO9W2NRz
         xGCBgb5hbmcwQcC78WgkceIKvxmv+8NpODWRokZifT9tMEcFHdC0Ah4SG0nGRsskYB0x
         g9fD457JcyFf6xvqf0RedBeIB/qlQbKWIXEQW8sGsLG0Z5kUjrkDKgXEH0VUC7TT3uos
         vbQJ/B63rwNwf/9VGZoXdPMpIQMvE/kh4TwJRDhYUy4UsFB9a7OLDVCFcRiYvTn4hlBm
         jIlcBn41btNKIVcMvoItxOE1cezhDneobYs3ui3r2fiEkrSDi7sG3YkgScX00HRXoerp
         OMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648021; x=1767252821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
        b=NVR+XxIBlUJSUhCd8W3WuHwQ+xWY+Q7/nOuB6hlUnapNKdxozMozo0G0vI8PqDBSf2
         F9ZMI/m5RXNcfpZEohkpfL1GrMf5aMW0th6XHtufh8z6PklOedJL4Wa3RLV9vQ0xlSNu
         izKvPfr38tR662PLZp9K1ahN/mE/c24UYSx6kEzTzqgTLqeGPCj5IzUmRAQWmOkh4Ejz
         jyqbf//xTCDrELD3DL2DWeqb13xsSguy/kGCchcAEAXqun6mwmxNY1wBV5H7DtEYO6Bs
         U6Cyhi/5uhA1jOvbj4gYxGYwsi86l7SGY9Uklny88a6hLXUdZs7i0EuKWfCSmHavb5lo
         kLsw==
X-Forwarded-Encrypted: i=1; AJvYcCViW5LfkS8RPMuQB+kZ/kKVy0SQXUn3IK3xIU79+S0PCTKNfDiOgt50LDh9eWj1tzFy3tQgJVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMpAu7eVCXjMWRVA/yIuHW+qKsuTkBgZjQtfBHGVevP8mUfsm
	+0lPD/xqqoyxuXXUAX8xg1aq6lw7Grnlp+XYWQ3XBkWI45pL/tCh1Xyz5RxbGywUoML40GUnFNJ
	NqzzTZa+RlX418QFu17I+vqXnx+PsEoZBhrW53JTmyqimqfVqK5FUtgAJtTe5iSmyRGpgLnq/mn
	aT903eNuAY6PRxdoDpjclP9BisiPHm48oe
X-Gm-Gg: AY/fxX6leizdMPM95nUoIYs7XuTriiwsxco6p2Cs6VRacKF5VGveC2jTB5WzP04WM3T
	A7pOmshCJDObSAU8Vfu0aXfQE4wqtD3bo9vSLYWPFL9/5CA+/rDAMjtE8ODc4V17a6Or6jCZwJT
	crRTdr4wlV4nott0M35jYZbwLcNWWSvPvuLATlzbBN70WmjN67IgQzEWglS2Ba6YMkpss=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id 98e67ed59e1d1-34e921d0d76mr15800483a91.28.1766648021164;
        Wed, 24 Dec 2025 23:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyl5vR43OkL/hDfKBDmGKAR37cMOZ8Ka1DFFBdJlFQKrUA0x40DEd0hamphs8/qa8tc2gRbIfcXUfzzGSd0U=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-34e921d0d76mr15800458a91.28.1766648020802; Wed, 24 Dec 2025
 23:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 15:33:29 +0800
X-Gm-Features: AQt7F2oZsDAy5UzUdBbuKS6sbUPRqmYTSaTWpVnvwoETb7rBpSLDuU-0lomm-PA
Message-ID: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bui Quang Minh <minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> >
> > Hi Jason,
> >
> > I'm wondering why we even need this refill work. Why not simply let NAP=
I retry
> > the refill on its next run if the refill fails? That would seem much si=
mpler.
> > This refill work complicates maintenance and often introduces a lot of
> > concurrency issues and races.
> >
> > Thanks.
>
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea=
.

Btw, I see some drivers are doing things as Xuan said. E.g
mlx5e_napi_poll() did:

busy |=3D INDIRECT_CALL_2(rq->post_wqes,
                                mlx5e_post_rx_mpwqes,
                                mlx5e_post_rx_wqes,

...

if (busy) {
         if (likely(mlx5e_channel_no_affinity_change(c))) {
                work_done =3D budget;
                goto out;
...

>
> Not saying refill work is a great hack, but that is the reason for it.
> --
> MST
>

Thanks


