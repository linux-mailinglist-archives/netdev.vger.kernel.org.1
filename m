Return-Path: <netdev+bounces-251419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B863D3C484
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29B1B6CAFC3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9583C1FCC;
	Tue, 20 Jan 2026 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8+JF6mM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="clDBS6kH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93273366DD7
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901862; cv=none; b=JMqZcEmKk9k6RVBdExCCD1osgvrGpyHw4sgl5wDazEjvyYxKcwikZC/Yn3J8lOjufAfIK+k6pizpw6BQaI3VEUmc6MpL0gQm5qS62ff5/vnutvzvW26PlIUdLwOFuliAK3+sTzYqOFjWaKGdhsrB8qOqZvVOyqFZH+QqYATlvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901862; c=relaxed/simple;
	bh=gJ8LRdePpGdfZIJ/xvuV9faBPChp54PHBmUoMXirzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2ynJQaU4zvwbHSiuWZeA+bKQAgo4Neuo2A0GtC0P8OuCROte7pW2he34FrASW/CoFbyVhXe7pqYsGeR6AQQE8W1AhA+fbgJj5HQh7qOh2eXJQCcQNrukKrqZywIUAfBjlxon+GOH10+yWiHhA3ykXkHr8MyBEUPAmpJqRNOIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8+JF6mM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=clDBS6kH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768901859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1riUelQkHubbog4Pig/nehvQm9nmVpndQsv6Cs1UVao=;
	b=K8+JF6mMHL76bZxS+ci6CY7KEnR5jdjxJGutZ+fuCfQlF0fbr47SzwJjAOKJRQ0ugF1xb0
	2Y71nRwmVtTchM1c6Un9PoE5UDZrtlTG8co6aH7HiMY+vimmGji2SprwxZjyjaG8yEzvWS
	uC2gzmgydR7cJT0JMc9UHzoDT7IdtXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-KRoHfOuzPriqyqW6nDbTaw-1; Tue, 20 Jan 2026 04:37:37 -0500
X-MC-Unique: KRoHfOuzPriqyqW6nDbTaw-1
X-Mimecast-MFC-AGG-ID: KRoHfOuzPriqyqW6nDbTaw_1768901856
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcfe4494so5249658f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768901856; x=1769506656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1riUelQkHubbog4Pig/nehvQm9nmVpndQsv6Cs1UVao=;
        b=clDBS6kHuU02e+svmRR7saf/d/7sXPtTCBrZqdainfUer3Ca8mC7vbq2mu+aFLdw3Q
         I8aR/8hdlZSmln8sl3WNdIz6E+GzjWZGfvs9g7rMcQj1tic2Lr9Y+iJ9JE/ydbWCuKp5
         gbADY0103aGNyrfR/uFtF7+cZsOAaT0Q4eUlF3cIawQK/LLEZVlDzsdJMwO5niDelrC/
         iBthyFfxBDJdzuBix0iny0V/TJ0PUXFbcQrRrVd6BC4ZaN9b0lw9iOlovBcjTklRd0pp
         93gLowV0g6E+Oiz9wnlUStpTnPpaVnj7b5r1xJWDeDWXtdwk7hkGkVwDtRJo5oapXJHG
         4HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901856; x=1769506656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1riUelQkHubbog4Pig/nehvQm9nmVpndQsv6Cs1UVao=;
        b=kOHIbs2iISU4yMEgRLBUnHi98K7Av2DopXYAgRTj1wzZHrZZGXlUYlZYU/s9hukNI4
         AN3ynFDDg/1KwfCEI0T63dkluhHbEbtFPz638okkxRvLK/IjyUfbKPNyIpoUMXj6K7s3
         ZvVwr5RhVnLrM80aQGzUanCcHzBFJaJTgDuI+2daNJmfFo8l+ekwpmnhtM2d3LZtoeqa
         x2lhrrJLwsCnxDBP2S8xfHz1nq8yhPq4YDngYpW1t7qmvQlTJvsT9PCvlzR6zDCxAwfX
         gh6pccZJz9xX3vHA8ZYbdohCgM6tQvfIa2EPX71bfAgzGW7B6SWZhpCqpv9bG2ky5GEF
         ZVUw==
X-Gm-Message-State: AOJu0YydCzbHZ+3EVEblsv2zB82VsRPtBZFPOkeKVoe6KP6HfmzLkRdR
	T0r/JO62u6mR2zbDsC00IqPe5VjTEPvp/pC7sPTIV2kLFl/QKeVpztaFcGuElVcwa7hxXeXRcmB
	6HHugXlzTQf9iAgle3Mr4U3D4Iuomxzo+c+hZLI2sSpwI7Zo7DnK0wY2Krw==
