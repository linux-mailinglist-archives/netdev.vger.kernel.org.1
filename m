Return-Path: <netdev+bounces-106440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9791657F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA6428395E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DE14830F;
	Tue, 25 Jun 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a64v6VGc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE95EE97
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312488; cv=none; b=O852WM7SMIvj/D2e4Z3QqzqnHSBFFu2CAr2CP8dKHW9bTr1YcB4TK46bKUxEopYK9EvZnFtlEtRaWYtZBaQZ+BIDWXdugek0yFQJnqmM0GEgXrixSK7uFYVZn33gaGAyUroKwqkml5NOGMKU8jXBquIgUoesemUqaQVkGVKYZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312488; c=relaxed/simple;
	bh=9nFKpaibRN9kC2rj0axdg4r5Q9Mn+COLC27rii+bKgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZTYVBMXH65e7AxvrkH/yGWvRkNyS2L0IgYGY7gfyufm23JQtkJGnLHRgkSafAac72OTESnlqxQlv2V678KONVMfaFwwAMTbQL9gjUIKiTIy6vzYTRoy0IrvLtMc9IFdsUwYQsnVgMi+wSTV1z8+uWfyhLqagkYrOMDL+pY+018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a64v6VGc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719312485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k+N1Zz/8PsExv7DPMnpWGtlej5MJgjXCpJCdjO+fDXo=;
	b=a64v6VGcjuaSeXa6eAm3JIYHQ8MbjOZ2p7O8O2dSPs+4VE2hOHiHyJLPSw4sDGrV9rmRUR
	jt1eKz6/iXzZkyvZLYQceSBE/zR5i3MKAFlZ5Y8GHwuOCTlA2MEvlJn9TOcLx70s82hd8q
	FlqsBPon3CTN4dxhWSpOLduIezixx5I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-0YlPd3gKNxqeopZ51J_sIg-1; Tue, 25 Jun 2024 06:48:04 -0400
X-MC-Unique: 0YlPd3gKNxqeopZ51J_sIg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-362a2547a22so148434f8f.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719312483; x=1719917283;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+N1Zz/8PsExv7DPMnpWGtlej5MJgjXCpJCdjO+fDXo=;
        b=JDdVdTuB0MyT+VhapYbht/kPQrOSNyM+zcFOuuBLhHs8RkiizHpTmwm4BLugKVDd8S
         YiE6yvzQIgWUwyCUoA1kJjTmuPuKITfyyLm8W2Ho1e4Hv9L0JG6ta3MRcgxASpjXM4hS
         SWFuq2gsOW4zB5aYUOGjUgxqY0kuSoYPwqJRjr89vNriXmV+akeWaj4vkX/1tqWgIasl
         Q1gsRAHNJmHz87cUxMmLoRazxGgh6+0Y6zTP3VZQwbGsZ4dwefac5GdWuqgtdmUHW7Er
         JXikpFNaWOmrS8IMzLZUyZoT3CP2ZSCkjIxt/D+SdUMP/lJswIj1o1hlgzJEtyuE1ER8
         GczQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgMe+t0E3yas/7v3/ynXczNPwzMIfoM+ICn5CI0YhPwfeaxVH9QIruSYLBo7Asx/HkIPsct8bDCaXakkDpbFe+m23nt96
X-Gm-Message-State: AOJu0YzrUVMcNbzqxveOfW0xT+uJlWn8+H+PR0o4xHA77hrr4QrtnW+v
	G23FUsEqDuD5D8aTg1nXBXh9nRz/SOoaXqSYsYiFMuhnuAqL39n7TuFCJEqJlZx1tw5h8wlZBNu
	NL4ChqhxHKJj4pRP7yN1VkEt0gJPAH7qwuPaNZ3h8dLX5pb17EAljMA==
X-Received: by 2002:a5d:6481:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-366df7eed8fmr6688184f8f.2.1719312483213;
        Tue, 25 Jun 2024 03:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkfmZ1QpXeNtB/CrBw4rTHfI4dCbEVUONOykMnoLPEvBx/FPul/x8SG9QmcZkYCi/1eFVGqg==
X-Received: by 2002:a5d:6481:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-366df7eed8fmr6688131f8f.2.1719312482816;
        Tue, 25 Jun 2024 03:48:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm12585191f8f.24.2024.06.25.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:48:02 -0700 (PDT)
Message-ID: <3f9026411e1f294da9da4ab84d383de3f68bd99e.camel@redhat.com>
Subject: Re: [PATCH 10/15] net: hinic: Convert tasklet API to new bottom
 half workqueue mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Allen Pais <allen.lkml@gmail.com>, kuba@kernel.org, Cai Huoqing
 <cai.huoqing@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Cc: jes@trained-monkey.org, kda@linux-powerpc.org, dougmill@linux.ibm.com, 
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
 naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
 cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
 stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com,  netdev@vger.kernel.org
Date: Tue, 25 Jun 2024 12:47:59 +0200
In-Reply-To: <20240621050525.3720069-11-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
	 <20240621050525.3720069-11-allen.lkml@gmail.com>
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

On Thu, 2024-06-20 at 22:05 -0700, Allen Pais wrote:
> @@ -968,9 +968,8 @@ void hinic_dump_ceq_info(struct hinic_hwdev *hwdev)
>  		ci =3D hinic_hwif_read_reg(hwdev->hwif, addr);
>  		addr =3D EQ_PROD_IDX_REG_ADDR(eq);
>  		pi =3D hinic_hwif_read_reg(hwdev->hwif, addr);
> -		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08=
x, pi: 0x%x, tasklet_state: 0x%lx, wrap: %d, ceqe: 0x%x\n",
> +		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08=
x, pi: 0x%x, wrap: %d, ceqe: 0x%x\n",
>  			q_id, ci, eq->cons_idx, pi,
> -			eq->ceq_tasklet.state,

I guess here you can show work_pending() as a partial replacement for
the tasklet state.

Thanks!

Paolo



