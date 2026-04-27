Return-Path: <netdev+bounces-281316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPhYOfFK72lO/wAAu9opvQ
	(envelope-from <netdev+bounces-281316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A96471DD3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B164D3032748
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D530AD15;
	Mon, 27 Apr 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccnRk3J+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486D1AA1D2
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289712; cv=none; b=DAzsQ9XhDyOPX41h2/Erj98tPIIti1l/FniR+aUQRF8ANEAF0Vg7WcXU/IsMOjgZ+NPDr3a1HtNb85twavttS9HUhPm1Bs7akK6SesGg10GSmN8OX5Dgv2CPJk52z7epvndrQg4ZO1Ja6XDOS/9v4LbpCZNv2i8Znwam+0Vclq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289712; c=relaxed/simple;
	bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFuQgtYMMclqow+FCOquw9gh6/Zy0+hBlFemEtKpg9+EcRT2zqwuEBFRVlxFQhSUNVttSr3oYquxEgFOHyMES90HLvh8mlbkQJWwFbHdWO1SC87sxdfg+oEm/W9u0hXZ5rfhMwex1SJZd7E10W0mApb50QwaB95FXV+xvgs5ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccnRk3J+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777289710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTmOBQOfI2cC6OKRMtTqpwmhqCYyPD1tqmAV3nNBJko=;
	b=ccnRk3J+T4+UiBaoTOeyP65EOS56N/SmHAX6DT1A2dOq5vgYHlp5FhW/JAhJibGO3DWOvR
	Oytu5WyQqMxFJcv7vAs+M1cJHgw4ikhHn9ssfET1zYSN11l1IcCADeyudYwj6rtDX+l/37
	mO9KGb9/N3QYSG3Y/cHjanY1/6TKAFw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-5jr6GjTLMJ-8MlD7OXhyrQ-1; Mon,
 27 Apr 2026 07:35:05 -0400
X-MC-Unique: 5jr6GjTLMJ-8MlD7OXhyrQ-1
X-Mimecast-MFC-AGG-ID: 5jr6GjTLMJ-8MlD7OXhyrQ_1777289703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CDF19560BF;
	Mon, 27 Apr 2026 11:35:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A457D19560B7;
	Mon, 27 Apr 2026 11:34:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 3/4] iavf: send MAC change request synchronously
Date: Mon, 27 Apr 2026 13:34:56 +0200
Message-ID: <20260427113456.1267171-1-jtornosm@redhat.com>
In-Reply-To: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
References: <d055ed86-89d9-42fd-a881-0384ebfd24f7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 48A96471DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Przemek,

Thank you again for your comments.
I will try to include the new ones too in the next version.
Indeed kdoc "Return:" was already commented by you, I will try to address
all the occurences now.

Thanks

Best regards
Jose Ignacio


