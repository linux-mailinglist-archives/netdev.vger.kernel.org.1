Return-Path: <netdev+bounces-261553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCNcEVCgoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:34:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71F1AE663
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDE830AA020
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD1355F38;
	Thu, 26 Feb 2026 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHjDpk84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC0423A8E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134140; cv=none; b=EgJkdbEv2wzydj67/5Ra51FtAw4RTwf9TEiNvHgZVnTflm5oqcNAc3amx8YXQo/k6ui2cYAqt5P21h0j2xlubg4p3sjLlcRhjvJ31d5ir+TgN9RHGyrtTIiTNvXbBsF9zSRfePD9jDIWoRdYEOQi1uzwSPB7G1jIM6x8x/9Er6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134140; c=relaxed/simple;
	bh=zlx02dfFFH3C/GMKZgoV/iOPRsXqWy2zd+GP10dVec8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSmqdyNZfBrfsQNhvmNXTAhQ3gMNdbKjd9EWlRITDp+5PpkAHiJ5ZzZ3ftvE/gCoUoBFT+VTcCD7KjcdJ/C0ywjpkWboWD/QJZWIp/H9J00h2A7CINAOVhUvVt3TBt1wJZU0icVHFp51u9PWW7T3TkBbRmWYmL+p55B0aMbYcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHjDpk84; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so10165505e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134135; x=1772738935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62g91QiQkJ/r/GOyxudf+i3snP9f/7zqyZVkGJABwWw=;
        b=eHjDpk84F16Q/ym8mV9c5ephofjs6wBggjG9ZhI9z4ioLeLouKpMTeHGh5A1J/o+RF
         IkV/CbQ7Wheij+SNtwzL1sTIcskIP1X3TiXDXU5VpZnpQQkSnhFSNde2wUEDAz+KY/yO
         i9PzhHH7imTf33dXz1KARkrRRo/PTvWN/ErUrivu5EKmpm3V5JlAxdpmslCiQZcA097A
         CQQcSbSOlx/zp3zGh1RdOsCKj6u/1bw6DRXvz9b2mARv8hfjsDHBJFyZdUKM1E/pePNl
         o+jh0oQYemMqHt1X+JyWpzSaJVGFvYcGpGUCih/m0HPAWppBOzsx74sVaVN/F60NnTUI
         aq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134135; x=1772738935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62g91QiQkJ/r/GOyxudf+i3snP9f/7zqyZVkGJABwWw=;
        b=FyS3ZKUKbGYKilEFeVtQAzUfAYl2xudAV3W59RTCj5wrsKOn30ml+oddUVG/6ArpQC
         Bxz6lb5czc7728kaHb1HUpmOdEoMHq5sZrVWwy6gMSHhL84ZpFBzLa6R7ou6a1x+sV0S
         PtnmRpp4WytRz8PF7IhuzlThEY7BDDm8YfcAXxmGzUdYG5P+B86wVupZs9uVlLyDekoa
         fGbue/Eu3YoNBdcPh01adKx0m1urhDVHFM3EDNgcWjf1Ac5qqAvSFnTf+0l2eAWiF3cJ
         HmJ5dHBTwbj92hF/Ut2t+WBc8ZYGx6EnUGU00ISYlTsUJgLYngUqAdY+L9O3q2z7VM7F
         9aaA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0TewBgmh/ruCDY5Y/6mB1CJqNzZEXd3ZgmwhNPjKNRk+GmShzckwaSfB7SXsWV1H6qWsvRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz668FRubZClwHXCBlzTU0iBwmMcaehrVmAqaG10ZNkBpPCKFOw
	yeAwDrZnd5y1EdTdyYLRa4s/cHdvvjoVoNoktp0ST/LnV1HxRQj5u6W7
X-Gm-Gg: ATEYQzwYFRLgL/Ik9H3jdCErztB5bEwhdBM2IPNXzhQm9mYr+aGU4CNd0yzCa6RtMa1
	ARqtC6mrGZg4dQBkc78RHQSzPWcVDgCo2k5Nl/UhhW3oketN0Zb8c5bZFGdyVmPQ1kUsrb0F92s
	fBL/cMKjMuN7N2o4AIzbGhzjN2KrdiU1/hcMSxZ3VP6vsMtgzySMlZJZMrZDBFEWJqTiHIZcA4X
	pS0EcdtDKgckjZcI9ey1O6TqqiIh+W4uPMwvxJ79Jql4R0N0R9VhUX/AezajSrYIvbcQFerfsjj
	ve1f+DvSdcvsQhxInC1ZJDAYcVhWCCvKGOH8O0RWCCTpl4TxxWWCOPqXzcILFkvN7Vzlox0bG91
	BOOiatjbASdvh2Iga8KoE1kgrXFwITuXhmLhF132dsX/seWCvBqV4sQHXhqSv759wq+DG5xfB/l
	UOtICwPO2sdW1wY0g+Fn/WHUczmuEqOoz/uqnpudxGQPoGHQ/8MjZzi6/0wvA7P+ugUwF+WA==
