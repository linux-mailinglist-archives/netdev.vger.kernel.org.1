Return-Path: <netdev+bounces-55378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250E80AAD1
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549F31C20825
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956E39ACC;
	Fri,  8 Dec 2023 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZZVQv7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E21738
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:30:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so1812333b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702056651; x=1702661451; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl5UZt4oYlqqBEsE/HSUIOZO8FgWoe/bgzIJwRORg44=;
        b=NZZVQv7DBMbJ/Z1anq9XKymTMMuQu8wLuqXy9/XxYglie0iIy2exrvQ9Y/5FasRrxm
         w1HgKA2VFYWMUn0/R6PVOFI60qKsUvl9Nv3CtB/e1M7xiu5SJJR+aPjWTtUjbjpkZ8OM
         pTy28Ihr+e73gWR1x4F5AIfdft/lWxBMSRpqCSHbV3R2w4SHRcxoyKxcJV1GhqK6Cfd/
         Ir8ut9kbzR/mwb8BGUDkVpdWF7TMfMEtWx96lBQsCI3qsZLH9WU0/KuIp/q2c3aJrU0C
         /6DhRYy94DlLJm38l5CK3LVwSMetlqSRU8P54EvcJJjOaLh5InEb4CKgm8slI2Gqd+uf
         xs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056651; x=1702661451;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl5UZt4oYlqqBEsE/HSUIOZO8FgWoe/bgzIJwRORg44=;
        b=iV5OjChlreJbUQGCBlFXebETQC0Y8UAtSMoV1lRLLV0AzWUVqvKBjPtfnUzSwVEsA9
         yPZbBzOqq+aaIBGeyrhCXPI1JZLYy2x38B/u0XW3no7VZty0TtgCvQYPKlhS/2o9lltk
         iCpgKGhN395bfMF6Uv2McYoFytO7ZbsORVHZQ4M51UC4vqSr35d2qMmeAs3mird47H89
         yiSzHTJE1IjGBJ/zyMJB504JhH2NB9odKnswhFatRQ7zWU4AZ5KMimrSti79r7v7KOba
         SacLwYZ7vkthUJMbba83MwP3Uc6DHhxqbu3Pna9HOEBEXWb1+W1VyaoAM8S4nfOGBJ+o
         FbvQ==
X-Gm-Message-State: AOJu0YySucPmUqDsYdFS561boa32x8vNJEWOd8mPKOcvZIiN9A3n5LlV
	3Iv9mn825rtQ9JaoVBmWVuBHPzIwKqQ=
X-Google-Smtp-Source: AGHT+IGFxRI2i22lp3EwfW70mOT/RA2fdJbDttR1CeY2ge57xim0HKXGUr4OrDo9f/vJcb6tDEuE2Q==
X-Received: by 2002:a05:6a00:3305:b0:6ce:6007:9bb with SMTP id cq5-20020a056a00330500b006ce600709bbmr367286pfb.60.1702056651194;
        Fri, 08 Dec 2023 09:30:51 -0800 (PST)
Received: from smtpclient.apple ([2001:56a:78d6:ff00::184e])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006ce3bf7acc7sm1819873pfh.113.2023.12.08.09.30.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:30:50 -0800 (PST)
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
In-Reply-To: <20231207143758.72764b9f@hermes.local>
Date: Fri, 8 Dec 2023 10:30:39 -0700
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E2F8965-E609-44F2-A361-270082367DC9@gmail.com>
References: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
 <20231207143758.72764b9f@hermes.local>
To: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: Apple Mail (2.3731.700.6)

Hi Stephen, thank you for the reply.

Proxmox does use a kernel derived from Ubuntu I believe (eg. kernel for =
Proxmox 8.1 which is what I'm using is 6.5.11-6-pve derived from Ubuntu =
23.10). Not sure if there have been any modifications to the Linux =
Bridge in it.
https://pve.proxmox.com/wiki/Proxmox_VE_Kernel#Proxmox_VE_8.x

Long shot, but do you happen to know of any workarounds with the Wifi =
interface issue you mentioned that would mitigate this issue? Maybe they =
would apply here.

I will also post to the Proxmox forums about this issue to flag for =
them.

Arjun


> On Dec 7, 2023, at 3:37 PM, Stephen Hemminger =
<stephen@networkplumber.org> wrote:
>=20
> On Thu, 7 Dec 2023 12:57:08 -0700
> Arjun Mehta <arjunmeht@gmail.com> wrote:
>=20
>> Hi there, I=E2=80=99d like to report what I believe to be a bug with =
either Linux Bridge (maybe and/or thunderbolt-net as well).
>>=20
>> Problem: Rx on bridged Thunderbolt interface are blocked
>>=20
>> Reported Behavior:
>> Tested on Proxmox host via iperf3, between B550 Vision D-P and =
MacBook Pro (2019 intel). On a direct interface, thunderbolt bridge Tx =
and Rx speeds are equal and full speed (in my case 9GB/s each). However, =
when a thunderbolt bridge is passed through via Linux Bridge to a VM or =
container (in my case a Proxmox LXC container or VM) the bridge achieves =
full Tx speeds, but Rx speeds are reporting limited to ~30kb/s
>>=20
>> Expected:
>> The VM/CT should have the same general performance for Tx AND Rx as =
the host
>>=20
>> Reproducing:
>> - Setup for the bridge was done by following this guide: =
https://gist.github.com/scyto/67fdc9a517faefa68f730f82d7fa3570
>> - Both devices on Thunderbolt interfaces have static IPs
>> - VM is given the same IP, but unique MAC address
>> - BIOS has Thunderbolt security mode set to =E2=80=9CNo security=E2=80=9D=

>>=20
>> Further reading:
>> The problem is outlined more with screenshots and further details in =
this Reddit post: =
https://www.reddit.com/r/Proxmox/comments/17kq5st/slow_rx_speed_from_thund=
erbolt_3_port_to_vm_over/.
>>=20
>> Please let me know if there is any further action I can do to help =
investigate or where else I can direct the bug/concern
>=20
> Most likely this is a hardware issue on the thunderbolt interface =
where it will not
> allow sending with a different source MAC address.  Some Wifi =
interfaces have this
> problem.
>=20
> Is Promox using a kernel from upstream Linux repository directly.
> Netdev developers are unwilling to assist if there are any =
non-upstream kernel modules in use.



