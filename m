Return-Path: <netdev+bounces-204914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3280FAFC804
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AFC7ABEF8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C0268690;
	Tue,  8 Jul 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhAsWk7A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A72264C8
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969529; cv=none; b=PaV6PkDx9hbc8Gp+LK3kHereAF2tvf/qDhGMlwWGIP1CurqTpGuohxlrBBtKfbJ7g9sYODHKnIAQ8MZlI2DLmchHdYo7IdO10a4kvvEP0Z82G2V7YG9kujb1JR12/Dwm1yn43dLEVRDDdnCdNbUD2IbqRP4OwjUWphFmt5tQ8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969529; c=relaxed/simple;
	bh=/HQa1z1jN3PpAa++723aUcYRHiwy+TUMDJs6S/qMvW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cido/kkDQJArVPjxY64xC4No33qCwH47wziMpo6EqO/xvinthk/a+s6JWEyGAEVAHxoya/YAuuCeePn4FHVFPhrtDq6yl8QpxQa0vH+tkMpavPN9Xe31hs6KWraWKeFYETxsdfuKlEL7tAH2W3McPVOyBd94neTmtlOKkoxrf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhAsWk7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751969527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VckvREiCdKgjlwTR0uzox8k7xIiq/bs/ylaonm/G3bc=;
	b=hhAsWk7AbeQZd5JSFYY6ZnLEwXv9C2bmV8dIqdcSULch63ElXog8AjBWYaeLBjc5FKkoCG
	mrJQ1mNNZ1nRjMdnrvEifhc2vnfMbPBARsl84czWFRxy07BEU+QKbk+1Vs7bWDRvzI83KE
	8Mb+Mud2dV1kEicY5XOfYofscdsjoj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-rXVb7UKLOUOkLSHdnBczoQ-1; Tue, 08 Jul 2025 06:12:06 -0400
X-MC-Unique: rXVb7UKLOUOkLSHdnBczoQ-1
X-Mimecast-MFC-AGG-ID: rXVb7UKLOUOkLSHdnBczoQ_1751969525
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so22105005e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969525; x=1752574325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VckvREiCdKgjlwTR0uzox8k7xIiq/bs/ylaonm/G3bc=;
        b=U9MQeKvyRFI6cz0cAGPQN2AJ6WYnHWdDWoldszrKtI9nDPFCg6b/TkRTxx0tTRbxiN
         ZanKUH9rYKPEQ0/K85Ya7Mm7Ntvhi2ZnE+Tm2WWZCk6AnU0TMG5T0KYTPa0Z1GnUdUn2
         P6Gh2Y4luYKgU/bO2rwN+BCwXYSk0R+RSQsvSedWi1b7oc2i7jED20+HhW/xCPm5Xa9C
         lcPmlCnN4W5Ys6QHyTG2aRaMzknpg7gKUUj6+IwzldnJYwB6nuCuZ/9edYR/5kaaRKNV
         PJdkEVlCjhSp2hEJ5v237VfZe440PqrFdKnkbpqriS7vVyKYAM4H70ntbCQcCrEsJ1If
         tm7w==
X-Forwarded-Encrypted: i=1; AJvYcCVjD3PzGNYB3q5xfpWz2Up1uMlzIj9fe97UehjZ7pmA+IjXxX5O+88Tlm8gQBkNsILFyF/UwnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5EN7cZ20AT2zKh89jiAW3VlmqOl0nZTdj2ycTR8amk6r4Yhi
	jPc76jTz8OHFUDTuLXht/EV6ohq+7MpWapiW/O7Z4IK8ojqBQxr0T9dKBI3N4JD0YTI+SYSt7JC
	EX7NHcG5bAtZ5oSkHOFbHCgEMSmUDKSJHLgxAVxjyTpBwk0ahgjJZMxxVXw==
X-Gm-Gg: ASbGncs5IvMpZtt0gaeKmsdNFRzY34dOAUCIlwIz2rL9p5+GAcoLX1cg2rBOwPJNKNk
	1Jol5/+nHmoZxZQjQdSCHY3J1mWMd4j8D2Gfl/+2FzKTm0TnmQaGLb1FiY/mWIlRWPs9u0UkaPY
	jWTaahRK5pMVeD5Kq3ySJAgHTbbmSZTfoTAgzxnjxBmfK3ol0sT6vlO36HHKEKPyaaAtR8VoX5m
	yAkYFxthfumbG5ET/j91VlfLL53C5AAR2eKe9qjFyb7i39Sw2ZZzaBm1pW2Knrg6yj2+ydPpKQo
	DsdgX1U+xC5QwvQMBY7g7a4vyue2MxWnszIXQV5jlWFoP6fdakAr97OXl+xJqoQlLTjoTQ==
X-Received: by 2002:a05:600c:8217:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-454cd4bb133mr25933425e9.10.1751969524777;
        Tue, 08 Jul 2025 03:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv2EXOVvGkJ5cBb0UY2EBrYXftEd6mDal9FJ3lqO+qaygdclYdtCf2yd+Q8hcc5IGZWIbqJA==
X-Received: by 2002:a05:600c:8217:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-454cd4bb133mr25933005e9.10.1751969524261;
        Tue, 08 Jul 2025 03:12:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d2661sm17889835e9.19.2025.07.08.03.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:12:03 -0700 (PDT)
Message-ID: <59259094-7eb8-42ce-aebb-c5b286a4f31b@redhat.com>
Date: Tue, 8 Jul 2025 12:12:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <20250701144657.104401-1-hare@kernel.org>
 <20250702135906.1fed794e@kernel.org>
 <5c465fcd-9283-4eca-aef4-2f06226629a3@suse.de>
 <df7a3f18-3971-434e-9222-6744d5b77f83@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <df7a3f18-3971-434e-9222-6744d5b77f83@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/25 2:55 PM, Chuck Lever wrote:
> On 7/3/25 3:10 AM, Hannes Reinecke wrote:
>> On 7/2/25 22:59, Jakub Kicinski wrote:
>>> On Tue,  1 Jul 2025 16:46:57 +0200 Hannes Reinecke wrote:
>>>> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
>>>> the serial number of the keyring to use.
>>>
>>> I presume you may have some dependent work for other trees?
>>> If yes - could you pop this on a branch off an -rc tag so
>>> that multiple trees can merge? Or do you want us to ack
>>> and route it via different tree directly?
>>>
>>> Acked-by:  Jakub Kicinski <kuba@kernel.org>
>>>
>> We are good from the NVMe side; we already set the 'keyring'
>> parameter in the handshake arguments, but only found out now
>> that we never actually pass this argument over to userspace...
>> But maybe the NFS folks have addiional patches queued.
>> Chuck?
> 
> Currently .keyring is used only with NVMe. I recall that hch has plans
> to make the mount.nfs command set .keyring as well. However, nothing is
> queued yet, as far as I know.

I read the above as we are good to apply this to net-next right now...

/P


