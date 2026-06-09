Return-Path: <netdev+bounces-297322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GBz3NBCOKGreGAMAu9opvQ
	(envelope-from <netdev+bounces-297322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:05:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 723EE6646C7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SsBXGj7H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297322-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB94F3043EE1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9823E5EC5;
	Tue,  9 Jun 2026 22:05:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F5331EA2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:05:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042701; cv=none; b=MObAPfSf/XioAaEfUPXUBjlhg4iG98RxymZzfu4Vqc3Q0MZUeb6xtCYzGZywSezHLeluSWXU7+dC5M5YScu9YNJL8b1hrEugDoLgvEgF/WVY6JRykv8Zqt9zM+TO/MpGpsA7HbZmyWYnA1Z7PcpXxDfXk5V8zXobVQ2uV3PpBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042701; c=relaxed/simple;
	bh=CmC5qziwznS7Kex6cuqYcE42ivbcGfXZ8w+wCL8lwbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDx0yPaPq91Kmajbe82EsKfxELEyKvy5wP18dNpJI4P0Fu3ljHtgOyaxl2MspnJxvWF5Uyc7ZqRuparkIRcIDggzU7j8gAaA2SnzjaDMCpz94CSGcZY8XzNeZMFSfV0iqxQB0ifaHXTMxOKI6XJFqasvtafyYo1I1zdqCUVvpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsBXGj7H; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so3656606a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781042699; x=1781647499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wt3b+Deif3nXdjZDbgXojibEH3nr7iYn6iIVS7zLH/A=;
        b=SsBXGj7HmgMkx2KmaqBk3p2CVMN3yzsutXqKCvjXDUzk0U8GXHgm/cH9ndDTqTSVNH
         RmQLxOFdtlq8fcsu+bIwGA3/mmbw3hZ9/flB+GD3FHVDdkwz2UUCtbrTxgdARQlRZdFA
         hbJXgtNL8l8LEh3cZdz2qrE+wswnL9Mh/tTO/Efc15ht676DhAsLjm3t91QGEX/Cr4yJ
         skgS6UzhfF7lJkjkyZKHrs1BYrNJw58ilJrDTZK4G4k4OtkUD78YKJPtbTqYnkM96bKK
         O9cdfGOWESbZ8mxtuN8fSKQlHu+6/iQLLpV//c80BpgSDlrpKkemB0aWjdkyjwZA9n8G
         018g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042699; x=1781647499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt3b+Deif3nXdjZDbgXojibEH3nr7iYn6iIVS7zLH/A=;
        b=aZGT5rPKVvSG3Io9WbtPEZ1gQJ7ldA2msePAurb5lb1rXmnbxTT1ZwUrZiYwERM1kj
         SZEjnK5wsCmKIZpq2s/rRI05069sLdtJPz3z1ns3AS5sdqjMrikqQAMmBb+n6g5mW+zd
         kvWVPrfcLKc9i3yLZafvoMJ7bF+sSjAgDVVEm5UdG6hRgmC1n02ht5Pixx4yLBzs/KP+
         7s4qH1d/bDTq5ziO0HKVFiYXM07mK09FhYbPy9WwnGSfFYdYBm8zCycLMblGwCu+BRKw
         xW8qddaRssBktl/m/DSEF4Q2wfU+p7GEbqOu3vFd5fpo3v3BA2BObB5v2Wh5DN8Nja/h
         H6ig==
X-Forwarded-Encrypted: i=1; AFNElJ9kR15XgEKLZqxdZcJeaZZ0GtJzGQiuHVCCcyQ9dXwF1Y+dH7E26EHOlM1IhUMIOwbqv/LlYis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfcc/FVROT6kLxh0UfLRxQvnXbnBO2zV1ZKleB+zQixbDAb6gg
	g/i2ffqcqWPTbQQxuuwJ8VUiyzhVCI29raGycz5u5rE73bQE6/6iLzbm
X-Gm-Gg: Acq92OEFcvL5g1VZYvE37AfSWbr4R9HdjOeqXLEHwI4S7sAfeqbRV9gJVAtlWYolZO4
	6Q9QhCokGmu41xv12GigUntq4OdtgR7XPEaw88YDH/GUFYiDhNYw11YL70IXwfANoAYZ/gsJBzT
	RQBeiGwyAXppr/1Ptg4gPerGxVvUYaICntyxHHIn5p4qJoeSnplc/m4balMZmI7SBiX/wcXhhXi
	angTbwAKUrAoYrSs1ai4/beiLHiZgBVfAVD+QNP8uKgBBQ/aZKyErBTcwvAQgXY9kKf8YyhXGdd
	LjKz+GZ0A3OF4rG0AV6aERjwWaKnpjoo4jz8aFIUag8OSMP6uWm51Jaf8hi82S6Hslx5jBul7US
	G5nwyWJOizERdBgNGzylvfPXRVUpTuzFMOhohMQxTR5sL9yapd2zKa7rWQ53Ou6Q48s/GpM/hTD
	dUFwKT1Fd7v+8ivWScfpPfyv/D1koFKPdq2DSkwu05UMb1H3ig9UfWbDY=
X-Received: by 2002:a17:90b:4b04:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-370ee5444e7mr22928910a91.2.1781042699375;
        Tue, 09 Jun 2026 15:04:59 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37626873b88sm294358a91.0.2026.06.09.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:04:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:04:57 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 3/4] netdev: avoid skipping objects on race with
 device disappearance
Message-ID: <aiiOCRpmdFcOf/yJ@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-4-kuba@kernel.org>
 <aihwlI9A2TKktq9I@devvm29614.prn0.facebook.com>
 <aih0ST30H9rlKX2f@devvm29614.prn0.facebook.com>
 <20260609141914.2957de35@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609141914.2957de35@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297322-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 723EE6646C7

On Tue, Jun 09, 2026 at 02:19:14PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Jun 2026 13:15:05 -0700 Bobby Eshleman wrote:
> > I just noticed we handle this differently in rtnetlink with
> > cb->seq/dev_base_seq/nl_dump_check_consistent(), but it seems like
> > netdev-genl.c intentionally does not use NLM_F_DUMP_INTR?
> 
> Intentionally is a strong word, but yes, it's "known".
> 
> My mental model is that DUMP_INTR is required when we are dumping
> unordered lists. In those cases we just count "how many objects
> were already dumped", so if we dumped 4 objects then object #1 is
> removed the dump will resume from object which was previously #6
> thinking that it's #5 and #5 will never be dumped.
> 
> In netdev objects have ordered IDs, we don't count.
> 
> But in theory we probably maybe should also indicate consistency.
> Nobody seems to care in practice.

gotcha, thanks for the clarification.

-Bobby

