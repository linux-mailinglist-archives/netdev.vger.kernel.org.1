Return-Path: <netdev+bounces-279296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMkCC+AM4mkg1AAAu9opvQ
	(envelope-from <netdev+bounces-279296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:35:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A041A2A0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC3A300C598
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD3349B02;
	Fri, 17 Apr 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKMJnEpG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94873B6C05
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421851; cv=none; b=uCFRqojYAMYURus2tB+3Db5ISiKSkWtO403WL1hbXW6qmLSu8xkbiR1ngajt39iBV0YCq9/izcDhysV6k53aiKCSAZ69RKZOBSc0NfU6XAjTWH2OZ+2cEoxzFvR3EXRond7OCt3IDpq0OxM28/1Uh1W2KMjJc4PFCP+6FA2kQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421851; c=relaxed/simple;
	bh=+Hls5wp1UWuzMI1mKYe2+ioDcWRk7O3VpaEdD4sGj5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnbscSrO5IEXznolhlS3zFeBd+H+l9AbIO7B5+Rx/s0KhdcvvdTuMNVOLSwZMZIk/iZ/cN1hggbhEJ1CX4Bdc3dgbaV0UFrcNcoJdGJdZ1hY6NXqkRBVflvo1XTbfaUirb9CYU3tgQL0dIu1J/GRhfmPfufTpqOVwMNgOp+DuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKMJnEpG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776421847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Hls5wp1UWuzMI1mKYe2+ioDcWRk7O3VpaEdD4sGj5g=;
	b=IKMJnEpGSddifEwiMFNiBECyv9i4chf0lHhyNNdmQjfOxQ/JvWjU5ouhxT7uDR6w9iqkcF
	DYX8Xh8ZJ6gz+CxNvaob5klXhljetJFZ0LuVTT2nEl99fIkjKRLamdol8tgmqUD/Qxcp3H
	JUjzp15+/BiN/YiJ7D3yMk+HcCRsbBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-qNIUl2R5Pe-oMBRDvXqfkA-1; Fri,
 17 Apr 2026 06:30:43 -0400
X-MC-Unique: qNIUl2R5Pe-oMBRDvXqfkA-1
X-Mimecast-MFC-AGG-ID: qNIUl2R5Pe-oMBRDvXqfkA_1776421842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0292418002D1;
	Fri, 17 Apr 2026 10:30:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E86BE180036E;
	Fri, 17 Apr 2026 10:30:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jacob.e.keller@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v3 5/5] iavf: refactor virtchnl polling into single function
Date: Fri, 17 Apr 2026 12:30:35 +0200
Message-ID: <20260417103035.152583-1-jtornosm@redhat.com>
In-Reply-To: <6539cc33-9294-4312-aa1b-5df311dce79f@intel.com>
References: <6539cc33-9294-4312-aa1b-5df311dce79f@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279296-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B53A041A2A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jacob,

> The cleanup makes sense as next material, but the other patches fix bugs
> that could (should?) still target net, right?
Yes, I think so and that is my intention.
Unless Przemek has another opinion and/or better idea and since
"iavf: add iavf_poll_virtchnl_response()" has not yet landed in any public
repository, I can include "iavf: add iavf_poll_virtchnl_response()" patch
like it is in my next version (to drop when the commented one is landed)
and in the meantime allow to progress the rest of the patches for net.
I will take into account the interesting comments from Simon and his
AI-generated review too in my next version.
If it is ok, later on I can proceed with this patch for the refactoring.

> I'll drop this version from the Intel Wired LAN patchwork then.
Ok

Thanks

Best regards
Jose Ignacio


