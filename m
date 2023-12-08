Return-Path: <netdev+bounces-55379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACE80AAD9
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA621C2081F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C939AD9;
	Fri,  8 Dec 2023 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoYjKvq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C0AD
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:34:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d05199f34dso18281555ad.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702056877; x=1702661677; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfkK96iearbD3Dwp0WR/m0UUvqIwQTcr2LSEAvnaVls=;
        b=QoYjKvq1EvZ7aPXSlz4Sqrd93GLEtbdCUQPKX4jW5AH6q1Lbs0OX560MDXm5NWeqpg
         M6sCyQxRCb9y7jaX6EOx/VVVml+eBrm/fFJg6Hgg0TcXp3Q50j+cJNo/e8lPpCMx8POs
         gAuH4h+aj31eN1tuBv5ZiE2KOtWKsEQYRX8J7SoFl6NT5DdtQMmBB1aKrTQBUWRE2Ha1
         GfAfo5FZX3mO+r3pKj8reRWbr99wJ/FzfyfkcfWJ5TyYzpXzAmzOqJp8C86iaRhcv38j
         T5mzo2uGnsMhYkPuyQq7EFpRtpHJmLo2vokZ+e8hUHsspzJLG8aoHD0sxOnAKbca3eo+
         3oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056877; x=1702661677;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfkK96iearbD3Dwp0WR/m0UUvqIwQTcr2LSEAvnaVls=;
        b=ibZRWhSokR3nNuQhaOSuOoC/Om9WUpByMQyIzprFsHl17VHSpE3EwPcEfzLT9H7aaH
         OtUfLnZ4sujOyuMWlFhWAYjOZHt/Dluc/IerHTO20jE0PK19WvLQDVRjiOi8vr2ez1hN
         8jHAJsFNMMhDAnOwJeWFEeET0PFwMjEFwcfFqx9mS/TbWdgF3j3O6BEejCEFWid2jIiC
         gbMPUTriTFOJ1fjBxJUhYFi3m5ZYqsYGATi5Cy//YkA1YgrZNeyiJgGjs/FNblwcz+6B
         V0cuNqARLpLHJkRiD6YD2wzWEaJb9RncC+cxD/WYpl1KEgwGKimCkE6WiA2D+hHv/ZX2
         fn8w==
X-Gm-Message-State: AOJu0YzGkT+3qASuCR14/FPhr04eC87z2olP/MNhIdI8wAA8IY5HPKZv
	mWiEhNwaDdpl5ndoQvNm+Wh9pSHqJUc=
X-Google-Smtp-Source: AGHT+IFpBAa9w/ySSBXCnzjOHnnv3rv30ErNZXgrNl1RX8UmsD3ji5W+zzeI++LLDlWncZ19r1L9XA==
X-Received: by 2002:a17:902:8692:b0:1d0:c6a6:10e8 with SMTP id g18-20020a170902869200b001d0c6a610e8mr358761plo.56.1702056876556;
        Fri, 08 Dec 2023 09:34:36 -0800 (PST)
Received: from smtpclient.apple ([2001:56a:78d6:ff00::184e])
        by smtp.gmail.com with ESMTPSA id pb17-20020a17090b3c1100b00286ed94466dsm2108346pjb.32.2023.12.08.09.34.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:34:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Rx issues with Linux Bridge and thunderbolt-net
From: Arjun Mehta <arjunmeht@gmail.com>
In-Reply-To: <4E2F8965-E609-44F2-A361-270082367DC9@gmail.com>
Date: Fri, 8 Dec 2023 10:34:25 -0700
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8111579-D8D6-40A0-B413-0DCA619FFEFD@gmail.com>
References: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
 <20231207143758.72764b9f@hermes.local>
 <4E2F8965-E609-44F2-A361-270082367DC9@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: Apple Mail (2.3731.700.6)

Also I want to clarify that the issue. You state "Most likely this is a =
hardware issue on the thunderbolt interface where it will not allow =
sending with a different source MAC address."

Actually the issue is that the interface will not _receive_. =
Transmission to another device from the interface works at full speed. =
Receiving is not working as expected.


> On Dec 8, 2023, at 10:30 AM, Arjun Mehta <arjunmeht@gmail.com> wrote:
>=20
> Hi Stephen, thank you for the reply.
>=20
> Proxmox does use a kernel derived from Ubuntu I believe (eg. kernel =
for Proxmox 8.1 which is what I'm using is 6.5.11-6-pve derived from =
Ubuntu 23.10). Not sure if there have been any modifications to the =
Linux Bridge in it.
> https://pve.proxmox.com/wiki/Proxmox_VE_Kernel#Proxmox_VE_8.x
>=20
> Long shot, but do you happen to know of any workarounds with the Wifi =
interface issue you mentioned that would mitigate this issue? Maybe they =
would apply here.
>=20
> I will also post to the Proxmox forums about this issue to flag for =
them.
>=20
> Arjun
>=20
>=20
>> On Dec 7, 2023, at 3:37 PM, Stephen Hemminger =
<stephen@networkplumber.org> wrote:
>>=20
>> On Thu, 7 Dec 2023 12:57:08 -0700
>> Arjun Mehta <arjunmeht@gmail.com> wrote:
>>=20
>>> Hi there, I=E2=80=99d like to report what I believe to be a bug with =
either Linux Bridge (maybe and/or thunderbolt-net as well).
>>>=20
>>> Problem: Rx on bridged Thunderbolt interface are blocked
>>>=20
>>> Reported Behavior:
>>> Tested on Proxmox host via iperf3, between B550 Vision D-P and =
MacBook Pro (2019 intel). On a direct interface, thunderbolt bridge Tx =
and Rx speeds are equal and full speed (in my case 9GB/s each). However, =
when a thunderbolt bridge is passed through via Linux Bridge to a VM or =
container (in my case a Proxmox LXC container or VM) the bridge achieves =
full Tx speeds, but Rx speeds are reporting limited to ~30kb/s
>>>=20
>>> Expected:
>>> The VM/CT should have the same general performance for Tx AND Rx as =
the host
>>>=20
>>> Reproducing:
>>> - Setup for the bridge was done by following this guide: =
https://gist.github.com/scyto/67fdc9a517faefa68f730f82d7fa3570
>>> - Both devices on Thunderbolt interfaces have static IPs
>>> - VM is given the same IP, but unique MAC address
>>> - BIOS has Thunderbolt security mode set to =E2=80=9CNo security=E2=80=
=9D
>>>=20
>>> Further reading:
>>> The problem is outlined more with screenshots and further details in =
this Reddit post: =
https://www.reddit.com/r/Proxmox/comments/17kq5st/slow_rx_speed_from_thund=
erbolt_3_port_to_vm_over/.
>>>=20
>>> Please let me know if there is any further action I can do to help =
investigate or where else I can direct the bug/concern
>>=20
>> Most likely this is a hardware issue on the thunderbolt interface =
where it will not
>> allow sending with a different source MAC address.  Some Wifi =
interfaces have this
>> problem.
>>=20
>> Is Promox using a kernel from upstream Linux repository directly.
>> Netdev developers are unwilling to assist if there are any =
non-upstream kernel modules in use.
>=20
>=20


