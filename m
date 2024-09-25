Return-Path: <netdev+bounces-129646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDAF98516F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CE71C22CE3
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A98148849;
	Wed, 25 Sep 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSfNEiQr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61B13D28F
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235073; cv=none; b=SQQgj4Ml50IObmBmAEByypaVRnIunVhVi0hLmjt594CPsOBNHihna+Li1vNRJYmof8B/3xdvpxEc4ChXb4cFgP9lE84Tip2ZWGEFK3uORupHY5SEFHdI0+V8LGQ8aVpT1l1Wz8Q92EgklZ2PgAKxFqW+kMt6jHvjFkbmjlbxCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235073; c=relaxed/simple;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdt+tZAy4TxrKlscDZvEi0XJhq5penqN100dqCmtYWtRbs1+uW95IhITNnTDIbyjOFnLwq5YwRpJMibwY4Dd3p3AFqJmDgQRxjinpFvZfiB5ye2e/RePf8g4RcxNxCRAR2jjLtUZ34OQW+itP3enCe348/uCYyaMnEhExT8P6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSfNEiQr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	b=gSfNEiQryX5Qntgto1tG6oWI8Yteq3asQBw9mV0khYlN/cDkXo1gOithLrHHonTnbrrbCy
	aQL16PWKNa9TQLZJCbQV+YztanCBtx+JWlIorV7USyWzhvFMH5+I1g8ZIE69cRxTKis+wP
	w8Wf+q7zw4l49h9OTQtL6/8dzH890ks=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Qa9aaPsXO368pcmYZx_YpQ-1; Tue, 24 Sep 2024 23:31:09 -0400
X-MC-Unique: Qa9aaPsXO368pcmYZx_YpQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2daf8920c13so502683a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 20:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235068; x=1727839868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
        b=Kif4v3FaTTiPiwpezorbCjQVevlDa4Aegx6jlYQymTM28hcLlV9ahcl0Pln2/FJ8d8
         iRzzD7Ba3V9AT16n6W1BcnQ192JjCY2LHmeTk95zZz21hMssRxcTicYuhudDh/IPz1+o
         yzSql71veYlrTp5zB0Fjkct9NIn2XTGK8bl5yOLGDGj5lnAfGpUvojFuH0jYoFY1iHzG
         ekbc1ui4dKYOjWF91ruM2rz/Ehm+GP62j+aXoqwHMhW19OvX5qwVa84GtiscoK4TxbJB
         xLc6bbKLIf6u+hSDGpZuIr0cjVcMT1Dvzy1QsSCX79EZ+BOBVLK+57Aev9NVYvD4ZBaQ
         z9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCX4hJQ6TaAhPyAN9/W0RwAYZhYlhvRKHa5T8qDKoKz1thwfruU1H6l4FvClthvpPc3HdBJG+E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdj3sAwAiAu4Z56dnQkRjKh4Lza+movPX5B0s8jwhwrjmTntkb
	cyDXw3yfPBF+8opi/7o7sOYyPQDESr6ASYJ6wivNK8LaAscfVAwyyFT+TgY0T8fCwU8ekNI4YgJ
	b1lC2S9dYlp0+y4gmXJ32DHtQHzPb1tHxKlgjNTyZZBKd4nslVnXFDdI7jhzWgiEtxiDWapdTtp
	jMHvdDcyvxoswdz9jq9kLq5rcHkgBB
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2e06ac390c5mr2020779a91.14.1727235068208;
        Tue, 24 Sep 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSXnVXH4KJFogFRlAqrxz0oHdsU+wQjcpSOWPpZkunKpdZpa8uVOFkj6NCDsQxAw+PRNHCHqUsGcOkqjm3ok=
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2e06ac390c5mr2020746a91.14.1727235067738; Tue, 24 Sep 2024
 20:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:56 +0800
Message-ID: <CACGkMEvKPXCPi6=1938J-k8JNA+hHqzRSt1gPQtqBvSfcgGZeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
>
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

If we decide to go this way, we need to make it reusable for macvtap as wel=
l.

Thanks


