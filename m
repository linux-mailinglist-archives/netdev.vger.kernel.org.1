Return-Path: <netdev+bounces-87336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C08A2BDF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CBD1C216D5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7B53E25;
	Fri, 12 Apr 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSmeRVlX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D456B79
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916220; cv=none; b=cR536PusP+Cr+gCrh/lsigVbQPV+0IRazqHX/3KK5UTjJmIeNuHsRl9DgmXeaSAkV5OSAvoraC56iwrfIWDyc1VCzp8tIz/jd1UyLOijFGy0xjYReHZD4s+5xQnGofjL8/fwtUc9vJvEYfnk99ZY0TRQEIloTLOdiHvUcZD07yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916220; c=relaxed/simple;
	bh=kCFs8dBn/1JGpYG68c7Y3WMvHB5AZcmXQHrmDUIzERc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8LTx1lkgVCz56rXcrXoJ+pM/6i9LFGbtZ8FRV4I3kxcdcEQduj/nIm6p8xQX02tGna2/aNsAO3bldfhiYgXI4qiAWKTNN0NaNgel6u+JWtapVGn+HBf+j30KSS5sJ6uwgWx0MEhPgEgIUpzGYyyR3qS7Wnypkw7K5G6dcaWqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSmeRVlX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a523aebeab7so43277566b.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916217; x=1713521017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt+tPyeMNAbk7zJhN/JNu7Dh+NFSI25n+VJa9A5DC2c=;
        b=kSmeRVlXP4R/KQqNuvIfGnMOnZyQQ9SeYR6jugQihAcd+cjhJHNQBpluNaS/47bFpd
         KpfY1YlrQHvZQujs/hzP5CZOkc2S1t7QLOGSIU1DQXFUYqKzwH07EtOysFO00DyFefBK
         1StxTqxjXLpY0T8g9nPp9ZWOsihwPhPqrKzmnXOwHg6gxAOUUbMA2p8Ofh7jbzXidbfp
         tYaOQz5iXMFvLXhgSlDEldZfbCHmnP5tAQajVzg7zFvsCCApNgh9zkhd1uAMV40KrZKc
         YLi3i5PPNENVfK/9dCreSTBOjkDH6uiiHNRczLGlvLYcXZf0UFed8qwQFW5W8DabXG4T
         sRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916217; x=1713521017;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt+tPyeMNAbk7zJhN/JNu7Dh+NFSI25n+VJa9A5DC2c=;
        b=rE2FTbNmbU39cNXRVcjU//ikO8+ple7TC78nWQdG32jwkIXmoapB3Q9UdYBzgFXf1W
         3zQa8ZTTck8vMuqNCEZHUQBaexCCUGnc1B7RYz5to30eRB6MhDYNwk7INNfeNz1gKFmG
         Ds9UcmBig0KTiE4GdZUXNtKEl5oU6uILT2IBOWA+n9URJAXlHK5K4JfYg+wUHuixsHQo
         cR1EL+B+3hCIguN5JOnU+YAUj6xfLzXnVM6WtkSMUMS1H+LB2/aqWo56/POSD1Pu4FRI
         YqBpp2IwB+LGM83vA+KIHpx+mfBSwRhnD/aluKN+6dXHtq/7U7nLRrB6x7WU34UzX5F/
         Dl3g==
X-Gm-Message-State: AOJu0YxWsRbVX/7AKJ+ypJ/Ta9joFE02+l0hJO7RrGsov5n7VmMLE26W
	U2yO1Qp7uNUhEcOGXUrO8OI7WY7JqXQu7VCZTfqggbR42R4xu5VI
X-Google-Smtp-Source: AGHT+IGvT//JH40VviLyTrgfAlkGnQqnpYlXhonrVb9T2xCHbXCuYi4vmPn0dtltDBj9pQ+DqObS8g==
X-Received: by 2002:a17:906:a84e:b0:a52:1733:c77 with SMTP id dx14-20020a170906a84e00b00a5217330c77mr1397063ejb.9.1712916216495;
        Fri, 12 Apr 2024 03:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a91:3c00:7438:ddfe:2573:311f? (dynamic-2a01-0c22-7a91-3c00-7438-ddfe-2573-311f.c22.pool.telefonica.de. [2a01:c22:7a91:3c00:7438:ddfe:2573:311f])
        by smtp.googlemail.com with ESMTPSA id bq16-20020a170906d0d000b00a51aa517076sm1660541ejb.74.2024.04.12.03.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:03:35 -0700 (PDT)
