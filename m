Return-Path: <netdev+bounces-194686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA3ACBE69
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 04:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B857B7A7FA2
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA32165F16;
	Tue,  3 Jun 2025 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxdNlVSq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FC1586C8
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916707; cv=none; b=e2dnPSEoA4EtXF/6vI6Srrf+MuIjN5NUJJ4TEJnzRnnyFbitOpdrfZDg5nnHuuP8HND4DRpSsAC9hx4F+ajpAy8iqp6P39/Z50y9r1lj9ZeupWcLEELAeMe0PTkgNsFObjm3l6rySe7cCzC/Aa7Dcp56dir4iW7tkFVGs85O6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916707; c=relaxed/simple;
	bh=5SUkoIWMAjAIpIXlBFSaT5tFv90k2XZW34zAkFU3E4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMQp3ICUz05voofHS0nLFlkv1WQKLJTi5enJHr14xiZ7k9LskF/2doL9rKyfo1mL7oOjor+400OR003kMPTAuNcBNVia8FqrM4VywFk3v45evhM+v/uDyVRjKjq8LTNDkWyn0frKMPftEw/BUvU/Ri0ygXVGJpcukRqDtIIqQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxdNlVSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748916704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdVPkapicRjOMbtBLEJrl+03IyctNYMht/gYKDQDs14=;
	b=GxdNlVSq77iYwWh8WGxzV4cOJixzcHYR7a+dH+RctXVQicTzhwyi5w5q1VNiKVfM3MB0++
	xflBUD5cY8Z0teM1XsMqyOUPDcuuWy8zTD8WJNDmTCei4MzKXL2jhQ7qxLmmzwsttbt+my
	6VhqAVazexs4VPV2zJBI6W5vYPYGRww=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-88WF8d2bO2umLyPSS1gjCA-1; Mon, 02 Jun 2025 22:11:43 -0400
X-MC-Unique: 88WF8d2bO2umLyPSS1gjCA-1
X-Mimecast-MFC-AGG-ID: 88WF8d2bO2umLyPSS1gjCA_1748916702
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311d067b3faso7625061a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 19:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916702; x=1749521502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdVPkapicRjOMbtBLEJrl+03IyctNYMht/gYKDQDs14=;
        b=ZYvztrX6l/z1LCuzH4tYpk0mQVYMNeU3HXcZMEROaE/cdkfkVaVKtj23j7NXK8kvNS
         ZTBhoJBzR9MXcYIaR9OlcuLSKnk3mQ1weDJZTLCciLpMwbCBK5C2hmy1e6JvX/DVCP3D
         fLDkAXYIE64ounmFoAeXSNTu60xrbJwbGuHyfE3fUnzYegX0zoJhWR72M5IzNBA+Uz4P
         qVfR5uE4GbzLnOr5gC4rGAZ4bID8qALHpSA4w+9FU/mFKEN570AplSl7a8FlrPFNti4s
         MYohR+EV64mCh1NWIB9JE5QlzYUsiMWn9q5EYJl11NeMVJmezjwyiwAFjabUViW0ltF3
         PDoA==
X-Gm-Message-State: AOJu0Yybixk6XYHZFucI6c3DGjiDxp+nB5WyMUAKRIRsd2lZsiGaum9e
	kXo4I2UfP0lA8NvW+cM4azCIexG1RujGEEqLXCFi0muo1IJOuAtzJZfM84xtFoU6clLDuDYRjLV
	hxtYdq3CZnZhXCGhiq1Vu3+5ROS+lHYEYZN0wCv0sYHGAPhyMJN6NvGRn/rX64q5DLTVhLA/KkJ
	HEb+84vqGZ+s0n/9rgutXJuII3yKm/sm/z
X-Gm-Gg: ASbGncsrU659RATuqftYs1OwEXiceiYzpH/iDGteyPV5RHj48VL+wNZQpZRQeh8I5t5
	nhqhjVJ+xVR+4I7WqEkUmXPDcv36LxeQB5vqc6LZz4c1xf/HWY47l87ddgg9uJsHuM1KE2g==
X-Received: by 2002:a17:90b:2e45:b0:311:e8cc:4253 with SMTP id 98e67ed59e1d1-31240c276damr26174108a91.2.1748916702478;
        Mon, 02 Jun 2025 19:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH22Ck5H5kBYkSAPhvNBddiR8+6yeJeIj256Occzgr5iA0NaiEUdRfCvoFdM8kvI5iKw4roNSPViIiw/U18i74=
X-Received: by 2002:a17:90b:2e45:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-31240c276damr26174086a91.2.1748916702160; Mon, 02 Jun 2025
 19:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com> <1f852603-5585-4c3d-9689-b89daba8fee1@redhat.com>
In-Reply-To: <1f852603-5585-4c3d-9689-b89daba8fee1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:11:30 +0800
X-Gm-Features: AX0GCFv0aEEBg3a8JsJmYwKGhVekURlCD5BtQTgiAKvY2FC_V40CMrCpJauuvHU
Message-ID: <CACGkMEu3Za1D_U2qC7MGyVNuHsmuMby4gbEopN8E_tQXWr2zwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/26/25 6:40 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> @@ -242,4 +249,158 @@ static inline int virtio_net_hdr_from_skb(const =
struct sk_buff *skb,
> >>         return 0;
> >>  }
> >>
> >> +static inline unsigned int virtio_l3min(bool is_ipv6)
> >> +{
> >> +       return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr)=
;
> >> +}
> >> +
> >> +static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >> +                                           const struct virtio_net_hd=
r *hdr,
> >> +                                           unsigned int tnl_hdr_offse=
t,
> >> +                                           bool tnl_csum_negotiated,
> >> +                                           bool little_endian)
> >
> > Considering tunnel gso requires VERSION_1, I think there's no chance
> > for little_endian to be false here.
>
> If tnl_hdr_offset =3D=3D 0, tunnel gso has not been negotiated, and
> little_endian could be false. I can assume little_endian is true in the
> !!tnl_hdr_offset branch.

That would be fine, and I wonder if tnl_hdr_offset is better than
having an accepting struct virtio_net_hdr_tunnel * (assuming we agree
that it is a part of the uAPI) which seems more consistent and avoids
a cast.

Thanks

>
> /P
>


