Return-Path: <netdev+bounces-198667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D42ADD032
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFF63A81EA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DB3202961;
	Tue, 17 Jun 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd0L0RU9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDC7081E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171177; cv=none; b=qUFx3A1oVSFziW6qGYgQg9gwfqx6cys138evHXFBkkWrvrxGsVBMtGQCBcrJ+kaKYXOzdoQ7heb172lUM8TDdaQtHUGE4zvKxd4Qljma47zFtRPl8/ejpkqj43S47KbEHhlhpVZjZd2H7W4DSGkympTwVMOw548xKyQ1ld0gouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171177; c=relaxed/simple;
	bh=P0TmBh/SuinKvkwSU9wHk7cmF2i1xnwgWli/nKJV0Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx87SdYfa8eUi2jKl/gdhzXH39tHckoafc/FT5I/ruN5v5y6MTy5sd2OpVGeKtd3+uJwCIdOyjMcxnXXQdfNrRVj7kei3o5TkaTz+FHZL0YgamrM5O0CjycyXOUrwRIgaB9gScYDyPZukapPFjxTJkdfN/CRf2jVpmVICtmTVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd0L0RU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750171174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
	b=Dd0L0RU9WSfnIGyKWY/8gz92slapCugP0zHXjwsN+Gpg2aSkiHPJvJ/jtwoPWjDjGJ4MT5
	hL4gCzj4PCbyYNJcPiH+72TYVX0PwCFncQ7rWWirghFB+qDzrpXaX+ZP0HySmI2nygoY+/
	BhfHJauwIR023Slt4qoiMC1jR0eRevQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-8u7N1NovPFC0qbkwLpBMzg-1; Tue, 17 Jun 2025 10:39:33 -0400
X-MC-Unique: 8u7N1NovPFC0qbkwLpBMzg-1
X-Mimecast-MFC-AGG-ID: 8u7N1NovPFC0qbkwLpBMzg_1750171172
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d244bfabso47536295e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171171; x=1750775971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
        b=KnyBEqRwnMOLd6q2GTYI4r00zhy6guBUe+3+VokZwhPgDVb52dv7nD+daXFPFs6fev
         8ntADuIi7DMp6UPkl2yAH/fva4z3vX7FpfETIUa4TKUzabOoOx1lEAxp5/ErKNjlnn05
         /vxcgCXc3x6pdIBUFktGikhLuLju5ugf1yH4MNixwPpK328P4qdYvd+Sy/a0waR+JDZo
         Ciyzhm/SHQLAf0JcB+JbMTm0w9FB63o18AWog/4h1X4hedNSGFaW+ioe6q1GlF0GqwjR
         cBgJcVpjghWM5c+E+e2G7m0WEUXed32I2DIsLJ2lTTCwYLtl0ha7FtvcYu8/VFa8+Dsl
         Q0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVPN0TYsQEKgXzQykAI9bn55mtRrdkWj5lXpAKeZxiF5+cDxnqGsOUz6HX5eJEj3CnIjDe8jSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+uLsckGMPYNaQ7tBllLZ/jwmixIDjHniHHfh5Ym+vNWKraOp
	PwBD1MkkQKMEWFjsNrMOQXUm+XNAU1kJOFB1Ff078j5akVwvUviD3zpt5cZ18Sx0bLFPM8m7Dnu
	YjEQNq88KINlPvDVlQkgO0xUu1BzbVbJz8+lrlBJHKgs21DV2BKi5h5GB2Q==
X-Gm-Gg: ASbGncvfn2i5S8uZjYFrsDxlf3jI3P/ERBuM7GxAis/3v58fjXDY+3xpq23onMAFPd9
	amcQ+iO4O1wjPxNALdbninkOVX9hrjAMgH7xq0s1mxLRxaHuIgbmZP7v3zsiRmvg0DtHMtHs2kH
	7GRWS7YRfmUCBjTm34JH/vu528Ip5nuQ7dMLkw1LAgGqgxIEtmk/vV85dFi0roLNvAvs6s1Negk
	g2FG016C2fJsvWGcgVNx9IQTQd/q2vDe5gSTByphm8N9icgr7lvevsPU4Ffuxg6FyumxWTGQv1K
	OOrrAZv+YWZLD1pGnQXGW4xw37tM
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71096245e9.32.1750171171557;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNxFUr/RsjSCEdxIvQ1nYZxg2/GHtiJcbK0+y2FBpHGRW3fR6k2TfEm1PQ2vYeyp/yl4Cmrg==
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71095955e9.32.1750171171029;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e241b70sm175740145e9.18.2025.06.17.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:39:30 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>

CCin hyper-v maintainers and list since I have a question about hyperv 
transport.

On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..bae6b89bb5fb 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
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
>+		n_bytes = vsock_stream_has_data(vsk);

Now looks better to me, I just checked transports: vmci and virtio/vhost 
returns what we want, but for hyperv we have:

	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
	{
		struct hvsock *hvs = vsk->trans;
		s64 ret;

		if (hvs->recv_data_len > 0)
			return 1;

@Hyper-v maintainers: do you know why we don't return `recv_data_len`?
Do you think we can do that to support this new feature?

Thanks,
Stefano

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


