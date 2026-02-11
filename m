Return-Path: <netdev+bounces-258212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7hVdI+k3jGkRjgAAu9opvQ
	(envelope-from <netdev+bounces-258212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:03:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F004E121FFC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF9B73011A68
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAB2F6574;
	Wed, 11 Feb 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY/SlWFO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU8Bt7za"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37B21C16E
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797028; cv=none; b=UhRU4CveBbxLDNFCLJHMc4khyU3hZ/qgQONy2TI+XFrOm/vgf9DnrqoOEseGgzr6yO6GzM22+amrBoIEAII9onru8sSvNcqJhIA95IEHD3b5tBf8JkSLuFRYaGFj3vhJA+cmimi1pRQlAtnEyg+HplV07qJB27MjmYP3Fbw/B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797028; c=relaxed/simple;
	bh=XhmUQvKrnFLzFv58aladTBg92zWRwn29QmYQLVQQdKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPJDLFk3OTuJDSltO0GeK7cpOGA9EqdOKBsqqv2/vNbswXE02/c3YKd3F1eDeHKwKOVXS0v1fXupFh+LToQRMIqzMYQpud001toM+9Aph6wxiWWmKHKQmbUd75tRu71TXYtTYDU+Paq+m6D/vAvOLOVr484dizpRLpE7t62y/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY/SlWFO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU8Bt7za; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770797026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXSzHCNlggSpaEU4Cd9wo0z0BNEV6ELigy6booHOajs=;
	b=SY/SlWFOCbL2ldg62CYHG78nx+WsQyvSTcg5QGMd5nz6tZlSkNMVodzEI9KEsePdkIEdxW
	3aP7q4ZaCC1qLvbzbAfFGdlED1BXxSOVkPUi/ZSG5osuxwYA3NSr75/oif5ds6jiGcig8w
	d/amKwMAnlT+ZM+zJkx5r8gsNE1HtJA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-BzeuZsa3MxOlI1RowMc6UQ-1; Wed, 11 Feb 2026 03:03:45 -0500
X-MC-Unique: BzeuZsa3MxOlI1RowMc6UQ-1
X-Mimecast-MFC-AGG-ID: BzeuZsa3MxOlI1RowMc6UQ_1770797024
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480711d09f1so26582715e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 00:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770797024; x=1771401824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXSzHCNlggSpaEU4Cd9wo0z0BNEV6ELigy6booHOajs=;
        b=hU8Bt7zaHxAvWQGg4I4KXq0b2h5IHuWTghosuc7Ncmf+6ZHuxoMnniHgFNARXVQlOM
         0/rA2PBTwBjbvJYbvg8S6g9O2eX/FHUoQ4xmPZ/VuXHitvsJTGshgb5Ns/FAkv+asKFj
         AeTO+EtKtIU96f20UuxDcuRb2mez1U9AxAz5y47lwjobtiXjFYEC8bWVeV4YPLQRBnl/
         2e30vkghnyAh2z+wWuELq40F0SJxw559S8hpqR5c7rVovdI4lX6mhKhHZU+ZRf30soqd
         f6YWd7pWHGSwc+6GVj00+m+adZ2Cw2ZmUULZPpUVzfCYJxphBXsoDpN1bAHls09Bj4Gz
         uGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770797024; x=1771401824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXSzHCNlggSpaEU4Cd9wo0z0BNEV6ELigy6booHOajs=;
        b=KBPKfkVdyhxZpft4kKiy18uUDYs2DAxBJoHwkJSlYpRALja3A7njWGvYG9sJbQtNF/
         y+3YHXahvYBp/Yk+kv9JsGA4fmJPyLnM+5XeBtSE1ja0YIelblniW5iiHBw3DJ3LoKS9
         Srp7uzriQWfLCGtg7Mfkvzc7A5+9iXjJ5oQ0mGsocvb2JJUQgc7FpNSwiB+ABHJUTsdE
         1V5gDZ2rCG5CZyBo5JbK+WaG/5WC5fJVS3MbUlMESfXzajFDjDLEluGAtmrfKVB0Uh3H
         jnCMjl28vYo7XbjpSf8gR+EXKKNllxXzAekyRtL0j8tRa2KoTHfZMD6rIJC/0x5K8adb
         AWWw==
X-Gm-Message-State: AOJu0YwlOYBIRx8AUDycbEDLZS/dWLFMdrLQbxK3Enpwu0BU58+JpQnw
	Ql6NbZd5ZgvSYxqUOu+DuUkpKiP5cGOFSXdSLSaf0uftgvb7yl0EEtBt/HmBTs5ySJR6fSc+uP/
	b4Sd0TIduyu3/yKqH6n79ASTRsIWYYD6qYjNovN9fFIgsSnDgIlONzz9LOg==
X-Gm-Gg: AZuq6aLVFRn7Of6X8a0X+sSoq+nNcsJW3rurfgwzseAE0tpQJ6dMiIEJcpWWfNYzpzH
	4ekHorPzQUL9gLLS0lww08u2dQrM6Gxgx6e2UZvvprqxUBxh4X0UNk8BtoWtqhynhGGQ9dB9LjE
	ZxpoNrN5+E2ZwDN7jggs+FZmVifYklglwHtMp30cCQPJgn0JoH4BxR3Bmg66uVEVNx663WfDJh3
	rkMi9n/gIFB+cnswd9IAREOZU6gmDQXAb1hO/Kh6NJPqm7hnyPeDKf0pMCwrP9cgox6vPrm77VL
	a7Z3ZTthE2gOL+ZqvlZINwuaHJDmh0TS44WSjzVMxvDzffrYe47eo7hQ9HQrIb2ICqANo2ADDDU
	89mrNgD4XlCKU4fXgTLSyUR089w==
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-483201dd216mr236652475e9.1.1770797024333;
        Wed, 11 Feb 2026 00:03:44 -0800 (PST)
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-483201dd216mr236651935e9.1.1770797023873;
        Wed, 11 Feb 2026 00:03:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba7926dsm11919045e9.12.2026.02.11.00.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:03:43 -0800 (PST)
Message-ID: <ec02262e-0215-4edb-8352-ee052f3e974a@redhat.com>
Date: Wed, 11 Feb 2026 09:03:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260206-fix-offloading-statemachine-v3-1-07bfba07d03e@renesas.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260206-fix-offloading-statemachine-v3-1-07bfba07d03e@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258212-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F004E121FFC
X-Rspamd-Action: no action

On 2/6/26 2:41 PM, Michael Dege wrote:
> A change of the port state of one port, caused the state of another
> port to change. This behvior was unintended.
> 
> Fixes: b7502b1043de ("net: renesas: rswitch: add offloading for L2 switching")
> 

You should not have inserted an empty line above. I'll fix it while
applying the patch, but please have a better look at the process
documentation.

/P


