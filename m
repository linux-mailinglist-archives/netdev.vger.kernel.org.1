Return-Path: <netdev+bounces-306170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c48tHld2T2q8hAIAu9opvQ
	(envelope-from <netdev+bounces-306170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:22:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB172F87A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IMCIqYJY;
	dkim=pass header.d=redhat.com header.s=google header.b=L8Nk3nFE;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306170-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306170-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 508E830252B9
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA03AFB1B;
	Thu,  9 Jul 2026 10:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722163FC5CE
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592432; cv=none; b=OKyLLULMrhpcexwslYxPrjM0KszlxGpbulWNTNEVphpeGzA3W7AekT008a+WknnUjIZSKSN8PJNZxTyNgSnEfKsX9WYmnVIkRj5swRc/2Vc98KeOib4AmXqBOClNftq/VXEQVfGnphV2gnjPeo6Imopo/KtZv5kcWzuaPfJ7+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592432; c=relaxed/simple;
	bh=l03Mma13Qm89vNsGQ6EclrWvCaJ3kq1w46aZwt8VWvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUQNWQSVwGFDrfnDSWdKSHtWWwHBdP0cJsUm9apfFWr1x0b/ebIrXcuKFjXoQXp2j4uYwnk1it8sMAqwyrP24WUDBoSyTGD22ENcrtrHgLGFiUHyknIu1v/IU9XfNmUs1JgMJfQyYndpBpL+EDkZXjTfRpGv2K3d8cQ+4luR8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMCIqYJY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8Nk3nFE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783592429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM7sdyTQRtnDP6H+J9BAIVWCmxmOTeppThgpzim0Y7E=;
	b=IMCIqYJY07gn0o5/WR5sklDx7XanN5M+yxksDbo3ttWShajaszNZerfJi8sY0GoXhMrPxC
	JQgweeGE2NMRuag7WMYE9qGW7EWCmfCT2EnCVWVPswtm23lxx+wqNDqQ8cjgnhefTt4kXK
	VdaZIVi9qtFpbchNHtA+y9k9w/FFXno=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-rDCMcBCSPXWWtM6wRKGLLw-1; Thu, 09 Jul 2026 06:20:28 -0400
X-MC-Unique: rDCMcBCSPXWWtM6wRKGLLw-1
X-Mimecast-MFC-AGG-ID: rDCMcBCSPXWWtM6wRKGLLw_1783592427
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46fb9079a04so876723f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783592427; x=1784197227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uM7sdyTQRtnDP6H+J9BAIVWCmxmOTeppThgpzim0Y7E=;
        b=L8Nk3nFE3lSk0XBvGFWiK2/vYvO+4jht+5JCfkRlm+TidWEbQmEnE5w92TfHr6AB1B
         AcTYc/BuCA01JKD0mMaXsZgg3BEK49AkxASRTQ0bmzKhV4ZkieLMf2uKdKHKY7s8D7QS
         G8StIY+PVOr2vKfUaB58l2EWtesKKpyxA7bBvSUuL73LYfj7ort06V1WNhZGmG/8aCwv
         JSfolhjDQb0UJD96D7r+H+6kCaVkjg72keghpRntY1ND/lko5NT8PtymW/i8q3chVac6
         aVc9X1La4bADZPcUOIBU8EjJLWvWm2qsGvcE1Ka3+y4j8sB64nnReYHrcsOgMG0ZXtwK
         wE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592427; x=1784197227;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uM7sdyTQRtnDP6H+J9BAIVWCmxmOTeppThgpzim0Y7E=;
        b=JNOreVvjysov4bAEqUCAUsCk4Ru5KofTcqJMLmyvKnr14IpVsKLxrJai68QPwMmmIt
         6QxYvRPuo/qf3D2TE19dwEKI+6yp3p/GZajRooxP09wvVd7NKEJGqQYJzr65t0pLUuXK
         1GyTCO8j6ykwOf7SL9YTHC/MSTfbjXdqiAW8NRMEVPWSN/64xI9NbhUowYQbWS4j6gVj
         kCwmsPHhZlG5449HGLukXMZoM+K/NKbscAw5qS5Wq486F00ag8eNlOXbae0fag+9SX+k
         Rq66H3yjkf93/noWK401qSpUqOrLj0eaHJYHNwoe5iycciwBdF6fh9oianXZq+ltHTOR
         3yVQ==
X-Gm-Message-State: AOJu0YwLNVUs2KNlENtKpo6FiLRRb/8V6zbKo7yYx12Mj3sqHScQesmW
	KRNm3+lDvroSZdumWHI6gB9CNa4bCEV5PfO/2xTfbT3/Te66lMJ+HbHRC4jKCWLH1mLmWdr8v3h
	1zNacAfAV1l8YRs+kXVbbnuDXD8HbvGKXJrSPVdDvY6RZIuTKGl17tF5GYg==
X-Gm-Gg: AfdE7cnTytuiwxqlbwmi7cvTKeMdwgi/2/BWqinbZOiLI5MmokJ5frsVbQj638QwSZV
	C9GcTATw+17+dYOnxXyPQU9gbMFolbcDIWRuPiGayj2EhYYsCCUFwVDW2y10M9mX/AVO9XWD3ii
	oMg/Sz1ClwwpPLiPWq/4NphTysEjZfGuvDgnL93Dnk9R6J5JWhZZ8zlNiQjlmLHnOCP95IsBGnl
	8XKZgskJvx1HEFkOG4mftUE+o8w4yOC6ld7Z1QDB0RCEufpcEbK9YP9sG3zPbgdrTGLZTMW4Wtr
	dYWAqcaj+GOUWlL+2eesTEJLpDbVR7liORW7kznkSRuSq/IEIhJxCJmNTX6afmBEdlrVf3HavM1
	RUbISgQkoRou3oQG5hgYYIFsvhC18otjeQo+3TVLbvr9j5b/U++dJY+l9WKES4hcL7oCOurglul
	+yqJWuBb7Mty3m
X-Received: by 2002:a05:6000:41c3:b0:47d:ed40:a94e with SMTP id ffacd0b85a97d-47df0735368mr6145493f8f.22.1783592427097;
        Thu, 09 Jul 2026 03:20:27 -0700 (PDT)
X-Received: by 2002:a05:6000:41c3:b0:47d:ed40:a94e with SMTP id ffacd0b85a97d-47df0735368mr6145466f8f.22.1783592426689;
        Thu, 09 Jul 2026 03:20:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50439568f8f.5.2026.07.09.03.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:20:26 -0700 (PDT)
Message-ID: <1bfad1f6-6947-47a4-9dc0-72b4c16fc395@redhat.com>
Date: Thu, 9 Jul 2026 12:20:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <akuUkNgyjVOTHMuz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-306170-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4AB172F87A

On 7/6/26 1:55 PM, Breno Leitao wrote:
> On Thu, Jul 02, 2026 at 05:19:44AM -0700, Breno Leitao wrote:
>> This work continue to untangle netconsole and netpoll, improving
>> memory usage for netpoll users that are not netconsole.
> 
> Quick follow up on the sashiko findings. most of them are assuming that
> netconsole_write is called locklelly, which is not the case, except
> on panic (CON_NBCON_ATOMIC_UNSAFE). 
> 
> 
> There are in order as they appear in
> https://sashiko.dev/#/patchset/20260702-netconsole_move_more-v2-0-1ebedd921dcb%40debian.org
> 
> Tl;DR: There are two pre-existing issue that I will get fixed, but
> I don't think they are blockers for this series (IMO).
> 
> Details of the findings and analyzes:
> 
> 1) This isn't a bug introduced by this patch, but is it safe to modify
>    target_list using standard list primitives while netconsole_write()
>    iterates over it locklessly?
> 
> netconsole_write() is never called without the lock, unless on
> emergency, which is known to be unsafe (CON_NBCON_ATOMIC_UNSAFE).
> 
> Sashiko doesn't undersatnd that nbcon .device_lock
> (netconsole_device_lock), is called before netconsole_write
> 
> 2) This is a pre-existing issue, but I noticed a potential race
>    condition between netdevice events and configfs rmdir that skips
>    cleanup. If netconsole_netdev_event() processes NETDEV_RELEASE or
>    NETDEV_JOIN, it sets nt->state = STATE_DISABLED and moves the target
>    to target_cleanup_list:
> 
> This is a pre-existing issue, and I am happy to fix in here or as
> a follow-up
> 
> 
> 3) This isn't a bug introduced by this patch, but I found a potential
>    lockless iteration race in netconsole_write() in this file.
> 
> Again, netconsole_write() is not called locklelssly. 
> 
> 
> 4) This is a pre-existing issue, but does lockless iteration of
>    target_list in netconsole_write() race with non-RCU list
>    modifications?
> 
> Same as above.
> 
> 5) This is a pre-existing issue, but is there a race condition between
>    interface disablement and configfs removal that skips cleanup?
> 
> This is a pre-existing issue, and I am happy to fix in here or as
> a follow-up.
> 
> 6) This is a pre-existing issue, but does skb_dequeue() acquire
>    a spinlock_t in NMI contexts?
> 
> netconsole is not used on NMI contexts, unless on emergency
> (CON_NBCON_ATOMIC_UNSAFE).
> 
> 7) When netconsole_write() is called as an atomic console callback, it
>    iterates target_list locklessly. Concurrently, if a privileged user
>    removes the target via configfs:
> 
> netconsole_write() is only called on atomic context on emergencies.
> There is no conflict with configfs.
> 
> 8) This isn't a bug introduced by this patch, but could the lockless
>    iteration of target_list in netconsole_write() race with list
>    removal? In drivers/net/netconsole.c:netconsole_write():
> 
> Same as above, netconsole_write() are not called locklessly except on
> ops.
I think you forgot the following comment, which is BTW the only not
clearly marked as a pre-existing one.

Still looks like a pre-existing problem to me.

---
> @@ -335,17 +340,15 @@ static void refill_skbs_work_handler(struct work_struct *work)
>  static void netconsole_skb_pool_init(struct netconsole_target *nt)
>  {
> -	skb_queue_head_init(&nt->np.skb_pool);
> -	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
> -	refill_skbs(&nt->np);
> +	skb_queue_head_init(&nt->skb_pool);
> +	INIT_WORK(&nt->refill_wq, refill_skbs_work_handler);
> +	refill_skbs(nt);
>  }
Can this race with target teardown?
If a network device linked to a deactivated target is unregistered, it queues
the target on target_cleanup_list and schedules
netconsole_process_cleanups_core(), which executes netconsole_skb_pool_flush()
under rtnl_lock.
---


