Return-Path: <netdev+bounces-291650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJGLHZp3FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:36:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 196565D440B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8260A300ACA3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F33DA7E5;
	Tue, 26 May 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbwQp925";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDMIVrut"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD33DD510
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791767; cv=none; b=GNcNVnZV4ZqzvhoNZwhGAZm4bkD+BDXlvt2An3Uns6pkn3dWQAyubnF/xfktV4uxJf9tVyy4JKjnDrBEjcZve8SagB7UgsmfwBYmtPgpsm2DDXTp6BYWuHgCyLb7cd4USE0iWuRXtbH3X0PyZuGnWMFsNlo2QJMWQyMra9K6ZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791767; c=relaxed/simple;
	bh=OP8gQgKmrgNl/Tv4qmsTuHrpVfsW/1y26zRhKFHkGG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrFmvWqtrJwizKgdY5SJ3HNS2waWXjp7nfIsCA7oyehk/XbU9LM/FIgpvySVKjCmuEeQIRt5gdA8UbiW8yGz+FruveNrzc1RhZwnL1vNrpmN4ZNdOOnT9zbbzwiHguLbXHOHdl4jCHYj/f23R+Dly8nbBKu2upJoMOiZBxVbRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbwQp925; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDMIVrut; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKCnyq8WGI8GQIs4WPayrwC5+jOUXUYoU+B/AmoRgVk=;
	b=QbwQp925ULu6JN0chtA0vQ8of61ehtY8FDbF40ne31t7PsRdOl3l4+H9kPU/yoy0+592z3
	qchSIy4zPDitFuUaE72DgSI2DLZ38w0gtPWpELFEO3YWiS9obpXtqEAr68Z8OyDnILtmnJ
	upjaNHu5YNNYFL4/CwFyDHjo/mW9ekk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-goaQVglBP5Kw06Cz-CYtFQ-1; Tue, 26 May 2026 06:36:02 -0400
X-MC-Unique: goaQVglBP5Kw06Cz-CYtFQ-1
X-Mimecast-MFC-AGG-ID: goaQVglBP5Kw06Cz-CYtFQ_1779791761
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490261c79fcso34569995e9.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779791761; x=1780396561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKCnyq8WGI8GQIs4WPayrwC5+jOUXUYoU+B/AmoRgVk=;
        b=ZDMIVrutucN6mbwTUaDtMHKp+DH5wAPKJsdXX+mruMw58Kg3Dd9M05zsXhMZTGJeul
         z1cMSjf+niOjJmf8yNGx8B5hUhzVbaJviq2T2S/4sswQyMPWi/GFHdMAE20ckxY9OZ15
         mRQ8EJ0GBXE6MEVdz5Wo7Ape2TbfAvJqFjlTqIfXWysYI14LIQUQEjqzgN0T8p6lBVYn
         LX8O1QPXYA8fC5rJJvdZ5I/FgXRhfcBv/CQ0rMZ7uhHabdILGdZvu27t0IHZCQ6qfznf
         2WLarjTmyfUb0WMqyMhkWYrZE9TmxY0oFIxDp2xawAiWs5gM++lUdAJfO+Clzz1B1SJ0
         4WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791761; x=1780396561;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKCnyq8WGI8GQIs4WPayrwC5+jOUXUYoU+B/AmoRgVk=;
        b=hBJF0jc7LDEQhYVD52F43S9MFOCW/FZHlEC3BmA4knJY3Iec05WIwPAlsJY4jbIiqz
         FdBk4qZNe4se06lIcQU+V2TFGhCMW18PuToDhAs5m1Ezm8vwkmlkLd+r3lbKKa//tVp8
         tDMtdBs+Tnr2JT/5d+s9zhOCPpX51efYYLZ+ajmgkV935wIEbDJRNwtUaiy/TYIjgIhe
         j98q0Jm8nMReXhvEDZ9QVQITxVMnJwNRk71W+ZFvYeFrsKSX91HdfpwBML/edqrDDaQ1
         h2zBq0ZcfMWt0VHC5ppLNt7S0PLy0sGaDlKzgFNbfQm0h8cjWeHQ8wU7PkJsyHsU948C
         mSHQ==
X-Gm-Message-State: AOJu0YwGYHfDIGOR0BuDox3ZCcUtwOhb30eoOZBqb+d+rhAPxF3ZjeLy
	0or50/iSLWzerxv64ugUFGtJu2eb07NkP7tOPorAWUJVGC6bm6m6vOgrLvwTTLKSj1ZS/KOb0i2
	/b4sgigLFR3tj/c47cGACuy1A4NdwayPbMxWPinLZxcfIOjpd/DkHPk2qvA==
X-Gm-Gg: Acq92OGQKdgTsZc+DFwm84PuAhB2f2ZFNzQHnGvrUu6mo9KxiupFQZnbQaB5r7Jnl0h
	0h8PAiL6grs2eWgY+UMyWFj8zV0EFbrmqw8B6CXWYDN2ORR1uzldXnq4FSHhZqZOxcF4/baNE/c
	06xBZJH1kC1o23sz9CsM6VAnbaktDC9LQyuupHVCLK8cjIG3JLORKq8CV8xbOKfFA2qLtej8BFO
	UOcKE9hMLb8yz1EcPBtDe3w1NIm8XD7LWAVbMtI0EQ5l/ImmfR/Ck5cz+gC4BsFVHV57Rk3gXzb
	N3wCHIttQUWnG0FBn9+6wEjhq9TxI5ElM76GHyg2pLNLwzB+6Fww7cYRWugosod1hpzGxJt4Xkr
	iGOFi6PRAAhOZsTkxU89vyDhUIyoFBFubnUmV/b58/n++uyfBMToMGkgmWD5x2RXYPHEJ
X-Received: by 2002:a05:600c:46d1:b0:490:3d3d:805a with SMTP id 5b1f17b1804b1-4903d3d823bmr305095795e9.12.1779791761375;
        Tue, 26 May 2026 03:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:490:3d3d:805a with SMTP id 5b1f17b1804b1-4903d3d823bmr305095295e9.12.1779791761010;
        Tue, 26 May 2026 03:36:01 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d49132sm34527634f8f.24.2026.05.26.03.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:36:00 -0700 (PDT)
Message-ID: <bc518fbc-5593-4084-b712-a5346367680c@redhat.com>
Date: Tue, 26 May 2026 12:35:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] netlabel: validate unlabeled mask attribute length
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260522054521.1169755-1-zhaochenguang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260522054521.1169755-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291650-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 196565D440B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 7:45 AM, Chenguang Zhao wrote:
> netlbl_unlabel_addrinfo_get() checked the address length
> but allowed shorter mask attributes to pass through to
> fixed-size address reads.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  netlbl_unlabel_addrinfo_get() only rejected a mask
>  length mismatch when the address attribute length
>  was also invalid.  A crafted Generic Netlink request
>  could therefore provide a valid IPv4/IPv6 address
>  attribute with a shorter mask attribute.
>  
>  NLA_BINARY policy lengths are maximum lengths,
>  not exact lengths, so the short mask can pass
>  policy validation.  The mask is later read as
>  a full struct in_addr or struct in6_addr.
>  Require both address and mask attributes to
>  have the exact expected size.

The above should be part of the commit message. Also this looks like a
fix that should target the 'net' tree and include a 'Fixes:' tag.

Thanks,

Paolo


