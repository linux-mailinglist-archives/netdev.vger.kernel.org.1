Return-Path: <netdev+bounces-305331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id naHVBSe6TGoeowEAu9opvQ
	(envelope-from <netdev+bounces-305331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C7719287
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ku+NGm43;
	dkim=pass header.d=redhat.com header.s=google header.b=Bvs5RL7g;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305331-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305331-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF203026C12
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE830BF6D;
	Tue,  7 Jul 2026 08:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A564CB5B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:28:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412902; cv=none; b=AhXGdX0D/84GlAD5G3JzGtRApHhFSE6qWtkX3YniPvYtOoFKGX08r34nOaexwT+qYZ2PGvcBvBUGOzAkWa3Uk74T6FCDdFOZ3t393hqtXLO+n9ZEbfMEHb0eYXLm3wQo88L27jSaCymTcnZyxl66d4vYgRE1qiNNYiC7N+Fn1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412902; c=relaxed/simple;
	bh=WQKIs64871yUyTjfsDUxssJgvhRqui78lP2WGCaXxAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtMh7nnzRkrkK+FIKibDhG4PSlEHZX9oqpgsAISh0PJiT95OI9Yi49moY3gJRj1TRPiJTGMfELtg4EuY4zpqvlA+iHN8xFwyAgYo17BD+m5bHLqlzlfbGoBryjPlv+uRH3so4OWDiRoe2F9hKtvMVql9vwhJWqvKvv1ZsladMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ku+NGm43; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvs5RL7g; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783412900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
	b=Ku+NGm43PGAKX2SlUAQ6tdu6zfNky9OJ75+Ogt9UsbsOiR8EzuWGdOJ4AyKZsr6wEbVoih
	9EUL852rrBVCZvxJm7FOoslqWgksCjNj0knKq9mc8ouh/HHvO/nEcns0Fli++GbQ3WLde1
	E/RX3T+ya1OtT1rbxcWQW56uLrJfGg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-dPojVbbRMh2O7jI49XgV6w-1; Tue, 07 Jul 2026 04:28:18 -0400
X-MC-Unique: dPojVbbRMh2O7jI49XgV6w-1
X-Mimecast-MFC-AGG-ID: dPojVbbRMh2O7jI49XgV6w_1783412897
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so37604085e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783412897; x=1784017697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
        b=Bvs5RL7gT/JU5uAsKOiCs0zFhzQFpT2S6y60ZDXKL2mAIodGdpjFMa+nPJhHSGkFiV
         /bbc/TybGGdPXYOqjmXxTVsYTckXiFuKBWjhInmTdIYXvA3UPdMuNhQN70WDwFtZa0Db
         elLIeWw9ZdBAOvFpR5PLFtLX6FayYwrvvlVQS58Kz/j+I2HNDEHlQg29mfojPDlTSgbl
         5dvDND9uAHVFza2ohxz+NGT2UM8U2egdSDuBzAKO008iGx6dH7GkNNlRvMxywgFViDSN
         zI7NLqbMxQ9PwwCuZvvkSD0ji3IRlE+UHQjGcHoXpT217PBRYGVvB/at6n36M448im3d
         HcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783412897; x=1784017697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
        b=bw1+LWe4oXrlTVlqLH2IaGk0q5ErOpTOMo4hTfBzMMtltbLPoqT9OV3V8IsnvX4Knk
         s8+KvNGPk/R6wlUfC1wur7B+HlwBjVHJG4BvEqGMLA2vnqynCYVc/W5ToeRAYQg0MPdF
         kclD4VNTlasit5R6LeXJ4PekX+8NydIrOuNrYx7GyJhIimg5BwMdlLww8YficXi97t9z
         5txq/6KTGeow3HxrLlCAXub8g/5s2S5nP/DhFG7WbYtrMcU9tioa98c6f96GzncnxHHx
         7gfGXdGbFmFQpFjLYO8lSvjj6Cr9TfGxYBtJFPa76Js1hwbDBLT2sdPjEhoEfmMT4Fzo
         nX1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrx/+Es7OI+ZcUQUUHxETSgMqh2qrH9dKbK8f06zmvLvlMy1vkjSsoO5q7fbzZNDoFNUBQBfBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsg9BemL9CEBfSsoQAMF5+Xfp/MmAO2oY7Hzrsq/wJ7emsLUat
	qtq1jD5mbsDbA7NsqGMky9GFCZBKtB4OXFeVcixtsvYq31H6dGECWz+UCPUD2qn9Aen0JIjAd5t
	ngQl0IproD70BLcxVmhuxTZOKJZd2L4/BeuxRBWY0v6pptj7hZ+AuucKTeg==
X-Gm-Gg: AfdE7clSuxyYiXZh5Yv/nW72SbXR+uGvZbY9fEd2E2MmLdAvL16+/YoPryZHT0HCV5J
	5Q5a9KzT3AtNfkh7eCUR82CwGD84m633OwWbRkUfBmMnczKnRw8W/VSSf5GFE/5KdlOLAjWZ6fi
	8JtZfpjjozdd8WoA4Qt7pB/8KM6NZ7Z5tXS7oOQgXZ0+sbmuon392fxh7zHD5cawAIGDORdgWVv
	2vM45WdRcMRQCuz5t3HkH71QDWDvK3EJ9tR72IhOD0v9RSiv6HerbEETLR5Shm4T93OP2tEhyno
	5KM/j17sCPfd1roW6llXKfTSjBaMXEfhfYKnfApTQqPMeyXfIVXPKIyCUXUSlRfn1A1FXqEcCmR
	ZdL2f31fryKSIjGm6Fsmfae0B8EQDReLtAfTtGbB4XWo9fk35PDNRV+2rLvMr01xltniaUTmWEH
	ZkbBMh7ZzBmST2
X-Received: by 2002:a05:600c:3f0a:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-493df0a07e3mr41019355e9.36.1783412895115;
        Tue, 07 Jul 2026 01:28:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-493df0a07e3mr41019005e9.36.1783412894747;
        Tue, 07 Jul 2026 01:28:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm44221735e9.7.2026.07.07.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:28:14 -0700 (PDT)
Message-ID: <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
Date: Tue, 7 Jul 2026 10:28:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] ice: wait for reset completion in ice_resume()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>, jbrandeb@kernel.org,
 stable@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
 <20260630214404.930923-2-anthony.l.nguyen@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630214404.930923-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:aaron.ma@canonical.com,m:jbrandeb@kernel.org,m:stable@vger.kernel.org,m:kohei@enjuk.jp,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A01C7719287

On 6/30/26 11:43 PM, Tony Nguyen wrote:
> From: Aaron Ma <aaron.ma@canonical.com>
> 
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>   ice_resume()
>     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>   ...
>   ice_open()
>     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>   ...
>   ice_service_task()
>     ice_do_reset()
>       ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
> 
>   ice 0000:81:00.0: can't open net device while reset is in progress
> 
> Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
> for the reset to complete before returning from ice_resume(). In
> practice the reset completes in ~300ms.

Would not be better to (eventually) wait in ice_open()? Why? AFAICS that
would be also more consistent with i.e. the current wait in
ice_devlink_info_get().

Otherwise why don't consolidate all the wait at resume time and remove
the other one in ice_devlink_info_get()?

/P


