Return-Path: <netdev+bounces-156022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20696A04AE1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15660166E8A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE41F755E;
	Tue,  7 Jan 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="mOEKgCHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F21F7081
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281160; cv=none; b=IaN2QF3QR0f+0MTZ9j9vCBSXrLv5mmSDGXIMonF01L1kmS+Qup+P8Frf++Ydvz3YXHp3E9DNcDHRHRNW0G+XOGwHQpQQNN9WSn3OcgDNY6Y8CEmPkgoWZm2suHPLW3gtF6V0YD78WGNlE6G/X7cgbl1thgsqv1z2MkCovfeFHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281160; c=relaxed/simple;
	bh=mnIduovjk4ZeXNSMbqsHEPiXih4u9LOJP0xl/aMzljQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC7+kUi9NsfJ8bI+ruDO0Pv7U4VSgOtFlGcpUgWl6ZZNVUNSIpdzNsZGcnpwENk1B8ngs868ZRpthC9aWX3+1zxk2FtUAG9p22Nq/vlbGZlPii/m/VnpjqIsrQ7P92DHuHXt8hcmfAclJrCoRJ94vEGMtPYEyLy1kvAzMGUviZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=mOEKgCHt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21634338cfdso20483845ad.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1736281155; x=1736885955; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRQriJLZjFTTEtwiNoQuJ/k3ZU8Wdh3DPUOyQok7IvU=;
        b=mOEKgCHt/J1L9reCLFQ0U+8eqR/Q71tyTLyzj6DWcI5nBu3ef+MT8Y8I1a4vMFr3xd
         MLdRGRKY4/Cyrs+ctjh0lJG98PxZZyp7i1CDHspZWXt4BWcNn6yaETlWvN90jT+39fou
         QijVc3tNPdh0FpmSENPWfCvysw5lRRc9TwBir44nvVUlWeXSFzSEkQgqYhiDj9NAWISR
         kjaphGG82fnwR6BTuS/n1GFS0FCh2xdKIWfZpr40ok1KtH/Y9GcT/jhxCszVdpRn7u1o
         IU3HrSYhqy+XCcYQqNtOWdq7X6h5JNIZOuZnw4KW/jiTwqmLO1CdiGSOFD/kpCdeWDw4
         arVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281155; x=1736885955;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRQriJLZjFTTEtwiNoQuJ/k3ZU8Wdh3DPUOyQok7IvU=;
        b=Vo72P3IY5UPHRU5uF5qPaloXIEyGR7XWdYuO4Gl4ASWsEukAriUYIst9QXOm5GguWi
         fb8vq3xUn9gCN6UmjZzhDbHPBVfajr95upnpxDOWwO5J7nZA/R7IB852mEgvG4ZIhS2z
         Ac/W9B1XkNHqB9qVhQR7ptqP11AvnjVdy8hL6mL7MqUs87RLgUsXT9EAzCnAvG3l6oCg
         BfP4T1MDhNpvQdgGSAYNVVNB4MwvsRZAPFttXLjWyPrRIW0yBhtlDGi6Z3UXP8UWUtYA
         L4xsABryCoghJCyDdKCGiVcz8T9IUSNFq1mVMHZtVWilb1V+uVREe4hp+P8TH+Q3D8qF
         8vFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/SSVg7h61PMtVG6umiO5voKDuhDr3w+nSrTSv922KTFkK30UpoRTqaAk0BWhhBFsdWkL7N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9slo2FAL843Xh+VujUtMJyTPD8zaiL0vGt9SBqXSYvcIBIPa
	cbc+3uVxy7HIpW9sA0PcGZE98eJ8aFqWEIexjwEv9+yBGybA1zjSf/1XD49OON8=
X-Gm-Gg: ASbGncuXPELOBlADrcbPaQqaYnuGyMp9fLJwNPDYeioJweX9oNhC0EIjS0URQKUxZTb
	L+s0uO5QYWt+r2/F6NIAemt1LHE7jxob6rd+YnrywxuQu+zj8i9tAtMsHqsQXrHSlbsbYFi+dzo
	W0LMzPLE4fAvlt+RX4L2RcaSoCiSW6Ne+cbhlZm2lO11kVHltXu0DSpuQc3wcS4AbZmmdI5Olza
	tTUKSNmEhM+67JVa7FWP2N8rvqBtJUZ/VmkIaavw9RBHv7hcsO1aBVjpg8em6E8Bd/T
