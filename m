Return-Path: <netdev+bounces-306487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WeXIAVG+UGrW4QIAu9opvQ
	(envelope-from <netdev+bounces-306487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83341739310
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:41:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AP6GEjb4;
	dkim=pass header.d=redhat.com header.s=google header.b=htrIYytj;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306487-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306487-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABA3300D46A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90663F58F7;
	Fri, 10 Jul 2026 09:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966E3F58EA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676356; cv=none; b=TA8ubyySMInLJxg7pqpsCQUNbInCB1XFyeky5MnWmvfmmSphvymezAllrjjkgKWKUTzczLd3Ua++cq3eNdqnGTEbuj4QoQ5Xl9xweVgE5UHD5bSkrRQKnZt/XUi7lF86tjWjX1/pwgYr7cRQPp1y0I/VhZH4yAeEnjWmyPiuwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676356; c=relaxed/simple;
	bh=tMcFLGQQp6kEB4sPtUNZgVVh+m9JR0FwtLdYZracIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9SMf+wGn43WMAEDsppjSUGYl4cpsr8wsrTdiBDlkF6zLuCB2EcGEd4zlTVQZuH4xxYMI094Ffk7qCcV9MC65tiX0IV7DE0wtZ5WwM0R+06ALCwbSRfgpkz+Yb48L1BTE4JqmLq4jSi7IZi97/c1znLNZopbsbq96DTSfqUpUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AP6GEjb4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=htrIYytj; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783676354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
	b=AP6GEjb490rkM1XnT5ict1sV72yymoKZS9lqWkb5UHv9017VjoZGVpJPbnfGDPeUlhKA0k
	SvzRd+A9sDK6FAC3m3Yh+9rtVmDD7EWR2tLI72A7cbHcZ1cvZh7etn6Tbfljo3NwQmiOP8
	tLBFvc1fz048DU3LCYNGMfk3Br/fUvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-s20U7jwEO_SBomZteHPkgA-1; Fri, 10 Jul 2026 05:39:12 -0400
X-MC-Unique: s20U7jwEO_SBomZteHPkgA-1
X-Mimecast-MFC-AGG-ID: s20U7jwEO_SBomZteHPkgA_1783676351
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473941177b0so601662f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783676351; x=1784281151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
        b=htrIYytjmnFUBerwB057efRfFPOADomWjSj4yawSx6mVdxeqWVJ2QTfoQG1N+Zbv3Z
         KSCTnS7uKRnd7pQN757mTQbwyIKkyM7lq6OxkU9EiGepuScwM/YS5hYzXLeyNgk0xfMC
         zNox7q+LHtWe8aBWAqGd1i8oHIMHLxA+GTjRuIXGBhIGJvjvfaalnZtdo8JoPped2JFG
         zkXB3/lxVxKoDIYt3tIepR2RUCP0ROVXwxb1P4tQWyXhICQCdo69DS4tD4xdoNO7Si+I
         ov2GYxKXiX4dAU5Q1omSqGi7iskWrXQLBjkdWKWzLe4vC8FUVtiT0qxpIgDj+1ILFDe1
         nIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676351; x=1784281151;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
        b=pgfceCDYWuDH0K+WTv4X8d8/1NrYl2hHKbpHQ5sQUpwx2gZ2ju0SaaaWDNB+F1Ov/M
         lHeEHez7zBpAQSXvJffbQ15jmbuAVT9Q86TAIivYUahAQ8FidyWFRn7A9wL1EB1wZl0p
         ks/dUloe9hjnHjTxuo4NNfd+6GNUiFwcOox4d6FIEhPTD9SNytHCVoDTI5+PEBqTwpmY
         1IjOKNMhDmzryUsNqTJtUvJgkpIcWY+oRl1GqBRwppMC+U8FQlOJvmhmGFlHZqe3U4U0
         Nb3et+nqyBvbhGpjhAnH0eo36QZ1Ry1QOZVOJeV91DBMCCFvkRD1iQ2uFNIdPaLv6+ks
         wxoA==
X-Forwarded-Encrypted: i=1; AHgh+Rrr6+B2MXt5wMHvKW544PkuytO+ir/2/r5gQARItR9usX4S0VvsRcbX9mWlP0Dp7aRJq86xlQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8oE9KztpFkcN2zWW/fDQ9TytBnfMNLsdnKfXI1XFDlvC0WJ8
	ixa+CnEO+DROvRdGBYVdij4WE0w8eebiRQlZHi3df9z7DmCX5FaroanWTRheObHtR1SutMdbm2D
	RacxEKRgsR5WH39J+vNDtng8WG1uAsFGShMI7Km+UgCRtj6D2i7Ou8OoB5g==
X-Gm-Gg: AfdE7cn2ngdHPLP1jZ0Re/ahpfAuQv8A0bRNDel6SrOYEeXRnAAHUwPsdbzkUkZIqmu
	WynURHzYNTzot+HqmZLlTEf/3JyPUrZ+HUmUTd6Es/nqBgNIUVUn4NjwHzVeTbUoiQ13Bi52qK+
	1lbeKcTdv8G/GOLCXknEWuYHk5qrAV449ffkhjPt+VU+1NkzdCQjooSCqMmf8J272+26CigPBGl
	8O46+qE7sHpdCakAx/rZtMMm7oTuafxn430d6S3ECdveqIbQmvLaDqvPrHGDXQ5yRPRu8KRD6ay
	nhlK4a88xDWclWbSFBjeQJua+Yb467ZJzVYai19sPMgN6nt/Vdb/13f2sBEryvvkVfoxSJaguR5
	PnRkUA20+6TTLo801z61halzrYrP5TQ7IJCFCrDXowCEbSDgR81qyoXIB+2iMqdIf1xsP/0SJ45
	jrUYp4rdeChKOU
X-Received: by 2002:a05:600c:6286:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-493e6892d8bmr105299395e9.8.1783676351396;
        Fri, 10 Jul 2026 02:39:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6286:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-493e6892d8bmr105299095e9.8.1783676350840;
        Fri, 10 Jul 2026 02:39:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm55755378f8f.10.2026.07.10.02.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:39:10 -0700 (PDT)
Message-ID: <6d6388c9-cdeb-4b91-b393-125f4a5b7e0c@redhat.com>
Date: Fri, 10 Jul 2026 11:39:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] rxrpc: Fix CHALLENGE packet overqueuing and
 simplify RESPONSE generation
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
 stable@kernel.org
