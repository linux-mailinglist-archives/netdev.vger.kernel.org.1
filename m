Return-Path: <netdev+bounces-281774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC2KJzKI8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:13:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C224825A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E18330128C7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB53E3DB4;
	Tue, 28 Apr 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS95XjTH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkBVQXYH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3A3DBD55
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371069; cv=none; b=AGbq/qZk9Hw9Mi4YzCBt0e1odxJQNmlfsmRY4Ks6nOLucBD4d7z7pffRKUt63emIpiBQD5U187IUCeIMEZEecqrtHoTvTcWi5X6d1VKuBUoC7Lu5pqq+ig6pMbAdFzSTn2X41AHIhFw/B6+mxjbQF+CcRPNsoIC7qKzUNivJMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371069; c=relaxed/simple;
	bh=31yeDrnmMMRschIioKbLjRlz7ASWelY2uXY9By9pwn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmNx7RA5IVdPWCmzt2fv4qaJgXwCwijr0hbx5It3/4O0bH3/ktHE1P5jW6toc7Z7l7/z9U2qrmKN2qk6IzTfdDifIbQRrk72f5pSN2EKhufjkoViz6H3IYE0c/OljAZaSBEq2rZ67QGx0zvf2TDIJJ/V0vhiZC/UnqXNrF9rnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS95XjTH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkBVQXYH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777371066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHpDxmZZESUVp790wiKic/ZdGJVu8ziS4BXr845PH6o=;
	b=cS95XjTHl3L4pOwa9kN4zmFlVRQJt2T6khSkZ5dm/mbGhc79ZKmMbixf+fOwlHgnEMfInm
	Ncu+DjHEJY3W5H+tD/sN4AXT9Uo/VKa157OVjBu+gg+rigrARBPYkhN7HPhBN5qlgSdzw9
	O1nHGZk5QCPlF8x0XYETDDHbqQ4Au/g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-j0jFBdqJMuWdtOisqVSFOQ-1; Tue, 28 Apr 2026 06:11:04 -0400
X-MC-Unique: j0jFBdqJMuWdtOisqVSFOQ-1
X-Mimecast-MFC-AGG-ID: j0jFBdqJMuWdtOisqVSFOQ_1777371064
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a5952c635so68077045e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777371064; x=1777975864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHpDxmZZESUVp790wiKic/ZdGJVu8ziS4BXr845PH6o=;
        b=WkBVQXYHZf6hd30dAIN3Uxe9L1fENUGVc06Ah73dI0z386xBllvJdzgfLslHoqM/yh
         MczN8VVl2Zak7HdgV/WKJJ9KXTePThlZHBpOjRA/At7S6N+V+hl6GhNCVeZS3tvTl1S/
         gUYGLyG2IDPhp4Yq1hpVL7JF1eWnS2ps76xYrDGJum/dc5y23gVnDhe9hRQjLAEHNt13
         vP7m9IPNOOZ34Hd5SdV+zBnOqhPT7Jy9KDM0z9MM7uTajJyswBDvF8NWRCSyrw14wFrB
         GVDwYWFGhjshd8ia2FQzWpuXZ+W1v7hHsrHI7CNTdlAn599TDD9B4aEg7mMn9B0ec2fw
         rRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371064; x=1777975864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHpDxmZZESUVp790wiKic/ZdGJVu8ziS4BXr845PH6o=;
        b=sxrNTuKJGx4WnwDBMn9luUHq+tGWArv0VCvZzCRh44XJpYFTM9ZOM9q/JFJZhChEM2
         Vc+SUTWOWDRvY0WBwq82TAdSQOmvzzHPvLMoahqIKVqS99wN/GRiu88r5jpAmtpF1yDJ
         SiNJhHqvO5232siSywxbGjvAerjOe7YBoz54nXoEjw/XfdysVfqUJ6xUzVncoEi4OQuR
         7l4dK7tB+FGI3k4EElSAVL0iSJ3tT+gRUmRsklwd111Ep4jPgARwG/ehQuqEaW7DrIaW
         pFRU6cxCdgDrqsovOmqQPqImj23zK6o8VAkII/dtnBqzBfkJNr8U2uZ72qZPzj9oF+uz
         8k9w==
X-Forwarded-Encrypted: i=1; AFNElJ8iEBezzPr+ZHGJXrwvWMJaoV1YxIp6vXB2z9JN+mHf1xSuenleOlyiTaWNDnC5bjmSSHr74Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAx+Zyda2eHEtOqoQtLX3ndeXEJYSx9cwYAzqrHAiDkmrf4U1
	mnKWrnNX5pxVgcC6s6DcdIGJsXBik1u9DICxRq+0FJtEBGM64KnLv63HYjPyj0Bi0ndpJYojyne
	2IyzETLfuNIhoF6Jh9wsiuvr8YS1z7pr9hGFK1B+yuR2T5DHrl8KYg5QzMQ==
X-Gm-Gg: AeBDievQKzX91nJ9BQAB0fYHQnK6CxqxQZlt7VwAg7tqCCCspqVPbkOc5kJapncoS7+
	4sJJY6kErhWVGouA8GseAQmntwsuyXgyV8l0hY4LO2TYNeDoFFhXDVNiyp7w6Ix6xgd0+qtrC0F
	k7zqAUaof4Uec4FM97L6LPZbxHIbg3xBx49MqcvpDo02z9djPT6RjvXJpOvnAil4+7rzpENgYdn
	zCmuiRBRSh88q17iO92yo4bD7x6AROi0DRTSgK96owsdWChtRXwXgHFMY8BpLbZVRyLnYaT/sEY
	OTBw0ubbfWkwCOHfJ0uocctdsWFQ1+EkQo+4Qxgb5dDD9fRJu7s4MFlc4E1NE320zgiPF9286KA
	A4zZTG4VBYsX9VMNDAyI9RBlasym1W7ofC8pVcA4YJ25eHfKyMDMZStqHEGttxhWOfA==
X-Received: by 2002:a05:600c:4593:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-48a77b1c76dmr37493885e9.22.1777371063570;
        Tue, 28 Apr 2026 03:11:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4593:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-48a77b1c76dmr37493375e9.22.1777371063099;
        Tue, 28 Apr 2026 03:11:03 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775ec57fsm14899665e9.17.2026.04.28.03.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:11:02 -0700 (PDT)
Message-ID: <03a1d7f1-d40f-4e2f-b61f-0d82b0dcbf05@redhat.com>
Date: Tue, 28 Apr 2026 12:11:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net/sched: cls_flower: avoid stale mask
 references after delete
To: Jakub Kicinski <kuba@kernel.org>, jiri@resnulli.us
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jhs@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 sbrivio@redhat.com, vladbu@mellanox.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 kanolyc@gmail.com, z1652074432@gmail.com
References: <20260421160303.1919562-1-n05ec@lzu.edu.cn>
 <20260423115129.6d8cbd15@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260423115129.6d8cbd15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16C224825A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,mojatatu.com,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/23/26 8:51 PM, Jakub Kicinski wrote:
> On Wed, 22 Apr 2026 00:03:02 +0800 Ren Wei wrote:
>> From: Yuhang Zheng <z1652074432@gmail.com>
>>
>> cls_flower keeps filter and mask state separately. After a filter is
>> removed or replaced, some paths can still need the mask data associated
>> with that filter.
>>
>> Cache the mask key and dissector in struct cls_fl_filter when the mask
>> is assigned, and use the cached copies in dump and offload paths. This
>> avoids depending on the external mask object's lifetime after delete or
>> replace.
>>
>> Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower proto ops")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Tested-by: Yucheng Lu <kanolyc@gmail.com>
>> Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> Jiri, do you have an opinion? Feels slightly wasteful (as sashiko points
> out), IDK if there's a cleaner fix.

I agree we should try hard to avoid the considerable struct
cls_fl_filter size increase.

Would be possible to move the fl_mask_put() into __fl_put, after the
rfcount decrement?!?

Or possibly would be less invasive to set the fd->mask to NULL in
__fl_delete() under the tp->lock, and explicitly check for NULL ptr in
before access (AFAICS, each access is under tp->lock).

/P


