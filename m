Return-Path: <netdev+bounces-193059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192AEAC245D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F67AA47D12
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD56294A1A;
	Fri, 23 May 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es2y6DAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B07293B6B
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007763; cv=none; b=hwbvlFDf9VWdBcdPW/pN5oofSHeNmBnQp3hcYlap0sz3CDyuOin0Jr/ussxM2K2Lyk1p6zTIqv43P3d/YsYVoK+tu1nbIDCfn8k2B9G/igOs0lj7jM1ZcdiParmsblqSWJi+ills3b36htUJxsWnK+du0mtJ1OuhK0WNtdYU5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007763; c=relaxed/simple;
	bh=WjW3vVoWxfLiWk8p2FNAhxo+W/c/L2p0egx0UmCdXLs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cRA3rGZCM1kGrnpkXb61WfIXoLw+obZZiQTQT+aQD1Vd44Nm/PcoOR8zx7wwbf/aBdpFEBlDkuAoby02/LxUDdLVtXkg63MfwjUjnRW+zFkeUOnWhhX80ELuD67wSIh2rWiQlUSArykORipkCZ5LOnC7OCv7TsJUR102F6DNBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es2y6DAf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c559b3eb0bso614299885a.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748007760; x=1748612560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjJx3bLsWXL//IHwgUsFc/qbO1bhLWS/ld+Azhhe1Bk=;
        b=Es2y6DAfON0FlSMWw7ZCXCUSw1rOh6g3ZJiC8ccdmyZjG9c4m6uGr93rqCFJ2TxckN
         wk56t+HfZkFZydEfQSIsRIdZzvr/F8tlsXUBo3SxS+i4Qe16yJFykzHJUo80JIhLQ36S
         5Dj9ZaGNMLUXpjrHVId1dDNKdqwwZ5C/WqPtK2F3q9JT8s4pp1qKHDHfXaMNqT6KFA0Z
         toXVlI6LbEyC2fqjHJrU1PIcN07x3cHq+fv0kdb0tVqnl7fZhZB1tH61tiP8qy3TAGy/
         Ym8XDcI/u12e3xfUsOaoU9iV/sr6zkVnyeuAFF4XqVhjQ6SGC1oKk27yyd0NH2iq/Ije
         Oafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007760; x=1748612560;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjJx3bLsWXL//IHwgUsFc/qbO1bhLWS/ld+Azhhe1Bk=;
        b=TslAHGumREjPcI5AaCSOViAsArBbGQguBpZLKPNfT/ORDvNFrCNNE7BcQjXvvNrhYB
         gwiS/4nYhXQ9svMGwuGjARuRd9ui3W1i+TswX8rLcj1+H5ScUhdjpug2KTrgWIQUtOy8
         y8dV57D9j5GCIdGkMIRvoLiiaNBgi188ecfnYyo8paQJdj8jpD52pXlEREJN9FOlsgSp
         /D4o9QDX+PXfFGqERe/Wse+/Nf7/ssdAwMsbtz70x8d7Nkl2fSnZjCSidnREuj/wcTrC
         pa8e0T6f9T5bxspJw3MLV6LGuIYv1Owzzn2argnhDX2P7y8r3acVSwvgo9jxm+krk/tl
         roqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSCBuFuc/yAI7h6TRPU7jCZzdGCJIgcJtnzI3o8uoZXoOZZsapPiFfQVeYrisKtJ2IKjumTJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVa9bDsHJMuIC+SuA+k0DkwZ6pzY5AnqSSvmVSqXzRFL4E6v0
	h0+z3M4RodD08PeBDLqjdX1/JZuLvuFEWs3pGzckoQGwFpPUiz0/u4cB