X-Google-Smtp-Source: AGHT+IGOYgUTUN3yERTuzrMDjitsm/6ZgYUze4hkaWMI8oXcs78IucQwdZz/57+VjW4FX9oqhcVrsQ==
X-Received: by 2002:a17:902:ebc6:b0:217:8557:5246 with SMTP id d9443c01a7336-21a840030ddmr4767365ad.55.1736281155317;
        Tue, 07 Jan 2025 12:19:15 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:efc3:bbb3:b5f:51a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964a8bsm313404725ad.8.2025.01.07.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:19:14 -0800 (PST)
Date: Wed, 08 Jan 2025 04:19:05 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re:Re: [PATCH net-next v4] wwan dev: Add port for NMEA channel for
 WWAN devices
To: Slark Xiao <slark_xiao@163.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <T3JQPS.DLBZIVAM0L9Q2@unrealasia.net>
In-Reply-To: <3c7d38cb.5336.1943f5e66de.Coremail.slark_xiao@163.com>
References: <20250105124819.6950-1-zaihan@unrealasia.net>
	<CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
	<3c7d38cb.5336.1943f5e66de.Coremail.slark_xiao@163.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-R071HAPMSzOXD91HCltm"

--=-R071HAPMSzOXD91HCltm
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Everyone, Sorry for the last (HTML) email.

Seemed i forgot Gmail sends HTML email by default and Geary client was 
broken.

Slark - I've got some vague idea on how it can be implemented with GNSS
according to your helpful last email which helps clear some things.

But the patch i'm giving does not work. (NULL deference err,
possibly due to gdev being NULL).

Just sharing on some progress i've made.

I'm still looking at it and trying to figure out though.



On Tue, Jan 7 2025 at 02:05:38 PM +0800, Slark Xiao 
<slark_xiao@163.com> wrote:
> 
> At 2025-01-07 03:44:35, "Loic Poulain" <loic.poulain@linaro.org> 
> wrote:
>> Hi Muhammad,
>> 
>> + Slark
>> 
>> On Sun, 5 Jan 2025 at 13:53, Muhammad Nuzaihan 
>> <zaihan@unrealasia.net> wrote:
>>> 
>>>  Based on the code: drivers/bus/mhi/host/pci_generic.c
>>>  which already has NMEA channel (mhi_quectel_em1xx_channels)
>>>  support in recent kernels but it is never exposed
>>>  as a port.
>>> 
>>>  This commit exposes that NMEA channel to a port
>>>  to allow tty/gpsd programs to read through
>>>  the /dev/wwan0nmea0 port.
>>> 
>>>  Tested this change on a new kernel and module
>>>  built and now NMEA (mhi0_NMEA) statements are
>>>  available (attached) through /dev/wwan0nmea0 port on bootup.
>>> 
>>>  Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>>> <zaihan@unrealasia.net>
>> 
>> This works for sure but I'm not entirely convinced NMEA should be
>> exposed as a modem control port. In your previous patch version 
>> Sergey
>> pointed to a discussion we had regarding exposing that port as WWAN
>> child device through the regular GNSS subsystem, which would require
>> some generic bridge in the WWAN subsystem.
>> 
>> Slark, did you have an opportunity to look at the GNSS solution?
>> 
>> Regards,
>> Loic
> 
> Hi Loic,
> This solution same as what I did in last time. We got a wwan0nmea0 
> device but this
> device can't support flow control.
> Also, this is not the solution what Sergey expected, I think.
> Please refer to the target we talked last time:
> /////////////////////
>>>>  Basically, components should interact like this:
>>>> 
>>>>  Modem PCIe driver <-> WWAN core <-> GNSS core <-> /dev/gnss0
>>>> 
>>>>  We need the GNSS core to export the modem NMEA port as instance of
>>>>  'gnss' class.
>>>> 
>>>>  We need WWAN core between the modem driver and the GSNN core 
>>>> because we
>>>>  need a common parent for GNSS port and modem control port (e.g. 
>>>> AT,
>>>>  MBIM). Since we are already exporting control ports via the WWAN
>>>>  subsystem, the GNSS port should also be exported through the WWAN
>>>>  subsystem. To keep devices hierarchy like this:
>>>> 
>>>>                         .--> AT port
>>>>  PCIe dev -> WWAN dev -|
>>>>                         '--> GNSS port
>>>> 
>>>>  Back to the implementation. Probably we should introduce a new 
>>>> port
>>>>  type, e.g. WWAN_PORT_NMEA. And this port type should have a 
>>>> special
>>>>  handling in the WWAN core.
>>>> 
>>>  Similar like what I did in my local. I named it as WWAN_PORT_GNSS 
>>> and
>>>  put it as same level with AT port.
>>> 
>>>>  wwan_create_port() function should not directly create a char 
>>>> device.
>>>>  Instead, it should call gnss_allocate_device() and
>>>>  gnss_register_device() to register the port with GNSS subsystem.
> ////////////////////
> 
> Thanks
> 


