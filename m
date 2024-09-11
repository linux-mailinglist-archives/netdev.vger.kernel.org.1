Return-Path: <netdev+bounces-127217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D0974924
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72404B239E0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5143AB4;
	Wed, 11 Sep 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8WRrZ1U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67737171
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029194; cv=none; b=oQp1aE3OYttVXFFSXqjbj+DCjuXlq6IEUgmi+Q2Agj7GbvE13SzG1xb3IL7Lo+sBx00JSWoLlZg59G3L9jZ8r8Bv/mNaC/VreG2spj9eJa8OEO5nsmvIT2IUm6iyFhY8mnYbh5ENfc/zUugqOUQGQ0dZxWiID2dlnXYJ+ANAGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029194; c=relaxed/simple;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku4NtVUP1Yk8P0N9uU1BpISW1uvLsaGF8EU+SAnZ2GMijG9M2zirgzYxuKAgjDYrnTbPlIufWR00m3d+byhxM2VOPNgZriNiYA0eOWWM8/gVAIptySKUOIGeTs+/ir5DoQySHrC5qwD39KXUTMljiiB/BuMqCYaWhEiSl0FqXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8WRrZ1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	b=N8WRrZ1Ul7NBqGMo4TnXJ/ObIoArT+SN02wj1VvP9ikvTE/uuVN6tie7RXbOj9liGFZwV3
	0YHFRSeVVC4kg4gQU5zn6wg611uRDSuJs/Fjr7BUeulnZajfd/+zmpCnbrWkVsER8oZLRR
	pwuFIRBVxDFQ155UotuEmf/zz1i56ok=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-ACV_kySEN6Wo98-FtQzMUA-1; Wed, 11 Sep 2024 00:33:07 -0400
X-MC-Unique: ACV_kySEN6Wo98-FtQzMUA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d889fc26e7so6438947a91.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029186; x=1726633986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
        b=OAapP+UoNJLYGPGgROd++4RYgprKnNkOGH1nC7Tf85kiXM683PjpoIvn35ja1aj1Rg
         WK5Ublh3Skya5+g//wYIcsawIpm2E6exLG4GMHMCEc/BiosV3mWE4b5tTYFSkevjaUJR
         FKkZH7QetHAOSu+AsPENZSZc7LD/yrIFyo5+Hi3wn4mNyGlgZWGlEtdZFIWSRZ3ni7Ej
         VoicGOozqudhfaIPhXayifCdEAt/DCbL9LmhRobC3t4PpkSNbQPkGGmlZQxYwIkgRNT5
         Woy9+N0ytXs3Sv4iEuQ6fzt1DODZVJirVXEYxiuAmfgbI57NuM4BnQIZg5thcRBxqpWY
         5tsQ==
X-Gm-Message-State: AOJu0YzoYpXkG8DxFjYqStYPnhHo72TaUtRKkL/tU5L32CReQMuHiD9e
	Fo+J3R6/IvNky6AuyLdm5YMdAYpe0yG9sNuW2JLXYG93qBxE9+UwzdXjfV5FTYizEcDhWWKhPw4
	CcS63RxQuN6t9d/Y3CmXjo1d/WjUUkUuhfv0FN2CPHSoiKEGs0kRyJy5l31d5Zx3GwFUt78MCbw
	Le8p61B2LcBJQqGb0xn7hfX8M+tLQK
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id 98e67ed59e1d1-2dad517f7afmr15824630a91.29.1726029186407;
        Tue, 10 Sep 2024 21:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3GVsn/LMGACZj1UXWZbjl/jqpQUo45nERNKW3tBta8SrZSl+483DwLY/qxFy+Bc3SjR46sSWGjFODet9XREc=
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id
 98e67ed59e1d1-2dad517f7afmr15824604a91.29.1726029186020; Tue, 10 Sep 2024
 21:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:32:54 +0800
Message-ID: <CACGkMEvvKsypiOmdhWKjNhXJ9fS5SVYQFzK=KtTr1DdyMOv8mw@mail.gmail.com>
Subject: Re: [PATCH net-next 11/13] virtio_net: xsk: tx: handle the
 transmitted xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> buffer) by the last bits of the pointer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I suggest squashing this into the previous patch which looks more
logical and complete.

Thanks


