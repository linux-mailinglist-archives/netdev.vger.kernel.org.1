Return-Path: <netdev+bounces-178562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A7A77909
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604A33A62AD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F021EFF96;
	Tue,  1 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5n62tSh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD11F0E44
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504175; cv=none; b=d5vFgbTNceuYx+j1iXUk39j+LDmxF4Du/us7X0FFqPiZJrrJDi6uF7EIAevGVYwFmFHSSnSsGzrUem3tkmIF9DnfNFtrrA4FhzE/8THjEVYssEt3siJXX+mICxQ1ViGZxb3qmNn4DZXu5Eayw67/FzpQAfne4yNfH/Hm1TYCWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504175; c=relaxed/simple;
	bh=9P026aIwZjJWPt7N0R319Xp1rQKitzabJGwNah/+/v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz9NbuXc3LmgtGvFRm6kZyr7l4beXu52/HOcd+RffJ0v5p8ZX+tcv0E/Ggci+Z+KZwoE62sEjyUfIMsSwWKOoYy6LJp1Zw95GKklLV2+bw1P/lkUUHXTSW3Zr1jFP7kLHd2cb+gDvIwJxv2OTDmSEqrbA0KsHDNy1Ev8DYG+CAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5n62tSh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743504172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L70RQfP142JDi0wg/GLWbGt4oR+cGIYDeU9CiOJovqU=;
	b=N5n62tSh5zQriizZp6gnjI4An4Brro16bNn6nANT6Xb7P6Dy0gv+tgAagi086vzeaJsLKm
	iewO5bHd/g2kJgy2btdZgurrGGGcgqNt66wV9whjxc+Lg8CL7xBdSplwk03CIUTFUMIom7
	gOkHXvbRN/nc+65WHryItx4N+wyQ2TE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-BwWHzyKOPvefwoakIkAZnA-1; Tue, 01 Apr 2025 06:42:51 -0400
X-MC-Unique: BwWHzyKOPvefwoakIkAZnA-1
X-Mimecast-MFC-AGG-ID: BwWHzyKOPvefwoakIkAZnA_1743504170
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-399744f742bso1597334f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743504170; x=1744108970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L70RQfP142JDi0wg/GLWbGt4oR+cGIYDeU9CiOJovqU=;
        b=IcKcq1sw4bBvYjHMKD0G2nzms9Xq7iiHCWrJOW7HizfDNfMxjAZvX6pQMaXfupROEG
         9bBBZedVjuc+gpcKXiBEMGX0TqQOAwweTfgt01J3kAGlB5UUMfgiNHt2t3olVDrX0ql0
         T/yaRzCfg/tjx1T5uDNCzDBdxcfdUAiYWQZhMgUDfpyCAaQMfL7Jg21hY5JzcM0opldU
         dia2BKxkQKgMsiuvkriDS6YpZk9xU3HOpbZYJhyEBaJR/Nl4jL7/c8tWmCfpQWBp4KqM
         YfhxZdGRYhXnvMcY8r4KeU2hAbSQukXxGqi68u0SvgQDGRd8jQ++qEjbz4IjzEDW/gMd
         fDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLxjsJg/voP6qFnQNU/ildq6mVtmLdhcXFeiDPdfjLptRvm8StfAJ0ZTu7nG97ag5avYXSMLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIYKvcuj6crYgOLyllLJIbxaCyleSRzvmFDM4yNMS9P+UFUMJ
	Nf0Jgn7jpVBMlfW3TdNhxF8Ch9M2SJHYAiaXqcQ1wm1Bk+lzrjcGrA7Wkx6lpLVACM4WF1OX8SW
	bGXIy7pdAoyyks0+aG+FmLqf+THSAfsOK7H5DkiizromKPTFA/ZOfnQ==
X-Gm-Gg: ASbGnctveB00bITd9HutR6g6oeQ22gjeZAFrawRJpnMUo45cAnFRL5foDbOpIHSliH1
	huHseBRMvG4xcGK84UkG+f0XJb/0vwrruo6z3YkqG6De39QbuV9sPjtHpmQPghR3/B16pqKkmn3
	jYNmClXnLVgqM1oQ4NBMFv1mBMHmVK+fGLewEU/mHdNXY1qv0KuAFvvNYflZVq/GcCuH7/Vzjrw
	fnuqQ2QTRQGu9ywN7sX7yz7iNPPMtduTBMzsg5A+FRxCVUcPyx0UV/Foo6WAvkzfSqJt35Fgyrd
	si+3JmqtxYj7DCnk6cRBTx+lHvUOJvdW0jugeUW90AQHkw==
