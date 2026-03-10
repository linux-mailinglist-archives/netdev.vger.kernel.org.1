Return-Path: <netdev+bounces-265961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAq+Hi/kr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:28:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E3248628
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CDBA300383A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC01438FE7;
	Tue, 10 Mar 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAQHJC8w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6t7bpdV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE419438FF6
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134826; cv=none; b=L3FMtsvfyG/oTqLDhc1+CrIpCGIyj93rt9PIDEMpS0HggARBhrY/R4IVaXQZoHzD0GNoQjtayIIUecdpDf4AfPHQe/T+8kNOUrcx6bz/45CV/WbzmVtF7Hefi0I+9fVCr08D/FnJ8+3AdtIjDKG3WzvFXwC3ns3l6noius4h7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134826; c=relaxed/simple;
	bh=prO5jcc8QDr/hEZyY6kj9FvhTx8zB5lagn1VGqip1d4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SU7ubhii7Xuuw1qP9ky2fEWjAThZJ2B5jylLGzL2OQ7SUqA6CQ9g0FepXSp2OcW8CmFUes6HtVQEqYiyjuY+Sc6kVOOR6Q6hkjLmTDOp64ppv7Q6P4ngsBZ5B3gX52LCJapkABM+IsljtvqBXdO9fr9s2c6H8TPHcGA2WD1q0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAQHJC8w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6t7bpdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773134824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
	b=PAQHJC8w4eTou2l1ukkNrTDkjeDjF3nCM5pAzEu8AyzS10yZPtD2ufwRuhHTltiG1lxllJ
	bjT779OpdoYjrAKm9dkvEyrh5dOuCiJZgxiqmpu2kK5P5kVb37zHk0xPz/qHSIf7wTjuvC
	Elp3D5NzH/VXK+m5ZtnLZLSlXRqsj1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-jeAdy08dNlCkDprWSKMQpg-1; Tue, 10 Mar 2026 05:27:03 -0400
X-MC-Unique: jeAdy08dNlCkDprWSKMQpg-1
X-Mimecast-MFC-AGG-ID: jeAdy08dNlCkDprWSKMQpg_1773134822
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so105878555e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773134822; x=1773739622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
        b=S6t7bpdVbpym1WyJ2YrAK8q9/V90gCgAHJbQgzhOAp0BZj6wU/1+xl9zT/7JPkVygR
         Zul2w2cMarPyt7g13dtgttOpChhqKcCZkpFDAeljvbMJU4WTu3sPXIrmrh+MSNAR9fHK
         WDK61MswNJZBFuT/4oRwHCPGu416KZA438yaqmGpD2uYChe55iDjpvCEHbAjCklMrdoK
         +pmBEuEuqtqi+/JqphJNdEASrVfi+LqoKW25oKs9GYXQDW7+6/Bf+f8Z7iVPmZhh6oqb
         22eWNlTZA1rb/0le5vxgsnfrpQPvo2ytbjIyyJ3GEsRJ9uNeWOGIgfqVpucR/2t5/emG
         jOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134822; x=1773739622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
        b=gkBRpGGOOZlBX1wMYzVhY1PUhcDj7bQO5YK+z2n28Re/cpA08QdRlfROy/qSwlfiCD
         eV0Q4hmYE7lHdxEf7LdJvWF1axeeTCqSETmwn//2ueZxw7MTAQQfBNAMM8ITUF6o5sRi
         EWoKOJgSDOjkBBWlif0aTSEzoLA1OlyhPs0d9AhkDJiF0WjDoGlP3H9NpEd3MC97M1AP
         JZG+kkU/JYuQg129/uyFbt49XjI0MNagFq7RBnYHDLTGI8XG36O9VGSyc4X75JXAPKSz
         BOEjI70JqSkLK/R3LPpxqdrZ7f3Ne2K0uGKqB9Usj5C9q815qiYdjYxa3QqjIjVjn5kA
         rhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUa+dwJu9Ca72/6oJYK+ZkP7bJa4bSncuT4SO/Wdqdt5Ygf9L3JdyA5jyU/Dyt8teQkpNH8PTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNY+r0peiebIls+3WXloi+RD7mkLeQ+YZrr1PEE3m+8aVpeVu
	3XZd38uc5QQrd5AEXRyOCBQLba4Y1AExJRPIpdsDawC6s2aunMGbdChH+Nz6G8Iod2VSEo8byhf
	u/rp2MHDkG5ulKB3P0Hk/Ra+0+F3znAn0XjuZ8pVSldMDLzksjP0whjjrVw==
