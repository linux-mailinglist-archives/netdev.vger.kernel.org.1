Return-Path: <netdev+bounces-289297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE91Eg4QDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:23:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5D578F94
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E815330C3F6D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3F3CDBBF;
	Tue, 19 May 2026 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgYdlUPn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qwS3BExu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBE3AE1B9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175060; cv=none; b=HWSpwOX0UMf86K0oQV8Nk0prxgbImhXN2Zg76Opln0jxyIZoo8Nm0v+u81drge59dI2oEOkV1zs7tRWlrsrKfsiFHVIEvHWYa2MOS6CnspC9Caq6PsRArLOQhlkAO6OedPUB54wNJuHxZts7Fnx5kymDl51FV0qLw/O6eWSnVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175060; c=relaxed/simple;
	bh=dzETsDdbYK0x8/pCg24n3n56p4YbaBRDF0Bik7m8yRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5CzhHi6STnA9Hd5yICkw6s+OX9svY6euWyka7L6Z0dxubojaA1b7rRuvjfD2J83HHOJj1pFoHJywuOQJsm61R5X0U8F0tFW+UomzzLixTMptoc7o4R1ybZHhbdrEIe8UBe1+OICC40WH8T0iddIcIjFlUXPuUcDt2e8SMdxG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgYdlUPn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qwS3BExu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779175057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0K4PXGRihbgM0Q1lccy8tXCU1A0cnyGkfzj/MtoSdE=;
	b=HgYdlUPnW4Yu3i4burFx4aqj6Qr6Pht2w8NWiwN1o8X0pCCgZB5WaFCvkqHVMv1TemAnJm
	dI1ztolfY2plSg1M5Qmme8o0JMZrFSqRwHkJp94I82olQLQ+M9H/sJQky3LGvNwIlHlo0M
	z9Tk067C8T/l3L+LOvX55LOPICC1zhA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-64Gsza9YMWms6mdRSpxw3w-1; Tue, 19 May 2026 03:17:36 -0400
X-MC-Unique: 64Gsza9YMWms6mdRSpxw3w-1
X-Mimecast-MFC-AGG-ID: 64Gsza9YMWms6mdRSpxw3w_1779175055
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48feb029961so18660305e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779175055; x=1779779855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0K4PXGRihbgM0Q1lccy8tXCU1A0cnyGkfzj/MtoSdE=;
        b=qwS3BExuyjGVYbGNzgYrD0di28iuOMJcO7Hncaaiwo2/qX+g6Su/QfR0Tqwymmv7qV
         ggugejE+gdmN/t77lMZnbgmUNd01J1zT4tgY23sS/aTQzs2zj1ZAli1MG3nSOGUxGwOO
         XPy7gwljBor4yhqAAN/8o0b72Yu2WmAwdq3yFy1u/nbawbAlRaJY9KKcWLN9EMxBf+7l
         1alWMjIz2y/y76gCPKQOQX2Xw/rKtomntECnPyc+YeVd/vdI3oG+gWpo4rVpKp3zsSzD
         zXp6GqvZcPDZmd38vFIg29AtLcumPYVyMWELnSg0j9N1awRsr4ZdQeVUuYkCen/pjSB4
         xfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175055; x=1779779855;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0K4PXGRihbgM0Q1lccy8tXCU1A0cnyGkfzj/MtoSdE=;
        b=STGpN8uA5Ii4mEml+LnuI/CaVe5Ix4g80AUV9LVHo6rzNNCBHliAA2z1md3aRuwNTd
         zp1ulTsa9r70xF6VxfHqubNquofrOy2++J6ABDid7tlfyKLL1wEHD9rksaxJJQMle/NO
         v0W1ytRGyJmIa7M67gmgD5KeKmPIWkYQOVcl8kHsAZpNp763p9yMMRndFdXigUcIJ6N6
         hhD2K26UUmf87VpQJu1s2EWJYBefLTJOLTXjifU/XEL53crgTfk//EosiZKQ0P5+yba3
         b7rzdbccOcx2aXMfzAxqQ5lEYTgT8a5GyqWUIFCimPPkxtrz7oLkxAvQFnInF+KTnp7K
         wvdg==
X-Gm-Message-State: AOJu0Ywo5qjze1zqFfSwZf1wCIsmHj4lHGpyJLINgaA69IPZzcgZkhKa
	Wg7YBrU/B4BbWWcz09M1Xx1A6po6scxD4QRVVmFPSU5vnurwlDPETQKmkODu1F1ARsWVlphr+pB
	4DOyuVf7ZzGFZ1vREWxTxzFEQmlw69AfvVwjp+kbaxVLe3kFtXoJFio7HPQ==
X-Gm-Gg: Acq92OE+xL8486GqO8GZwv8qRHcoT7Nc2/GhHU5ES9621mwPOjuh75Fl0zijglv/WTo
	4DxRjN2cMDpixgXNQA24AxPQq4To5jWYQb4C6keRQ7X1/XZsGzzGOCX4N/7fVCVg4g1A3/OgaRE
	UmFyha4OOMTrLaTRHvgdxA97r8GkFqQp5jvkn6/blsZIpfipWGU0KY1hV5MaHRIOxU4vRM17+0k
	uq15boAniFPm5gJwFrgFH2bZA5VplBLc++tChsREd+GE785RrCom9582EmVDmBdH6a1g2fZDB3l
	79eDp62Eu6oTKyuhdtX2p8m9JvlSlnUbddEGMkYFuPKYwd3DKbsHLXP+aonzTcPowy4fZWlrSpo
	DY131gyROcDlIZ1KUAdaEpHaMoUyCV70Kvanhv6HBw9+fdt+mcFDdsMY=
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr298884485e9.20.1779175055231;
        Tue, 19 May 2026 00:17:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr298884015e9.20.1779175054759;
        Tue, 19 May 2026 00:17:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm335599635e9.7.2026.05.19.00.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:17:34 -0700 (PDT)
Message-ID: <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
Date: Tue, 19 May 2026 09:17:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Jakub Kicinski <kuba@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
 <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
 <20260518142346.4c0903de@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260518142346.4c0903de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-289297-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6E5D578F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 11:23 PM, Jakub Kicinski wrote:
> On Sat, 16 May 2026 09:02:27 +0200 Fernando Fernandez Mancera wrote:
>>>> Oh sorry, I should have clarified it. ip netconf only shows/query them
>>>> but it cannot set them AFAICS.
>>>>
>>>> Usage: ip netconf show [ dev STRING ]  
>>>
>>> Oh, fun. anyway, you gotta find a better way. Or just give up on the
>>> selftest, the YNL hack is too ugly to live
>>>   
>>
>> Fair, let me see what I can do. Otherwise, Paolo as you requested the 
>> selftest, would it be acceptable for you to drop it given the situation? 
>> I looking for alternatives anyway :-)
> 
> Maybe extend iproute2 ?

Ideally I think extending iproute2 would be the better solution.
@Fernando: perhaps you could update the self-test accordingly, adding an
explicit check for the iproute subcommand. If `ip netconf set` is not
available skip the test, so that iproute2 patches could land later.

Does the above look feasible?

/P