Message-ID: <a4a6df3b-550e-4868-973b-5218462bab1d@gmail.com>
Date: Fri, 12 Apr 2024 12:03:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Crash in new PHY link topology extension
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.04.2024 12:00, Heiner Kallweit wrote:
> On today's linux-next I get the following.
> 
> Apr 12 11:36:03 zotac kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
> Apr 12 11:36:03 zotac kernel: #PF: supervisor read access in kernel mode
> Apr 12 11:36:03 zotac kernel: #PF: error_code(0x0000) - not-present page
> Apr 12 11:36:03 zotac kernel: PGD 0 P4D 0
> Apr 12 11:36:03 zotac kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> Apr 12 11:36:03 zotac kernel: CPU: 1 PID: 219 Comm: systemd-network Not tainted 6.9.0-rc3-next-20240412+ #2
> Apr 12 11:36:03 zotac kernel: Hardware name: Default string Default string/Default string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
> Apr 12 11:36:03 zotac kernel: RIP: 0010:__lock_acquire+0x5d/0x2550
> Apr 12 11:36:03 zotac kernel: Code: 65 4c 8b 35 65 5d d1 7e 45 85 db 0f 84 bd 06 00 00 44 8b 15 f5 f8 14 01 45 89 c3 41 89 d7 45 89 c8 45 85
>  d2 0f 84 c5 02 00 00 <48> 81 3f 00 f3 8a 82 44 0f 44 d8 83 fe 01 0f 86 bd 02 00 00 31 d2
> Apr 12 11:36:03 zotac kernel: RSP: 0018:ffff9ca180e6f498 EFLAGS: 00010002
> Apr 12 11:36:03 zotac kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> Apr 12 11:36:03 zotac kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
> Apr 12 11:36:03 zotac kernel: RBP: ffff9ca180e6f510 R08: 0000000000000000 R09: 0000000000000000
> Apr 12 11:36:03 zotac kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> Apr 12 11:36:03 zotac kernel: R13: 0000000000000000 R14: ffff98e7c5b38000 R15: 0000000000000000
> Apr 12 11:36:03 zotac kernel: FS:  00007f7e7440e0c0(0000) GS:ffff98e937a80000(0000) knlGS:0000000000000000
> Apr 12 11:36:03 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Apr 12 11:36:03 zotac kernel: CR2: 0000000000000018 CR3: 00000001027c0000 CR4: 0000000000750ef0
> Apr 12 11:36:03 zotac kernel: PKRU: 55555554
> Apr 12 11:36:03 zotac kernel: Call Trace:
> Apr 12 11:36:03 zotac kernel:  <TASK>
> Apr 12 11:36:03 zotac kernel:  ? show_regs+0x5f/0x70
> Apr 12 11:36:03 zotac kernel:  ? __die+0x1f/0x70
> Apr 12 11:36:03 zotac kernel:  ? page_fault_oops+0x15a/0x450
> Apr 12 11:36:03 zotac kernel:  ? debug_smp_processor_id+0x17/0x20
> Apr 12 11:36:03 zotac kernel:  ? rcu_is_watching+0x11/0x50
> Apr 12 11:36:03 zotac kernel:  ? exc_page_fault+0x4cb/0x8d0
> Apr 12 11:36:03 zotac kernel:  ? asm_exc_page_fault+0x27/0x30
> Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x5d/0x2550
> Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x3f8/0x2550
> Apr 12 11:36:03 zotac kernel:  lock_acquire+0xc8/0x2f0
> Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> Apr 12 11:36:03 zotac kernel:  _raw_spin_lock+0x2d/0x40
> Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> Apr 12 11:36:03 zotac kernel:  phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> Apr 12 11:36:03 zotac kernel:  phy_attach_direct+0xcd/0x410 [libphy]
> Apr 12 11:36:03 zotac kernel:  ? __pfx_r8169_phylink_handler+0x10/0x10 [r8169]
> Apr 12 11:36:03 zotac kernel:  phy_connect_direct+0x21/0x70 [libphy]
> Apr 12 11:36:03 zotac kernel:  rtl_open+0x30c/0x4f0 [r8169]
> Apr 12 11:36:03 zotac kernel:  __dev_open+0xe8/0x1a0
> Apr 12 11:36:03 zotac kernel:  __dev_change_flags+0x1c5/0x240
> Apr 12 11:36:03 zotac kernel:  dev_change_flags+0x22/0x70
> Apr 12 11:36:03 zotac kernel:  do_setlink+0xe9f/0x1290
> Apr 12 11:36:03 zotac kernel:  ? __nla_validate_parse+0x60/0xce0
> Apr 12 11:36:03 zotac kernel:  rtnl_setlink+0xff/0x190
> Apr 12 11:36:03 zotac kernel:  ? __this_cpu_preempt_check+0x13/0x20
> Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv_msg+0x16e/0x660
> Apr 12 11:36:03 zotac kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> Apr 12 11:36:03 zotac kernel:  netlink_rcv_skb+0x5a/0x110
> Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv+0x10/0x20
> Apr 12 11:36:03 zotac kernel:  netlink_unicast+0x1a2/0x290
> Apr 12 11:36:03 zotac kernel:  netlink_sendmsg+0x1f9/0x420
> Apr 12 11:36:03 zotac kernel:  __sys_sendto+0x1d0/0x1e0
> Apr 12 11:36:03 zotac kernel:  ? __seccomp_filter+0x22e/0x3b0
> Apr 12 11:36:03 zotac kernel:  __x64_sys_sendto+0x1f/0x30
> Apr 12 11:36:03 zotac kernel:  do_syscall_64+0x6c/0x140
> Apr 12 11:36:03 zotac kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Seems phy_link_topo_add_phy() can't deal with argument topo being NULL.


