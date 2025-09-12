Return-Path: <netdev+bounces-222733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BECB55832
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764B67B7160
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98543375A9;
	Fri, 12 Sep 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfYhH89O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461A32F77D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711596; cv=none; b=D0iLMMUeS4uquL7d2R0I1QAjNRFg5jE6Mpktff//yZzkIf+UQy87268/nii9WE/PwqUXbUL5JCP5X8JoaCM0dtkYVCNSVcGdsk3bJq5DVyMLLEsjH7HywmwaRbI8rGwkjD8KHBkndad1a7TMYAwhoJ1IIXaTl19S1boHi4+IbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711596; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfMTKtoQoRzbI9iAWDitA1V1QITu3t9NEib2Sbh81eR1iRIWM6cvmwuWUXMdD7XpCpC1GkV/1Sn68VprBmsNNXF3s9T3uaUc95JeQcNVrmOj4N9CpRiPOhL+lffiwOuBHppa9iDMTaqfqoDlBWLKJ9WSydSTgPeSHbAAJR/jsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfYhH89O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=NfYhH89OCJJ9xV3YK+X0hGStcpwCW6dgEx1kbuEcNjmMn5RA/OA7mGH8ML5bCINl2kfysG
	Lk4h4sXEg3CO36ZiT3Tgw/m8GHKWbNU/OVyoCj3XD2EH0wDn7i7M3gyYzfInuL1rgLFwo9
	YhK01U54ABsgadSsPFOnWArTY1bAsfI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-VL_VQpZeNFm8kIeSbinR7A-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: VL_VQpZeNFm8kIeSbinR7A-1
X-Mimecast-MFC-AGG-ID: VL_VQpZeNFm8kIeSbinR7A_1757711592
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b49666c8b8so50579531cf.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=ekGR/slL+jnT3ebq86x0hBr5yxs745Nlb3izHpd6iAu0Ty10kpNo0XgwqqU+TzqiAr
         +rgiDDTEDn9O+wvPWJIpSQNPHJVixwPLgGevSTCw0UtutFR1lZVKgqUkTeRSZEaptbW8
         AbiBaUoihTgDyZ3sYAUF/PxmEr7JcFf5cUXK/dVUONl2YJbz2OE3MSS28bCSYZ1Bki0W
         QgDAw78M4mjlDJT6hP28ZOcGCXiyTNhd511K/+fjubj1ZkNhDzK5sNPDq5LCqwNmRZXd
         gkwI7Y8Bb+BLZ5yp/TufFFeRx6By3eV45DPJHEzrGrd4oHA87OxiKI0yjCxWeixkD7s5
         UW2g==
X-Forwarded-Encrypted: i=1; AJvYcCXmhl9eSz+grgV9Y41ysbo63HWqAjGRRk9miJTAR8H/C1Y+9Np6K1P/e6hhEWGe3ycIovpWrxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvA1pASaU2GRBlyh02ipR/4vbhR7ObwHDBW4w68c0OdE90hCMn
	DFwcCrP+4fZ2QM74VgV4qEmcCkqD9s3SkXrFzBEmNdpqXLMRBsiVu2qOZ5ilHvAzWkCuuXDuU9l
	nNAJ0BVHb+pghkV5z3kZU7/VuxJHODX3cQwbfdy5cIYNfFPMix56x/vw1tQ==
X-Gm-Gg: ASbGnctb0qGqWdxKkEMwa+gjHnMy3GCENkunBud4A9TBzv/cueZCEaEUSnInt3VynLY
	MDHAmuQ9RCc8/U0AUmScpet3OzK558L1Wtzuk7H08zAv1ME0QnYh0vPu3kNusu/Uld/FBrBm3B1
	5RP31sApeLyKHEkrPOvXJvHv01jakykEuVZz2XSinkFzDm2uHNOstsjYTKQb8jv9d3r88DGJJGP
	iHyLhTky0Zo8awQOE5szxx4QwPpkMK12vnncv1wr8J0KxlTvlR/NQ4uqLKstksQG33VfjHdmUqP
	hjq8m1xIeMbxhOv4S8Q9Q/JNpJ1ZZkMOIkaYU6hOL+11AhsjUI/u7doW/BwLZSHKqtAnVBbYqKW
	v8EZ5r3Rmqw==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549531cf.25.1757711592215;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman


