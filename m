Return-Path: <netdev+bounces-278928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +WAxKyF14Gm2hAAAu9opvQ
	(envelope-from <netdev+bounces-278928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7B40A673
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FC53056286
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5133BBAD;
	Thu, 16 Apr 2026 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZxnaVVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAC361DAB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317724; cv=none; b=N8pDOK3fojAm12GnOSjBcFfB5hU+JWwD9p28j5JUAfipDtQlpcKs93qwnsd/6R4gfFCo/5jchisLuNK2JZIPd8kotN2mXZrDjdOrmCwLwb5pSJq6x0SL3R0b0tE9u1iXCcokWx16EqA5hjq86NXuFy0fKapPhaQR8N1nGAFz17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317724; c=relaxed/simple;
	bh=wfuKNl81vcLBESyJ/WSUA2R7MDOlTP6g78Vq8lsrZcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bu463Fn3KsufqBnexPOOYxVFbFFZJDlVqlQ/ma6jeJFwwgE9hlBcSwNJTI7A6MxTLwyWMZamhV5NX9SLcrl+PnrtIRPv47UZU8eDFyd6SBAsNCe0bUJUWo6Jc2QPLTq2KZ5MtmoaR15gp2gs7fbEYW+b5qCnt5RKW2FICC+ynbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZxnaVVJ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso7802055eec.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776317722; x=1776922522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgpQWKE1SSEzde69n2CviM1cZRQ6zBZdEhKdH+Htau8=;
        b=WZxnaVVJfH8VbpCj8Bc9JyFN9no765qTnDqkxEnL6RLYcWhikMFvQYhK3nxMGKhJ+7
         hmQPPRrzoPSvf0tRFM1qWFw8AJuH0CMX0bthvSS1f24MArW1yhkamlRCOQwmDcyjcv5N
         s03+dEHVCd70nkd+uFUJIq99fJQeVIwxA5GOSNW72QqBelPUTq5HCJSZCcALWty93uI5
         46bVXElXKjDtNQ6XSGWMdafYcp0Gxk0kq126KKcuKPqHTzZ3zITx2P7OzykKQbyMm/gA
         1DbBBCuJjL1Z/+Mbcpk0QPExrq/gc0f+N23sattZvzMY57tCgZRbw9jECzlcl3lLGFaX
         WzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776317722; x=1776922522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgpQWKE1SSEzde69n2CviM1cZRQ6zBZdEhKdH+Htau8=;
        b=IZt6VCWypKE6YuVazJZwozXpDOvZgkVAVU6wBjdBCY66b0c3VURT8GKDackdZQT6BS
         zzB9uRQtPa/CkEvIfEUMAf2dtJNrikOgrqCvx1C9tDuKavVv26tp+zXaWK0nsh3oby+c
         7eCU+6h74Nq8O5xa3tz0V4tsyzz7Q4SphsFU1fsxVc1BbQotr7LxB4+WBw/0Tnly7omT
         v/iOzbjCXCUZ5TelJW09XOa4W1LJWN3uPQ0gtJLGxUtcz6oGIxvXJSlAqb8She4giz36
         ZnhNUW+4NdrhxROxnkRe5ZR6SwOyc1kNrYqk762htcH8p/GgOa3k8cC064OHVP/zgHpe
         lF5g==
X-Gm-Message-State: AOJu0YzTIZvcFxKDzltd26i88eByRrVZu4SlZgGJCQWBk5Z1yqF2movC
	EGu4R6Q7tjLIs29Rz6cQy0sSEmvLd6zrm6qo3IVaNTBWVHqh7SDMlpcC
X-Gm-Gg: AeBDiesJNXQZAp8Vj+h5tCic+hbNpo0MWCPaD9FipEG51NVnIK5itHFYIvyCQqCDVUE
	M6Azrdz7G3sEGVXfMMBeXv6WEam0H80zudeUa0AJfCZW9+8uRVWyrqwOdrJPdrSw6An49krBX41
	KWOXL5zRQ4G8o5uIGoleNqQ3FDxzQ7biKmR4r+yJB0ecBfePGT/LdCLYvbttg6U9jpq+pCjPlVW
	h3Z8vS0gjEFBNRG0wegQMlr0Rh9NBBGJTrOSvoXhlxA9HukYCmHPOZRImgMayohkQFtUpp9UD/x
	+v1U8mH2AG0c5y9NoqVBQJYN2oG1fQf2vfbHt6IWth9iyF8cJjRyDyAv8ehNrwusMWYfgdDL+a7
	iVzYGlsVDDAHbPGOl2jyVkX67Q8bEhqRZNAOZEHXRDxKIpTrbiDsYKM57aHGOyXsBxVRYfMtgUu
	wGdGpFqh0vNdbWM+y9fG4cgyRFdVrFvI8aPIyGd6oo8tPBCHfSt/RRF2hS/SaV0aIRWbR4gIHLJ
	z7xUSWeytjknnOpIXr7BuV/XQ==
X-Received: by 2002:a05:7301:1e83:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2d586380895mr11962659eec.2.1776317722024;
        Wed, 15 Apr 2026 22:35:22 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8fab:d47d:714a:b947:7290:ba86? ([2607:fb90:8fab:d47d:714a:b947:7290:ba86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8fa5efb6sm6112944eec.28.2026.04.15.22.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 22:35:21 -0700 (PDT)
Message-ID: <d22967f1-789d-4f53-baa8-492f64fc725a@gmail.com>
Date: Wed, 15 Apr 2026 22:35:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] 8021q: free cleared egress QoS mappings safely
To: Simon Horman <horms@kernel.org>, Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ylong030@ucr.edu
References: <cover.1776039122.git.ylong030@ucr.edu>
 <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
 <20260415151545.GM772670@horms.kernel.org>
Content-Language: en-US
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <20260415151545.GM772670@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,ucr.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ucr.edu:email]
X-Rspamd-Queue-Id: 6AC7B40A673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/15/26 08:15, Simon Horman wrote:
> On Mon, Apr 13, 2026 at 05:07:20PM +0800, Ren Wei wrote:
>> From: Longxuan Yu <ylong030@ucr.edu>
>>
>> vlan_dev_set_egress_priority() leaves cleared egress priority mapping
>> nodes in the hash until device teardown. Repeated set/clear cycles with
>> distinct skb priorities therefore allocate an unbounded number of
>> vlan_priority_tci_mapping objects and leak memory.
>>
>> Delete mappings when vlan_prio is cleared instead of keeping
>> tombstones. The TX fast path and reporting paths walk the lists without
>> RTNL, so convert the egress mapping lists to RCU-protected pointers and
>> defer freeing removed nodes until after a grace period.
>>
>> Cc: stable@kernel.org
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>  include/linux/if_vlan.h  | 23 +++++++++++--------
>>  net/8021q/vlan_dev.c     | 48 +++++++++++++++++++++++-----------------
>>  net/8021q/vlan_netlink.c |  9 +++-----
>>  net/8021q/vlanproc.c     | 12 ++++++----
>>  4 files changed, 53 insertions(+), 39 deletions(-)
> There is a lot of change here. And I'd suggest splitting the patch up into
> (at least) two patches:
>
> 1. Convert mappings to use RCU
> 2. Fix bug
>
> As is, the bug fix itself is difficult to isolate amongst the other changes.
>
> Also, AI generated review suggests that this bug was introduced by commit
> b020cb488586 ("[VLAN]: Keep track of number of QoS mappings"). If so,
> it would be appropriate to use that commit in the Fixes tag.
>
Thank you very much for your review and suggestions. We will try to
revise it in this direction.
May I ask whether we should include your “Suggested-by” tag in the patch?


