Return-Path: <netdev+bounces-268590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DfmGfRHuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:24:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 850342A9C83
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D8DE3002B7D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B13C13E6;
	Tue, 17 Mar 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3ur5lB+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZQqjBqF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EE3C13F4
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750061; cv=none; b=WA+5DHxBUzFwGXSFrz2A4iaQ+BNPjupYOIB4ZZ/KSLdIFNVGWR9H1lTYmtvYJ99k91j/M1BKLb6ncgmpMWmgs/unufGKN55lhKXdBWHtchrZCXcanR5lx64smDrSK43o4xH5OeUSZv8DrZC7wA4vNbDvsKsPE7S0BVoPCmhxg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750061; c=relaxed/simple;
	bh=ikYXskdjqT1oBUvXC9EURGXDDr3yzkun5zhv0pI6MFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A047Ui3xhtT4oIebzyQWrNdXKqE8p6silm/ErvXDPaJeOa8jTAhbZxuw/lBLIEYIx/FZO0abLhdAdzdRmPuOR6pb6KEeRFKc6/P9SUur/OM667DdbJckkDH9Cvb9W9gOfAdmFgSH+J9h9YwKGauLWkrh5dqSqJFT5mYnYo/HCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3ur5lB+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZQqjBqF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773750059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMR0WXF/fPUdEPH+ksc6APmIhPxNqgYRRVse5Z+N3hE=;
	b=O3ur5lB+YkK7VIWRsG+GM1pyHRiLjT+JaBfklYHUrfh2OUCcDT1IusQIX5EAWmH/Ribj9q
	DjBp5v3K3h++9XgbiTdlztnKHS4AezXxsQQuOufv4wgvWZXIAPjghXrSYX1nTRn15hdZxg
	edwcwFyGFLMOM73QERAXIWerCid+YTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-5k9yvcZ1Ogq9ytC5MiuU1w-1; Tue, 17 Mar 2026 08:20:58 -0400
X-MC-Unique: 5k9yvcZ1Ogq9ytC5MiuU1w-1
X-Mimecast-MFC-AGG-ID: 5k9yvcZ1Ogq9ytC5MiuU1w_1773750057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48534941525so82641735e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773750057; x=1774354857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMR0WXF/fPUdEPH+ksc6APmIhPxNqgYRRVse5Z+N3hE=;
        b=OZQqjBqFji5Vx6OHxzeo0yhAqlL+ayGB6s6MF8G2T3bE2NfRKRGp93FREqnx4LA/uF
         kaDAbt/wo3kBVEz3PO5luO1u21CQC5yCs+KX5rKG8zoWlh7fd5HRq6Bd1GH/KVOiMDQp
         EmuKVa52BO16vi+7iH8CNB028krhZ0+VupUM2ewAqThgOLZnt/q2gCGIJEpbOLmldSjD
         UdoPuxmlQP4Pz3tnigWwaE3EiAJZKhSVeTO6G1di6rwn6jUCpV4pPSChmuYxns3adozH
         EqSprnl733oWvrPjKW8yLItfqyLMmu7PzUsb74MxxuBbnvVcZm+MeLhPweD9IANqYLeN
         12DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750057; x=1774354857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMR0WXF/fPUdEPH+ksc6APmIhPxNqgYRRVse5Z+N3hE=;
        b=Qgw9zUlp7046v8MKmdSexfXiFz6wipKO9Jk4TRL8367h/EGbdsKv5I4pKhrt8vxRzq
         J2I5hknrIGxXmhEQYPqlcrqAnSwmPTDZRnQZJyzuiyMSdZ1SwxOHDfT8YriOmuViaY/n
         nezuNf1zsWPa7404rgKFi4My0Nmd5QqCYUhPAEVAcgfhvGLSsQIX9cmme4s5gCDbuFl2
         9NXRjrGMSR4JvnOeN32N8iPeBUaMZ4Lw9NwlpQBmwbsxXWbSKG4G3sxjMeV5I4f4Tcpw
         KfmgrW5Kt5r4ICIQ+1IV4RoRU9swcqruDOhE5nkl3r3PpZwvmObf0866oiOTy4JOJCtd
         jbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdIAkDycmKfIo06hHQ+MP49NbGQma0zKKsa08V5IYdij9RYxwEWKYZ8W5/E7WTI13bXy43YEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnZg1TAJp/rjRuFhE4NBzTpBBov9301wVfcHIS/b9cSGSIUSu
	Br9c3kUlGC6gSfzc8jzJkYaMX32SwJ106mT04qqYXzS9R39dfI6xi0lRXwMdpQwSY5A07xv1QoV
	PTtuJRPmsafiOZg4S1BSPQEmT7yPYcaRDlulutXSYy9E7+5vQeCNRUSX2Mg==
X-Gm-Gg: ATEYQzxNhaU2e/+z0tR7Ys/JA+XfY4Ii8r/WuwfDkd2NTSBM3+YLTed0fxBtPd2YWlL
	54FeGjuNBAwXKB6G0m/+ryS8bBU1de9yZxsXr5Fs/WXrF3qC3NgWp/qtRbi0R9Cb422ftmn0n3c
	BSf78ssMhGYsMujiYY+LSgYyhNn53j4burijLnP5Ak3BXTVxMfmWJWonr2bLD5U3bvcqJQ77tOH
	AT8YJxuSfrdGUntVSTz3RjxpSkgFP60CuyMq8RUuV8sDFqR2KoP/nWPCxdeWSDR5UlpModZG7Vg
	zfqwnXB4FK7rd8bsCEG7CqXpeRB02pPUE6s6gKAdQ5CoqS77SYkuZY5RTdOE1uDJlYxOtMpBrua
	+PKeYultPbUGr41E02Nv+8I9ku4ye3u176nCABPTovVJagGy13xWS8k0=
X-Received: by 2002:a05:600c:45d5:b0:485:4535:73d with SMTP id 5b1f17b1804b1-485566cfb8amr268349995e9.2.1773750057262;
        Tue, 17 Mar 2026 05:20:57 -0700 (PDT)
X-Received: by 2002:a05:600c:45d5:b0:485:4535:73d with SMTP id 5b1f17b1804b1-485566cfb8amr268349235e9.2.1773750056767;
        Tue, 17 Mar 2026 05:20:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eab15f4sm66629305e9.14.2026.03.17.05.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:20:56 -0700 (PDT)
Message-ID: <d2900f79-f481-418b-986e-7b86ab20c803@redhat.com>
Date: Tue, 17 Mar 2026 13:20:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: add robust link-down TX queue handling
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260313134628.3827338-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313134628.3827338-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268590-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 850342A9C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 2:46 PM, Raju Rangoju wrote:
> Add comprehensive link-down handling to improve driver robustness and
> enable fast recovery from link failures. Currently, the driver lacks
> proper cleanup mechanisms when the physical link goes down with
> packets in-flight, which can impact network stability and failover
> performance.
> 
> This enhancement adds intelligent TX queue management during link state
> transitions:
> 
> Link-down detection improvements:
>   - Adaptive polling: 100ms intervals when carrier is up for fast
>     link-down detection, vs 1000ms when down to conserve CPU
>   - Enables ~100-200ms link-down response time (10x improvement)
> 
> Smart TX queue handling:
>   - Immediate TX queue stop on link-down to halt new submissions
>   - Skip futile hardware drain attempts when link is already down
>   - Force-cleanup abandoned TX descriptors that hardware won't complete
>   - Proper descriptor and skb resource reclamation

It looks like this one should be split in multiple patches, to better
isolate each specific improvements.

/P


