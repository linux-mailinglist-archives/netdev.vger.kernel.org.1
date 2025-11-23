Return-Path: <netdev+bounces-241071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C1C7E932
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14083A6DB4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C527C84B;
	Sun, 23 Nov 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ14KnRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEB27A123
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938490; cv=none; b=dsX2Wk33ZtqXUFlW2/zlmisnXGIRHY39+HerVxZD+Q25+e+YcTshG1M4wnHnDXpMhQdB22gF2LXhevI3fsnGqLtwC/EUd+Au6H8Y4YWL/Op+p1aNUI9gWqaKJKjLhlW9UG+w756TSS1bFw28/Z7BM2c5SV6HSekTDCKlSVQloaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938490; c=relaxed/simple;
	bh=piJafTIDiwNynzV++L4ciEnUVDZAglPLTI6DaKyAnxQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=MnKUN588OQ26EufhYU8jd3NjcaelIbArLgfMnp0BTOUV23ksUhA+DKTyWIwXfF3w7Z7hNMQp6wGkVJyrvggxtRXesPM2oHMGybwPvDlOxS5pSVQOLXYtZs0UsrtGyNw1AhAnp4LLIEGL65/zEnmKzyaFsiFfMhI4SRolScY3yZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ14KnRE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47790b080e4so19245345e9.3
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938484; x=1764543284; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKWbsiM5IfEjQHOsCxlpd6wq/e8QDivMefIg6uigHYY=;
        b=YQ14KnREwfVltnfGvHBejQNWNNgcOuD1fp8nq84od8yES3tF+IA0KP490tNiFVpFqq
         i67d4Umit3DxvLa9MdgmXyOWCPjQm9BX2NPYkhNmbxJ4G0H1BFhDtYue+wKxR6WIbqjv
         PdWVeIScngVtwbeXDypcm6luj7jzUjswWmh9cC8xap51IEQDvhXIISBPvOvOtnc3aTra
         3Yp1p3r5UjLx+05FoEgLAjOgnt7KegyydGAlTit5IlYtCbzn+PYDZRftgZ7989uFltSd
         K+k1sy8lilPAhBuJmRf7x+iPl6ozkHLz+xVrlexbtc3C78TSL3EBdSpOkYn0pWVqQ3S4
         /Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938484; x=1764543284;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKWbsiM5IfEjQHOsCxlpd6wq/e8QDivMefIg6uigHYY=;
        b=g6DLQ+3M/gWvhEnBP0T/W8eGqzC2nRH+2Z2c1y+F7sD3pQiTIzasMTf3oUjJ4HzG2p
         woe7y564ALMBTuFWCTTsK3fpSd49GeaC213rLs1jISqmtnTLO4AetRIx51IDHzcEl/iG
         6v4kQHrbUDNnF0Z71IAQEyJvOmjLYHs/cJNdM0dL/dst6Xgoc1XRROU3NhZjB7Hp5pRj
         q9iu4/9N2x4y2R56nD0Z0IKv8l96EJs8JBtG1fbtkJWfOToN+AX/pf//3Go12lYgYjwi
         D8pecg/gu7O3/G1TPZ287md+ZotKqn0xpwlKqJPoy/hj2B7LWNXIXWRnm7YbE00WFupd
         XURA==
X-Forwarded-Encrypted: i=1; AJvYcCU6QA1FpkpCidpqMgcjwrbpKqRVC/m1MUnlOVq/CllmaMUVdjh9TVhdoae2gAeIwE3oK7+X4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAcgB2v+K6nRA3lhvpUOsx+oszgMJRtllyVV7O+G3eMVQb3Ug
	60KURcB5C0MBgJYLGUzxlss7JgZNE3DIpLWE38oX00G9Nu9t4/SAq5HN
X-Gm-Gg: ASbGnctzq0C12Gp9My/SZrwYsu450n3WM/r8pJHmR6Bl3uKv7G998/vHb1XcM0pa9ig
	xeoO5u5v4vWbx1Spcaj+I8omjHzBJNAvcCJWjy2HYGYk+M+UCjpRg9Fkss74A4uNmluZFf00i2w
	CBDxUgeeCtcFeVjXGNyJ5x6SR6znfPyXErrhTgqUjkVEfXMLPulQVZ6oBx2XL7Bg2cigsmtnGIi
	jUy2l9LLuvGOj5fdZslOZZBPXzx0p5U+sIfhU+T7A35NYdU8dh28fsRVbPFcDHlDWVaA5tEuUsd
	sBzxHr3pPQhUVl+1F2NVAmIyMTKBpzrvu0K8Tdi5EkD3lf9aD3iHNn5vsm6e56CD3b9dcp1IUze
	Vnp8E63sV9GkfIefSMMPtomoZ6VBcR9Ht2Y9Jt+lpmxzArfm72ra/eZXG1SamgdMdFu600ENpdF
	oBMZkre/WjhtR683ogp/MkQbAemusHtAiNhhO71MxZ2v0RlBfwhcdFOmWBJYd4YpIVY8FY1mBi3
	7hkMsEpD/zoBd5/WFdYDPi6Gzg02iqrYt0vN4lyUzVmZ6thJnhbQw==
