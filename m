Return-Path: <netdev+bounces-201522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5ABAE9BC8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B085F1C422D0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB725BEE7;
	Thu, 26 Jun 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMr9qH5Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF9259C9C
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934969; cv=none; b=GJfuEuYrVheZdsXbfQCa6jLCKY8xg7wWStUewWuxl9AzV5Jw6WtHqzA2dr6PZBWCmHT31QDv5tYAskk35QZ/fcdZ6ILVo1zuTFcx58YijLBIzb3gt5GRLjmk3RZ6/gX7Pwt/I2WGXbsBRiE5MVVKkQ/BIRbaPIv101kyFjMurFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934969; c=relaxed/simple;
	bh=Zk9uNBD/3zLkNEjmpD3qCsMfvJIuuh1c2ZCwfPqI+70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4guygQDJcvn5s+lmrWanktJv764j4qOli65UCYljpjPIVfnx52r7k33SLtNI6G/wXgWJHiqbOUVQbTe/ykTjyKLEN/z8vZ+gyyzCN2rsiM+yVTraA8eFTrlREf4dAMwRqHfwx6iaaBN/c+OV5eVt0I3cGWjNXYCIV9oxqxD/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMr9qH5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750934963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hClEzZB7iPAsT1CZh0FstMmZiuvXLbKEWsZdkRZsLLk=;
	b=ZMr9qH5Y+StSspDlIg6p5TX2g+Yf5X29P90C3ECfdBf6VH2BRbJBa9UCn4XQdILh0dK0ER
	MdpJ8ikIyc6oDhBV9tdS6fPJZQ0JpxdIeHN6ZGp2qHPnds+M8WMw+KD3fajjqB1uoAq7+u
	yfStGW2HhzgTRq1ax8efCdEghahQ7uU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-GNHpPoebMs2nvPh8o_9D0g-1; Thu, 26 Jun 2025 06:49:22 -0400
X-MC-Unique: GNHpPoebMs2nvPh8o_9D0g-1
X-Mimecast-MFC-AGG-ID: GNHpPoebMs2nvPh8o_9D0g_1750934961
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso4882705e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 03:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750934961; x=1751539761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hClEzZB7iPAsT1CZh0FstMmZiuvXLbKEWsZdkRZsLLk=;
        b=ilH3qn8JSUgOC7br5wa6W1dGiSuyPj4gc9XZZoUMoGd7aXSMu6RYjDXrolXzv/+1Hj
         erm04/hNwfIpCn6QnObwiRu9ywkcBFhaadPcyYRGjTownmoSAMddZW+7jcdPZcTXSsgq
         j0NsZwl/3sxRt16X1fB/55XQ5D+Kq7/cgFu9L94MHD24AE8Tg3opOjVoYzc8LaGNyvV8
         T5rGUdj7/muzHwNjJW5uQs1N4tXnJB8W/JUn5qVFDlDkrXM9wV0DKLPDr7Ro7ROFyQ/s
         0JG4QiIqKbGcDL5XIosvqdZn8INXAerdSE2LN1RqP69zVnDpta34ijn0twZdBTj6pf00
         ulkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDkFPl0EWnwA001uX4jmQqeALE/81IjrDXbRxWChRb1zQcsSgEC0Wy98RzPp+g9iwe/lwBkcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHREDojq3yn2meXVP1aVZWRoHQEu6uCzuHwcp61uGXZTA7FgmZ
	x8wxXCp1EoUyYXE3dDMWlxykhtriwEuZhG+90EmFLd81IVhWFhcOdLbPCurQUx5qrSdQtkhyIqP
	73BajaNzgpgPvrZYuh00fqgAtol8od6XxuW3gCZO855W+tmdqOkvjHO2N5g==
X-Gm-Gg: ASbGncvpHiBIhsoDMIGRYgN5X/az74nJPEc0IA7hUGXRfD7qJ5rlnvskQoNxm3hnoCu
	4gu2J0e4+y6eLCvprpQyXiept1hZKsdaAzf/cYS9wR4+COeCnJg1mkQXSIRVusrzZN9NS5Y1HC5
	gTi5xGx0y+qQxqgc3eo8Pnvq7yvBW+7G0vz3zhWrKc3qPhL4z4x7kxEk7Mu3ONoH65ZkyyEniE7
	c+hAK7o8TUnuwYsBVE+fcLCZFy0+LK/zQZx0hzNwvG/szDGAcgcpJqS9LifPkdd4OVK6rGmvUXZ
	vxJAT2GKL7fpVVodggJ9xmuh+y1Lfmclxix/B/HYRZvzP2DhfeHUxooYQFgsmrTsEOyRmA==
X-Received: by 2002:a05:600c:8414:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-4538acfd410mr16688865e9.7.1750934960925;
        Thu, 26 Jun 2025 03:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw8yRKgKYEs5+g9AWNThiUunldNOI2Tc8JO6kDN8yD1L5b2b9siy9ooGV55tvobGHLCrFHqw==
X-Received: by 2002:a05:600c:8414:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-4538acfd410mr16688595e9.7.1750934960508;
        Thu, 26 Jun 2025 03:49:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4076ebsm15506555e9.31.2025.06.26.03.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 03:49:20 -0700 (PDT)
Message-ID: <9829a19e-0f19-46e4-a007-0e943f1fcdb8@redhat.com>
Date: Thu, 26 Jun 2025 12:49:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <f1511ff00f95124d1d7477b0793963044be60650.1750642573.git.tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f1511ff00f95124d1d7477b0793963044be60650.1750642573.git.tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 4:18 AM, Tonghao Zhang wrote:
> @@ -893,6 +909,8 @@ static int bond_option_mode_set(struct bonding *bond,
>  	/* don't cache arp_validate between modes */
>  	bond->params.arp_validate = BOND_ARP_VALIDATE_NONE;
>  	bond->params.mode = newval->value;
> +	/* cleanup broadcast_neighbor when changing mode */
> +	bond->params.broadcast_neighbor = 0;

This does not look enough: it looks like 'bond_bcast_neigh_enabled'
accounting is ignored, and should instead adjusted accordingly.

Side notes: please include per patch changelog to help reviewers, and
when replying to reviewers comment, please properly trim the unrelevant
message part and separate your text from the quoted one.

Thanks,

Paolo


