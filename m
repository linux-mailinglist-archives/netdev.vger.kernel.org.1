Return-Path: <netdev+bounces-178984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F0A79D01
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297D7189045C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A991A0BFA;
	Thu,  3 Apr 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A05E+WU+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B82A8D0
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665453; cv=none; b=sJXT5B3xBR3XaAI2hJ7yYS4/aSWk76SaVwCxrGwTXjsWpQXMDDR22lGxpWDl0VypS7m2pUwMBUlc2f6YJlhrapfwY+RtH6T6xwvj4bIkOEyWQ4laEeS9c6MXBAhxIbXJsV3bFYI6AGfEAkX5jd2jYPZleEmKHIXZIEKl5SXmZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665453; c=relaxed/simple;
	bh=dpl7bk3zxrfUvX8Qn3SA1RTjpFP8x6HWUUrKuatCZlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrDwik/0ybmfALZGHra9hQb2qpsFeVW3qtqwPvVbQXCsZGc5zyaA9ipZ1Z+s0AFDkmSKq5sTAG+5COClxKKLF2Ugag2P2EUL5Z4e0RPJ1PWtNrHbPY/JwGbiwja9+V5U25puAk9tdhzPnv4UJLTgOB9FIhg52Pan0g5vMOaAY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A05E+WU+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743665450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvqByI/L6b/XJ2HJVELnCm3U+HbyNA6GAMZmcDdB3dM=;
	b=A05E+WU+qQqbNNLKwY2WOsnO6pozzn93XLAE5wZ20Q9fejLr2CzxvH3fu6/Sm5F67Z2uR/
	851gj/u3cKrNjL+4e2D6Ug73W122ibpM47b0+iWTbK0glZQ/eD0z5yzdKZmLWCpcqjusV3
	0VAkVjcyh4LoR5dhdP4V9JoKTVYfMZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-W5oyXMzSPImtkyHIcxkK2g-1; Thu, 03 Apr 2025 03:30:46 -0400
X-MC-Unique: W5oyXMzSPImtkyHIcxkK2g-1
X-Mimecast-MFC-AGG-ID: W5oyXMzSPImtkyHIcxkK2g_1743665445
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391345e3aa3so350172f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 00:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665445; x=1744270245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvqByI/L6b/XJ2HJVELnCm3U+HbyNA6GAMZmcDdB3dM=;
        b=GWNDuwd5ywiLN7261BX2qgxqVKocn94ih+SVXgfwOvEmRWIK3Vay2vOUSPTAS/8QI7
         94Sd3juFu7Pg0Qe582jONyLiCVquUimyzLw1Tb+fC0hYqz031+7j2UNR29Z7l9GDEVDv
         i4wvoHyydldNcg+xfXV8zLkWbzbVB37fOBTlDI5T3TepJ6N2MbA8AQ0uddE6hsoAQXt5
         +4BiwV5UvnBD5Nw50oSvSNTPIn5pivuObr3UWbXFuALsH+lxnD6KmNF6AuCRxVyQP6e5
         SV9zir/UtLMcTV2iMuZVaGhVIagihiN3Y2OUq3DayGy9jCtX0QVnYJagF8+6ixyYc/7Q
         vZGQ==
X-Gm-Message-State: AOJu0YzXtBaDPMQeka2xdrsjPOziY6KW4QSLvRwX+ZaKQ9L63hQKWBR+
	21HrSLTcL1PLje7tr8ZSdlTMNd+4kqU7agr5Oc5h18Hs92xa4+V7uztG6FrVLc5hcfPNhIkd2vq
	Stas0KvHrVsKE5qAyQBOmDBClqrcnvJTYtx0gFzvT+h14+VLcc9sccw==
