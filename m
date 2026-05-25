Return-Path: <netdev+bounces-291248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DKnHiX6E2puHwcAu9opvQ
	(envelope-from <netdev+bounces-291248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC25C7219
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E55F63001309
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE703D16F4;
	Mon, 25 May 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6ph7os0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361F26E6F3
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694113; cv=none; b=cvDAcg2DoRAou94Ucc03QLye/t0MYGsj3UEEv/btLVELabGBs/0AjQKRTqIps1COTJvJ9ily2xHT2YFXShsUlM83YjQzyD7iczDDFc3g4VJoe1NDIZhTbS9kkAlclrGPDnjHsHrFVolj3hgY2vE8rOsJfp0Vr28bM4G3Htsjza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694113; c=relaxed/simple;
	bh=EKkYSzzDAuLx0gtyGx5yQSpYrM8c8z6+RvIZwPES/iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dmirz2XBvGvyf5Kz5WEfPLrEVDAmsnvpaLK6SZyB9dRaqTbOVjH1/jb2HTAAzyYajSK/+zqYxq6+N+sueDODzMGUt9KjDeSdnDQ4gDRLItvaKeeLXA4rUs9Eljt3tdv3+451Whpco2YognDms1W9w38NeZb7zdQ6HW9rwi7i3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6ph7os0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d146705b4so98160615e9.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779694110; x=1780298910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0w4aRnsi5pVu0IzKW7hScfcrcT75qAZDyNhUAFxAG0=;
        b=I6ph7os0Z0Ytu1EP9Awb+lJpD91iiyZuh15NeIQj/w+GSAjwlkVsuhxtc0IC3LwUr1
         VmT0H2aUwT43JYlgwAVrpLV498AB+YB98lwnZ1qAJVV5G51sGRg8DDZtjkTKlwiyWbvb
         8BX10EDH3l3sTlWUBcetxbGcqpuTjyTsjmYWWFFqNMRJC3zyO2leL67Xhj7DpD79rerl
         ccEan79TvE5OR8gXNJdUTOMEhMGZJSsDH8eiW6cm3RK6biktGxUyD7k7GYPCtrVhKBQ4
         ji0UYr3v5YS1cfol0jQKGtvzUWEHaFMZ7gWRlXMR6cGHwh0CN8SpMe3SclKQ0dzwHQvM
         IHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694110; x=1780298910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0w4aRnsi5pVu0IzKW7hScfcrcT75qAZDyNhUAFxAG0=;
        b=VzFlr4QnfjZWJns7j2GxXpoaP9GJi/wj2bD4RGS7bZMLAfpx+wCrZmImdmcd6+fGQN
         bX/uCXNoo05AsKxkVmN4S8DgsszZSHAskvuqiVipf6JNn5JDE4fIwtwuu/++r8UBJUfn
         BYSFiSu03106yI25MV8TIX4ehVMYwymQCe5fBLlBwrxxWjNRCaYs+zXNjBzLI1JwUhlC
         dryzXQwTAlutpodYsvoC8JSMnnDkIGZ57vo4qhVzxXk19t+VVUKZTQadVOcCd5CSjoEl
         d9T87Yld9PIIKNUXC3YSsoJTjjV8qGtvvoPRzmhSGALVrHlCjZEa0VWFEDa4hYjmB/gE
         GLWg==
X-Gm-Message-State: AOJu0YwdOspaQbE4WdCMxJ68cHzktWuK/73Oa/LQggreYXHeRh/JcZoG
	TAGggBRCKEHiusv00yDDg+yCsrvZagzNO0MzWRDpu4I07Lf3ch1OxNAq
X-Gm-Gg: Acq92OGYMoSlCLHXOnc8UcuXK3+bEidEGn6QJxZ1SunILfzwVkqQiDKy9Y4LU6rU6i6
	0CNizrwQI1tU4RGtrB/E5PDenTBPjqGa1KbwDFgQfmrUpTJaPDTFntVGKixBonE+qTBNhgRJ8+o
	jNwdV7EcRHE3beoxMoU9ybaSc1aS1qee3Fcq8n0yhfEkzNwwCn9B+QEfzlIrKbh9XZZ3BYnt+MI
	nfREx5PwQpWDzdTeudcf7q3MhqIRCX4m8xyIawwPWuxvmOfLd7TP8725J1top8KDdokc8gO3hnx
	y0ZGQN3hcAt8McgIDL7i0qTPqClJVbPlEeLtMik6HgPbmBYFjHMpwH967UdWBoJO/J1NqaKgYs2
	yU7arMq30+jKDKSsUYIv6fzw7MFzy1sf1DNj2uiEF4lYLf5LCGtkW67+VSHDSbj1g0NZAFXPFoZ
	2/kiI380TeVs/qrkfvjrWSZ1LPHw3RgyiTmi4IzhrsdhUtSzZmi0YCRiQeHF3YXot3ELKYqVXEv
	QKTtPS0pgtgIy4xlUOOHTw6keKmJR80XIB/6HUKV2egK1XaOT5AMVNc0kUEnKZ9sUou/iyQ8YbV
	6A==
X-Received: by 2002:a05:600c:4fd0:b0:490:3dc7:9778 with SMTP id 5b1f17b1804b1-490426d3f0dmr211949685e9.23.1779694109671;
        Mon, 25 May 2026 00:28:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm25849304f8f.22.2026.05.25.00.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:28:28 -0700 (PDT)
Message-ID: <27a64a78-f94a-4724-8bb6-3eba84204df8@gmail.com>
Date: Mon, 25 May 2026 08:28:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Huzaifa Sidhpurwala <huzaifas@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
 <743e314d-abfd-4a03-a74e-33a57c0bf6b8@gmail.com> <agx66OTyTlQbot0M@krikkit>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <agx66OTyTlQbot0M@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-291248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1EBC25C7219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 15:59, Sabrina Dubroca wrote:
> 2026-05-19, 15:39:19 +0100, Pavel Begunkov wrote:
>> On 5/19/26 13:40, Sabrina Dubroca wrote:
>>> skb_gro_receive() can currently copy frags between the source and GRO
>>> skb, without checking the zerocopy status, and in particular the
>>> SKBFL_MANAGED_FRAG_REFS flag.
>>>
>>> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
>>> on the pages in shinfo->frags. Appending those frags to another skb's
>>> frags without fixing up the page refcount can lead to UAF.
>>>
>>> When either the last skb in the GRO chain (the one we would append
>>> frags to) or the source skb is zerocopy, skip the frags copy, and just
>>> append the new skb to the frag_list.
>>
>> Was it reproduced? Sounds like we're missing skb_orphan_frags_rx()
>> as skbs looping into rx should be orphaned.
>>
>> +cc Willem
> 
> Yes, as I wrote in the patch:
> 
> Huzaifa has found this to be exploitable to overwrite the page cache

I know, I know, but I had to ask as since recently there are too many
reports where the exact wording wouldn't mean anything sensible.
Thanks for clarifying!

-- 
Pavel Begunkov


