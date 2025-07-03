Return-Path: <netdev+bounces-203700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724FAF6CA5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29064A0E98
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59A2C327C;
	Thu,  3 Jul 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhJD91vs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217C295523
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530731; cv=none; b=IremWtSpo3kXpDoepLYK/gSoEiybIC555bNDQ3LxE3p0kilTF60HWrzmNID3SGyV6SR33aDTBkKa0MzkXPYDaPyZc2gMx0ZoBiw0lELCrDwG3l70CKRf+oqs8sqCF1rk9fnDBHiLsp//lgC4+4XUC+aenQ7VdMNA1py0aX+CPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530731; c=relaxed/simple;
	bh=hk+vmY3dwf/9cfvNIfPCcCovO3SGaMSrfEj5J+75b3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtDOAGuzq5DHL9I4Dib7hv/5vxx0XPxbX2M6E5Ri1YWcJZfU6mgH+j1eKSaErHqQA252Vwp97fAfcjKl2MVbEXry2+VlVGRgr93XJF0ScAoQixDAqM6/14x2ePlJQgr1LLzL6fPV5RpE4GmKLY7Mrl7GTceveYqpSCGI80zZhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhJD91vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751530728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+LEYHxbEIy/Tv/yJgYAu7UXqbf4GKrC7aHzLDp5r0E=;
	b=GhJD91vsMAhaXZHOG/oYaOwBXwF/9zIN8nTtuvmplPeaYxdbnY1WU0hXlTp9aFrWYrFxSC
	x1mhp24VPVEfeNVeqrvSIPVvrOFF2KfOLl7gsblQktXVb4SrZYsmoaD/v3xhecbcN9MT6p
	zlNGZuZLUHwf9Yvg5A85gylm1QZEJzo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-mRGvkjDUMJipt8cZ3M7FaA-1; Thu, 03 Jul 2025 04:18:46 -0400
X-MC-Unique: mRGvkjDUMJipt8cZ3M7FaA-1
X-Mimecast-MFC-AGG-ID: mRGvkjDUMJipt8cZ3M7FaA_1751530726
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso5273131f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530725; x=1752135525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+LEYHxbEIy/Tv/yJgYAu7UXqbf4GKrC7aHzLDp5r0E=;
        b=Mt5dKXYl/Ymw7VF1V+lQkn7OoTBA4neHPeZ7kW0bb5d6nWWUg+6JeL6sYo4d5a70Qi
         su0booxxh095l+lIadNBrgucm1oLr6ISXyTscKO44QuD9v9V4oXAsSXZ4yKO2lroaSr3
         0sG968SwdhQ2W2Vy3Up/9WYAoAYFWetatdCwAUPVwVaR2Ja9GJucT6Ch07c/UXMHD3/l
         CyUQ0VDux9HNRAQJQkygpjyrH7V3gp2yATH3T3vzKtVkPQ6kYB7r9vi1VSwVdxXf//ND
         EphqGH6iclZlb10P40iX1zGgkG/w5uHFjACVWPV8duTps+nLWgsF4GBahPfOiQT7jKfL
         2wig==
X-Forwarded-Encrypted: i=1; AJvYcCUtQ3F2jQ5QtK5oX0XklphWsC4fz9kfJStXGQha7yXy/NqJE+/rY9ud8laZkgG/xzdqLtyNlT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaACVzWNMp5PnzKex63+qDbUR3YE2Ihf4V6CK9tGrETcB0KL2I
	9GUtL8+UFTu5vkMhaQoRB+W4MlU+Rvj0GEiMi+Mbhy5h8v8AGPkAqdchXBUlPO1TcFfLlduKUaJ
	waNgOqXFtW1qYCFUFnSweSIiyYIKKdzaE1YJYf9C8kx6P01o3Q8VLcMFS1A==
