Return-Path: <netdev+bounces-253397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA0FDZs0d2nhdAEAu9opvQ
	(envelope-from <netdev+bounces-253397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:32:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8ED860B5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDEC304018D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1B3164BA;
	Mon, 26 Jan 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LywcPcKP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10777314A6C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419721; cv=none; b=goufD+SwFuNCZfs+AmyIRO9evnP2+0aXuloYRBmhRPB3RGZ4iMARZCnfsOXuPEJC0VWjO/oVlYRAolWKwNFRyANHcZRDT9YWmmuyzSnacLmKMIGqVSZsFUs/SD6iu8w/RIbJpLymDNC3mb46t7n1pRbaekHbikOOO0QV4KXcE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419721; c=relaxed/simple;
	bh=lIZ/axGtJY1GJmgq+Bq/FOTvSbmIpkliuvpjSjqfq6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uPOE26Bs4XUnNXd/OTlzdFEKOXtGQelbiQ0Nsp5vs8kdWgF5RV7suahVgsbOjogRojnhs/QuCyknJOqp09PkhG3d0JG0wd+baRZz5Ok5VLuTtU7FL99yRdBRNe42uBWaGWhHudLFy51aEFZePA8vyLywrcIMjcSNVcsrRS9+qLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LywcPcKP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769419713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=W+4vYzNAjTdVAA623ZrO8amSnfgaSmiNwyODoYrAlvY=;
	b=LywcPcKPtFaLW/cCVU5sHKo8Z1xmhkcOJW3ZgeRfJXMdQiyHPKv9bFQ7ccSWXrMsNaLKn9
	j56WwxidYpYv1ZaKR0wNawRtwhsAY/pO6LZtEQ8aQL/ICQhlcAllMWT+Bzh9ZImH70Q6xf
	moSt+039wBOC4wvsYiT9PiVROkXpURo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-P6GaWfdnP6qxEPQ8HJLT2A-1; Mon,
 26 Jan 2026 04:28:27 -0500
X-MC-Unique: P6GaWfdnP6qxEPQ8HJLT2A-1
X-Mimecast-MFC-AGG-ID: P6GaWfdnP6qxEPQ8HJLT2A_1769419706
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDE011955D92;
	Mon, 26 Jan 2026 09:28:25 +0000 (UTC)
Received: from thinkpad (unknown [10.45.225.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38A3A30001A7;
	Mon, 26 Jan 2026 09:28:21 +0000 (UTC)
Date: Mon, 26 Jan 2026 10:28:18 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, jkarrenpalo@gmail.com,
	tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
	petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <aXczshu7nvWWFMy4@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122173556.44d8b77f@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253397-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AC8ED860B5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 05:35:56PM -0800, Jakub Kicinski wrote:
> Transient build breakage here - patches 4-7 don't build and will break
> bisection. Perhaps wait a few days to give a chance for Sebastian to
> TAL before reposting tho?

The build breaks because I didn't update the KUnit test for the PRP
duplicate discard algorithm in patch 4 and 6 to keep the patches a bit
smaller. But the build succeeds without
CONFIG_PRP_DUP_DISCARD_KUNIT_TEST, which is probably not active in most
bisection runs.

I'll wait for feedback from Sebastian, but I'm also fine with merging
the fixes for the KUnit test into the other patches and reposting.

Thanks,
   Felix


