Return-Path: <netdev+bounces-91667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045208B362D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5EC284BAF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50D1448F4;
	Fri, 26 Apr 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciH+tcZi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE7143C67
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129216; cv=none; b=ZKSkY1L0CajSUH7rLYeQFxnVDyDFaTE4qhw/kSrvIHqQ/PrMv95lKYo3AYzB7D81OGwxLnXkMZjkL3SaXMCEPkDs5Bq2SwiotwVNRFzylHgwclKFaOeP0DJ2Ooh3HC+Uo73X54k13qxqSUGgEVXdC9VYdA2bw90w+/axK2Yt2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129216; c=relaxed/simple;
	bh=CtOi/0dPQF8qlAD8nVHiqDqi3MtonLQxBAmh2S54SbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wqi/sPI5AVnuxhWdqamnwS556a8vP7m549RcWvhtsLU70v7Gh0rRklxU1vqp/+j0jLcXJE1EmAYajJ9bgXZCBYn2UgXE+JyjML16DD7KjnnTNzwQklTnaaKXhMFKNO9NPacpPIrkActrBnv6oxwfdEDKmJn9UduATisAEc3SLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciH+tcZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714129213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VRKxMtqHs2wgUn/4jXt4dUFqRAFf/DY+zHLZIvUUb+g=;
	b=ciH+tcZiXevhL+zgcU3P3y1+v7lRBbL8GPknlhTYbIlGu9KWv72K/E75sZmC29ua5QXJj0
	cCe7w51kW0hyXKsFcTn28rVGuEqnJIFREIojF0ExhkXkFSt1AWXf7ppMmwnPp6sDdsls1V
	AwGxQSholwJEfzyinGpcLDRxg7tkLKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-m9jXuqiRMqqVkhkZFsBdAg-1; Fri, 26 Apr 2024 07:00:12 -0400
X-MC-Unique: m9jXuqiRMqqVkhkZFsBdAg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34c5ed73e41so42444f8f.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714129211; x=1714734011;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRKxMtqHs2wgUn/4jXt4dUFqRAFf/DY+zHLZIvUUb+g=;
        b=pZ19uh+uou2A9DjxwamA0Xvz+QF50vngAGRATHVEoGs+5ikC9F18p5+/Td2T5c2ySC
         lFabBV3oKofuR9aEcujq4dS9Zvr4qdnkJmH+ECKLjhPnrofnmKw5UcZeZAHf31ROd2G+
         1fv0YrEPD/zSvzSsRftxHFa3Cv/xstKHWa+QOwizMpAQRhpt3B/qCYY2rb9CvWAl5P33
         yh3UtjLB1vD85gGYG8mvXguIiNa7z+IUm7DUOceGuiHTDPd9DvtuL5GYmgkyBNCHs4+u
         w3pX/Jsz+gCALJM2TcN8l+klheiHsW2FQYUCqeIYtqH75bM5PIutE4AjpMLJ6bG/G1cq
         wEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVjUQtNSU5a1BkI2PLvIjhGYFyYnLRZ5bnGm5hfxolVBSpm2JjDs9qUigUf75P7v28wYoC9QKtypvgin5+IePTONx/Sfbm3
X-Gm-Message-State: AOJu0YwE3kz7hNaGlKmjbmYv8OZldQuMU6/f+aqPJAveBVtZtyIQA6xQ
	CowGvNwIBxCDDj1itKtv52gomDjR7yNunU/RcBcelbcGI53n/Ni2gjbxdNCkuVLWAaE8AmHh4T8
	6UoYYrRoDuCbs9k3d7/Y2he+wlMhoJM4faj3DefqUvGrwLn1C/PdaNw==
X-Received: by 2002:a05:600c:4f13:b0:41a:c4fe:b0a6 with SMTP id l19-20020a05600c4f1300b0041ac4feb0a6mr1770951wmq.4.1714129210926;
        Fri, 26 Apr 2024 04:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7i5rWuE1XAjQg+GaCVb5jl4+TYMtzZetwFkMO/dpB8lCiNLQET84fZIACfhDR6eTC+rLiQ==
X-Received: by 2002:a05:600c:4f13:b0:41a:c4fe:b0a6 with SMTP id l19-20020a05600c4f1300b0041ac4feb0a6mr1770926wmq.4.1714129210517;
        Fri, 26 Apr 2024 04:00:10 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id k9-20020adfb349000000b0034c4d0a286fsm1528309wrd.13.2024.04.26.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:00:10 -0700 (PDT)
Message-ID: <45002f120a57ec362459868a67af1627a22274d1.camel@redhat.com>
Subject: Re: [PATCH vhost v3 0/4] virtio_net: rx enable premapped mode by
 default
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Date: Fri, 26 Apr 2024 13:00:08 +0200
In-Reply-To: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:16 +0800, Xuan Zhuo wrote:
> Actually, for the virtio drivers, we can enable premapped mode whatever
> the value of use_dma_api. Because we provide the virtio dma apis.
> So the driver can enable premapped mode unconditionally.
>=20
> This patch set makes the big mode of virtio-net to support premapped mode=
.
> And enable premapped mode for rx by default.
>=20
> Based on the following points, we do not use page pool to manage these
>     pages:
>=20
>     1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
>        we can only prevent the page pool from performing DMA operations, =
and
>        let the driver perform DMA operations on the allocated pages.
>     2. But when the page pool releases the page, we have no chance to
>        execute dma unmap.
>     3. A solution to #2 is to execute dma unmap every time before putting
>        the page back to the page pool. (This is actually a waste, we don'=
t
>        execute unmap so frequently.)
>     4. But there is another problem, we still need to use page.dma_addr t=
o
>        save the dma address. Using page.dma_addr while using page pool is
>        unsafe behavior.
>     5. And we need space the chain the pages submitted once to virtio cor=
e.
>=20
>     More:
>         https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujSh=3Dvjj1=
kx12fy9N7hqyi+M5Ow@mail.gmail.com/
>=20
> Why we do not use the page space to store the dma?
>     http://lore.kernel.org/all/CACGkMEuyeJ9mMgYnnB42=3Dhw6umNuo=3Dagn7VBq=
BqYPd7GN=3D+39Q@mail.gmail.com
>=20
> Please review.
>=20
> v3:
>     1. big mode still use the mode that virtio core does the dma map/unma=
p
>=20
> v2:
>     1. make gcc happy in page_chain_get_dma()
>         http://lore.kernel.org/all/202404221325.SX5ChRGP-lkp@intel.com
>=20
> v1:
>     1. discussed for using page pool
>     2. use dma sync to replace the unmap for the first page

Judging by the subj prefix, this is targeting the vhost tree, right?=20

There are a few patches landing on virtio_net on net-next, I guess
there will be some conflict while pushing to Linux (but I haven't
double check yet!)

Perhaps you could provide a stable git branch so that both vhost and
netdev could pull this set?

Thanks!

Paolo