X-Google-Smtp-Source: AGHT+IF3/VNcuiY/SXHgmeHyjSvtl6MUTCtcMPOOyA5xUDmOC/QV2V94sa6qVvAb9vKenxNgsYpkiw==
X-Received: by 2002:a05:600c:4f14:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-477c10c802bmr101486315e9.3.1763938483887;
        Sun, 23 Nov 2025 14:54:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f07:a200:64d1:20ce:925d:2315? (p200300ea8f07a20064d120ce925d2315.dip0.t-ipconnect.de. [2003:ea:8f07:a200:64d1:20ce:925d:2315])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm170047565e9.0.2025.11.23.14.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 14:54:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------s1Hirkhv4vQis9DNEIDb9pUr"
Message-ID: <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
Date: Sun, 23 Nov 2025 23:54:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <aSNVVoAOQHbleZFF@google.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aSNVVoAOQHbleZFF@google.com>

This is a multi-part message in MIME format.
--------------s1Hirkhv4vQis9DNEIDb9pUr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/2025 7:41 PM, Fabio Baltieri wrote:
> Hi Heiner,
> 
> On Sun, Nov 23, 2025 at 04:58:23PM +0100, Heiner Kallweit wrote:
>> This is a version with better integration with phylib, and with 10G support only.
>> Maybe I simplified the PHY/Serdes initialization too much, we'll see.
>> A difference to your version is that via ethtool you now can and have to set autoneg to off.
>>
>> I'd appreciate if you could give it a try and provide a full dmesg log and output of "ethtool <if>".
>>
>> Note: This patch applies on top of net-next and linux-next. However, if you apply it on top
>> of some other recent kernel version, conflicts should be easy to resolve.
> 
> Thanks for the patch, ran some initial tests, I'm on Linus tree for
> other reasons but applied 3dc2a17efc5f, 1479493c91fc, 28c0074fd4b7 and
> the recent suspend fix, then your patch applies cleanly.
> 
> Here's ethtool output:
> 
> # ethtool eth1
> Settings for eth1:
>         Supported ports: [  ]
>         Supported link modes:   10000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  10000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 10000Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         master-slave status: master
>         Port: Twisted Pair
>         PHYAD: 0
>         Transceiver: internal
>         MDI-X: Unknown
>         Supports Wake-on: pumbg
>         Wake-on: d
>         Link detected: yes
> 
> The phy is identified correctly:
> 
> [ 1563.678133] Realtek SFP PHY Mode r8169-1-500:00: attached PHY driver (mii_bus:phy_addr=r8169-1-500:00, irq=MAC)
> 
> That said I've observed two issues with the current patch:
> 
> 1. the link on the other end is flapping, I've seen this while working
> on the original patch and seems to be due to the EEE settings, it is
> addressed by:
> 
> @@ -2439,7 +2439,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
> 
>  static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
>  {
> -       r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
> +       if (tp->sfp_mode)
> +               r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
> +       else
> +               r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
>  }
> 
>  static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
> 
> 
> 2. the link is lost after a module reload or after an ip link down and
> up, the driver logs "Link is Down" and stays there until the cable is
> unplugged and re-plugged. This seems to be addressed by the code that
> was in rtl8127_sds_phy_reset(), re-adding that code fixes it:
> 
> @@ -2477,6 +2480,13 @@ static void r8127_init_sfp_10g(struct rtl8169_private *tp)
>  {
>         int val;
> 
> +       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
> +       udelay(1);
> +
> +       RTL_W16(tp, 0x233a, 0x801f);
> +       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
> +       udelay(10);
> +
>         RTL_W16(tp, 0x233a, 0x801a);
>         RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x1000);
> 
> Guess the phy needs a reset after all.
> 
> With these two applied it seems to be working fine, tested suspend as
> well.
> 
> Would you integrate these two or want to try me something different?

Thanks a lot for the valuable feedback!
I added the SDS PHY reset to the patch, and improved MAC EEE handling
in a second patch, incl. what you mentioned.
Patches should fully cover your use case now. Please give it a try.

--------------s1Hirkhv4vQis9DNEIDb9pUr
Content-Type: text/plain; charset=UTF-8;
 name="0001-r8169-add-support-for-10G-SFP-mode-on-RTL8127ATF.patch"
Content-Disposition: attachment;
 filename*0="0001-r8169-add-support-for-10G-SFP-mode-on-RTL8127ATF.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZGQ3YWE4MDYxODRmMGJjOGQ4ZmViODBjYjJkZDJjNTM5N2VlMTM0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPgpEYXRlOiBTdW4sIDIzIE5vdiAyMDI1IDIyOjI5OjI1ICswMTAwClN1YmplY3Q6
