Return-Path: <netdev+bounces-121784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2195E922
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DB28247C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075D136E23;
	Mon, 26 Aug 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drDeuFGN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032884037
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654273; cv=none; b=B33CFirL0tdDtZCzN3l9sxLqVKj6hTujXBg+4x5ksCjTKrPZJpNuxQPrBfN7Rr9Cfk0QCeuW90D/lz0EQdV6K6V3SGymaG5j9BY48Yhbx6GyWag6u6jBT4pQCzfb51qNOGiVqfdC50xDZU8R10oNpJ0aTv1pWmuY2YdogPYhnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654273; c=relaxed/simple;
	bh=tIqjP7wkBcetb1vT1IM+Khjh2UxNrkOVUPOtgZvtKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8Tu0dziAHm1DXGZBpIhb1VLOXOaZvC0vlhKEt4w8JnFJov1tVvrxsRqGXlnw1L8/pVuLUKZvkkLoyu0cFVYVz1jYzw196vZVn9BP/SwQ6Sk0FAGfPbHHV3ZXWJx8/N7ZJURJiP35ZLJraA3hG1eA+KomqenOaWHQCEiLTVWDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drDeuFGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724654270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45FOD6KTcPecHM5IOLAynL+DDZ1FnLvddcnxAZcFSfY=;
	b=drDeuFGN4Sc35CDeUZ8gpsXlFBC+4ptp7jjzVbb+kV0HBXrrU4Y0ywgildqtIwyVMhFvuN
	ejk9usHxKtLL/OGFDj2wyHVRdAiG5fFcAc4KNLWIFawMFWQVWqaQZOPSpXoTr6oFY7VV3b
	G5I8Te+D302YHrYmNPlVIl4awVg7yyI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-eOmEtaOhNzSg0MroTcXSVw-1; Mon, 26 Aug 2024 02:37:48 -0400
X-MC-Unique: eOmEtaOhNzSg0MroTcXSVw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334656d5c3so3800434e87.1
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 23:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654267; x=1725259067;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45FOD6KTcPecHM5IOLAynL+DDZ1FnLvddcnxAZcFSfY=;
        b=hZDySerFRyHfOGQa+jHZYMhi2SYmZIXPP7NVwn+mocWPhzJT5b/uJIpoExEv9+E7EI
         s+TUO7Y4xc4e+1QqpmqtJL2nSldEYd973cp7ga8YvIfBhnlr3aImejCvI3dT9ydU4hyW
         nSpfwpDN5nbChArPlbh4v2gTKH9s5hQWoi5CShIiXQe9PkGMWrlGjUhzY2F4CDQZWRNN
         GC7NWmVi31OfcPk6lxGeDa7iXA6HkY+ak/cxpFHcU+Aw8JC5vmvqhF5FOV7AZndDP6QT
         tjoN7ShezurLKd80QYg3xVa142QdUvr6oGAueqa4/E7vHnabI6bxU7ONcYK16rIi8d4c
         9imw==
X-Forwarded-Encrypted: i=1; AJvYcCXefG8zj43mYGR3ETQrrmPeXyRRNT0T19D2HjwldpYPUuMw1Pp3fLpuOl3Dye7JhB+wBFA+Oo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywldz+nhDUZJ1CdfGUJaUuVyOuVGv1EiajUAEYDnCEtWpaB9QOP
	x+ZCRaPUrfoj4g7FYf1Zi2elmyAxRz6ITerJArzwppj6PvK2Jevy4va4bjMjHi8a6b5zW0X8zzp
	Aucwwwzod9x/gXs2/cB00svStgSpk2tosid7c9sP8j7wkuxVlbDf/RA==
X-Received: by 2002:a05:6512:3191:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-534387bc61dmr5752307e87.37.1724654266744;
        Sun, 25 Aug 2024 23:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHybNBZvXvGT1JAjBIuJZk4lctTsFDvHNw8UbEsu8wiVnEjhBh18CnKX34zVm4ZL+xWbkh2ig==
X-Received: by 2002:a05:6512:3191:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-534387bc61dmr5752279e87.37.1724654266155;
        Sun, 25 Aug 2024 23:37:46 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436badsm622206966b.139.2024.08.25.23.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:37:45 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
 dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, dccp@vger.kernel.org,
 dev@openvswitch.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 6/8] net/openvswitch: Use max() to simplify the
 code
Date: Mon, 26 Aug 2024 08:37:44 +0200
X-Mailer: MailMate (1.14r6056)
Message-ID: <B4FCA95A-F6E0-4610-8671-780A2015C5F4@redhat.com>
In-Reply-To: <20240824074033.2134514-7-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-7-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 24 Aug 2024, at 9:40, Hongbo Li wrote:

> Let's use max() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
> ---
>  net/openvswitch/vport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 8732f6e51ae5..859208df65ea 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -534,7 +534,7 @@ static int packet_length(const struct sk_buff *skb,
>  	 * account for 802.1ad. e.g. is_skb_forwardable().
>  	 */
>
> -	return length > 0 ? length : 0;
> +	return max(length, 0);
>  }
>
>  void ovs_vport_send(struct vport *vport, struct sk_buff *skb, u8 mac_proto)
> -- 
> 2.34.1


