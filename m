Return-Path: <netdev+bounces-237779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ABFC5029F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC14E1A00
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61119DF6A;
	Wed, 12 Nov 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi8RwPRl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMXy+88V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245851F5EA
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909240; cv=none; b=JwdakBLOgXKZoFaKeDcdxmS+c201SYhL2F1A6hdpefwWq6GIpaMaS9q7GPLGRvSgw25JTePnbbE0wsUfXoFqOJswcu4xFnQdin7TamaRj8e9Wamo/XUHehCsUU6rEr69iRCIMud/7P+t9Ok2YjAcnu/KjIdV6I6YYTIZzDaZLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909240; c=relaxed/simple;
	bh=zzKo2mj/+4vtvIo5VcfAPqVBZTJajVhadduku3w/Us4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2CfD30AlvAewZDM5W++uRu76iSAQQIfqmCr6M8uoqV6UX0MyKsw5LdYi8O5XJU/l3KEzO72XYNdEeJVRbsqTZDbNBSXxcM8wSb71vaxZUAeaZn/Rwhi/FzipDxrDIp8OmsfUrErcaYoQwas7ymvyBEZ8BuiRkTKfXxhPpte8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hi8RwPRl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMXy+88V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762909237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFVrOXbCFRxnp2issGLmDi5PFJkGnCTM0Na+vvGf2k8=;
	b=hi8RwPRlPPhMgui1g6pB8rU9ZV74BNh4oK6bl/e+dicZmRlaippmRZEBwQH4yJ64BUGwqg
	UyMuF83fR6CTW6AsYxXYHws2BpBaOJ50A3dwKDHth+VB4TZnuKFjmeIor/YXy/FHCG3EwY
	1eGPp6t4a3tq1YBFOA/+fjj5Ts2SoII=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ffxWhUCtNmaP_O2Ugfjlqw-1; Tue, 11 Nov 2025 20:00:35 -0500
X-MC-Unique: ffxWhUCtNmaP_O2Ugfjlqw-1
X-Mimecast-MFC-AGG-ID: ffxWhUCtNmaP_O2Ugfjlqw_1762909235
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93526c6b4f6so184236241.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 17:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762909235; x=1763514035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFVrOXbCFRxnp2issGLmDi5PFJkGnCTM0Na+vvGf2k8=;
        b=jMXy+88VOeZAXz7li8lPxYdYlccS3e7/Mssa3QijKTYXty0iWtSWS9plyOt0pTGrKl
         dDtpN00oUbbwOHjFzL8C0oYvqpiiemVvsjhEbHeoycgvf1DIT0SNRWG+2r8DNZSX8Fpx
         W0u38VR8ndMFPyVWORSd6xl/X3GNk6CCnmwaXHUvCm+I62zHfBYAeiUgZmgedOAbATld
         YC2KvseHsZA42BYYEqtfek9EJAOzaLF+viuCtlhfYBW3JzQQjhmhCRbskWrgKhxy8R1o
         9eCzl/4JNEWoLJJVRuBzcZO7XMuyVr0G+2orqDd/eEC+ggs6JP6WORefBrhO8PyF1wM1
         nB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762909235; x=1763514035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFVrOXbCFRxnp2issGLmDi5PFJkGnCTM0Na+vvGf2k8=;
        b=DRC7G9VIWvowV81wtw1q7KTsuWUkofiMwh0Mmp3ThPPh21Q8K4p0CSxRDGfvGgUcsJ
         a0LGS+S/UvyMYG5wii3x0z8NGUTfUgzK+xkIUKjKMh6nrb8YqGky0rQRIwYBum+/E6Um
         NscsSj4kBJfXHmtBa4ZPH9CTJtBD8ogu2TnPWmw/wXrJh2+mVbkIlfDFWvS7v6YgzUIu
         CibJafks2M606x0qZRi+lfGXq3ThTWEGikXrdy6xfl5XxEBX6MrhNPwxHmgtte/5pT4H
         q89kJfbNqytCVaANWysX5kzVVA9lx690wMn/9zxySjPkuSC6IqbXJQFplBENsyDoRtFr
         12mw==
X-Forwarded-Encrypted: i=1; AJvYcCUFppqkvJul9bdNiEOEdaw9eHlm9fjW1QXi+rXi6UOnvH3NGbl4SUHpOQvVMXkf18qSjBYeFo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GU0oki3yhqmxc+BQrvDbYXy1k32f8UuAmloPdYaZBO/PboKm
	Iyza87O1tylpDeqOjZT9DGjO/x6B6PIoENilC25YIKyJ/pIvtF3xQAuqbnRGCxnih2yRKgDE80a
	iQuvUVloR5yvbC70Hz1KB9uOh2e67EP2Nw1XFbYmRXJxbKhf07WGTCqOLEofJEWsaDmSQThL4NG
	7pZ38BXih0+/diWMas1XCsczvUxQTCvpa5
X-Gm-Gg: ASbGncsUY7D2cIlcw/NhbfV2p/YzBZ5CTTHFPI2dhiD/BEEWX5ZGNMxOqHxBfvKcf+G
	Vm5a+3dXzChRd05WkD2cdILp8iSUggm42ffXLptDQIunI+WijrwhxThAffkLJv5hc/vQRy72Bho
	w52Bxq9MXrJGoeUypw0aCGN8405InGtWy0njdV21HdxyeYaHPWY686CMDd
X-Received: by 2002:a05:6102:c04:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-5de07d583b4mr283746137.13.1762909235004;
        Tue, 11 Nov 2025 17:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgpt/cD5eXz8XccmQv5+UwYlAdDSB6UzWuxssggO0EBznFSIg1YG1onbagrA6UIT13LrlniFagHoveoNvzrs4=
X-Received: by 2002:a05:6102:c04:b0:521:b9f2:a5ca with SMTP id
 ada2fe7eead31-5de07d583b4mr283733137.13.1762909234629; Tue, 11 Nov 2025
 17:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
In-Reply-To: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 09:00:22 +0800
X-Gm-Features: AWmQ_bkX9lyiKTIQGwwCGxeG6NPaCiYy1VfK14nH1UflcpzDspDFS3ytGYyGxbs
Message-ID: <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> > @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >       }
> >       vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +     /* Initialize flow filters. Not supported is an acceptable and co=
mmon
> > +      * return code
> > +      */
> > +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> > +     if (err && err !=3D -EOPNOTSUPP) {
> > +             rtnl_unlock();
> > +             goto free_unregister_netdev;
>
> I'm sorry for not noticing the following earlier, but it looks like that
> the code could error out on ENOMEM even if the feature is not really
> supported,  when `cap_id_list` allocation fails, which in turn looks a
> bit bad, as the allocated chunk is not that small (32K if I read
> correctly).
>
> @Jason, @Micheal: WDYT?

I agree. I think virtnet_ff_init() should be only called when the
feature is negotiated.

Thanks

>
> /P
>