References: <20260702144919.172295-1-dhowells@redhat.com>
 <20260702144919.172295-5-dhowells@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702144919.172295-5-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306487-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:jarkko@kernel.org,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83341739310

On 7/2/26 4:49 PM, David Howells wrote:
> Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
> the AF_RXRPC socket that generated one of the calls on that connection for
> the application (which might be in userspace) to service.  The application
> then picks up the CHALLENGE and requests a RESPONSE packet be generated,
> allowing the app to include app-specific data in it if appropriate.  There
> is, however, no actual limit on the capacity of the CHALLENGE queue, and
> this could be abused remotely - and also getting the OOB mechanism right
> has proven tricky.
> 
> Further, by analogy with other AFS codebases, it's not actually necessary
> to generate the application data in response to the CHALLENGE.  The reason
> I did this was to set the encryption on the app-data to be the same as that
> specified in the CHALLENGE as the server must be able to handle that.
> However, it's sufficient to use the encoding type set in the token that is
> going to be sent to the server; presumably the kerberos server knows that
> the fileserver can handle that type - otherwise why tell the client to use
> it?
> 
> With this in mind, make the following changes to the rxrpc server:
> 
>  (1) Remove the OOB queuing stuff and retire the related CMSG values and
>      sockopt.
> 
>  (2) Revert to making the connection event processor work item parse the
>      CHALLENGE and generate the RESPONSE directly.
> 
>  (3) Add another (optional) parameter that is passed in when an rxrpc
>      client call is created and ends up attached to the connection bundle
>      and is a user-type key containing the application data.
> 
>  (4) RESPONSE generation looks at the bundle and if the app-data is there,
>      it will include it (if the security class is YFS-RxGK; RxKAD ignores
>      it).
> 
>  (5) The AFS filesystem driver will create an app-data key when it probes a
>      fileserver and will attach it to the afs_server struct.  This is then
>      picked up when a call is made to that server and passed to rxrpc.
> 
>  (6) Direct userspace users of AF_RXRPC can partake by creating a user-type
>      key containing the app-data they want to use and passing its serial ID
>      in a CMSG of type RXRPC_RESPONSE_APPDATA in the initial sendmsg() of a
>      call.
> 
> To support this, I've made a change outside of afs and rxrc:
> 
>  (7) Add a refcount to the user-type key payload.  The problem is that the
>      RESPONSE packet generator needs to look at the length of the app-data,
>      allocate a buffer for the packet and then copy the app-data in - but
>      the RCU read lock cannot be held across the allocation and the key
>      might get updated.  To get around this, a ref is taken on the payload
>      before the allocation and then put afterwards.
> 
>  (8) Since the DNS resolver makes use of the user-defined type's code, but
>      allocates the payload itself, make it initialise the refcount.
> 
> Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
> Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: keyrings@vger.kernel.org
> cc: stable@kernel.org
> ---
>  fs/afs/cm_security.c         | 151 ++++++--------
>  fs/afs/fs_probe.c            |   5 +
>  fs/afs/internal.h            |  37 ++--
>  fs/afs/main.c                |   1 -
>  fs/afs/rxrpc.c               |  39 ++--
>  fs/afs/server.c              |   2 +-
>  include/keys/user-type.h     |   2 +
>  include/net/af_rxrpc.h       |  20 +-
>  include/trace/events/afs.h   |   1 +
>  include/trace/events/rxrpc.h |   2 -
>  include/uapi/linux/rxrpc.h   |   6 +-
>  net/dns_resolver/dns_key.c   |   1 +
>  net/rxrpc/Makefile           |   1 -
>  net/rxrpc/af_rxrpc.c         |  49 +----
>  net/rxrpc/ar-internal.h      |  22 +-
>  net/rxrpc/call_object.c      |   4 +-
>  net/rxrpc/conn_client.c      |   2 +
>  net/rxrpc/conn_event.c       |  68 +-----
>  net/rxrpc/key.c              |  36 ++++
>  net/rxrpc/oob.c              | 387 -----------------------------------
>  net/rxrpc/recvmsg.c          |  84 +-------
>  net/rxrpc/rxgk.c             | 128 +++---------
>  net/rxrpc/rxkad.c            |  27 ---
>  net/rxrpc/sendmsg.c          |  15 ++
>  net/rxrpc/server_key.c       |  40 ----
>  security/keys/user_defined.c |  23 ++-
>  26 files changed, 238 insertions(+), 915 deletions(-)
>  delete mode 100644 net/rxrpc/oob.c

This is quite big and difficult to review, could you please someout
break it in smaller chunk?

/P


