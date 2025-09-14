Return-Path: <netdev+bounces-222841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448FDB56756
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD923BC6A0
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8522333D;
	Sun, 14 Sep 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh/TIy0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3B2147F9
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757839920; cv=none; b=ns4n6UPPoOzrhzgwiVdoNEiSBxiJX9jLcjo7D5A6Goj7HJQPAVk5XYFDeF7XDiPOtKIuQIPJxupYKImbeHC7/5z0SGTOkAAkjRzq1onqGWe9FZr9prNNzTqC2EW+OvrGfipc8VDSRCk9vexV/PgQJcizxe+wRDOQCu5BC5NV5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757839920; c=relaxed/simple;
	bh=pu0GrjYYfzlRG9ePNGfLSB1xjWRol2JFlYQ+Bg4jd5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=EcBRcMCIpHHwmhOPcrLG258BvD3xsD7DbdKF0tv447b+4rFWRmAPjtBppdAFiVBamIDRi9ynPS64sTfW992kmYBsbeGeIC2czOLfXp4DB8Q2CFo56WLEGqiIhge/jXchkWWC9eRSx8+mvmLkinf5PIS880sghQh0AIwPvSUVFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh/TIy0Z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77264a94031so2377014b3a.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757839918; x=1758444718; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xYB2/4f3FmpIxcEv4UNcJMbm9iSz8Dk35nkey4DobA=;
        b=nh/TIy0ZC+LHXN0xeF8ymZPWBOzecpqfCtZLHmKhRNthcfS2IaYYp0pu36JWxizD8Q
         GC4BysKgm7HNivJvOb8SaL5CqWR6REy27rbKezKw8FwfhXt0pIPSZj5+KPPyliTqfAHR
         /xO/kKMNfAmcEw1gateIfAb7T/V6OzI6jPeQpFYpx0h+PO2CjGVIdnaOe0wPfsAM6Q5J
         LnoQ1pULLfrQPoO0HtOVgqRfQO7lGR68zVXK+v/uqzg2c9aWNE95AEICT9H0qO86HN2P
         Gqot6QuwMUJJiAvAp4YrHk7JWrL1IoD7IO6dKFOqtkgCiA409gg4qv/3XjnNpgttcvqP
         wwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757839918; x=1758444718;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xYB2/4f3FmpIxcEv4UNcJMbm9iSz8Dk35nkey4DobA=;
        b=SutaYJvxs5k0W8ZVvKsMv8L4D0wdMtbuFjJFJJJ1iAar/LDhUOXA7+u257iwNyuG6O
         Fz3hZjdcc3+YOcJP/spwsBtUSESxPcz0F0+bp3WHCX3bROnaLxMO33i8k3ky50eHgoZs
         N/t1MQFS4SgRJzuDTV6Bh0FKuSjQJ0GEPJQiu6GzinrizZUvT4pn5I13c4Lv51qBzrrF
         xSaDmMtfYtrFRioeZGAeLiUDxUt/iq6/BbQBZq9k5Z0ZKEZwJFVmlAmK1gA5lz/I9V2N
         6lz+0nLUzjDflpD8DMlSb2p+93XxpfNi6e5a5+D5kYyWxmwBOHadcFmJs/p6AXOQx2wc
         ySjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9EYBeYv/2l4H3pmziMV0U93UvNE8KlIIq5sLxN0SRwvGriX0jom+LyPrJ73vwDgooxJDe2Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAemOQ2sgXmFMGrxFChoiEFRDmtrVDjhQhuWX23Uh6TaFcTQE
	ttW++id4UqkNdVOWUuEbE9P+eaOp7LW6+5OyUTwf82qYc23eiOqYq0pp
X-Gm-Gg: ASbGncvztdDX/Zo0pYnUecY3eTPnp1kZor2mH1HPjxiGaZjht1FLTngCSG3jpRmiSi1
	koR4EEM3Q761U2OA34FDT2+ZMSRNzjBnbelkLItUpCWI2CtXCajETsIx+pAFIFJP3SMMkCq+DXI
	2jqjbGr0AbuPw7BhesnDNHvKE5d/VHxgfTFA/EEeNr/M3YsLWhFtItTOUdCGAF6LPGd98Sb/XzG
	LJYYpWU7Q0FHIeKKwDVDMGbS/VW8ZNW6yb10ERuxQM6Pc82RCnZHY85B133yXEezyG1V7XvAZJO
	bP9z9JKf3YMRRQQny5MQPgWQKZArmhLfKSsADUIqlTIxI8fLa9ygClFtt/RkSijsoTH05l0K/Z2
	Obd8pk+b756ithx1EgfQsZSuuSHA0h5RLZm3Ube8+aLYseGVNgCG3DUOqdsFxNoU=
X-Google-Smtp-Source: AGHT+IGBCGF/62swHad3RbhGMxjfqONlAZq9ze+mDcHFiwssxclDQ9ZkAqX+WR2tZzKT+yzYuyr5Pw==
X-Received: by 2002:a05:6a20:a10a:b0:24c:c33e:8df0 with SMTP id adf61e73a8af0-2602c72030emr10783930637.45.1757839917945;
        Sun, 14 Sep 2025 01:51:57 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cc21sm8937206a12.28.2025.09.14.01.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 01:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 17:51:54 +0900
Message-Id: <DCSE8SBC2ZD1.Z7BOJYSEIELY@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: handle copy_thresh allocation failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250912145339.67448-2-yyyynoom@gmail.com>
 <57d58296-c656-4dab-a2e2-faf2452fb4de@lunn.ch>
In-Reply-To: <57d58296-c656-4dab-a2e2-faf2452fb4de@lunn.ch>

On Sat Sep 13, 2025 at 5:39 AM KST, Andrew Lunn wrote:
>> -				skb_copy_to_linear_data (skb,
>> +				skb_copy_to_linear_data(skb,
>>  						  np->rx_skbuff[entry]->data,
>>  						  pkt_len);
>> -				skb_put (skb, pkt_len);
>> +				skb_put(skb, pkt_len);
>
> Please don't include white space changes with other changes. It makes
> the patch harder to review.
>
>     Andrew
Thank you for reviewing!

As you mentioned, it indeed becomes harder to see what the real changes
are. I have a few questions related to that:

1. If I remove the whitespace between the funciton name and the
parenthesis, `checkpatch.pl` will warn about it. Of course, I understand
that we don't need to follow such rules in a mindessly robotic way.

2. However, I also read in the netdev FAQ that cleanup-only patches are
discouraged. So I thought it would be better to include the cleanup
together with the patch. But I see your point, and I'll be more careful
not to send patches that cause such confusion in the future.

3. This is more of a personal curiosity: in that case, what would be the
proper way to handle cleanup patches?

	Yeounsu Moon


