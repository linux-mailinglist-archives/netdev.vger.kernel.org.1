Return-Path: <netdev+bounces-53310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875680238D
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B2EB2097E
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF6D29B;
	Sun,  3 Dec 2023 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMIZzSnp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D386D0
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701604477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsMMCvKq0Ewiy320Ly77st5H5qzHH4bDYVOsTjx5q7g=;
	b=iMIZzSnpWDjmrB1ZYgrjowyrb8jtStYoU144SlKeZ0/HkKD32anqVzJ+VOdEHupMmozEKi
	GXSnc8Tv2FaWnmEpDFYRgCxRk4FXFUDBsTyzdg8JngW/GV4LzwH2PwNCqTVUhRJYhYPntT
	2U7vIjldKSiEhoSFRxdV5kManaHU0no=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-IrGc1WVsOrGnTJmtjYyOJQ-1; Sun, 03 Dec 2023 06:54:35 -0500
X-MC-Unique: IrGc1WVsOrGnTJmtjYyOJQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c668dc7f7bso939721a12.3
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701604474; x=1702209274;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsMMCvKq0Ewiy320Ly77st5H5qzHH4bDYVOsTjx5q7g=;
        b=NQLQBdt9gfdw/31vdI1nYjUvD3pheIp8tx3k/HhfMzd9rzNeLvApA/HWGHjqZR3lMP
         KiwfS3Pf+U1ScwpwZtGsm4GkW8llXVP6WwqZ8quxJJARvAt2Y6jnvPwv9AOY6QUY0yeb
         DlKveeY8urbxuQaizWw5hKVJ9st5h80TxpauGCjNkM8meftApoKQ26eVLFCzTwR39jcu
         gVHKuxRsOBHe5fNi7y0PM39NCGofE6JS7ruMNQj15lnEVEGEtCsfmOf9OwJbi6R/PIgt
         DwycEk/ITYjpn6iYT5f4xn4esK16+HtpheMAqo7yCNn9ioxQPNxuhK7EOkgV4fdZNmH+
         uOrQ==
X-Gm-Message-State: AOJu0YxfyWnXCb33X8q3ou56UnwOZeJjQTS5haVaMHT9y03RuB7hfJg8
	gV3Dd+N3/rxrNdqQSvBodaqEK5xvbelhMwtgOEIHF8A2tfHmtbXI8AUZGeysvOJ3jrXEZ4oGtdz
	n+yoAPpWOyRnOtSwM
X-Received: by 2002:a05:6a20:7f8f:b0:18b:5b7e:6b9 with SMTP id d15-20020a056a207f8f00b0018b5b7e06b9mr3587804pzj.2.1701604474372;
        Sun, 03 Dec 2023 03:54:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNQD4hRia5373/pCV7PCil0Ivh433RqIJioYM+uHGkbMjdSNcnMOvby2PUm57PEGvQqDzUXg==
X-Received: by 2002:a05:6a20:7f8f:b0:18b:5b7e:6b9 with SMTP id d15-20020a056a207f8f00b0018b5b7e06b9mr3587789pzj.2.1701604474077;
        Sun, 03 Dec 2023 03:54:34 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:7d6c:1284:4ab0:52ee])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b006c31c0dfb69sm6132152pfb.188.2023.12.03.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:54:33 -0800 (PST)
Date: Sun, 03 Dec 2023 20:54:09 +0900 (JST)
Message-Id: <20231203.205409.646024453190363727.syoshida@redhat.com>
To: sumang@marvell.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [EXT] [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in
 ipgre_xmit()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231202161441.221135-1-syoshida@redhat.com>
	<SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Suman,

On Sun, 3 Dec 2023 06:58:19 +0000, Suman Ghosh wrote:
> Hi Shigeru,
> 
>>diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c index
>>22a26d1d29a0..5169c3c72cff 100644
>>--- a/net/ipv4/ip_gre.c
>>+++ b/net/ipv4/ip_gre.c
>>@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>> 	}
>>
>> 	if (dev->header_ops) {
>>+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
>>+
>> 		if (skb_cow_head(skb, 0))
>> 			goto free_skb;
>>
>> 		tnl_params = (const struct iphdr *)skb->data;
>>
>>-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>>-		 * to gre header.
>>-		 */
>>-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
>>+		if (!pskb_network_may_pull(skb, pull_len))
> [Suman] Since this is transmit path, should we add unlikely() here?

Thanks for your comment.

I traced this function and found that pskb_may_pull_reason() seems to
have appropriate likely() and unlikely() as Eric says.

I'm new to Linux networking. Could you kindly explain the background
of your suggestion?

I understand that a transmit path must be as fast as possible, so we
should use unlikely() for rare cases such like this error path. Am I
correct?

Thanks,
Shigeru

>>+			goto free_skb;
>>+
>>+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
>>+		skb_pull(skb, pull_len);
>> 		skb_reset_mac_header(skb);
>>
>> 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
>>--
>>2.41.0
>>
> 