X-Received: by 2002:a05:600c:810a:b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-483a95bda25mr348633745e9.10.1772134135248;
        Thu, 26 Feb 2026 11:28:55 -0800 (PST)
Received: from [192.168.178.48] (80-218-237-147.dclient.hispeed.ch. [80.218.237.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c7657c7sm1547881f8f.28.2026.02.26.11.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 11:28:54 -0800 (PST)
Message-ID: <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
Date: Thu, 26 Feb 2026 20:28:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
Content-Language: en-US
From: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Autocrypt: addr=zefir.kurtisi@gmail.com; keydata=
 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
In-Reply-To: <20260223163227.y3yzzpncyf5a7klq@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-261553-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zefirkurtisi@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD71F1AE663
X-Rspamd-Action: no action

Hi Vladimir,

On 2/23/26 17:32, Vladimir Oltean wrote:
> Hi Zefir,
> 
> On Fri, Feb 20, 2026 at 02:29:30PM +0100, Zefir Kurtisi wrote:
>> From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
>>
>> The fsl_enetc driver experiences soft-IRQ storms on LS1028A systems
>> where up to 500k interrupts/sec are generated, completely saturating
>> one CPU core. When running with a single core, this causes watchdog
>> timeouts and system reboots.
>>
>> Root cause:
>> The driver was writing to SITXIDR/SIRXIDR (Station Interface summary
>> registers) to acknowledge interrupts, but these are W1C registers that
>> only provide a summary view. According to the LS1028A Reference Manual
>> (Rev. 0, Chapter 16.3):
>>
>> - TBaIDR/RBaIDR (per-ring, offset 0xa4): RO, "Reading will
>>    automatically clear all events"
>> - SITXIDR/SIRXIDR (summary, offset 0xa18/0xa28): W1C, "provides a
>>    non-destructive read access"
>>
>> The actual interrupt sources are the per-ring TBaIDR/RBaIDR registers.
>> The summary registers merely reflect their combined state. Writing to
>> SITXIDR/SIRXIDR does not clear the underlying per-ring sources, causing
>> the hardware to immediately re-assert the interrupt.
>>
>> Fix:
>> 1. Point ring->idr to per-ring TBaIDR/RBaIDR instead of summary
>>     registers
>> 2. Remove per-packet writes to SITXIDR/SIRXIDR from packet processing
>> 3. Read TBaIDR/RBaIDR once per NAPI poll (in enetc_poll) before
>>     re-enabling interrupts
>>
>> This properly acknowledges interrupts at the hardware level and
>> eliminates the interrupt storm. The optimization of clearing once per
>> NAPI poll rather than per packet also reduces register access overhead.
>>
>> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
>> Tested-on: LS1028A (NXP Layerscape), Linux 6.6.93
>> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
>> ---
> 
> Thank you for your patch and for debugging.
> 
> I am not sure whether your interpretation of the documentation is
> correct. I have asked a colleague familiar with the hardware design and
> will come back when I am 100% sure.
> 
> Superficially, I believe you may have mixed up the documentation for
> SITXIDR/SIRXIDR with PSIIDR/VSIIDR. There, indeed, it says "Summary of
> detected interrupts for all transmit rings belonging to the SI (...)
> Read only, clear using SITXIDR."
> 
> I wonder whether it's possible you are looking at a different issue
> instead, completely unrelated to hardirq masking. I notice that stable
> tag v6.6.93 is lacking this commit:
> https://github.com/torvalds/linux/commit/50bd33f6b392
> which is high on my list of suspiciously similar issues in terms of behaviour.
> 
> (note: when submitting a patch to mainline net.git main branch, it's a
> good idea to also test *on* the net.git main branch, aka
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/)
> 
> I also note that I have put prints each time the driver clears the
> interrupts by writing to SITXIDR/SIRXIDR, and with various workloads on
> eno0/eno2/eno3, not once have I noticed the interrupt to still be pending
> in TBaIDR/RBaIDR.
> 
> Is there something special about your setup? What interfaces and traffic
> pattern are you using?
> 
> This patch should be put on hold until it is clear to everybody what is
> going on.

Thank you for the feedback and clarifications.

The statement that SITXIDR/SIRXIDR bits are directly linked to 
TBaIDR/RBaIDR is missing in the reference manual, i.e. it states that 
the former represent a summary of the latter, but not that W1C-ing the 
bits in SITXIDR would also move the other direction and clear TBaIDR. 
That clarifies quite a bit, thanks.

As for your request to take the mainline branch, I am depending on a 
OpenWRT build-system and shifting linux kernel-versions is unfortunately 
not something I can do in no time. As for the potentially missing patch 
you pointed me to, I backported that one, but it makes no difference.

Luckily meanwhile I was able to narrow down the issue and can provide 
you a means to hopefully reproduce it. This is the tl;dr version:

* enetc operates eth0
* ath9k operates wlan0
* both are bridged over OVS
* device is AP with an active STA connected to it
* STA regularly sends an L2 WNM keep-alive frame
  * that frame is 'buggy' as being tagged IPv4 but without payload
* through the OVS bridge that frame makes it into eth0 TX path
* enetc_start_xmit() enqueues it into TX-BD
* HW processes that descriptor, sets IDR and issues interrupt
* enetc_clean_tx_ring()
  * gets a bds_to_clean=0 (tx_ring->tcir = tx_ring->next_to_clean)
   * i.e. HW signals it completed the BD but did not advance TCIR
  * skips the while() loop
  * and hence never clears the according SITXIDR bit
* enetc_poll() after completion of ring processing
  * re-enables interrupts
  * but the one bit in SITXIDR is now sticky
* interrupt is re-asserted immediately
* the affected core remains 100% SIRQing
* it only recovers when the affected TX ring advances

So in short, enetc breaks when sending 0-byte frames.

The patch that I provided resolves the problem by force-cleaning all 
IDRs before interrupts are re-enabled. That is the sledge-hammer 
approach, since it also unmasks BDs that were just completed during
execution of enetc_poll() or no_eof BDs. Hence it is not the final
solution, but currently anything is better than a freezing box.

Below is the tool I wrote to fire such a frame-of-death. If you can 
reproduce the observation, I'd prepare a v2 patch to unblock the issue 
once it happens - preventing enetc_start_xmit() from sending such frames 
I'd leave to you, since that part looks complex to me to handle it properly.


Cheers,
Zefir

---

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <net/ethernet.h>
#include <netpacket/packet.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>

/*
  * Enetc-Killer
  *
  * This is a PoC for fsl_enetc Ethernet driver to detect an
  * issue the driver has when zero-payload IP packets are sent.
  *
  * It was detected when using an enetc Ethernet interface bridged
  * with a wireless interface operating as AP. A connected client
  * regularly sends L2 WNM keep-alive frames without IP payload.
  * Through the bridge this 'buggy' packet makes it into the
  * enetc TX path, which the driver enqueues for sending and
  * the HW signals transmission done but without providing a
  * completed TX-BD. This leads to a sticky interrupt detected
  * flag causing a SIRQ-storm.
  *
  * This has been tested on a LS1028A based system under an
  * OpenWRT derivative / linux 6.6.93
  *
  * To test:
  * * build and copy binary to device
  * * connect over serial, leave eth0 idle
  * * ensure device runs with multiple cores enabled (otherwise it freezes)
  * * run the program
  * * with top, observe that one core is fully loaded with SIRQ
  * * to recover, storm-ping eth0 from outside to
  *   enforce TX-BD advance
  */

int main()
{
	int sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (sock < 0) {
		perror("socket");
		return 1;
	}

	struct ifreq ifr;
	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, "eth0", IFNAMSIZ);
	if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
		perror("ioctl");
		return 1;
	}

	struct sockaddr_ll addr = { 0 };
	addr.sll_family = AF_PACKET;
	addr.sll_ifindex = ifr.ifr_ifindex;
	addr.sll_halen = ETH_ALEN;
	addr.sll_protocol = htons(ETH_P_IP);
	// Destination MAC (Broadcast)
	addr.sll_addr[0] = 0xff;
	addr.sll_addr[1] = 0xff;
	addr.sll_addr[2] = 0xff;
	addr.sll_addr[3] = 0xff;
	addr.sll_addr[4] = 0xff;
	addr.sll_addr[5] = 0xff;

	// "broken" packet: only Ethernet-header, no IP-payload
	// as sent by wpa_supplicant as L2 WNM keep-alive frame
	unsigned char buf[14] = {
		0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	// DST MAC
		0x00, 0x11, 0x22, 0x33, 0x44, 0x55,	// SRC MAC
		0x08, 0x00				// EtherType = IPv4
	};

	if (sendto(sock, buf, sizeof(buf), 0, (struct sockaddr*) &addr, 
sizeof(addr)) < 0) {
		perror("sendto");
		return 1;
	}
	close(sock);
	return 0;
}


