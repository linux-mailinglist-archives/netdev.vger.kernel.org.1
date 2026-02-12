Return-Path: <netdev+bounces-258446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPlHExHDjWlt6gAAu9opvQ
	(envelope-from <netdev+bounces-258446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:09:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4C12D4FD
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B34930869E9
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F31356A1C;
	Thu, 12 Feb 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be4m1eKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvtKC8oe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004A3570B8
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898069; cv=none; b=ljcaMO8vF78Z4w/810IPSH4Dx5xHFyPbmTU8DvC4NQdYr4JgGjWeX8stRWfy5T1JDjrnqNg+3s3EUiU6ez+56xu4FduPw1ESAd9x3N1I4ErgTU8NCVCOWYkttrFH0G/q0KW62G7t+muhU4J0x5+WmoL+4sMXB/rIKIDR8o35nMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898069; c=relaxed/simple;
	bh=5ua5PZM7Z2mgMd4hu812b6fBC/PNkuiebTid3t9B86g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MnqwHVBdmaXS4Y9ImrzLLq2GdpC7/T0L5m9MKq7sVFpM91PMD29snHEmYQi5/D1qR//JmveCN/ztDVJ0edORjATHbjrRNRINT+qM9fECz0lFemka1/b4hF4Rr2K86p+QZ9xQ2c0G/Ak6dC7GXJRh8eKz0VoSHmhs+SEt4bJV0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Be4m1eKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvtKC8oe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOekXDRr8Jlh0YLli45CfMDWlgFjDNfanVrwHUirv3E=;
	b=Be4m1eKHZZuYB0bKEkRb1Dxj196bnBRgqZH9JkZGP/FcL9Yxpsw5u0czbOLFvHbk95WGsq
	BWEML1ySdFeeTui0DLAwMAX9FJGVelkom/AHVsmIY1T93da8oD6jBtPxvj1pMlGLdFKv/U
	kyVcDkbisfu2i9G1G4hiGhv9DGx7ULQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ltWfczqcNUuT3CZwXeFLOQ-1; Thu, 12 Feb 2026 07:07:43 -0500
X-MC-Unique: ltWfczqcNUuT3CZwXeFLOQ-1
X-Mimecast-MFC-AGG-ID: ltWfczqcNUuT3CZwXeFLOQ_1770898062
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso77151135e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770898062; x=1771502862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AOekXDRr8Jlh0YLli45CfMDWlgFjDNfanVrwHUirv3E=;
        b=DvtKC8oetXIt0Ua3zBsMZBMWlcBLhnt5li9OA4ni9rMuBzPGX1/758hLj4h8bi1vl4
         43qXynxdB86WVJ3RqJlbU3NbQZ1lBKNRQqrymx2BcffbFaobhj5eaoYvXelmo5L7XoSI
         vOKLYVj1PjutXbWhZJl4GPSnm6N/I6gm82bdMCuG7xXEnAemce9CpftOwIcVMJlmqQ4s
         ADiBJij9jpqjYpr0Kg4A2w7LmouYkQXl/MdW5HILBzFs6/RewMSCoDCLGdOVK1sNqncU
         CHGNsk0h8KFa5M42QhnXEqwtSjWKcmyPOtDmJHUFKmKaLnXmAF7Lkq+zeBHX6wwEDPfV
         ASgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898062; x=1771502862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOekXDRr8Jlh0YLli45CfMDWlgFjDNfanVrwHUirv3E=;
        b=BCfz6kfoH525o0mmFUPr9OI5Dz/RY501k1YwmacjcEvlAyyY/NbjD7aprGKiINWOFg
         uNSw4cDyNL7DS/aJxW13BzYNoa6Ex1XfobtJMTm0nrLrvqjOq5N7R+ch4+tb6swhBtrF
         tBtZMD4ZknitNbLoeovmoyex5vNpPYR39qCJAjXEPSZ0BzvSn82/McKd239mD6aIkHiU
         G4HKy69t58+Eg6JCt3Woug2SjjtNT6Cve8340VS5zsilCmgdQbvhpBUy936QK67NYG/0
         Awf6IDOBv1k4edSwwrStWn+oPWaB93KmE8MebOjpGDtuSjdkLG0WF03ar4fE4ijIgJxE
         Wudg==
X-Forwarded-Encrypted: i=1; AJvYcCW1IR2BN1W74kgP3HV+yN8eik1TMuu/wVVYCkLU2VkWFXkrlT5G8J+YMj491pmDKVwaOQbOBAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aITR9+UwC1LOezG4Z10+NEMuZqeR50S00X6LLhQCKd9RqykG
	GkK367FzH+V/06CMGDjHnN9x7V17GtHIwD+XhYPSdPVDhoYfZ6oGi8dvUF+CuvnJuqwY0iEeD30
	xYtFNVyCJpqmgshAIDmZoOm6SfVedvWgZf0jRNi76j0nOHLOEjH3/KUfuww==
X-Gm-Gg: AZuq6aKZLJcS8EmXlnlG0S+3lmS2S5yopdcLg+SRFj+C7yr50KzJzGW4NEu1cQzh5gB
	aPLh/5Wul4RaeivMYguFKf7rrOe2yhlbCYpXvqJU655NK2IjGDCp391wE8eYjeK73nln4GLqTEJ
	1yd437lsRrOMFVShq+gm6RmljCOpCi3uTPfXUG0zKl0zXNagHTYF2Mb8+lTHOcP/aqgkFi2U1R7
	K3DijPZga1wjoYDOSwQ81iW+jSrkkpjXlW6dPhzRxMIKFt37XcFXMH191WSiU2uJaGreJDEUB3U
	mNxgHbss7JTLZ7Ai/67MCwHIzWxlQmvgROQ+ydZEW6mpGXeZzNCD++yf5imfiWQnMYWnvv/+NOo
	Xi7DIK3pHTmzMx1snQV2Sw3io0Q==
X-Received: by 2002:a05:600c:a015:b0:480:4b59:9327 with SMTP id 5b1f17b1804b1-483656ae687mr36462095e9.1.1770898062419;
        Thu, 12 Feb 2026 04:07:42 -0800 (PST)
X-Received: by 2002:a05:600c:a015:b0:480:4b59:9327 with SMTP id 5b1f17b1804b1-483656ae687mr36461615e9.1.1770898062016;
        Thu, 12 Feb 2026 04:07:42 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfda66sm12266105f8f.22.2026.02.12.04.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:07:41 -0800 (PST)
Message-ID: <9c536b9a-cd27-4b39-841c-f775c4961727@redhat.com>
Date: Thu, 12 Feb 2026 13:07:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][net-next] net/devlink: Move health recovery notification
 after abort check
To: lirongqing <lirongqing@baidu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260212105751.2410-1-lirongqing@baidu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212105751.2410-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-258446-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE4C12D4FD
X-Rspamd-Action: no action

On 2/12/26 11:57 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In devlink_health_report(), the DEVLINK_CMD_HEALTH_REPORTER_RECOVER
> notification is sent immediately after setting the error state, before
> checking if recovery should be aborted via devlink_health_recover_abort().
> 
> When devlink_health_recover_abort() returns true (e.g., due to rate
> limiting), the recovery process terminates early, but userspace has already
> received a notification implying that recovery is underway. This creates a
> misleading view of the reporter's activity.
> 
> Move the notification after the abort check, ensuring it is only sent when
> recovery will actually proceed. This aligns the notification with the
> actual recovery behavior.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


