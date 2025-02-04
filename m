Return-Path: <netdev+bounces-162516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5305A27280
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D453A1920
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1020DD45;
	Tue,  4 Feb 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZJmGA67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10820DD79
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673590; cv=none; b=Hzh4GP34AJF7Bb6hV1+cR3ipO8yzee3O7aEA+STbO1t13uuD5G+8isD5dADzhMSzrrePMdjIMz7zDIai3v8y+IRm2k7Ry1jQ769paaYqmfRqez2wk5g+ZDAVaJ2C0phxFF1MGhkxR+vmfwr0zXBtjK5mc2D36QyaYl7hlCt1Xh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673590; c=relaxed/simple;
	bh=E2XOKaKCPe4d0VXjuMdn3z7hPrsYbPCbKGNXONoomO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgogTJSRtDsXo/8dfZj3UeuuyU/COumKY4nAfvxDVuq9ZhL1ciS1cHVMka7SFDW32aWmdUUvZi5jzxadTvs77R9OPyaadNxL8lZxHD7UcI0IxCTnPpR0SUwi3JCbvu0ePz+tsQTDgCD6zBowK8oeWP5nxh9QXb2wCmnPG6X3z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZJmGA67; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738673587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9lGb6ArVNAnC84Dm4Ix0Qfrp4oELB1vI8ob2VTGfsk=;
	b=iZJmGA67IYPWS/xtSbPc7Q9GLH/kXMPWSwivPiNG2/mtHtj/K4W0epuHzL8zxJNxafxHjh
	yfgNvGiAjTKXch/zzz+Lb9A0B0QnKjak7T95XvHJ7ob20WbxC5sQIhCW6Un2SO3PufEtC1
	8j7ISM1ka391mHNCwsXlP1szGFPhxKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-x5Ti19JZMB2uf0Nj5WFA1Q-1; Tue, 04 Feb 2025 07:53:06 -0500
X-MC-Unique: x5Ti19JZMB2uf0Nj5WFA1Q-1
X-Mimecast-MFC-AGG-ID: x5Ti19JZMB2uf0Nj5WFA1Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361f371908so39925555e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 04:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673585; x=1739278385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9lGb6ArVNAnC84Dm4Ix0Qfrp4oELB1vI8ob2VTGfsk=;
        b=i5EWuO2QDRItuA9xf8YIqb/klBnv5YVSKfcDbGZAbH/vOYzhcfOWhf5xWfxv5vHXZ6
         6B3SUJHjHRUe/VY+uYLL6gvAc3NTz5dMvQAoU3AN/ARP1yUhPZpHB0VXBGypNBisRtBM
         o8gnmSlrFurk21UXo6z+l05HfIJBM+b4R1O6/H68O+aRPvujMAFJON6daIL0iiIEx6v6
         wnVFGzd9+a47tupkhck7G4N+/Tw+94fOO2WMD71KgbPtaP8yXX+5OVPlZsuXRG15qq/Z
         kutAHGhHcbwdZ3xMrX/2B6VqR/QRqc5OPb2t+09Roe6pee2o920ZY8E3oRUufS7lj9Ul
         q1kw==
X-Gm-Message-State: AOJu0Ywp3+VkuJrS2y5rII1gh+2xkCBmn8Nf7bXEqmQwVezUuaezNLWu
	ci0smmO4hBaUDAySvo1VHBah/ZAq3exu+O7tRf5O2jVhKOdKxqJGkWOt8zW0XFx6m7BotjYdLup
	UjZ/BIozWT+qHKbocG1+7Osd2uPiKURjvlMstMGumEE9tVeQG+tLGlg==
X-Gm-Gg: ASbGnctmCOE7Bh1nRdLMEGv8ODH6MdAzV2Z9CD7qzuRGUU/2OCAe7PazbC22RlXAvNv
	VuyvJQF+tXvFGO5vdCUKZK2ALJ6b9O7Cz+VXpaZw7r2ncenJcB6mOF6M0eYoEaZ6g74gH+PTdqj
	uQLzxtlUmR0DsHx/e4zbk5cDUQFmDWu9S976kD+bu39GVKtyVXcMcd048I5NIVdZEA1soe/I0Il
	A26lwZU1GencrbKbGf1vTyBXnuQ/L7WHR4CJEo9AxkM2I2xaPquHzy06xK/U9dUoihOD5fifYEk
	a6Pd+/sXJS19Kmb6sFYMvikqVCetd7Sqqh0=
X-Received: by 2002:a05:600c:b89:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-438dc3bb62fmr211869695e9.4.1738673585396;
        Tue, 04 Feb 2025 04:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0ebWy/v6G4LkxINcqvwhARvH23QsWGEzmKN6/2zftb7x+PQKmee4ZP53mN3AbmSaDP8Q1Rg==
X-Received: by 2002:a05:600c:b89:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-438dc3bb62fmr211869505e9.4.1738673585046;
        Tue, 04 Feb 2025 04:53:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e236f9bfsm195113395e9.0.2025.02.04.04.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:53:04 -0800 (PST)
Message-ID: <a2154fb1-95ce-42d1-8cdd-ae955b850a29@redhat.com>
Date: Tue, 4 Feb 2025 13:53:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: rose: lock the socket in rose_bind()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com, syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com
References: <20250203170838.3521361-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203170838.3521361-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 6:08 PM, Eric Dumazet wrote:
> syzbot reported a soft lockup in rose_loopback_timer(),
> with a repro calling bind() from multiple threads.
> 
> rose_bind() must lock the socket to avoid this issue.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67a0f78d.050a0220.d7c5a.00a0.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


