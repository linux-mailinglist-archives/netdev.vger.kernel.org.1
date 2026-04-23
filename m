Return-Path: <netdev+bounces-280869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFakCXl86mmqzwIAu9opvQ
	(envelope-from <netdev+bounces-280869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D2457289
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABD83002108
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729643A3820;
	Thu, 23 Apr 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWi8GF21"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6D3A256D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974966; cv=none; b=CRJjgiNiQm0OOQMRWdnEQ+HaLNjmrE8ZiPDNAEzJAfWQYk3wq4czyhKd5LD6X5YDGKLXq46KUrV/jbbmGRKS0+7V/frBqXkW7pbz9FiIyJHWoteDZ2TJugDRmb8aOEKON9NOPy9hinnTG8pbzd3OA8ralZJ5ixr91Uv1y7FPuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974966; c=relaxed/simple;
	bh=G+nNWqdUC8HBpSPkg06CS2GrjiTCDu5mrXe6AN/4yY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9etX5+qytBZ9pVSEF6+DTiM/RaCVZ5yHCT1Fy8kUPCOM4tL2Ed4gFIqUShW4lLqXVR4cgYvlEEoY+IX+YGTlnciBt6vBGBTbMfddV2v7qWh2nIZ7i9+f836NEKk8CRqlss2NaCZK3tw/14c/kbNdSlCp5oKmNWppeE+DHtkzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWi8GF21; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776974962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FxeQ+Dz4xpImThoQHj8qkhFKVKe8qxbOpL7Rg8TPxNY=;
	b=WWi8GF21YKC4eJijBzNlXj0zEUuwwq37zi/4ikyeTzQdk76jjOmeddwSCz68a3IFmfE1e0
	WdaD0WpQDFnQVzT15w/rjMnM8zWYwMquk81rwIjWKGKIAqQ5USnuqmZwJZWQpmqGa62v1V
	EaXym1hKI343mO/OIxi0geDI83L8Qok=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-DorYdAAXNGe8EjoLKN3iOg-1; Thu,
 23 Apr 2026 16:09:18 -0400
X-MC-Unique: DorYdAAXNGe8EjoLKN3iOg-1
X-Mimecast-MFC-AGG-ID: DorYdAAXNGe8EjoLKN3iOg_1776974957
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE70E195609D;
	Thu, 23 Apr 2026 20:09:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9F2E180047F;
	Thu, 23 Apr 2026 20:09:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] rxrpc: Miscellaneous fixes
Date: Thu, 23 Apr 2026 21:09:05 +0100
Message-ID: <20260423200909.3049438-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280869-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 785D2457289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are some fixes for rxrpc, as found by Sashiko[1]:

 (1) Fix rxrpc_input_call_event() to only unshare DATA packets.

 (2) Fix re-decryption of RESPONSE packets where a partially decrypted
     skbuff gets requeued if there was a failure due to ENOMEM.

 (3) Fix error handling in rxgk_extract_token() where the ENOMEM case is
     unhandled.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Link: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com [1]

David Howells (3):
  rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
  rxrpc: Fix re-decryption of RESPONSE packets
  rxrpc: Fix error handling in rxgk_extract_token()

 include/trace/events/rxrpc.h |  1 -
 net/rxrpc/call_event.c       |  3 ++-
 net/rxrpc/conn_event.c       | 14 ++------------
 net/rxrpc/rxgk_app.c         |  1 +
 4 files changed, 5 insertions(+), 14 deletions(-)


