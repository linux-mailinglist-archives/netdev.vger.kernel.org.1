Return-Path: <netdev+bounces-277333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYkBxbb2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B666B3D6046
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C8E302611A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAC3A1E8C;
	Fri, 10 Apr 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBezDgAz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C338F633
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819539; cv=none; b=IdwGDdttFVEC02iNp1FcqNEQO+69xxOQnFz/MmqfxnYN5Q2EDt/5WMcWnIqpoDG4K34nlf9EZ8ZKZLmK+SzHFzvAR0Nz99c0HYp6wIZ9JvcF6VXcvQLj5MBzQDJKgDgiEEoPyXoZ5i0f6BfNN1f2Eq7MzeVXE2su0RdZrYiqRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819539; c=relaxed/simple;
	bh=6q/fYiv79cBBdIHumevrLvgbJqRc865vCfOw9Njpits=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSKP7TutupqtzLgWpwAvCsvq4/GeA/Q8B67d7VACZuNCkCwsfy43xNLFO+DplgxnFuO7JbIe4oVEU8MQJkYP8bkDRU1unwzUpAUlslTiizIy5TLLy2tTBXsQKOIvCPQqSsFzo49mGfhUfxOg2FHH4bCx6HgNrFVbWFHgSCEI4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBezDgAz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775819537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6q/fYiv79cBBdIHumevrLvgbJqRc865vCfOw9Njpits=;
	b=ZBezDgAzD+4j7mhz2coYRzeCLxLrBZ4wz0Xl+xVsmk/Lnb5XJmbwOaVPuXeWnYppJxApPK
	IbYWZyEcmmgYp6QfEGY2FUd/lprXLgLD9P3NAAUlql6UICphqBsAnjtwhsxC+fXv5/4xQH
	afDRUOTvaeWKYAUg4Y/mZOXdhPRERZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-cO40RGV6P32C3UDeo9Ngow-1; Fri,
 10 Apr 2026 07:12:13 -0400
X-MC-Unique: cO40RGV6P32C3UDeo9Ngow-1
X-Mimecast-MFC-AGG-ID: cO40RGV6P32C3UDeo9Ngow_1775819532
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8A2A19560B2;
	Fri, 10 Apr 2026 11:12:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECEF21955F2E;
	Fri, 10 Apr 2026 11:12:06 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kohei.enju@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	poros@redhat.com,
	stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/4] iavf: send MAC change request synchronously
Date: Fri, 10 Apr 2026 13:12:05 +0200
Message-ID: <20260410111205.84349-1-jtornosm@redhat.com>
In-Reply-To: <89bfd605-1877-4d40-95e1-bfeae6624168@intel.com>
References: <89bfd605-1877-4d40-95e1-bfeae6624168@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277333-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,lists.osuosl.org,redhat.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B666B3D6046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Przemek,

Thank you for your comments.
I will try to include them in a next version.

Best regards
Jose Ignacio


