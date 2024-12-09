Return-Path: <netdev+bounces-150330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E79E9E29
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224CD18883C0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B035172767;
	Mon,  9 Dec 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXmykJUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDD167DAC
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769430; cv=none; b=EHrL9U6JikHVj2f9WIIbZLJ71zmFXVSQjMQxcPlSTGRJ8eGELC0K+ajmVaIka4ZeHpdFAmS2S/MY/cGS+h9RqwbnjmJmJNuV85hf9AuJfiD9HySYNmtDwbn5Bn7NiSxG5z0rbBDy587emiovzCBqFvXSpeF0rvYd3XG0AJoMN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769430; c=relaxed/simple;
	bh=ZIK0EewLVrJBA4Uc/hArxadlByCLJJ7W5uA/zEoxoWc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=o4d+VZUoRSk3WIRQkjHqKejlRc9i4bwB47FWiU1VtkyyffdltaeFk6w9A6SUegOqpZ+UXOcVXkRmXeewbh/e1UmbEJIbc52vItO8IWXDLAtXmMR7bfmezc9H6PkNmAAzAoELb+X967GyH0EQKvvEGAtn5qQ5YgTBVvaXgwxzuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXmykJUJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b676152a86so571945785a.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733769427; x=1734374227; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/YmFDgpUpDSzsmPW5+tzjrqrqfqeFy/GKHYDmvyeOE=;
        b=KXmykJUJm4ZraINr1+bPbyKLaoxDcKRdFYdnZE7taJ4xVlukbwzCbwR0teKkFezIRj
         t4A1SEgvoz/41uCifcTUavdQ6dgUnhdGxiJun+mi1Smy4Y0jV8uwnECSdHnsl3Sjwaxx
         XF7Rg9T2Tjxbw7Tmne+YSMu4uZ6dXfor7eGZDxnOCuS/3FkmZTPh0PzZy5EFHQMUl8y7
         WSerFE2HPp5m9eteuAhPEDwuR6uxlDmjM+XFTbaDe7lYDZowooTTwlG9SLB0CuXAu00t
         K/wpw6485GdrqkfFP67k49wDt1T+xxY9DzxD1NgLkxD0fzvGzlwDWSf2RE5KgU9QhJNr
         jihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769427; x=1734374227;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J/YmFDgpUpDSzsmPW5+tzjrqrqfqeFy/GKHYDmvyeOE=;
        b=by5ThhEaMsFlalXB+BFxwlEhAfFvdFBtHyEtYodIUFZcKCR/etqnwI0Bv0PYKvOF1N
         GP6lkzi5gDJ2GMisegDTh6LYm9Mpj8qRqc+o5OohwYhVvHwkXKTWpgvxDWhDQvtij1Q2
         Oa3xJxp9Citgt87ubUT7AUekBokFSL855dHzVxY2k0kTCOhGTUA660HmIK388nOPy2Y+
         OMH89QKBBgQ49Y7/GHtGr/YFukenOz3W1b8zg5o5H0ZcZDtu7iFcem3SBrN7N7bI8Baw
         Zkdiwl9p0OALadBQE6riLEKt5Rt+FXkj1pW9GOyomg8MaTpfrn6aVbkGTai2LeuYcN88
         g6kA==
X-Gm-Message-State: AOJu0YyU+pr9FBwP77pRw02hRLxqWDCkRoJDp4WlMd/jEt12hSErNBAR
	RSt7GZMZBeFkyYtdiJihK36pI+DkWL7as3f8sgPohOkXkcKk7a/SsZkidg==
X-Gm-Gg: ASbGncurFbvplScwysxkT4kRObYWiS0616HMOboId7IFo4tFHvjGDHn0Qsv5sk708kv
	zvULIqkOjz5SPT7XgnPUfzE1H5UP+T0ttilKK7J59r5YE43q5sxXC7jVk7UszPWW6kYMio02yGN
	miPnhpSaKJZdmmNqsT8hLDsBe1ncu9FO5UQPQQJwLeF6R12xI9qVK/41BJeZU8tG7q3TMZ3L4WP
	ptOHgJANoGsFr6E0k/W4pE762DMQ2E1gfKfUGRB9QsObVZjzC4McMeG+72kri0L
