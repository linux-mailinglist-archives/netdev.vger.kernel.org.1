Return-Path: <netdev+bounces-278940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONmjDv944GkfhgAAu9opvQ
	(envelope-from <netdev+bounces-278940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B740A7A2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9D7303C2E8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE23379979;
	Thu, 16 Apr 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atVY+RKY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D837883E
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318715; cv=none; b=konzvSC6f5EfuINdjV9jKIAYlUvuY4pMCMm+bfFyif+BrBu/xboXQPcrkk3FLecsiFaW4qhF0RtFaqk95CyMchhvodWZoUvTfIZefEyHJpGpLUgGdJFcjMp5B1pwan2aMNycUixjgbvu4ar2MZNFR9gHtV1Mhem8zTAcu0yL0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318715; c=relaxed/simple;
	bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNLq8QL67oeu9bmphT1Y+jPZU3/pQgPvshFG/Uwte/r0DejkUuKa9RbmLR3LrT9a1FAGmkW8hlfiYyNcY+P21aKzl7UB8AwcFGxVfkLXKOhUhhRmr5oa4lu5S30HhgUl1r8CxwuyrDLv5K08WTfiryZf5EaS42DifGA6/sZq8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atVY+RKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776318712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9WaNaQ/uFgsOFE1s6aD5beNTsaN2ql4WsVBGG/diHU=;
	b=atVY+RKYAFN6Ag5u8gqP5A5SOnMMwSVDQO9zefvUhhLPMOa53mc5VVmJ4ekXIIa4+uz+Mu
	Scn1VovFsgxXUV6UG1CmGRvFqIgZQqI8FsY14aefu5RZ1CfidJKW8mItXlAXcLMJHid5tz
	viQpaVASPtViFNjTNnUYlxwuK2ZTLn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-j7N_kwrUPIi1B6AD2q453A-1; Thu,
 16 Apr 2026 01:51:49 -0400
X-MC-Unique: j7N_kwrUPIi1B6AD2q453A-1
X-Mimecast-MFC-AGG-ID: j7N_kwrUPIi1B6AD2q453A_1776318708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0CA218004A9;
	Thu, 16 Apr 2026 05:51:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7796030001A4;
	Thu, 16 Apr 2026 05:51:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: RE: [Intel-wired-lan] [PATCH net v3 5/5] iavf: refactor virtchnl polling into single function
Date: Thu, 16 Apr 2026 07:51:41 +0200
Message-ID: <20260416055141.19127-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986843CDCC4F6DC6CD015FDE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-278940-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A3B740A7A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Aleksandr,

Thank you for your comments.
I wanted to link this patch in some way with patch 3/5, but you are right,
perhaps as a refactoring, better for net-next.
Anyway, I am going to wait for Przemek and
"iavf: add iavf_poll_virtchnl_response()" merge, after that I will rebase
and I will create another version of the series, dropping this for now.

Best regards
Jose Ignacio


