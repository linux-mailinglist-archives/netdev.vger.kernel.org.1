Return-Path: <netdev+bounces-280252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMe8NCHl52lXCQIAu9opvQ
	(envelope-from <netdev+bounces-280252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:59:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D20343F98A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D28F43024793
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773993822B5;
	Tue, 21 Apr 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNmQNJsT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EE3624C8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805150; cv=none; b=LoKrFnQNR3+y6NIq4l/ol2A7Mxm0LNoX83sd003by1TNF3A9JfmXWAX+TB3tcrfxvmcCFxcCyWdjlJomi/mcU69KDpYcwsr6ZZgh7EavMfE4hy8J3NQMlG7pIN9EPTbPUp+8p5eQFDDdrhm7qNsHY+AuI70mejp9HfmzxdkA6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805150; c=relaxed/simple;
	bh=VC8AY93lihS6pHsZUAz/pZ8VolrI50ool0waQtLSc44=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QADAIdNMzrWyDS0dVKKbxt3n6A5h0o/f/idbSM0xKmtqZTtEpTc1fWIwxr5uBZxin/PJP18rCtpGbR7fwGMwjL80Da/j5qLftU+yy9a0dLn7kbGBmUZZ1xK7u/u6lkCpk7yW4D0GM7C2rbB5aWpsWgQYPwfpArPs4oT9wQ3dcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNmQNJsT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776805148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VC8AY93lihS6pHsZUAz/pZ8VolrI50ool0waQtLSc44=;
	b=GNmQNJsTmKMGNt5bwUMFWktZYr3UxYJx+1mvCCHDNc/XUD5HBvfujOBgbE5nYJ9ZZ7dHgn
	IcbfsJQ9BQ88d0pUmw/ewndDXiohA3knnm7p+ljKIDIn+ZAJe5pS+1Yo3v806VoJwencT7
	46acarrfG8gPSCZsk9HLy3uT9IZpylA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-qSDvEMwUP7uWKhfPaaC7hA-1; Tue,
 21 Apr 2026 16:59:05 -0400
X-MC-Unique: qSDvEMwUP7uWKhfPaaC7hA-1
X-Mimecast-MFC-AGG-ID: qSDvEMwUP7uWKhfPaaC7hA_1776805143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1C311956055;
	Tue, 21 Apr 2026 20:59:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F25D1800351;
	Tue, 21 Apr 2026 20:58:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260421203833.745240-1-horms@kernel.org>
References: <20260421203833.745240-1-horms@kernel.org> <20260420145900.1223732-3-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
    edumazet@google.com, pabeni@redhat.com,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    jaltman@auristor.com, stable@kernel.org
Subject: Re: [PATCH net 2/4] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2080439.1776805136.1@warthog.procyon.org.uk>
Date: Tue, 21 Apr 2026 21:58:56 +0100
Message-ID: <2080440.1776805136@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 7D20343F98A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simon Horman <horms@kernel.org> wrote:

> This isn't a new bug introduced by this patch, but since we are modifying
> the unshare path here: when rxrpc_unshare_skb() fails, it sets *_skb = NULL
> and returns just_discard.

Is there a way to avoid having skb_unshare() eat your ref to the source skbuff
if it fails?

David


