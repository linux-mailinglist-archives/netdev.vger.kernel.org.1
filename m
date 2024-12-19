Return-Path: <netdev+bounces-153264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2519F77BE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB416D409
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CB220681;
	Thu, 19 Dec 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ6ZNg/r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9402165E4
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598475; cv=none; b=UpjLS8yPyldlW9iDdwgzPNW3yYDFGcaR40Pz7w8EuCjE5hoE60Wdro4ixZL7djhGZGXMMGZLWElB6mtbdd1egt1ysiG1mMoj4H+rmhCEp1VFjAadL9nNo0nxdAkcLOjQ7glNoaaF8YCZjRzuwVU49h2OaIIzuHSevsJF60XJ00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598475; c=relaxed/simple;
	bh=AbZVrsl5rcNSdQpiQSZHZhwFsv98yfZDMrhu36UQQ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBYmCWhvd7RJX6yGfMASIONGrn4MtUn7PhI/Nq33MVGIiu/loSeS5nKyomgDZ+P9lq0vlNIAZ/+qqH1238fMZdhdSr+3F4eloQPyaLW4zcpr5VlHorTyl2EvQIjibyycQGcc9pGzotra5sbSfwhv5OMCnDHc6GV1mnQZ8bg0JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZ6ZNg/r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734598472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln73Acm3j+A5OSP5LEbrk72iNmfw3DGuza7Hn+SfBsI=;
	b=XZ6ZNg/rV2a6VJkfFu4rpFjblbs/EwGFiydjpsrnjia5UwJM/3hcKzx0LU7q8HzunDf02w
	/ugxiJ8K4VKvlJ0BoeB2dQAxr+btTB5rRl0XLXmVRstwQ6yQCW93SxN7gsfWynZRYrMu6y
	C0w/vAuIKgBruIgkpi9ykUL4VaEdXwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-X9r9x-GbOFekPeuKLvwuWQ-1; Thu, 19 Dec 2024 03:54:29 -0500
X-MC-Unique: X9r9x-GbOFekPeuKLvwuWQ-1
X-Mimecast-MFC-AGG-ID: X9r9x-GbOFekPeuKLvwuWQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43619b135bcso3065375e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 00:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734598468; x=1735203268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln73Acm3j+A5OSP5LEbrk72iNmfw3DGuza7Hn+SfBsI=;
        b=jmgp7FtWcFXpOnsLBb0XR3KC6n3sCCk5EiFf6K+lWYoPcGy44AJhF/MeFbhSG0401W
         IRdYhLxLaKVN3vb0IzPaIlz8+hpOBSiiJ8oKw5tXxxtV20rXTgUjTFu/LdI2cb7LbkFo
         TWqnjd6S9HP47yiXhM0Ryakdg/iRHb2n4H5clrHcddEryJ4WrN3qhkhvp26U3/FQ/slx
         bE8O9vtNgXao1MaFoazCqSro6WW/Mk8y4Al8q9KL9s6vo8wuxaVj6i2yshAe/k7PhZOb
         Ervl6AIm5Y43jidPT33xDKbvkMU0j4DUHuTH9Yf6/Mf+5I2LK54hvyl6DiemneOl74Ta
         l35A==
X-Gm-Message-State: AOJu0YzcvrmkquY85+R5KO0sUojIHSKKn/FJe0rXIC9VLY9pDTLVyWvZ
	LR5VOKG5PnU48zBFyY4qnmUNTANFgp4AVpn+sMzAcTLNT52MNeP17sZqsivzELmgFRxpviw4BTp
	NCx1J0phQXYZo5KJKse2mAL11LAEw5CXNjS13tyz1isR4igr+klLXfg==
X-Gm-Gg: ASbGncuIzHU+MgLxhbHYuXEBrRZ4h0jsGqHiuAYWDP7l1a6YVWvyhb2g+7/keSr+5t6
	hrWSYoTJiudnKQsatwOebFBiElncApH25EUsRmk+SNrD6Nn/czjqG/CqBUYPy8xOfK5cLIzChcx
	8TMFc4dB1VVdY63m9F4KNweg6GF/7WykMgJn2aS+nPKgl85Ov5kPR1I+vqh/+4HvqMkP0vP7bBQ
	O3+oabdFsTjX1KHkg+hXd+Qvt+aFPI+VAH6Tsb0W2GZ13uxAbQoA5FJwG5G/WAhBo5vh624g0f7
	YscFrTHwGA==
X-Received: by 2002:a05:6000:4a18:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-388e4c94037mr5970412f8f.0.1734598467832;
        Thu, 19 Dec 2024 00:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8u3gkOMLTQkOjSqvv39VU4biDyXs1jALCJ+S0HqVLmGxgtgTo7tJ8iRysWUI+BMylGj423w==
X-Received: by 2002:a05:6000:4a18:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-388e4c94037mr5970386f8f.0.1734598467277;
        Thu, 19 Dec 2024 00:54:27 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833149sm1020867f8f.39.2024.12.19.00.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 00:54:26 -0800 (PST)
Message-ID: <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
Date: Thu, 19 Dec 2024 09:54:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
To: Soham Chakradeo <sohamch.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Soham Chakradeo <sohamch@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241218100013.0c698629@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:00, Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 18:51:57 +0000 Soham Chakradeo wrote:
>> Import tests for the following features (folder names in brackets):
>> ECN (ecn) : RFC 3168
>> Close (close) : RFC 9293
>> TCP_INFO (tcp_info) : RFC 9293
>> Fast recovery (fast_recovery) : RFC 5681
>> Timestamping (timestamping) : RFC 1323
>> Nagle (nagle) : RFC 896
>> Selective Acknowledgments (sack) : RFC 2018
>> Recent Timestamp (ts_recent) : RFC 1323
>> Send file (sendfile)
>> Syscall bad arg (syscall_bad_arg)
>> Validate (validate)
>> Blocking (blocking)
>> Splice (splice)
>> End of record (eor)
>> Limited transmit (limited_transmit)
> 
> Excellent, thanks for adding all these! I will merge the patches
> momentarily but I do see a number of flakes on our VMs with debug
> configs enabled:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill-dbg
> 
> In the 7 runs so far we got 2 flakes on:
> 
>  tcp-timestamping-client-only-last-byte-pkt

Quickly skimming over this one, it looks like it does not account for
the increased default 'tolerance_us'. Kernel packetdrill set it by
default to 14K (instead of 10K IIRC).

I guess this statement:

// SCM_TSTAMP_SCHED for the last byte should be received almost immediately
// once 10001 is acked at t=20ms.

the the follow-up check should be updated accordingly. In the failures
observed so far the max timestamp is > 35ms.

Cheers,

Paolo


