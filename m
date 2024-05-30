Return-Path: <netdev+bounces-99267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0F8D4407
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC41F22F75
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631256475;
	Thu, 30 May 2024 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad+vBcOn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983854FAD
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039430; cv=none; b=q6xJroklbwP1/Z0/NgTo1WwUVVD9Oa7AOQJZ4yH9XA4dQrzTphK9vgws0uM7wabRsGFI8EsASubPy9kT3n1jJ/+zmmR3cLdifRJNHUFCM3Na+RpmMS/mgOZs7R4np+PogBFASNEvez/wIRmbUKVO7Qt3/lk5sZfRDsg+UUrmNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039430; c=relaxed/simple;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt2S3qZ65t+geaSWMtiGjRvUFFBXDxLSBDN98CA4caZmrJuKKjCZhUzny1D+4nWvJzhStkOQ4Xqe3y62S7u1ml/5gQ2LMtCIOMVo5tdjG+GUawcrE4160iIPmqATX1TA7whyJEkwWl9qnyx3gE24nCtdSiSxewndmz62SOEDTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad+vBcOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	b=ad+vBcOnA174Y78PxCcT1YnWKVLdRvGwBvbVAmSUhsNmJ0nsbviVcoc8J6rIM5KWlLffty
	WxM0/WY0giT1Nss6o4nLi+RSQ4XlB5wvKi7ZVSGuU2+1D/j2Arim7tK/CNkfm9r49r+DmP
	f3r8QQLJhhZbsf9PIKHciWKvYl+0Tz8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-KU_CfmqpMbi1MrhacW6lPw-1; Wed, 29 May 2024 23:23:46 -0400
X-MC-Unique: KU_CfmqpMbi1MrhacW6lPw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1a23d1382so411312a91.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039425; x=1717644225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
        b=cqhac1pnDoAv0vgiHUliwvab9+BEY+fJwZadRshqdrFfw+oMtMCaH8/r8iUeoSLNp/
         kFsD5uyJobguUlpDAC1eKu0sbjCCiepM+PIK7IykxCqczpEfLDK61LFLnGoAMWfkEE+w
         ITZqDex3k+xmO0qKBRdO9RUPvSyja28sF21ZyUnwbFYxGwzhXtSWV5ACEDoF5SJLznTV
         HSG/WSgaD3UQ9aL6wJww90pjx3u5CBToNL3y2oSXI/AZH2finwrS6e5QnpdvG5j5WSZn
         md99NVCmshCUj8hP/XhRzooIjqCQM82vKi9bVvurgMDTP9ggzhyZFmBXCZDXg33r2r4N
         6kgQ==
X-Gm-Message-State: AOJu0Yz+SWFWueJBvU0AoivCX3Isn2I4Y+W3H4XtEBuUuRvdWoM4kX60
	6fJGGko+rKbfsrw03B89fxE20lNjpGSjg40Ys4uvCyvSj9vlh91svdOFCSFeaZzkxs20Ybe/x6e
	n12IOjJoBq6IzV59sJ6BjtH8OZkDKHPoY5klNol+jtg+Od9Jl+R82HU7d7Wl3yAkc6e3Vm/mgg2
	3N6CQhmGol9S5ZpnbrKyq6TwxNFzD5
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id 98e67ed59e1d1-2c1aabe9d88mr1616334a91.0.1717039425070;
        Wed, 29 May 2024 20:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY/pYUq0iajDlnpjMsBnh48kBWVYBIbXgSvQ/hOOE6EMpOmk07gTWNTuhtCbRp58KyXGCVbg/V7IP9Yi+YZlE=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id
 98e67ed59e1d1-2c1aabe9d88mr1616307a91.0.1717039424645; Wed, 29 May 2024
 20:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:23:33 +0800
Message-ID: <CACGkMEvjaY1B6tG0M6HjLDPNZkFsvdgXNA-O4GrjyXomQiBmEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] virtio_net: add prefix virtnet to all struct
 inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> We move some structures to the header file, but these structures do not
> prefixed with virtnet. This patch adds virtnet for these.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


