Return-Path: <netdev+bounces-112534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1F939C47
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A53B22320
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B614B963;
	Tue, 23 Jul 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ZmJs2Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8A13D537
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722224; cv=none; b=qm7Ftaxd+m6mhGlolUkkz0m+BFXQ3FjjAMXnofQOhTtv5FJsXPvVx0l9BYxuWqWcnEVA/cxcpFW+W5Gqsi0jY24V5r4sKB+xB/ThCDjHaI03+UYPr0gGsrg4qQPQFUOgH2QjXofclomXvc0hBZyKP3IjkV73JcUjRbIDul6tQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722224; c=relaxed/simple;
	bh=fr95nzY+lzdUkWWatT97wPFAB2Gx9SYE2jl+ZxB5dKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNYeVPK3eF5h9hCkjZ6Gp1jO9LrSnhPnMvGFcILNaj8ckdwMr8kXXzvdIA+b57W/1lZ1bfe6kpZdgKzjEDOgiZ1WwdrT3oTKr8qWE0HHcdSm2Zko5Rq1aG7O8f0ntty6xwkV3xPwBx/3a7xcb9YtOxCI9iI4nNUDUOeiVlrZIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1ZmJs2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721722221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
	b=R1ZmJs2Yvck7hnRRxF2KZ1N3nsU8vn23tlwfYF81LSslAa1oijWDpoJVrGyX8ReOCanLLm
	yMoW3Dbu6og4qYy/y+sGAYVGkSo9tsNZAezXFzHxEsbJ2KVZUNnD6WQjDYlcKblnmdA0nA
	dnSZpT9dgdFihcHQpM4D5jLoNn3lZ/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-d6DzwxmGMcKikuuw-JcXTA-1; Tue, 23 Jul 2024 04:10:19 -0400
X-MC-Unique: d6DzwxmGMcKikuuw-JcXTA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3684e48b8c4so785130f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722218; x=1722327018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
        b=kzIJkkj5WbWQnCO14xBmHAidPfSc0SuF8KrSWobP5cypuiOsCx/jcClL2uYDGzhuKT
         89VK1jt1mLUj6LXZb2dCX06oYTuhJFl2tJEiCecCSyHe3rhQGQQ5RNYbsUWXfbA8WkyI
         XHIWGKzH11daoxwaNJ+iBj0CwbgCc/TIZXTDoQ0IRIivW1KvFJFtvXAAXVZoHimn+KU6
         bZOgOcEF6RRDrHMNjxzr/sbqkh34nPOGWLri7wR3zkyjIdO12prpOD3Hj4CUrGK5K5lK
         Of9HBINpLhVuqYYwng+riEvJ3YS3F8p1OOTT3GihiTB3G3BQqIGHeb21yFV8eWbFc2CS
         0LwQ==
X-Gm-Message-State: AOJu0Yykr7OpL5gKKYMyT/SANOgc7876RxVw1U8mVK4iqzDoyh0h7Kny
	wxnum7W+M5ihmYhTU/bbMoBul4Pc9TkB8Isg92GP5oByEGlbYjhdUlWk/Gw+EUVgCwZd8+BbHuu
	afPi5FP65qMUJAMihHTegsV5CNo8gxmKJ7TWfIdbT/L3Mjv2E5ftxCg==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550145e9.5.1721722218496;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCo1aNAhjviULscGaL8sACLt8gU7d795r1dvnXHXwpUiu5iTQoVlYIXQzwkKwd8V2YJAIQg==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550025e9.5.1721722218027;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cece3sm10602003f8f.69.2024.07.23.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:10:17 -0700 (PDT)
Message-ID: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
Date: Tue, 23 Jul 2024 10:10:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to
 SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jerry Chu <hkchu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> A recent commit in TCP affects TFO and MPTCP in some cases. The first
> patch fixes that.
> 
> The second one applies the same fix to another crossed SYN specific
> action just before.
> 
> These two fixes simply restrict what should be done only for crossed SYN
> cases to packets with SYN-ACK flags.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
>    comment.
> - New patch 2/2: a related fix
> - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org

Re-adding Neal for awareness. It would be great if this could go through 
some packetdrill testing,

Thanks!

Paolo


