Return-Path: <netdev+bounces-280690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAxZJhLy6WkzpQIAu9opvQ
	(envelope-from <netdev+bounces-280690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42C450838
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E66C3070378
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493437B41F;
	Thu, 23 Apr 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+cAcZn0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3EvWZNi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF43793DD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939206; cv=none; b=tuj+UXI4F2J0QEoPpVLyakmqIE8R2i1DcdysugoK5pJPFqwl/qmyrhXMLLP6ks/FkVea3EQlr+J5NKkdQn+hhHaHFDei3y1wpK9BmW5qSqst1h418ZndONgAxBExaPSLUOr6efPjw4di3X5QfhN6EoKSSyXawftGnZEvzSoke+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939206; c=relaxed/simple;
	bh=2REbWSVv6SJOy7FnA2tVcEQgkIZf2TRIcOEhVdMfb0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIEDfMAAbsnK3TiRsuZcgRT5c0uBJqz5mdhD+L4vI12n3ATof5SGL8DMpxuLtqIWSL5aycq16b22XE2o16YgUV27dLBkysaIJNf3yE0CrKSgoGwiRxKJ0ksi8OJKic3G9iG7nusDziqUlLU5oAAruvL20ByQdFRPKH4KeTXiAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+cAcZn0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3EvWZNi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776939203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QkTAY0cWRY7AHIF+qIX/Mtw1Z0EQWzt9k3+TnQSWKLw=;
	b=O+cAcZn0H13VYQde+lko4VpeniIxsUzGdHV8afE3K6fQKejs6646EUjWnhUcpaoeVhKIkY
	8WmvwtX7V6TLJJbNhv80UzokENBAATapANo24RI9P0k8pxFAcfu9+BlgKjiUbJL6Sgqcs0
	rwi7ozcRO7Osm2EvFHaeILWtO6FBjaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-9UguDlvMP0SjeurV_9poLQ-1; Thu, 23 Apr 2026 06:13:22 -0400
X-MC-Unique: 9UguDlvMP0SjeurV_9poLQ-1
X-Mimecast-MFC-AGG-ID: 9UguDlvMP0SjeurV_9poLQ_1776939201
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a5adc12ffso12767635e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776939201; x=1777544001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkTAY0cWRY7AHIF+qIX/Mtw1Z0EQWzt9k3+TnQSWKLw=;
        b=N3EvWZNiuM+BbQdXXECLX+hk8dXQT0BGkYWG92YTbk1O0xeaFCuqqQaSDWFcFDWPIz
         BWvAKH4RRdEb+0b4nwCbo83khtAYDFph0CJE+Zena7o6BxhoW5AlObHt7WY8iAqc/UDO
         FG8kSC+dOiUQXxsPxxetq/P2FkFWrYYDfdXW+poazopJwCACrQoBjQ9jklLjwtkO7OcT
         rf8eIxgjkd1Pmeh+Wii1WVsRT9KmgXGfqSMNemuH8I2IV0MXvSWag47uCH4wEdmujcB8
         OTxk7+Bq0KrUJpf0hePHqzdE4GkKZibItq9HRE6Cigudh9XM0vo1cc0j9ROJBEgeEIMz
         sVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939201; x=1777544001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkTAY0cWRY7AHIF+qIX/Mtw1Z0EQWzt9k3+TnQSWKLw=;
        b=CW3kpVS1nuZ5vifqCy6W0roH6ccvWczN93Vt9JX9rzqARb/eKzibyohY+zvlnt31XC
         R9+zZR9ijsufLk6wpRc2nBK1i2rigZcfn/bp01Nb7orsZIb4drs/AtvFQTHnY5ld58QA
         z/dk6k8tVenlLLPKe7iCHy2vcdcldtJ/uPLXtoF3Svw09H/DZYOlOjkZ3nP+DbYPhw3O
         1KH9cu1G6Giu2zwHNa4yt9NIMMUTwio147VLbowvB+/36qMB5MYuDzklSX8LKGlWr81t
         1rDRc1w2uwqpwZiL7XY47CAqUcErFTbo/FrO7Ic+/MrAWs5uLLhI3P85i/7IMPaA8bzz
         TGXQ==
X-Gm-Message-State: AOJu0Yw7CNZ6sgwHUmSDXYANLEwGhoxUEcsIjUDrd2j5OVyMzhbc1mDA
	YujQpd5Ewk6A2ClIoD3RuGOfTfr4vYD0OXtJxczzwYY8FzUUXXXzZrulR7QAuUJQsW460UiaYp7
	NoMl/hhgv+fFT2iKvnwJvXc1uUTCmIgIxi6kmaUjYMxmtnT3eXShBEYetVA==
X-Gm-Gg: AeBDietAQ/3QkUtpCJdkNq2A/fI2QMg/WqjiRb/rqGxjNXvfJRqEkNrTGTCUr3uvHxd
	wQPwymh3qCvgfl+caDLhaMgvD87rP8vI8da0JqO3oedo+dZuUL6sYkRuN1w7znnqTwY3TT3To67
	r3WZsx+MWs+YYU/84n/BoQAhAFUgK5JdWQ/+MCyWry3GUdA/1gXPYnKYcjv8kU+jK1GjUO2ru4l
	ZIV8L6S9byU5csC9OhLyE4Zp0Ju9SKy6Nw0ZOsjo6gCoBFS2Xhfhy0BVx4BEcGEYzEDmMwEKGG4
	k+LVfrZsqezuJmymz/fVmVrcWslPaOusgQouJWg28v9DNPppWVx4p2zDZasQLA00SJmzF4heibD
	O//aCBXw0paRYrAsdOnUmGdEUMVa+oWH5WeP0LO37rrdKRyXPrglXU9XgIgjXyOM7tqU=
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48a592ce89emr113247815e9.14.1776939200869;
        Thu, 23 Apr 2026 03:13:20 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48a592ce89emr113247435e9.14.1776939200401;
        Thu, 23 Apr 2026 03:13:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm582390305e9.8.2026.04.23.03.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:13:19 -0700 (PDT)
Message-ID: <8bae5082-b086-4c22-a19a-3a3c20c827a9@redhat.com>
Date: Thu, 23 Apr 2026 12:13:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] 8021q: delete cleared egress QoS mappings
To: Simon Horman <horms@kernel.org>, Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, kees@kernel.org, yuantan098@gmail.com,
 ylong030@ucr.edu, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn
