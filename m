Return-Path: <netdev+bounces-290480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHDDFnkbD2qeFwYAu9opvQ
	(envelope-from <netdev+bounces-290480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:49:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32A5A7A43
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B738319DFD9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32136363C6B;
	Thu, 21 May 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVglaGZg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4031A6815
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372052; cv=none; b=na9wca6v6scsIhTIn8GO5cFQexW3JPzjC0HE46iEUqJBNZ7+Q75oTZT35ONltMuXs5KXSjDNlXKsFztuNfNC8aU85lkPRo3A6ME+QTHrSSAJiHufHv9m6aiVZi7CJ4Xn49/LWWSmHvfs1iPHxX9FlnT2TnXTchQsP5eggLM27iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372052; c=relaxed/simple;
	bh=V1aYIRFuyyT5/+K+k6imL2TLIXjliRelxkb+H9Aa8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUQDG/NMfE1WX3aFk1RpExZSjVktLlAIJMIuhn6/lRIpJVaYToYfzGD0a+Td5NyquYdXygA/E5+RSpfV/I+FYoXb4vqUm/ARbvXsRWbbZJicW5VsrJeQyy9zTrwQXVcfje6E8EP9mfggPXUdCrMiYDA04obUGXe1Iu/FQSmMorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVglaGZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779372049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1aYIRFuyyT5/+K+k6imL2TLIXjliRelxkb+H9Aa8MQ=;
	b=BVglaGZgGaErlcQ+qz20R01rBIbU3KovWUIg0vu5P/gs7CU4odj05ygNDkNqcCG4whmSvo
	Dz4FaP6X8dxni8hOhHGwBShCrIRQSfBU709MteFMMCRL7FfGGD/90v2XuyU0ewOwyp6XTb
	q4hqWGpN1ALTtNssODk9doP/bXr1WoU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-OPtzuasWP7qNTrW0sjX7Fw-1; Thu,
 21 May 2026 10:00:45 -0400
X-MC-Unique: OPtzuasWP7qNTrW0sjX7Fw-1
X-Mimecast-MFC-AGG-ID: OPtzuasWP7qNTrW0sjX7Fw_1779372043
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5896A19560B5;
	Thu, 21 May 2026 14:00:43 +0000 (UTC)
Received: from griffin (unknown [10.44.49.174])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2887F300019F;
	Thu, 21 May 2026 14:00:38 +0000 (UTC)
Date: Thu, 21 May 2026 16:00:36 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook
 <kees@kernel.org>, Adrian Moreno <amorenoz@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Matteo Perin
 <matteo.perin@canonical.com>
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
Message-ID: <20260521160036.413771e9@griffin>
In-Reply-To: <bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
	<20260520172317.175168-3-i.maximets@ovn.org>
	<bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290480-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbenc@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE32A5A7A43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 14:36:12 +0200, Nicolas Dichtel wrote:
> I still don't think that this is the right "fix". The app is broken. Even after
> this patch, the bug could be easily triggered again by a third party.
> There is nothing wrong with assigning a self-nsid. It would be a lot more robust
> for the app to assign itself a self-nsid when it starts.

On the other hand, does the patch break anything in practice (as
opposed to in theory)? It makes live of several apps simpler, which is
not a bad goal.

The only scenario where this would introduce incompatible behavior is
an app that self-assigns a self-nsid and expects to see it. That looks
quite stretched, doesn't it?

Not that I have a strong opinion about this, though.

 Jiri


