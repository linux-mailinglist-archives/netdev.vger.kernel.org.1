Return-Path: <netdev+bounces-282222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4QLrOAhw8WlugwEAu9opvQ
	(envelope-from <netdev+bounces-282222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:42:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7CF48E657
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E2C304DE80
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7A37F746;
	Wed, 29 Apr 2026 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgRkgMya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25B29D288
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430530; cv=none; b=gxrfu8OJ7cTHGiUY25CiBpHPW2HyYl0dZJ/NxxUbwLQJoJpY3faXhrwXMUo3DH+wyGl4aqX8SF6Tm4YClDNjc94i1HdSqe4xrBxAevYEw9QYK/Nq8HNN2O3gXoui++waJ3GGbRbLLy6ExYh1mCSKeajAaIhGPAimmrHZXBxavXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430530; c=relaxed/simple;
	bh=LkDbRl8tl4kuJoVWU/LkPRmQ1BdTd+x44yvnNxItZoc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bv0qalifAw5x1MnizJpIgb+MQnzJoyv2focbtSnKsDGjAyRs5yxoFtuqjOL3arBZM2yOJHcUMMo8UubXIvcgqqwYay8lQpFuUmu+TSzLbNsr5fu7CfomW0WcM3BjLEghGXxavOullHeqat0HdWWolk6TAAd+Q0P3cZrLq1Z09F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgRkgMya; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bc83e74aso10065130d50.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430528; x=1778035328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsXnDL2f4bjRwOGB8bjtkEsiK3KvwK5FVTY8bFg0h14=;
        b=MgRkgMyaNMTRaHrXtuBhffeMpr/KYJoMfBfg2T3ZJEruqjLmS4hk8bdPkIV52amlZb
         Zhq+oMxNxrHijdijeEb8R77k43+pmUgprm3H0zgbELbMygjQc2jgNpgO/r47Du2KyKkq
         ti8Np0sU6kffkTOYwyu//Y4XcZvKQJYcx/fIZy8Qxh8Q8614BsprEOHYXUtae7kqhsgd
         2wN3Ut1NacZWdVwZr5wDWBWXLfnHkglt/VquAjHkq4PPVmiyzi7HPkZrLoS2uHg21qJm
         A+BJllEyjG9TAYb1ru+D2PSCcJTFmBo7cAFysXF0IAL+4Mu0RPJwwOkuscS2ACw3AI/P
         6zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430528; x=1778035328;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsXnDL2f4bjRwOGB8bjtkEsiK3KvwK5FVTY8bFg0h14=;
        b=AXByXhRwdcPsKQza8qgB6sXB4EFZnxsu6by9QyPJU7PmaDAf+OQ2orHXhm0jV8B8T9
         3R0CF/gCKVM990xRE354lDAt66/bpK+JOww+sZgqBSAOQ9upegLq938p7v6zMBqlv+In
         D+8hQNb+dUx26NE7rNcqAbdf75Rv34ErPkCe9+9Nn6iWbCQQYwxNB9ileGRQFWVoo4Fs
         6CEK3UI72SyKBKmvFuaA7aqzOD8JO9RG/Ci86G+g7zqVnXRE0SyXOzTj5z14Wpj5m2hJ
         /5in9Ejufuez9YIJn/sTJquA2TzC//FbbPxTtt7XiZDQ2RGqQa5wcEvDeihULoZk275r
         Zh7w==
X-Forwarded-Encrypted: i=1; AFNElJ9a8x/9jSBTsfDsv/b6Cetjb+Wr8ryoa1xMGIM7fQrCf9POyhwh7XcHVcBDeXZ32dt5/XA2pf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjsSNVl/J5ViZb+SAeGNoE//FuS0c5tVLdUVcqfs9SmvmzLYj
	51eDTlWaMKO9B7Ne6QC9UprP0qYTQE2eiwU2BaZXc8ZRSFrBQ/RxEhzC
X-Gm-Gg: AeBDietK+RcUur63RopKDkbohIFCQE3VonnYY9dJszqjSwUj3wpP2hVHFHmiVpivqGN
	SPIVgGZo2Ot9RTjVjVxe3sabq7i4EaNkHFTRc7OgPFa74W7eJWnV7C5WuCAyH57tKg/gDTXk7P1
	kNDTtEOBq+XL18hMyX3vRLkEqMftU4jsKWO0At9XZjoz+lWpyZW5kn7XFfPqT/DJNMBJkG+mM8h
	T111brmFHBUdAoZAGbHMTXqDsuC07p1NLfQ//pon10I5RDOHqCTnqSiW+myhVnHGFSjbv5bpiPg
	SdGwJ0GnX8/6i5DPUfaknqKZQvb0i0XJVKv2Pi5I2aWYjCeR/cBTzJOwmHSlKFq21jr7mSDu0kG
	n+21JA4tS513cWKKN4ZxtMRW2EnBlqkna1oYkFbSdLKtZ22qNhPZO2Lrw/lb0UDtE6zit+BakHJ
	Pvpj0jPzlmWs9oRuE1JYllleHp+gWHvSm28UfpvWfDRH5CIIS31IznLF1NkANq5uboox2r+UO0j
	gZXtX9SsxypyKE=
X-Received: by 2002:a53:a581:0:b0:650:77f4:60d with SMTP id 956f58d0204a3-65bfb708f88mr1799680d50.53.1777430528048;
        Tue, 28 Apr 2026 19:42:08 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff6c9302sm663569d50.10.2026.04.28.19.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 19:42:07 -0700 (PDT)
Date: Tue, 28 Apr 2026 22:42:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 daniel.zahka@gmail.com
Message-ID: <willemdebruijn.kernel.a64bb369b0ea@gmail.com>
In-Reply-To: <20260428184336.2244b6a1@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
 <20260428205352.1247325-4-kuba@kernel.org>
 <willemdebruijn.kernel.223eebd28b57a@gmail.com>
 <20260428184336.2244b6a1@kernel.org>
Subject: Re: [PATCH net-next 3/3] psp: validate IPv4 header fields in
 psp_dev_rcv()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B7CF48E657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282222-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 20:22:34 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > psp_dev_rcv() is called from the NIC driver's RX completion path
> > > before the frame reaches ip_rcv_core(), so the IP header has not
> > > been validated in SW, yet. We expect that the device has done
> > > all this validation, but let's also add the SW checks, to avoid
> > > surprises.  
> > 
> > If devices are expected to have verified this, should these be more
> > noisy checks, similar to netdev_rx_csum_fault?
> 
> Maybe "expect" is a bit of a strong word, I meant "anticipate" /
> "suspect". Dropping invalid packet in SW doesn't seem like a huge
> problem, other paths in this function already do. For rx csum the
> problem is that we got a incorrectly math'ed out value for what is
> likely a valid packet.
> 
> That's just to explain my thinking, if you prefer we warn / dump skb
> I can respin.

No, sounds good.

Reviewed-by: Willem de Bruijn <willemb@google.com>