X-Gm-Gg: AZuq6aJgwgSYgknpjHxsMmR31teViZiiOjxHZ5OXllQ7fceeK6aP+LgPPTozlAg55lU
	z1gcxfjdHQ/Ma0Z4Ca55cpXzFppBBgObxRr5778YK3gX9eLxwqrLnt+MFG4ep23DMkLJ8iaUhKm
	8c6diYpy2YM9L9XbuohEXtVDJXdhLozCbyH7vPgcJPCOm7+cwDBuLL1ri+gB+Zo7dfhQkcq6tym
	9x5ptEx1MnqsThhcoRCyDH5HxRJyKC22bPRwibNw7w65cmQKptmb9b/N39mSRQyOZ83yIw3e7I2
	y2jwdYGdIaUFNPpdZPgcVzGb+ffgLJSCaOeYBdqiCNe2igd4OgxYmWtHXyGSlGAxYzxAqjxcbV+
	Q5guinKGS8ZJc7qostdmVLznqu3w5HQiYwSK6h5fh2mS11dCM7+ymo69AlEo=
X-Received: by 2002:a05:6000:2f83:b0:432:5b81:480 with SMTP id ffacd0b85a97d-4356a03d2demr19167510f8f.24.1768901855985;
        Tue, 20 Jan 2026 01:37:35 -0800 (PST)
X-Received: by 2002:a05:6000:2f83:b0:432:5b81:480 with SMTP id ffacd0b85a97d-4356a03d2demr19167470f8f.24.1768901855514;
        Tue, 20 Jan 2026 01:37:35 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cefdsm27663754f8f.24.2026.01.20.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:37:34 -0800 (PST)
Date: Tue, 20 Jan 2026 10:37:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Asias He <asias@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aW9L0xiwotBnRMw2@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
 <20260119101734.01cbe934@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260119101734.01cbe934@kernel.org>

On Mon, Jan 19, 2026 at 10:17:34AM -0800, Jakub Kicinski wrote:
>On Fri, 16 Jan 2026 21:15:13 +0100 Stefano Garzarella wrote:
>> Resend with the right cc (sorry, a mistake on my env)
>
>Please don't resend within 24h unless asked to:
>https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

Sorry for that, I'll avoid in the future.

>
>> The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till
>> v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/
>>
>> Since it's a real issue and the original author seems busy, I'm sending
>> the v5 fixing my comments but keeping the authorship (and restoring mine
>> on patch 2 as reported on v4).
>
>Does not apply to net:
>
>Switched to a new branch 'vsock-virtio-fix-tx-credit-handling'
>Applying: vsock/virtio: fix potential underflow in virtio_transport_get_credit()
>Applying: vsock/test: fix seqpacket message bounds test
>Applying: vsock/virtio: cap TX credit to local buffer size
>Applying: vsock/test: add stream TX credit bounds test
>error: patch failed: tools/testing/vsock/vsock_test.c:2414
>error: tools/testing/vsock/vsock_test.c: patch does not apply
>Patch failed at 0004 vsock/test: add stream TX credit bounds test
>hint: Use 'git am --show-current-patch=diff' to see the failed patch
>hint: When you have resolved this problem, run "git am --continue".
>hint: If you prefer to skip this patch, run "git am --skip" instead.
>hint: To restore the original branch and stop patching, run "git am --abort".
>hint: Disable this message with "git config set advice.mergeConflict false"
>
>Did you generate against net-next or there's some mid-air collision?
>(if the former please share the resolution for the resulting conflict;))

Ooops, a new test landed in net, this should be the resolution:

diff --cc tools/testing/vsock/vsock_test.c
index 668fbe9eb3cc,6933f986ef2a..000000000000
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@@ -2414,11 -2510,11 +2510,16 @@@ static struct test_case test_cases[] =
                 .run_client = test_stream_accepted_setsockopt_client,
                 .run_server = test_stream_accepted_setsockopt_server,
         },
  +      {
  +              .name = "SOCK_STREAM virtio MSG_ZEROCOPY coalescence corruption",
  +              .run_client = test_stream_msgzcopy_mangle_client,
  +              .run_server = test_stream_msgzcopy_mangle_server,
  +      },
+       {
+               .name = "SOCK_STREAM TX credit bounds",
+               .run_client = test_stream_tx_credit_bounds_client,
+               .run_server = test_stream_tx_credit_bounds_server,
+       },
         {},
   };


If you prefer I can send a v6. In the mean time I pushed the branch 
here: 
https://github.com/stefano-garzarella/linux/tree/vsock_virtio_fix_tx_credit

Thanks,
Stefano


