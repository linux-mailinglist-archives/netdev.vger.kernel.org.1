Return-Path: <netdev+bounces-280651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH3KH1fQ6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAC44E34C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02351302084A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05ED337699;
	Thu, 23 Apr 2026 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxRHvlMp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5GKfbBq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816433A9CF
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930630; cv=none; b=HdvClXFCkWfpebBTi9IWcLgYlXo40HK81qw+751achlkmKlz+gp/kQQ6r4UMfTwsJ/5hJawKSB74ZrU8splViBXFfepRCqmjXs+oNjYKiGHd37PFAYW8YFnjL6veRpqb6mYl/TeielRLt8PlClz3Mhfqzbq6f7bm6a33olWQ+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930630; c=relaxed/simple;
	bh=89j00iLcqHYB5cU4LIGHWsJdhgF0Qz2eMdlFKcdrmQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loMZ9NozqoeYf5LHFJ65BWikREhbozSKXG83EgaurPmKWPEJR2P1lzbkWxY9ejXvRukWU3ecE3y5a92FvRz9mHIEA1JD8lIYb/2KD7JzTjrFXo/0mjS4Gibk1Ic1zrWIVqyUkoHLqmrv5QAJjtTJLyOx5+1KTBFtOViwULJPPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxRHvlMp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5GKfbBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D30yfVtGlHBCp6XmrkjxJaDZ/v2wJtlooW7205vdCuE=;
	b=UxRHvlMpKB4U4qL//Hw+x1q+JdsWDoTGvXzfQUfWuJnlnoQtlcW/qwfjM+xzvKor2HSdcH
	Oq2ZiyceVa3ihdAui6Ja50OVM/YhNP7sS1XQPxaLxo1pxi7FHg/4yuZSwcLdJpNUR2Zl6h
	jAx8YXW/gR8gyJxQK1AX74iUGTv3wcA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ecOw31ZOMW-gB76opwWF8w-1; Thu, 23 Apr 2026 03:50:25 -0400
X-MC-Unique: ecOw31ZOMW-gB76opwWF8w-1
X-Mimecast-MFC-AGG-ID: ecOw31ZOMW-gB76opwWF8w_1776930624
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso4223556f8f.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776930624; x=1777535424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D30yfVtGlHBCp6XmrkjxJaDZ/v2wJtlooW7205vdCuE=;
        b=U5GKfbBq3DUEtlSKfPFhTDhQw+9TreHXMQu58wIG52dVXfy6RQPtVXtbMFXc3MnFMh
         yEHRWd7h7efhsvU1DhYKBOIwcCW3LnW/cwyxnT1KRxiaB8igKv858uil7sZUreYp9wlH
         RCdxoW4LDD71OcG6wYc37q0pxZEVSfMlyHq6tGnnKDgmQ+Q5HeTbm1Ef3BQXj7FLeaBj
         Ft7b6594vcINrwcuffSzlp4Iy1OUrA+9Jlpa0MfnNMywvzMIcAebSAkQj0O6tRI6v/Ic
         y4O5Qx2G3WjH+AaTZas4LySDO6S1LTS4ZV2GAXyaC2ctyMFS4i36sE6FdJVKVhkc+3PO
         UySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930624; x=1777535424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D30yfVtGlHBCp6XmrkjxJaDZ/v2wJtlooW7205vdCuE=;
        b=DcjH2asXfexGICCQToYI4t+GLLZJwPbGJTGM7SbxS2iCI50DOcOia3R2DKD1IVxl4R
         OkvQeLmK0Jxf5m0CWl8yU3y43k3zElWFAUvoo2zT6GWJO+QNQlCKHCsGzpOg03PHdf30
         PnEAJTcbWN4dF/8K3VkBePqB2LnAs9dVH6bmre7ldP19D25S2dUTAhGzMsO83vNSTLrX
         mfdO1JepbZSwtqjC34xcVKR8NNgmM/SgA0qqu8ACJo6/RYl0jV/d9P3QAzssNQUcKsGz
         kQeFvc+XEEZqZyGAM6NEbvNTa7iihmXLMwsbDTz6bgmWzUdfwnQwAMmlK8aNv53YtasZ
         NQKA==
