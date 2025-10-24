Return-Path: <netdev+bounces-232560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D8C0691A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB23BBFFA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77A316188;
	Fri, 24 Oct 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvUKeBld"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1D257841
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313810; cv=none; b=edm4743bkaFk2HB5xs/D5SynU4YfP9YRvBeRLvqPaCHD6wtIzl2w1QFzLGM2CeAJDo9sF8ykbHzlLhNt8qu3W+DlNXTvGFYSeBPEu9K8GWkxKOpMDZN+I4r72t1aZovttzvK7VXGkExYIp8I0xelMFfhHexHeMbnNoMkl3opTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313810; c=relaxed/simple;
	bh=migtZ7Qq0fXapKTB00zx82ZTtpJ2vkvbO0JHcjYPeWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQkJouUvT7Oz5xsAaPoMMZWktBLwgb14QlaLTBD50GVoFMYMTOw6g/bGrhFmuS3z5LF890i01UwsoxCAJg5UCPeoZThS5h2L2GBdY8YP6HMxf56ziS93k+Ykxu/CmATZ6A8RSPDESPLg1R7mAOhx0TVOc4WTuhM+95diLnIHsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvUKeBld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761313808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AffTiktMGo1g+duhHDsTzpJkOxPv08cQeBULfzXp5LI=;
	b=WvUKeBldmpaIOb+TPKSPn5+/+KAPHM7l/aaQqN2oVQ3K4AMBkmKuO5yDkao8016OQMr5/Z
	WIcBCjdqvMW6LB4DFwYlqvqecqs4AhA2q5fKQ+39nk5aetamxGFnIXZ68dslzjpTi/nerC
	2LtOQaSAbQbDHKad9RPt5J0Stgd++jU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-VW3xQaCwMrektL_vcKgnCg-1; Fri, 24 Oct 2025 09:50:06 -0400
X-MC-Unique: VW3xQaCwMrektL_vcKgnCg-1
X-Mimecast-MFC-AGG-ID: VW3xQaCwMrektL_vcKgnCg_1761313805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee888281c3so1279247f8f.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313805; x=1761918605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AffTiktMGo1g+duhHDsTzpJkOxPv08cQeBULfzXp5LI=;
        b=mfDNUhNXBHrALzKFkmifdK+tTZehwCgHWeH630O9dojhkAmndEMnRsEcDFUeVli18+
         ju0eggpejP8y8PXEEEI49ichMGBorjKSQ8NbQMqLHp/B/27O0HXX0vH8G9mariM7g+1j
         Bqb/fkGxC/8fGgW7aXQmuK+MtXNF7MM+CVaAy/TE1zymMe5FVrTW7PhRBFNCypCfKowG
         HwN2HgQM/5xniW/gXjJO+/vOG+1+dWAnLLf0bUYEhqEVo9WSKObyv6kUDnoxc3wWwj6Q
         TEjHYWphmjiR2ish/QjSik1SfmFDX5Q83/UC4gx9GjgNlJFS8faelxkyOGdAkiyIWzz/
         Plvg==
X-Forwarded-Encrypted: i=1; AJvYcCX4acxPC6sgmaO3BG7m7HNkLrL2Dlk4S8YZu/yPJurH8x80RxaN4Nh0FmJcnu9RgCZzCImzP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb224uX4KO7A8Zg2kpLSRU+BB66OuaqDsfHyRBCmc3FqO5/lKH
	B4VsjFp7BdxnXqFZmVHU1FDtXX/8y25ekRbExkqIqG1c0OEgTRQmCwh0rAbWAo2wdPCMflzMB4H
	a+P5WcoFWWQeVwiN44F5gAFSPO4owec21JQ1BV/HOyOsG9dyCmlxlmxN3tC9SAwuErg==
