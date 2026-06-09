Return-Path: <netdev+bounces-297031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UmrwD6EBKGp87AIAu9opvQ
	(envelope-from <netdev+bounces-297031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A348765FD7A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KNF3HzKS;
	dkim=pass header.d=redhat.com header.s=google header.b=tlfhyqQW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297031-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86F303051A68
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6440BCC8;
	Tue,  9 Jun 2026 12:03:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C740BCCD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:03:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006595; cv=none; b=sU2BEC1C6+umJ/CFcwLn1dIsPdK++Sb/x9YSRHFhAauQ2tZiZoichdnz4oo+RDLx5UG6Hz3DuthCN53p2gExCRPjen7bIMcTQZ/Za+TLfoy2bJrT6oSrU5Ox9iSG3ZNaB9s1QYG4vuDmzKJJ6S6iWh7efpJKTvuBH1njImzsQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006595; c=relaxed/simple;
	bh=KYOKqzvxVdLkyqmcf60b2kuYcjBVPIadLaEpXbLdVdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMs7HAgXKCu5K4xBquM950CSMG5r6mdonpIdNS39xHYS3Kzov/MRkm3zUc2ExNIb9YSE9lBE8tyoXsTib1rfm1pThzAMVfBrB6ChnCQ0sCMPq0YUpHhbp0RO8Lc2REFm1wg18im0iwh1NHc6/CoQ05UIVmExtRYj0kHFas0A9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNF3HzKS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tlfhyqQW; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
	b=KNF3HzKSuuSTnGKvN1G7Hc7OXy8VmINhOo2qlPjJPrP6O222wiOt1vCUfYxLP3zLYIDz5H
	e9nMGUqWdtiEa6ui54sDLI7X4Ayq0bonB7+1JV4BBKsundg57bsy1v28NFvBOnVkvv3f0n
	VAJoTqpQC/3WmMzFoLgX/DzCT0WIHcE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-ZyBzQWHlNICpTmj81WHZnQ-1; Tue, 09 Jun 2026 08:03:12 -0400
X-MC-Unique: ZyBzQWHlNICpTmj81WHZnQ-1
X-Mimecast-MFC-AGG-ID: ZyBzQWHlNICpTmj81WHZnQ_1781006591
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso25260905e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781006591; x=1781611391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
        b=tlfhyqQWgfBLsrnYXzEPzFm1+hWn6NRBk2wRtmGLmwrwHi2A5ud36FrGLjmdkmCc7t
         YLnMQtyKh1mSsZMuI1ENK6tf+itPvRW332Ln43HWTOvPntR2lsJLydAC0Od5kLsd02qs
         Caa1bm2oEF/w0JhvzxqTjblWktq1XktegFrGTeEzVYfp5pgHg6uY4OAVR4W+GadHpnUz
         laoVfV/XueNMKMbi4TEjKzW2XeCfbey55jil9RfHEzt1QREvb8EOLBLmYCW8v5s80BDc
         XRQg7qErpNAR67HvN36wMBMUFJgpfIWtLEBwuLCQj4WpWICBZ8MKdaNYOQHrKEvfFQgG
         EaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006591; x=1781611391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
        b=D7yANJwNdyqHjPuAYdHvUjfuR/iEYfYMdELuVPaq79zpRuWFGMYdinfp4w68QEe76V
         eSbF2gjqnTM1p2oOrkSO5AKWKQCLN5jlMLV5q28TFrY41RLraQV4JEtmJfIX+3QqOD7t
         1bdHDvjILq3OahWjwEpi0rCBecO/rvzuNGC3rwoEdocAbblNWr68bwyiNeYE/r+Uw6TM
         R/YoZTk5MJwi+Wgct/MtNp6QYmr9H8mkoGz8JsgBH/aInAtZGxClhFunkzi6lE8fCeya
         3K0Hu9Ivnvv0LDpSfukKEnLuBcCH2FHrBBdKdHLvhkIqKxO9kM4DIBIxRIqUnBdFr/uK
         yvXw==
X-Forwarded-Encrypted: i=1; AFNElJ/hZp2HVJj5FcOKxH4mAt5j9OtTlYse2vZp/JuNyN8sTbTyU+aedRtfa/AJUmXK0hwBDqq0w38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rj/e1Z6PUCw0AuOzbY0pvtYfChHngQdueUNLObNlbnkd7ACb
	ptLQzlPKrMQSuUXkULi2bEiwhAU4aJ2VCSJZwYcEDMoKEKXEHIGNDvlrSDzyz+2eCYuGxTBMiFT
	lBS8C1lA3MN3XgwcdZJ6CIUljke2h5ejAqS0jW7Qe5EByuQmw2uyOFYPVMw==
X-Gm-Gg: Acq92OEPXVSHx5OfkCI7imaZ5O9pRek9oDeT3FkmzWOlSwJYO898aYVmETmpBUjSK5L
	4drKKQ0i/Q5LuQcVNbQlxQRSbVbO/ch2oTF/Nzi8fRV51lIFo1LcoJR35PC2xVj2I5if05B+hfJ
	IEDNIf0JJQvWxsctgTaG7SsQJ1Xte3o9KvLHJlIYkxpQy8xYfU/qGf+Ke8EvPGgaiU592W8Tn2+
	m0Aq7tS43gPd3qZYeLhaXnSesrO+udGjevPOTSVlKswL+loHMkM22kjxanw8LqRv2Jd0cuCshlh
	yBPqOQaeGOHQPYdDzZGHgdvRKJvXu9+yPl9v+mWqeoheWkj86hStKlgNIEHodHsbBk/HjuYe2Jm
	fUO7B5VHoeONUhEGVoZZPg7Bhuw5n5zXPsj3tlGDsh9K4gD4IOEDbGzDA14ekI8Os+Q==
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id 5b1f17b1804b1-490c2612b7fmr333238185e9.23.1781006590842;
        Tue, 09 Jun 2026 05:03:10 -0700 (PDT)
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id 5b1f17b1804b1-490c2612b7fmr333237345e9.23.1781006590316;
        Tue, 09 Jun 2026 05:03:10 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d5d2b4sm314279195e9.2.2026.06.09.05.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:03:09 -0700 (PDT)
Message-ID: <c04cc47a-c27f-4267-97c7-fafb80639f5e@redhat.com>
Date: Tue, 9 Jun 2026 14:03:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/2] selftests: net: add local ECMP rehash
 test
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net
References: <20260604212246.265079-1-ntspring@meta.com>
 <20260604212246.265079-3-ntspring@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604212246.265079-3-ntspring@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A348765FD7A

On 6/4/26 11:22 PM, Neil Spring wrote:
> +test_ecmp_midstream_rehash()
> +{
> +	RET=0
> +	local port=$((PORT + 1))
> +
> +	local fail_reason
> +	fail_reason=$(ecmp_midstream_rehash_attempt "$port")
Shellcheck complains for the above:

+	if [ $? -ne 0 ]; then
+             ^-- SC2181 (style): Check exit code directly with e.g. 'if
! mycmd;', not indirectly with $?.
+

Eiter disable the check or use:

	if fail_reason=$(ecmp_midstream_rehash_attempt "$port"); then

/P