IFtQQVRDSCAxLzJdIHI4MTY5OiBhZGQgc3VwcG9ydCBmb3IgMTBHIFNGUCBtb2RlIG9uIFJU
TDgxMjdBVEYKClNpZ25lZC1vZmYtYnk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBn
bWFpbC5jb20+Ci0tLQogZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWlu
LmMgfCA3NyArKysrKysrKysrKysrKysrKysrKystLQogZHJpdmVycy9uZXQvcGh5L3JlYWx0
ZWsvcmVhbHRla19tYWluLmMgICAgfCAyNiArKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5
OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVhbHRlay9yODE2OV9tYWluLmMKaW5kZXggOTdkYmU4Zjg5MzMuLmNiYWNmMWVmODdh
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4u
YworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYwpAQCAt
NzMxLDYgKzczMSw3IEBAIHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgewogCXVuc2lnbmVkIHN1
cHBvcnRzX2dtaWk6MTsKIAl1bnNpZ25lZCBhc3BtX21hbmFnZWFibGU6MTsKIAl1bnNpZ25l
ZCBkYXNoX2VuYWJsZWQ6MTsKKwlib29sIHNmcF9tb2RlOjE7CiAJZG1hX2FkZHJfdCBjb3Vu
dGVyc19waHlzX2FkZHI7CiAJc3RydWN0IHJ0bDgxNjlfY291bnRlcnMgKmNvdW50ZXJzOwog
CXN0cnVjdCBydGw4MTY5X3RjX29mZnNldHMgdGNfb2Zmc2V0OwpAQCAtMTA5NCw2ICsxMDk1
LDEwIEBAIHN0YXRpYyBpbnQgcjgxNjhfcGh5X29jcF9yZWFkKHN0cnVjdCBydGw4MTY5X3By
aXZhdGUgKnRwLCB1MzIgcmVnKQogCWlmIChydGxfb2NwX3JlZ19mYWlsdXJlKHJlZykpCiAJ
CXJldHVybiAwOwogCisJLyogUmV0dXJuIGR1bW15IE1JSV9QSFlTSUQyIGluIFNGUCBtb2Rl
IHRvIG1hdGNoIFNGUCBQSFkgZHJpdmVyICovCisJaWYgKHRwLT5zZnBfbW9kZSAmJiByZWcg
PT0gKE9DUF9TVERfUEhZX0JBU0UgKyAyICogTUlJX1BIWVNJRDIpKQorCQlyZXR1cm4gMHhj
YmZmOworCiAJUlRMX1czMih0cCwgR1BIWV9PQ1AsIHJlZyA8PCAxNSk7CiAKIAlyZXR1cm4g
cnRsX2xvb3Bfd2FpdF9oaWdoKHRwLCAmcnRsX29jcF9ncGh5X2NvbmQsIDI1LCAxMCkgPwpA
QCAtMjMwNSw2ICsyMzEwLDQxIEBAIHN0YXRpYyB2b2lkIHJ0bDgxNjlfZ2V0X2V0aF9jdHJs
X3N0YXRzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJCWxlMzJfdG9fY3B1KHRwLT5jb3Vu
dGVycy0+cnhfdW5rbm93bl9vcGNvZGUpOwogfQogCitzdGF0aWMgaW50IHJ0bDgxNjlfc2V0
X2xpbmtfa3NldHRpbmdzKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LAorCQkJCSAgICAgIGNv
bnN0IHN0cnVjdCBldGh0b29sX2xpbmtfa3NldHRpbmdzICpjbWQpCit7CisJc3RydWN0IHJ0
bDgxNjlfcHJpdmF0ZSAqdHAgPSBuZXRkZXZfcHJpdihuZGV2KTsKKwlzdHJ1Y3QgcGh5X2Rl
dmljZSAqcGh5ZGV2ID0gdHAtPnBoeWRldjsKKwlpbnQgZHVwbGV4ID0gY21kLT5iYXNlLmR1
cGxleDsKKwlpbnQgc3BlZWQgPSBjbWQtPmJhc2Uuc3BlZWQ7CisKKwlpZiAoIXRwLT5zZnBf
bW9kZSkKKwkJcmV0dXJuIHBoeV9ldGh0b29sX2tzZXR0aW5nc19zZXQocGh5ZGV2LCBjbWQp
OworCisJaWYgKGNtZC0+YmFzZS5hdXRvbmVnICE9IEFVVE9ORUdfRElTQUJMRSkKKwkJcmV0
dXJuIC1FSU5WQUw7CisKKwlpZiAoIXBoeV9jaGVja192YWxpZChzcGVlZCwgZHVwbGV4LCBw
aHlkZXYtPnN1cHBvcnRlZCkpCisJCXJldHVybiAtRUlOVkFMOworCisJbXV0ZXhfbG9jaygm
cGh5ZGV2LT5sb2NrKTsKKworCXBoeWRldi0+YXV0b25lZyA9IEFVVE9ORUdfRElTQUJMRTsK
KwlwaHlkZXYtPnNwZWVkID0gc3BlZWQ7CisJcGh5ZGV2LT5kdXBsZXggPSBkdXBsZXg7CisK
KwlpZiAocGh5X2lzX3N0YXJ0ZWQocGh5ZGV2KSkgeworCQlwaHlkZXYtPnN0YXRlID0gUEhZ
X1VQOworCQlwaHlfdHJpZ2dlcl9tYWNoaW5lKHBoeWRldik7CisJfSBlbHNlIHsKKwkJX3Bo
eV9zdGFydF9hbmVnKHBoeWRldik7CisJfQorCisJbXV0ZXhfdW5sb2NrKCZwaHlkZXYtPmxv
Y2spOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9v
cHMgcnRsODE2OV9ldGh0b29sX29wcyA9IHsKIAkuc3VwcG9ydGVkX2NvYWxlc2NlX3BhcmFt
cyA9IEVUSFRPT0xfQ09BTEVTQ0VfVVNFQ1MgfAogCQkJCSAgICAgRVRIVE9PTF9DT0FMRVND
RV9NQVhfRlJBTUVTLApAQCAtMjMyNCw3ICsyMzY0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBldGh0b29sX29wcyBydGw4MTY5X2V0aHRvb2xfb3BzID0gewogCS5nZXRfZWVlCQk9IHJ0
bDgxNjlfZ2V0X2VlZSwKIAkuc2V0X2VlZQkJPSBydGw4MTY5X3NldF9lZWUsCiAJLmdldF9s
aW5rX2tzZXR0aW5ncwk9IHBoeV9ldGh0b29sX2dldF9saW5rX2tzZXR0aW5ncywKLQkuc2V0
X2xpbmtfa3NldHRpbmdzCT0gcGh5X2V0aHRvb2xfc2V0X2xpbmtfa3NldHRpbmdzLAorCS5z
ZXRfbGlua19rc2V0dGluZ3MJPSBydGw4MTY5X3NldF9saW5rX2tzZXR0aW5ncywKIAkuZ2V0
X3JpbmdwYXJhbQkJPSBydGw4MTY5X2dldF9yaW5ncGFyYW0sCiAJLmdldF9wYXVzZV9zdGF0
cwk9IHJ0bDgxNjlfZ2V0X3BhdXNlX3N0YXRzLAogCS5nZXRfcGF1c2VwYXJhbQkJPSBydGw4
MTY5X2dldF9wYXVzZXBhcmFtLApAQCAtMjQzNiw2ICsyNDc2LDM0IEBAIHN0YXRpYyB2b2lk
IHJ0bF9zY2hlZHVsZV90YXNrKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBlbnVtIHJ0
bF9mbGFnIGZsYWcpCiAJCWNsZWFyX2JpdChmbGFnLCB0cC0+d2suZmxhZ3MpOwogfQogCitz
dGF0aWMgdm9pZCByODEyN19zZnBfc2RzX3BoeV9yZXNldChzdHJ1Y3QgcnRsODE2OV9wcml2
YXRlICp0cCkKK3sKKwlSVExfVzgodHAsIDB4MjM1MCwgUlRMX1I4KHRwLCAweDIzNTApICYg
fkJJVCgwKSk7CisJdWRlbGF5KDEpOworCisJUlRMX1cxNih0cCwgMHgyMzNhLCAweDgwMWYp
OworCVJUTF9XOCh0cCwgMHgyMzUwLCBSVExfUjgodHAsIDB4MjM1MCkgfCBCSVQoMCkpOwor
CXVkZWxheSgxMCk7Cit9CisKK3N0YXRpYyB2b2lkIHI4MTI3X3NmcF9pbml0XzEwZyhzdHJ1
Y3QgcnRsODE2OV9wcml2YXRlICp0cCkKK3sKKwlpbnQgdmFsOworCisJcjgxMjdfc2ZwX3Nk
c19waHlfcmVzZXQodHApOworCisJUlRMX1cxNih0cCwgMHgyMzNhLCAweDgwMWEpOworCVJU
TF9XMTYodHAsIDB4MjMzZSwgKFJUTF9SMTYodHAsIDB4MjMzZSkgJiB+MHgzMDAzKSB8IDB4
MTAwMCk7CisKKwlyODE2OF9waHlfb2NwX3dyaXRlKHRwLCAweGM0MGEsIDB4MDAwMCk7CisJ
cjgxNjhfcGh5X29jcF93cml0ZSh0cCwgMHhjNDY2LCAweDAwMDMpOworCXI4MTY4X3BoeV9v
Y3Bfd3JpdGUodHAsIDB4YzgwOCwgMHgwMDAwKTsKKwlyODE2OF9waHlfb2NwX3dyaXRlKHRw
LCAweGM4MGEsIDB4MDAwMCk7CisKKwl2YWwgPSByODE2OF9waHlfb2NwX3JlYWQodHAsIDB4
YzgwNCk7CisJcjgxNjhfcGh5X29jcF93cml0ZSh0cCwgMHhjODA0LCAodmFsICYgfjB4MDAw
ZikgfCAweDAwMGMpOworfQorCiBzdGF0aWMgdm9pZCBydGw4MTY5X2luaXRfcGh5KHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgKnRwKQogewogCXI4MTY5X2h3X3BoeV9jb25maWcodHAsIHRw
LT5waHlkZXYsIHRwLT5tYWNfdmVyc2lvbik7CkBAIC0yNDUyLDYgKzI1MjAsOSBAQCBzdGF0
aWMgdm9pZCBydGw4MTY5X2luaXRfcGh5KHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQog
CSAgICB0cC0+cGNpX2Rldi0+c3Vic3lzdGVtX2RldmljZSA9PSAweGUwMDApCiAJCXBoeV93
cml0ZV9wYWdlZCh0cC0+cGh5ZGV2LCAweDAwMDEsIDB4MTAsIDB4ZjAxYik7CiAKKwlpZiAo
dHAtPnNmcF9tb2RlKQorCQlyODEyN19zZnBfaW5pdF8xMGcodHApOworCiAJLyogV2UgbWF5
IGhhdmUgY2FsbGVkIHBoeV9zcGVlZF9kb3duIGJlZm9yZSAqLwogCXBoeV9zcGVlZF91cCh0
cC0+cGh5ZGV2KTsKIApAQCAtNTQ2MCwxMyArNTUzMSwxMSBAQCBzdGF0aWMgaW50IHJ0bF9p
bml0X29uZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgKmVudCkKIAl9CiAJdHAtPmFzcG1fbWFuYWdlYWJsZSA9ICFyYzsKIAotCS8qIEZpYmVy
IG1vZGUgb24gUlRMODEyN0FGIGlzbid0IHN1cHBvcnRlZCAqLwogCWlmIChydGxfaXNfODEy
NSh0cCkpIHsKIAkJdTE2IGRhdGEgPSByODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNik7
CiAKIAkJaWYgKChkYXRhICYgMHhmZikgPT0gMHgwNykKLQkJCXJldHVybiBkZXZfZXJyX3By
b2JlKCZwZGV2LT5kZXYsIC1FTk9ERVYsCi0JCQkJCSAgICAgIkZpYmVyIG1vZGUgbm90IHN1
cHBvcnRlZFxuIik7CisJCQl0cC0+c2ZwX21vZGUgPSB0cnVlOwogCX0KIAogCXRwLT5kYXNo
X3R5cGUgPSBydGxfZ2V0X2Rhc2hfdHlwZSh0cCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYyBiL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVr
L3JlYWx0ZWtfbWFpbi5jCmluZGV4IDY3ZWNmM2Q0YWYyLi4yOTY1NTlkYmM3ZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKKysrIGIvZHJp
dmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKQEAgLTE5NzcsNiArMTk3Nywx
OCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgcnRsODIyMWJfaGFuZGxlX2ludGVycnVwdChzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQogCXJldHVybiBJUlFfSEFORExFRDsKIH0KIAorc3Rh
dGljIGludCBydGxnZW5fc2ZwX2dldF9mZWF0dXJlcyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5
ZGV2KQoreworCWxpbmttb2RlX3NldF9iaXQoRVRIVE9PTF9MSU5LX01PREVfMTAwMDBiYXNl
VF9GdWxsX0JJVCwKKwkJCSBwaHlkZXYtPnN1cHBvcnRlZCk7CisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyBpbnQgcnRsZ2VuX3NmcF9jb25maWdfYW5lZyhzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2KQoreworCXJldHVybiAwOworfQorCiBzdGF0aWMgc3RydWN0IHBoeV9kcml2ZXIg
cmVhbHRla19kcnZzW10gPSB7CiAJewogCQlQSFlfSURfTUFUQ0hfRVhBQ1QoMHgwMDAwODIw
MSksCkBAIC0yMjEyLDYgKzIyMjQsMjAgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIHJl
YWx0ZWtfZHJ2c1tdID0gewogCQkud3JpdGVfcGFnZSAgICAgPSBydGw4MjF4X3dyaXRlX3Bh
Z2UsCiAJCS5yZWFkX21tZAk9IHJ0bDgyMnhfcmVhZF9tbWQsCiAJCS53cml0ZV9tbWQJPSBy
dGw4MjJ4X3dyaXRlX21tZCwKKwl9LCB7CisJCVBIWV9JRF9NQVRDSF9FWEFDVCgweDAwMWNj
YmZmKSwKKwkJLm5hbWUgICAgICAgICAgID0gIlJlYWx0ZWsgU0ZQIFBIWSBNb2RlIiwKKwkJ
LmZsYWdzCQk9IFBIWV9JU19JTlRFUk5BTCwKKwkJLnByb2JlCQk9IHJ0bDgyMnhfcHJvYmUs
CisJCS5nZXRfZmVhdHVyZXMgICA9IHJ0bGdlbl9zZnBfZ2V0X2ZlYXR1cmVzLAorCQkuY29u
ZmlnX2FuZWcgICAgPSBydGxnZW5fc2ZwX2NvbmZpZ19hbmVnLAorCQkucmVhZF9zdGF0dXMg
ICAgPSBydGw4MjJ4X3JlYWRfc3RhdHVzLAorCQkuc3VzcGVuZCAgICAgICAgPSBnZW5waHlf
c3VzcGVuZCwKKwkJLnJlc3VtZSAgICAgICAgID0gcnRsZ2VuX3Jlc3VtZSwKKwkJLnJlYWRf
cGFnZSAgICAgID0gcnRsODIxeF9yZWFkX3BhZ2UsCisJCS53cml0ZV9wYWdlICAgICA9IHJ0
bDgyMXhfd3JpdGVfcGFnZSwKKwkJLnJlYWRfbW1kCT0gcnRsODIyeF9yZWFkX21tZCwKKwkJ
LndyaXRlX21tZAk9IHJ0bDgyMnhfd3JpdGVfbW1kLAogCX0sIHsKIAkJUEhZX0lEX01BVENI
X0VYQUNUKDB4MDAxY2NhZDApLAogCQkubmFtZQkJPSAiUlRMODIyNCAyLjVHYnBzIFBIWSIs
Ci0tIAoyLjUyLjAKCg==
--------------s1Hirkhv4vQis9DNEIDb9pUr
Content-Type: text/plain; charset=UTF-8;
 name="0002-r8169-improve-MAC-EEE-handling.patch"
