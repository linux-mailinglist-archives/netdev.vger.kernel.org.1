Return-Path: <netdev+bounces-157308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB5A09E69
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC66E188AB0C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A221D582;
	Fri, 10 Jan 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="BKw1uIFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D6218599
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549537; cv=none; b=QHcn5n1vxvxvcBu7ntiK2xxvo66QxbW96HxQS6awXCtYbJFG7enJ2EAzjfWWQOVFvR24aOtub+i/usqNaD8i/tTw5MDE9Rrd9V0pqW9uRdpxL6isYqeumCVRqMLE39IJBIlw3Y3OXtpzgcPl7tGXT5xy2+pQTwzGDqTNBrLN74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549537; c=relaxed/simple;
	bh=JZHqlk+65oHwniuof9YMax5W0VcsEzP6KM6gcWIovm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3ARgyT2eksi3Y1sysNVLOu8jpkDJhH9ABc7cUxslv/wuGagT1Kuo1DNvufMJAqJR40S/I1bZyNIcJBcg44RRDpI/mpXbdTZsNPs2CGB1ylHvTmPE7ZVq8x+RmZD3MCQ3UoAgWl5gUvX0YB3nzWuPj/BT5uMObXzLiUQmP8lPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=BKw1uIFh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163b0c09afso45919785ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549534; x=1737154334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbi6CHxANPrMQarVV/c3DpvaHRVNCAuF1gxqd1Fssgk=;
        b=BKw1uIFhlO+laccxuFETQVE/E3WqKt1hqIZ2kJSRWbXFbcKOuCoPJfGJhTWIrKSnOz
         tiQWY7z01efC6pZCDZmsuRGF4UU5jjoY3s+o2c+5U+vfz9wPc/x38IminR0gDZvWZbyj
         2oJM/e8v/VFARqsE6CRPna4tfWrh5wzaPb1eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549534; x=1737154334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbi6CHxANPrMQarVV/c3DpvaHRVNCAuF1gxqd1Fssgk=;
        b=YXK2eWyeWmRoVcVoAtFwWWszm/xFvuJImIBFA3pkbOcKRXP/k4udyMB03ZeSu0yX4z
         DeBGUJQoK/TBD8ZekoiSyTDpvSjWLtA1rzOj3lC3Woi7GqehTkFp+Z28vo6c7w93Klj+
         2oqieM3qqQZgIPb11AMxOfb0vzQIvrcAaZxwRGQLVDJGYdxWEPw+Hfq9jSWM15ghu619
         MNa2l77r27ZC4biouU4dPKydr4wnQa65QIHg3lSANUToo4FC8F9CzYRDJbq6dnCNf1No
         WW/3s5V3C4wUYzYJVQ5S1IYCcwYnpv2dtd91vu+aCmFIyu0/n2ONWl6xl1t1rXhA/81f
         R7eg==
X-Gm-Message-State: AOJu0YwbpvJ6Ww35qvSfVCYwyxiyg+SJFiy8kKwg8pFWCYMQ7ahgYTNy
	HbqR54oPOGkUQzncqZ7gcJqDKf2Ekv12PiaQURCVj1g30NCTrypte8aKAcTrtWk=
X-Gm-Gg: ASbGnctKqEQ3Ovgx+8uzJyMiI38GhgU/ZDiIXEVBL4+h2Y5xsl5vSJ6b5/xOvfw0Wj5
	tLXsSlS/8wOvqpb/q0blV857aRDId6RENRS8TLyGwLjkt/FztWFJMDekkglN5d7SFAjOisdXxYs
	Ne/pydlQ6Itfjqf2iovZneMIh42m5T86owQRsO7vbfbtyWwjn/U/yCMtD29D6Ta8zhlK8AhFSwI
	zxzWD6Ek1yXqrPnpx8K/mrXIcBlt50QymSDXLaASTZUc3v6F2mC7YK/+rLc+Qc8RFECKg==
X-Google-Smtp-Source: AGHT+IENF/FxDNTliDs2DD6iZam46B2U64YorZ5+dfuiE11gQj49C7rnn2z29pL0pKaqTcMm+AS1GA==
X-Received: by 2002:a17:902:e84c:b0:215:4757:9ef3 with SMTP id d9443c01a7336-21a83f338b0mr168094885ad.9.1736549533645;
        Fri, 10 Jan 2025 14:52:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f4f3sm17847985ad.31.2025.01.10.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:52:13 -0800 (PST)
Date: Fri, 10 Jan 2025 17:52:06 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in
 vsock_*[has_data|has_space]
Message-ID: <Z4GklsPT0bP8cLac@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-6-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:11AM +0100, Stefano Garzarella wrote:
> Recent reports have shown how we sometimes call vsock_*_has_data()
> when a vsock socket has been de-assigned from a transport (see attached
> links), but we shouldn't.
> 
> Previous commits should have solved the real problems, but we may have
> more in the future, so to avoid null-ptr-deref, we can return 0
> (no space, no data available) but with a warning.
> 
> This way the code should continue to run in a nearly consistent state
> and have a warning that allows us to debug future problems.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
> Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
> Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
> Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> Co-developed-by: Wongi Lee <qwerty@theori.io>
> Signed-off-by: Wongi Lee <qwerty@theori.io>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 74d35a871644..fa9d1b49599b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>  
>  s64 vsock_stream_has_data(struct vsock_sock *vsk)
>  {
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	return vsk->transport->stream_has_data(vsk);
>  }
>  EXPORT_SYMBOL_GPL(vsock_stream_has_data);
> @@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
>  {
>  	struct sock *sk = sk_vsock(vsk);
>  
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	if (sk->sk_type == SOCK_SEQPACKET)
>  		return vsk->transport->seqpacket_has_data(vsk);
>  	else
> @@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
>  
>  s64 vsock_stream_has_space(struct vsock_sock *vsk)
>  {
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	return vsk->transport->stream_has_space(vsk);
>  }
>  EXPORT_SYMBOL_GPL(vsock_stream_has_space);
> -- 
> 2.47.1
> 

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim

