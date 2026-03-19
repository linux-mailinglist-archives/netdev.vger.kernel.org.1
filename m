Return-Path: <netdev+bounces-269389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBrcFGXNu2mXogIAu9opvQ
	(envelope-from <netdev+bounces-269389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:18:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 793922C959E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14E7D307CF2E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB43803F0;
	Thu, 19 Mar 2026 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6EwL7pa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX+Aai+K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D53603E7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913963; cv=none; b=afnyXd4cd5ZLNoQX6d0h9EaHMWtPpZQI1doKHPT7NebCZL4hem4M3ESKh52j6uGDzP5Mq/c9+mES5td+sJxeHRxNLPJgIUwL23CqHSKpdGJN7DAyo7cEDTX0N488U+M70RhGB5mCHSEda3FNPNamWSVKZ0UjcrYUsvJBneJ9kyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913963; c=relaxed/simple;
	bh=7uA/BCBTVJ94Aaj2XviPEUjuMABWk6OC0mXxBgWG+pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSwbJ9WXS+zPZAzPbzVKTbYXA84z5u/k3J+sRwT7ptso+HuCP6bHANxtiOYy9/brNCwe7dpxDt6s1RUPW0flGmFSVkslQVtI2pfaS8XaB5j37u0Vge3iJ4hOoD88J4sRZzREy2MtOWsycwd/i+6WHJ+C5vXxAI21MPQ8vtB4aDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6EwL7pa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AX+Aai+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773913960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWVI4IPyZgF76R5k9iVZditqSOUJj0IJ9hCQO83Ez8E=;
	b=c6EwL7pajDifaS7mnFuMEwpU//SNIJ27TwjlxFebJUcBI3bQGwRCgpQSatD4zvecvzgVH5
	Z3OSd/rjpDcy7MHxvfgC5um0SvLAfcjb6XU1fcQi9pCI1TbGYA6WUqDz0vxwGAnf1UcGoB
	ckUoipLYrGjbC5nRc0sKgqaTji0pJOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-RUlly1FKMTqiH2begN5fGA-1; Thu, 19 Mar 2026 05:52:38 -0400
X-MC-Unique: RUlly1FKMTqiH2begN5fGA-1
X-Mimecast-MFC-AGG-ID: RUlly1FKMTqiH2begN5fGA_1773913957
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852d27f473so2550575e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773913957; x=1774518757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWVI4IPyZgF76R5k9iVZditqSOUJj0IJ9hCQO83Ez8E=;
        b=AX+Aai+KHde3OWrOPVpjQ80Oyqz9znVUhHcfl/2YRBURf86ijtcTDZPwDK9oI+jFY/
         UFN4zLr2bNCTiLXybEDzJRMFMwb4FItizO5dUzmW2h8VoohB5wldInBNqkPBLZn+xXK5
         Rnkdjs1WchAvzVaATC41djQaHL07v33xlmAFgnRz5PKs+Z1UkokvChpcNoghYtGbxdvR
         dEQWAmhTAa3w4klVBDhnzVS3NmxPwco0ILFlNEO4WpdJsh24HBg59VVpJlxSnF7BucBr
         29FhFXS1XA9+BlEf7u9lYW0H4hcnc72gi/jUn+NWWhEMug8dhZohMHaZxw14bxbhfdCw
         miEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913957; x=1774518757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWVI4IPyZgF76R5k9iVZditqSOUJj0IJ9hCQO83Ez8E=;
        b=dcOIAr57x25911YOc+u7QmqjFCpslRRI9PaQtf+CTSxhYrCqvNMm+T/40p4ApQhhbY
         aN978UWpl41MZ9VhTMKH7a3I9Y5EVuZHDA01uB6EohP3Xs9o1oTBoOJLgSkjV8ak6I5L
         3IhgOFVu9611XK4xLH5vUYgRFk4dR4YISOluW+am+R5wSvEHnMGSactzOhrhsyA1RJZY
         JS0cGA298AIhXwEaHjeG9V66pzcI6RHKj7tf7WUhfpfSXLZ5HEidEBZ9uofXNxiOidyQ
         RlVldi2+H22Rg1x3COkkqKlUs+1HTCEG6FmBDyMeHxFfzRGaN9L6tXNLy3SXG3W78q7j
         EbqQ==
X-Gm-Message-State: AOJu0YwSYqfnI0Yn//lHKZ/EvFEYm31NeVqy2NqBQ1p7ci2KHGzPFQco
	LTHHfID7jaV2Qj/0tXz2QgzsaX7jpPWe8mTmKXzu+WaCnNuFeCl3S1/nBLdbztKcFWTy/KqAhZA
	Q+aFrBSddSRz86Dj6m2dJuAi1AS8yDne/Ncn5ctRdDIBmNK2a8p+bXlKEvw==
X-Gm-Gg: ATEYQzzVAsgy1WjW8yzucs8GtSb+SHm3KgbPd1vbGTcJ9XZcrDMv3RyTrXLfR3kE/eu
	ZFVBUWKGwzcWLvpx1dW59u78t11NtlI0WZ/Xw9IK42aRiQFzInAPVVCpcnUzPrtV3qckUSmO3MY
	kekIfIKzSFRwvoWYS0KZZMjb1zMEnQ3kcO+xGRItJayvJiAAqLBSmX8B+lpjyCSzOMYWhlqeUeP
	uc7Bnx2t4KyoMVBUYu7qqFXFkeFKW/2FLV1IbauHX+Zs4h0NXz4JQPnkDDRlknpi/dnZjKxKzrV
	f3GUbditJhsf/b/2VUkAwSBcFaoiEaCrqT9+AtxrJknxvRF2F70HRd+JbLaL2zJVCtmH5683pcT
	/y8jws9FDF+v/faEq2zVYG38Ny2qYrVDT/O0WklqD+QS9f4yPUXqRaJio
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-486f44485b3mr101908105e9.17.1773913957186;
        Thu, 19 Mar 2026 02:52:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-486f44485b3mr101907615e9.17.1773913956651;
        Thu, 19 Mar 2026 02:52:36 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e48ad5sm170628175e9.1.2026.03.19.02.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 02:52:36 -0700 (PDT)
Message-ID: <337a938c-8a03-43f8-8402-745020185b37@redhat.com>
Date: Thu, 19 Mar 2026 10:52:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-269389-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,blackwall.org,nvidia.com,queasysnail.net,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793922C959E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 5:26 AM, Hangbin Liu wrote:
> Currently, master devices (bonding, bridge, team) manually call
> netdev_compute_master_upper_features() scattered throughout their port
> add/remove operations. This approach requires each driver to remember
> to update features at the right times and leads to code duplication.
> 
> The series adds a new ndo_update_offloads callback that is automatically
> invoked during feature updates when upper/lower device relationships change.
> This centralizes the feature computation flow and removes the burden
> from individual drivers.

I'm sorry for the late feedback, but I think the driver cleanup and
simplification is not worthy the core complexity and the new NDO added.

The AI reported issue would probably need very non trivial changes to
both team and bond driver to be addressed.

Most of the cleanups belong to netdev_compute_master_upper_features()
introduction in the failover driver. Factoring out that single change
would be IMHO a better option, if possible.

The new ndo looks controversial. We already have 2 different ndo at
__netdev_update_features() time, with slightly different semantic.
Adding another one feels like a design issue.

/P


