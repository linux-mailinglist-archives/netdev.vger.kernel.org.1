Return-Path: <netdev+bounces-198068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEEADB25C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B91188DF7E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945E292B52;
	Mon, 16 Jun 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfybn6CB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50762877E1
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081383; cv=none; b=b38hgpu0MbmM8s4aKVaaiStgbZMnqHIEw51D5syzJaW6E5OUk+pJP32xIKK7rOUtnXYBvZvJbLfej8R6Ua+Lv/zzkUvWcNqMciV0qEfts4oOcAmNdiiH/ViRLstm4ZZ1agZy3mSCsS6D5ki+pEi8EPnPtpaUhJ/qHTy0OItoCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081383; c=relaxed/simple;
	bh=VnrsqW0cFhf4bv6MzZGMbjFwbnVzVssH5gqIsZDw+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2em4JZOjlod7AmTvnFNYKieQTjJE3KtQxYGeKBzw3UGts09wTSNuRExOr9bL64IO8egLVfG0AZmhhsJiVlRkITWU7jCPihPMJ1QX6gcI5gVib1XIhcw8GVy5sMmqplTZ4MOG+gzUSs9IYP3cPdyQISaBuRqytgDWdT1Pn0If0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfybn6CB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750081380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYooHu95agsZ2B7UMKycranS7g+0oNMg2oTlfmTsJ8A=;
	b=Dfybn6CBa2XvpSgO0FI/SS6sRF+aL9F+TCUXFpUXWvA8NIayMZ21Q4ekef22gTl9x6XdYY
	YLwaVP6zJB8/x7Ftmlo+dKPkTudAmq/OXV/53fMLJ+hPnyw22kSpgiq4JxQFUGMH89tU5j
	kk1GEM9CVCuqbnSDCiJhIrPknqWwD9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-CtDYprUbPuemndWWNeC41A-1; Mon, 16 Jun 2025 09:42:57 -0400
X-MC-Unique: CtDYprUbPuemndWWNeC41A-1
X-Mimecast-MFC-AGG-ID: CtDYprUbPuemndWWNeC41A_1750081376
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450de98b28eso28347415e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750081376; x=1750686176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYooHu95agsZ2B7UMKycranS7g+0oNMg2oTlfmTsJ8A=;
        b=HYHaQ6eF6I6WpV/8nPuQm56eQjbiAlX3IwdPqbkoVKXLRHmdXazHqFiffkSb43WsJh
         Tn91LhHAWJHd+m5/Qj0MoVY5fncTSn4tcOZCRhgWAqOpLrfw0HzJdqj7Pfr5PClUytaH
         zZx9d6KcIK2AxsXqfu24fjpjAU15wsaGUKlXnhKZm+5QUgiqcFDMY7Ma7L4kb02i44Ey
         aKm3JmWa5TeAQcveYiYSpr1VdlnWUWAQ4v7GmGWVP2DQ5BVOVCeEqDYWrOfaNhCpvRZI
         0uiDm7tIbhV8zM8D0Pt+3Sn3oRYMDdTvdFDJ15+A+pYBgVb7jMr6i9wWPIqJ1Pw15rxh
         dxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVoInqkOpmv5W+CFcidNHYYqOcinma0QBkvWODgtx3dQ0ZhD9Qk9kuKsJst2FqYSi5hr8VjmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvPiSqyIilrmz5xXMxEwMSkOF17y1hbgRvlSAGwlwYQgNJeOK
	0z5d0VOqiT9uj/LbweV3LQV8M/p7iLX1la9tJ4T7B3eipnGKierqpPSK0TnbvSV+MnxOKHJ5Pce
	nDEtrsWozWzOZIoqS4x1NNoC2BRwe2aDI1TRbSRcBV9CUSkClRofCnCS8Iw==
X-Gm-Gg: ASbGncuPIJit41F+h8L69sLoxYWWIVfO2rZJA7LfasUPIqLkwJ+rUAJaevd9SRdEGZM
	j0EA4CtmBM+ghllkAjD1SoIDdaFx6YQqhZfHUy73eediciKIlimARmc+3QV9qAjRX54/pBGM2u3
	S1vd+6pMDSkt0Q/nFRGDxrgShqEiq4Lpm+5P9R2OFBIIxDpnvrcG7pbRrP57T4Ulnv7/NhwN3Rd
	CqgLIcC5v2EaHjc62V9FBlfpx+hdHPCap1+28tFsAFohqGmuKhPT0jyzAG9r5IRMvV8N8TAza2l
	WBEiwP8ec9kpovv5VH0hPHF4Iw0=
X-Received: by 2002:a05:600d:d:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-45345f19d92mr48060945e9.14.1750081376138;
        Mon, 16 Jun 2025 06:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9QG30mvjeJ1Ut+tifvz1DPhVeIM1Fgs5sS6gUqPYjMUgSgqJf6605Ua8bVmyMnHzNApbnvg==
X-Received: by 2002:a05:600d:d:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-45345f19d92mr48060675e9.14.1750081375726;
        Mon, 16 Jun 2025 06:42:55 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1b1asm148612515e9.14.2025.06.16.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:42:55 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:42:53 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	netdev@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <2bsvomi4vmkfn3w6ej4x3lafueergftigs32gdn7letgroffsf@huncf2veibjy>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>

On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
>This patch adds support for SIOCINQ ioctl, which returns the number of
>bytes unread in the socket.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 2 files changed, 24 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d56e6e135158..723a886253ba 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -171,6 +171,8 @@ struct vsock_transport {
>
> 	/* SIOCOUTQ ioctl */
> 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
>+	/* SIOCINQ ioctl */
>+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
>
> 	/* Shutdown. */
> 	int (*shutdown)(struct vsock_sock *, int);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..466b1ebadbbc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport || !vsk->transport->unread_bytes) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsk->transport->unread_bytes(vsk);
>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-- 
>2.34.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


