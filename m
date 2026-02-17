Return-Path: <netdev+bounces-258995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHcyEYQ7lGntAgIAu9opvQ
	(envelope-from <netdev+bounces-258995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:57:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7C14A9A0
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179173004620
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35631A7F6;
	Tue, 17 Feb 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7SBYDCB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UU+6UbSo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF382E92A6
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322210; cv=none; b=UrREmkj9J6YZ7Ggqi+JQOEketulfsbw12/GHOED5uM1AoVL0vGrAw2mFBbGrgtgWhJlwOqUC1bj187bYkDjkCO59Ag34ZUwW7usYqYhdvTui4os36yuHNT/o+CAbwzgnKyvvFCd/wpnEIwm3p7qxWUxmkk6vnvzDPEv/K1ShmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322210; c=relaxed/simple;
	bh=eRcblvrd5cLZVFTkwCFagYaJ0w+paGvFCVQFJWoKhUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXWD9/e8hALIpq3vInNSmQQX8xhe0WY9WeKY4DM/Js41xgjAODRfhhqAl2SEnGSrh5T/5ivhFiqBIWY1m6Yzf5wLt5w6ynAyEeBLt3EJe7eT9LmbbTgnsHvO4v3agghjVYbxaEmu1qQnyIeIDsOB74klKl+Kbp99NSm53JBQqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7SBYDCB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UU+6UbSo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771322208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0BlC0sekasDq+Z3G0wuqwsYPHRJUXWfqPUd+DIRuUQ=;
	b=J7SBYDCBJczid8mVf0PDImVjkNwTs04JqpdpGTFgG0dOXl6cfnl5DTysazerqMXkec6iN3
	tjSW/t/Gqudr5HnEr+azWFVLRxHSkBKTRaXp4Un4aO6YPFapQ8VKtCmgVCzaINtzvWPCOX
	AC8lV/dtReC/19OkLIUAcfsBxf3RucE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-khGiDzGvPX-A1MBNCkjK6w-1; Tue, 17 Feb 2026 04:56:46 -0500
X-MC-Unique: khGiDzGvPX-A1MBNCkjK6w-1
X-Mimecast-MFC-AGG-ID: khGiDzGvPX-A1MBNCkjK6w_1771322206
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4376e25bb4dso4302067f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771322206; x=1771927006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0BlC0sekasDq+Z3G0wuqwsYPHRJUXWfqPUd+DIRuUQ=;
        b=UU+6UbSoTfHgMSolps8gM9sFbTxy321sIajY4MccSH0bXlCNQygwwKKEeq+DvVoDdP
         MU6IemNLdchTmv+zj/F+xWymKFLT7kEPD62P47kQbMOYVh8yMakvT4LjTpcdFluQ2MrF
         1eceLCfZn/yP+fVHIlNOzrXpodo/5rKx4Y9Hx9WWpTEPg7kkmUgYOLaGgvIIkaSaDtZD
         gD+GtrBzBpMF98ADCHUkcjA3q1t3HKTyN9Cfp9D8oydBlor1W9kU1m2gtC3WkYYTrWd5
         1egNzbC/DBA+uS06nJ+V165V48heJWHTPbDl5X3CAGcWsnBal7Q2PqTShhC8y7MXHgv2
         wS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771322206; x=1771927006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0BlC0sekasDq+Z3G0wuqwsYPHRJUXWfqPUd+DIRuUQ=;
        b=pi6SWAwAe44Ml2xncLntCIbjOQm3AvsxZfUfXZ4HUkF7XPvVRdLrUpxuBFEegtPu+x
         7/ygb48As9UexKMQD+iiB17Dqx4O19ZdpM4UAP/hEft44bM/zIPoeKbc4SepbjD/Zf/O
         BwJTvmDQD7wYCM8n5HlUIIPQ+OPQWHodyEjayWAYF1LBtDf8nlf6GBr7qWoV/WhKWrA4
         F8en1j7XfcFE+pZVCv0cKhhXyTU6/upGhfSM64u1Dr8dhVjKRmoNdJqHwdDdM2690pkO
         dssyOMR6Kjx+s7lo5IQ6eMhJIKpbyFBWIhcigdAhoz/ODcMmRs7k5lGdqfHqBniUwsGD
         2ySA==
X-Forwarded-Encrypted: i=1; AJvYcCURCG0L8z31U3UdZ/MWc3qyhJD4n+rW3o/Zc8S4EXc8kt1q4qLEX+YDt8RGitv6cxOHPY8+4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAzDIYnB2x6xM0QcEr1/RUFla3BgJ8gBFcG7wP/68JsHUPs4U
	XzS/B2PigxxcN2wxqmatrQxVVEbyd5n3EC4tGcQdBZ3k2jlZeUYXjI1roaVBMFHa/P55f4t/6+v
	7FkMDHt5BaV5AP+iEtxPktlD6wfP91mR4jaE/Mf9+1DvwtpAM8mnd2+Pfqw==
X-Gm-Gg: AZuq6aIWerdWsy/EAJUC/khkICLgZYT+YFLtW2LLMPh7QpowpZ2HNNB0Q18ASXml2ej
	xdiuDsErNBX7apFm0xeTQ2eOZ0hsjEQ8FEMX2iD7FOr9WsGSGfuIVto6w7swpUwmpSGLa+Mp+qo
	PoCwBeer+VeI3vvR1gxqnmMG3rHuJvWklWCiahu4TZVTyGPdoE++D2/wHguz+DbyPdHNiIBnwd9
	YJ//98lf6F3L/R4oriMsOJiqH+xAfXxUVYHa29qPU0yEPRwUjh1s0KQlDlXiBtQea9fxm14LZbA
	UmwCaslwU/LGGvcvk3uAbwMLlktOFWn4NW8A6JHq88tJpVfkrE17juU4HsE/4tA/1TnTwgt4yzg
	oFxv4cM1pEjpimQv1M7VVHFE/6Q==
X-Received: by 2002:a05:6000:40ce:b0:437:6758:ce7d with SMTP id ffacd0b85a97d-43796ac213amr24548990f8f.24.1771322205617;
        Tue, 17 Feb 2026 01:56:45 -0800 (PST)
X-Received: by 2002:a05:6000:40ce:b0:437:6758:ce7d with SMTP id ffacd0b85a97d-43796ac213amr24548945f8f.24.1771322205125;
        Tue, 17 Feb 2026 01:56:45 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm32429601f8f.29.2026.02.17.01.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:56:44 -0800 (PST)
Message-ID: <4e07f6b8-5225-46e0-b3ac-d02495392835@redhat.com>
Date: Tue, 17 Feb 2026 10:56:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net v1 1/2] octeon_ep: avoid compiler and IQ/OQ
 reordering
To: Vimlesh Kumar <vimleshk@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Satananda Burla <sburla@marvell.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>
References: <20260212121634.360252-1-vimleshk@marvell.com>
 <20260212121634.360252-2-vimleshk@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212121634.360252-2-vimleshk@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258995-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DF7C14A9A0
X-Rspamd-Action: no action

On 2/12/26 1:16 PM, Vimlesh Kumar wrote:
> Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
> variable access to prevent compiler optimization and reordering.

You must include into the commit message a more detalied description of
what could possibly go wrong and way. Also why wmb/rmb are not enough?

AFAICS this is the only driver requiring such annotations to cooperate
with the H/W and/or the firmware.

> Additionally, ensure IO queue OUT/IN_CNT registers are flushed
> by performing a read-back after writing.
> 
> Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion,
> and replace napi_complete with napi_complete_done.

This looks like a separate change, and again requires a more complete
explaination of what could possibly go wrong and why.

/P


