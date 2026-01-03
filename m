Return-Path: <netdev+bounces-246635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F46CEF8A2
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 01:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A82305F827
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA72264C0;
	Sat,  3 Jan 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIheJrua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE92222C8
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399858; cv=none; b=UOaPPFU81INHxMr7PH8RU44dyCljRhn/mo2F9k/O85572qqqbbbQPOY7OALAb/yKw5/vi9jGnQ8dt3NV8QxhMFWn2wIunMpwQGglbGmbTQieYVhKUev9gDBNpr0EEhhQSw5oXPIPlbuWfg56ibeprN49RkY1jSErqa4QQkUsNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399858; c=relaxed/simple;
	bh=GrruGnTWNFicIxTKog0wvHUDAWFhHC8XMrj2UCVjKRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxFhlx5Je8qYZKnM5tOmZQ2hVD8pLfPhKhKiAS0xBGg0f4qnrRJbCF9rMpTKalaKPUufcEs+kS0DijBse2kzA5OlWT1wNaj4xdhxEX7q5HPMfZwPwg9BKHGm7MbXKWc9pLe8F6V4yapCYno0gIiuDnpEmnloNmfvycqsdXucpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIheJrua; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f6ab1f67so647908f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767399854; x=1768004654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D95a5c1nOaQkivBqExxtnMCQs8Q4tlZPGQfVh8XzhJ8=;
        b=QIheJrua19UO2Tgvy6iSVcdH7C9ubyYrEgcR4d+a/EEPhJM1MlGi5Ha2qW2+5Y3JP6
         eK82d+ymADRm7v30o+2q8NbC1Gw6aK+6VVj95+bqTT6S/f3m63Ud+lZicAzsvKuEL/ck
         bp+KQEwhNOuKacSziE3VoPImMPyE4oE9q0uA/T5+hCwQvm2rZwHEOYXFiFU2Bm7UVNMJ
         tVdK4mMdlnHMVWSaEUXKER7wSCFAVCbu639s0JSjjVGr6bA7UuovpkyLqoCYRB0ABIJJ
         5izIeu9DpnOMdAmq2VrW4S3eqIUt59r5tCOzGefSmXhxtcsmOhktfgkVwTWUDRh4WCoL
         tspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399854; x=1768004654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D95a5c1nOaQkivBqExxtnMCQs8Q4tlZPGQfVh8XzhJ8=;
        b=BD4cpgybtF5Rm/Q65jE0b1eJ5122oe5fYPFvLdBO2d/RFC8VKqViies7u2mxX1Ajap
         dScXHV6PbrHq80oB2/bj6iGvQcJfhVDU7o01W/RYvfplX6ZmSbB+cs+HbT9cf89LhwRF
         aIBrusV54s5GZXYK+lfdKQaFQaAq0sqaRfa53HB83qyqH+mNiFwG3PPM4gcffcttncWs
         1XEOAkx/WPr0HW7PLz7J5p0eacEm0lUwpXEsWdoZp/Hs0cXjp86Zot8QJK8YVWQhQeAb
         sr5/Y5lOvIls3bmOfU8Pnjpk1z0HNihs4S7Swz6ebD3vqU04CS9sM0QeJ5eEBNL1ycev
         XKjw==
X-Forwarded-Encrypted: i=1; AJvYcCXHYBjzh67KJZonhj9f19oZHI7lqvq/gq1h+8jvvY4HLvE5Q7YmRdFeUL6nX439Se+bwNvK688=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDmyQSDBz+hTQus721k3oC+v8ShCIwgBqAQRwEMkMj1gSaQAM
	V41TNSz6Xiq2OeCOu7y8KmGTl4Kv1xjOAJuZZcN2PpDOUp33nKjvMcyy
X-Gm-Gg: AY/fxX6Eh/vAwRyX+ISdHDsWlGXV7cpuqPaUct+Qp48VYDe9f7dzO9BKwScMa9RyOGF
	ywXe4maoKnAPnokkl/7lda+oiSXzbOIg2T4gS0VMPc0oGfxt9GY+rgbPFyIUMM73/eCEY8XvGkZ
	p0egJPZlN7HU5TEAU9GQykSPCCb8ahDDJz4A9ML5Fb9ZrprRuE5HRKlJsamHwadWqErVFaz/ZUb
	42L3rw05wCFi57X8cLCPjYm6TnvAjrfBz3ku6K8n1RuYeAQ5se5PctRMMW2tUecAkSiPRkGEt7D
	jBP96RoA2jdNCR1r63hedsTQ4pce9M7zboDSEns+1/12q4+UjyaSpe3Cu7ixm76HO7UrJxkXbIg
	W4tZ/bzNllazJYm4z7z68rlLHJhkTfNMefy04ejht6mjKKW67OmRenRKfJiBvRx4lqstDISxFy0
	uLjQ==
