Return-Path: <netdev+bounces-49406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99B7F1E96
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A5B2110C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391F37177;
	Mon, 20 Nov 2023 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWjyDhkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F08D2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:15:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so5821071b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700514943; x=1701119743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJhAktQ8YptxCo0xFGqf0D0Bj/NGrMrR+E+DusKyhUU=;
        b=rWjyDhkGBnKExvoxje8U07YlSxaHW5Q+GgQ/iI3LYDj8hoiHMS5EAeR/6yzr8P5Xhv
         ALsFBiIqUjeET3nlxGcJjwpsIth2GU+GNVn/za1HNRIujNQ3Ytq+p0PQACWWz30yFdJi
         OU+BbdCqzdQCoUX+Vmpmr9N4lndYBbVs8xwHiAvI1Ppw09a/mw1q3XnP3FWZdHfMRi3T
         aio3IRpj5ENYgsnfSRlEJuyKVYMMYOvYVo9ERPfjxfGUT5I7+HNQ8Ud6gui4iD6NEBlh
         ig6klYomNhMDGbrP+5oZFvKqDNAZLbv08cY7jhomhIxgREJMGVeVPBWKxURzXQmBk1zV
         8bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514943; x=1701119743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJhAktQ8YptxCo0xFGqf0D0Bj/NGrMrR+E+DusKyhUU=;
        b=WIYz7dTv6s88hdisZpvGIo0W8B/FQBXYhY/GPrAV8PGZ1NXOaw5yIMclLbJgR1uOez
         0++Nc9hw6/rU15CziSUStts8E2GffoshYmUfjItPMUJ193aV97WFKICwkBXBEt9+rVLS
         bBbVJXYBsKQT//C5BGgjZbdw9LqVsL+tfosocxQG5x3oZSRClswnRVarYnN8ynG7i2p0
         vnQEWQPzK15peSCn8RFZCdBwnXQ4Ox42+XaBch6t7sFmYhQn05HK07LV0/SrcYQhR34w
         WqDD0xpk180d9v+x1K9fukJ3v3FK6NsoFuKN0Vcw+9hxDqYv+fF3mflAiYncg0+VNZZr
         2MPQ==
X-Gm-Message-State: AOJu0YwUNRTzz9tjCMNZr7PXMQvEVUA2Se+JAkED3RBBM/K2d5wDSbIY
	YRI0lZ02Uc9MWl8tTmnh7gd1NG0=
X-Google-Smtp-Source: AGHT+IGAcpy14NB4SIG15bm/T8tGAD4FjydZmjX9MDG5i1aAXgYyTPNALf9MpZAWrbYKr22joYwvqM4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2314:b0:68e:3053:14b9 with SMTP id
 h20-20020a056a00231400b0068e305314b9mr207509pfh.2.1700514942953; Mon, 20 Nov
 2023 13:15:42 -0800 (PST)
Date: Mon, 20 Nov 2023 13:15:41 -0800
In-Reply-To: <20231115175301.534113-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231115175301.534113-1-larysa.zaremba@intel.com> <20231115175301.534113-18-larysa.zaremba@intel.com>
Message-ID: <ZVvMfcOnqsyocJ6A@google.com>
Subject: Re: [PATCH bpf-next v7 17/18] selftests/bpf: Use AF_INET for TX in xdp_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="utf-8"

On 11/15, Larysa Zaremba wrote:
> The easiest way to simulate stripped VLAN tag in veth is to send a packet
> from VLAN interface, attached to veth. Unfortunately, this approach is
> incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> such feature.
> 
> Replace AF_XDP packet generation with sending the same datagram via
> AF_INET socket.
> 
> This does not change the packet contents or hints values with one notable
> exception: rx_hash_type, which previously was expected to be 0, now is
> expected be at least XDP_RSS_TYPE_L4.

Btw, I've been thinking a bit about how we can make this test work for both
your VLANs and my upcoming af_xdp tx side. And seems like the best
way, probably, is to have two tx paths exercised: veth and af_xdp.
For veth, we'll verify everything+vlans, for af_xdp we'll verify
everything except the vlans.

Originally I was assuming that I'll switch this part back to af_xdp, but
I don't think having tx vlan offload makes sense (because af_xdp
userspace can just prepare the correct header from the start).

So if you're doing a respin, maybe see if we can keep af_xdp tx part
but make it skip the vlans verification?

generate_packet_af_xdp();
verify_xsk_metadata(/*verify_vlans=*/false);
geenrate_packet_veth();
verify_xsk_metadata(/*verify_vlans=*/true);

?

