Return-Path: <netdev+bounces-275870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFlvDCWf1GnsvwcAu9opvQ
	(envelope-from <netdev+bounces-275870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:07:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E43AA26E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90B06301484E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE337E2E0;
	Tue,  7 Apr 2026 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhZ91mcG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmfWWNU1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03B37D120
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542050; cv=none; b=cTFHaU9b6B5ZCKNOW1nJg7Ifp7MRqHymtbV4wAZIq0KgthZG3EDoW+HIUJfe+9iHKklxNX8SLlFC35hXG9vsYa+sCf4nTESmFB9T70qnjH9DOxafAjJxl/YlJmncKPIVrouicdM0hCKLFUvxlxEMsh45jTxkLSzO7PdgPGY3QYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542050; c=relaxed/simple;
	bh=zSPXquHJPZc4vaZrZRXpX7a83xz02/Rc79YIwB+l/e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAlOaieL/zttgi3hdFc8feC43qs0Btrvw/t4Jc6/FvuG7d2VbRUWQ6XQCp5Qd4Nh7Ad7KqUmdcspcX8/VHb6THUAshks8BOBq7WL+7t3DFO60iuQBF3A5YeeSW9FciCt9iCT/zPSWcKN9igxL49yKZxjC00d0Z4gDKO2zQunWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhZ91mcG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmfWWNU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775542048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=goNgr9AbJ08dlfiC1cIzWTDFI/Qs/LnpiiJx3p3Hftk=;
	b=BhZ91mcG8gX596jy3pdwC1D60Vo0bODdvw9e4R/MxlWCbfXeoua+I6OljZJ6qRs62lquDD
	vTQAkpNFbX/DMX6dv4P8R1A4CfFNXmkm3Go6FP3LTTzzlHnP7zN2TIhnz5kpffQ4uxvbsP
	nth+z+8EikFwqRGiuj+/AP3Tyfed44c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4W25jw1HOGaKFJNJqvPSBA-1; Tue, 07 Apr 2026 02:07:22 -0400
X-MC-Unique: 4W25jw1HOGaKFJNJqvPSBA-1
X-Mimecast-MFC-AGG-ID: 4W25jw1HOGaKFJNJqvPSBA_1775542041
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488af976487so11054135e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 23:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775542041; x=1776146841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goNgr9AbJ08dlfiC1cIzWTDFI/Qs/LnpiiJx3p3Hftk=;
        b=dmfWWNU1heq7V7tC4TwouPMxIw3wRFPkptnsJ1GNWh40Mle4dyYJztDD8CEkcLuI/H
         SgzKllWP0CVvviiNEIgnxdWyueK1TLo5QvZ2NqAk9l05k4zYtv/p57EoU/S4VgjS2pHJ
         CwTkR2+fjlPo3F4VtwA6ic1MuGhBVXUyz6cwgSSTBQSx2M9CfGEPa1qGU/CPjOhCZzFJ
         A2DcEVDtkf6/HzkQC28B8f7LtJ1eIXrOCrRs7uWM5ZU16CXZ1p/1tQI3czerDVIqDMYs
         jJZEBazJoz9LG7OrfhSu6GXXx5NaPY4V8uPkgcFDjQZWoiU6fiUsxq+GGOczZBN1ijzP
         DkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775542041; x=1776146841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goNgr9AbJ08dlfiC1cIzWTDFI/Qs/LnpiiJx3p3Hftk=;
        b=QaRtft8JkqgaH6/DdQsTgMJZZHc12nD7O8Jz4ykctM2a4ntEsWrXPik/V4Y7s4dR0e
         UuctaqGwNSnQGi9iY5CBvAVnWCZqcJgj7G92uZcTrGtrKgx+rRcPs31fBm64yARWHqDx
         roX3gy3LlnV2supiLEvOrvUOi7uGCrVYTPf61pQK98rSli943uA87apBRsxosP7ESg+t
         RS1PZIT5pWl1UKepk1cNAhEja83/HHOZHMCRvhpct/jS2QuogSNQ5VRapT0DEzLhFW4c
         i/mGn9n5v5XBggu+SrF+gvL7GiuJi8QCserbcHA5BvA09vaD0Pu/894DULAo+GsKS2qT
         rLZA==
X-Forwarded-Encrypted: i=1; AJvYcCUjKA6yB8bjMAx9psxWvoqo5jNM0M07rqHvQzU17vgFy1AzaiRR8GJYYfoKoV+ITP0K85ha+y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlCaWzKpq1/c3hwtm3/RWXE5GKZOXGKVeF08yESV1As/s5m16
	q2hv+r9w2NPvAh3CbK1mjgB1Xt9FLkXpBA81nS9xXYIbqd18u7ROeppvCzLxe7+iwahBo3Zyq96
	6m53aFZnSJyFX9O5RpSXDOKgDboINFv+6XHTpjzgF9bAwXNuBhLr75LfQSQ==
X-Gm-Gg: AeBDieu7L5bTXPIMke8PuW08/WdKQIYVp1F9Ketgd1bhiU0o8yesnQ073OBQw6oW2zN
	g69RD11/mfZf+1Nqj9VjPVMOIuBPNernPhiLjcgpj6ObSGxoxZz97nu9URjHr4yJiDe2zlM1MHX
	Mn8ou+j+2OnASbth80dKJACWHu1xH9cT4ID938PdDJsCwGT+CySIyNWusR/DPPz2QyE4RX3KSAr
	vp0c0snZwDA3k7kOTNrV3rqm/XTAi7g/cmjAwBU3wcyhrfab49axN/CNyiOavdD7TLxYZNy8k9I
	UNblojFzwGwAdJQNDFIxj1/9hvJhnKxpYXCAix2C9Q3VvcY5CG0GPut1aRETHQVPC9xcyMM2MdG
	4lNgYEZYGTOkI9VlyC7zTE0Iph6/6B53HB0fejbWdLW13NwLgiBqom7sreQ==
X-Received: by 2002:a05:600c:348d:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488be2155c0mr15464305e9.8.1775542040628;
        Mon, 06 Apr 2026 23:07:20 -0700 (PDT)
X-Received: by 2002:a05:600c:348d:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488be2155c0mr15463755e9.8.1775542040128;
        Mon, 06 Apr 2026 23:07:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d3a4e9sm221519485e9.6.2026.04.06.23.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:07:19 -0700 (PDT)
Message-ID: <7145f530-3adc-409f-bfc4-583e42be50ee@redhat.com>
Date: Tue, 7 Apr 2026 08:07:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v17,08/14] net: homa: create homa_rpc.h and homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com
References: <20260316223228.2611-9-ouster@cs.stanford.edu>
 <20260318072131.268946-1-pabeni@redhat.com>
 <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com>
 <6fb603dd-7bc2-4b60-bf93-7247d05f3250@redhat.com>
 <CAGXJAmx6YsBYQCagvHs1DPTd-b-yHYVTN67-JCApQdG+x6-cjg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmx6YsBYQCagvHs1DPTd-b-yHYVTN67-JCApQdG+x6-cjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-275870-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A15E43AA26E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 1:04 AM, John Ousterhout wrote:
