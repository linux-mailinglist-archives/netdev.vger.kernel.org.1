Return-Path: <netdev+bounces-280687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEdzE23r6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2244FFFD
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C56B3044BBD
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE503E558E;
	Thu, 23 Apr 2026 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwYT88+y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rx7VUmfM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8873E51F6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937459; cv=none; b=aIZgEstr0Dg0p2ZnfpN29m7Q/e4j8j0j11QGt3olqrrRZC7CPMBZDFTFtBPU1I1DnhsKJheQ7qY6SvOfMHKFF0Bv+8XYxTusR38FwIVpU/VGSLC5Am3epAoTir8CpZG5qQE9SUd95gYVr+Rmqm3TVCUpJDMMDfr/Wc+qcEja+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937459; c=relaxed/simple;
	bh=Z/92kxlTMapvm6iTYEtSUelcWsiZw6+p+av2N6I37V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYWRrzddpYAiCST36FFUPMJ125ZvqR1NfAbg6nahrv+ORgkjtIE0OzBHpzuowkgMmfkWHR3Idsi+VmCzXFhHJDTLmNnEw6TkAib1cN9sb3nBnC6WGn1+BMesZ9Y9URpO9MQSVXrKP6TNQwazkRLdyXqJ3CYeyEPG8vy4cDB7kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwYT88+y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rx7VUmfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776937455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Czf+kEL9BcsX5OJ1yNM5tadNHCEbw6TrzapGuBP20Y=;
	b=PwYT88+y0yj1hD6HNPAYSUWX8STw+Fnn78s+trZ4lzFeRvDAxzHcK6+Km0kR/3R2iJJxnZ
	qgC/c3GdZ6mIr6qmR91syWH8tE7Df2AeQRs8/WWSb4is6H2iNfveHSagocbotmj3LRqH3N
	8/HvEx1Y6BjjrbMfGNdfO/amNJw4bZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-I7TypvCtMkiTrbNjAtnViA-1; Thu, 23 Apr 2026 05:44:13 -0400
X-MC-Unique: I7TypvCtMkiTrbNjAtnViA-1
X-Mimecast-MFC-AGG-ID: I7TypvCtMkiTrbNjAtnViA_1776937452
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so62896345e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 02:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776937452; x=1777542252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Czf+kEL9BcsX5OJ1yNM5tadNHCEbw6TrzapGuBP20Y=;
        b=Rx7VUmfMi3VBEGYuUrSO9Hz8ad3UdVfNhMlcMEfznuZsuenkg05IHDWYgIoU6ge2pl
         dvH/c/2S5GBRk3bvNeJ/5HXjPn7Qbw8nKI9xLtBtqbhfB8sZVtDpAXZ+hYqCaRnwM17M
         xD7r4zFaNBgj4Oq9bVLxX0UxqOYPnpOBZS5UZT2zrVSkiZPTd1RS3KaYp+tClIHPVOjo
         Ndpl4eV2jE+pn8IQkeZBCtVT+KyO5Fe4XxLUOQcm7DGiV8Fe3m+dA70ahTFopJnRhdc7
         3UzhTABhx/R4U9jHUs0yHXBkrsFcvxG9I8fu62V2cf39X7z8y9ZLPKHzt+LLyXMqQetN
         JiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937452; x=1777542252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Czf+kEL9BcsX5OJ1yNM5tadNHCEbw6TrzapGuBP20Y=;
        b=iVwa48iXdkhVUPzNf29a25PjhdktKckxb7O/qxV3nQlCKnvC4hy7LTbz2impBKI0/S
         Bd9l2XPj/+BFzPuhplNwq22PjfFloYuIah9EKLYan5y2B9qLjLu/RsDAGQMyNN/zLcDV
         84ljFQ7vYs4xP+OgT49gRqnXE0dUKJlzcvF7lzNSM2H1xNFUnkmxAR9ReeALgTRPst6j
         aKylJzrJeURL0CIDvFoolXUkh3BArd3J6yiHe/fNAfiyxunGamaNRc6Wt4V7wsSdl2wk
         rGG9/SbueXBvDUV3qnd3ox/kHL6XhdJ7Qqidh6k79hl3y3EupCiSHqM8jdz4dT6c0SiN
         cyWg==
X-Forwarded-Encrypted: i=1; AFNElJ8IpqSbZY29Mh8Kx84q2C9LS9MXyCCNc7QVtLdGG57/Gdc+dlt2c+dXa0//QOf015gmLrm7NH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy4Aa3yeDx+8HV93Us323F7mT05T61JPiD6oK902wHQUMd+wY
	RdjaTXUT5WXhrOsd9gqVVMbNJsLSiA9U3A+qqOc/Kl/+ns/or9y/ZmqocvKserictju0ITgJXSk
	w7URUgb5DMqGB3KXmU79D5MSIDNeTcA65Msxox14gU3ULsiDzo2EnTM4Vfg==
