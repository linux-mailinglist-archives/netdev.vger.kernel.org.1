Return-Path: <netdev+bounces-137816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C419A9EA3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6F9B241A3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F443186E43;
	Tue, 22 Oct 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwqyyogQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984112D75C
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589835; cv=none; b=ihyuacKoWniF+/cgOn13Cp9vM9Rchl0HDEGSDZyeVYBb7UjW6Nl7zdvl3IJ8Z41qHLBVVYj7OGPQAHwB4wdeqsPacPNTN7qKY6I98OQ+h9gSsMZ/3j0CtzFGx4t8vKSWFfaTzRG3WjM1spbc4Q+JOhVex/6OBqXGz3F06PZFTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589835; c=relaxed/simple;
	bh=gmg6Hll2n8lVXWSgQOtDgKvXuCqm8xmSTbTzUh8cbMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ/5SnAMpVn8mmglVTpv6uKOQco2/XoPc8K0yMU0xN3OMk9X6kcCzKT+ks3OQmKQ6/pgJlwYFuZ8a4IF8RcGhB7EVDhAocVdDa1PgT6ipXJbXm9PDfMMO5yl0Kqmn8w53WIR9wG98dW33JjvBnawXSaHVzOwh3Iro83+gHfWU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwqyyogQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729589832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pB/b7s5i5wAAKinrSsA2emfYkpQpPUZUCI5/VTA0GYY=;
	b=IwqyyogQkhUuNlE31f22sVjJeLzc6AJBWXkvlFCSl/Y4BGmKcvI0AN9Ou3PhwyqW8xuRSk
	8dntoqNyODspt0TQcAYiGY55b5VqOqQmicc8EXRSXayfXNoCSbVJ7mjaYyYoWvT7BDzIu1
	6n1X5J3XLue1go0Wx5QdiROZVJpfSxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ePWnp-sVMSqgm2Kt_BcvAQ-1; Tue, 22 Oct 2024 05:37:10 -0400
X-MC-Unique: ePWnp-sVMSqgm2Kt_BcvAQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso3198607f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589829; x=1730194629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB/b7s5i5wAAKinrSsA2emfYkpQpPUZUCI5/VTA0GYY=;
        b=FdwGnlJI/o2MHWt6tYMpwLmc7FLAvr50/lbOZidrHtTMde3v1W+phKS1ydcVvf/Bm9
         AWIY0KKeJ4HO7FqLyvLq6ksnGZ6hquEoiIScEg2qAqB1EL6i9U/8Psua9DOUhrU5y0Pw
         aROi34iuSVfP1OgGhefg+eabJ35wdbEuM7TkxFaFdFKflFRluHNAsy6It3MyniStsJvg
         z57SGmonpieHGKyJU7JrqqPBRSzvn6EDer89Nh0YyUy7oIiM+xIuqSdn65SU+rxeQG7K
         dfyQGMH5qgQ7PEsZriZ0VUJ8t2Sehs78jROvbIzEhbK5w2bRUnkNaeTSSNXhEckCSUR/
         /8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVu54bWriMT7nmFAiJHQxbbWwtr25ScnsMcGCZM1voKgihPT2ya6zE6FCz3Ca0cMa8E5i0ZdJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3S6T+9OH96UDDKdcifXPjEud5MeGSrs5WSyaEGEudBC7/Aro
	iU4cuXs7qhsHZKGbur0dBaZpY+Ks2ORS3wNCKuI6+9yQNqsXl3KHUivC3quPIv0imIpmd9ucuDN
	UokVvcTdqDtKG5E0oD31hVRINpYQ0MZI6zkNp9jiXlVKJjooOQI3cKQ==
X-Received: by 2002:adf:a34e:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-37eb4896bcemr8757050f8f.35.1729589829361;
        Tue, 22 Oct 2024 02:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIHqnfu938gdAY0h3QmakAjtBGWP4PnYRliinr483YmlhYWXPL5NDovyVXnQ2JnjB4kE4lg==
X-Received: by 2002:adf:a34e:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-37eb4896bcemr8757027f8f.35.1729589828980;
        Tue, 22 Oct 2024 02:37:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcc8sm6181269f8f.107.2024.10.22.02.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:37:08 -0700 (PDT)
Message-ID: <5cfc763a-2d9a-4d87-8728-19db3f8e096d@redhat.com>
Date: Tue, 22 Oct 2024 11:37:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/12] selftests: ncdevmem: Unify error
 handling
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 Mina Almasry <almasrymina@google.com>
References: <20241016203422.1071021-1-sdf@fomichev.me>
 <20241016203422.1071021-4-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016203422.1071021-4-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 22:34, Stanislav Fomichev wrote:
> There is a bunch of places where error() calls look out of place.
> Use the same error(1, errno, ...) pattern everywhere.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> index 9b3ca6398a9d..57437c34fdd2 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -340,32 +340,32 @@ int do_server(struct memory_buffer *mem)
>  
>  	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
>  	if (socket < 0)
> -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);

The above statements should probably be:

	if (ret < 0)
		error(1, errno, ...

>  
>  	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
>  	if (socket < 0)

The above statements should probably be:

	if (socket_fd < 0)

AFAICS 'socket' here is the syscall function pointer. I found it strange
the compiler does not warn?!?

Thanks,

Paolo


