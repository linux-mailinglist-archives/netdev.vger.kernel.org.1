Return-Path: <netdev+bounces-200994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5BAE7AF8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40831766F2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12728469D;
	Wed, 25 Jun 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoPCt0Lg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EE26B973
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841693; cv=none; b=k8crYazh1bcK047jcC576KyVVnIrIGlMWJDiS76msBsADszfGGs2qeJbJCGx7Ve+QNJg0WJrQf4EzHLQV9CM9ZE5prbrPsvuI4MCc0IrkgtdDJYequLicAFmxo9e7d4vzFDiHRIL/pbdY3+dPBJum7+OG6WxpMW6Dmh5+wV1RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841693; c=relaxed/simple;
	bh=IMHNO1bT1El4HG2JXEHyLJZxCIu/EzODJnWdqZWBHw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9XQDliAc3RFSsiF/DPCow2Jo8HqeZp7Cmm0gF4GTjMDsP5zFXvhWH+yJW7tzN8nsoWwynd6F87llsXo571ew3Ym8As65cXwZWcD1U4YlpAe50FU1Um8aF76/2y87gIOW4DLWI6tHcCZ9AowCmt3yU5h9dbUESX4y62d324+wak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoPCt0Lg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7SojeMD2gps8cZo3IPHcE59cXnndpk0obLuxFCFG5c=;
	b=NoPCt0Lga0/6jdflq+J4E/ccK04N95tVlCIgg2Wunq/V+T0wNAnqfCmFsVPT0TWc8iwhaz
	EV5D8rHlenTxGe1IaSt4OEIN6I9Diwq+iOfqFVeSgOFY0GflqYgzUQcpMhySs/mTFQIHaD
	fxMtiHxqaF0oJbsw4ScOPC44YxYHGoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-ZJHRBYjdM4qTYx-bb8OAOg-1; Wed, 25 Jun 2025 04:54:48 -0400
X-MC-Unique: ZJHRBYjdM4qTYx-bb8OAOg-1
X-Mimecast-MFC-AGG-ID: ZJHRBYjdM4qTYx-bb8OAOg_1750841688
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45359bfe631so7127205e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 01:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841688; x=1751446488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7SojeMD2gps8cZo3IPHcE59cXnndpk0obLuxFCFG5c=;
        b=nDRfqHwdMldXgeTMnWYSYDJkz6edwnIx3lc4Y5NQMw2jVtT0AkBUvDogjawRwjbwSE
         OncJFGsm5FygHuMveSwRodUkww/n+T2Jaf8DZE6uTBNeVk1V39Fh54mfPVNnsGP/TwgG
         yGe00fDTGl/HvgFzSTii2hI8N/IuGO9YZCobnRPf4dEM9wQlFGKLz55JtHMr5h6EgTuf
         oKNgWZ7gM2twL5rE2X9tbguE+xIA/cSJB/1XqAeh1dou/S2nqMxvWdWgZj1Gq/ZJbZsh
         7N7XiuTJZNzu+jLUNgmBza7xOkmBS+Qlxx4DC8ayhyR2xlamvCRpTE/85cgCfWF5wU7P
         F48Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVrWFVm+P3hcBC4orAoVHb8R1WlqDp6xh3e3a0TaTcLKmRutheWXI83wQUcd3NZUs7TR+1KwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGWHng4jYQ3i9k+GIw/rRVdGXORViwEe0BXLj2vwSfWokoFmy
	W1sBEZ7nFN1RGgabYAjTSRV8ODJQz7cpQwCf2YnGQgNN4AtALqwJ1Qays2uI6ofM7UEjwbAwDAc
	0B2Cpm6XBLWpHK9Q4B+cv9IHq6X6wnMMgmcYVfFg0RycLr7+VQj01XCCTBg==
X-Gm-Gg: ASbGncu+uF1wn0OPyFMyHafy1i4EP4SJUZ8bgjj7KrYvZieEw5DGtAG5g1A6oeKzj8l
	qjk3d7JuObKWq+PDGEoXkfiyB85CJ6lQyDhzkt2pdakY9NT5bedfMvjkzKKWjvULww2gDxkX9XV
	Nh1Wl950Di6OB4xC2uQZ01lip2yB/7/K7No8KHtTruqE3+D2jUr87eb8FaI2acbZq9eWQqi77mk
	K/6nmF+zjnNi+LnQZPqxjjNooDmwlCZPc8sorP6+CtUYmjXBMMNMF0C2F8Cq9UYA7e5h60h6KJT
	vQ1uZxHK6xuvoKjzEt7hD4X3vEqy
X-Received: by 2002:a05:600c:35d2:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-45381ae467cmr18288095e9.19.1750841687671;
        Wed, 25 Jun 2025 01:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYLN8WpVcipmrn+PxxvTbwwdYiFGmiYVj3yUsHDD0K7ZUDXBWM8hLnXLAMurjH8x8NH2rxcA==
X-Received: by 2002:a05:600c:35d2:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-45381ae467cmr18287785e9.19.1750841687044;
        Wed, 25 Jun 2025 01:54:47 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad247sm13350055e9.26.2025.06.25.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:54:46 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:54:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID
 to check also `transport_local`
Message-ID: <uqap2qzmvkfqxfqssxnt5anni6jhdupnarriinblznv5lfk764@qkrjq22xeygb>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>

On Fri, Jun 20, 2025 at 09:52:45PM +0200, Michal Luczaj wrote:
>Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>available.
>
>Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:
>
>   Ioctls
>       ...
>       IOCTL_VM_SOCKETS_GET_LOCAL_CID
>              ...
>              Consider using VMADDR_CID_ANY when binding instead of
>              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.
>
>   Local communication
>       ....
>       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
>       used for the same purpose, but it is preferable to use
>       VMADDR_CID_LOCAL.
>
>I was wondering it that would need some rewriting, since we're adding
>VMADDR_CID_LOCAL as a possible ioctl's return value.

IIRC the reason was, that if we have for example a G2H module loaded, 
the ioctl returns the CID of that module (e.g. 42). So, we can use both 
42 and VMADDR_CID_LOCAL to do the loopback communication, but we 
encourage to always use VMADDR_CID_LOCAL.  With this change we basically 
don't change that, but we change the fact that if there is only the 
loopback module loaded, before the ioctl returned VMADDR_CID_ANY, while 
now it returns LOCAL rightly.

So, IMO we are fine.

>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		cid = vsock_transport_local_cid(&transport_g2h);
> 		if (cid == VMADDR_CID_ANY)
> 			cid = vsock_transport_local_cid(&transport_h2g);
>+		if (cid == VMADDR_CID_ANY && transport_local)
>+			cid = VMADDR_CID_LOCAL;

why not `cid = vsock_transport_local_cid(&transport_local)` like for 
H2G?

Thanks,
Stefano

>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>


