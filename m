Return-Path: <netdev+bounces-242252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64798C8E2C3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6826D4E5D92
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E632AAA9;
	Thu, 27 Nov 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWWwpRGO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBTSEjCX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA62302158
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244928; cv=none; b=aCNHWDCqWkU8cKYgn6Ay12xUu0r2kRhRS8EyBgxPu2WOW8eZGY2+Wvzl8O4HS5azhwWQ5ZSoa3Iy/tz98zi0qFRbqJkBjkZTvxANPPDpnnxzC1n7xzoys6NBURKWogzBy4BfIl7Gx5we615hCQ4o9V22irow+qGaYtNxNQOL7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244928; c=relaxed/simple;
	bh=ehWkCwHPO+pEw5/TrMrZVgpPVFj63hERVhd6qBsrUHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2kvGoGEDMaP/k6qMS0enRlYVc3itI2SJGxhK2pDnGcjVR/SO5ArJQOo73EQI394gpNd2Wl0Z97fMtfSQE+aRioaWYttCTW2G9Cd8/QunCFMV0/q0LixY+qF2ezvxPb4JPH0jDnJVtrSvKQhftzXCID2T3MWgAn1zjtAhOXd4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWWwpRGO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBTSEjCX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764244925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
	b=dWWwpRGO5VQm0OF1hRWRsVW7og1+6uP0mDY1fOfeZ0dbS0RteuaQ0YMWLuFa2gCotaxKyK
	kJU1grCM4KsjeDOZTszei94PyfnjWaco2P0k4qvBtlPwvsQ5jz1TwTDectfEvihs/G86dS
	vaFU/dN4BbxziwVHpyjM8CTmTeV5PsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-9rBo6wSTO2mVDQq6iAOCwA-1; Thu, 27 Nov 2025 07:02:04 -0500
X-MC-Unique: 9rBo6wSTO2mVDQq6iAOCwA-1
X-Mimecast-MFC-AGG-ID: 9rBo6wSTO2mVDQq6iAOCwA_1764244923
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso6057855e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764244923; x=1764849723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
        b=RBTSEjCXWwTYESlXCR8h+fS6VC653h/5RJ18s9OxekjAj5UPB2Sq6gqYGY0VfLBxbe
         bwN29YcdnHUMgiDzRKWuhvWOlO/t7xBOtwZcNrbgU69gXS/YulZv18V663PsYxkch8Dr
         22EXTO/UwfY89clAVmvoMCo8L+qUi23izg4wf4XXLT9YWthl+ZRvJnbspAw7AF3wWmD/
         iodnX0ueWUGPEPR9D1UceRiDQNgfq9L+Z8mo5yhhkixUqXe3hhM2dDeZYa6tRu4yAIAJ
         oNyAktUBMmw6zJQk5ymg9aGCJAbogGQXIzYWywE3jLaVJfCTk6/stJK8YGFmNEmlWXIG
         ylAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244923; x=1764849723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
        b=ki9C4UKVgVTeGB/TObDYc/4gCSD5PyO7G9U7H8Y744hA6Lfz2YfPYSKf5UmxcvZHT+
         EM7w9bzqE9ld2XGa3MJjCU/1D35wf9+Gr++kxkedXgexN3rJDrRRWd03CrBwfTdWQcAm
         bEvDwuj4yvohStyIcgWiG9Z9PK8d6K1eRinzM7tVray/8nOcDxKDoMIcgPZ8vpH4y5kv
         72SOtkwMwUHN+7eAq0/eKcJBIwH0rKEAdwXl45B1IYZRpyhKVhrnlPr1l8I/JDN+p1AK
         FLUyGrQxjpBH7+YhyFawVbxUTNxW6i06Ia/OMK7QljYHQQf5y03WDobJdwkGv4d45+P3
         vT7g==
X-Forwarded-Encrypted: i=1; AJvYcCX4YTcmJZSDX/XGPvRn8H8dsp32bVC4hwX23Mt4PYWrOxy0mZfmCXUH5R+Ahd7Euif+a1reUNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+NLSxWTeiKO7Ru7/C9fKnmjgq5wuk3Tsvj0mvpNLtUGaDQ0b9
	46kU/YRJqgwD6C80JgOPtP4wTpXkZdO9uVEeTWPrM+JMmaPiKDPdhbNQVpj5YIWuIYQaScxsUWD
	/7AinKO/Ipj8rY9RjDxvtW5NMARM9sIN0yEYJu3ROp0WADPJF0ZQ3dF/ZHw==
X-Gm-Gg: ASbGncs76DSD+RQCOW4ZK4YsqjBzz7VX1YJAiK+1R7lQdMijLZlc3qeykR4GUe9C1De
	73lLu8H/NVifFR8CTxWYbTe4rstNFk/WD1kkUDlCkdfe4jwIV7K459Ci+pWLgt5b3MDN4Znqs32
	qFljoOOP8ER/R+gBc7dOanBBQmUPR5pdv0VEGVaQ7VSVZMn/XcF60hTH7ZmfooJMrDnlgSw7VMd
	vz1QmFVqzwr/MDJWF6KleBh0G8ai2DiXxAtQf+NPqlAS5bkuDBnVjlUdiF72y4y+PNEL7txV78j
	sEM2InHctdWj2/XyJO7CO0dvHKiyFmM8AbjHs3WrlTQkittiymaCFc109RJWRhSBaKHYwR4l2d9
	Ofs5Q4SfI7N5XVg==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr98284525e9.26.1764244923111;
        Thu, 27 Nov 2025 04:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2W68LFAdvuVXZdLjoN0So8upVJgTz0J7veoBYOYmjnfap1Go0y1jQBhOt+rN+UOJ2VeylEA==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr98283915e9.26.1764244922617;
        Thu, 27 Nov 2025 04:02:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add4b46sm100442865e9.4.2025.11.27.04.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 04:02:02 -0800 (PST)
Message-ID: <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
Date: Thu, 27 Nov 2025 13:02:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125115754.46793-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 12:57 PM, Jason Xing wrote:
> This patch also removes total ~4% consumption which can be observed
> by perf:
> |--2.97%--validate_xmit_skb
> |          |
> |           --1.76%--netif_skb_features
> |                     |
> |                      --0.65%--skb_network_protocol
> |
> |--1.06%--validate_xmit_xfrm
> 
> The above result has been verfied on different NICs, like I40E. I
> managed to see the number is going up by 4%.

I must admit this delta is surprising, and does not fit my experience in
slightly different scenarios with the plain UDP TX path.

> [1] - analysis of the validate_xmit_skb()
> 1. validate_xmit_unreadable_skb()
>    xsk doesn't initialize skb->unreadable, so the function will not free
>    the skb.
> 2. validate_xmit_vlan()
>    xsk also doesn't initialize skb->vlan_all.
> 3. sk_validate_xmit_skb()
>    skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb or
>    sk_state, so the skb will not be validated.
> 4. netif_needs_gso()
>    af_xdp doesn't support gso/tso.
> 5. skb_needs_linearize() && __skb_linearize()
>    skb doesn't have frag_list as always, so skb_has_frag_list() returns
>    false. In copy mode, skb can put more data in the frags[] that can be
>    found in xsk_build_skb_zerocopy().

I'm not sure  parse this last sentence correctly, could you please
re-phrase?

I read it as as the xsk xmit path could build skb with nr_frags > 0.
That in turn will need validation from
validate_xmit_skb()/skb_needs_linearize() depending on the egress device
(lack of NETIF_F_SG), regardless of any other offload required.

/P


