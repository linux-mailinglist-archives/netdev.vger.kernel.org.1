Return-Path: <netdev+bounces-271010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO6HEf13wmlsdQQAu9opvQ
	(envelope-from <netdev+bounces-271010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0C3076FA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D29330156C3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8936654C;
	Tue, 24 Mar 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWnvACga";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTUSXM3m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF13E2755
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352003; cv=none; b=BiuiVgW/3lLA/lutIaBYepGdeklLisCvUBMTIl1n1qHfOlr8YPKIMlEFRC+vUahWrTDEVHX9uqOF0vZUAiT+tvDbr/SIXk955pEy07K6T96wVYAhH2i8EJie9CGySf2+lEpDXe+NA6eFpyHD3whJUQPLajow2S9ieodkwAOK2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352003; c=relaxed/simple;
	bh=U1ZZDVReoS4K1/ku/u4YW9Z0Zpv2ym5Ik+pHIY0KxUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCUGCukZVQfU57N8Has/kyoBbSCuIRo7tk7fTc6sYWSgMK1E7ouNBpKG+fbXgHOza0+yAh3TLF9I2T9YKNvgjDoJUYk1FjNI80YA86r4j1dVlYUeLZDPs2etRqDccFU5xcasf/QtsiClZ9NwWVX3tjZVKDY4apvOxcfYaScoluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWnvACga; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTUSXM3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774352000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLnAmNwXOpjUu2Gs2/JZiRxrt0ub2jGE+o4ZOrH4niM=;
	b=RWnvACgaKKohYQzyr9N6tj40UqTAAV5J76TEuWNRhp3dQA1zDoPdlGUmNnJNnQ4ige8AHl
	cBO5OukFErce2CNlaebLimz3s5bNQCCJ16Po4lGHjieUhQ5q1c9AFcOZo4gK/POG5xrLNG
	VX/fE6/8nx4lq03zI16/vOnhQs++xoE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249--Lk1w_LbMpKiCpqJmPOmYQ-1; Tue, 24 Mar 2026 07:33:19 -0400
X-MC-Unique: -Lk1w_LbMpKiCpqJmPOmYQ-1
X-Mimecast-MFC-AGG-ID: -Lk1w_LbMpKiCpqJmPOmYQ_1774351998
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48378df3469so46549835e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774351998; x=1774956798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLnAmNwXOpjUu2Gs2/JZiRxrt0ub2jGE+o4ZOrH4niM=;
        b=jTUSXM3mt7d8VzWi5s2koooCfckDonVd595cboiRf96aTuLvN9HD0VKZVoCHuxBzfm
         BLibd7AXbYxZu1SnIkqKqTcnBnLzUZEEG1Em6Jz0KzwjF1gCkfxI212AEYUgCUWlo6eG
         Vn/pac5rH5yMU1io2CT0d11eSluudqS+F9sZtISCBjppX93CUL/NEK/BSCwdQQnbfgfa
         FARFIOlaCSOOm/gQGxhsCCXpwL/0HCV3OqZc2BJhGvhwaszk8669TEC3NirXXfJa3JWl
         pJx/2I0Vu0NmrxzXb4l+5ZG6RPQuZCcycnX/Q9n6LWKoEnCg1QUL86QMN+tam5fMY373
         pFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774351998; x=1774956798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLnAmNwXOpjUu2Gs2/JZiRxrt0ub2jGE+o4ZOrH4niM=;
        b=nvjrXKM3oGaIfGXhvfMYqCkYGgwF3a0Firo6RaqHntjMkSUD6LYI75myt5yddJkG/E
         SoE0VE0hpf7oXXGyLN8B3KwbibWNQt6a1ARNt5YnDxKngz4r+ooOMfHitSA46VMzUkxo
         EXNyZ0hy7RHu6tDyk4FqcDMGJsPTuGmz6Qcy7spSJmy2oIJT+F3cibAt0kOD8hm+UiQA
         clJXhgGflL4KvXMFi8wbtvhrIz77X8Y4hEhSXM/+ifI/SNQPzLPlyFcCmMcRBPmMOAlN
         LU8vTm7u+TutSmGQRG2/yia2BzKYVBZ0R5odszwbDwd6QdwW4t+36oCt4K64y/KJxmgS
         A9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzulxHptBtIedvA9WpPYkZofz5GwBLS/1hwlJNpfd27DfS9/TWxb0mqDsYBDPjo9SzoGmbms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+GWYLPzbXBLo6kAqTgZePuY1TVJ2eOir20VIWZ9zCoq4yDmi
	qHU0IQOE/tL5UXtXaUscwpvVeTUkpmuSAFEIDVm3mhdbua1xwINi2noHIb+TgB2nm054Mxzu491
	dvb4GPjX0ntVTdv02edKoTC4RXTIpIZgW0Aot/Exf4lZDKrfF/9+pWWpvlg==
X-Gm-Gg: ATEYQzxUw2dsn1Ri0K5fSKF3RIu1E+nd9IzClo2hBJdYD+DPZD92Pwg4B01LFHmVXs0
	/ReiTdd77V0R7CRyQntOB3TKl0zFB5URD+1hpYsnpEj+Kc4ED705CHDtCwI/mzK/PQ9btMQcYmb
	GFQv470346GYc7xkJ0XIRunEI3Q940PjnsOhMb2N4oeGgFb+2hvGRQ8s/YdlCW44+KJhb45IfTN
	9B2/T1Z4BPcRUDh3oET8Mn4O8TYXOv2gKU6exa3Lf13kShjxcOfRmwEH+NkiCj74wEKRoNfTeKm
	w3vaxvthh5yP1WBtxxwdhhrTbinE5mf9wGSTyCE9wZ0NyYkTZQIrNLNguILQbLPfjlFGRnQAYSh
	7Tim1VanVPgTauKhYnZbHVcGsXu2OkUU1EFudI1Xa+2Qf9drSjzBPEhnY
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4870f212c1emr44835095e9.13.1774351997679;
        Tue, 24 Mar 2026 04:33:17 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4870f212c1emr44834735e9.13.1774351997263;
        Tue, 24 Mar 2026 04:33:17 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm48568595e9.2.2026.03.24.04.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:33:16 -0700 (PDT)
Message-ID: <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
Date: Tue, 24 Mar 2026 12:33:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone
 setup
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
 <20260323083440.2741292-21-steffen.klassert@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260323083440.2741292-21-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271010-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4D0C3076FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 9:34 AM, Steffen Klassert wrote:
> From: Paul Moses <p@1g4.org>
> 
> iptfs_clone_state() stores x->mode_data before allocating the reorder
> window. If that allocation fails, the code frees the cloned state and
> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> 
> The xfrm clone unwind later runs destroy_state() through x->mode_data,
> so the failed clone path tears down IPTFS state that clone_state()
> already freed.
> 
> Keep the cloned IPTFS state private until all allocations succeed so
> failed clones leave x->mode_data unset. The destroy path already
> handles a NULL mode_data pointer.
> 
> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

While applying this series to verify the PR, I get the following error:

Applying: xfrm: iptfs: only publish mode_data after clone setup
error: sha1 information is lacking or useless (net/xfrm/xfrm_iptfs.c).
error: could not build fake ancestor
Patch failed at 0020 xfrm: iptfs: only publish mode_data after clone setup

The above also prevents the CI from testing the series. Steffen, could
you please have a look? Possibly a repost could be needed.

Thanks,

Paolo