References: <9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com>
 <ecfa6f6ce2467a42647ff4c5221238ae85b79a59.1776647968.git.yuantan098@gmail.com>
 <20260422162041.GO651125@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260422162041.GO651125@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,gmail.com,ucr.edu,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-280690-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ucr.edu:email]
X-Rspamd-Queue-Id: EF42C450838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 6:20 PM, Simon Horman wrote:
> On Mon, Apr 20, 2026 at 11:18:46AM +0800, Ren Wei wrote:
>> From: Longxuan Yu <ylong030@ucr.edu>
>>
>> vlan_dev_set_egress_priority() currently keeps cleared egress
>> priority mappings in the hash as tombstones. Repeated set/clear cycles
>> with distinct skb priorities therefore accumulate mapping nodes until
>> device teardown and leak memory.
>>
>> Delete mappings when vlan_prio is cleared instead of keeping tombstones.
>> Now that the egress mapping lists are RCU protected, the node can be
>> unlinked safely and freed after a grace period.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Cc: stable@kernel.org
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>  net/8021q/vlan_dev.c     | 20 ++++++++++++++------
>>  net/8021q/vlan_netlink.c |  4 ----
>>  2 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>> index a5340932b657..7aa3af8b10ea 100644
>> --- a/net/8021q/vlan_dev.c
>> +++ b/net/8021q/vlan_dev.c
>> @@ -172,26 +172,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
>>  				 u32 skb_prio, u16 vlan_prio)
>>  {
>>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
>> +	struct vlan_priority_tci_mapping __rcu **mpp;
>>  	struct vlan_priority_tci_mapping *mp;
>>  	struct vlan_priority_tci_mapping *np;
>>  	u32 bucket = skb_prio & 0xF;
>>  	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
>>  
>>  	/* See if a priority mapping exists.. */
>> -	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
>> +	mpp = &vlan->egress_priority_map[bucket];
>> +	mp = rtnl_dereference(*mpp);
>>  	while (mp) {
>>  		if (mp->priority == skb_prio) {
>> -			if (mp->vlan_qos && !vlan_qos)
>> +			if (!vlan_qos) {
>> +				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
>>  				vlan->nr_egress_mappings--;
>> -			else if (!mp->vlan_qos && vlan_qos)
>> -				vlan->nr_egress_mappings++;
>> -			WRITE_ONCE(mp->vlan_qos, vlan_qos);
>> +				kfree_rcu(mp, rcu);
>> +			} else {
>> +				WRITE_ONCE(mp->vlan_qos, vlan_qos);
>> +			}
>>  			return 0;
>>  		}
>> -		mp = rtnl_dereference(mp->next);
>> +		mpp = &mp->next;
>> +		mp = rtnl_dereference(*mpp);
>>  	}
> 
> Hi Ren,
> 
> Thanks for splitting up the patchset, it is very helpful to me.
> 
> It seems to me that the mpp/mp construct used is a bit complex and
> stems from the use of a hand-rolled list centred the next field of
> struct vlan_priority_tci_mapping.
> 
> I wonder if things can be simplified by moving to use a standardised
> list construct, such as an hlist. And the helpers available for using it.

I agree hlist_rcu usage would simplify the code above, but I fear it
will make this already relatively big change even bigger, as several
list traversing places will need to be updated accordingly.

I think conversion to hlist_rcu could/should be a net-next follow-up.

Thanks,

Paolo