X-Gm-Gg: ASbGncvuaA3U35J/2fwnP7zo7AesfE+d1qmL/xDL3JmbUvzHew+n+I68peqIN5CQwu9
	LrX0d0KMpi+n0oaz9WEsztUfP3m2fl/vQupwMeuqrh0ydfn8SaygflbtzfDYVMzUF7bgK2J/AXS
	ER9ObpLcOpUbxJu/l1TYoC7sLCM1/yOZ4WIqoXnJq6bdhuW2q8esHjYUWd5tDJD+TGDMhLIrV3g
	ivyCxK0b8dtcBrcxQrApP1qMTLjGAh4mdRfWUnp7JOEZOkDhaD2flEuN8NNCyh14FIV/2zeFVwr
	JQCszR5XNhEaLxQBovZDh7mMPzf/I1LavDBxTOEXC4HbHA==
X-Received: by 2002:a5d:64aa:0:b0:39c:30fd:ca7 with SMTP id ffacd0b85a97d-39c30fd0d18mr656643f8f.7.1743665445503;
        Thu, 03 Apr 2025 00:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+lNFS2je41M2jSOllRUK4YaCcFAGiVZTLhILMcGSQdXFLtyr7e/6X5pueyK8fMJPhqBd6ug==
X-Received: by 2002:a5d:64aa:0:b0:39c:30fd:ca7 with SMTP id ffacd0b85a97d-39c30fd0d18mr656611f8f.7.1743665445097;
        Thu, 03 Apr 2025 00:30:45 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b46bbsm13134995e9.36.2025.04.03.00.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 00:30:44 -0700 (PDT)
Message-ID: <03151db3-61fe-478d-b91b-549d18648738@redhat.com>
Date: Thu, 3 Apr 2025 09:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: decrease cached dst counters in dst_release
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
References: <20250326173634.31096-1-atenart@kernel.org>
 <89dcde93-8e5a-4193-aa01-fde5dd5ee1fd@redhat.com>
 <174358103232.4506.6967775691343340999@kwain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <174358103232.4506.6967775691343340999@kwain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Steffen

On 4/2/25 10:03 AM, Antoine Tenart wrote:
> Quoting Paolo Abeni (2025-04-01 10:00:56)
>> On 3/26/25 6:36 PM, Antoine Tenart wrote:
>>>
>>> diff --git a/net/core/dst.c b/net/core/dst.c
>>> index 9552a90d4772..6d76b799ce64 100644
>>> --- a/net/core/dst.c
>>> +++ b/net/core/dst.c
>>> @@ -165,6 +165,14 @@ static void dst_count_dec(struct dst_entry *dst)
>>>  void dst_release(struct dst_entry *dst)
>>>  {
>>>       if (dst && rcuref_put(&dst->__rcuref)) {
>>> +#ifdef CONFIG_DST_CACHE
>>> +             if (dst->flags & DST_METADATA) {
>>> +                     struct metadata_dst *md_dst = (struct metadata_dst *)dst;
>>> +
>>> +                     if (md_dst->type == METADATA_IP_TUNNEL)
>>> +                             dst_cache_reset_now(&md_dst->u.tun_info.dst_cache);
>>
>> I think the fix is correct, but I'm wondering if we have a similar issue
>> for the METADATA_XFRM meta-dst. Isn't:
>>
>>         dst_release(md_dst->u.xfrm_info.dst_orig);
>>
>> in metadata_dst_free() going to cause the same UaF? Why don't we need to
>> clean such dst here, too?
> 
> I don't know much about XFRM but if the orig_dst doesn't have
> DST_NOCOUNT (which I guess is the case) you're right. Also Eric noted in
> ac888d58869b,
> 
> """
>     1) in CONFIG_XFRM case, dst_destroy() can call
>        dst_release_immediate(child), this might also cause UAF
>        if the child does not have DST_NOCOUNT set.
>        IPSEC maintainers might take a look and see how to address this.
> """
> 
> but here I'm not sure if that is the case nor of the implications of
> moving that release.
> 
> As the dst_orig one seems logical I can move it to dst_release too, but
> it seems a deeper look by XFRM experts would be needed in any way.

I also feel like the XFRM side needs some deeper look and the most
straight forward fix could have negative side effects, so I'm fine with
this patch dealing with dst_cache only.

@Steffen: could you please have a look at the possible UaF mentioned above?

Thanks,

Paolo


