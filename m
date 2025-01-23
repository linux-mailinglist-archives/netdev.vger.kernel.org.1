Return-Path: <netdev+bounces-160558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B9A1A28F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3485F160CDD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779720DD4B;
	Thu, 23 Jan 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR0wsGpp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9120C46B
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630448; cv=none; b=oxm+87neTc9Vss1EYzGc/x0jKIHcXT0YV80ADYgwOjjGrG/uztmwrqHXD5V8Hp59GXvLFSTxVaGW7/A23jNkRXlyPYzH75x4+jxm6ILKrVL/rm5G/ACcyMZP89T/E9p1zAWYWXp7W8cYDojbe3qnsardQCgzSIwCFXdocM+rRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630448; c=relaxed/simple;
	bh=YPOST1Fzc6x2LIkj6vAO74E2gLZ+iV52PnFU26XNinw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM2sybDemS8IOo/d9LCMtWcxF3642rhR9bjNx9vNbu7bVeLrB4U+o9/iPld/nCWtBUy2a5itfhPhlcYwFLLWAo0AqrMKjcnixtBEFAlQuAT+Q9tB/nO55LUI41Yqly8qeSu0S+MwnI2IQrkesAy0PRxoZYhy9usmim6Mx9XVGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR0wsGpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737630445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UB8pKxlQSwgWdcKeuClWsuan72QQNYMhxbYghGZa83o=;
	b=GR0wsGppbjUzQmB5hXsWFhtJIcRqSv0lHFBgA6qLp2LGQUCWCaPyHgks7aarsVRs+0wcqN
	TVuGZGkfd+9yJnYTjdbxx3MqFO2RGKllv9CvccZxd1mvD5s6DTDVAz5cfBKEThSAnwmooO
	VEwGWPmMJYNHnx9Fok5sAH/teX/PcvA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-VrUj8Lf5Pfm2ya8EfMzdIw-1; Thu, 23 Jan 2025 06:07:24 -0500
X-MC-Unique: VrUj8Lf5Pfm2ya8EfMzdIw-1
X-Mimecast-MFC-AGG-ID: VrUj8Lf5Pfm2ya8EfMzdIw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38639b4f19cso513129f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630443; x=1738235243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB8pKxlQSwgWdcKeuClWsuan72QQNYMhxbYghGZa83o=;
        b=JnNWzyYoFLFo4buZlNnU+slUt+W2EXQtx3Z7WaPUfvKVUTiCJCSEGB4LuqZivnEu/C
         Gno1iPJoVLhswRduuHIKFg8EjaFdd06GrgqFSAn9f6Uox1PH8zZKivxCP4aOejTgvYiV
         Zvb5W4mIy+Yhu1Orr1Gt7Rl5hhtzt9Ffh4xQQ66fMHbwNKTlTmc4SvFWPiBz3xRsw1P7
         1kubSrJNu7HcMQhgd25eEheEIUn9/kNluA6ZD8kVvW3m8Jf26DUdDNImGg0/tGjJPmZk
         9q4XxPNUXNiOHboTPLQ3VDXq/ys4vcuuK54sFk2WrTgkhZvQU43PV2XS9VhuP6df5OLe
         vNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9NhPXMU+Jc0D6UBd9SMLiG/I1GKKiy6ZO2kxQw2lD80wxF0N6DMxLn7bvi7Y+AdUFwZdIrYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHnB3H2V2toDzU1U+tCPb9kcUc9ji0+SZdXWE0bSZDKCLY6L+
	9tl9CAweEVAG1+c2XAtnVIJmwUj8NtqmcP+ZjDMJpVN1btwNFoPjnKgaQIml0kXfpmNxCS2lefr
	iy42UWnIn+oY5FyFZwo2+AxjIgrOw+Ys64cgHJqj7IyDhfkrM4oNmkg==
X-Gm-Gg: ASbGnctONejVb4FD+jCb1rvDGiUgxxsha+0yY/t4e4/NoLBsTgCfTHNJTpOqlrjKpLL
	JPihmpp8vhVSk5TNdJzQac3O0K/OumEES/bZWniHIkSbIpNq8R/+O8JMhn+OZwbbKof/tNTXR75
	0hFdSCjr+RuxTsF5bFeddsJPv6lng80uSAw1+8GR3qHQKTrHzg8ji8Tl9gQkQxzql0kdR+oISYm
	F7xHZm5WpweqyITHA8S0YEcQOtpMjlxmt3407AtkdG+cl26gapyogwH+DRdFHJoEod8opv1FRBD
	LrX67lowhQV2HpNSNmfY4jqTgdL3qr0OBrrfLAYx6J8/Xw==
X-Received: by 2002:a5d:47a9:0:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-38bf57a77aemr23651308f8f.34.1737630442822;
        Thu, 23 Jan 2025 03:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcmMshoEt2cTW2G7eHsewYbeKhCpKdgj1qbOoQfKuj7MMZZa3MdWczPNJ6P3orAKtC72cXQg==
X-Received: by 2002:a5d:47a9:0:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-38bf57a77aemr23651225f8f.34.1737630442117;
        Thu, 23 Jan 2025 03:07:22 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce2295sm1062377466b.64.2025.01.23.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:07:21 -0800 (PST)
Date: Thu, 23 Jan 2025 12:07:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 3/6] vsock/test: Introduce vsock_bind()
Message-ID: <ygnl622eexwagmxmsq5nrjk6owxr7tpdu4jd5cpkgkdnio6ekp@6jzpcwcsdnnm>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>
 <xzvqojpgicztj3waxetzemx5kzmjy57yl5hv5t7y2sh4bda27l@wwvuhac6zkgg>
 <64fcd0af-a03b-47d5-960d-4326289023a5@rbox.co>
 <gkgrd5zpqow4jn2dzr4svh2xu2tfhzucqjv5wavnqrq3qa34uj@x3lv7qy27t2m>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <gkgrd5zpqow4jn2dzr4svh2xu2tfhzucqjv5wavnqrq3qa34uj@x3lv7qy27t2m>

On Thu, Jan 23, 2025 at 12:02:36PM +0100, Luigi Leonardi wrote:
>On Wed, Jan 22, 2025 at 09:11:30PM +0100, Michal Luczaj wrote:
>>On 1/22/25 17:01, Luigi Leonardi wrote:
>>>On Tue, Jan 21, 2025 at 03:44:04PM +0100, Michal Luczaj wrote:
>>>>Add a helper for socket()+bind(). Adapt callers.
>>>>
>>>>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>---
>>>>tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
>>>>tools/testing/vsock/util.h       |  1 +
>>>>tools/testing/vsock/vsock_test.c | 17 +-----------
>>>>3 files changed, 25 insertions(+), 49 deletions(-)
>>>>
>>>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>>>index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
>>>>--- a/tools/testing/vsock/util.c
>>>>+++ b/tools/testing/vsock/util.c
>>>>@@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
>>>>	close(epollfd);
>>>>}
>>>>
>>>>-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>>>>-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>>>
>>>If you need to send a v3, it would be nice to have a comment for
>>>vsock_bind, as there used to be one.
>>
>>Comment for vsock_bind_connect() remains, see below. As for vsock_bind(),
>>perhaps it's time to start using kernel-doc comments?
>This is a good idea! @Stefano WDYT?

I'm not sure it's worth it since they are just tests, but if someone
wants to do it, absolutely no objection.

Thanks,
Stefano


