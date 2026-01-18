Return-Path: <netdev+bounces-250834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E84D394A8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E13300D48D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F52D77E6;
	Sun, 18 Jan 2026 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze/35401"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5A218827
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768737790; cv=none; b=LxziAeEe64YRX/3TByo7rCJ/Rr/DL4GP8Pa1gZwNsvQ2I/jSj+ZsRqr+OJ6MDnF+lNkMAtupSmrNugy2TU23d6a2EnZjuijnCrnQ6sNTL11DpCNxbfRzb9jeVx7vy+sEEKw2dLu1dD7mr25m/pOQe/0SIJ3jxtmVhwiwOYb3yYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768737790; c=relaxed/simple;
	bh=MWuwn9svUpXUNyTJI82Pkl9AqetdFirCQVqd5w/pCZw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ilqC73RrRZ2kiAH51m06KPdc8CpWqiOm4gi1g5gzBWMkqtfsvUCYkgEEGbMt4VYALGRoO4di5Kri2q9u16g4iPTM5aUAYeatkz+njncrWrRoITHV/9xRfDRRywyraQFBCUUiZjB9EHQRxG5uPwBrY4H9g7doJiS86bBYkEPhTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze/35401; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768737787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sapUqr2OXLXuwQlCf/VHjgpvD1V1dsv5E3o93uphOFQ=;
	b=Ze/35401qnC6PdsKCvIHNHqb8TJCBGo43ZzV1Y6gUcQtKgcETLIrRVrI6OoL5tp4CwUekg
	qeZcyPNbQpeumbjOLLrikS322LytCQOju0cy1vBb5lgbkcx/ug3P+8XqoSdqkBMBk85VYo
	E41A8+gZ0okiPH9DO26C2s93PTxUQDU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-4GrXCCwIO6CfvJkL-zKMfw-1; Sun,
 18 Jan 2026 07:03:04 -0500
X-MC-Unique: 4GrXCCwIO6CfvJkL-zKMfw-1
X-Mimecast-MFC-AGG-ID: 4GrXCCwIO6CfvJkL-zKMfw_1768737783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C63318005AF;
	Sun, 18 Jan 2026 12:03:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A87A18001D5;
	Sun, 18 Jan 2026 12:03:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260118002427.1037338-2-kuba@kernel.org>
References: <20260118002427.1037338-2-kuba@kernel.org> <89226.1768426612@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org
Subject: Re: [net,v2] rxrpc: Fix data-race warning and potential load/store tearing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <916126.1768737781.1@warthog.procyon.org.uk>
Date: Sun, 18 Jan 2026 12:03:01 +0000
Message-ID: <916127.1768737781@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> wrote:

> > +		   (s32)now - (s32)peer->last_tx_at,
>                                  ^^^^^^^^^^^^^^^^^
> 
> Should this read use READ_ONCE(peer->last_tx_at) for consistency with the
> data-race fix?  The new rxrpc_peer_get_tx_mark() uses READ_ONCE for the
> same field, and the same seq_printf uses READ_ONCE for recent_srtt_us and
> recent_rto_us on the following lines.

I suppose.  Racing doesn't matter here as it's just displaying the value;
tearing might matter, but it's now a 32-bit field.

David


