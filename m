Return-Path: <netdev+bounces-256511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDxEBQCpgmk2XgMAu9opvQ
	(envelope-from <netdev+bounces-256511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3AE0AAB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56E3E30B3B3F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF372163B2;
	Wed,  4 Feb 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYf46rwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E412AE77
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170621; cv=none; b=UvC9qEv+cTY8dt73nfpQgIu1XFn6HOQ6VyY9aHwqHtOXTw454oOYxwem9NF/QiDCtayR1RMbW8iU7n7pNxGlF5xtTqs58jSeSxBllmK5ofeOvbBIgdguDWSAshSSLLuBcOTuMiyUNY112PG/CB1ZWujWubkTZLl8xJE4zQBfU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170621; c=relaxed/simple;
	bh=T1vd9mg1yWl/lMzXf4IwfNdF2cIDbwFbnp2BYJnLnUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hicRAw09I869ouRRRo544Bb4UbWks37TgNmHf8qu6cqgLtMAgkWiicgMLcdITN1tVgUF+MctfQDwgVyfZ/jwQbUke8RDK0OFq5rhSbbMLQTSqLTrJAeNDLl2xoS6OYph4iTzyJQ5H4tzBLA5URn7IjwgN6UYCzjsVP5jOCAZJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYf46rwU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso271485a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 18:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770170620; x=1770775420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ALkrvouXDX1bkJ5I93gQd+svVXtDxd7uZ3bzwQMI7Q=;
        b=bYf46rwULID4f0iYwDmVgD0hR0AH5v/9zvva5rQew7fu9zgsikYnfZMSRxeFrJOQy2
         6ccmCnQwrUBSNpqZOZQER0gLzRBx0XUDpryiB0lL+ZVIrMYCjZGaBfSC7mb1zXj5bJgY
         tRdoClSG+WAFHa6uiyzw5GOS3Qb14ja44HMHZdilPqiXwaasIUKEQmRY3btcZQqaTjTA
         GCp0ujKF0nHO0Gx2HYE0ms38yzPu4S+1DOTaExCnYMuBSnscv//Bz10c/A0lqHsMBaDA
         FgH7MYZgy+mPBQKN5FFOVUB5cc8b/DTvXYS1nIEeQkH2+LYEqAbWEZW+7cE4X14oTWcO
         S8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770170620; x=1770775420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ALkrvouXDX1bkJ5I93gQd+svVXtDxd7uZ3bzwQMI7Q=;
        b=pmL9fFQpFKECOaO2OA27XmJnF23hDSefIF44tci3LFYRw+XEPYE4c3Ngfo/jylK3b+
         yhIOPryGs5wuS+SeL8bLCl0BDMEtnZfv4mUpqwt3spUGH9CEWAsZBh8Zu+A9veNUUO3n
         P1VcbhF3daplUmILH2CIy7Yzu/nt1jjw1q+hoWI22BVqE6k4lF80b8ayMvkIs2C2LSQT
         pN1WU6ruitbxJDlSWZnQN1RDRC5NRfrZiJbyw0vY7B9J/BWnnAFS8cOHD60b+CZ3oORI
         dMjO6n3izRJm2eTH0QNn7f57n+4isitGj3MU6XmqzE2Bu7+PLl/MzFLxJHMwt687B+6i
         4TRg==
X-Forwarded-Encrypted: i=1; AJvYcCUFe2lc19LdqEB5NNyN+9KhDqYevm6LuCOddOlrZg6YrZgnje9GduL9XFfGjpXddBbc9Zm9ibs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfhob1zrP/R1deuPZi5nXrVFnpZ+Ob2sKxKr6hP+rIQMKc6Tl
	GjvwzBL33nygw7MB0+cV8kdxJor++uIxFGmNA08+Ie1+LPB0berP5pg=
X-Gm-Gg: AZuq6aJk5zfk7GlzTPDR687yWor3WZ8tIeVuSgKjBsIbvZwiqP5AldSBu0evwnhr372
	FLgeFfDCTuGj5pT0fIOxptwuBlNMrsrKJjzwmtgbYw75s8xYuMK7EZfHDF/0S9Q1Joady5uCDM9
	34EoDYtD1neZnglhyLsHqWfLWNljIVWBk2DR44+j0RnGwWIw4Yx3c8wPEXHBiv5XDFiIzGVxRVp
	pkmDQ86F0KKZWR+3qGbqP8E12GUydClSmWCaxyEJ9Byi2m/eF9VORYwCoeLiVYXxIDp3Bvjqff2
	o0zJqrFbDTE6lBi4XSelmBb7b0R0v7TMhNUyUTodWTHqrUcy4RE541WHmzFtMUxViufIIyF9E9G
	9RihRpf2T0qODU8Ygk6Bg4aVAZkcXPmdKMPBRSFiAF2Q/a/6+uJQaxaL/pz9+4/UxKb8RjiWQ0H
	z7myEbTuj3/OVtqxt9Q50JkNNFm1LRTEj11167rwNEi4piovyYoeKihGBV0Zz8U3Ah9jmJZwzo1
	b+X7Q==
X-Received: by 2002:a17:90b:3d12:b0:34c:a35d:de1b with SMTP id 98e67ed59e1d1-3548721960amr1024115a91.37.1770170619361;
        Tue, 03 Feb 2026 18:03:39 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354894acb47sm174006a91.10.2026.02.03.18.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:03:38 -0800 (PST)
Date: Tue, 3 Feb 2026 18:03:37 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Rao, Nikhil" <nikhirao@amd.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	sdf@fomichev.me, netdev@vger.kernel.org
Subject: Re: net/xdp: Potential issue with xp_aligned_validate_desc() in
 multi-buffer packets
Message-ID: <aYKo-YeGpsl8ngeK@mini-arch>
References: <c4b5955a-8ec6-47ac-913d-4a959e0b477e@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4b5955a-8ec6-47ac-913d-4a959e0b477e@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256511-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81D3AE0AAB
X-Rspamd-Action: no action

On 02/03, Rao, Nikhil wrote:
> Hi XDP maintainers,
> 
> I have noticed a potential issue with multi-buffer packet support in the
> xp_aligned_validate_desc() function in net/xdp/xsk_queue.h.
> 
> In xp_aligned_validate_desc(), the validation always adjusts the address
> and length by pool->tx_metadata_len:
> 
>   u64 addr = desc->addr - pool->tx_metadata_len;
>   u64 len = desc->len + pool->tx_metadata_len;
> 
> However, in multi-buffer XDP packets, only the first descriptor contains
> TX metadata. Subsequent descriptors do not have
> metadata and should not be validated with this adjustment.
> 
> This causes validation failures for the 2nd buffer onward in
> multi-buffer packets when TX metadata is enabled.
> 
> The same issue exists in xp_unaligned_validate_desc() as well.
> 
> I'm happy to submit a patch if this is indeed a bug. Please let me know
> your thoughts.

I think your assessment is correct. Can you try to extend
prog_tests/xdp_metadata.c to send a mbuf packet? I don't think we have
any real test coverage for the metadata+mbuf..

