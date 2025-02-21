Return-Path: <netdev+bounces-168343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF45A3E9BA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D18419C09DE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CB38F9C;
	Fri, 21 Feb 2025 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/bHJm7H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD786355
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100513; cv=none; b=B2WhcWBmMd8TxDUtFLoa0/Gc3oBq1b8GbbbaDjmZ7ZON55TJrNCmZs+j9GZEJNTjyIWXwGXZWU1ThZakB4rf+AZe0wj+Pgq+lLc+fVFvLO/+RWFd0kbzFYFWls7DuMkDKdVLqbpkIPrDONl4WUUZWvB+ND9nd5jLHon1dzG+ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100513; c=relaxed/simple;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN6+beNP7DdBIeImGXcIA6/R5pBYAvbUcR5dsC6ow+bthvcnJGxJu1vzTVh0aM7s16+/oRGW1AXaGOlxhsQamAeS9Zrl1yEqWJwxZ/8FPvwE9ymp+sjwxrFhNHzJwedioIXPvKzYVDFreVfWK15A4rjHD6Hn2v+wCulGiBiwhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/bHJm7H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	b=V/bHJm7HHy849dnbGLvJyMOjN+PYg876C2iBic+Znf3c+MNBD/1XIGCO45SYbPXqZ8Rv60
	ql6ZhVXlPJvivicbIRx5bvhnmbi4VhrVXkKGe2fM9+bVZpyCw2x/IC6SZqshiFCkGkme3j
	ZOyORzpUCIAbXr2dXrPp98m4/toJPkw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-LvLcElZhMlC-_tZQ9wzfuA-1; Thu, 20 Feb 2025 20:15:09 -0500
X-MC-Unique: LvLcElZhMlC-_tZQ9wzfuA-1
X-Mimecast-MFC-AGG-ID: LvLcElZhMlC-_tZQ9wzfuA_1740100508
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220c86e46ebso28007965ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100508; x=1740705308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
        b=U5bDRmsW0wpFIq7gr+qMNzy7ccTRAkr+oyx2TaJYVNwnUks6vM5joQftSFJc1XsRje
         Iu9TyGERMc60H0770POo+foocd6SKTydIcUsLElqDhrEVo5joxLP9qn9Af8pT5CplwbA
         nBk9U1UF4ik23ffg4Gu5J7pVxgqqgKaIXmfhCEoTVcX/IQGd5TMRuISNXDmhLXFv7o6w
         z3AsSW6vLAQFzXgLUmhozjHFhD+cUku01C7O4lnETOI/1Hwk59FSNa9sdwQ3NntHIsqj
         97ZHf96o3L47gf+qiTG1x5gGPWw3afWX0VFqbWGkY9Qjarw/SdJRUBqeTfVM8VPsIJpl
         VqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/SkuxKGq3i/MB+VQc2aXlItCphLeQ8t+aZ2Rm6YZfHppTlr94Qz5zujknj3i4imzDMf/C3Po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oaXeGvH6aUzVw5pfoDSomrfxzSDiTUnJmJp890W4bm+5IrcP
	3klqIIg8zf/IYns+Nf7GCEsi5MxWYkHlN3b2+Zb5G8gdxDCUU1qjJr/nkJOi++Cg4t/NV/oIdvA
	VKbk1rFmrejnL+BZRxKL5HVnOZXk9drFGQ9MZt9JUskKdhlZQnLA680qACXJSGi2FrrPbe4W+G3
	uP1l+9ZEORVh7P7dE3pdAfk3ol0/sn
X-Gm-Gg: ASbGncvA5FW5Aho2018cuCSixCU/x5kTCW7TYAJBGNdeudv17xMvZp/M+YzhhBvsVhn
	tTg8C+FeV6gcx5WHddSdKmGHA9WU+zKZPqZFcd9ZU3ZaYpq0hHG43NYp0IlsnBTg=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id d9443c01a7336-221a0ec944cmr13551805ad.9.1740100508432;
        Thu, 20 Feb 2025 17:15:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNUoAtdLLCDrmQ4E0KhxP1/v8E8OjE3hwAErurd7Thltd/lsB3alr0YyGDAyw/Vnr52MolQRVxcb5jecipEJY=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-221a0ec944cmr13551285ad.9.1740100507900; Thu, 20 Feb 2025
 17:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
 <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com> <20250220034042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220034042-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:14:56 +0800
X-Gm-Features: AWEUYZk12eKYMoRdAhOr_VqKFdK71rl0l2JCQtxsCVicbAIDmOs5Fp4sSGUmfl4
Message-ID: <CACGkMEtN1K7jRVmZwxah1vET=p5k_Nd0cpov=R0B8sP=bjC-sA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Feb 20, 2025 at 08:58:38AM +0100, Paolo Abeni wrote:
> > Hi,
> >
> > On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> > > tun simply advances iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This will become
> > > especially problematic when tun starts to allow enabling the hash
> > > reporting feature; even if the feature is enabled, the packet may lac=
k a
> > > hash value and may contain a hole in the virtio header because the
> > > packet arrived before the feature gets enabled or does not contain th=
e
> > > header fields to be hashed. If the hole is not filled with zero, it i=
s
> > > impossible to tell if the packet lacks a hash value.
> >
> > Should virtio starting sending packets only after feature negotiation?
> > In other words, can the above happen without another bug somewhere else=
?
>
>
> Not if this is connected with a guest with the standard virtio driver, no=
.
> The issue is that tun has no concept of feature negotiation,
> and we don't know who uses the vnet header feature, or why.
>
> > I guess the following question is mostly for Jason and Michael: could b=
e
> > possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
> > to explicitly signal the hash fields presence? i.e. making the actual
> > virtio_net_hdr size 'dynamic'.
>
> But it is dynamic - that is why we have TUNSETVNETHDRSZ.

Yes, tun currently only recognizes a subset of the whole virtio-net header.

Thanks


