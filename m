Return-Path: <netdev+bounces-112537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08279939C9B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8909BB22CBD
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D214C582;
	Tue, 23 Jul 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgvw9gay"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF58814
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723235; cv=none; b=WiKNJdx1G/IyASHV44bw9M8stFNvgTwGfHHfTfHT3hkfkbbfXPvAX6AxAeOdfcSW+npfmIe0DxkF7WU33puiXHS42e8uw72okvRpuNfFm5sZizQaGjTP+BLqjPKtSOVdr6WSC+MXibUs+m1iPYnXM4XigKQcEKD5S8CJtMVmh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723235; c=relaxed/simple;
	bh=GWxwNNUUchgR/mEv8fXJVXJ9+NszEjBE2JW5a21cBiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/Ke1d22P0Ydqp3xKMzbwlPAh6SbDXZ2zXkjF+vZ0Cn5QWpI5GmQBlIX0JM5CPEsgDJJZ3nR1HMmuqU5OeDvOkAwnD3orrdMKSr7LWxLi/i5J+1tQ740BL9sVNpc4FcbFftbUnBbSSQJPnbhobbuEYBR5eaapVJHfazYfnmPmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sgvw9gay; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721723232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
	b=Sgvw9gayo1vZSbBw4VQ/Z25wswtNDKlYLcUrxAsk9VMTtDGRE116JWHlBeULZsg2TIDlEF
	9hmDuUKTIj9vH+B5scHYKN7EPDDC+FTC543MM05QhPwxZcrUOsPBrZb4f9MHoo8L3dvDhI
	WUMcRTs8lLBcbZRX1N6Li23a9n4A+20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-YbQLFbaWP9qyEvMq3gKpbg-1; Tue, 23 Jul 2024 04:27:11 -0400
X-MC-Unique: YbQLFbaWP9qyEvMq3gKpbg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42660e2e147so3142315e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723230; x=1722328030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
        b=A5GrkVOYABZ+pZd2duwt/BlYmoY6DuGzXdefvAJjInN29YrAvvxmZfKzQDc2DuEsu5
         IOiPmk6O5V9sG+KZKnBvbTrEeRR6ocjfxQVMQAoCbZ1snItHb4AQJzILPVVKm+1Z1UM/
         CZd7j92xdlP3fW5/vYIvJ1vDSOXELhK8K/0b69dyKDr+8fqlSWiGsD2yE5Wu2QfVuCi6
         UOQupPreUKhbi71i9DfWMvCp/RFByypDlgB4+AVOTJ/pveNo9wg67n/nJTUrd+oItOsp
         dREnAmaXU4H0rm0ZbZkUaYK1m6hN6aC1zhV6mPSjk/pekLtxJ9zCC9t0jAUTRlgGzOF2
         TyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmhDre4zWbABPRjkLHTFuZyR/4o6WoecmL7MOuXNYMXqdfLl47HbIDpUEmD6/ptl/jfd/kwbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQGgELg9aMreS597JqvsqFclmwWXadYQTorRa0SIDZzKeBDyG
	DQQgCsiUc3X3BKz67YHh8CSUm+42bw8xTKReiNoyDnJlBonN98bkOH5r7TG6BGmfJC+emPJmJIt
	HtgZyqbb8YDyAEnmONQWBB2BE3qU0pZob0SnrVRAvdG9ufY0WxmipUw==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr42159445e9.4.1721723229849;
        Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyB35vHUyy7xn9TnmLleBJi8gLs2mzDoXRcT5qHjLuUf9xNuul01VsC7irrgvs/KrKyAUdGg==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr42159325e9.4.1721723229417;
        Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a63b70sm188462035e9.19.2024.07.23.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:27:08 -0700 (PDT)
Message-ID: <afdb7011-5098-47dd-89af-5ed0096294d8@redhat.com>
Date: Tue, 23 Jul 2024 10:27:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] igb: cope with large MAX_SKB_FRAGS.
To: Corinna Vinschen <vinschen@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240718085633.1285322-1-vinschen@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718085633.1285322-1-vinschen@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 10:56, Corinna Vinschen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

@Tony: would you like to take this one in your tree first, or we can 
merge it directly?

Thanks!

Paolo


