Return-Path: <netdev+bounces-256613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AImdJP8Gg2lLgwMAu9opvQ
	(envelope-from <netdev+bounces-256613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:44:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E17E34C7
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68AE307D4CA
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B3395241;
	Wed,  4 Feb 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K43YDj8b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB8pwo55"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3471D63F0
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194422; cv=none; b=roF02U21VL07iaYUgejCJfG/lO8mlnRaHH8lpe8tJa7wVnKKPKJd+/Pts13Vo1B2VccHycoJvKOJTVnGGnuLTsQaAohK1kSLSXFXqbJ6NaVicWRuEX0l1oi3yiyHlPcN90Pmec21ae93Fj+Rynf/UsKMtby0yQZPRjEKSb7kUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194422; c=relaxed/simple;
	bh=3+L6PI4GMuiQHrHIZb7E3cB/vnOAJRDCFkosOULZ/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBsA6CWmDzBTjrxPMv4CdGxJhSsu6Hlhaxd++C1Q4FOmyYup2JJy352SAjqAjJQwEiFeMJltYUPwvDjbS9Q5JOvsOWkVgc31q3v1pkbDRfMYCrbfPmbXS4e6jxSu3d4p2o1QAZAUeydqpnx4h45Sp5VxIM7DX7ncw5vM4z+JWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K43YDj8b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB8pwo55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770194420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6IMhKc2VzBHFc6lr2fAv4BQhS3mPy88vUETyFpbphk=;
	b=K43YDj8bHH1WNZUYAGOlGhuTA5b94i4QpLOPa4jVvbLIoEtcSUqo+odiPmHEU8fWvjc9v3
	l+ufYBMJdk80nomtIdjQcZZtsuVSlplnes4MllIJxepcEp0nqD2wv+aLDMITxt2hN6lhfi
	drMyPaNOxwNG+zL00AYZc4scMh4Giv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-CcZBxRQJNread-T_pAvSHw-1; Wed, 04 Feb 2026 03:40:19 -0500
X-MC-Unique: CcZBxRQJNread-T_pAvSHw-1
X-Mimecast-MFC-AGG-ID: CcZBxRQJNread-T_pAvSHw_1770194418
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so75006055e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 00:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770194418; x=1770799218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6IMhKc2VzBHFc6lr2fAv4BQhS3mPy88vUETyFpbphk=;
        b=HB8pwo552XaEMeNYdhFoL2wR3MhNe3FJ44k/aa0Y69Dzz0Xz42cae6fRvNghcRRibl
         CPpxl8Gc6bB1ZxXkdU8ojTlbZrLwUgwxrQa+adN5l2l8/1aMIT/3GciiRQKkppZCejnl
         2Hb+UT+IYJ3rHCohLxtNSWVqCtDWGgtuGpGTY+qD6CHls2+6c2cedPMUy6p49XPFiBFs
         QYC1J/2NKWpiA4SCR8rkFsZJ6yMKA64s0+hwmzTASVreB2l6V/6xyCAqC23/BRFgX7P3
         KCUMhLvcm/7+5D6+MiugpkEfzskdkZFKOQaNkWWsb3j2Ec8YplZGOMbDQTawPS3bm3ty
         VuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770194418; x=1770799218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6IMhKc2VzBHFc6lr2fAv4BQhS3mPy88vUETyFpbphk=;
        b=DK5Z8+O/6ADiHIMP/rYhBPCgXwYDcCEWIT2kCnVbXHN72UnE+subWU7MKI/iy4wZzg
         NdDIsjEnvSuEEGi9eEKEy/dnICjPsLInJLc4TmuA8+wy458eGywgjeCmHWRUxJ/wp4hA
         1cA9R2XXZ/ZoAtk4gDPcPcNDmjzskgefAZ3KCDRc0EAZ0l8Z9ib2FWjgee0E+JYy+xoX
         2D5jvnTiz3oSCYH2PK0FDWUCSyja7XibzJwnF1VwWQlPYSA3Gnc0L11RKVHG7CmaVTYg
         57BlfZf9Fb+1eE9nlzTIZ2Gy+3ESLR7AxpTe9kMoCf9IlrOJSxsoJJMP5ln3bz2agZd4
         bUzw==
X-Forwarded-Encrypted: i=1; AJvYcCUx2drWWiY3/+3UuJ3q66dA74unSxjOitOSu/uMOZMIp+iZVG9QOitfT7D5c4NpiJXGTO1CW54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDvu6veLHbW07Mqff15vVXdzQkeakvtahD1mCQlA0UbN9r998
	yj+ccFYy9F7iau0oXb6hmXpzLcd3E3KP5xaL6pRlzHjB6V+l20Jjza3xlOhS7+pAG9e8cikycgY
	FUJtG8YmO6FpVoR20T3DX0sMVB+dzRQFDnq/wcgxdzhmHYlJqrRba06LWZw==
X-Gm-Gg: AZuq6aJSAREkZYjAXk0/Q4VTKN92yaGvxHbhyIp2UUbzDb6tkkVFhvxOYd/kvMI1Bm0
	SwtztA4P+/iqvU7Xex0YrYLw33zu5u6SiMS+K9et7IPJqAD4ZolRfbiANFlXpTAe7eRUc9mp8DZ
	mvBJSxAWmh3160LH+luD0aOC5eA0ukVwaYpXqC5gdm9H8o/NwSVWu2LXDU686FWXR1zk/5cAiut
	+JaYZkh0kLKQP+O6ilGkKuVdH1/ZkyTFsxQPdKJspY4Gp3BeGesS8vpesSUKHRqF6g736kRCrfZ
	iSi/7uAkndSp/92vbwPP+AaqlVNFuOt19xGjQCB9VR3TYJz0gLCT5oXCWaX/ZESvbLVqkav9f7T
	Awb3ECpjDW0ti
X-Received: by 2002:a05:600c:3549:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4830e92cc18mr30995995e9.1.1770194418124;
        Wed, 04 Feb 2026 00:40:18 -0800 (PST)
X-Received: by 2002:a05:600c:3549:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4830e92cc18mr30995685e9.1.1770194417736;
        Wed, 04 Feb 2026 00:40:17 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm14137265e9.19.2026.02.04.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 00:40:17 -0800 (PST)
Message-ID: <eb700d8d-81e0-4c56-9cf2-48473404563b@redhat.com>
Date: Wed, 4 Feb 2026 09:40:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Dan Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-8-danielj@nvidia.com>
 <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
 <a3aec539-9468-4273-b7fa-6705331c9b92@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3aec539-9468-4273-b7fa-6705331c9b92@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256613-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23E17E34C7
X-Rspamd-Action: no action


Hi,

On 2/3/26 10:40 PM, Dan Jurgens wrote:
> On 2/3/26 3:19 AM, Paolo Abeni wrote:
>> Hi,
>>
>> The AI review reported a possible issue that looks valid to me.
>> Reporting the feedback manually because I think only one to the AI
>> remarks is valid, see below.
>>
>> On 2/2/26 6:05 PM, Daniel Jurgens wrote:
>>> +static bool validate_eth_mask(const struct virtnet_ff *ff,
>>> +			      const struct virtio_net_ff_selector *sel,
>>> +			      const struct virtio_net_ff_selector *sel_cap)
>>> +{
>>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>>> +	struct ethhdr *cap, *mask;
>>> +	struct ethhdr zeros = {};
>>> +
>>> +	cap = (struct ethhdr *)&sel_cap->mask;
>>> +	mask = (struct ethhdr *)&sel->mask;
>>
>> This function casts sel_cap->mask to struct ethhdr * and accesses fields
>> at offsets 0, 6, and 12. Shouldn't there be validation that
>> sel_cap->length is at least sizeof(struct ethhdr) = 14 bytes?
>>
>> Looking at virtnet_ff_init() at line 6291, it only checks that
>> sel->length <= MAX_SEL_LEN (40 bytes) but doesn't enforce a minimum
>> length for the ETH selector type. If a device provides an ETH selector
>> capability with length < 14 bytes, won't validate_eth_mask() read beyond
>> the allocated mask array?
> 
> It won't read beyond the end of the array. When we retrieve the selector
> caps we make sure the that the size of all the selectors and their data
> is less than what we allocated. So I don't think this is really a bug.

[sorry for the latency]

I'm possibly lost, but I do see such check for classifier->selectors,
but I do not see them for ff->ff_mask->selectors, neither in
get_selector_cap() nor in virtio_admin_cap_get().

> I'll change the check here to be sel->length !=
> get_mask_size(sel->type). It'll fail in a clearer way if this is the case.
> 
>                 if (sel->length > MAX_SEL_LEN ||
>                     test_and_set_bit(sel->type, &sel_types)) {
>                         WARN_ON_ONCE(true);
>                         err = -EINVAL;
>                         goto err_ff_action;
>                 }

If you mean:

		if (sel->length != get_mask_size(sel->type) ||
                      test_and_set_bit(sel->type, &sel_types))

LGTM!

Thanks,

Paolo


