Return-Path: <netdev+bounces-82804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66688FD2A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63667B292DE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FC7CF33;
	Thu, 28 Mar 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ysx0mM3F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D157895
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622054; cv=none; b=YpltbBptGZFGdCzEhg7z+uiIqCcgQpnL+HKbCvJvp6Ly/gqlae1rEHV9S7hbrdE+LlYN/T/aNr8O2WYCD3zRf5v2QJnPCTT4wq6WpO9sULTQRPkHXcBoNAdDZsHPw+HmVAAynHtNw0e11fJQiTOFT2jACXKeY4+tf+nePqQagnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622054; c=relaxed/simple;
	bh=+ad/hoB9dd8EarsV8rLVrOWJFI/NCOLGBcEthgahtuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItZefkdBSDXKaAs6aq0Y+A65gXskVcVmSPvnr1d3teXcPMe2Z8EAskZ9Og0zjOod8zwXM1K+Ss9qnEAAlpgUCtSMv/sH9kMYtfKiuBQZA+GMn5QPKEOs7MTxZwSLwLIW7APX6lS/jrSkX1VJ19yYUe1Bxd+fr5m3Wcef4WEIzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ysx0mM3F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711622052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1IxLcm5VF1ZKM6N/R+53L4zTQRtk19u0z0ECDAJ31Y4=;
	b=Ysx0mM3FLh2UnCOB742hUrv2bS5x7D1N1epncFgJD8RqF1StHqfLqk/xCYgMZyTmV6Erel
	aLRvbFuy7+qVLu10A7L/Dov2KFlohyFx89txp4QDJ5SMohkJA/tZSVtKnO9V8g0j37GCvk
	Kpv3Qd0IsO12r1U3UbG5b7qdRqFaZMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-kM7EOYlqNj-GCRTOAqIzRw-1; Thu, 28 Mar 2024 06:34:10 -0400
X-MC-Unique: kM7EOYlqNj-GCRTOAqIzRw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-341d0499bbdso174313f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 03:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622048; x=1712226848;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IxLcm5VF1ZKM6N/R+53L4zTQRtk19u0z0ECDAJ31Y4=;
        b=KIRmdrxdc0tEkcJcia+fOGKOPI1rUJAuIVNyM6cx+ngz9R3HKjHIfVTMmk4pnxiqt0
         JvEpCFCjxRnWgnEEweMwSm4Cl8vpu8RihbchikzWLX2mqZgKYELJIBIznxFiokIEnH4z
         yqMa/PZaNgHMOfCx1enbDJ+zvvn5O2HEJKrlwPHsdJNCi/CKtvjAD9c29/x6IR6X2L0x
         ZzKm7TQtP212Xa/wk+QzNwqWKbi+Zy/awUK7yy7fiYDVKj2IOO19uJiYaSJqbWAFLqH/
         DYLRSw5AwY6VfN+pOBvLDjQqW19oZ4+wP+DDqY9SWveUlGpJpUGXh1p3G0mGMqoGHQBE
         EkRg==
X-Forwarded-Encrypted: i=1; AJvYcCWwkLa9c5WNi3IW6CjdTe4IClkup5fwvJVaxN7LkArm2owUESGAPZL5efdvd1UMPQruhmUxndu3PGscIp7LeROmmgERlK4t
X-Gm-Message-State: AOJu0YwMsWdSZlG2pty3UdhnN8gftE/HBD6z7qMysBRuaZKAxEF0hyWv
	6qxWKSuDYxw5wXMSXlFP8TlJUlVeZkma+hzKjFvxOs1NiLzqurrpS58M9IJHAmASNOvCd34TeC7
	kdDNAMY36RTwJUbpfK2u9ZwkAMxe+ZhB+SszM6obny5Sd0dyZE5+ZKw==
X-Received: by 2002:a05:600c:3b04:b0:414:b440:4c66 with SMTP id m4-20020a05600c3b0400b00414b4404c66mr1942513wms.3.1711622048149;
        Thu, 28 Mar 2024 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZbeRLexz37XOXW8pgf5qgcy+nuEEXVGmbgL79/Pw9xcIamBV90wWvsAtnAImUMYIKMb4EJg==
X-Received: by 2002:a05:600c:3b04:b0:414:b440:4c66 with SMTP id m4-20020a05600c3b0400b00414b4404c66mr1942497wms.3.1711622047727;
        Thu, 28 Mar 2024 03:34:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-47.dyn.eolo.it. [146.241.249.47])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b0041462294fe3sm1860034wmq.42.2024.03.28.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:34:07 -0700 (PDT)
Message-ID: <8097366d5c7dcbb916b32855d2a56189a3e6dda2.camel@redhat.com>
Subject: Re: [PATCH net v2] virtio-net: fix possible dim status unrecoverable
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
  Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Date: Thu, 28 Mar 2024 11:34:06 +0100
In-Reply-To: <1711434338-64848-1-git-send-email-hengqi@linux.alibaba.com>
References: <1711434338-64848-1-git-send-email-hengqi@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 14:25 +0800, Heng Qi wrote:
> When the dim worker is scheduled, if it fails to acquire the lock,
> dim may not be able to return to the working state later.
>=20
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. The ethtool command is holding rtnl lock;
>   3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>      to acquire the lock and exits;
>=20
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
>=20
> Patch has been tested on a VM with 16 NICs, 128 queues per NIC
> (2kq total):
> With dim enabled on all queues, there are many opportunities for
> contention for RTNL lock, and this patch introduces no visible hotspots.
> The dim performance is also stable.
>=20
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v1->v2:
>   - Update commit log. No functional changes.
>=20
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d111..0ebe322 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct=
 *work)
>  	struct dim_cq_moder update_moder;
>  	int i, qnum, err;
> =20
> -	if (!rtnl_trylock())
> +	if (!rtnl_trylock()) {
> +		schedule_work(&dim->work);
>  		return;

I'm really scared by this change. VMs are (increasingly) used to run
containers orchestration, which in turns puts a lot of pressure on the
RTNL lock. Any rtnl_trylock+ reschedule may hang for a very long time.
Addressing this kind of issues later becomes _extremely_ painful, see:

https://lore.kernel.org/netdev/20231018154804.420823-1-atenart@kernel.org/

I really think a different solution is needed. What about moving
virtnet_send_command() under protection of a new mutex?

I understand it will complicate future hardening works around cvq, but
really rtnl_trylock()/<spin/retry> is bad for the whole system.

Cheers,

Paolo


