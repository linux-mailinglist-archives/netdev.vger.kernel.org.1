Return-Path: <netdev+bounces-170740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEDA49C44
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4777E18995F4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE676270EA6;
	Fri, 28 Feb 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyIOiYxO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DB26E959
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753637; cv=none; b=mDT/KbvSJtOyO/41gHQBEOkjMLLLImQbdF5YZ9+Z98bHt7yD/v/GZquyK04fdde30GnsyJ9jpqXsefPMw9lOi6fPen5MmwdMJqTY4ez8TZtEwYUI8BlvDTrk1ZUgv3TDjVG2J089lMYLoV9chTm+X98O9beDw3POk7SNShVMC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753637; c=relaxed/simple;
	bh=vvamKXaXonTikm8G6IDKp730/CDhnoJ0Mk8W9T1Ok3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4A/uo++Mel4eGoaTGQYfjjqczWxk+f2PGzCbmJ1cX1q24EFeBZwSP7n+8YOjWNqnnVCDHj+35q2s0RU3Wb18W4bqmSrVecJpdyG87rT0KI1OF3ZKN7kV5yIQ5LX+l+c2l9lHk2bQpPWYc0zKkF85qAYgP5Uvd4VZd2/QOU2+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyIOiYxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
	b=EyIOiYxOdjtErqp4y3lED5NUjsNF13aVSu6D7d7RCOd/6Bq/4I4J0Z+TGzXietAKjSs3/7
	QnE1wRQ6POPdRYPCG/fqQilTiIAU4o/3SNBNwSCXz//4ffU255kTKtl3gjA65hutnVv55Y
	gK71KJtBd797DXRrdiMy9JaCdEBEe8U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-H1B_WpbjPZuaJGQPicwlWw-1; Fri, 28 Feb 2025 09:40:29 -0500
X-MC-Unique: H1B_WpbjPZuaJGQPicwlWw-1
X-Mimecast-MFC-AGG-ID: H1B_WpbjPZuaJGQPicwlWw_1740753627
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abb7e837a7aso251062466b.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 06:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753627; x=1741358427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
        b=DwpmipEWpZAB3nBmkXDXnyxBXKqEIpsFS4efb/Migj1twoFcJjfm2EHK4TBM+25aF9
         5i6R1a5pnGlppypSsX++wJqiAsjGQnF1SGNZoBDPvOkVdw6wmep9prA8obVJIrxND5NY
         iCfZoQJtBTqofVUCqIvt0psqhXHaNnFDDk5bkwjIpFa1SC8pI/3iQNoPjooIsYTISUmz
         ppy+IjcQt9YePN1gmseu+kCPDzJFdNHvbWVetEKORAfUaauPS3JGtrD521LdZlpQJIZL
         hJ1PTB4dr51v9LRFhDtsBPmcEgGgMhHfP+o++GHhbQaHv1bu4vP/bhgTFnUMZLn5kORd
         QANQ==
X-Gm-Message-State: AOJu0YwJl+ExUNdorKzOTFl9noQAijhI0qTPpTgBl5dr2HFW4XKQ4MyK
	bq+XzZTmYClSiW3aOOD9hiJUaoBW9wiy4O5GBAXfdovFTIjuxt/WhTiDG1zA1hUruYndjgZyyaa
	4xYGIQHYo3Ej/5iiYIyLhx/SmvS+JLGbnRoUxw2Ti2Vbgyk7EXQHeL03jFYAqGF22y7uviSrmZI
	GYpD8jg5L2JTqyDP8BRr/fjT4kWH35
X-Gm-Gg: ASbGncvImXOCS4SHZShjQZb24ZGUSfTTzGLTOw6K2vWxyD71Vo4PmgQLggQz2LG7EN1
	OteDZBlbmcGsh69pjhytN8MB/pjVzo2veHFP4Z7rGDLurBQY1hijnQIEgsolp4HtN2up1d/Pvow
	==
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id a640c23a62f3a-abf25fb677fmr319208566b.13.1740753627002;
        Fri, 28 Feb 2025 06:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPegDg6tPejCUZgBS9Oz611YYT0gOXJGrHO0Mf3Y3+5jBs88zw4q+EJl75v4x09O8dKVdC8oCD4tipkFYJN9I=
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id
 a640c23a62f3a-abf25fb677fmr319205966b.13.1740753626613; Fri, 28 Feb 2025
 06:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 22:39:47 +0800
X-Gm-Features: AQ5f1Jri6SSnIUB3TA8bZTF7aUJK_L13tJvV7_Fad3fng_j3YX1IbMDftxVWDPk
Message-ID: <CAPpAL=xpdFVfFMzU7qQM=YGJvEyhSPyUDfrt2FyWx61BJgHjMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, mst@redhat.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also tested this series of patches v5 with virtio-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> Welcome to v5. Patches 1, 2, and 4 have no functional changes only
> updated tags. Patch 3 was refactored as requested by Jason. See the
> changelog below and the commit message for details.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
>
> As per the discussion on the v4 [3], patch 3 has been refactored to hold
> RTNL only in the specific locations which need it as Jason requested.
>
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
>
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> [3]: https://lore.kernel.org/netdev/CACGkMEv=3DejJnOWDnAu7eULLvrqXjkMkTL4=
cbi-uCTUhCpKN_GA@mail.gmail.com/
>
> v5:
>   - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 3:
>     - Refactored as Jason requested, eliminating the
>       virtnet_queue_set_napi helper entirely, and explicitly holding
>       RTNL in the 3 locations where needed (refill_work, freeze, and
>       restore).
>     - Commit message updated to outline the known paths at the time the
>       commit was written.
>   - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
>     functional changes.
>
> v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.c=
om/
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
>
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fas=
tly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
>
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
>
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.=
com/
>   - patch 1:
>     - New in the v2 from Jakub.
>
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
>
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
>
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
>
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly=
.com/
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 28 deletions(-)
>
>
> base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
> --
> 2.45.2
>


