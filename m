Return-Path: <netdev+bounces-178558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E69A778DF
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28303A9796
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373601F0985;
	Tue,  1 Apr 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5HMXC4w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC41E5739
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503597; cv=none; b=b3fQdE4fQqKqvKQ73e1n2Bt331gi9zHBWVw0E5dhD3yxcvD+jn/7w6de8uafbzGNBRDPsn8wnMB5gZidzkF4KqxdeH2Xs6p89P5NtFr1EpkHyjy8e7cO3ESPoQFq8M0+q3L1CkcFEOTnbpnkOED/bPq3I01q3xakH7EnDu9Zidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503597; c=relaxed/simple;
	bh=ApBnmgcKqMD058hx45MHE4QVSw6qEmgZIyz8Wmp0Z8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdvlT4mo4JDJiLvr99pcdK5umX/wJEQO7nYGTO3z0+pgRDaCZSpvot35ErQgukBvzYQCfKYeCdXndTf9yjkrbnDBmZpF9mHEUnKD7gNUmACnMocyjM9pjYTPCGwhtSqHvjSqqrC/lRBS6F8wArdP2dFQKc+wcGHqk3O2hx99uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5HMXC4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TsOOeVbIrS0kLjU5o00N+CHVLz6q84BnG/iW8mymGA=;
	b=O5HMXC4wRotUbBHqnAThf8R2t0IKOHhCdwlsa3dXKDW63P3kzYciCFaOVVAq9jyW5+SIeU
	kRIPJVl3HnsysxWezdzRkPnWrjWSrRXRAHmvwQR1GxPpzY/8gaXji11WUaRFvaHr8P1O9x
	WqIIX8ZaMiiNdIMk/6MkoY4reYHC5h8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-0_jOcKmBN2O5R3I7YBABXQ-1; Tue, 01 Apr 2025 06:33:13 -0400
X-MC-Unique: 0_jOcKmBN2O5R3I7YBABXQ-1
X-Mimecast-MFC-AGG-ID: 0_jOcKmBN2O5R3I7YBABXQ_1743503593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947a0919aso43486935e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503592; x=1744108392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TsOOeVbIrS0kLjU5o00N+CHVLz6q84BnG/iW8mymGA=;
        b=IyX8Y9YQD+4uyeqJfkGDr6yy+/AyQd0D1ZQNxCXHkK7IWKFsU12EALqiNbhfmcbYun
         zieuo41Pl8hfeZHEzwVRVXpGkTA8IzLHQEc45XowgDRrt66aInnvUtSIrhTIGHRHndot
         1fblcldfhDLejM+Bp2byMoHUCWn3Ku6GWgnTojiOQKE/43hiUdipTtfAnPWuWLVqpuvk
         AvxIMkwzWbutxfuEGQGlOFzUBtNjFd7ANtoaBfG3Mz/bg06muLqxr7sLp2OWEAbaU1DA
         lueJFo3RWEGrUpNP6at7JFA7VDKZ1FLVNrZ/GYZU+nKuOP1qSTACKppnfqnH67Nj9UZe
         jt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXEcXOiZnOOS7yCZNVMJSIxYR0+6MGAw9pYHh0Qzux9m+vIwtjoOiPGPU58DY+4ujYc/qYWijA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1LFVc4TyzGDx6pa/7GSZDMsDSYgImmCIOQHe+21+wyqv5Pbp
	iuY10W6m6/yc4G5TXNW6UGHtz84Gb5v7iekmYcpAy9bS/ZA2+7okLoiX0SlB1px02OWuOuzF3g1
	w1uIXL8vh0NQiChusY5XtHXD/qr0PsXxM0G8dRZaG55uMZO/FJu0p751d+YzYiA==
X-Gm-Gg: ASbGnctxxP+6TcJyiCJ3sOUJ9AX51p/+jH62eqztli5ff/pV2z7x/fU152L+5pE3US8
	rqZcaIMMchF5nLLBkFdAmdJrlQVVbgTE3ywilmCmnoA+lMuqapbEGsccfLj4cguLuh3tPR4FVgX
	aq+rBdXLZp0TSmW9Va5/lW4irZyMr7pBLmRKB4F/mtcehbH1Raa+iY/XlPpH6a4GlTbIAhH1Uso
	dk91/3k1qVIJlq+rTo1BRYcN3Mgbk8GGkyVleZucKUrOl4n+T0lP2QYTQGHuQMyBgbhnPVVTxgh
	DVRQkUzBT3Fbcaypf8rMsz4Ze6jV/GJEVZOlTSwwGiv7Pg==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43db6228823mr106308255e9.7.1743503592250;
        Tue, 01 Apr 2025 03:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMLjX+su0ElU+wdiotWIkpWOESzlWW59YNDgOLOqWSNKSZCQnxyBq6YuI7/DjQUyGF1DSr5g==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43db6228823mr106307925e9.7.1743503591949;
        Tue, 01 Apr 2025 03:33:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm193576985e9.18.2025.04.01.03.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:33:11 -0700 (PDT)
Message-ID: <d2914c9f-5fc6-4719-bf6b-bc48991cd563@redhat.com>
Date: Tue, 1 Apr 2025 12:33:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
To: Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, hawk@kernel.org,
 syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
References: <20250331142814.1887506-1-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331142814.1887506-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 4:28 PM, Stanislav Fomichev wrote:
> Syzkaller points out that create_link path doesn't grab ops lock,
> add it.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@google.com/
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

LGTM, but are there any special reasons to get this via the bpf tree? It
looks like 'net' material to me?!?

Thanks,

Paolo