X-Google-Smtp-Source: AGHT+IHXO+SKLKqYCf/PmRSq/tuN2EoFNx+cLMtlICEErr5AEN8+fpwT7TqnosDuyMb4fsxKDrG0Pw==
X-Received: by 2002:a05:600c:310e:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-47d195815b0mr328415975e9.6.1767399853446;
        Fri, 02 Jan 2026 16:24:13 -0800 (PST)
Received: from skbuf ([2a02:2f04:d804:300:99e9:1ddf:4bef:6664])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed0asm9818545e9.3.2026.01.02.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:24:12 -0800 (PST)
Date: Sat, 3 Jan 2026 02:24:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: Fw: [Bug 220932] New: Possible bug (use after free) on DSA
 driver removal
Message-ID: <20260103002410.brxrcajbnd2bpq5a@skbuf>
References: <20260102114605.3351c6eb@phoenix.local>
 <20260102114605.3351c6eb@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102114605.3351c6eb@phoenix.local>
 <20260102114605.3351c6eb@phoenix.local>

Hi Luiz,

On Fri, Jan 02, 2026 at 11:46:05AM -0800, Stephen Hemminger wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Thu, 01 Jan 2026 22:56:38 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220932] New: Possible bug (use after free) on DSA driver removal
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220932
> 
>             Bug ID: 220932
>            Summary: Possible bug (use after free) on DSA driver removal
>            Product: Networking
>            Version: 2.5
>           Hardware: Mips32
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: luizluca@gmail.com
>         Regression: No
> 
> While testing a driver patch for OpenWrt (dev), I noticed that the system
> sometimes crashes a little after I remove the module. I dropped all my patches
> and bruteforce it:
> 
> 
> echo 'file drivers/net/dsa/realtek/rtl8365mb.c +p' >
> /sys/kernel/debug/dynamic_debug/control; echo 'file net/dsa/* +p' >
> /sys/kernel/debug/dynamic_debug/control; rmmod rtl8365mb; echo 0 >
> /proc/sys/kernel/panic; while true; do sleep 1; insmod /tmp/rtl8365mb.ko; sleep
> 10; rmmod rtl8365mb; done
> 
> 
> After a couple of cycles, I got this (repeatable) crash below.
> rtl8365mb_get_tag_protocol and rtl8365mb_port_stp_state_set messages are from a
> small debug patch I added trying to trace the crash origin but it should not
> matter.
> 
> 
> [  469.884379] DSA: tree 0 torn down
> [  471.094669] rtl8365mb-mdio mdio-bus:1d: found an RTL8367S switch
> [  471.100980] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_get_tag_protocol priv:126ea59d
> [  471.349018] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.357364] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.365716] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.373964] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.382228] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.390503] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set priv:126ea59d
> [  471.398580] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_change_mtu priv:126ea59d
> [  471.647590] mtk_soc_eth 10100000.ethernet eth0: port 5 link down
> [  471.674092] CPU 0 Unable to handle kernel paging request at virtual address 702e7660, epc == 702e7660, ra == 80001e90
> [  471.685048] Oops[#1]:
> [  471.687381] CPU: 0 UID: 0 PID: 7473 Comm: modprobe Tainted: G           O       6.12.60 #0
> [  471.695837] Tainted: [O]=OOT_MODULE
> [  471.699401] Hardware name: TP-Link Archer C5 v4
> [  471.704029] $ 0   : 00000000 00000001 81c40560 80a63cdc
> [  471.709403] $ 4   : 00000cc0 00000001 0004c50b 82ab2f00
> [  471.714771] $ 8   : 0004c50c 00000cc0 00000000 77e89000
> [  471.720139] $12   : 00000003 82b8dc0c 00000001 77e8afff
> [  471.725508] $16   : 00001173 77e89000 7f958894 00400dc1
> [  471.730877] $20   : 8383fbf8 77e903d0 00000000 7f958730
> [  471.736246] $24   : 00000003 8084aba8
> [  471.741613] $28   : 81c1c000 81c1df28 00000000 80001e90
> [  471.746982] Hi    : 00000000
> [  471.749926] Lo    : 00000000
> [  471.752868] epc   : 702e7660 0x702e7660
> [  471.756798] ra    : 80001e90 work_notifysig+0x10/0x18
> [  471.761975] Status: 1100b403 KERNEL EXL IE
> [  471.766269] Cause : 50800008 (ExcCode 02)
> [  471.770366] BadVA : 702e7660
> [  471.773309] PrId  : 00019650 (MIPS 24KEc)
> [  471.777406] Modules linked in: rtl8365mb(+) rt2800soc(O) rt2800mmio(O) rt2800lib(O) pppoe ppp_async nft_fib_inet nf_flow_table_inet rt2x00mmio(O) rt2x00lib(O) pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mt76x2e(O) mt76x2_common(O) mt76x02_lib(O) mt76(O) mac80211(O) cfg80211(O) slhc nfne tlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c crc_ccitt compat(O) i2c_dev ledtrig_usbport sha512_generic seqiv sha3_generic jitterentropy_rng drbg hmac geniv rng cmac leds_gpio tag_rtl8_4 realtek_dsa dsa_core gpio_button_hotplug(O) realtek hwmon i2c_core phylink crc32c_generic [last unloaded: rtl8365mb]
> [  471.854523] Process modprobe (pid: 7473, threadinfo=674a8fb4, task=b017bdbf,tls=77e98dfc)
> [  471.862981] Stack : 00000000 00000000 00000000 00000000 77e97290 00420f3877e97290 00420f10
> [  471.871571]         00000000 00000001 00000000 77e1f644 77e89000 0000117300000000 00000000
> [  471.880157]         0000000c 83855940 77e85000 77e77000 81b911e5 0000000181bbac60 77e85fff
> [  471.888745]         00001173 77e89000 7f958894 00400dc1 8383fbf8 77e903d000000000 7f958730
> [  471.897333]         81bbac60 77e556d0 00000001 00000000 77e97290 7f95845000000000 77e1f674
> [  471.905921]         ...  
> [  471.908431] Call Trace:  
> [  471.908437]
> [  471.912653]
> [  471.914177] Code: (Bad address in epc)
> [  471.914177]
> [  471.919517]
> [  471.921240] ---[ end trace 0000000000000000 ]---
> [  471.926052] Kernel panic - not syncing: Fatal exception
> [  471.931404] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> The RA value (80001e90 work_notifysig+0x10/0x18) indicates that the crash came
> from a notification. Maybe DSA didn't unregister/drain notifications after the
> tear down.

My reading of work_notifysig() is that this is delivering signals to
user space, completely unrelated to DSA. It is just what the return
address was at the time of the crash.

The epc == 702e7660 possibly means that the kernel tried to execute code
through a stale function pointer.

Nothing in rtl8365mb looks particularly out of place in terms of things
that could linger on after the driver is unregistered. I looked at:
- priv->user_mii_bus could host a PHY whose state machine continues to
  run. But it is allocated and registered using devres.
- mb->irq cannot fire after rtl8365mb_irq_teardown()
- p->mib_work cannot get rescheduled after rtl8365mb_stats_teardown(),
  because the ports are already torn down by the time the switch is torn
  down, and the phylink instance which schedules the mib_work is destroyed

The only question mark right now is with the many out-of-tree modules.
If there's anything in the kernel holding a pointer to the DSA switch,
it needs to drop it when the switch driver is removed.

> 
> I'm using kernel 6.12.60 (LTS) and I also didn't notice any relevant changes
> since that version. I'm just not sure if
> 2bcf4772e45adb00649a4e9cbff14b08a144f9e3 would be related.
> 

Without a stack trace, it's hard to say what could be wrong. Could you
retest with CONFIG_KALLSYMS, CONFIG_FRAME_POINTER, CONFIG_STACKTRACE and
whatever else might be needed to produce a stack trace on MIPS?

In addition, could you try enabling some debug options for use-after-free
which are more lightweight than KASAN? I'm thinking of:
CONFIG_SLUB_DEBUG + CONFIG_SLUB_DEBUG_ON,
CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT (if memory allows)

If this doesn't point to anything, you could simplify the setup and
teardown (and then probe and remove) methods little by little until you
find the culprit. The idea being that a driver which doesn't do anything
on probe and remove shouldn't crash the kernel.

