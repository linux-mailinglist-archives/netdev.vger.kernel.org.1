Return-Path: <netdev+bounces-279916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJx5LxeC5mkIxgEAu9opvQ
	(envelope-from <netdev+bounces-279916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84034336B7
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B7ED300D74F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0D3CAE7D;
	Mon, 20 Apr 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9BKgjEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85073B635A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714257; cv=none; b=LBWbUa6D2Q3GwpyW4XdLN/57+TkR4mnhzYvlPp1CxM4mbW/i/dGkZ95vboTAR6WnIRemWJZtZr+db44omJGOYT8L0eE6RxbOzKKEZ3exRvlatWvbcLKQ8TkfACG7ls+YamL0JuicxI1ryAwvdkSIcca3RfvDI/iQ297L9vq62T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714257; c=relaxed/simple;
	bh=SS4Yt3zFzImyyeOq4jcHWSPrcqDrkh4/v4ZlbJcO+xA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kxZNQH8mR6uX6IpqwEVK3PkdW0hOxpq8bUlB2UDggKdopnZlRq5ZTMmK7YzrSiHYocpQrLTEDfrnFhY/oL35F6rYNU1DSmKB4E1XNEushy8B0hOpxYw5X3mviUPylHAAlwBCNIJU+zn89j0QG8XIGOdM86sONny4Ewi9czB3q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9BKgjEf; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65318dafbcbso3259547d50.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714254; x=1777319054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=V9BKgjEfchSp8tkqQZ4moMzjp/rIHnE+icTZM29dJt6hR1Oi7LejriM3J8t8JT9zg2
         A4OPL3T1seoHqVeZi7yCFkfy873Cp5tzQq65wSVPJ/VhLoyAwIWKEpezU57qEJ8o6Nqr
         WMu1gmz2xnO3w8+JII+d/RFONcP52Iwdg3lFWvmO0vD6plHfwsnNY2NOiRmeUo4S/r4J
         YdtslDkp0UBuGd2rbVLlRkaTeW7C7TqM6DjsfE+UF53soDu3XJ/BmBnhIXPzPXqMxlNC
         h5P6nLSGo6WQ/uElOF1el+a3CBp9cl/BScFw6cYCxzUhcl0AhpDJBpZMYC1yAwDgjyDd
         qKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714254; x=1777319054;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=hQQZOF28mjYjo9j5bjvWGiU6Lk2kKjvTKjDTLtfGuyu1ZpIuZtSYqHuSD4/wfSWn5Y
         jl07DvRr6r2tjStAk5Cx4ESkLqPrOqOqR8aqAghfp3GDbhJEEXJA5daYDyyy9akvhust
         T4aX4EZnILLC4cBDeLBcsZPsOzlFmLoCLPDtrlRwbbCBYWwgxbrx/s20YpjNnq7G/l8x
         HYkyQJ9h0guS1ra0pLAmqakwMw6aPtf+qbLGZiiKjOWQ7+J8/ZlLmmQA2F3gBPF7rjxK
         aCYqCh8Q/QDsifk1k3CdBheaxBSm9HnAfquIBSmkjLBPOyeDzeKj0C3XxNB3+GIsrduk
         hIZg==
X-Forwarded-Encrypted: i=1; AFNElJ/Y0F6c0AFvtW2P3REct+SWETG7SUQEIkhzcFB5ylhaFMeZoX8EejKw0dH6Hxfrbfs6FKThkOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrieRAtMQPIVR+/qatlk22qfvyXZ8qI2fS1i2aKtscuAtsKeTg
	UyOaXJrZxUD8FB6Zv7JNcLkR4ZUXB9i+UbV2iR+mIEWmxLtsTCa7YjaE
X-Gm-Gg: AeBDieuhDEj/eNDKK9GE+NDI8iEXjOM7jJPzyahh9SdbRACa2aPsMoQhYh0FrRgCKJm
	3q1blxgTMt0eNIdTpMqKy3+G/m6l8HuPrpJGD4gcHDw4BFtI/4xMzVNVCj9EMtpg5H2FSdPPuFu
	63AzqnbsMcatol11JCSb0DOjFgDgSkXPdQVSk16DPVmnXpxvSsyZau2mMxoCjNL52B0vaMIDcy8
	S9xqd9fZC+E10BEDwR2b+I3BszQpWpgONyobnP129JVrgwBvdU3Yv9ioGAgjBfCaQzgvM6xNNpy
	jEyfa8EstPOCyaNbb64vknuTjVOv8Mdc5QzD4lUkzUcLVPF82E4u3zdQr+j8XmHgRoY75e3RXGp
	K6sngYC7yQ8K7wdnp8yiEhHffUzfUI/YyVQe+VofmmKMvV1hqj7xI9YiGCrplYofNscBTFMQxHn
	e9xeWMJFk8isBqMpaLJcKoPI+Ksj4Ec5MRddXrc1Gp6cR0Ur5VJEULEbzVTjfW0m4896RqMGj8h
	+zBNoaSPrg5j2A=
X-Received: by 2002:a05:690e:130e:b0:64e:bfdf:454 with SMTP id 956f58d0204a3-6531056e7bcmr14161558d50.0.1776714253941;
        Mon, 20 Apr 2026 12:44:13 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b63174sm5737205d50.6.2026.04.20.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:44:12 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:44:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.33c89b87c9822@gmail.com>
In-Reply-To: <20260420104051.1528843-4-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-4-nhudson@akamai.com>
Subject: Re: [PATCH v5 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279916-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A84034336B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add new bpf_skb_adjust_room() decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6
> 
> These flags let BPF programs describe which tunnel layer is being
> removed, so later changes can update tunnel-related GSO state
> accordingly during decapsulation.
> 
> This patch only introduces the UAPI flag definitions and helper
> documentation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

