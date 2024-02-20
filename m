Return-Path: <netdev+bounces-73296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2585BCA9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAB7282725
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036CF69DE4;
	Tue, 20 Feb 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk6a3Hhf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C236A03C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433781; cv=none; b=LRnASrz8rIdAhAWgAV8HkxFUgAMKqrxnDSi3eRZaBvV2OEj47FspPaD3ouI08sP0V8kJG87BdTUJjDkqaQvRRMFq24NZHMLO8lxOgH5U7ojRZ4Dc0qdxP2317ILEmeWBd8/qay0tICR9CHFTA6Npz79+sBKdPYZZ8RsldWjuIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433781; c=relaxed/simple;
	bh=vQLjhwBErnyfhRMtC87Kz+aXIbqsiKbLaMP8DDIrKUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8CJ6np4Gyl0ANYV6pmfIP8qrRmUvpB3R89hVevu1kiSgOkefvNiX4XBai6EsvMarazH/EWqgTfSl2WsnImIm5zgnqXAj1pn1u0CQpx53Ch6CvwIYBquPUsgyt3ZgW6mt9Y8PAh+UGy5ARtXc3WX8OeKJxjosDdDgra+pRiYifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bk6a3Hhf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708433778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+GNV2a+I+7Wxr9EdF+siLO2S2qArmZP4/l4m5mqTQMQ=;
	b=bk6a3HhfB8RLKPqXkQnU8w8b14O2XcZqo8gXDnKhQhCiH+BjzPoD/vQDN17sCvrXZlwO62
	rdSlO5Z+JrktFRAM4ahuczXHcv/pyGfOAuXb9fyDg4KCGpq0s3eGuLcQhmwuky2zSneptG
	vwWW8hI/+f7drBrXy19XHKgVEKYcN00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-uvUoIOAyPtaGvZCjcpta8w-1; Tue, 20 Feb 2024 07:56:17 -0500
X-MC-Unique: uvUoIOAyPtaGvZCjcpta8w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411e53af2adso8716965e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 04:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708433776; x=1709038576;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GNV2a+I+7Wxr9EdF+siLO2S2qArmZP4/l4m5mqTQMQ=;
        b=UzGO8UPib3RRAJBA0XBaz5S93W32E7qvOUNdzanANI8Oc77LZl7felAPGvStMM3U/f
         FLZFv1vl2ZV48EDJA01wZeOI0WE6u82+fxu8ybjL6+mLkveATH0fxT7Z4faZF1F+wjxF
         NJEyhDYlESm0hLieydRidk7aglfhojRQ9f9go0H1GttY646jeuSgPxDpiJ6K/9stzyn9
         F6viLH50t0vip3zrpLQpK4PcRxCjAxcWbVIbLu61XYhoIYqXjyIz6r09d1Rt1qPK0fkK
         VAyqwyy2CocWqD2egYS5lrCcIDAtEa8jO+JmA7CyVyNr4EpvZJit1sW8mfRVDL+aMIib
         52tw==
X-Forwarded-Encrypted: i=1; AJvYcCXcJfb6bfLQwibGZh86c5Xoegj2fdx8MhLLhGW2EBoNwVy152192/GGU/CLuv7ytpHbmmp6W7NezJqVI+sOj3gufcXAWSKv
X-Gm-Message-State: AOJu0YxZ3MqxIOof+osHbBOo2T7brA8JpJE6QONHtQeARsgtAhI9vkGP
	7gdpsFOIL35nZMKUdRZD+Y7KoevaCtAK8oaTiUx5CxL+MnhRZ1MVXcdWidHQl5J7NS5Cb6u+vrr
	ylxUST/bA8Yj2O9jbtCbH1MOWUkqBUaoaVS2ZdAVq+RC2MsctlNMHOw==
X-Received: by 2002:a05:6000:1f90:b0:33d:278e:2e17 with SMTP id bw16-20020a0560001f9000b0033d278e2e17mr7456445wrb.3.1708433776171;
        Tue, 20 Feb 2024 04:56:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3tu0aPKwaMRHy1WnvulT2Hdz9RJfDe4MJj6OyAww/2GwTnljPI3b9mCBniA6BithyZphvig==
X-Received: by 2002:a05:6000:1f90:b0:33d:278e:2e17 with SMTP id bw16-20020a0560001f9000b0033d278e2e17mr7456429wrb.3.1708433775819;
        Tue, 20 Feb 2024 04:56:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056000079300b0033d3d9447e3sm8207606wrb.83.2024.02.20.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:56:15 -0800 (PST)
Message-ID: <98016c09e181336c477bf07d5e58b98bd644b075.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 09/14] af_unix: Skip GC if no cycle exists.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 20 Feb 2024 13:56:13 +0100
In-Reply-To: <20240216210556.65913-10-kuniyu@amazon.com>
References: <20240216210556.65913-1-kuniyu@amazon.com>
	 <20240216210556.65913-10-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 13:05 -0800, Kuniyuki Iwashima wrote:
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index b3ba5e949d62..59ec8d7880ce 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,6 +36,7 @@ struct unix_vertex {
>  	struct list_head entry;
>  	struct list_head scc_entry;
>  	unsigned long out_degree;
> +	unsigned long self_degree;
>  	unsigned long index;
>  	unsigned long lowlink;
>  };

The series increases considerably struct unix_sock size. Have you
considered dynamically allocating unix_vertex only when using
SCM_RIGTHS?

Thanks,

Paolo