--=-R071HAPMSzOXD91HCltm
Content-Type: text/x-patch
Content-Disposition: attachment; filename=expose-nmea-to-gnss.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMgYi9kcml2ZXJzL25ldC93
d2FuL3d3YW5fY29yZS5jCmluZGV4IGViZjU3NGYyYjEyNi4uYWJkNzZlZjA5N2JjIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4v
d3dhbl9jb3JlLmMKQEAgLTYsNiArNiw3IEBACiAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4KICNp
bmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+CiAjaW5jbHVkZSA8bGludXgvZnMuaD4KKyNpbmNsdWRl
IDxsaW51eC9nbnNzLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4
L2lkci5oPgogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgpAQCAtMzQyLDEwICszNDMsNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHsKIAkJLm5hbWUgPSAiTUlQQyIsCiAJCS5kZXZzdWYgPSAibWlw
YyIsCiAJfSwKLQlbV1dBTl9QT1JUX05NRUFdID0gewotCQkubmFtZSA9ICJOTUVBIiwKLQkJLmRl
dnN1ZiA9ICJubWVhIiwKLQl9LAogfTsKIAogc3RhdGljIHNzaXplX3QgdHlwZV9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCkBAIC00NjAsNiAr
NDU3LDE0IEBAIHN0cnVjdCB3d2FuX3BvcnQgKnd3YW5fY3JlYXRlX3BvcnQoc3RydWN0IGRldmlj
ZSAqcGFyZW50LAogCWlmICh0eXBlID4gV1dBTl9QT1JUX01BWCB8fCAhb3BzKQogCQlyZXR1cm4g
RVJSX1BUUigtRUlOVkFMKTsKIAorICAgICAgICAvKiBOTUVBIGNoZWNrIHRvIGF0dGFjaCBHTlNT
IHBvcnQgKi8KKyAgICAgICAgaWYgKHR5cGUgPT0gV1dBTl9QT1JUX05NRUEpIHsKKyAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZ25zc19kZXZpY2UgKmdkZXYgPSBnbnNzX2FsbG9jYXRlX2RldmljZShw
YXJlbnQpOworCisgICAgICAgICAgICAgICAgaWYgKGdkZXYpCisgICAgICAgICAgICAgICAgICAg
ICAgICBnbnNzX3JlZ2lzdGVyX2RldmljZShnZGV2KTsKKyAgICAgICAgfQorCiAJLyogQSBwb3J0
IGlzIGFsd2F5cyBhIGNoaWxkIG9mIGEgV1dBTiBkZXZpY2UsIHJldHJpZXZlIChhbGxvY2F0ZSBv
cgogCSAqIHBpY2spIHRoZSBXV0FOIGRldmljZSBiYXNlZCBvbiB0aGUgcHJvdmlkZWQgcGFyZW50
IGRldmljZS4KIAkgKi8K

--=-R071HAPMSzOXD91HCltm--


