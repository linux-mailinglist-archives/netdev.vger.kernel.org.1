Return-Path: <netdev+bounces-268558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BoJOXw1uWmcvAEAu9opvQ
	(envelope-from <netdev+bounces-268558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:05:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 666682A872F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF1B3071430
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F30376BEF;
	Tue, 17 Mar 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlM6ky8d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQbjPmyS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAA3A5E78
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745359; cv=none; b=jn0JWARWkp7F8DOK+b/itH36VFfIOxrlrJhZWXdCUYojCluvhGLlb4AprLmHdYb3zCmklFz0fDmuegCs9lUPT+VOibVL+8+IJlCZe/Rj0/IU8ilvOdMEFENSKRhP/FAD4Q8Iu8YHqvxEGcyOZFLxJ2q/PoFwQC7PyMLGaYRC80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745359; c=relaxed/simple;
	bh=trM+aO4di/fsC0njym61jkx0cfiIdiMuMstSKrw+wFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXR/6cYSl9teq4F9phEeSSjbExff8/QUzdLhUTG2dB1vH3bBLn0lVvcas2ixLM1JpIzW1ejdWIw/9doB472kRIDy1ddoVfIA5dBOLlc86o8XR3Iu9DAzt4UBdTX5DUB9QQPzLFQuRqeUs+puO/bHRduXuLcSfmbjk9OEEdZbfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlM6ky8d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQbjPmyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773745357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UksvgSzqwGYCFxE5GghOmDEeBc6x2USjTD0nYL5bANg=;
	b=MlM6ky8dKfgwTShN8f1tKu8w/bbYJkxeXp5NfAbPCEqjeE1PdvgtysLfpVEmlof3w74luI
	aupW0UuZMLMbc8iEQ0QY7pY7O3SAUajhTPu24QbDvM03zTu3OwKRz622PcGvll7NBzUWpd
	ZUD1hDHYsH/siMakbuP6fogVRRoeLWs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--PdexQvlP_STrI4r2-ihcw-1; Tue, 17 Mar 2026 07:02:34 -0400
X-MC-Unique: -PdexQvlP_STrI4r2-ihcw-1
X-Mimecast-MFC-AGG-ID: -PdexQvlP_STrI4r2-ihcw_1773745353
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8704795d25so186674866b.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773745353; x=1774350153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UksvgSzqwGYCFxE5GghOmDEeBc6x2USjTD0nYL5bANg=;
        b=UQbjPmySWDYQLWKS4KbI3qQgnTEvtNSonGBL1HNt01NV0zcnrxDE17wOGgG4jd/vVq
         b72qi2FHqFTGJ2Xh8CwKc0DAI825cQDG25oReDnbKBwp0nW4dd0HUItAjylaFzVfwHHQ
         CyOOdZyu5EL107sdAiJ4UBg5DDeA4P39CAZdoeELqVrQXevsOX1HMriiFjFGAZe0PlxT
         3nDwP9aOoP2em7WTQGsWUg02lR/7gWs/EycCdoNtG89XlOQIhnryrCHZoWovyBnVaqAR
         tHUM46li6U2rK1yKgHbjWLGGb1CK9drHCHe7DN0d0D2N/eDysKs5RqA5Pw8PzMA+OawH
         ND1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773745353; x=1774350153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UksvgSzqwGYCFxE5GghOmDEeBc6x2USjTD0nYL5bANg=;
        b=CLvfQ4cxQpr+pgYMclZ1YFzYQq74julT6FwvVemuGfe4N5kD/e8CgkcrP1TjImMAEN
         n4xbBvUrcXcDGHOM4AbpLO0ywfn1mivXAjDaoK/wcT8V8X0rbg8SvBVQOH20eAaDzOYr
         QDnJhVbQd3C0VSrmcON8GmkyyQf2SRnU2yKbytzyO6LY/wKBj940wxvU8zE005dJqn+V
         8W9/RkpR0Nhzri5YZTBZA7XOCd+YjC4w/Vo7Jn2w1k58uo2TRZ7967RdI//7Aeutd292
         kU84VeGF+gZx7YBUO9PYsDhCsM4xOONM9VjqNkohiOHSPN4Dp0w3lsiZeWSt+Xif+khw
         TrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPq4NvV7OhRdMWilo0cRZbUQklIhhE64f2vaTV94xTDj7ylMADNITSmg+yjvzIunsKMFh9iek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7PY2xi2K9bN2uN+mV5LVlmsWO1K9MxAMsp/TL3w/u/t4/QnB
	mQ1hRCcCiPl6XM6KnSyLc5RYzQR8KizP5K9TaDBR6aUju6bSEzbGQEaF0xpeASY9A5evHhLn26s
	brVQ8aKswDrkmcXRuTTx+NbFGoRHrwpgr1WLbR70su66gDete0J2CzG95hg==
X-Gm-Gg: ATEYQzwUQMEWnKvFijzV21N1yM9hY/xDuB4dK6JHiJlsJpz4kl8CLo+dzIcjYfP4n+r
	+VqNplUltG2aAMQnfK/x8r/V53fDVuD+Helbr6pjnrS90VQBFAZe24Zlc8F0cDAyMuXsK3nRhH0
	2QVr+Wqh2Up2iwK9/0y5pjqlqg18cfrCXT3qRQMqYoM8eidsQJyJKIcaI3lHr77tSFUTMVM478+
	fJSbjotYnD8S/ZsqbqA/wrmFHK1CY34jaOh6Rrpdkj6SNsMwRa80KNBXXrb0zVAF333zwg+j6gQ
	sOetkDG/c4BJR98nartjEcOAyg7YlNXmrjRxPCRZB4SBD2CMEiwv3jr8so+Ogo4fqOWg+LIfzH3
	MJRn8Sl9b3vrRwV5/HRpuBCw2OIVMY7aouhFKY6FIRRee5XMJD9+Gu/U=
X-Received: by 2002:a17:907:d15:b0:b97:9636:5aac with SMTP id a640c23a62f3a-b9796365b2fmr701141666b.13.1773745352650;
        Tue, 17 Mar 2026 04:02:32 -0700 (PDT)
X-Received: by 2002:a17:907:d15:b0:b97:9636:5aac with SMTP id a640c23a62f3a-b9796365b2fmr701133266b.13.1773745351948;
        Tue, 17 Mar 2026 04:02:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9791c113d4sm624943566b.6.2026.03.17.04.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:02:31 -0700 (PDT)
Message-ID: <89df6470-027b-4d86-98a1-72042ca819ed@redhat.com>
Date: Tue, 17 Mar 2026 12:02:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260113162954.5948-1-mmietus97.ref@yahoo.com>
 <20260113162954.5948-1-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260113162954.5948-1-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-268558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 666682A872F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/13/26 5:29 PM, Marek Mietus wrote:
> Currently, tunnel xmit flows always take a reference on the dst_entry
> for each xmitted packet. These atomic operations are redundant in some
> flows.
> 
> This patchset introduces the infrastructure required for converting
> the tunnel xmit flows to noref, and converts them where possible.
> 
> These changes improve tunnel performance, since less atomic operations
> are used.
> 
> There are already noref optimizations in both ipv4 and ip6.
> (See __ip_queue_xmit, inet6_csk_xmit)
> This patchset implements similar optimizations in ip and udp tunnels.
> 
> Benchmarks:
> I used a vxlan tunnel over a pair of veth peers and measured the average
> throughput over multiple samples.
> 
> I ran 100 samples on a clean build, and another 100 on a patched
> build. Each sample ran for 120 seconds. These were my results:
> 
> clean:      71.95 mb/sec, stddev = 1.71
> patched:    74.92 mb/sec, stddev = 1.35
> 
> TL;DR - This patchset results in a 4% improvement in throughput for
> vxlan. It's safe to assume that we might see similar results when testing
> other tunnels.

IMHO this performance delta is not enough to justify this amount of
changes.

Additionally, the measured impact of removing the dst_hold/dst_release
does not fit with my direct experience on the same matter: it should be
below noise level in practice, as dst are per-cpu and and no
contention/false sharing is expected in a good setup.

I think you are observing larger impact because in the veth test
dst_release can happen on a remote CPU. Note that this setup (vxlan over
veth) is not very relevant in practice.

I'm sorry I'm not applying this series.

/P


