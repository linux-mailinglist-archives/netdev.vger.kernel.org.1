Return-Path: <netdev+bounces-177302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A5A6ED14
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3410418941BF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1252528FC;
	Tue, 25 Mar 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cACGKuYS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C3254861
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896386; cv=none; b=Tipnph2jI2q2pG+IVVFVk35njfcFZwexbExO0JksaRxzhhrvFx/beVYRzvqHMo0FwwtXqxlIrlALv2c2v/JzfF3f5E9MlbFrP8SgklyAPZe9kpQNU52ZEy6ogV8F5ibF5374lz4lWJGbBv1W+ytr4axDfRMBXOop6C5U7kO65sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896386; c=relaxed/simple;
	bh=g/PZojo7Vtmb/7rS+vDqEnvamhDirH6xExzh1cYK5UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0Q60oDsC8dUSqOlaBGbUXT/TIlXp8PcSLyvnkgrCAYQq2b5RgzAV2nO2p0wlEc6u9aLHMKOKTcp9FhZetuZGjHBo/JwPWcDnrqxpG64JkEndIGeonUer+zDJf0HE1Uwy9xkseFeGhCQxWWkE8F5Z9nsn0Gp9/ihcbE2j7JZ6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cACGKuYS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742896383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VwJ4qmAHW6mIQYvRMYR+1kBiCO1OoU67ZBajJ1aVd8=;
	b=cACGKuYS7C8fZX0lRTcH8qYsvsGykVqixckxaXt+cz1+Rxd5pU5zIhw1XW7LCjCrg83LCw
	WYwZMqb+lJrOEgsxidK376LsOArqiGoILkBQEdXk8N4hPYxmwHQt+nJAJMZVsJcj8SbRTK
	DsZLLROHVurFMiY1MuhoOizCIuXfRP0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-EkKwjQedPniiB6bl1mILQg-1; Tue, 25 Mar 2025 05:53:02 -0400
X-MC-Unique: EkKwjQedPniiB6bl1mILQg-1
X-Mimecast-MFC-AGG-ID: EkKwjQedPniiB6bl1mILQg_1742896382
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c59ac9781fso945778685a.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 02:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896382; x=1743501182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VwJ4qmAHW6mIQYvRMYR+1kBiCO1OoU67ZBajJ1aVd8=;
        b=I+F25LNH2puW7R0F7MCvfTyXfdvI6wbHd1sX/U6ijOpgDd6y4rjenWdu0yxtfKROt1
         99DlAgJusrNmjKUUvalEw8rCvrdO6+ABWJPOQQ7bEq3375vBclV2B3w6GKaY/8Tnnvz9
         9r4Edh9O7jqqLTL4uzVrmTGnh6zfVmf8aQR3NBEnxiPKn1/YdzT1R2xOWC0v5IV4ax99
         XARlX0MaYYPhJ7noWdpNm90mCI2tjD0amwcx3mNcTPN54nuHpjdLAU1bQ4f+sL4yWFHC
         k6296lFcbHzhvpNM0CLgnxojzQbPw14DU0OgMiS8a7L/6JSFSR1lhdjSJGenm5fUY9wT
         aYiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3qkvIX68P407BDG0LA5Sa/ykgVscoYge/RxsWd+n6bzUDq7g92nPZFOblZznY/IugVSVA5Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPvrbcwcp6RHRDCuMicKDKXLwvYvbFqpiYTKus6QFtp/xLGZ1
	MrIxKZvrwYaWRxsp/jZVE8U4yph/U8PBv1z+qOdYJcJrVlXstcrolyXkokjqWNO/x204nmdoxpO
	13eCRtOL8kItTYPJbk1g4NcSB+RGC8rjXBAYiv9/bUDUhr4TcX9eKzKM/wWRJhQ==
X-Gm-Gg: ASbGncsMj+2BPf6kWUnVrATy6jdlNBQt5M+GEJ75f/1+tLaKkHSojMOMtSVlXZT67bN
	7lbPC2GgwSsvb8RolzA3iSVKDlMugGLJ/KzG0FYma67gb9BgpRFjH+j+5DakC5LZu7nMAkUE1bN
	GXmfD4CxSOlJ9f+gBV9j53l6Igw/Gb2J2zVJNErJZDH4cs1nc5FaYOvCeNFCZsruf60TX1xjgFb
	iSPssZBnkUhnwMqcHRvW7sowvgG9pstaGiRECrJfEHTg0aKRn3ezkJj6HpDbudbjL99i+KyL210
	z0Sib3YRG0Peips=
X-Received: by 2002:a05:620a:c51:b0:7c5:3b8d:9f2f with SMTP id af79cd13be357-7c5b0527fd1mr3208996985a.17.1742896381627;
        Tue, 25 Mar 2025 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXoILeFeHwDpbK2MlPEHNgV0HFSkdRaMjudRdE2u/xjGXQh0gVmo0a+EY5Z+FvuFQcYV2u6A==
X-Received: by 2002:a05:620a:c51:b0:7c5:3b8d:9f2f with SMTP id af79cd13be357-7c5b0527fd1mr3208994385a.17.1742896381126;
        Tue, 25 Mar 2025 02:53:01 -0700 (PDT)
Received: from [10.16.31.40] ([101.100.166.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92dd9fdsm626398485a.35.2025.03.25.02.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 02:53:00 -0700 (PDT)
Message-ID: <5432cc4f-99f2-43c2-b228-94fb38c2f2d0@redhat.com>
Date: Tue, 25 Mar 2025 10:52:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] udp_tunnel: properly deal with xfrm gro
 encap.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <cover.1742557254.git.pabeni@redhat.com>
 <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>
 <67dd94e315ec3_14b1402947e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67dd94e315ec3_14b1402947e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/21/25 5:33 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> The blamed commit below does not take in account that xfrm
>> can enable GRO over UDP encapsulation without going through
>> setup_udp_tunnel_sock().
>>
>> At deletion time such socket will still go through
>> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
>> trigger the reported warning.
>>
>> Add the GRO accounting for XFRM tunnel when GRO is enabled, and
>> adjust the known gro types accordingly.
>>
>> Note that we can't use setup_udp_tunnel_sock() here, as the xfrm
>> tunnel setup can be "incremental" - e.g. the encapsulation is created
>> first and GRO is enabled later.
>>
>> Also we can not allow GRO sk lookup optimization for XFRM tunnels, as
>> the socket could match the selection criteria at enable time, and
>> later on the user-space could disconnect/bind it breaking such
>> criteria.
>>
>> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
>> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>  - do proper account for xfrm, retain the warning
>> ---
>>  net/ipv4/udp.c         | 5 +++++
>>  net/ipv4/udp_offload.c | 4 +++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index db606f7e41638..79efbf465fb04 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2903,10 +2903,15 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
>>  {
>>  #ifdef CONFIG_XFRM
>>  	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
>> +		bool old_enabled = !!udp_sk(sk)->gro_receive;
>> +
>>  		if (family == AF_INET)
>>  			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
>>  		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
>>  			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
>> +
>> +		if (!old_enabled && udp_sk(sk)->gro_receive)
>> +			udp_tunnel_update_gro_rcv(sk, true);
> 
> The second part of the condition is always true right?

Jakub noted my initial reply did not land on the ML, sorry.

Yes, AFAICS the second part of the condition should be always true, or
at least I fail to see how to reach there otherwise.

Still syzkaller is too good to prove me wrong, I guess it's good to err
on the pedantic/safe side here - checking that condition explicitly.
It's also IMHO more readable.

Cheers,

Paolo


