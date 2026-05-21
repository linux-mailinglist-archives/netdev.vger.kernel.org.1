Return-Path: <netdev+bounces-290398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCXLH1n9DmrrDwYAu9opvQ
	(envelope-from <netdev+bounces-290398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C775A4F70
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67074303D2CD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7E3D1712;
	Thu, 21 May 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="eHS9VtRx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1A3CF05B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366882; cv=none; b=jQBJ7grchZwHhjuL6P9ercG06nA3EuMaXleyh5xRh/TtDjvuTOJwF5PaN12X/oR76R6M0fUn1QeaR3QJPrZmJeXN76p/j4qJetzQGyvy6KZtwixejnA99u0MWoUJTwOQuS/bjPA2CDi1GaWOK36fh599h3wcVm3zsxKMI6YbdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366882; c=relaxed/simple;
	bh=OIWPqSThIXz6QkyOoowPul59qYNL9Vt4QmCBHLMe8Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou8bpFk0Zc2kJQph+jEphTlymAJTikHbmvyJpwa0jsdHMofxU6BM2Cj+0LQkJ469rdn11NuaPMgJndRwyMyY6HClkDZBQ2gTWoHffcfcNpQMRv+A1J829+ryHy6uGg0YA6vDEL2r7yuMY4v2UpXtoIYC2PXHLfVFjsnPyyHuFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=eHS9VtRx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ea5252a63so44918f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779366878; x=1779971678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72FTf+nx/w2/qV444w6muOfwzxuqRZsZ1yO2xcnGaH0=;
        b=eHS9VtRxQjbIJMPk0UjdgnoQNVhhrzW524WirNDZSwfAv9oxif9cHdDK4jn+lma3b5
         6tz/lDpoDX2z8Yymp1TZXZr4zOp+OfHXOM9R7/X0UShtkY8ou86nT/oJLRfVFFL1dd2H
         TeCmC08Gi0o7+VXyX316W3b2JJyFPq96TC5+yRlnbXaJ5CJA45XslObLY3/x41XR4PEr
         9xFWoro8JTvvQt7mNKaWLVibaaxOfPrZjYD4m6QkEyav2nRNoR6rOwGJ4WtYhNVk5hWQ
         PJiiarvtmOfGqsDzaWVi1iqzETK5KbvihPeNOWY9HLVx59zS1avRv7QBc1gxJ78TTnTJ
         c9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366878; x=1779971678;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72FTf+nx/w2/qV444w6muOfwzxuqRZsZ1yO2xcnGaH0=;
        b=G8GoR2ApbXdmDH7ta1dkn71hHOJ8YrimS3P+cDlVQWJ1sXnKnjVql1JukEPOD3ZbUZ
         YLKNqX1cgyXD4e7uTVwnffUootkckipzxknefCxHw8wfDQYMbQotyLO55Lm90FPksTbx
         jG7jCZWSzl664iBCGjnEgpiM1zw/Hf2C3BH1sX2nr8gWCoD95TSmvehB3o6R5R5LB2aX
         irbaSpheofBKDDu6+8bI2tBQ+IEluEzEWy8gmLVckdMTPIPILM+4dUXLD5J6JZRkEe46
         892dlqSStYBq8A1OfNIYsgZ8uoNp5Ave2P1H/dZc/3WF9C8h9i0jJ7Z5bKT1opg8jV0b
         c3gw==
X-Forwarded-Encrypted: i=1; AFNElJ+TrFJzz/fbwQVqjvzSclPZcwUkEHKa3ZHSgA/hXhnkXNdMMG6OTStLqnKHThZACmgkHIYre3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9uP8xWX1aqdbKl5kCfwN5crl557eFtvusPBM/l0QtNvaoDr2
	Rtesk4wGA38amljpIsgO4z1OXpQNRKHN4zPA77jf6FKRLffZBIy5e3v3irrWCecuNfQ=
X-Gm-Gg: Acq92OHDrsDmc3M9VTQwA1ODbwzNF9k942SKzB+AQpkkIFdkBw9D4f/qvxt0pcQV9uI
	mYQw/w65hApLIrxyJ1afQVPb2h/KWrHEGzMzsPcqQZCcbd8IEHDSnvn+mCjvh3mlFPawMrftj6F
	34BwSMz3iqibZGDOw7p4+/Hm41d35JWJwphDakK478nKg/HD6LZzm3aPrJkBVKoFwjohdNIsUv3
	JDeHGA7/eJvVwIu0tlPmWuRIvXxMAdqB6IKkyXwfwophyxydfJEftVqYqtrqZ25zm0iiZKpOPZT
	Ogo//qqXgfQETLEz3yIrvSSU6dAWNX0UZIXiLmdqeG4nKbqPz8EMj+OtYkdTmgWRDchQrkNeQOl
	carXyccNDB1wGxxQoHb8+YlgxpSbpZZNx2LqbhV7KqTg8hjnbxeZ7heSfr/i068HjSjlDSzRkWw
	WzuSgSW38Murt1IVfmaiNhHAuayAkL/dAIEKTT+7mTBT1luBkVFo7nSDo/9sJdU0VCyZ0rTStuO
	S2o
X-Received: by 2002:a05:6000:1861:b0:45e:8c3e:8591 with SMTP id ffacd0b85a97d-45ea34836d4mr2228063f8f.0.1779366877751;
        Thu, 21 May 2026 05:34:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92f622sm2840823f8f.24.2026.05.21.05.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:34:37 -0700 (PDT)
Message-ID: <0a77c5c1-8680-447e-b9aa-c73600b107ae@6wind.com>
Date: Thu, 21 May 2026 14:34:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 1/4] net: netlink: fix sending unassigned nsid
 after assigned one
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-2-i.maximets@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260520172317.175168-2-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	TAGGED_FROM(0.00)[bounces-290398-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6wind.com:replyto,6wind.com:email,6wind.com:mid,6wind.com:dkim,ovn.org:email]
X-Rspamd-Queue-Id: 28C775A4F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 20/05/2026 à 19:22, Ilya Maximets a écrit :
> If the current skb is not shared, it is re-used directly for all the
> sockets subscribed to the notification.  If we have remote all-nsid
> socket receiving a message first, then the 'nsid_is_set' will be
> set to 'true'.  If the nsid is NOT_ASSIGNED for the next socket in
> the list, the 'nsid_is_set' will remain 'true' and the negative value
> is be delivered to the user space.  All subsequent nsid values will be
> delivered as well, since there is no code path that sets the flag
> back to 'false'.
> 
> Fix that by always dropping the flag to 'false' first.
> 
> Fixes: 7212462fa6fd ("netlink: don't send unknown nsid")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

