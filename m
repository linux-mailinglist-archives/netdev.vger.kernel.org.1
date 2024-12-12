Return-Path: <netdev+bounces-151342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9CD9EE46B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6488B1886A97
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597D210F60;
	Thu, 12 Dec 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwKgbQft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6F10F2
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000296; cv=none; b=XQ/xYW/UaWD0VNPQWKtcwJUO1Y1FSbeUzbwW5zozwoi5fVrVGz6hVrG++0iXN5NL7/GMinH0AbJnNitpV+dHc1rqcPaqyRgRT2LY2h5w+clr9JJ9ARRSmjwaH1vaZXGzBqiSfkbzF3sz6MaK3wl8xHIJNUtklsPegvnArv1CfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000296; c=relaxed/simple;
	bh=5b/d8AyG2N/kZgsV83xq0eB7TQYSMiYh65wkLwvvA/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JhXLrO2CwXSyhKlNA5uH8QqUL/bD4YVF9ScczixC0dfMWz/H2OIcUV9h/EyPleVPSIg8DoCZj5fryWmbpH3nMeOaaXOcL8vXSDStDlbN1ni9cFc6ejGpTCyStn0uNSrojX2euGUZktI9j/kwz2BmlqD17/nzcgmF7+Q+I8JD4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwKgbQft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734000292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cwnE6aZS9G1n0HYjfMg9NdtQL50LplyHybCt++p+aI=;
	b=IwKgbQftTJPHq848H2yJYpe4g2Oa+W+1BYu8/taCvZVjXnH1qiemgawSNYc1/s13VdOhc3
	DChYzuVQ+hjyC0Dll5rvnIlVv6InhNE7su7GCokHCL0x+3S9NdyLbSGH51wyvBdKASrtH+
	ZsTlmPtWo2ucx8JMWPxkiBY4Av5qeG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xe1Y__sFP2K_AHmTaVzASA-1; Thu, 12 Dec 2024 05:44:50 -0500
X-MC-Unique: xe1Y__sFP2K_AHmTaVzASA-1
X-Mimecast-MFC-AGG-ID: xe1Y__sFP2K_AHmTaVzASA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d80576abso310589f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 02:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000289; x=1734605089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cwnE6aZS9G1n0HYjfMg9NdtQL50LplyHybCt++p+aI=;
        b=CnFSeCrEBT7OdBZI5j3Xsm5g/8w/wtJahKOzZE2HHf8d9Sk6zdVEqwhy7A+ZiiRy+Z
         wC+lyYHDz1jHMeoTy3OpNgN3UPhXJqN79xbwBfnb2gRndzEnvJrKgt8RlurQyN3gt8gw
         9Ou+bCEMwdxzV9pKN2xRflCr5iQqT2kjWwXXiDlABkY/xhwRaZ1pwjN0oMHyjksBln05
         /VnBfl2rXxxi6Y0tuSFuV43O/ZKLtzm3WV2r3iVPHz0HzNUg5tu4GSws/A7TUuQ2WXta
         hUVOf1wcuqoYqXxrd3JBK3MUuuOZXQlAlcZq2a/7xAwcgz6sSWYHSuuW7v2lHMFeZ3cX
         Aweg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Mty3I+EuVD67Lws0omPtmVxuIOrR4dcIavlF6Yggx+q98S680ylSSWAJXFYoOp6WaFHqbrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7EapbnDg05vQ5Syrmho2SpwGsg9fDheDXW3n38hDzpbU9JtD
	2HKk0lCUnszMywUx3YBtWxN1AnKyZY1Hxp+ixMa6OIqUMVUbNHfTgdXu8yMbwYUtFX3a30kFxUc
	jdR35f7JXq07sMuuGzsOewO7fHqE6fv2zeF/JkC9VmLYsLwrMh1f6OA==
X-Gm-Gg: ASbGncs/JqiSrMTg0zEE9pp70WlnX7blt4bGYjpLYqhjn+hhFXTyU0qKHMmqWtYAQKB
	fLRJ3z3CrzOkX+HGp3Xe/I1w44TW2Si15xLrJgAkzxoZPbePHDXmFhjuNAOUQMTj88omhiB85BT
	KiFyFviETsl++SgllqrnQ8FZV/MuJiiOdiRA7PK7ynDRvmql6EshL6eVQ2nxxe0658ihMH/Hrtv
	qAYfjU1FLBXl7XU+OmXbOOeRITTINL9g9fQH+wUw2kgHB+WlZ4R/U3SwDoe8+DvCdwiecEspMQn
	Fxkl/Rc=
X-Received: by 2002:a05:6000:21c5:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-3864ced4a75mr4060345f8f.56.1734000289514;
        Thu, 12 Dec 2024 02:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoGUBQoyq6hw31iEBG4OwN016yKVTlUbicI6drvmMl3LuyRpLo48NHbMKwz3SgwhJtjNO7AA==
