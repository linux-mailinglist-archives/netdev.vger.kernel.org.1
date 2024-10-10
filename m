Return-Path: <netdev+bounces-134111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FA99806F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E8E282FC2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B81CEEA4;
	Thu, 10 Oct 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hmr0Y5HN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869141CEE91
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548762; cv=none; b=lqTLF1aIlia7WOcNlupzD0pkUP93CgpVMGzlG2t/naR3rNHA0ASsbq6DirVc/1oaUFzpFIMd6rmUulut5i64MtxuXbviKQqJ0k/eN07o/M2g+Uu0swL7Xne30HJogg/O6iN4zpbFvUeXFVxBVORTEh6IQ+H1rWVR2J4zq7HOLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548762; c=relaxed/simple;
	bh=dqyQvgHvQL/aQd0lGWWhd3kBvQIxg+mwqM9znGxTZig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxc4mHyhFS2ILOrKEKbaKT8XEIrxLQ9NWk5oHFpkLRecVgtOdIjaRm9/ll3s62NRs3jaGwrH9xcuRIj6V97yIimztzMqxbBuDx1iGxM0ta33QASe0c6fm8g9OQsY52qN0Rjn9EsRSgTi2AK6U/8ownZ9kqDRFFQhp6pc0TqncYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hmr0Y5HN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728548759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1h1uJoRfos/O8AAaaZabotvNCrfCwdQaEKlDSIDITk=;
	b=Hmr0Y5HNX5MH7htzS90nfzViz2O9NvLVoBbWGEXqrMnecm3VfKdYJspYwpm+cwK1yXKZgM
	SfW/eiy+y8hCD/So2SgUSZyDZ4qLerzH5290C93sRrKMc/3lbJWzjWt4wZ0Oi7hY7AHoiJ
	zI2VlnIsEgppUNzEL025MIUm0rOo+pA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-0-SMpkc3N5CJnkV-bADtRw-1; Thu, 10 Oct 2024 04:25:56 -0400
X-MC-Unique: 0-SMpkc3N5CJnkV-bADtRw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d504759d0so66109f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548755; x=1729153555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1h1uJoRfos/O8AAaaZabotvNCrfCwdQaEKlDSIDITk=;
        b=iZllDTkxKcrKCEEYPHKdE+4Ij5tFrCxStC2Y8OYbN2GlosG+VcfExrb1LNbY9M0Q+c
         ij3sIXWv7APoHBhQISynw2k87QKzSOuikur9IelSyvAnjtFwbMK6YSEB4tbILFGmD254
         LvOLU9rG/pji2GfIW3c8PPz5wi1UwG6ouxyEH/fHczDzXpj0xIrRjt2DL5lsupqhFDZp
         bQPmHSN3jnGcQhrsjl0ZBEEksyDGYOtnuOfRRpyKX6jYaNvcFteYWr/mJdrs4Q4jjPGf
         S2qKqKtxrldFuTwj2vCIW/8BRYJ6yvX+7aUKut3EAUapvbdYeEb4ibhgWfY/kYzk+QEV
         7Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCV75twpaw8Vt1khTxrH4Qf/cWm6rVdBLjOiZqVvfRJbgxIt7phhplAcyDxEpmyrV5fx59C9Sug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfi4tcj7FLHf/ObEaCeztFSBIu768+9LguXK2J22r9JJLnNHH
	t1mTcZfbTiknbArtchbw0vEFbtus/1R0ganlIOGv0ib9JsrYEgO7TamdD56VL/T+GMt37gBFc3O
	OtwNaB1wQQMODHJx87vfsN+qzUJB1ZkoV6p64rS0KlJuFHkABJDUkUw==
X-Received: by 2002:a5d:4109:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37d3ab0118amr4315412f8f.49.1728548754917;
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUzRA5DsZ8WcessaPKi5kUw1LuvxVNbo8hX2evZpBQA6p8oT+WfWiN1QuaiBkJBSm0JUYRPA==
X-Received: by 2002:a5d:4109:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37d3ab0118amr4315373f8f.49.1728548754437;
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8b80sm836160f8f.9.2024.10.10.01.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
Message-ID: <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
Date: Thu, 10 Oct 2024 10:25:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com,
 kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241007074702.249543-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/24 09:46, Menglong Dong wrote:
> In this commit, we make fib_validate_source/__fib_validate_source return
> -reason instead of errno on error. As the return value of them can be
> -errno, 0, and 1, we can't make it return enum skb_drop_reason directly.
> 
> In the origin logic, if __fib_validate_source() return -EXDEV,
> LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
> checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
> effect only after the patch "net: ip: make ip_route_input_noref() return
> drop reasons", as we can't pass the drop reasons from
> fib_validate_source() to ip_rcv_finish_core() in this patch.
> 
> We set the errno to -EINVAL when fib_validate_source() is called and the
> validation fails, as the errno can be checked in the caller and now its
> value is -reason, which can lead misunderstand.
> 
> Following new drop reasons are added in this patch:
> 
>    SKB_DROP_REASON_IP_LOCAL_SOURCE
>    SKB_DROP_REASON_IP_INVALID_SOURCE
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Looking at the next patches, I'm under the impression that the overall 
code will be simpler if you let __fib_validate_source() return directly 
a drop reason, and fib_validate_source(), too. Hard to be sure without 
actually do the attempt... did you try such patch by any chance?

Thanks!

Paolo


