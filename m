Return-Path: <netdev+bounces-130185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F5988EFA
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCEA1C20DAD
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABD0170A37;
	Sat, 28 Sep 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMDsb1F2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630943D3B3
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727519476; cv=none; b=CwydLZH+Rod6O/z/AOC8rnXN70k3zzkAADkGFlPT4U8CJgR5nPg3te0Oh9avARbKWdX8fASIvZKB4F/CPg5/LxpPlbFTDUP89PrSYHMdNv0mqmf9Nrsoxh0Bu/dxfSrocrpj77uqhRGPfa5CRkeWk9AeM0M+gqI8lpvUsTmSqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727519476; c=relaxed/simple;
	bh=dDHrR22WmXcK1oZRFZfxwGP+7kFIwDMTIs076q/6V4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTsiEUzrz/SgSDMluE8K1wu3kXwa2A7pLsgJ1NjyjvkzZ6EiYv0Zz+f8ilJ7i4TACkWxeu/HXYf6UjW6C2O50kVYr51+HSJYZy2bCiE+gG/sTU+t+V3uiOQSy6qfKi26qsK0E7VQSq1wn/4VWmEt+0PetzDjcRbaawZOO0WP/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMDsb1F2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c718af3354so3659568a12.0
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727519473; x=1728124273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEisC0iRnLOpREGpVd6A93qrY+F/ucLTNFfZyjxhWMA=;
        b=vMDsb1F2KdnOU0GIFE6G40oidLvkWLu/7WfqJFM2ZkWml30mg60h4CTPDlO+Sby9TY
         YWRxCPE9CfMUdmY7eSKprGBhLGd8pVgGV65Jz48FKqjt2lMxmZt9QJuQN7ODKhe+rn/u
         Vw0jfzB9pSH9P8Ey7wkvm1KHUj+HEckQxRrV7YrrxK8mlIJD0oiL05hHz8wh+WfOVsdH
         98UBwHWqhVa4Yi+n8lsthdYxsGDUl4iZR94ifDyZ8qvb9CjPVwX3pmTi2gSOYoGkpVPT
         FHU0T/S2oHQBA7e5RYw+JrZpt+xqQP/S2lCIr9Jhu+8vm1HhugY8iusUbUw5MU4/mUWl
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727519473; x=1728124273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEisC0iRnLOpREGpVd6A93qrY+F/ucLTNFfZyjxhWMA=;
        b=FPBjcoVail+vAwKW01zmjos15Aj5fXmJXXcOgA6RxnhKam4EbzhzOa+v7CX6s+P/J0
         +5ABiZVRtlY+8U+0hxSHqut5CEMc2J8jnIoZs88/3Nsn0ufWrHR2lHqLpJvU2ZK6sHSR
         MUn4Z76/kvtV15cFKUx1PUUtIYo3Dx5Ol2I7VygjnlNwy6C2J8X49a5wOs6YVb+HO51/
         aHw8S8U4qRmncBbdrBKJ9wsd+DrRS1hZAsyA+c0fIBcrGVC9pMsFo3bUXEqGF6xkTfS4
         PKYVWFKfPijdoFdEdDT3vwV4lyCWZEBsypqhVhWsnGLokZ3H0Uy4fSggy7BKj3lRasve
         Q1UQ==
X-Gm-Message-State: AOJu0YwPWFL7zVkdOPIRi8Gysdv7SPYpCg2947UzBoacevJCqv5vWAKp
	oZyWVfsG3mcmxpLMR8VdxNdz/2GIz3ryadJXbrwpZ/OSy7KOpeJuthO35vaDoKjhUVtjBHwT8JG
	pGsD9BZJ1LnOwA3G3U8gSgTW8gV3HRRHFcNxpn04wZx3lIhSUhQ==
X-Google-Smtp-Source: AGHT+IGs8s4/clyDBjxyWsfXBD07dUrX3uXFq6NNpNNKcODLAYZn3PgCmyDCXjPgjKTL4lCpqXExfBmGtguaX51yLAk=
X-Received: by 2002:a05:6402:42c2:b0:5be:caf6:9dc7 with SMTP id
 4fb4d7f45d1cf-5c8825fd2dbmr5517804a12.25.1727519472268; Sat, 28 Sep 2024
 03:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Sep 2024 12:30:58 +0200
Message-ID: <CANn89iJb_ftSAE1vNCjtEvt-XBjXUy6DymLbxc+WOJELrk7+nQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Suman Ghosh <sumang@marvell.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:53=E2=80=AFAM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Regression Description:
>
> Depending on the options specified for the GRE tunnel device, small
> packets may be dropped. This occurs because the pskb_network_may_pull
> function fails due to the packet's insufficient length.
>
> For example, if only the okey option is specified for the tunnel device,
> original (before encapsulation) packets smaller than 28 bytes (including
> the IPv4 header) will be dropped. This happens because the required
> length is calculated relative to the network header, not the skb->head.
>
> Here is how the required length is computed and checked:
>
> * The pull_len variable is set to 28 bytes, consisting of:
>   * IPv4 header: 20 bytes
>   * GRE header with Key field: 8 bytes
>
> * The pskb_network_may_pull function adds the network offset, shifting
> the checkable space further to the beginning of the network header and
> extending it to the beginning of the packet. As a result, the end of
> the checkable space occurs beyond the actual end of the packet.
>
> Instead of ensuring that 28 bytes are present in skb->head, the function
> is requesting these 28 bytes starting from the network header. For small
> packets, this requested length exceeds the actual packet size, causing
> the check to fail and the packets to be dropped.
>
> This issue affects both locally originated and forwarded packets in
> DMVPN-like setups.
>
> How to reproduce (for local originated packets):
>
>   ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
>           local <your-ip> remote 0.0.0.0
>
>   ip link set mtu 1400 dev gre1
>   ip link set up dev gre1
>   ip address add 192.168.13.1/24 dev gre1
>   ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
>   ping -s 1374 -c 10 192.168.13.2
>   tcpdump -vni gre1
>   tcpdump -vni <your-ext-iface> 'ip proto 47'
>   ip -s -s -d link show dev gre1
>
> Solution:
>
> Use the pskb_may_pull function instead the pskb_network_may_pull.
>
> Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmi=
t()")
>
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