X-Received: by 2002:a05:6000:2409:b0:39c:1410:6c20 with SMTP id ffacd0b85a97d-39c14106c25mr9465875f8f.45.1743504169666;
        Tue, 01 Apr 2025 03:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErjtyNpQgTEEfLNTpXMht6fpOiuyDyvAzgK2cO+MDz04IWniLzgBXbdUzCkiAA6Wpk9SMqnw==
X-Received: by 2002:a05:6000:2409:b0:39c:1410:6c20 with SMTP id ffacd0b85a97d-39c14106c25mr9465851f8f.45.1743504169250;
        Tue, 01 Apr 2025 03:42:49 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e31csm13961368f8f.68.2025.04.01.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:42:48 -0700 (PDT)
Message-ID: <d994809c-7960-4fea-b10a-9c1937f00fa5@redhat.com>
Date: Tue, 1 Apr 2025 12:42:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Fix qid report in
 airoha_tc_get_htb_get_leaf_queue()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20250331-airoha-htb-qdisc-offload-del-fix-v1-1-4ea429c2c968@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331-airoha-htb-qdisc-offload-del-fix-v1-1-4ea429c2c968@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 8:52 AM, Lorenzo Bianconi wrote:
> Fix the following kernel warning deleting HTB offloaded leafs and/or root
> HTB qdisc in airoha_eth driver properly reporting qid in
> airoha_tc_get_htb_get_leaf_queue routine.
> 
> $tc qdisc replace dev eth1 root handle 10: htb offload
> $tc class add dev eth1 arent 10: classid 10:4 htb rate 100mbit ceil 100mbit
> $tc qdisc replace dev eth1 parent 10:4 handle 4: ets bands 8 \
>  quanta 1514 3028 4542 6056 7570 9084 10598 12112
> $tc qdisc del dev eth1 root
> 
> [   55.827864] ------------[ cut here ]------------
> [   55.832493] WARNING: CPU: 3 PID: 2678 at 0xffffffc0798695a4
> [   55.956510] CPU: 3 PID: 2678 Comm: tc Tainted: G           O 6.6.71 #0
> [   55.963557] Hardware name: Airoha AN7581 Evaluation Board (DT)
> [   55.969383] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   55.976344] pc : 0xffffffc0798695a4
> [   55.979851] lr : 0xffffffc079869a20
> [   55.983358] sp : ffffffc0850536a0
> [   55.986665] x29: ffffffc0850536a0 x28: 0000000000000024 x27: 0000000000000001
> [   55.993800] x26: 0000000000000000 x25: ffffff8008b19000 x24: ffffff800222e800
> [   56.000935] x23: 0000000000000001 x22: 0000000000000000 x21: ffffff8008b19000
> [   56.008071] x20: ffffff8002225800 x19: ffffff800379d000 x18: 0000000000000000
> [   56.015206] x17: ffffffbf9ea59000 x16: ffffffc080018000 x15: 0000000000000000
> [   56.022342] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
> [   56.029478] x11: ffffffc081471008 x10: ffffffc081575a98 x9 : 0000000000000000
> [   56.036614] x8 : ffffffc08167fd40 x7 : ffffffc08069e104 x6 : ffffff8007f86000
> [   56.043748] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000001
> [   56.050884] x2 : 0000000000000000 x1 : 0000000000000250 x0 : ffffff800222c000
> [   56.058020] Call trace:
> [   56.060459]  0xffffffc0798695a4
> [   56.063618]  0xffffffc079869a20
> [   56.066777]  __qdisc_destroy+0x40/0xa0
> [   56.070528]  qdisc_put+0x54/0x6c
> [   56.073748]  qdisc_graft+0x41c/0x648
> [   56.077324]  tc_get_qdisc+0x168/0x2f8
> [   56.080978]  rtnetlink_rcv_msg+0x230/0x330
> [   56.085076]  netlink_rcv_skb+0x5c/0x128
> [   56.088913]  rtnetlink_rcv+0x14/0x1c
> [   56.092490]  netlink_unicast+0x1e0/0x2c8
> [   56.096413]  netlink_sendmsg+0x198/0x3c8
> [   56.100337]  ____sys_sendmsg+0x1c4/0x274
> [   56.104261]  ___sys_sendmsg+0x7c/0xc0
> [   56.107924]  __sys_sendmsg+0x44/0x98
> [   56.111492]  __arm64_sys_sendmsg+0x20/0x28
> [   56.115580]  invoke_syscall.constprop.0+0x58/0xfc
> [   56.120285]  do_el0_svc+0x3c/0xbc
> [   56.123592]  el0_svc+0x18/0x4c
> [   56.126647]  el0t_64_sync_handler+0x118/0x124
> [   56.131005]  el0t_64_sync+0x150/0x154
> [   56.134660] ---[ end trace 0000000000000000 ]---
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Paolo Abeni <pabeni@redhat.com>


