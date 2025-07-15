Return-Path: <netdev+bounces-207052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC4B05760
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C81C20B8C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4212D5439;
	Tue, 15 Jul 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdOW+Hk4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232F23A989
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573733; cv=none; b=j5Bi/tqh4TSlBfunhY5kWVMTD7XWAlemi6UGQj7XbfO+fueRy8bleeL2Kx9Wa2JFwNjPPWqsZIiFQnqh8ScVQcGt7BEs63farB6fz6l39N+uVzBosLSBc4tCMARAawqxSaQbqDg4U80HSNysqHUji7n3ZvvD2Q4kWzSosEgvwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573733; c=relaxed/simple;
	bh=/Esi2LSscF1WVQ+nHVOWsWxA9bkfWvoVCVYFUIPTLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8YCmO9xuXvJmTA77brfJGz3rQkP4JoxKdQ3JRyoSomOH1nqDN8dBzs2cByAl/byHgZ9BNnWHBWzRCW7sq0+z4mN/bzX+VxfcFX7YyekTolqGNMxn8dBUy93RAHl1Zqd3x/B7Tang29bfkFFduaZRpkTGxXT9NvOZpIsSAvYcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdOW+Hk4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
	b=XdOW+Hk4eClJR5CyPWH1jJv1dv89mR0CSxN+84Z5gZnJTSiyuRTCdKJNrX3E/lrd3mDRm3
	ja7Oj6gup3SI3obEQnUTDJ6+vnJTDju9oNj68qyFm5+3ZKdiapTSDuakuTj7WEuNeZSGAL
	4a8pZv0feMU/9UJUCsMI7Q+Jh983B70=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-vA0lT1QMOQ265ahS3k_Ufg-1; Tue, 15 Jul 2025 06:02:09 -0400
X-MC-Unique: vA0lT1QMOQ265ahS3k_Ufg-1
X-Mimecast-MFC-AGG-ID: vA0lT1QMOQ265ahS3k_Ufg_1752573728
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315b60c19d4so4708708a91.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573728; x=1753178528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
        b=ueUWTu6NznlGS5u9ZoQnRtz5vlvnoegYRAxaUlcjfkcEfnfu6j0w4JSMkxtgXd+gHK
         BLl8jGdKfSa8PHusojyIrGqG7fZ0JpIcRh4PZX7eZQsSXdAmwenOtBTHqdryWRjfHnSI
         Ij4WcYKP5HMl07Sm8ac4ZvQLiT4brsWmo1IYh06T7n+ZlyPxrYdOUfLKcWmFobzrPkj3
         ctJEFyhtHIs4GM5/5l9JYatu6a+Al85uvCG2iAJgRcZUI0DqX9zgA4JZp3ynRuWaBoM/
         LoBRTdgsx1GbKPVNoikXaV8fftCVeb4NCnwdKoXSzfSCI/jQhk5mETLyaWnLmsndGhCz
         hw6g==
X-Forwarded-Encrypted: i=1; AJvYcCUUfTLwIeSKDExBJ7yZh+QT8gj1GexcNZtTfAi4YDRYMwiS+QPM4WwCQJtPWS8ZqxzxVPoNBNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NrpjQ0rzN4wQKjzPL0W1h2FzFJwrN2rKgbivvLzh+6GNN0zp
	gcb8nMbxAZFd3H5qw22FmUSzyXP2866K8eyW4Y9SuBwvfS73YpfICO8Sa+TVpVXacodIRqyZLcg
	1KxnoMYWtXD25OEQneI9Keo2xO7Di9u6FqTFCkujJwAZzOWLFPHU5nswMQg==
X-Gm-Gg: ASbGncsZaQ/qh/byeI9I5vHyIYji44/if1EqILnHymkDc6a4VjVtIJrdk+wBWoE8Ceh
	jLk/4VL1odQVR+28zKkrpXq7UMU0Wr3BuFXb4hTRtpFMPAIJyYJIoflDPhBBW23gOUF1/jr1EUi
	xOdw7ay6o/jZJfOblY76w1etDoamsyZOE2j5Z0dwhdn2wRpCEWVzQYUi9hRM6LdLOi1oFHUUno5
	dm4ThjG/ZVP1zuAiH8v01PgwYzBg7V78N75TRuRJ9BUvmQ3D4BBoFQ+fT3zUdVaLoEwXSZwd7H0
	tyE4MlMRbILxnYaHg9YxPi0L98XSxHUALNwkjLNsDw==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556976a91.2.1752573728003;
        Tue, 15 Jul 2025 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF43KPk0Mv+KOem1eKuyhOhWAxYn+8QkkyVrOQLCDBIs5jSRYrwTAbV1ZjwkxKobKwqVaLB3w==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556922a91.2.1752573727386;
        Tue, 15 Jul 2025 03:02:07 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e958166sm11589778a91.5.2025.07.15.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:02:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:01:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <opdsodne4zsvgdkp4v3q2xggjzwjtk22j3knvpntlo63h6t767@jsuxmvgucatu>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-1-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:54PM +0100, Will Deacon wrote:
>Hi folks,
>
>Here is version three of the patches I previously posted here:
>
>  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>
>Changes since v2 include:
>
>  * Pass payload length as a parameter to virtio_vsock_skb_put()
>
>  * Reinstate VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE based on a 4KiB total
>    allocation size
>
>  * Split movement of bounds check into a separate patch
>
>Thanks again to Stefano for all the review feedback so far.

Thanks for the series!
I left just a small comment on a patch, the rest LGTM!

I run my test suite without any issue!

Thanks,
Stefano


