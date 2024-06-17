Return-Path: <netdev+bounces-103903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6768890A21A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154471F25290
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012961607BB;
	Mon, 17 Jun 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG7hTXmV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596E12FF6A
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589167; cv=none; b=s1OqejHZclF8c8PxxVDftZVTtKAnqY0VxtIhqObhdWjY+Wg1KiNLcOG6e6DIAUYm486OehD7FK6VIIuh0f2D9VgV69EBMWW1HS8o4q/PE1/5+RRR6o6F/6Uw+KLx0ZzdgcxUs33efkwJTaepqB+BQhZiQb0moMa24xWKbCPdrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589167; c=relaxed/simple;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HD5lwdIvyzAVMfM/x4VQoGCgBgQDmJG3z5IU6MNOlpZ1AEXMkwYPPSw63JcWdBAhdzxwJDlEESi5IIjP9jhzOkd+e7BqD8p12DaYi2Oqdx2Y+rffmUVau90lsui+e/UCOzW4QdO+LBgj89S7D+PseqapmGhWo3cluGSxCrpxcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG7hTXmV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	b=JG7hTXmV3s0xf+D/2sfXCpw3XmY6Ugp/wcgpzfeEotPn0NzFkoo5+X5Q9qnSrCHTrQTlHY
	9XgESgIbzcTR+OGs5Oy4g018xq4AfoYcC629pzSv/YXKBjYHX3MFdvSkFesbuEhMPY0Ee3
	Unqq1elvb0uk/AVaTQaOq/MDtEd+nPU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-EYONG38yPMSWNrB62WbT2w-1; Sun, 16 Jun 2024 21:52:44 -0400
X-MC-Unique: EYONG38yPMSWNrB62WbT2w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2d2534c52so4250059a91.3
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589163; x=1719193963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
        b=H5Tkz3l/BPA16J56OVQcD3zjeV14aC1pRxONG8lp9NHIouEJiJ+9qVRAIQKElr4IOO
         KtQJLPUfsQo1jlRIgST7grLDzAyBtrz4dvLBlxU20mmYUoYReBCWgbaHmFC/C3V7CoUP
         y/r17PRwiocZIjSuvWk+rNg294uxIyDh2+2kn2Al0QUQEd2d5our+xWYFMq/5h6AFy6e
         A3pRD4rJxEy8gTElcAIF4lfS8hng86dMpYtyg7lt2t6Zkcni3TYt3aJLBgFgRLL6LW7x
         tNeqKzLZpN2mPJWl9b0EK8NOYAUblyAn07bzgXodeceWfMtwdoxOsXIYDPCj0q+mGeos
         b00Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzp6gJDXkytfpDjqjjFUvPNT8J1ak6hj0Znv0tT/a1979cQEayd5X1XTk6zUm//gvGtQMMnBcGAqyi4OGY8N0Qzc9erXSp
X-Gm-Message-State: AOJu0YyDHxvFfgofHqxLeUmSQp9dE+YnISxeDGgjNmc7XZs5YTaD56XT
	HR7gRXb4lpVg3ZTT4lF064m8n0XXsnP9z1uUV9sQ3r1PExSTTZfOIlrwUPRBL0okSlRM5h1VCrC
	Dq+ylc479GhFifIy083pZuq7XaZSYQEQomxjFXcoB8+Hu/8ZgJTShqj1zBrw5Wg+BqSuNrubO3/
	JxByT+Yb/kLWxIi9EHiR2mdApzctYW
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id 98e67ed59e1d1-2c4dba4cf41mr9455807a91.36.1718589163039;
        Sun, 16 Jun 2024 18:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+QQNT5453eJc8Q6wrY2MwQONVCUdTNKrjoTG9l0wExtAxoW4PcawA6CbvZ6/VnsBDwc00gN9K/+tJsC+cH0k=
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id
 98e67ed59e1d1-2c4dba4cf41mr9455799a91.36.1718589162769; Sun, 16 Jun 2024
 18:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
In-Reply-To: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:52:31 +0800
Message-ID: <CACGkMEvdL4ieDDbpwy+MGBbHjia5UbbJQfUidh2btG9vPcvWpg@mail.gmail.com>
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:57=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> Fix the allmodconfig 'make w=3D1' issue:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>


