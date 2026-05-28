Return-Path: <netdev+bounces-292633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MeOCLQNGGrMbAgAu9opvQ
	(envelope-from <netdev+bounces-292633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782F5EFC72
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3601324B36D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC23AD527;
	Thu, 28 May 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDEqj4nt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o52DZ/Fq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DB3AE1A2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960653; cv=none; b=vAC19qL9zmrZiX7+ny8z6H3MXgOEMqlMImJ75DOXUyg8mbxMmCKTYzYfZm3C8PO/h71iT7EMrJR0jNQBRLkBMHchnDR46UpIyTzBI2mDr21GmuepLi5ykO0e7OAvJBgoRRHGNex6MOCB+JMq/q8ym1L93aVRV1ycDjurqOp2yOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960653; c=relaxed/simple;
	bh=LoGASex2qnTG+TbDm1RTWf0ExI8R1+KY/4AGVcMtGWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lAFyrINegBCGe2L8EoMn9h7luhzMBvw8gUY+m1k9bna196xUXuP4/fm3Ipn2bxjmOVsuEoDp+j0hPxFOD8JcIcRku55LQpcaHTuS9kxyxpzVUL+XOi5xk1N0e551yb05Stkt7P9KO99XpANGATD26aLS3Qe4BjNDwBRRoTCv71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDEqj4nt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o52DZ/Fq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
	b=RDEqj4ntpTDe8KmfV3D3uxuK/r/ZvJV/FjVhPdGZlzT9Htw2mac4QO62azYgtv4ZSSfCsV
	4oSOxRy/VTaMYIDjJzsNGqEcrWNAtX6ZEbQ8jjtzffktYGXK8zpHVSngFiQ6SsFMR5myAm
	+EZZSL7LUovlsU7V25b3YqnZ5aB4U18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-pjMcTmRiNl-XCJDM1RiFBQ-1; Thu, 28 May 2026 05:30:43 -0400
X-MC-Unique: pjMcTmRiNl-XCJDM1RiFBQ-1
X-Mimecast-MFC-AGG-ID: pjMcTmRiNl-XCJDM1RiFBQ_1779960643
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so7668412f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779960642; x=1780565442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=o52DZ/FqAhN+vs84+yikxVl81ZMWIybv11FV3YEJ4xCeRw3dh8yi66KZGMozD/StiR
         2mTEk3hcROKX0BgdkkfLPoledB7cKzseQWbdBp1Z7SG5nKsYrGzScr/1WqXwjcxOSj6K
         WZ+uJgOF0QX6/j+Ra1JTHSUH7azaYbbv303jqemnzJxJPryg/L+MrPvHdms8YpeKHiBA
         ctwaqFLR5hWY1PlHtC94q8g+7XqcGEbF/zsxW0w3zgvl7IiIQoGZNVumcYK+tSlvaW+o
         a/kN4xwODcmtIjzJqyRcQ480CB4pmxEzA92yHv2At+uwa8e9/kPh22nLO5VstbPioUiZ
         YtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960642; x=1780565442;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=T9h+PesNiCV5m0AIWe5l1kiSv9Yvlj11852bHygqL2Q0tj711caZU6Ew5T2OK2uU7F
         q5sF0i+Rs8SJWaZYXxGUJvyLoHAh/6oqjXGlaGYnpInKsdOdtNE67vVGVNUb8+6JdfqL
         3DoAvh7hLv6vN0tmEbGgKXlB0Wq2ALAJrrDQm4O6bbJDaOLRL1KqZgGKhG3MMaITfPUF
         BX4INcAgiB1yYLpaeDPIqFue5Lbi9iqmrZNYDrvHkQaYal6AC0vyhPzGx90jefm8f3qK
         qsubJdoHqkJkbqL+IOmRPIWZBRTB17ez29EFH9XbBj6Kyc81/Fj003AoCVNLfTpIQ5aQ
         QQgg==
X-Forwarded-Encrypted: i=1; AFNElJ8TcYySSHwLx1T3qYfyAIlPw/jwUNlmJhuHw+I+cg3gvjIrzqeLjuuaD8oJPFES4yaCK640DOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0udNKt3amS9i1x+LXLUG84JNRC7lTWvuYdIBynb9Wi3P3mMr
	mlyz3DHpj19Y1/GcWVFANp7fmbyfUgBjRo7s5DoVI37qHaaRQPblef1N5/3H8MpMDdd+mcxdEOE
	EhDr+KQZdeeTD8S05F/0pX+yDvU4Y6UkN+2yWcVEIyA8lJIReIp6eBkXUcw==
X-Gm-Gg: Acq92OEN9FMAAUau56HL+lMQys02kYhUTZl2Y/batroDK0eYLhCzgo/bgGezBqJugbo
	8cbqSuL7DkRU2F/vKtPqN6Xc3jjD429z8Ll4rMhuYg6fOj99x7/vyHjqGPx7Y+2uindK/MlRKTH
	PZyK0ptXhAopw8zpGFiLrnja7+7lFVu2P3tx5/w1pf7RHhyDTkP4QJ6DlbA7v8paq5s7s8cvfuC
	4X3mJUt/JP0PLBRBV2U5WcJ54j6y8DjEqhjA5AiYmgnNe4NEV9bOZBiBUMXG8kZMRy1UDC5tJt2
	7PZfBftiA2ayjcLIZILIhxCab7LwO6YDMRjBZFJ9qe1mf1TMYmKCGqOr6pwq6nZtqdELyGCmVn2
	oaa5v/gWk9KhVTZq7X4j7ScLpoiAn12p7kh0lmGFiigwQvBr61YE5POWM/vlx8Dhbmw==
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523748f8f.38.1779960642481;
        Thu, 28 May 2026 02:30:42 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523688f8f.38.1779960641995;
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm11898279f8f.21.2026.05.28.02.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Message-ID: <3665f7c1-9c97-44ac-8b6a-e6c31ad96730@redhat.com>
Date: Thu, 28 May 2026 11:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: mana: Skip redundant detach on
 already-detached port
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com
References: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
 <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7782F5EFC72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 10:08 AM, Dipayaan Roy wrote:
> When mana_per_port_queue_reset_work_handler() runs after a previous
> detach succeeded but attach failed, the port is left in a detached
> state with apc->tx_qp and apc->rxqs already freed. Calling
> mana_detach() again unconditionally leads to NULL pointer dereferences
> during queue teardown.
> 
> Add an early exit in mana_detach() when the port is already in
> detached state (!netif_device_present) for non-close callers, making
> it safe to call idempotently. This allows the queue reset handler and
> other recovery paths to simply retry mana_attach() without redundant
> teardown.
> 
> Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 0582803907a8..1e1ad2795c3c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
>  
>  	ASSERT_RTNL();
>  
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!from_close && !netif_device_present(ndev))
> +		return 0;
> +
>  	apc->port_st_save = apc->port_is_up;
>  	apc->port_is_up = false;

sashiko(gemini) notes the above can lead to different race:

---
Can this early return cause state machine corruption by bypassing the
updates
to apc->port_st_save?
Consider this sequence:
1. queue_reset_work runs, mana_detach() succeeds (apc->port_st_save = true,
   apc->port_is_up = false), but mana_attach() fails.
2. The admin brings the interface down (ip link set dev eth0 down), skipping
   mana_close() since apc->port_is_up is false.
3. The admin changes the MTU, triggering mana_change_mtu() which calls
   mana_detach() followed by mana_attach().
4. mana_detach() hits this new early return, preserving
   apc->port_st_save == true.
When mana_attach() runs, it sees apc->port_st_save == true and allocates
queues, setting apc->vport_use_count = 1 and apc->port_is_up = true, even
though the interface is administratively down.
If the admin then brings the interface up, mana_open() will unconditionally
call mana_alloc_queues(). That function calls mana_cfg_vport(), which will
return -EBUSY because apc->vport_use_count is already 1.
This leaves mana_open() failing and the interface down. Since the interface
is already down, trying to bring it down again is a no-op, meaning
mana_close() is never called to clean up the orphaned queues.
Does this sequence permanently brick the port until the driver is reloaded?
---

I think you need to be more restrictive in the early return check.

/P


