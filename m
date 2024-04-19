Return-Path: <netdev+bounces-89609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D08AADEC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA8B21025
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384F823D9;
	Fri, 19 Apr 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMlIRBeS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA246200D3
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527642; cv=none; b=ly80Zw9RSJPHsbbOGgZSrhoEESGbpIoLEWt2Vj66v57q//B4yVTADSrTovarCCxltOgnPENG3+ZOmW9/DGKgo7ioIxyRH643ucvdQns3b/bVlYcO642WouaRr06nRr5tDDveLumalH6G7LWNU5zQnDu/21mxwyTSCQ4Pi/7YdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527642; c=relaxed/simple;
	bh=saGsoo/zJ+pMhVkwmiOky8LnM+WmGJUwqUTSK30WuBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCEDacr9cMh4xiTcA0/yzFS8NFbggu7KMIBEgL3vur6n105roEPP4Iodt3ZI8B/R/mn9tjkPZViNwqGCj1RoUaKNITcjbLQr5ies6ZxUttRaN/ZDW2ydMIdByyMmsmh2JfyT1JaFtRpDEjrp/qqsSG/LiFLbyWsWFKZurIM+5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMlIRBeS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713527639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=saGsoo/zJ+pMhVkwmiOky8LnM+WmGJUwqUTSK30WuBY=;
	b=YMlIRBeSbQj6z9igNFI7Udwo7ozH9N29LP2jcOQ3SSGs8CSDPGUJMRB84+2yRqo+B8mA0f
	T7CxFZqoiKeApGz2y5DVu/uolLi1f0WSiFiHCOB5vlVEzgpCV1Hehabepfj8gEe0FEt1EW
	HyzHoHcKeFrT0fQ+GKo1eWqwgY7vww0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-mvqGkOAVMr6JYLAkKHoqcg-1; Fri, 19 Apr 2024 07:53:56 -0400
X-MC-Unique: mvqGkOAVMr6JYLAkKHoqcg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349c5a9ee38so250564f8f.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 04:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527635; x=1714132435;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saGsoo/zJ+pMhVkwmiOky8LnM+WmGJUwqUTSK30WuBY=;
        b=aImogVnKNR2GDTvyJZx96tStKBEQDk2F2GHoLldV/aI+q1nV6SAXTEqPSTHgOPOGPW
         Q9SokFVNYTu0/bI3dH2bAuUoBqEV8/ZdZMNTeGr3lG0lkCNKLXINMb3/PoF6parvX5TL
         XCLe6u5k0kFxIHH6sXIvvEJ7JwcvBwCULd56mo6dmfng6MvYS9RJrvGgrgG/V3FlDlNz
         BhEZMVu8e2k3FQy8eTka2Cf4o9mAVz3vQePnz3lYIc3oNqXm1q9xXYe+wMgGoHtaT3uF
         lIFNeXruUqbM9ppj+ilaVLaTh9T3gj974PlsA4hODmIx2t+8Kufx6HSfPghjgBIYQMvR
         vlhw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRbAPvUKrWu0Y24REppI0rGETmSH/TX6/UWiBN/pRHRh/+xlAHBtX4FoMFSUg0sG96CYqOOoJTwH+KoHpStcsxxh96M0k
X-Gm-Message-State: AOJu0YxJ4M+dwnU8RtO3hBV+oApSTkLyGT/87B9RbRu/c1pj8Z4t7M82
	HZkN/Thi7P/I2G2u3p3eDiJL5TKiT/+v/D8FP2D1xN4ceBqZhhTdEYfOBv0MCDL2pZPA2ru0k5x
	Ni7MV/uocK27jT7V4y/LeQA6BzRmaxgn3YjU/a6MI8R5bIJO6ynDbBQ==
X-Received: by 2002:a5d:6808:0:b0:343:3f59:c97e with SMTP id w8-20020a5d6808000000b003433f59c97emr1072720wru.6.1713527635394;
        Fri, 19 Apr 2024 04:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmD2UL+cEsv/PZRLOL2dFAmRa5wcw65wK8SfM42d1vg4birPA0m7DXpcWsS1pVboxnBeZDWQ==
X-Received: by 2002:a5d:6808:0:b0:343:3f59:c97e with SMTP id w8-20020a5d6808000000b003433f59c97emr1072710wru.6.1713527634926;
        Fri, 19 Apr 2024 04:53:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0034a25339e47sm3392070wrr.69.2024.04.19.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:53:54 -0700 (PDT)
Message-ID: <0c1528838ebafdbe275ad69febb24b056895f94a.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Date: Fri, 19 Apr 2024 13:53:53 +0200
In-Reply-To: <20240411090325.185c8127@kernel.org>
References: <20240405102313.GA310894@kernel.org>
	 <20240409153250.574369e4@kernel.org>
	 <91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	 <20240410075745.4637c537@kernel.org>
	 <de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
	 <20240411090325.185c8127@kernel.org>
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

On Thu, 2024-04-11 at 09:03 -0700, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 17:58:59 +0200 Paolo Abeni wrote:
> >=20
> > Also it's not 110% clear to me the implication of:
> >=20
> > > consider netdev/queue node as "exit points" of the tree,=20
> > > to which a layer of actual scheduling nodes can be attached =20
> >=20
> > could you please rephrase a bit?
> >=20
> > I have the feeling the the points above should not require significant
> > changes to the API defined here, mainly more clear documentation, but
> > I'll have a better look.
>=20
> They don't have to be nodes. They can appear as parent or child of=20
> a real node, but they don't themselves carry any configuration.
>=20
> IOW you can represent them as a special encoding of the ID field,
> rather than a real node.

I'm sorry for the latency, I got distracted elsewhere.=C2=A0

It's not clear the benefit of introducing this 'attach points' concept.

With the current proposal, configuring a queue shaper would be:

info.bw_min =3D ...
dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack);

and restoring the default could be either:

info.bw_min =3D 0;
dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack);

or:

dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack)=
;

With the 'attach points' I guess it will be something alike the
following (am not defining a different node type here just to keep the
example short):

# configure a queue shaper
struct shaper_info attach_info;
dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &attach_info, &=
ack);
info.parent_id =3D attach_info.id;
info.bw_min =3D ...
new_node_id =3D dev->shaper_ops->add(dev, &info, &ack);

# restore defaults:
dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_TREE_ID, new_node_id, &info, =
&ack);

likely some additional operation would be needed to traverse/fetch
directly the actual shaper present at the attach points???

I think the operations will be simpler without the 'attach points', am
I missing something?=C2=A0

A clear conventions/definition about the semantic of deleting shapers
at specific locations (e.g. restoring the default behaviour) should
suffice, together with the current schema.

Thanks,

Paolo


