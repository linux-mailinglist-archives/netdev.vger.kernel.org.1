Return-Path: <netdev+bounces-280067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DMPNgpK52lW6QEAu9opvQ
	(envelope-from <netdev+bounces-280067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE1439372
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0823014BC2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B93AF670;
	Tue, 21 Apr 2026 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeViz+DS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p9YqY3cK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDED2472AA
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765170; cv=none; b=NXMxs2PoUKCnBxOyEAUGay+UyXDsvdRRbpA9Ea5gyGGhHKKs39at5lTfR1Ada7m3AjobxCmTC1ySm6DRjB4m6VMmG6ytHcWH3y4AXro7CwHH6Bl3MEGg0fLGHF1gXrrRuau7OQJneYQjjo22c7GCcBHG4TnD4ZwHQLEjJz0Jf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765170; c=relaxed/simple;
	bh=slA0K3Q0i7F6r3lyrTCBc+XgmVzz5A7P+SZSVT5xYcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swE0zEYjOLnMTVi2JzZkXX41T6vdOpGksghMAfBvzRVU8SDin0GxB5vY/N+a2vQY+GiLAJG1A6mmpR9ogaMGAg/d+NFjxntH+j/PaAutmoQIMr8UxOYLgnWBAK//rzzUZrZev2T2r8Iv73YJIczrdn8PFUnsiVIdX9xUu5ACaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeViz+DS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p9YqY3cK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776765167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVqREod6HTBPHp6mkmRIbmc7vUzvQxPVwYuXLRxBU/A=;
	b=XeViz+DSQx3G9yO9scIKV6637eJjGvnd21hOWgkfMZ9aoEZCEKfpXRxD5TPbHGLSreh+rR
	TbeNMVBsgNvW7JOk3xGgCIHpNTEJOjWasx/mc4TRGTeJF7NRme4TuBW+TzAwkFpaJc3RGs
	xQEDEmYr/VbAmxHP2UZFgtPpkmmM/2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Zrf0HorDPdiy0SfnIZb4IA-1; Tue, 21 Apr 2026 05:52:46 -0400
X-MC-Unique: Zrf0HorDPdiy0SfnIZb4IA-1
X-Mimecast-MFC-AGG-ID: Zrf0HorDPdiy0SfnIZb4IA_1776765165
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43ff0eb2b2aso1669889f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776765165; x=1777369965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVqREod6HTBPHp6mkmRIbmc7vUzvQxPVwYuXLRxBU/A=;
        b=p9YqY3cK2UGuYdcdETcF6osBh9ylYkxgv2fPR9qbjx06MuRtx7S1fLj/XIUPRWAVZS
         qbdMWYOdyOXLE6iqJBtgMxeYPt4EitVsOUOLZWF+GP2RpYFqCZuFdvaHyQGaPsbDHle3
         Fccnpu6uJyssG3e1tjZ4sFsdfVvIdA/Di6HRNAJn2eMfI91PQodmF33AkYl79LuereCO
         FUmK3FH7Lg5n6ndLOWTbGkhKWZ5ZkFE/wm9rIDuFJ4nS6tC8OyougmS4gqXb/Qg8nUas
         ravuP4THNfng+temIFv098So2wuwGBeO97/FmDHk9pzE3lqS8UiQLf78GfW2ecjiZJ80
         N/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765165; x=1777369965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVqREod6HTBPHp6mkmRIbmc7vUzvQxPVwYuXLRxBU/A=;
        b=IcYZjeBHNLJVamj5s2q9rXEQHJYL7lMVWrXt8S//qHtCMaWAX3Eqe9WmwQB+NnOeNV
         WdMA/U2T7Kmd48YmUoAZRPkuxBcXeuv2T1+kMR062fRzyJkZRRv0f3QW7zj2P9aN04cl
         nEzxCwHC98ByCsx5wlZIlwHCFoo7XygVWIWiL8NlllS4nNUS+mZ5u458ZU1L534e9gL5
         kIUMT5ZDqtyoeOkJ8SNdwExzQnyLv8uZWVYQqQHPXofUjeQuy8ElNAyQxY3BiKqPtTvP
         ml7jolYu+gd4p7MKufwlshNO23PwFr052rMeDKPrpsiTUkOuh8/jfN2UsrASH+V9EdY4
         eQOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+reRtxXPr8Xdmwbo+lTbcTCuadvPUlroE1dZMJx3tTeSQVDyUQYIpdliFI1F339bzkpXifquI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgK2TAkIR2inphsY76N8YGG8IwwS8VNXgW1fmSM5bIwqD3sUZH
	zjUBSbPptQlkRDt3vewHYN7pvCtd+fFdPN3t+ZQIrw/ljPTIPgbg65wJ63RbZh0a8CE4CgSkMIr
	y2O7mn+WPIZWDNEZLyFYG+Ao2+3rDndBVi1YRPZ/vES82r9Rj/b4eMrwBrg==
X-Gm-Gg: AeBDietdOAgGW7z8Yxb5BqAK8mmr5CtgGttzY6XYEWhQGytJTY9QhxvV3/M/td7OGHA
	8Hn0i9zr4tHGfXfhpQZFdl0SaXznlgQO/NTToTEBoT2MDsVANOF7ImxV1Y0P5vsv362Rn6bDBbA
	+A32y1R8BaKlw3P0K6gAjx4L7ZbbfCWPDy4hwTMg2DfbpTBEUuT3vPPAv7UW9s4/83kpiGItPjS
	aSJHWndfAFPAQ0PSBouGRet0FLpqiUrMdrC34OAO3l1J08Dmoy3BA1YP40DB7Qx2QcAQy62HpXr
	CqAtUHCRVSubVzpU2bnvUp0ed5egbefteIvTip7+vFMgoRSnrdR05un34RNQWUMS4FJZSlQ/RP8
	ShjrbOAR7RXjnqoQ7FBBcJruchWLx0ai7kYcIemTFdISOnuvOPHG1runv1mxY2hM04Kc=
X-Received: by 2002:adf:f344:0:b0:43e:aa43:24d with SMTP id ffacd0b85a97d-43fe3dc5832mr15712090f8f.6.1776765164841;
        Tue, 21 Apr 2026 02:52:44 -0700 (PDT)
X-Received: by 2002:adf:f344:0:b0:43e:aa43:24d with SMTP id ffacd0b85a97d-43fe3dc5832mr15712062f8f.6.1776765164390;
        Tue, 21 Apr 2026 02:52:44 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm40238551f8f.6.2026.04.21.02.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:52:43 -0700 (PDT)
Message-ID: <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
Date: Tue, 21 Apr 2026 11:52:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 03/15] net: cache snapshot entries for
 ndo_set_rx_mode_async
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-4-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416185712.2155425-4-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280067-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 3DCE1439372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 8:57 PM, Stanislav Fomichev wrote:
> Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
> allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
> reuse previously allocated entries instead of hitting GFP_ATOMIC on
> every snapshot cycle.
> 
> snapshot pops entries from the cache when available, falling back to
> __hw_addr_create(). reconcile splices both snapshot lists back into
> the cache via __hw_addr_splice(). The cache is flushed in
> free_netdev().
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> (cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)

Are you backporting from 7.2 via time machine??? :-P

> @@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>  		}
>  	}
>  
> -	__hw_addr_flush(work);
> -	__hw_addr_flush(ref);
> +	__hw_addr_splice(cache, work);
> +	__hw_addr_splice(cache, ref);

I think here sashiko has a point, with the cache size being unbounded. I
guess syzkaller or the like will find a way to make it grow too much.

What about hard-limit it to some reasonable value?!?

/P


