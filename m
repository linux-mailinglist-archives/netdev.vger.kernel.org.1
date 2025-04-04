Return-Path: <netdev+bounces-179245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAEA7B87A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48520189AEEE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5255218DB17;
	Fri,  4 Apr 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgiH7w5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D0847B;
	Fri,  4 Apr 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753570; cv=none; b=Ln205S/g1TjSNcF1Be8kp5T9gh8lLHTm7h3V+oSX38yErf5H/L/Kh5y+eOVlg5Tdbtt8XigNmT1vliFxPSlvS/XOLOrziNMjarGcTm9RzPqmhI2JNqU34RtAMH7GzOv5dS8CoN4eCBFDXKSq0cwz2RcH8KcB8t66KKRfCYwzXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753570; c=relaxed/simple;
	bh=yGuboUMthTnrSr0YxktMqa6s6aGvoefMlWmXmxJDGv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGNMr2T0ce5qhu6Op4wbSq9ZZ48BoVzHS9f6G8xu8/sE1GJ7JAAxdttcogIf2VQ8V2KGb/APDWckKN0E1mKwpjKwdSNaLttdmVvnXXXW2iPTmNiNOrb3GJ/6ErwgtGmGbowFV80Psxv6X7sLhpFhDFqjtQZkaMDIM2DUZJUxzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgiH7w5M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso17662645e9.3;
        Fri, 04 Apr 2025 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743753567; x=1744358367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nr/t6BskpDZsQWS/KHvw+5O1AbfwUb+OCjtyeJ/2soE=;
        b=SgiH7w5Mwr+vdwLUbnj/5FLxf74iYcd1fuewmzSepSEI2hqlG1E97LYz4WGrZCTIXY
         RCX4eFNUPeZRv5zsYfYgmTaNJ9f5kittGDS3gTM87rO4++us/XGrvBnUbvqm/JKl5MH3
         BMB46wsCFnyQN7cXLLMQ2fcrHa1f7xPhjzd6MGursIoPb9jNOgrjzCxgjkral6Y49Qi/
         K30UIOc+WdKSZrBEtvPVsHanmErbwbQ2jQ/sjS2uAP6m2EZ8LI56o6cMn6fDXHRC5PXf
         JPiX1jVZ8IHnidUtu3z1XWc9AyfE3HWm3xJ925yAmtNyv65EVPistwZivMxoF2U39oXw
         uMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743753567; x=1744358367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr/t6BskpDZsQWS/KHvw+5O1AbfwUb+OCjtyeJ/2soE=;
        b=MZuMuGumipFs8viR229bDhNW3dmAKZA4U8aqljSYKKzz7m0j9hhStCG7YUD+miYytP
         BgrdB4On5UbfMcKROIbFaW8GZu3JPlrv1eyeO0u0TX7berA4a4oDGdaTPTQB28j4rmf9
         CHw7SqxKAJUebIV87U2T4UwwjHMPBGmicZ/bFKkU932pjfHg+AhuIefy1+RDRjs2VibL
         G3Kd7Xg3MMblKko1pyvLFe479Q/a0D082guo+6QtzCTK7Bx5mk2HbvdkB9IhbaG4dDW9
         h5b6GxVr3B40OCqFcKn395rEL9ZtZ93/mzMADOkiRZdTlAGtgTPXtziEYhMFfoAvOmfw
         cNkA==
X-Forwarded-Encrypted: i=1; AJvYcCVAaiEs5HTYz2RNnxmFjfvW+dAkugQKxnI6Pd3EChqm+dRhrvIJiDDgmddI8AfIEaLEj7gRZdaB@vger.kernel.org, AJvYcCXAwyn4eAh+DNOPyZGisnC4qYLzeY6DWyGs4bB7fZV9jFW4TWdI6sHMHRATHBJ7Aa5XufoklY78+i3MRBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HxC9wZG8wiac/Tt/1MHDX45GMxluK+ebnjkl1P308TVN4vLD
	gxcO8mbzT9tnvarQDDTapAgbv3irXnu7s8zTb+dScc8qZh9AxT5T
X-Gm-Gg: ASbGncvUcT6Vg1ke8rJhC+y/pcvewfq0CiSkhX+2H92QDJvjAy6nDP7vObFOymEdTZa
	L+YPSg4el46zRkGJ4ab4FxO+sW+x/u6b92pOHaKHnQfl8da8jbxQpaGWw/Jxzqx4khlWnDooITW
	tGOmHGE8/JekAJbtOUJUxWaRovQ0R7SiCKQq7FIEWvuO3ibush3fy/IPcKRIPy9lpeXCtsR3nRQ
	9gIGxGbLcIfib1fPIGKy6C50U8FQ5IlP7re+BcmGO4ANH6wOMJb7x11HYo4pYOIvucqDbD79vmv
	UfFecgKUpmteblRCkLlKEVxD3nlW5zJd4ehQkAOl0g/rxhO8NngzkYGX
X-Google-Smtp-Source: AGHT+IGy0FnVsV73jUujcayMrD7rYIs9G/cxOlRjUi4l53/BlPFVn3dQEG1Vf4RXOkfRc3KVHv1q4g==
X-Received: by 2002:a05:6000:2902:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-39d0de67b6dmr1352589f8f.42.1743753566484;
        Fri, 04 Apr 2025 00:59:26 -0700 (PDT)
Received: from ?IPv6:2a01:50a0:aa10:1a36::11d? ([2a01:50a0:aa:0:185:40:248:10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794e94sm42791465e9.31.2025.04.04.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 00:59:26 -0700 (PDT)
Message-ID: <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Torsten Krah <krah.tm@gmail.com>
To: virtualization@lists.linux-foundation.org
Cc: Markus Fohrer <markus.fohrer@webked.de>, mst@redhat.com, 
	jasowang@redhat.com, davem@davemloft.net, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Apr 2025 09:59:19 +0200
In-Reply-To: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Mittwoch, dem 02.04.2025 um 23:12 +0200 schrieb Markus Fohrer:
> When running on a host system equipped with a Broadcom NetXtreme-E
> (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the guest
> drops to 100=E2=80=93200 KB/s. The same guest configuration performs norm=
ally
> (~100 MB/s) when using kernel 6.8.0 or when the VM is moved to a host
> with Intel NICs.

Hi,

as I am affected too, here is the link to the Ubuntu issue, just in
case someone wants to have a look:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2098961

We're seeing lots of those in dmesg output:

[  561.505323] net_ratelimit: 1396 callbacks suppressed
[  561.505339] ens18: bad gso: type: 4, size: 1448
[  561.505343] ens18: bad gso: type: 4, size: 1448
[  561.507270] ens18: bad gso: type: 4, size: 1448
[  561.508257] ens18: bad gso: type: 4, size: 1448
[  561.511432] ens18: bad gso: type: 4, size: 1448
[  561.511452] ens18: bad gso: type: 4, size: 1448
[  561.514719] ens18: bad gso: type: 4, size: 1448
[  561.514966] ens18: bad gso: type: 4, size: 1448
[  561.518553] ens18: bad gso: type: 4, size: 1448
[  561.518781] ens18: bad gso: type: 4, size: 1448
[  566.506044] net_ratelimit: 1363 callbacks suppressed


And another interesting thing we observed - at least in our environment
- that we can trigger that regression only with IPv4 traffic (bad
performance and lots of bad gso messages) - if we only use IPv6, it
does work (good performance and not one bad gso message).

kind regards

Torsten