X-Gm-Gg: ATEYQzykqpzksbBwtvNbLmclcKHPhWnXLmtHmMZdzy8dLZ/Da++8MgyLlypoNxbnSj+
	dxk/ppmJnoiF+s+wjOHjxc+UiptQmRhN/0iSV2+M2KVuVeXDdTSKEBdn2TLZEohvPtpoHOKcwpI
	o+2fxQNHD1x25NJ3xvSgcJxjMvRXArkWQCSaJLO1cQm39ewleqO3xSNNDhNnRkf9g8GcYvcYD7W
	157zg1kCEQFclLVZhmdHdeEuMAM+8vn44JoUpZTYgndC8leCTCzPZAzVM5L6r+lzBOEzSnjoxLK
	YmxTrGFqU8G/k38iWPl0kf1GHJilblQqzEaz9q64Cig3aL6tO4Lh4O/H2oVuWA4bijoVNKt0Qek
	TJq9k98EvbPlmfrFPksoxDQNo6y9jXQpOaXiHAjjSV+oVT9R1zmcIN07z
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126931105e9.2.1773134822169;
        Tue, 10 Mar 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126930725e9.2.1773134821691;
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8f610sm103923765e9.7.2026.03.10.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Message-ID: <ef3435b1-5d86-4137-903f-bddeca3deb91@redhat.com>
Date: Tue, 10 Mar 2026 10:26:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v4] vsock: add G2H fallback for CIDs not owned by H2G
 transport
From: Paolo Abeni <pabeni@redhat.com>
To: graf@amazon.com
Cc: vishnu.dasa@broadcom.com, stefanha@redhat.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 netdev@vger.kernel.org, eperezma@redhat.com, gregkh@linuxfoundation.org,
 mst@redhat.com, jasowang@redhat.com, corbet@lwn.net,
 nh-open-source@amazon.com, bryan-bt.tan@broadcom.com,
 syzbot@syzkaller.appspotmail.com, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org
References: <20260304230027.59857-1-graf@amazon.com>
 <20260310091843.101237-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260310091843.101237-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E04E3248628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265961-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

Hi,

On 3/10/26 10:18 AM, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
>> @@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>  	case SOCK_SEQPACKET:
>>  		if (vsock_use_local_transport(remote_cid))
>>  			new_transport = transport_local;
>> -		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>> +		else if (remote_cid <= VMADDR_CID_HOST ||
>>  			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>  			new_transport = transport_g2h;
>> -		else
>> +		else if (transport_h2g &&
>> +			 (!transport_h2g->has_remote_cid ||
>> +			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>> +			new_transport = transport_h2g;
>> +		else if (sock_net(sk)->vsock.g2h_fallback &&
>> +			 transport_g2h && transport_g2h->has_remote_cid &&
>> +			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>> +			new_transport = transport_g2h;
>> +		} else {
>>  			new_transport = transport_h2g;
>> +		}
>>  		break;
> 
> The old code had `!transport_h2g` in the second else-if condition at line
> -583, which routed all CID > VMADDR_CID_HOST traffic to transport_g2h when
> no H2G transport was loaded. The new code removes this check.
> 
> When transport_h2g is NULL (no H2G transport loaded) and the G2H transport
> does not implement has_remote_cid (as is the case for VMCI and Hyper-V
> transports), what happens?
> 
> The G2H fallback branch at line +596 requires
> `transport_g2h->has_remote_cid` to be non-NULL. If it's NULL, the
> short-circuit evaluation skips this branch and executes the final else at
> line +601, setting `new_transport = transport_h2g` (which is NULL),
> ultimately returning -ENODEV.
> 
> The commit message explicitly states the intent to preserve the existing
> no-H2G fallback behavior. Does this implementation break it for G2H
> transports that do not implement the new optional has_remote_cid callback?
> 
> This affects VMCI and Hyper-V environments: when no H2G transport is
> loaded, CID > 2 connections that previously fell back to G2H now get
> ENODEV.
Other comments from AI looked like nit picking to me, but the above one
looks relevant. I forwarded verbatim all the feedback for completeness.

/P


