Return-Path: <netdev+bounces-182846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F92A8A17D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BD93AA507
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D538BE5;
	Tue, 15 Apr 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhzoyuh0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DF535D8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728424; cv=none; b=HSdmWZmkev1rqqktrtWDTFHsExTlbOYDnwV74uyq0BM46Py1CfVkA253ZG0yCWoSa8T2ZN/AiGgFanuQHGolUY6rEG8153nWMC5yDxr23u5ryxsANnjbIqNkY/jJKtbwXxB3ki4U4CBboB1oFohN1f6pTMITvh8DMJvufVl3B48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728424; c=relaxed/simple;
	bh=lP37Ul/V9UUEgBu4Y5XXBoMSyAY9e7d/SlzxC1cn97s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpct03EjIlewQsqdOI+UtfNG+uRaCywNLdz7t460egpmqJXd4khhyircK5QyD0sWo2cuA38BT2UoLSmLpU5Ew7P2ggPBce/MziBui+aC9xJTlP5NvQSwk20BAA4aK9wJFt5B0A1zoKmutwszGZcc6S40lZb6Q4d/h/aRuF+XpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhzoyuh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744728421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rmo7jwGllcv/S3D2SoD0PGiN20VfUU4oQPWFcPGOl+w=;
	b=fhzoyuh0sw+PmLcJf6XvA7n+GAEAkK6pgDdpq+EszMOl929j8vN/LlXIPXdbmM8TfsncFt
	NjQKUnyMGJYt3HOct95gkVY9bACV6l6HIq3gC5gkTCNnh6y776MmGaffhL/yWXzPJdD8Q+
	nRHvafmgoxtq8lf+/EGEWOyPLV2ddbY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-4tMMosPJMPSuMVHdkLSbMw-1; Tue, 15 Apr 2025 10:46:33 -0400
X-MC-Unique: 4tMMosPJMPSuMVHdkLSbMw-1
X-Mimecast-MFC-AGG-ID: 4tMMosPJMPSuMVHdkLSbMw_1744728393
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so29105545e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728392; x=1745333192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmo7jwGllcv/S3D2SoD0PGiN20VfUU4oQPWFcPGOl+w=;
        b=iQeJ1/Y8LNfehcgD7/feE2a7dIdmE5PRdB4kNUTkf2wXKfm2gRjfPvw/F6kagWzW0N
         gwy3/x+xbu7dXFUCjTKTB1amCzUEs8eNmwpbGaMFP0qAq/FkZawaEDeLhYY3d4k5hujn
         MYQYBMwzpBj5pSozGsD5GoxZ8uWW26A5S1UEPf8WeqxR5DmXWcqY+cmgCTkYuLOKu7HF
         p9NLRavPi1Hbm63CqVMZAKu4fYgQMG4C0XLRsn23GIskyx1L2Q2I5VeKlktZq1LbeNCs
         KMQjkAzyolCNeQSmUWwK6Gq4V/TR8y08oFHxJVJpgB3AxrapqYhvBympC4iD/SGRDo7n
         n1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrR6glmen+YlHHkgENJPxK9iV8cXCq1NPakiQDV6QuZtfViWXVUllqfL8Tjlv6ry9DugQ9zFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRAFgaJCvYXxFP1FdmIQRoaDULQmus+SDEvtImKwuUS1/YAly
	LhqZmWcnaMD1XeQYtKhYMXvK6PpbmDTteuIjAjNho1LndM3quQ76OJl6KRJ3EXpZ5lK1wr5q3gx
	Uor7jRj5SKuqWiqbB5JB8GDtcqPj7Yw5/mAQKFs1p4vlRC+uMM8bSafo5n9zhQg==
X-Gm-Gg: ASbGncsV0cS9tALAPkZi+CpiXY8CKyLr5KykyVG05gMNtOB9zkWtcD6PzNd/xhI++SU
	PGb5DEhxUyluFvGl3zf7YAA+F6lSXPNDyMTH9A6lycJX+6wark+14UJFMzxO13ScfGh8R8vc7u/
	SaBVDEGcs6VIEjqF0Qx+lHvjcBbpBNJgFj+tC5N3496WSq9XEyW+rfzoBezwleF/VTC9chiFyV2
	SLusGKFZZYhEE0maBvMpRnbNq21UmesL6XqWNtY6zhn2kty21DNrvYMEaXdJ+FCeDCxtQViiRYK
	ppgVrm3HJVYD/NzxqedfwjucgRIKKLR+bZ5+jqg=
X-Received: by 2002:a05:600c:a41:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43f3a93c874mr155413695e9.9.1744728392298;
        Tue, 15 Apr 2025 07:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnycpvaNvPmuw7b1odSUloZAEVhU9gr08QXA1WthREBzSAdWQvCmZeAh2Fxb6Wj5Awdt19mA==
X-Received: by 2002:a05:600c:a41:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43f3a93c874mr155413445e9.9.1744728391932;
        Tue, 15 Apr 2025 07:46:31 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm210914395e9.33.2025.04.15.07.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:46:31 -0700 (PDT)
Message-ID: <30c45fd5-9725-405b-9ff6-39db994d07d0@redhat.com>
Date: Tue, 15 Apr 2025 16:46:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach too
 many actions
To: Jakub Kicinski <kuba@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250409145523.164506-1-toke@redhat.com>
 <Z/aj8D1TRQBC7QtU@pop-os.localdomain> <20250409171016.57d7d4b7@kernel.org>
 <Z/14I68bvZRza6eB@pop-os.localdomain> <20250414142416.7a4936d2@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414142416.7a4936d2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 11:24 PM, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 14:03:31 -0700 Cong Wang wrote:
>>>> I wonder ENOSPC is a better errno than EINVAL here?  
>>>
>>> I think EINVAL is fine, it's the generic "netlink says no" error code. 
>>> The string error should be clear enough.  
>>
>> IMHO, EINVAL is abused (which is probably why we introduced extack). I
>> prefer to find a better errno than EINVAL whenever possible.
>>  
>> Extack is available but it is mostly for human to read, not technically
>> an API for programs to interpret.
> 
> How is user space going to interpret the error code here?
> Seems to me that'd mean the user space is both aware of the limit 
> and yet trying to send more actions.

FWIW I don't see much value in a more specific error code here. An
application will likely bail the current operation and the end-user will
have to look into the extack to pick enough details on what was possibly
wrong.

/P


