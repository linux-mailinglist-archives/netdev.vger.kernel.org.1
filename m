Return-Path: <netdev+bounces-141862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA49BC90A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14DF1F23859
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289951CFED9;
	Tue,  5 Nov 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F88PUSWK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A21C233C
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798605; cv=none; b=ALus32nwSlBN84lgY+K57e31HbpHEdjt84kfOj2S/XBvWXix6XNIpuXOnsA4wxXmHFOawNfYkQWUahlTQj3RoqDQuWL3VLrQ3Wu1s/ps25FdB1vUODpYgXz+gP+cEtPyoMKPIqqklI66WLGIBBUaWAzOk9P3J6FVjN29va9XSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798605; c=relaxed/simple;
	bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbl0YTKAlf6CbIGiEScCKmP4ObXxqYlwZg3f1mOg9ieILhHCLlqwtUp5Ojv2mFO2Lpl66wmBinTaZHhK06HAVfeUnhfHj7JASeZryXgn4/4NvU84Y6cEYwYUc6ODUPxInWfP8MognUKGHoa27YF6qCJky2rCsf/UJupYXV0Ojbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F88PUSWK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730798602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
	b=F88PUSWKHl6vABFRNU5fN5sbiJUJZKB+MV27WK5Vck18WVzutj7xVaQyUWp/H2Zp5iS3ax
	bs5UawyAU04/jWegoYDbnqsnPo5C3GY18zNfuwdffkkFun81Tv2vnH9abEPv5Bfp6lUQUT
	938q6trH/hoQmNk72tMy8NLGMZp++js=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-zk1c9j9KOa2E2Jps7qzMQA-1; Tue, 05 Nov 2024 04:23:21 -0500
X-MC-Unique: zk1c9j9KOa2E2Jps7qzMQA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e3ce03a701so5080372a91.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798600; x=1731403400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
        b=DU/k+F6qqD8jAvICYfI+sLSkxRBtuQ/55mQIf9p8+tAZXkT//tQAdmBGW6ypmNrFnu
         qfiHNKoVQ/LSutn1F0MZ9/mE2ylW5TrtX4LsM9y4Ym+Db1uOmwel7fIYRfPWL4sspIyg
         5uQJSCLn+TvYwiR+L9oQ1M1rcAgNXFI6S+WJK0O0ZfnDOF05WsCZhel0ZCqbQW5CAmkn
         IJNJsbqO1Cp1jI/GsuOy5/thbmvGMbJLh6weLVctP0nIwZJ612DaoVzwnY//VIoFdYsl
         uwJwP5UidfO047dQg6W9IP5LRL2gY2F28ygpnNfOhXI/tmAg0Ch+jl2iW8obZO+DnwM9
         9mQg==
X-Gm-Message-State: AOJu0Ywb1u2fqganhsgajyNiBxmoEmOovyLuogXM4aGm/8Fc1sROo4dj
	blqkJfx9tGtYmLydlNV8azo/o6hK5VUBkEnApSqYd9ii/kzeBq1TxqSr51cfMiwqAF39LfwhWUe
	HfSmjzXmuxpePlxB2xhljDgoLTCVAGgY0uk/HMZKx5KU2fHI6OLUF73zQP42xxeli4s3p1KJvW6
	JRuInJCEt1d6/LHWbTa9NMkGd/MHVz
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id 98e67ed59e1d1-2e94c52a9c3mr23098578a91.37.1730798600314;
        Tue, 05 Nov 2024 01:23:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPtci1uxxNPh759PaVSGbZ7DqP895VpcRzq1C4wn1LN8wRlvHgQnWd4dh6rpTXmWqZ0UunppM8qq1LNUaG4hU=
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id
 98e67ed59e1d1-2e94c52a9c3mr23098547a91.37.1730798599879; Tue, 05 Nov 2024
 01:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241029084615.91049-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241029084615.91049-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:23:08 +0800
Message-ID: <CACGkMEsDHtT64Gi=BuB0OGoD8EJgpL9=Hb3+L4im_EUxNC-XqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/4] virtio_net: rx remove premapped failover code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, the premapped mode can be enabled unconditionally.
>
> So we can remove the failover code for merge and small mode.
>
> The virtnet_rq_xxx() helper would be only used if the mode is using pre
> mapping. A check is added to prevent misusing of these API.
>
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