> On Tue, Mar 24, 2026 at 1:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>>>> [ ... ]
>>>> Paolo also suggested using deferred SKB freeing (skb_attempt_defer_free) to
>>>> reduce the cost. While you mentioned that GRO is implemented in the full
>>>> Homa but was left out of the initial patch series, would it be beneficial to
>>>> include at least some of these optimizations in this initial submission?
>>>>
>>>> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com/
>>>
>>> When I asked ChatGPT about homa_attempt_defer_free it said that it
>>> only works if the skb has no dst, no destructor, and no skb_nfct. I'm
>>> a bit unsure how to proceed. Is homa_attempt_defer_free only intended
>>> for incoming packets? If so, then presumably there is no dst? But what
>>> about the other fields? Do I need to do something to clean them up
>>> before calling homa_attempt_defer_free?
>> skb_attempt_defer_free() usage is intended for the RX path only.
>>
>> Incoming packets get state (dst, extensions, ct...) attached in the rx
>> path before reaching the socket. You should free/release the state, if
>> possible, before inserting the skb into the receive queue, so that you
>> could defer free them after read.
> 
> I have modified Homa to use skb_attempt_defer_free, and this made a
> significant difference in the throughput of the critical path copying
> data from skbs to user space. Thanks for the suggestion.
> 
> However, skb_attempt_defer_free is not currently exported, so the
> patch series will now include an EXPORT_SYMBOL line for that in
> skbuff.c; hopefully that will be OK...

Yes, it is as long as such export is bundled with the module user - i.e.
this series.

Cheers,

Paolo


