Return-Path: <netdev+bounces-64292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5A832183
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 23:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C21C22F8F
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C931755;
	Thu, 18 Jan 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpZ5RSeK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9D3218B
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616579; cv=none; b=BuWRBVOL45nAUHYOOINdu6APQkk4df0JpJgVVJoN178+AwQyjrQQs04qLy7y+vSe53zcCpydNBu76RR+8uANMk7+kFbzzF+H//+Zwncz/LACHMSjMYbLfNxshcv1UYFdpK0v/MMz2isnAsDDkjNDJsFuyHp1Zfmmv6HhGxFPua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616579; c=relaxed/simple;
	bh=526of4HqjOzwOIFCBibfrY1voNlM3Difc4c/rvJiVj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HivxkJ6Pp59C8TqmHRR5CfVVn56KImN1SMxHuTBZcx8zcGhpSSBcvIzPzOg0dqmKWeUJxquUtfK2EHkJR2ePgU4ssT47vUCuo4jbJkKHqsDnFPakmK+m4vR2ow9qkBqOobt7gJQsARABJNrc0YoMp3MCK2aQkZHmXoiWjFPWbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpZ5RSeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705616576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvxBCM7tLuOpwx8+wEAIw7J+J049pbv0MA/RJ2ja7ZE=;
	b=gpZ5RSeKSP2LONzO2IYd7xDsrB++1cmbDvr3fvgLWQC48Rf/nOH8yLzQxIQl8IRl+eruiI
	IQQ0CcA5J58216tipzDIwJ9NN03F2//8cgtJ/eGgcX+gpEkZr0pIpAKFXCgPjq6McnIQJ6
	JZD0dzAhygPhOH1EvvVOKzAjKGaaYh0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-og1wZPslMca7hME-9zI47g-1; Thu, 18 Jan 2024 17:22:54 -0500
X-MC-Unique: og1wZPslMca7hME-9zI47g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-429ca123301so21314391cf.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705616574; x=1706221374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvxBCM7tLuOpwx8+wEAIw7J+J049pbv0MA/RJ2ja7ZE=;
        b=QnTpVgjrVfQSoPqVKWRJUyOu+1zMH24Gu+Y/h+uXj78bP/I0muzUya1a29pDG+Ge2M
         7RQOIpHGZDTvXUk4XKSyfgdfeaSQ8XucDGTgenoEy7ducQZsHcueOFUwmVSCaUn+Wv2X
         D5va2xAqrKP5Cdpe+ENhycr4yWMMrtphDc24+n7BWZrZq3VxiwjCnJmEZnjQ9m8iQZD6
         Z+PBzmDdrhtwivvTIfea6ZYIKUZPulF637gCjN3674TJCgldctJplf4rk3k5tTfaIiKJ
         e6e9Y6TtZ2RqAIM5DspWrZunh8GNXgyHxOVmTYGf9FJK7iyGV4jeRQzPuEceS5vcMSCX
         xxiw==
X-Gm-Message-State: AOJu0Ywd7yOf5s44o7k7YEGI7glmwoUfcG2lbC0F5exQ/Mr+kZ/HPnPv
	TosyL2ZuArAlMqWP0B4wo85aUoMzI6PNz8Xkl5ZdqVM8mhlY5Tn6kk2KLEs1C9ofUYSIyEgJJB0
	ikY+4l2S10E9CSd2yWV96g/EVbZghE5YqMoJxDW8fcMRE7o5qUhAX8g==
X-Received: by 2002:a05:622a:1b8c:b0:429:f36c:c3a8 with SMTP id bp12-20020a05622a1b8c00b00429f36cc3a8mr54380qtb.29.1705616574110;
        Thu, 18 Jan 2024 14:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIy/Q9lJrPxvZzjxVCIHrv8RLUIKR9E98DHv+c76z2bAYwxPzJ/nj7XOaWTLW+09+1TQQ/UA==
X-Received: by 2002:a05:622a:1b8c:b0:429:f36c:c3a8 with SMTP id bp12-20020a05622a1b8c00b00429f36cc3a8mr54369qtb.29.1705616573815;
        Thu, 18 Jan 2024 14:22:53 -0800 (PST)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id cb27-20020a05622a1f9b00b00429bdb1d705sm7163417qtb.1.2024.01.18.14.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 14:22:53 -0800 (PST)
Message-ID: <595d89f1-15b1-537d-f876-0ac4627db535@redhat.com>
Date: Thu, 18 Jan 2024 17:22:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC net-next] tcp: add support for read with offset when using
 MSG_PEEK
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com, dgibson@redhat.com
References: <20240111230057.305672-1-jmaloy@redhat.com>
 <df3045c3ec7a4b3c417699ff4950d3d977a0a944.camel@redhat.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <df3045c3ec7a4b3c417699ff4950d3d977a0a944.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-01-16 05:49, Paolo Abeni wrote:
> On Thu, 2024-01-11 at 18:00 -0500, jmaloy@redhat.com wrote:
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> When reading received messages from a socket with MSG_PEEK, we may want
>> to read the contents with an offset, like we can do with pread/preadv()
>> when reading files. Currently, it is not possible to do that.
[...]
>> +				err = -EINVAL;
>> +				goto out;
>> +			}
>> +			peek_offset = msg->msg_iter.__iov[0].iov_len;
>> +			msg->msg_iter.__iov = &msg->msg_iter.__iov[1];
>> +			msg->msg_iter.nr_segs -= 1;
>> +			msg->msg_iter.count -= peek_offset;
>> +			len -= peek_offset;
>> +			*seq += peek_offset;
>> +		}
> IMHO this does not look like the correct interface to expose such
> functionality. Doing the same with a different protocol should cause a
> SIGSEG or the like, right?
I would expect doing the same thing with a different protocol to cause 
an EFAULT, as it should. But I haven't tried it.
This is a change to TCP only, at least until somebody decides to 
implement it elsewhere (why not?)
>
> What about using/implementing SO_PEEK_OFF support instead?
I looked at SO_PEEK_OFF, and it honestly looks both awkward and limited.
We would have to make frequent calls to setsockopt(), something that 
would beat much of the purpose of this feature.
I stand by my opinion here.
This feature is simple, non-intrusive, totally backwards compatible and 
implies no changes to the API or BPI.

I would love to hear other opinions on this, though.

Regards
/jon


>
> Cheers,
>
> Paolo
>


