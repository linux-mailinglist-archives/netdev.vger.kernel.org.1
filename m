Return-Path: <netdev+bounces-175227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA74A64735
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEEC3B414D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2122579B;
	Mon, 17 Mar 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3oSJOk0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5A221F1F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203443; cv=none; b=mFouOcBsfr1+rXythiFUra83kdTc5HzhmMvW2+pDIHdsgKP8yNTJ4erl/In/oK6/8Qudt7Xnn7QvcAlNwGtk7MGGAU477uTjasu0xLz7S+ZXR82s9F333WbDQhGXwCADuyPZpSvvpPk3xt6NjvKA27aewj9JXhMF6fnDbiEpijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203443; c=relaxed/simple;
	bh=w3j/18x5zG33l1Xn2LDakJuAelpXyi10nt0TIrK2h0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwj0A4KSInhlBdJzRUsy81v1ShtLhbxlNKFcGeLPytuzHwTb6ATZPGJGBv31iZEaPq4V3mqUAE5Y+qcmyTbU7O8KgdOiUZI6Pb0B9l59L5EeSG5rh2bAT8lDuft/UumnG3c7FVmZ4obvlMDdjrpJ/QPyVrtW+lPhnDhwh9hv7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3oSJOk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6ZVFd7JUtvf27xnQEgyjnhtq0KyQz2b5f0StY0AKxI=;
	b=B3oSJOk0w1IxxA/58OZdY4k8LIvwSF1s/WeT9rZYR48a4DU4xtcHzbYIhBTHmpYSdxopT/
	7zkEhp5JWYwdDfYsmG+RwtRXTDtJDsbsoMQUJ1l1KyELlrdG7ZqxWTHp3RBZsF1wbjYPIW
	Ify/j5Luq21suxNjRocPZBoAbaH6068=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-A3x0x8zYNC6AAjP4TJuKew-1; Mon, 17 Mar 2025 05:23:58 -0400
X-MC-Unique: A3x0x8zYNC6AAjP4TJuKew-1
X-Mimecast-MFC-AGG-ID: A3x0x8zYNC6AAjP4TJuKew_1742203438
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso13038065e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 02:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203438; x=1742808238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6ZVFd7JUtvf27xnQEgyjnhtq0KyQz2b5f0StY0AKxI=;
        b=WqDglyV+52O3W7v6ICms0OJOgi8/LnsPSskj6c+wYQ16MjGL1e1Iud56JQZzM14Wkt
         kdjgsncFW4CMurGPO15D4aZ0cNJErEbduwennDCcnWRNsuLXs+829J2cJRpPt8qZDtkR
         hbjbp4NuMCtMbyZ5LwZgt6DgG731VHP6qeYSS+qRYldW7m7Hj0TIzuw/snb98JQujTtp
         jV0UgO/MbB4htOd4LG30NqdCy7xfBnMvozOpTAh42wOMaA906mQxwCZesGPx8WS/i9RM
         mgr36AJoYh5lubNeJH9vCuQ+dkkLAJxaeQasSgiRdq4d5m0EO4/3fs26viUjDw4nljxS
         tOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcC7gR13tfv8DXs14+xM8y+Nirf6DagEC+60woiRi2yg/PbWpDZ+IB5lSGvs01bkdE9kbt8E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gKVF0jvAGbT9C9DsDJLYxMD+0/sH6L8ntGpmwbVldYdfrNRH
	Q71EuIx4MpV2zPdrjuuvtT1HVXRQfL0QhTx9WvaDP0hMsBG64DBiLm8k2MHjGIMhwvXGL+2g6xC
	CnGqK5m5U27B1s1HXmcyF9HLBMjgU3nQmwh2knZwHKSxwO+zBvDZtPQ==
X-Gm-Gg: ASbGncvopj0PvFcswv+FxhlIIErp+gFr5sZuNFjypeX3aVkrm6EdxpXnGhfECxiHA0p
	pc54/MJP5Up+8QiYTm2OPe+CwrQki/fq0dm2Pys/m9vjrvBi3fc7upwSmSCEvFQmflJwHb+jQKf
	FJb46UF1L63Iu/sjllYds6kDAcmhVTBt+8+RdglzxmmvheiaAoL8xAkwhYWH9ubmybE+QB10zay
	HZ+vjXC/1yRn4P6tCXC00Bwn1mXUSXr4OXo16cmJ75QIfhX14CsgQWir5RAwsoFogKiVfTNTP+4
	zeB8DbOllyokJPtquGRpo5r6Mb4MR71fh5/50LxddZDjHA==
X-Received: by 2002:a05:6000:18ae:b0:391:40bd:621e with SMTP id ffacd0b85a97d-39720398fe7mr12297880f8f.44.1742203437766;
        Mon, 17 Mar 2025 02:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsU3reAV6XxwOJwxHfqVgmlQZsdrUsmdlq26F98XjPeivLhAYt7RLXE8nKAteDAl29vQqh6Q==
X-Received: by 2002:a05:6000:18ae:b0:391:40bd:621e with SMTP id ffacd0b85a97d-39720398fe7mr12297856f8f.44.1742203437465;
        Mon, 17 Mar 2025 02:23:57 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888152dsm14138232f8f.48.2025.03.17.02.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:23:57 -0700 (PDT)
Message-ID: <cf04be0e-eeaa-45ea-9a06-3870e65a977a@redhat.com>
Date: Mon, 17 Mar 2025 10:23:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] net: introduce per netns packet chains
To: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <cover.1741957452.git.pabeni@redhat.com>
 <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
 <Z9Su1r_EE51ErT3w@krikkit> <df7644e4-bb09-4627-9b73-07aeff6b6cd9@redhat.com>
 <CANn89iJZHok-JHiu3bSZQaNSbu4r+yJkXhZ8eoTtk1EaHsR56w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJZHok-JHiu3bSZQaNSbu4r+yJkXhZ8eoTtk1EaHsR56w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/25 9:43 AM, Eric Dumazet wrote:
> On Mon, Mar 17, 2025 at 9:40 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>>
>> Thanks Sabrina! I'll try to address the above in the next revision.
> 
> Could you use dev_net_rcu() instead of dev_net() ?

Indeed all the call site are under rcu - except the one in
dev_queue_xmit_nit() that will need a little adjustment. I'll do in the
next revision, thanks!

Paolo