X-Gm-Gg: ASbGncsvIDg84xNEtepE2GqJskv9QE1IiYlYN7bH568OgPYTQI/TM91LZO2K8/ZWIOe
	IuD67CnvKGPiqLCeLMVXtVxyb7dPRApeEWGDhqg1SgG/j+qnXlRxniB4c8pWw0gtYi9uPrKebS8
	vLdBRsEBribPmD1Bqo7anpDxYd5pjn7mR88wmxh9SL9ibbsY5a06y6jO7tMxF4vbnSdJKYVhoxV
	Co4Jiy2GatYNRKztMws7hktgJRjzQ9WbuuIOasd/z5r7dA/bIIon+Xd8dPGdgkh+mLquOgYQ17R
	G5G39uJoXer/NHL5J5qhBcuuW714a+prBLj6kBbyDmh8wIdENtdP6/X6pj7oPu1CwRLikPiBIPC
	WxhaFHccOm2jdyUjyIjCMElgfohPAmK4XoA==
X-Google-Smtp-Source: AGHT+IEyg/AAdkRSHTAxc8uwiMauLFelEAk7npjTr2kFcwqVIlhIoaNSQrB2hdVEE4JFd6zRCmpcJA==
X-Received: by 2002:a05:622a:146:b0:489:7daf:c237 with SMTP id d75a77b69052e-49e1f89fdc2mr33867001cf.45.1748007760272;
        Fri, 23 May 2025 06:42:40 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae42498bsm113528691cf.35.2025.05.23.06.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:42:39 -0700 (PDT)
Date: Fri, 23 May 2025 09:42:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Message-ID: <68307b4f745df_180c7829493@willemb.c.googlers.com.notmuch>
In-Reply-To: <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <682fa555b2bcc_13d837294a8@willemb.c.googlers.com.notmuch>
 <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 5/23/25 12:29 AM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> The virtio specification are introducing support for GSO over
> >> UDP tunnel.
> >>
> >> This patch brings in the needed defines and the additional
> >> virtio hdr parsing/building helpers.
> >>
> >> The UDP tunnel support uses additional fields in the virtio hdr,
> >> and such fields location can change depending on other negotiated
> >> features - specifically VIRTIO_NET_F_HASH_REPORT.
> >>
> >> Try to be as conservative as possible with the new field validation.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > No major concerns from me on this series. Much of the design
> > conversations took place earlier on the virtio list.
> > 
> > Maybe consider test coverage. If end-to-end testing requires qemu,
> > then perhaps KUnit is more suitable for testing basinc to/from skb
> > transformations. Just a thought.
> 
> My current idea is to follow-up on:
> 
> https://lore.kernel.org/netdev/20250522-vsock-vmtest-v8-1-367619bef134@gmail.com/
> 
> extending such infra to vhost/virtio, and implement GSO-over-UDP-tunnel
> transfer with/without negotiated features on top of that.
> 
> In the longer term such infra could be used to have good code coverage
> for virtio/vhost bundled into the kernel self-tests.
> 
> I hope it could be a follow-up,

SGTM!

Syzkaller will also give us coverage for the extended virtio_net_hdr
format. It has found many creative uses of that header before.

I did see the offset integrity checks you introduced when parsing the
header. Which is exactly what is needed to avoid such frivolous abuse.
They looked sufficient to me too.

> >> +/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
> >> + * features
> >> + */
> >> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
> >> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47
> > 
> > I don't quite follow this. These are not real virtio bits?
> 
> This comes directly from the recent follow-up on the virtio
> specification. While the features space has been extended to 128 bit,
> the 'guest offload' space is still 64bit. The 'guest offload' are
> used/defined by the specification for the
> VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command, which allows the guest do
> dynamically enable/disable H/W GRO at runtime.
> 
> Up to ~now each offload bit corresponded to the feature bit with the
> same value and vice versa.
> 
> Due to the limited 'guest offload' space, relevant features in the high
> 64 bits are 'mapped' to free bits in the lower range. That is simpler
> than defining a new command (and associated features) to exchange an
> extended guest offloads set.
> 
> It's also not a problem from a 'guest offload' space exhaustion PoV
> because there are a lot of features in the lower 64 bits range that are
> _not_ guest offloads and could be reused for mapping - among them the
> 'reserved features' that started this somewhat problematic features
> space expansion.
> 

That's a great explanation thanks. Can you add it either in the commit
message or as a comment at these definitions?


