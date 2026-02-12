Return-Path: <netdev+bounces-258447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABkOOADEjWlt6gAAu9opvQ
	(envelope-from <netdev+bounces-258447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:13:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3E12D55A
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FA0309CEFF
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E63570DC;
	Thu, 12 Feb 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YveR4QPU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjDE/VkB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2D3570B1
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898410; cv=none; b=EVNHGI+hTcfijTQbmfJGMUvIg6Ea1VPK3UuflHlP8ZBo4IVb3hbNMhLfEAsiNyE9zUs50UwBl0cDP7tjm7O+pu/Sku8tw4qyRsZhlnne2qHk25AMh/hlzjBIqy8YndZdKDyBcyhyXOaoJidkAxOMQE9OlpLOJJbCaoWi2O0fYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898410; c=relaxed/simple;
	bh=lKvpeJi7uNV0Ih3JqfJpszylxumkmE+gwrTj1Z8q4po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk9FSVgmgnsDi02eHZkGLm2RA2heoWcShAWdDHsv8SFbmARNcSxY8X3hFnzVOToJtUIudju5DnnxznfkKeWnWWndilFRrubcgivZNOSoQduqd4h2VqjG+6oePkdssuuXahIMD2juFdycTQbo+VHctmtUWbnP3PLvK4BkhD5V66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YveR4QPU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjDE/VkB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhlNTtPjb8WNYnzKWJ5DsTLwzJj2iKNDqtguIqmgVrY=;
	b=YveR4QPUc5c0aVehc0kK9n0QVMLZnruQLOJnY3LD7IzJhM5d4AxDyCf/eXNJ8+zn5MWhfd
	2f64e2PwcUrAAH2CNe51hZZmC7JVr9KR1tW0MZmOaLeL0sWmduqxWW6oM/NU6vEZmIE5WY
	xJQubMNWuV1pWvV4c/9l/Fbdbxohj5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Dycv8QABP5mnZ9qXsNxiDg-1; Thu, 12 Feb 2026 07:13:24 -0500
X-MC-Unique: Dycv8QABP5mnZ9qXsNxiDg-1
X-Mimecast-MFC-AGG-ID: Dycv8QABP5mnZ9qXsNxiDg_1770898404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso2528305e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 04:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770898403; x=1771503203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhlNTtPjb8WNYnzKWJ5DsTLwzJj2iKNDqtguIqmgVrY=;
        b=gjDE/VkB/zjNhBTNLR2RKXXNqmMXAqUIOFjJu4Z3Sn0GF92zNyO17tOGcNLjJVzafu
         0oOCzY4pWJ6rjdGlA4USjARScWWkDzbzvOoZZAg+ToF3g30SX2wEISIZjZ6hlybFAqrl
         1dsQ8iG7+mu4HDcHVyrgxjm/nRpeavBRhOdTn8sMSduXGng3eunpI1gxs86NGSHmAcQk
         mCLkE8e2qjEpHLwqxxYDORYS60KP3wqX4Am+xqehwGTrhaU/8iEkDd7vCwFKDkTT483p
         lSk1jL6+Z8yyeFEKiP+g1D3ku59QgEsam5BVZbAUrzmWD363KmoUuW2harvEf2EZE2xs
         yvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898403; x=1771503203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhlNTtPjb8WNYnzKWJ5DsTLwzJj2iKNDqtguIqmgVrY=;
        b=oyQ+29f2byYbaiG6wZZXKzQapTrUJAiZB8dANgmMHwPnZYhU1CapsSwEdHr954vGCb
         2fDp1nqmIoBGRy1lqU1uKee9A9WC1d1WD0gPkLDoAopci/tzE1M1oRJu7Hd3fBPmqH1W
         TY0vktnXL4XQFmjb1grR2Ai7mngB2ErR1MxWOwsyIxwdjs95++PdO3fvSEcNUg8h7dKp
         RLzp392+eLsgrYEdsOS5mL/EtSqr5UGV9eiYkQn1+YcDGeTSEL46MR5XM3JOlATV6GYj
         c+dO8KCImgghQrhqaQM5YYqWNZs+JG6tMJ5NRGSLHuOI+JbFQU135CCdJZSxc4sk89Ut
         sH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhv5ySiKx+vrSsA9P/85dO55wBHutqaYyhLgqSuz38ANNdFZjzrIc6gJmF8F8MfC1gMGvSecM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/NXE3FVRIIUfxU66okSfMchGTWzU3oXy5C4nNmlIqHpLU+yh
	Ax1gKGjpCkZ5ElNizUxkpdz3iJY8MRr2EYpg5dENdGixJgw5r/G/rN7LIH54rjK1pLEOJ3Y9Dsz
	COTrFrxZF8R7U2KChgUofLSEPr6EgZExHrX4vBE39xw5gBElnQghBz/vSow==
X-Gm-Gg: AZuq6aIVKQJqRQN/IGysWRpSqFWIyNqOxlpG5GT1fk3Z9XpbP+hOH2Qyf3WBTM47AXZ
	rJUQMfHONK+TlExfeXxlMgFy8mcGFdj667Yv6ZZ96Uqxm9uD9VYxZzXSnzr5QjreKsaZTfnWAi6
	5TUgJOCnW80zbEQgTiQdHMEXPmqJ3a+5U7PSHEPSEH2ybAz2xSxeteVOWPJU9adpGjB3jsnrZCE
	xNypUkOUCg2XVSelB17iyel9y0bEK8qOHhDOv5HC28bqTPOekDfSSV8aSJcR5ylgnkVb1ACJIKD
	CGl8iYRKukPIwcDwieRvIwsjUoydpHSSQM8Cs57snb0TXhJgaV2olP8jqbCYLhaUN/tDONQTDxa
	2cCVjtgWhaFjv8HLTmRON9QxToA==
X-Received: by 2002:a05:600c:4511:b0:47f:8c05:786b with SMTP id 5b1f17b1804b1-4836717341bmr26321475e9.28.1770898403478;
        Thu, 12 Feb 2026 04:13:23 -0800 (PST)
X-Received: by 2002:a05:600c:4511:b0:47f:8c05:786b with SMTP id 5b1f17b1804b1-4836717341bmr26320955e9.28.1770898402985;
        Thu, 12 Feb 2026 04:13:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd20519sm193863435e9.15.2026.02.12.04.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:13:22 -0800 (PST)
Message-ID: <4ce73296-a6da-47d9-8483-5bbe564f20c6@redhat.com>
Date: Thu, 12 Feb 2026 13:13:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: caif: serial: fix TX UAF on ser->tty
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, Shuangpeng Bai <baisp@psu.edu>
References: <20260212042236.639174-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212042236.639174-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258447-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,psu.edu:email]
X-Rspamd-Queue-Id: 4DA3E12D55A
X-Rspamd-Action: no action

On 2/12/26 5:22 AM, Shuangpeng Bai wrote:
> KASAN reported a slab-use-after-free in tty_write_room() reachable from
> caif_serial's TX path. The TX handler dereferences ser->tty while
> ldisc_close() can drop the driver's tty reference. Since ser->tty was
> not cleared and accesses were not synchronized, the TX path could race
> with tty teardown and dereference a stale ser->tty pointer.
> 
> Fix it by serializing accesses to ser->tty with a dedicated lock. The TX
> path grabs a tty kref under the lock and drops it after the TX attempt,
> while ldisc_close() clears ser->tty under the same lock before putting
> the old tty reference. This prevents the TX path from observing a freed
> tty object via ser->tty.
> 
> Reported-by: Shuangpeng Bai <baisp@psu.edu>
> Closes: https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/x8qUc3yUAQAJ
> 

Please, no empty lines in the tag area.

You must include a fixes tag and specify the target tree in the subj prefix

Does not apply cleanly to net nor net-next

Please read carefully the process documentation under:

Documentation/process/

and especially Documentation/process/maintainer-netdev.rst

before resubmitting

/P