X-Received: by 2002:a05:6000:21c5:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-3864ced4a75mr4060329f8f.56.1734000289130;
        Thu, 12 Dec 2024 02:44:49 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dba9sm3618778f8f.98.2024.12.12.02.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:44:48 -0800 (PST)
Message-ID: <1fae5ceb-e15a-479a-b876-0239a4cdfc27@redhat.com>
Date: Thu, 12 Dec 2024 11:44:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] llc: reset transport_header offset as value is
 inaccurate when buffer is processed by DSA
To: Antonio Pastor <antonio.pastor@gmail.com>, netdev@vger.kernel.org
References: <ef68689e-7e0b-4702-a762-d214c7d76e3b@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ef68689e-7e0b-4702-a762-d214c7d76e3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/24 19:36, Antonio Pastor wrote:
> While testing 802.2+LLC+SNAP processing of inbound packets in OpenWrt, 
> it was found that network_header offset is 2 bytes short (before 
> sbk->data) when the packet was received through OpenWrt's DSA 
> (Distributed Switch Architecture). This causes SNAP OUI:PID mismatch and 
> packet is silently dropped by snap_rcv().
> 
> Here a trace:
> 
>            <idle>-0       [001] ..s..  8744.047176: find_snap_client 
> <-snap_rcv
>            <idle>-0       [001] ..s..  8744.047218: <stack trace>
>   => snap_rcv
>   => llc_rcv
>   => __netif_receive_skb_one_core
>   => netif_receive_skb
>   => br_handle_frame_finish
>   => br_handle_frame
>   => __netif_receive_skb_core.constprop.0
>   => __netif_receive_skb_list_core
>   => netif_receive_skb_list_internal
>   => napi_complete_done
>   => gro_cell_poll
>   => __napi_poll.constprop.0
>   => net_rx_action
>   => handle_softirqs
>   => irq_exit
>   => call_with_stack
>   => __irq_svc
>   => default_idle_call
>   => do_idle
>   => cpu_startup_entry
>   => secondary_start_kernel
>   => 0x42301294
> 
> The offsets were detected as incorrect as early as napi_complete_done() 
> and I gave up on tracking where the problem comes from. Running with GRO 
> disabled makes no difference.
> 
> Curiously enough, __netif_receive_skb_list_core() resets network_header 
> offset, but leaves transport_header offset alone if it was set, assuming 
> it is correct. On non-DSA OpenWrt images it is, but since images were 
> migrated to use DSA this issue appears. For locally generated packets 
> transport_header offset is not set (0xffff) so 
> __netif_receive_skb_list_core() resets it, which solves the issue. That 
> is why inbound packets received from an external system exhibit the 
> problem but locally generated traffic is processed OK.
> 
> I can only assume this has been an issue for a while but since 
> presumably it only impacts 802.2+LLC+SNAP (which I'm aware is not much 
> used today) it has not been flagged before. I wouldn't be surprised if 
> any protocols using Ethernet II frames reset transport_header offset 
> before they have anything to do with it.
> 
> The kernel code does not touch transport_header offset until llc_rcv() 
> where it is moved forward based on the length of the LLC header as it is 
> assumed correct, which is the issue.
> 
> Patch below proposes modifying llc_rcv() to reset transport_header 
> offset and then push forward by the LLC header length. While a better 
> solution might lurk elsewhere by tackling the root cause of why 
> transport_header offset is off after DSA set it to begin with, that is 
> taking too much effort to identify and risks widespread impact. A patch 
> could be made to __netif_receive_skb_list_core() to always reset 
> transport_header offset, but that would also impact all frames. This is 
> a lower risk patch that will not impact any non 802.2+LLC frames, and 
> presumably only SNAP ones. It follows the approach of 
> __netif_receive_skb_list_core() of not trusting the offset as received 
> and resetting it before snap_rcv() has a need for it.
> 
> Patch:
> 
>   net/llc/llc_input.c | 2 +-
>   1 file changed, 1 insertions(+), 1 deletions(-)
> 
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct s
>       if (unlikely(!pskb_may_pull(skb, llc_len)))
>           return 0;
> 
> -    skb->transport_header += llc_len;
> +    skb_set_transport_header(skb, llc_len);
>       skb_pull(skb, llc_len);
>       if (skb->protocol == htons(ETH_P_802_2)) {
>           __be16 pdulen;
> 
> 
> Can you share your opinions on this patch and suggest next actions for 
> its adoption (or modification) please?

IMHO llc should avoid entirely using the transport_header field as
AFAICS the relevant information do not belong to such layer. Anyhow such
change looks like way too invasive as a fix.

Your approach is IMHO correct, but the patch itself is white-space
damage - be sure to generate it on top of current net tree and double
your client is not corrupting it. Additionally, as a fix the patch must
include a suitable Fixes tag. Have an accurate read to the process
documentation before formally submitting the fix.

Thanks,

Paolo