Content-Disposition: attachment;
 filename="0002-r8169-improve-MAC-EEE-handling.patch"
Content-Transfer-Encoding: base64

RnJvbSA5ZGU2ZWU3MjI1MTI5NDZmOWQwOTBiZDY1MDcwYTA1ZGM2NmUxMjE0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPgpEYXRlOiBTdW4sIDIzIE5vdiAyMDI1IDIzOjM5OjQzICswMTAwClN1YmplY3Q6
IFtQQVRDSCAyLzJdIHI4MTY5OiBpbXByb3ZlIE1BQyBFRUUgaGFuZGxpbmcKClNpZ25lZC1v
ZmYtYnk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+Ci0tLQogZHJp
dmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMgfCA3MyArKysrKysrKysr
Ky0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDM3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsv
cjgxNjlfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWlu
LmMKaW5kZXggY2JhY2YxZWY4N2EuLjMzYTgzYmY5MDM1IDEwMDY0NAotLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYworKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYwpAQCAtMjQyNSwyNiArMjQyNSw2IEBAIHZv
aWQgcjgxNjlfYXBwbHlfZmlybXdhcmUoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApCiAJ
fQogfQogCi1zdGF0aWMgdm9pZCBydGw4MTY4X2NvbmZpZ19lZWVfbWFjKHN0cnVjdCBydGw4
MTY5X3ByaXZhdGUgKnRwKQotewotCS8qIEFkanVzdCBFRUUgTEVEIGZyZXF1ZW5jeSAqLwot
CWlmICh0cC0+bWFjX3ZlcnNpb24gIT0gUlRMX0dJR0FfTUFDX1ZFUl8zOCkKLQkJUlRMX1c4
KHRwLCBFRUVfTEVELCBSVExfUjgodHAsIEVFRV9MRUQpICYgfjB4MDcpOwotCi0JcnRsX2Vy
aV9zZXRfYml0cyh0cCwgMHgxYjAsIDB4MDAwMyk7Ci19Ci0KLXN0YXRpYyB2b2lkIHJ0bDgx
MjVhX2NvbmZpZ19lZWVfbWFjKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQotewotCXI4
MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGUwNDAsIDAsIEJJVCgxKSB8IEJJVCgwKSk7Ci0J
cjgxNjhfbWFjX29jcF9tb2RpZnkodHAsIDB4ZWI2MiwgMCwgQklUKDIpIHwgQklUKDEpKTsK
LX0KLQotc3RhdGljIHZvaWQgcnRsODEyNWJfY29uZmlnX2VlZV9tYWMoc3RydWN0IHJ0bDgx
NjlfcHJpdmF0ZSAqdHApCi17Ci0JcjgxNjhfbWFjX29jcF9tb2RpZnkodHAsIDB4ZTA0MCwg
MCwgQklUKDEpIHwgQklUKDApKTsKLX0KLQogc3RhdGljIHZvaWQgcnRsX3Jhcl9leGdtYWNf
c2V0KHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBjb25zdCB1OCAqYWRkcikKIHsKIAly
dGxfZXJpX3dyaXRlKHRwLCAweGUwLCBFUklBUl9NQVNLXzExMTEsIGdldF91bmFsaWduZWRf
bGUzMihhZGRyKSk7CkBAIC0zMjUzLDggKzMyMzMsNiBAQCBzdGF0aWMgdm9pZCBydGxfaHdf
c3RhcnRfODE2OGVfMihzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCkKIAogCVJUTF9XOCh0
cCwgTUNVLCBSVExfUjgodHAsIE1DVSkgJiB+Tk9XX0lTX09PQik7CiAKLQlydGw4MTY4X2Nv
bmZpZ19lZWVfbWFjKHRwKTsKLQogCVJUTF9XOCh0cCwgRExMUFIsIFJUTF9SOCh0cCwgRExM
UFIpIHwgUEZNX0VOKTsKIAlSVExfVzMyKHRwLCBNSVNDLCBSVExfUjMyKHRwLCBNSVNDKSB8
IFBXTV9FTik7CiAJcnRsX21vZF9jb25maWc1KHRwLCBTcGlfZW4sIDApOwpAQCAtMzI3OSw4
ICszMjU3LDYgQEAgc3RhdGljIHZvaWQgcnRsX2h3X3N0YXJ0XzgxNjhmKHN0cnVjdCBydGw4
MTY5X3ByaXZhdGUgKnRwKQogCVJUTF9XOCh0cCwgRExMUFIsIFJUTF9SOCh0cCwgRExMUFIp
IHwgUEZNX0VOKTsKIAlSVExfVzMyKHRwLCBNSVNDLCBSVExfUjMyKHRwLCBNSVNDKSB8IFBX
TV9FTik7CiAJcnRsX21vZF9jb25maWc1KHRwLCBTcGlfZW4sIDApOwotCi0JcnRsODE2OF9j
b25maWdfZWVlX21hYyh0cCk7CiB9CiAKIHN0YXRpYyB2b2lkIHJ0bF9od19zdGFydF84MTY4
Zl8xKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQpAQCAtMzMzMCw4ICszMzA2LDYgQEAg
c3RhdGljIHZvaWQgcnRsX2h3X3N0YXJ0XzgxNjhnKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUg
KnRwKQogCXJ0bF9lcmlfd3JpdGUodHAsIDB4YzAsIEVSSUFSX01BU0tfMDAxMSwgMHgwMDAw
KTsKIAlydGxfZXJpX3dyaXRlKHRwLCAweGI4LCBFUklBUl9NQVNLXzAwMTEsIDB4MDAwMCk7
CiAKLQlydGw4MTY4X2NvbmZpZ19lZWVfbWFjKHRwKTsKLQogCXJ0bF93MHcxX2VyaSh0cCwg
MHgyZmMsIDB4MDEsIDB4MDYpOwogCXJ0bF9lcmlfY2xlYXJfYml0cyh0cCwgMHgxYjAsIEJJ
VCgxMikpOwogCkBAIC0zNDcyLDggKzM0NDYsNiBAQCBzdGF0aWMgdm9pZCBydGxfaHdfc3Rh
cnRfODE2OGhfMShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCkKIAlydGxfZXJpX3dyaXRl
KHRwLCAweGMwLCBFUklBUl9NQVNLXzAwMTEsIDB4MDAwMCk7CiAJcnRsX2VyaV93cml0ZSh0
cCwgMHhiOCwgRVJJQVJfTUFTS18wMDExLCAweDAwMDApOwogCi0JcnRsODE2OF9jb25maWdf
ZWVlX21hYyh0cCk7Ci0KIAlSVExfVzgodHAsIERMTFBSLCBSVExfUjgodHAsIERMTFBSKSAm
IH5QRk1fRU4pOwogCVJUTF9XOCh0cCwgTUlTQ18xLCBSVExfUjgodHAsIE1JU0NfMSkgJiB+
UEZNX0QzQ09MRF9FTik7CiAKQEAgLTM1MjEsOCArMzQ5Myw2IEBAIHN0YXRpYyB2b2lkIHJ0
bF9od19zdGFydF84MTY4ZXAoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApCiAJcnRsX2Vy
aV93cml0ZSh0cCwgMHhjMCwgRVJJQVJfTUFTS18wMDExLCAweDAwMDApOwogCXJ0bF9lcmlf
d3JpdGUodHAsIDB4YjgsIEVSSUFSX01BU0tfMDAxMSwgMHgwMDAwKTsKIAotCXJ0bDgxNjhf
Y29uZmlnX2VlZV9tYWModHApOwotCiAJcnRsX3cwdzFfZXJpKHRwLCAweDJmYywgMHgwMSwg
MHgwNik7CiAKIAlSVExfVzgodHAsIERMTFBSLCBSVExfUjgodHAsIERMTFBSKSAmIH5UWF8x
ME1fUFNfRU4pOwpAQCAtMzU3OCw4ICszNTQ4LDYgQEAgc3RhdGljIHZvaWQgcnRsX2h3X3N0
YXJ0XzgxMTcoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApCiAJcnRsX2VyaV93cml0ZSh0
cCwgMHhjMCwgRVJJQVJfTUFTS18wMDExLCAweDAwMDApOwogCXJ0bF9lcmlfd3JpdGUodHAs
IDB4YjgsIEVSSUFSX01BU0tfMDAxMSwgMHgwMDAwKTsKIAotCXJ0bDgxNjhfY29uZmlnX2Vl
ZV9tYWModHApOwotCiAJUlRMX1c4KHRwLCBETExQUiwgUlRMX1I4KHRwLCBETExQUikgJiB+
UEZNX0VOKTsKIAlSVExfVzgodHAsIE1JU0NfMSwgUlRMX1I4KHRwLCBNSVNDXzEpICYgflBG
TV9EM0NPTERfRU4pOwogCkBAIC0zODIwLDExICszNzg4LDYgQEAgc3RhdGljIHZvaWQgcnRs
X2h3X3N0YXJ0XzgxMjVfY29tbW9uKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQogCiAJ
cnRsX2xvb3Bfd2FpdF9sb3codHAsICZydGxfbWFjX29jcF9lMDBlX2NvbmQsIDEwMDAsIDEw
KTsKIAotCWlmICh0cC0+bWFjX3ZlcnNpb24gPT0gUlRMX0dJR0FfTUFDX1ZFUl82MSkKLQkJ
cnRsODEyNWFfY29uZmlnX2VlZV9tYWModHApOwotCWVsc2UKLQkJcnRsODEyNWJfY29uZmln
X2VlZV9tYWModHApOwotCiAJcnRsX2Rpc2FibGVfcnhkdmdhdGUodHApOwogfQogCkBAIC00
ODI3LDYgKzQ3OTAsNDEgQEAgc3RhdGljIGludCBydGw4MTY5X3BvbGwoc3RydWN0IG5hcGlf
c3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQogCXJldHVybiB3b3JrX2RvbmU7CiB9CiAKK3N0
YXRpYyB2b2lkIHJ0bF9lbmFibGVfdHhfbHBpKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRw
LCBib29sIGVuYWJsZSkKK3sKKwlpZiAoIXJ0bF9zdXBwb3J0c19lZWUodHApKQorCQlyZXR1
cm47CisKKwlzd2l0Y2ggKHRwLT5tYWNfdmVyc2lvbikgeworCWNhc2UgUlRMX0dJR0FfTUFD
X1ZFUl8zNCAuLi4gUlRMX0dJR0FfTUFDX1ZFUl81MjoKKwkJLyogQWRqdXN0IEVFRSBMRUQg
ZnJlcXVlbmN5ICovCisJCWlmICh0cC0+bWFjX3ZlcnNpb24gIT0gUlRMX0dJR0FfTUFDX1ZF
Ul8zOCkKKwkJCVJUTF9XOCh0cCwgRUVFX0xFRCwgUlRMX1I4KHRwLCBFRUVfTEVEKSAmIH4w
eDA3KTsKKwkJaWYgKGVuYWJsZSkKKwkJCXJ0bF9lcmlfc2V0X2JpdHModHAsIDB4MWIwLCAw
eDAwMDMpOworCQllbHNlCisJCQlydGxfZXJpX2NsZWFyX2JpdHModHAsIDB4MWIwLCAweDAw
MDMpOworCQlicmVhazsKKwljYXNlIFJUTF9HSUdBX01BQ19WRVJfNjE6CisJCWlmIChlbmFi
bGUpIHsKKwkJCXI4MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGUwNDAsIDAsIDB4MDAwMyk7
CisJCQlyODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhlYjYyLCAwLCAweDAwMDYpOworCQl9
IGVsc2UgeworCQkJcjgxNjhfbWFjX29jcF9tb2RpZnkodHAsIDB4ZTA0MCwgMHgwMDAzLCAw
KTsKKwkJCXI4MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGViNjIsIDB4MDAwNiwgMCk7CisJ
CX0KKwkJYnJlYWs7CisJY2FzZSBSVExfR0lHQV9NQUNfVkVSXzYzIC4uLiBSVExfR0lHQV9N
QUNfVkVSX0xBU1Q6CisJCWlmIChlbmFibGUpCisJCQlyODE2OF9tYWNfb2NwX21vZGlmeSh0
cCwgMHhlMDQwLCAwLCAweDAwMDMpOworCQllbHNlCisJCQlyODE2OF9tYWNfb2NwX21vZGlm
eSh0cCwgMHhlMDQwLCAweDAwMDMsIDApOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlicmVh
azsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIHI4MTY5X3BoeWxpbmtfaGFuZGxlcihzdHJ1Y3Qg
bmV0X2RldmljZSAqbmRldikKIHsKIAlzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCA9IG5l
dGRldl9wcml2KG5kZXYpOwpAQCAtNDgzNCw2ICs0ODMyLDcgQEAgc3RhdGljIHZvaWQgcjgx
NjlfcGh5bGlua19oYW5kbGVyKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQogCiAJaWYgKG5l
dGlmX2NhcnJpZXJfb2sobmRldikpIHsKIAkJcnRsX2xpbmtfY2hnX3BhdGNoKHRwKTsKKwkJ
cnRsX2VuYWJsZV90eF9scGkodHAsIHRwLT5waHlkZXYtPmVuYWJsZV90eF9scGkpOwogCQlw
bV9yZXF1ZXN0X3Jlc3VtZShkKTsKIAl9IGVsc2UgewogCQlwbV9ydW50aW1lX2lkbGUoZCk7
Ci0tIAoyLjUyLjAKCg==

--------------s1Hirkhv4vQis9DNEIDb9pUr--

