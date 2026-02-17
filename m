Return-Path: <netdev+bounces-258988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK93Iu8rlGmdAQIAu9opvQ
	(envelope-from <netdev+bounces-258988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:50:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D614A18A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2884F301AD1B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680E2E229F;
	Tue, 17 Feb 2026 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk5NYCPf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJfFOwDj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845302C11DF
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318242; cv=none; b=iuB3OXsEL5kaTaELLnBzF/bhlWsOFpHTRtJW5ilvLtKS+R33VJTyOOEyCZJKf4CkzhdE8zF6+m0m+29Zg4kAqN234f0ZiNsAbsHMvQkP27ZzFScF/I5C351CYIhS2fI3cybAZIjGBbahBp2zOa0VvgURoPsTCWggNODsN8w2bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318242; c=relaxed/simple;
	bh=MPRho1BXR5I07Gqqkye/DGFZwC7hGpqHjYdeOqW6o3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBkC66fy9XpHsDrvcRLarAMwWMAXrBIZfVHqgd8nzZ9VkiG50BmDTydHzRHPPGpOPYqL6f6yvdRfGHNLnD80jvG4P1FFwq6gVUqSc/tuy4/qO9bBjXqKgHzjjqJCsVBgFUqwMw265u8bLYfwQUNQ//678M+B0g7mTj+phTtFyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk5NYCPf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJfFOwDj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771318240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhmnk81VjeKfSAS/tzd8Udq5jgElSXLAFbVQDFjFNds=;
	b=Pk5NYCPfxNLhzYaOPnmt3aWrampw+aTYxnwTSJfc1aGgGkK+8CZS/PKSr+CDB6itlwB822
	L1Ad3XlvWx3LfZPM7wtZ4EKkMA5mYtIddFGdJ6kfCP1bQjW7IFlgGuwP+oLnwaxMpVvRpH
	tjN0vCqiKfkrQSkU+meV3mIbXnzp3bc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-wTABKqRhO9SPyhz0khwamQ-1; Tue, 17 Feb 2026 03:50:38 -0500
X-MC-Unique: wTABKqRhO9SPyhz0khwamQ-1
X-Mimecast-MFC-AGG-ID: wTABKqRhO9SPyhz0khwamQ_1771318237
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso26206675e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771318237; x=1771923037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhmnk81VjeKfSAS/tzd8Udq5jgElSXLAFbVQDFjFNds=;
        b=GJfFOwDjEyev40NrSNamIFggqF+2o8pTVJ+zbA08zBRZxMRRBeesPGb7egxnBWsOhr
         Nx5F7TxhrN4IFKcOy+Hi6rqIIMYrZJHGWsS4ULjfjK+4P20WkbW5+T/ANPZsAHh6tIAN
         8nSYrD+3I+SsN20rqpvndNqvtTUkkVJ+U3vtQGCBiLZ/ysl463+Bwr8/FrckJlIEOboL
         /Drx/gdqVIMPKaFg7MNXUIDTlHW/LSfyrofUEgcAIBmpb6v4TqysfZKA/GObkx5aebWd
         EzWEoVr/qhbtgY0XBBmWAyzaeu5EyBAt3G29dugaxJY+uI2S7TieZ/03yr+IwU169RJr
         ss3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318237; x=1771923037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhmnk81VjeKfSAS/tzd8Udq5jgElSXLAFbVQDFjFNds=;
        b=eigXuerGMTiOkhBvIAaCpq14BVgPi7xRVYyDzyMIttMblbG0ryUS8Bm8685+2LeCol
         yeOwkKcuiWOOh99BP03K2HTgbKfEWmua2lwNxvM4aMauupbGljkLj0aDUnqbV0409m0l
         0xCQ8SGLZ92iY5+6E5knQXZkSl7P1UtDjYRiLVYEspiSMshQiFGJFQop0hf4GwQKTIaM
         shW91NCIYC1dYZrekeRFhASJVzo00sUgGEgoh9GJ7vcqD4NfNdE+igEcvgEhMlwVGUDz
         G0aDSsCazNJ2IeLNHfrEXSGqmOBa+DGCUxV861vNU7fRP8XvA1sRTpQBwk+oaulQIk+S
         yUCw==
X-Forwarded-Encrypted: i=1; AJvYcCUkz/drRxLgmgqSrR+3iubzly82hCLUtuyIqZouo+xQM6fXmhohw1benArRVUc9wzo/d/29S3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2u33pT06uSgAuD02Hnfmm1TKDdogqH4GD4y6KEit8O2iDAdH
	S5K24UXF6dUf72HY6HkZYL9PGL/sZqLtSUUW3qIGlJc2sh29TcuyBx8DvioEeI392gZNQUNlJ+8
	LTaTdS3L5OORQQgBDJv4Iv6BMZ4DqGi+hBMtl0vhBcQ4ITYKjQItla7+1dg==
X-Gm-Gg: AZuq6aLwy6W2g9gTay8bMTq+0/DH+fzV2AnGh/qHF9Em7MSp9gWvg3DbLZO6ZJ9cENN
	G7r41Lkjbl+Kv7x+6SqFjAA66PsZ6qxt/XooC+rk39OjzNSLqr0s6oAoP7niBwSt3Q6f/u0d0t/
	6dsFXLyg4l1WTyCRv+HwnAhNe7MVUa6fDyLOImvVWPOUvCwKuKQvY7rhMaOznu0LeDX4Nwnn+za
	TVOAvWoB7x8COGoEolPH3vtKpFmsgIgvGTTLzJtplSLuCiX2X3Eom4iVlx7oJfDGYR7yBTqEcAL
	V+UJwkyUmCzQqjGzfQhUX9vWbxuJROk0mvdZ7iqNtw4vhYVlPlooCxLK+YQne+QUOIazdrgKo1b
	++VAnpVSx/BaQoo2Y9emPlCdxcw==
X-Received: by 2002:a05:600c:8b61:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48373a69ed6mr211390195e9.26.1771318237184;
        Tue, 17 Feb 2026 00:50:37 -0800 (PST)
X-Received: by 2002:a05:600c:8b61:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48373a69ed6mr211389885e9.26.1771318236688;
        Tue, 17 Feb 2026 00:50:36 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm29315414f8f.7.2026.02.17.00.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:50:36 -0800 (PST)
Message-ID: <119e20b9-4ecd-480d-b629-1c57b2088a41@redhat.com>
Date: Tue, 17 Feb 2026 09:50:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: kaweth: remove TX queue manipulation in
 kaweth_set_rx_mode
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
 <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch>
 <CAMFT1=bFkHFsh-3U+Ca7Dey1mzPdz0rpQweCLmXFrattwZ_uMw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAMFT1=bFkHFsh-3U+Ca7Dey1mzPdz0rpQweCLmXFrattwZ_uMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258988-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: DD7D614A18A
X-Rspamd-Action: no action

On 2/9/26 6:48 PM, Ziyi Guo wrote:
> On Mon, Feb 9, 2026 at 7:56 AM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> I think there needs to be a better explanation why it is safe to
>> remove these stop and wake queue operations. r8152 does the same. Is
>> it also broken? Rather than removing these, should we actually be
>> waiting for the completion of the urb?
>>
>>         Andrew
> 
> Hi Andrew,
> 
> Thank you for your time and email, here is my understanding (correct
> me if I'm wrong).
> 
> I think ndo_set_rx_mode runs in atomic context with a spinlock held,
> if we wait for the completion, this would sleep under a spinlock.
> 
> And it seems the architecture of r8152 is different from kaweth and
> rtl8150. In r8152, the ndo_set_rx_mode callback (rtl8152_set_rx_mode)
> won't directly call netif_stop_queue/netif_wake_queue. It only sets a
> flag and schedules delayed work.
> The function that does call netif_stop_queue/netif_wake_queue is
> _rtl8152_set_rx_mode(), which runs from the work handler
> rtl_work_func_t() under tp->control mutex, not from the ndo callback
> under netif_addr_lock_bh.
> Also, r8152's start_xmit never submits URBs directly. It only queues
> SKBs to a software queue. Actual URB submission happens in a separate
> tasklet using a pool of 4 independent TX aggregation buffers, each
> with its own URB.
> 
> So even if netif_wake_queue() triggers start_xmit, it just adds an SKB
> to the software queue, no URB is touched, and no double-submission can
> occur.
> 
> In kaweth and rtl8150, start_xmit calls usb_submit_urb() directly on a
> single shared tx_urb, so the netif_wake_queue() from the ndo callback
> causes the stack to call start_xmit while that URB is still in-flight.

It looks like kaweth_set_rx_mode() is already functionally broken: the
real set_rx_mode action is performed by kaweth_async_set_rx_mode, which
in turn is not a no-op only at ndo_open() time.

So this looks safe to me.

/P


