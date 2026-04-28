Return-Path: <netdev+bounces-281877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFrDFIe28GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC6485DC1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 643C0312BBA0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D82B43CEDB;
	Tue, 28 Apr 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AR3+wxS3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzcBCKCf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCD43CEFD
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382294; cv=none; b=o0n0cX7lXFjmxmp+W54WTpdiB6sbEc22skPNvDvwGLxdXlkgmnQTjhxdkzhEN7eX18tdgpLV5S2PVQlN9oL0iByBzQ1k/HToncfvyptRB9etMXW/aES62pJ7zKOGFLg4zzQybSspPeyPyhJxdMxuHDvYBkgWic70glxLxsonNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382294; c=relaxed/simple;
	bh=GhY3FksqwFDvPBV5sg0GBgUrwnJg+z9AjdtiOlcITa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyMg5+jaNAATe41wMLJnnzqP6kjLsiIIei3x1E56xLjEafhX/WoouwmMqMsdfoHfo1uedq1h1Wvq5RUMmZz0xnAY8daNhAWSmHSgBfrF0wlSwK8lmPW/B5KNNwKpEAoLL1LVQ2OS+3Nzr+QgUFj+dMyM+x3HrQz51O6dzC9CX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AR3+wxS3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzcBCKCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
	b=AR3+wxS3EjxbY/vwrMgFLbF19Bd0sKB4cYv4D1Tf1ZWEomWm9gw7x0jgBkVEiv+zmQXUEw
	tkokLLqABRADYMCXEMygYO04FP1iH+Er8YC5AROZZzajrT1Ie+s3jkkd/mLArT1eejHOhS
	y7AYjmdD9hrNOzvwzJsvj4DZTF/ricQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-yHQlLm8WPM2QXNzl6BqPqg-1; Tue, 28 Apr 2026 09:18:06 -0400
X-MC-Unique: yHQlLm8WPM2QXNzl6BqPqg-1
X-Mimecast-MFC-AGG-ID: yHQlLm8WPM2QXNzl6BqPqg_1777382286
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d780757eeso7585732f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382285; x=1777987085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
        b=DzcBCKCfD5BT5eD5auT3BBHxxdPFcIg7ivEuNcs2/+eRGAuBUpNx1OC9WS63U7HXY6
         icHzzwVGjz8wX+UI9YXNDjsEmkLPCcNffdfJSoPn9y8kjNPHVWqIOfLyzmJQxBnKZt96
         pgC+N91PpO9Q9L5le5EpCce40Ji+e+Gjb1jkklw50vaEU/kTjxYSaDny1SMGvOA0gAPs
         tL7kYgm08rbYuB3Kln1+nBsCCEoQRDBNe2w8yg9MORnCHnUDGQIUc/ZNdvGE0HHV/2AG
         FTKm2SA8eXKnuKA4b8a0CWbJXuModyuS0vQEY+0CIgG4ehzIzHOqDCypgsF5KwEsC8MJ
         2Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382285; x=1777987085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
        b=X1ExW5alywlNsFj04mBOW5CGQ/fo0TkQIPsoEqVLnNeSGur2UxXmBNvV6Cigeln9Kg
         6SgsYiVBfUHF1LbooFUt31jWg6I+ky/Z41JIWIx6z0nMaXeo7TyofootmPHi5E4wbRMV
         B3Lw/x1hLQ9REF3uP/ov8f/0WQIwdcZ8N3bhHT3l9vjFEnuK1ZglgSLxLfFXC+VvP+rf
         /ZQmAB3AU7uEtIxyZQ8E/Wtz3lxAbGmZdFwWqNFLl/c+lHzDf6BhSlMkNOXensvdMQFQ
         xFfzFDFqnL7fWOwRz+eP41f9LOgrilERfchuK3Fez0DFrPVmyBu4c1OQQfPq9TesteKK
         cWOw==
X-Forwarded-Encrypted: i=1; AFNElJ/zLu9/l2A4P1e/9kYzP3C/x365C36tobDqsyJemTa9Ng9rRc9nGAR5WeMWpD1kK0WvKMGbGNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7K9INheyWwvS3Fc9jByH00Ir8nut1QngCX3+dqX/MKZniTTc
	wBU/w7gsh62HaCvmza7rtz96onxx7DXTskJgmIxVS3AO8ymq65tBBrJ5YAPW3bPbQExD+8N+K4v
	bAc7lwQm2Wk4Qr63CUjlNYuAZD0nAA0BM+ubz7qvfqVELBPhQlsgJl7VEcA==
X-Gm-Gg: AeBDietF41f0FHKxtpfHURlEXQiMPPF27MVIoNP67Lp6W+sl09VZYa/n90OzmRfJfcZ
	V/UGFMOyXIQu550Mipsdvj6x2F2j/FFVLPN0LnQzauu3LlqBiPtdti0c9Rv4Vw/WAjtUEH2G5lk
	VopgSTbrzwcFXpboaoIhkDZWlQIxlKGAkTLZ/DcDtXS0Yb+wyLSqDje3o+OiNVyGvz6zH1koLUt
	kGjNBx4xCr1Ap4Buml70imZamFTF0AN9ysjNNuNohimR1tiFRUWaQow+Xb2avbmUg3YZQLj8hM8
	l+8Zop8PX2/gSetgMjAS3oy3V94PtZi/mEW/p50KZ3clA+DAY1AEWfMDPptMFidQ1v3wslSCBrc
	alTVTH6bGE2wpACP3bYc+9BNUxCXwFsYu2/cfbeoFOJk5yZzEejv7FsisrzCSee4X5A==
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-44652b863a5mr3564958f8f.31.1777382285448;
        Tue, 28 Apr 2026 06:18:05 -0700 (PDT)
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-44652b863a5mr3564924f8f.31.1777382284851;
        Tue, 28 Apr 2026 06:18:04 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fb7e366sm6197707f8f.31.2026.04.28.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:18:04 -0700 (PDT)
Message-ID: <b1fa683c-31e0-49f8-b1ca-bd921555aa55@redhat.com>
Date: Tue, 28 Apr 2026 15:18:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260424053816.27965-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E7AC6485DC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281877-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]

On 4/24/26 7:38 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In unaligned mode the chunk
> offset is encoded in bits 48-63 of the descriptor address
> (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Fix this by handling the 32-bit case in the destructor_arg helpers:
> 
> - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
>   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
>   address. Leave num_descs as 0 (zalloc) so that the subsequent
>   xsk_inc_num_desc() brings it to the correct count of 1.
> 
> - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
>   when destructor_arg is NULL (not yet set), false when it points to
>   an xsk_addrs struct.
> 
> - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
>   before touching any other skb fields; on failure return early so
>   the skb destructor is never changed from sock_wfree.
> 
> The existing xsk_consume_skb() already handles 32-bit correctly after
> these changes: xsk_skb_destructor_is_addr() returns false for any
> allocated xsk_addrs, so the kmem_cache_free path is always taken.
> 
> The overhead is one extra kmem_cache_zalloc per first descriptor on
> 32-bit only; 64-bit builds are completely unchanged.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

LGTM, but waiting a bit more for Magnus, Maciej or Stan's ack.

/P


