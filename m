Return-Path: <netdev+bounces-147882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F270A9DEB88
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BA728246D
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6919E99A;
	Fri, 29 Nov 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUf9Gk0W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD12C18C
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900399; cv=none; b=oKPrmyl/DO7xSomDl7ZWcZMedlWtZVE06hsKcTv+0XcktB+9bt6pTwAkAZds+uIu85v95W16lBnJwNqgqJZclqsubV+oMAnMMdQPGEog05Ep7wp+svDuT++eHwX3dGpqonsJeAIQQxFaRum4DmtjL2TjTs2CRlqlBvJSCL28zFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900399; c=relaxed/simple;
	bh=fwX5PilPPQ/nTbDVHOkVu8G+mdiA/sLxP8jqzC6dEps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1HOC78DBDHAdAfQu6maE/TzXYYfhAw0OgW7JFNvjP1W6R3AxI0J0x44+D43xZyzHKFM2zXb0tg4o2YlDxsUhFQzoyTGIs1FVvmjw+/oM2a2uSummauFLah7stRAbUlMsS0bm6W46Gtkcn3MV3UsSAQ5MMQJ1c+UsElJW7PyNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUf9Gk0W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732900395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80ml9lvTWxjPXWs4oXjdfP1Zf1OuxneTzA0YgFL/sFw=;
	b=WUf9Gk0WBu7tWjVKQ0FakwlEEBxlF3fmS9aUVv2TohNUbZNwJ0VT/saoY/yhs8NmyqrZNp
	455LE0DlDPAHgHIwcEfBS8Nmnb2gu7y0VA0rxQyMagqKBLW1GgKCg5yCHLL88Lt1ywm/Vf
	X1MFSY449vWwXGwug+523xV8lJEWqrU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9Pfiu3DvN-OVF2BFXGoirw-1; Fri, 29 Nov 2024 12:13:14 -0500
X-MC-Unique: 9Pfiu3DvN-OVF2BFXGoirw-1
X-Mimecast-MFC-AGG-ID: 9Pfiu3DvN-OVF2BFXGoirw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381d0582ad3so1391280f8f.0
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 09:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900393; x=1733505193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80ml9lvTWxjPXWs4oXjdfP1Zf1OuxneTzA0YgFL/sFw=;
        b=iZziIKS5jADkjYItClJ4qmLyYKz9aOk6aU1rR/sj69gn64LWLaT0NZcA0defimxe/n
         zaLECfFDkU+JqXSy9mRD4nJQMYwhypkz66ldHy4e+WBFhSIjcWLX6/GoslAzXKIzav0C
         Dn6JY0joDuKTrUNE3Eod//bIptCY7OCS1xBgJ81ssOnv+Vj7VZJLeprWuUCRX+4EJhPk
         If1TKxuK+QXSx12NfJ/ii22GFWPx+IXKMLRUi41kj+4kwd8NjHSwzCFFIu6IIzKEqylt
         3QBQkYVO5Czy6eBdPp89HZiBLc3F29EnMBG/gzptFfvIt6MaHTbPbAhPL9IUyrgp+iBP
         vvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4cDG2qkPNbwGGuqcnK/SN7/LziyW35Rf9NItWWHt8i2qVhFcqMiEkbhVExIgoK5Hktsp4jXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7exmBX6/FEi+9xR+fnz1PG1MA3zT/o7uIW7Rkd2fuy9M788T0
	5Gt8uMOWdZzOc3v6fg/eBWVRE1lxCRnz/3BMJhJkF0e+/n5gGK83oO1adjuAoXzpOM85cx/IsLD
	E0CKTn2U1l5po3r1SJV2JcvOYkp6hpfEYjWNd16/EufClLBX8B6Rpxw==
X-Gm-Gg: ASbGncsXrIK9YlLWAXdRXhokbubJ3Ai+iy6CnyYqPDhV7Z5f2dl8VzxZhP+ivCSx8jT
	a7O0umHE1SJXFgOO9ABm38ZM4c7LA3u95hVQ91U8agSIafLqxWyRF1B36Jyw55ElaZFcEGVKG09
	hgYjqU5IA9bofKdfEnx0+ACRpXJeB330YMl8Z3RYvALrGKz3HcuC4Cd88/b7wIbPkNH4wX/Ohi3
	c1MkhjACaJB2DPtUA2H28+c5w1mGK3/sUWXwkqYUCcMOku5EXbdSxo8RYaAstmTaSsbupaWpVa3
X-Received: by 2002:a5d:6c65:0:b0:385:e0ea:d4d9 with SMTP id ffacd0b85a97d-385e0ead709mr2516579f8f.14.1732900393053;
        Fri, 29 Nov 2024 09:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU3Ek+urKrzT2ns1OpjHqj154hAhb0Bo+ykKlmZhAVH3Od7w5nA8f5/9YcthNy9ujyoP48/Q==
X-Received: by 2002:a5d:6c65:0:b0:385:e0ea:d4d9 with SMTP id ffacd0b85a97d-385e0ead709mr2516522f8f.14.1732900392568;
        Fri, 29 Nov 2024 09:13:12 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385db37debdsm3273329f8f.2.2024.11.29.09.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 09:13:11 -0800 (PST)
Message-ID: <7eec1423-d298-4fc1-bbbd-b4a7ed14d471@redhat.com>
Date: Fri, 29 Nov 2024 18:13:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: tune the ipmr_can_free_table() checks.
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
 <a4ad9242-2191-4f64-9a92-25d11941cf2b@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a4ad9242-2191-4f64-9a92-25d11941cf2b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 18:01, David Ahern wrote:
> On 11/29/24 3:23 AM, Paolo Abeni wrote:
>> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
>> index c5b8ec5c0a8c..d814a352cc05 100644
>> --- a/net/ipv4/ipmr.c
>> +++ b/net/ipv4/ipmr.c
>> @@ -122,7 +122,7 @@ static void ipmr_expire_process(struct timer_list *t);
>>  
>>  static bool ipmr_can_free_table(struct net *net)
>>  {
>> -	return !check_net(net) || !net->ipv4.mr_rules_ops;
>> +	return !check_net(net) || !net->list.next;
>>  }
>>  
>>  static struct mr_table *ipmr_mr_table_iter(struct net *net,
>> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>> index 7f1902ac3586..37224a5f1bbe 100644
>> --- a/net/ipv6/ip6mr.c
>> +++ b/net/ipv6/ip6mr.c
>> @@ -110,7 +110,7 @@ static void ipmr_expire_process(struct timer_list *t);
>>  
>>  static bool ip6mr_can_free_table(struct net *net)
>>  {
>> -	return !check_net(net) || !net->ipv6.mr6_rules_ops;
>> +	return !check_net(net) || !net->list.next;
>>  }
>>  
>>  static struct mr_table *ip6mr_mr_table_iter(struct net *net,
> 
> this exposes internal namespace details to ipmr code. How about a helper
> in net_namespace.h that indicates the intent here?

Makes sense. What about something alike:

static bool net_setup_completed(struct net *net)
{
	return net->list.next;
}

in net_namespace.h?

The question is mainly about the name, which I'm notably bad to pick.

Thanks,

Paolo