X-Gm-Gg: ASbGncuGjsBK6b+nDHO+Ea/wnUNL4mZsZRqPaXMf1u8a5befnaNl2XAcZ4rUcXR76Id
	IPf30jxmrfajzWRBowCsWwzig2FImuhHjuLXM3pWImJjRfeT2eraoDAlSsBwiD3L4MHS5jLX1WG
	NBVcbF1koN/RzR9oFewFH/e9B1DdaVYsmB6BkAkqUsf2cC2ml5JWYjoZm4yGLNG4vWfyjbt7i34
	D7zWq2cWBtU02ghX1lzT8/YNUzmTYTUi1MkwhyzbnV9w9R/A2YezqPfAVT3iASPKsqbiP3sJ7wf
	hXFx7glYs34wkFsbA97eJdRlfgw=
X-Received: by 2002:a05:6000:4406:b0:3a5:300d:5e17 with SMTP id ffacd0b85a97d-3b2001ac272mr2916163f8f.29.1751530725433;
        Thu, 03 Jul 2025 01:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW0kGfmmDWUEurUd2wl4ocsEjWEOjLs4QoNc2p+iimi1Wz7I4Ohva/pHwVEIrj+lRpCHqhCA==
X-Received: by 2002:a05:6000:4406:b0:3a5:300d:5e17 with SMTP id ffacd0b85a97d-3b2001ac272mr2916144f8f.29.1751530724857;
        Thu, 03 Jul 2025 01:18:44 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b516sm17574612f8f.41.2025.07.03.01.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:18:44 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:18:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <ed4jqbmfre4ggtza76lpzq77szhgxdfy5fgokqgfzdy3bdop42@wnp2s6mxejvj>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
 <20250702-vsock-transports-toctou-v3-1-0a7e2e692987@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250702-vsock-transports-toctou-v3-1-0a7e2e692987@rbox.co>

On Wed, Jul 02, 2025 at 03:38:43PM +0200, Michal Luczaj wrote:
>vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>transport_{g2h,h2g} may become NULL after the NULL check.
>
>Introduce vsock_transport_local_cid() to protect from a potential
>null-ptr-deref.
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_find_cid+0x47/0x90
>Call Trace:
> __vsock_bind+0x4b2/0x720
> vsock_bind+0x90/0xe0
> __sys_bind+0x14d/0x1e0
> __x64_sys_bind+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>Call Trace:
> __x64_sys_ioctl+0x12d/0x190
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 27 +++++++++++++++++++++------
> 1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..39473b9e0829f240045262aef00cbae82a425dcc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -531,9 +531,25 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>+/*
>+ * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
>+ * Otherwise we may race with module removal. Do not use on `vsk->transport`.
>+ */
>+static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
>+{
>+	u32 cid = VMADDR_CID_ANY;
>+
>+	mutex_lock(&vsock_register_mutex);
>+	if (*transport)
>+		cid = (*transport)->get_local_cid();
>+	mutex_unlock(&vsock_register_mutex);
>+
>+	return cid;
>+}
>+
> bool vsock_find_cid(unsigned int cid)
> {
>-	if (transport_g2h && cid == transport_g2h->get_local_cid())
>+	if (cid == vsock_registered_transport_cid(&transport_g2h))
> 		return true;
>
> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>@@ -2536,18 +2552,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 			       unsigned int cmd, void __user *ptr)
> {
> 	u32 __user *p = ptr;
>-	u32 cid = VMADDR_CID_ANY;
> 	int retval = 0;
>+	u32 cid;
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
> 		/* To be compatible with the VMCI behavior, we prioritize the
> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> 		 */
>-		if (transport_g2h)
>-			cid = transport_g2h->get_local_cid();
>-		else if (transport_h2g)
>-			cid = transport_h2g->get_local_cid();
>+		cid = vsock_registered_transport_cid(&transport_g2h);
>+		if (cid == VMADDR_CID_ANY)
>+			cid = vsock_registered_transport_cid(&transport_h2g);
>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>