X-Gm-Gg: AeBDiev7OvIQlAmUtHc90pp0BOAQ4uALtsqcXaWnl4JogyXQJwvSeOpz0a7L1qmJ0OZ
	dDj4cMnUN0n6+A2vwXsr5J6hfTzoK4sv4Hnr2ik7PX79sNuervA+izpBCYjODESCv7+eHWSbJ2u
	7i61MRgbQYm5N7bLlXhWGfpyXmI0VEbAMV9h7OI+DRUI5360Rwcz60TZr4LbSCuYdpezvVhe0ha
	HH5MfA0ywj9/kNpPa6+jgcylpZC9P8bC8vbpC/NIp/R8GNg6P00al+9bRb5f7h0NR+WneBSM6Q+
	/KXDGlBhFGfAsny+PHJK+bi3Hy+sJV9oVXDvwgFXHs0i2oBVQzQLlSGgT+/BVcCUsW76QN7OSgx
	vKi1/ypxE9KgENjHMORcu7PmPfLJNf6y8xZ3SGdSWr45i53Up4I+ZaR9uPtTHFOd64b4=
X-Received: by 2002:a05:600c:2d91:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48a5301bc69mr110956315e9.16.1776937452429;
        Thu, 23 Apr 2026 02:44:12 -0700 (PDT)
X-Received: by 2002:a05:600c:2d91:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48a5301bc69mr110956115e9.16.1776937451954;
        Thu, 23 Apr 2026 02:44:11 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm157378285e9.18.2026.04.23.02.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 02:44:11 -0700 (PDT)
Message-ID: <a93c34d6-8c9f-417e-9ed2-ff4a9f668d11@redhat.com>
Date: Thu, 23 Apr 2026 11:44:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 0/11] octeontx2-af: npc: cn20k: MCAM fixes
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, dan.carpenter@linaro.org
References: <20260420023442.3295891-1-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420023442.3295891-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280687-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3C2244FFFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 4:34 AM, Ratheesh Kannoth wrote:
> This series tightens Marvell OcteonTX2 AF NPC support for CN20K
> silicon around MCAM key typing, optional debugfs setup, defrag
> allocation rollback, x2 versus x4 KEX profiles and default-rule
> allocation, logical MCAM clear and configuration, default-rule index
> bookkeeping and explicit teardown, and NIXLF reserved-slot lookup when
> default rules are missing.
> 
> Patches 1 through 3 focus on AF error handling: propagate
> npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config,
> copy, and read paths; treat cn20k NPC debugfs files as optional so
> probe does not fail when debugfs is unavailable; and fix defrag MCAM
> allocation rollback so allocation errno is not overwritten by subbank
> index resolution.
> 
> Patches 4 and 5 align default-rule and flow-install behaviour with the
> loaded mkex profile: prefer x4 default entries when the profile is x4,
> and reject x4 flow keys when the profile is strictly x2.
> 
> Patches 6 through 8 refine cn20k MCAM programming: clear entries by
> logical index and resolved key width, fix bank and CFG sequencing in
> npc_cn20k_config_mcam_entry(), and read action metadata from the
> correct bank in npc_cn20k_read_mcam_entry().
> 
> Patches 9 through 11 complete default-rule lifecycle handling:
> initialize all default-rule index outputs up front, tear down default
> MCAM rules explicitly (coordinated with npc_mcam_free_all_entries()),
> and reject USHRT_MAX sentinel indices in npc_get_nixlf_mcam_index()
> for cn20k.
> 
> Ratheesh Kannoth (11):
>   octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
>   octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in
>   init
>   octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc
>   rollback
>   octeontx2-af: npc: cn20k: Make default entries as x4.
>   octeontx2-af: npc: cn20k: Reject request for x4 entries in x2
>   profile.
>   octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
>   octeontx2-af: npc: cn20k: Fix bank value.
>   octeontx2-af: npc: cn20k: Fix MCAM actions read
>   octeontx2-af: npc: cn20k: Initialize default-rule index outputs up
>   front
>   octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on
>   free
>   octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> --
> v1 -> v2: Addressed simon comments. Added more patch fixes to this series.
> 	https://lore.kernel.org/netdev/20260418162013.GG280379@horms.kernel.org/

I strongly suggest avoid extending a series to address issues found by
the AI review, unless such issues are actual regressions/problems
introduced by the new code. Sashiko tends to find a lot of collateral
problem and the series could easily expand beyond any hope of merging.

Instead you should reply on the ML, commenting on sashiko's review,
explain why or why not the outlined problems are valid and/or should be
handled separately.

Thanks,

Paolo


