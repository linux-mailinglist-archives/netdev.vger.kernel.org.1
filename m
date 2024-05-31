Return-Path: <netdev+bounces-99750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3668D633F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF8B21BF1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60063158DAE;
	Fri, 31 May 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxsCfV4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC26158D8C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162894; cv=none; b=XC0mxF2CeBCNUSxGuBX31vZ/pmNJ8Z4NfZInYbcaAhc/n16Vx5zZCUnQPGt4TyjOTqbTXE+8iBmEgwrHqrAp0Ip9CrecfF8O8gS/6JP/SBCmMrdqd2CvQ1l2BSsUw1zw7PzbVFkiTG/vOpLafdLmy/vUI+vf7Z86wKMOh8VkN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162894; c=relaxed/simple;
	bh=Qe6iPNmZyF9PbqeWNYRD2JXQ9U03MTdbpv50ax+t/hk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a+y+pxnltdmoxehvVpFqREOdDutLy5BrWZY5/3xPdNyTCRsN/oO2bbkllmNo/KR8MsbZgq6dzDnHzMQxVT9LuscJ6JHLpKNX/Yfwwmv44hjvunFan2fszdAqdfppZSXTv7r4oTp3GCokBsJ3bb7YmyeYBffdFFWDrIEOI01qeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxsCfV4c; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d1bdefedc0so1085043b6e.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717162892; x=1717767692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53NT90nK/rQ/MNedY8JCIK8AOZhWYEd9h5PFD5XpxyU=;
        b=XxsCfV4cgaUF4bWeua2vIDiL0o4jCj79Tzi642oPc0w7i0gHkby368xS8t8aBW+7qs
         HSq3Xuz3X1d1FZXnKLFO0krSwAfnWNfLbp64MwGqHKbs9bd4Ti6curlgo01YXWYcIB5+
         vFrDvYaArYlcVNO8FUitbHG8iac9yTb4K/MKxgIRaBG8DyvNEqVjPpdvC3huON+VIAdg
         PifabCoBzVPDvcTzA63CqHCWu6HgkUiBuFxMk1Q0KGhVjODexpMF1zpmVWzacsWPpYDW
         m2kRtEWR9plbUwG40R7WE76A2W2ZALkXKG5GIcjot/2oEm3aBPhtutCBgrbxkF4dvKPk
         eopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162892; x=1717767692;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=53NT90nK/rQ/MNedY8JCIK8AOZhWYEd9h5PFD5XpxyU=;
        b=YuZ6Hb+oecF831+BTE5bMtvrlX+iNRSEAtGUbu4/mVYIJL80vKkhNlNawNtGzQpXi0
         RcrMaTnkHd+PBYB1ynvwylEGCrmzhF5CdEXCbLFQagkuqnHnG19+n+akCBvKuHw4wkjI
         UpZTfmvqiGj75vC08+6wc8Lcilmc4RIRgOkqY8sb0I5UU3x9sftVp5fetn5qm0W2DGnd
         kNhyVhmTzUCgy9WvToFaTvRHr+cXX41Tssg8FH419kkmlZbaBBCIs0nsIZ1YcnCMuq2o
         pqX0/Q+4Qic/WukK3ayVWjUH/UaCltu4fOXJokVr2GaMw8zzKIAlKcOMBooCkgaBbsQ5
         L+tg==
X-Forwarded-Encrypted: i=1; AJvYcCUfLYMRB3yo0iSXTnKJ8SCPp2MHiHHpGnqbDlCgw0k6cusXyhps9zbkWlJ0PBhnLHW4vAl1B2bGoAgIYKVxILf3v1rPa5h7
X-Gm-Message-State: AOJu0Yxz04QdmUo7yf4Fa49JRarT2tkorLefsav/NI/RSR9GRmm8xlji
	2rkhblnkYA6JWbfS3GOYSBhupwFNN7DKloyd88vcMMr1r3xrc9J7
X-Google-Smtp-Source: AGHT+IE7yMTgsH5ODanjs+vRlfbfg0/F/j+h/ZOyGYRrc00sXZyuCTKmgGy3M8gqqDyGx1aRGA2SKg==
X-Received: by 2002:a05:6808:1491:b0:3c7:4d4e:efa with SMTP id 5614622812f47-3d1e31ead0fmr2761496b6e.0.1717162891841;
        Fri, 31 May 2024 06:41:31 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73fa69sm6601726d6.19.2024.05.31.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:41:31 -0700 (PDT)
Date: Fri, 31 May 2024 09:41:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-3-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail
 skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> TLS (and hopefully soon PSP will) use EOR to prevent skbs
> with different decrypted state from getting merged, without
> adding new tests to the skb handling. In both cases once
> the connection switches to an "encrypted" state, all subsequent
> skbs will be encrypted, so a single "EOR fence" is sufficient
> to prevent mixing.
> 
> Add a helper for setting the EOR bit, to make this arrangement
> more explicit.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/net/tcp.h    |  9 +++++++++
>  net/tls/tls_device.c | 11 ++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 32741856da01..08c3b99501cf 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1066,6 +1066,7 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
>  static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
>  					const struct sk_buff *from)
>  {
> +	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
>  	return likely(tcp_skb_can_collapse_to(to) &&
>  		      mptcp_skb_can_collapse(to, from) &&
>  		      skb_pure_zcopy_same(to, from));
> @@ -2102,6 +2103,14 @@ static inline void tcp_rtx_queue_unlink_and_free(struct sk_buff *skb, struct soc
>  	tcp_wmem_free_skb(sk, skb);
>  }
>  
> +static inline void tcp_write_collapse_fence(struct sock *sk)
> +{

const struct ptr?

> +	struct sk_buff *skb = tcp_write_queue_tail(sk);
> +
> +	if (skb)
> +		TCP_SKB_CB(skb)->eor = 1;
> +}