X-Google-Smtp-Source: AGHT+IFEscSXGykpGsOxgaBS5AmGwPIxbfVmAh1BJMkQaGwAzO4EmqeEjstbL3/MLV/n4r2sAHR4gQ==
X-Received: by 2002:a05:620a:2a05:b0:7b6:dd89:d86f with SMTP id af79cd13be357-7b6de7616d8mr50365785a.24.1733769426837;
        Mon, 09 Dec 2024 10:37:06 -0800 (PST)
Received: from [192.168.128.127] ([142.114.175.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6dbb3b67fsm47068685a.10.2024.12.09.10.37.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 10:37:06 -0800 (PST)
Message-ID: <ef68689e-7e0b-4702-a762-d214c7d76e3b@gmail.com>
Date: Mon, 9 Dec 2024 13:36:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Antonio Pastor <antonio.pastor@gmail.com>
Subject: [PATCH net] llc: reset transport_header offset as value is inaccurate
 when buffer is processed by DSA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

While testing 802.2+LLC+SNAP processing of inbound packets in OpenWrt, 
it was found that network_header offset is 2 bytes short (before 
sbk->data) when the packet was received through OpenWrt's DSA 
(Distributed Switch Architecture). This causes SNAP OUI:PID mismatch and 
packet is silently dropped by snap_rcv().

Here a trace:

           <idle>-0       [001] ..s..  8744.047176: find_snap_client 
<-snap_rcv
           <idle>-0       [001] ..s..  8744.047218: <stack trace>
  => snap_rcv
  => llc_rcv
  => __netif_receive_skb_one_core
  => netif_receive_skb
  => br_handle_frame_finish
  => br_handle_frame
  => __netif_receive_skb_core.constprop.0
  => __netif_receive_skb_list_core
  => netif_receive_skb_list_internal
  => napi_complete_done
  => gro_cell_poll
  => __napi_poll.constprop.0
  => net_rx_action
  => handle_softirqs
  => irq_exit
  => call_with_stack
  => __irq_svc
  => default_idle_call
  => do_idle
  => cpu_startup_entry
  => secondary_start_kernel
  => 0x42301294

The offsets were detected as incorrect as early as napi_complete_done() 
and I gave up on tracking where the problem comes from. Running with GRO 
disabled makes no difference.

Curiously enough, __netif_receive_skb_list_core() resets network_header 
offset, but leaves transport_header offset alone if it was set, assuming 
it is correct. On non-DSA OpenWrt images it is, but since images were 
migrated to use DSA this issue appears. For locally generated packets 
transport_header offset is not set (0xffff) so 
__netif_receive_skb_list_core() resets it, which solves the issue. That 
is why inbound packets received from an external system exhibit the 
problem but locally generated traffic is processed OK.

I can only assume this has been an issue for a while but since 
presumably it only impacts 802.2+LLC+SNAP (which I'm aware is not much 
used today) it has not been flagged before. I wouldn't be surprised if 
any protocols using Ethernet II frames reset transport_header offset 
before they have anything to do with it.

The kernel code does not touch transport_header offset until llc_rcv() 
where it is moved forward based on the length of the LLC header as it is 
assumed correct, which is the issue.

Patch below proposes modifying llc_rcv() to reset transport_header 
offset and then push forward by the LLC header length. While a better 
solution might lurk elsewhere by tackling the root cause of why 
transport_header offset is off after DSA set it to begin with, that is 
taking too much effort to identify and risks widespread impact. A patch 
could be made to __netif_receive_skb_list_core() to always reset 
transport_header offset, but that would also impact all frames. This is 
a lower risk patch that will not impact any non 802.2+LLC frames, and 
presumably only SNAP ones. It follows the approach of 
__netif_receive_skb_list_core() of not trusting the offset as received 
and resetting it before snap_rcv() has a need for it.

Patch:

  net/llc/llc_input.c | 2 +-
  1 file changed, 1 insertions(+), 1 deletions(-)

--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct s
      if (unlikely(!pskb_may_pull(skb, llc_len)))
          return 0;

-    skb->transport_header += llc_len;
+    skb_set_transport_header(skb, llc_len);
      skb_pull(skb, llc_len);
      if (skb->protocol == htons(ETH_P_802_2)) {
          __be16 pdulen;


Can you share your opinions on this patch and suggest next actions for 
its adoption (or modification) please?

Regards,

AP