X-Gm-Message-State: AOJu0YyqiUQ6257uCX//9zlmHXeub+oyAzeNfrD2ClXBOEAPxr5cWJzZ
	JBBGacq/Lo6da66zlWAr5QA8adA4ZtmWVbZOqAsDQLR/IDzw1+/v+81pUMLv3bVEm/hVRaxJJwS
	877GlvW9GuuXjRQpaYlpqktjF4UYX0+KeBGtMhMOu11nsZpESzG2YBiWUaA==
X-Gm-Gg: AeBDieuGWV8yWe1lJG0nCfu5u2FCU4GnaXm782Xz72/LFym3UGuPae1Iz2WUlW2TujY
	mY8LJtec83Ovtx+uG7zdaVRRYcLLoGKNR5DTu1oSTQlLUQRLbu39nDNU4KXRry7hjDC2EKMg1kN
	4/ogQGyQHr1Ba9M2lhiMcaHR8wTsnclv36Xh+wknsYMMyR4/qbVNoOwI1qunwhuRWf4uHNZePpw
	B2EdvUfhSluwO5hkU0ITGEwcBzF5Baj5WzH+tOgu6AN11IIiuqFDV6tIJyJAlo55Vf2iGuIKGdo
	8HUYFYM5C08KchPJu3jiuSn9gt54xrLEnCsIxSWP8PQSlKU/6EhW6PANVXGxTFlWatD/UD7nkPX
	PLsNOun5w1ZMfD8YnBq1Wm3LLwt+tCfPgx96EptQPNqmas5QG5rd68irnnMCfaeXzPSc=
X-Received: by 2002:a05:600c:3b04:b0:48a:5574:3a57 with SMTP id 5b1f17b1804b1-48a55743eb7mr137090115e9.29.1776930624008;
        Thu, 23 Apr 2026 00:50:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:48a:5574:3a57 with SMTP id 5b1f17b1804b1-48a55743eb7mr137089715e9.29.1776930623580;
        Thu, 23 Apr 2026 00:50:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm166355775e9.0.2026.04.23.00.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:50:22 -0700 (PDT)
Message-ID: <87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com>
Date: Thu, 23 Apr 2026 09:50:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot configuration
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Taht <dave.taht@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Simon Horman <horms@kernel.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-5-stephen@networkplumber.org>
 <20260421131039.GA651125@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260421131039.GA651125@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-280651-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 03AAC44E34C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 3:10 PM, Simon Horman wrote:
> On Fri, Apr 17, 2026 at 08:19:42PM -0700, Stephen Hemminger wrote:
>> Reject slot configurations that have no defensible meaning:
>>
>>   - negative min_delay or max_delay
>>   - min_delay greater than max_delay
>>   - negative dist_delay or dist_jitter
>>   - negative max_packets or max_bytes
>>
>> Negative or out-of-order delays underflow in get_slot_next(),
>> producing garbage intervals. Negative limits trip the per-slot
>> accounting (packets_left/bytes_left <= 0) on the first packet of
>> every slot, defeating the rate-limiting half of the slot feature.
>>
>> Note that dist_jitter has been silently coerced to its absolute
>> value by get_slot() since the feature was introduced; rejecting
>> negatives here converts that silent coercion into -EINVAL. The
>> abs() can be removed in a follow-up.
>>
>> Fixes: 836af83b54e3 ("netem: support delivering packets in delayed time slots")
>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I acknowledge that Sashiko has provided feedback on this patch.
> 
> 1. "Does rejecting negative dist_jitter values with -EINVAL cause a
>     regression in userspace ABI backward compatibility?  Since the kernel
>     previously accepted these values and silently coerced them using abs(),
>     existing userspace tools or scripts that happen to pass negative values
>     might start failing to configure the qdisc."
> 
> This is intended and explicitly explained in the cover letter.
Jamal, given the uAPI implication, could you please double check that
the change is fine?

Thanks,

Paolo


