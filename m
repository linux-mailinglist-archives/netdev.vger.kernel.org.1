Return-Path: <netdev+bounces-53314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D975780252F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB5B209BF
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095A9154AC;
	Sun,  3 Dec 2023 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqUtv0NF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE4F2
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701617907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQxOP9Pb/F6NHproH1Uh8UYxD4u/gyzAwpumhp9pq4=;
	b=IqUtv0NFHDnc2ziLUGJDgLu2F4qbkZUXDe599xyupao2u0amtYeEK33Xw9BJE8kTik/cNz
	BqbX7essc0ydXVWsVkoudxlHxjfR80So1cBHr93ddx7Q+aEqOW1OfkgtPGTBJCsEXAP8bo
	oTh7xs+XuTPXXGyaGWP3w/6WCR56a/Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-FuIW5AJuN1y4y5rSzxMJCQ-1; Sun, 03 Dec 2023 10:38:26 -0500
X-MC-Unique: FuIW5AJuN1y4y5rSzxMJCQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ce47f7d744so107059b3a.0
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 07:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701617905; x=1702222705;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pYQxOP9Pb/F6NHproH1Uh8UYxD4u/gyzAwpumhp9pq4=;
        b=j6DeVNVhU+zUlR4BdhMikUbELJAgFCxpNqXLQqpL19R0FENamaWHEz2KSRbG0brkA8
         vGTePlHSTTe0KOslTl4luPDy/XrAeTo8vlHUz3JGnzzBbga1+cD4UWk7v7bo2FaRIqGI
         qTiXDJT0JeEZAOF6/oezyC6/7rmBq7i/WqRpxCZf1peHxA+tAfZHMcozg7jRdYaOQ21L
         aQWH1AYpEyHsEXajt3BuKQyXRuIHKQ2WwOZXzic+QRqLy//3xfTG0XrCQZxDC2Nijvf5
         tWlSCnTtYuCaW4MjPkfNUqpdVQl5GeEGC+ZJXwqaCbIIhiJ3FrgJCHysKHA20MCg+J1r
         tCYg==
X-Gm-Message-State: AOJu0YxOEFfMm1vZaIrDxKYEuViWgdBpCARjQ5PLlmw3JUCgj+BsPtVC
	qnIT4JBH3gb344dWQbgRodK7QX4yKYpTsChgjFdsRdPrv9pbTfPxVfyr/YX7amc3ZwHxmKOULuK
	tKouQmcTS9sD/Ikrs
X-Received: by 2002:a05:6a00:982:b0:6ce:2731:c236 with SMTP id u2-20020a056a00098200b006ce2731c236mr693785pfg.37.1701617905333;
        Sun, 03 Dec 2023 07:38:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGou+fj2OrEkNfHTzexvyH52JZHlxwieUtPewwjCMmxRNdu9UXfHcNAzyl51tOVvTcSD/vPSw==
X-Received: by 2002:a05:6a00:982:b0:6ce:2731:c236 with SMTP id u2-20020a056a00098200b006ce2731c236mr693770pfg.37.1701617905019;
        Sun, 03 Dec 2023 07:38:25 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:c5d9:5358:537b:93e4])
        by smtp.gmail.com with ESMTPSA id t9-20020a62d149000000b006cb8e394574sm6372961pfl.21.2023.12.03.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 07:38:24 -0800 (PST)
Date: Mon, 04 Dec 2023 00:38:19 +0900 (JST)
Message-Id: <20231204.003819.166258252408944062.syoshida@redhat.com>
To: sumang@marvell.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [EXT] [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in
 ipgre_xmit()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <SJ0PR18MB5216005BB27035DE7C37CAA4DB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
	<20231203.205409.646024453190363727.syoshida@redhat.com>
	<SJ0PR18MB5216005BB27035DE7C37CAA4DB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 3 Dec 2023 15:17:09 +0000, Suman Ghosh wrote:
>>>> 	}
>>>>
>>>> 	if (dev->header_ops) {
>>>>+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
>>>>+
>>>> 		if (skb_cow_head(skb, 0))
>>>> 			goto free_skb;
>>>>
>>>> 		tnl_params = (const struct iphdr *)skb->data;
>>>>
>>>>-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>>>>-		 * to gre header.
>>>>-		 */
>>>>-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
>>>>+		if (!pskb_network_may_pull(skb, pull_len))
>>> [Suman] Since this is transmit path, should we add unlikely() here?
>>
>>Thanks for your comment.
>>
>>I traced this function and found that pskb_may_pull_reason() seems to
>>have appropriate likely() and unlikely() as Eric says.
>>
>>I'm new to Linux networking. Could you kindly explain the background of
>>your suggestion?
>>
>>I understand that a transmit path must be as fast as possible, so we
>>should use unlikely() for rare cases such like this error path. Am I
>>correct?
>>
>>Thanks,
>>Shigeru
> [Suman] Yes. Likely()/unlikely() helps the compiler for branch prediction and we use it mostly on the data path.
> But I cross checked that this is static inline and the function pskb_may_pull() already have likely()/unlikely() in place.
> So, you can ignore my comment here.

Thank you for your explanation. It is very informative. And thanks for
the review as well.

Shigeru

>>
>>>>+			goto free_skb;
>>>>+
>>>>+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
>>>>+		skb_pull(skb, pull_len);
>>>> 		skb_reset_mac_header(skb);
>>>>
>>>> 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
>>>>--
>>>>2.41.0
>>>>
>>>
> 