X-Gm-Gg: ASbGncv9dmZUgg66QedpF4TARcXr0/fdTuAuZMI9802iDMj8DohoV1zygeCbzFRMKHj
	lI73SXvrPy1gp+TvB2b/jIU5yOYl4BzE+B4VsHjxm21GgIa83A3LJRCyAEmrFS36fxTufdgG+8L
	oUlRu1woE3aOETw8J6r8a9v/rJDJYjRHyrf2FrmFNSXaVrnuPk9Ry1VktcGqHx4K+T3RD2HhcBX
	vybaAIi3LE61J9Eoj/xsz588Qcqg3SpSBaLrNXM40fHABs4HCVdkPp5p6+ASQ+jZiHhDSQv0Fbh
	3hKm2LC6+2rp5XK1TWoecZ3RV1v78fdaAl5A/syAlUmsahkYQqCriSTurEtPCqdSJtswYcTHmbO
	D2PrlVt4ojeLRvCj+yNbVYsMf0qQdazbVELwYe2Y8oBtUTUU=
X-Received: by 2002:a05:6000:230c:b0:429:8d46:fc40 with SMTP id ffacd0b85a97d-42990717e8dmr2215569f8f.25.1761313804785;
        Fri, 24 Oct 2025 06:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGFUtpjcksqJymTvb8OYpJF1cnFDBLogSrgxtzEM6seDwLyPjc4djfMZ3P92yGuwdePa3H9A==
X-Received: by 2002:a05:6000:230c:b0:429:8d46:fc40 with SMTP id ffacd0b85a97d-42990717e8dmr2215527f8f.25.1761313804326;
        Fri, 24 Oct 2025 06:50:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm11330309f8f.36.2025.10.24.06.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:50:03 -0700 (PDT)
Message-ID: <aab41dd0-2937-4d9f-a62a-60775243d6c4@redhat.com>
Date: Fri, 24 Oct 2025 15:50:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to
 tcp_rcvbuf_grow()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251024075027.3178786-1-edumazet@google.com>
 <20251024075027.3178786-3-edumazet@google.com>
 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
 <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/25 1:19 PM, Eric Dumazet wrote:
> On Fri, Oct 24, 2025 at 3:09 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 10/24/25 9:50 AM, Eric Dumazet wrote:
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec65657ec179cfd52ede483 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>>>   * - mptcp does not maintain a msk-level window clamp
>>>   * - returns true when  the receive buffer is actually updated
>>>   */
>>> -static bool mptcp_rcvbuf_grow(struct sock *sk)
>>> +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>>>  {
>>>       struct mptcp_sock *msk = mptcp_sk(sk);
>>>       const struct net *net = sock_net(sk);
>>> -     int rcvwin, rcvbuf, cap;
>>> +     u32 rcvwin, rcvbuf, cap, oldval;
>>>
>>> +     oldval = msk->rcvq_space.copied;
>>> +     msk->rcvq_space.copied = newval;
>>
>> I *think* the above should be:
>>
>>         oldval = msk->rcvq_space.space;
>>         msk->rcvq_space.space = newval;
>>
> 
> You are right, thanks for catching this.
> 
> I developed / tested this series on a kernel where MPTCP changes were
> not there yet.
> 
> Only when rebasing to net-next I realized MPTCP had to be changed.
> 
>> mptcp tracks the copied bytes incrementally - msk->rcvq_space.copied is
>> updated at each rcvmesg() iteration - and such difference IMHO makes
>> porting this kind of changes to mptcp a little more difficult.
>>
>> If you prefer, I can take care of the mptcp bits afterwards - I'll also
>> try to remove the mentioned difference and possibly move the algebra in
>> a common helper.
> 
> Do you want me to split this patch in two parts or is it okay if I
> send a V2 with
> the a/msk->rcvq_space.copied/msk->rcvq_space.space/ ?

I'm fine either way, please pick whatever fits you better. Given the
strict interconnection between this specific mptcp and tcp bits, and
thinking again about it, I now suspect splitting may harder and updating
the patch as described above could be the better option.

Thanks,

Paolo


