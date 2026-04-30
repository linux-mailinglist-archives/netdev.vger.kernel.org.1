Return-Path: <netdev+bounces-282874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFTnA6hg82lT1wEAu9opvQ
	(envelope-from <netdev+bounces-282874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EB4A3CAB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C26D301A2AE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F4E429835;
	Thu, 30 Apr 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OsgqwrSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FD40B6F0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557648; cv=none; b=kBijySCyOWSR84gHaAixZXx1ZlJ9sGJ7j36LWf01mcK4yeEoWJKFFEbt41lcRIM/OR1pjOv6jvkOOuGVPoHE6meACKHPU8HU+eRECluhcN/0XKnTi5s+nuywiV5IaibVRbEqVQiGHhjq9XM/riRXhbualYPdVw0/Zel7q3gDOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557648; c=relaxed/simple;
	bh=7aaPSh+t1OHW+/zR1gCWlbCFnchyVN66dBCSRYvuMs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcceHZpmfH2jJRzyHwi7sTsHUkNOUfhxvty/zo6zbKHg/4wzHGrhtOfv6xFIUEWMEPUAKOms6cndIVBWJw5Q9V5mZM3Yv/EmUJ8Yg0D382MsRtXChbMAVxvQuGSisRAD7McbUie26VvXGYzClVUGLFYJuBIwnHHXQOFCHvU2QV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OsgqwrSc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so11597305e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777557642; x=1778162442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a8IqN2nClV5W8eMacjfQkZctmqsFW1NVgyk8ESO8z8Y=;
        b=OsgqwrScUUKeYGmXN3quL2L3+H5HtXtoFqLvmrW1pOpGjXxprkJAeingNYadlRS7v3
         EjKcog0v9LrH6DFiKbVSE1ILWZQCTRbpMyfdeASzggS/2AtEkbbm1eBQKdOO6UvwM0Nz
         6Bc7kpqQR3q+SGihoktLZ0TrrasF/F1x57kbF6xOrgtUkq2/OzQlJYFIkssG5XK2j28a
         3JoUMOF3ysMOn++c9WKV7himCb271Bt5h7h5CrRfZT+Cxhih6HIevgIr6yB8vbnto+p+
         SUYHQeHhpnr/2V6iSoFeViTQunuxkf0MPhrpw8Q8UsYnDnAD9WqcHl0UxLpz1j7iG+GD
         fQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777557642; x=1778162442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8IqN2nClV5W8eMacjfQkZctmqsFW1NVgyk8ESO8z8Y=;
        b=Ujp07AmDmbU6gZLyqp/jEv4vbRag0nKI/+HCpbn7jaxUTCRyqGYSu/DTNhpmlJRrTT
         TXTq7w+D+JnodgN3h5pNREuIV1ysUV5l6y8m7SECuc8LcboUhu01UooNYx8lGSWxUW1p
         vBNysQaFR3KOB+7wluGyYWe+tR+1Y173wdi3U4rto4AjpzD/EiaGb1kE5sW5+7yhp735
         PP9yCemBCAU8MpClGqV6t0q1N4bJG7H/hTtabkX+FF+Jw0ShfZPLfigZyDb5FZk1xxGr
         NfhN/Ujvj3EPLEqpnJE+kqQ8PF0EPGqm4V1cDQxAgYEKjEn5dN30dWvuPm+MMBQcHUg9
         oweA==
X-Gm-Message-State: AOJu0Ywz//kZi7rOCKgiGy73qIPA4LYw7SFGtTqYdiklsVP9eCVPe5jn
	1qp7WbvljNUbHg0cVnuMlpxt9YzZE2H4qtoorPKVW/Msd52kUPqSjy0brcPKhr/luvzhzmajSUn
	r2lYgbwU80bsPr9dCKAbrHzAiHMcIwg8E64rbxFGCmo2Jm8dJ0IE=
X-Gm-Gg: AeBDiesYKGm2x6hdmhot1t46Vdldh3qF3Auud2GUGQNR5KZ7mY/HIWCzvIEFz6cmAHJ
	ikxZgunPXq5/dHNHsx6IUPshxAM3knb4h/v2ngd64FRGBhpkz7/EIv3B2MIYcW+49UPgdx4i7+e
	FfBGnaI9GHQXLl6OpsDX5Da+hQPUdYdMBEp/CK6ClMEGPEzdhZH834e03SIzdQ42c03SKarPFxC
	dxDoV569ZA6EElUmc2jLZzvIUikq4c3dgkjexMYidOgJA4MsQH4ISIiWqNV7A6Kkd1FlvIcrc8N
	1FtlmeF5Yuev8rovJ99yrUnUaOIfEhkdFtuyaHau88Pta8tlnz72P9VBwTZuY9Pi6jGy+NVGV01
	Xl79oj9Kr0pWsI1kAh7YKsROBQvFXmWZlbbKMPymet/BlaygumZFMSYoqZ8cnQaV+DQXc07Mw5s
	FDGUBdIirXYg40c5pbaiXaqJsMykngoQqhgQGtO9u3thjdrKEqiImam6pyKdANHEkrzY8KJX60
X-Received: by 2002:a05:600c:8599:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-48a8447c7eamr39024215e9.23.1777557641252;
        Thu, 30 Apr 2026 07:00:41 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2493:6197:23ff:7e65? ([2001:67c:2fbc:1:2493:6197:23ff:7e65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217b20sm12757756f8f.22.2026.04.30.07.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 07:00:40 -0700 (PDT)
Message-ID: <a643b413-9997-4a28-a0de-919b83b327e9@openvpn.net>
Date: Thu, 30 Apr 2026 16:00:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with
 BH disabled
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 ralf@mandelbit.com, Sabrina Dubroca <sd@queasysnail.net>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <20260429120120.514491-1-antonio@openvpn.net>
 <20260429120120.514491-3-antonio@openvpn.net>
 <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net>
 <CANn89i+kGAXWEmgSwrUyRhh7kk6r3FjEza9mjDXq4AjwbC5DZA@mail.gmail.com>
 <4930aa65-6d0e-4ff8-8e7b-91feee1ce646@openvpn.net>
 <CANn89i+5q8D50sEKUwk1OzGt8tZD2ddSK-kHGq6dFm5QRRpaDQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CANn89i+5q8D50sEKUwk1OzGt8tZD2ddSK-kHGq6dFm5QRRpaDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 578EB4A3CAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_FROM(0.00)[bounces-282874-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid]

On 30/04/2026 15:43, Eric Dumazet wrote:
> On Thu, Apr 30, 2026 at 6:40 AM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> Hi Eric,
>>
>> On 30/04/2026 15:37, Eric Dumazet wrote:
>>> On Thu, Apr 30, 2026 at 6:28 AM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>>
>>>> Hi Jakub,
>>>>
>>>> sashiko came back with an interesting review of the per-cpu stats update
>>>> in the surrounding code.
>>>>
>>>> As far as I can tell its explanation makes sense, but I am no per-cpu
>>>> expert.
>>>>
>>>> IIUC it basically says that if gro_cells_receive() is invoked with
>>>> bottom halves disabled, the following dev_dstats_rx_add() should be too
>>>> to avoid deadlocks and corruptions.
>>>>
>>>> See below:
>>>>
>>>> On 29/04/2026 14:01, Antonio Quartulli wrote:
>>>>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>>>>> index d92bb87be2b2..c0fdb9504241 100644
>>>>> --- a/drivers/net/ovpn/io.c
>>>>> +++ b/drivers/net/ovpn/io.c
>>>>> @@ -91,7 +91,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>>>>>
>>>>>         /* cause packet to be "received" by the interface */
>>>>>         pkt_len = skb->len;
>>>>> +     /* we may get here in process context in case of TCP connections,
>>>>> +      * therefore we have to disable BHs to ensure gro_cells_receive()
>>>>> +      * doesn't enter deadlock
>>>>> +      */
>>>>> +     local_bh_disable();
>>>>>         ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
>>>>> +     local_bh_enable();
>>>>>         if (likely(ret == NET_RX_SUCCESS)) {
>>>>>                 /* update RX stats with the size of decrypted packet */
>>>>>                 ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
>>>>    >>             dev_dstats_rx_add(peer->ovpn->dev...) << not visible in the diff,
>>>> but it's here
>>>>
>>>> from sashiko:
>>>>
>>>> Can this lead to seqcount deadlocks and stat corruption since
>>>> dev_dstats_rx_add() is executed with preemption and bottom-halves enabled?
>>>> dev_dstats_rx_add() operates on per-CPU statistics and protects 64-bit
>>>> updates with a sequence counter (u64_stats_update_begin()). When called
>>>> from process context with BH enabled, on 64-bit systems, this_cpu_ptr()
>>>> is evaluated with preemption enabled. If the task is migrated mid-update,
>>>> it risks cross-CPU stat corruption.
>>>> On 32-bit systems, u64_stats_update_begin() disables preemption but not
>>>> bottom-halves. If a softirq (e.g., a concurrent UDP packet reception)
>>>> interrupts the process context and calls dev_dstats_rx_add() for the same
>>>> interface, it will re-enter the seqcount writer lock on the exact same CPU.
>>>> This corrupts the sequence counter, causing readers to see an unlocked
>>>> sequence during active writes, leading to torn reads and corrupted stats.
>>>> Should local_bh_enable() be moved after the statistics updates to ensure
>>>> the entire per-CPU update is atomic with respect to softirqs?
>>>>
>>>>
>>>> Do you have an opinion?
>>>
>>> Sashiko suggestion seems good to me.
>>
>> But am I right saying that this bug existed before and it is not
>> introduced by this patch?
>>
>> A concurrent softirq (UDP RX pkt) could already trigger this problem
>> before we introduced the local_bh_disable/enable() calls, right?
> 
> I think we are saying the same thing.

Ok.

> 
> Let me rephrase: The bug was introduced in:
> 
> Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")

Well, the process context was introduced by

     11851cbd60ea ("ovpn: implement TCP transport")

because the TCP code relies on strparser.

Before 11851cbd60ea we had UDP only, therefore everything was happening 
in softirq, which means no bug existed (if I have understood this 
correctly).

Makes sense?

[in any case, both commits were basically merged side by side]


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


