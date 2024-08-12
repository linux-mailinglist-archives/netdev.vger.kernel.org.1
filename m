Return-Path: <netdev+bounces-117580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62494E660
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE711C21434
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4814B952;
	Mon, 12 Aug 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMmyvCsY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836E3715E
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442757; cv=none; b=ugmw6+EVk9JkAXaDUtTnynbwD5lfTcZBf1PdEWhrE8wPgkthFv8nAXGQGwh/ti193whC/9GoejN9dlQfqn+7KA+0KASSsUDPpodQlkkppGcXSfhYTwIiUIfmvPebruyTalf6p527p3+O+N9SRF1OK99DRo0yMy5VTfQN2p4bpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442757; c=relaxed/simple;
	bh=Dm/92/bGvdHP5SQ80XUnnaP7TEoYqwtKdS6w2k2Gz4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6dg4oXjAJW5Bl34/VACFecn40kd2UAp8tp0r6Ycu9gpD5aM2On//umvm2jN3EkFW1ov+6qklfgeCAtEsoKE8hPwpkc+kCRZe1D3qpju7D+K4l7pb0W97/HByrteLVFdQVUYO/e8UMReTXQywXrwhXQDNAYubYsay9UtlQIaPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMmyvCsY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723442754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA4BH06bb7VMDIbOMqT+kOmvZ/O4l65OvWNFedwV4Kk=;
	b=BMmyvCsYYg/N2Msl7k+banZAEmA0I8SHEp145dooPaxVLhKnTRDm21rSYgEReFZ66ir7sX
	+eFqzTuPk/+idwoMUlyISvJ7fcVKcmoyQTr17Sifp+ymh6IH2h/zSa08zSSSlzEOywZ6rL
	QG1FrEr9w0EpQV4vxaUyVPdr3CBBATg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-epRnnTxnNviUhOLqL3CGww-1; Mon, 12 Aug 2024 02:05:52 -0400
X-MC-Unique: epRnnTxnNviUhOLqL3CGww-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb600e1169so4250138a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 23:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442751; x=1724047551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA4BH06bb7VMDIbOMqT+kOmvZ/O4l65OvWNFedwV4Kk=;
        b=a6CwINQOcpC1sli1KvL4NiKRcmbv3cjBbgk3eOmGbUa9DlLt+NqPoIjcSuAshIw97u
         WQD4b+lKe5u2o/PpR+Ja0QkW0tiNHd/9b8q25VH7ZJTDt9+QLGTIewckKCoWHvrwWkFW
         HgluiuLlollM+ITGGWOlzMlUurRzGlNuCQb6owssCUr+IJcZgQ1ndLnsslYWFMBQ3OjR
         tA5c/ldaA5VEO47DqIgyPRk/r/88/cqGu+WuPKxJMSQL8CwD+37GpM8JpvX6kCeasw+R
         HR/q+2XUR9ji4E6nkGLq+meJAlMBmCmvlAE3VAkRC512nJgqfyXiQ6VnKF2M/2rkT3GH
         B/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVyakb0sLMHvZuvR+fQvLb8er9Lt54Yu8nSKQY7+eJ390sdEe9yP4E+AzWL1XFoRLDJU13QM59KazwpFQ7MiREGNMaoSiA
X-Gm-Message-State: AOJu0YxJh7vVsSTMGLe9vBdCswOZo8XEeI0INfQjnW4aFk1B31sGO6wT
	4ZT3j3ugH/l87bpSjRCuHIMIkCUN8xMqcPfcGbVcIMBgowufq+GJ+ygGbWctEesk+2XvcvrRclI
	3TzbnA/I1CNJc8MQzUnttL6aDNNr1jOno2HPNvtrnM/IKdRB1qhY+ZhOofR5fDLzcfdYJ0u3L9P
	VbT9V29z1fB2br7u3ufKnLS1bDQRGf
X-Received: by 2002:a17:90a:e7ca:b0:2cc:f538:7cf0 with SMTP id 98e67ed59e1d1-2d1e7fa3ee1mr6621446a91.4.1723442751221;
        Sun, 11 Aug 2024 23:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPchhMOprMgdkVva/H94XFQJSN4hrwiz5xzEmRL+mAgQxBDibh8AJMSeiipVWXNAeVB9xnLnBIBB/EeLveqQg=
X-Received: by 2002:a17:90a:e7ca:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2d1e7fa3ee1mr6621423a91.4.1723442750662; Sun, 11 Aug 2024
 23:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info> <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
In-Reply-To: <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:05:39 +0800
Message-ID: <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> ayaka wrote:
> >
> > Sent from my iPad
>
> Try to avoid ^^^
>

[...]

> > 2. Does such a hash operation happen to every packet passing through?
>
> For packets with a local socket, the computation is cached in the
> socket.
>
> For these tunnel packets, see tun_automq_select_queue. Specifically,
> the call to __skb_get_hash_symmetric.
>
> I'm actually not entirely sure why tun has this, rather than defer
> to netdev_pick_tx, which call skb_tx_hash.

Not sure I get the question, but it needs to use a consistent hash to
match the flows stored before.

>
> > 3. Is rxhash based on the flow tracking record in the tun driver?
> > Those CPU overhead may demolish the benefit of the multiple queues and =
filters in the kernel solution.
>
> Keyword is "may". Avoid premature optimization in favor of data.
>
> > Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /24 su=
bnet, if everyone opened 16 websites, are we run out of memory before some =
entries expired?
> >
> > I want to  seek there is a modern way to implement VPN in Linux after s=
o many features has been introduced to Linux. So far, I don=E2=80=99t find =
a proper way to make any advantage here than other platforms.

I think I need to understand how we could define "modern" here.

Btw, I vaguely remember there are some new vpn projects that try to
use vhost-net to accelerate.

E.g https://gitlab.com/openconnect/openconnect

Thanks


