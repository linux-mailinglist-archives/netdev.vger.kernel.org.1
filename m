Return-Path: <netdev+bounces-280990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LMZI+dk62mtMAAAu9opvQ
	(envelope-from <netdev+bounces-280990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB65C45E91C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AE6300D94D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301C36F413;
	Fri, 24 Apr 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+SAXkBp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1733329C60
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034446; cv=none; b=ZwnqLPuA0GjLfHFAt1MekIuMcZ5/6WHpP7lnZSH4vn+lc9dGAbyVhf2xXMMwkOIVI2mX/rJVdjcVliS+AgNZmzWoSRgBIeVS+bPnJbF3jPYqwnJ5qrMLeaitxSpRPvHCivqCyiiTB258RUhsCI0NGPx+uo/TF04V/rGrnYqz0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034446; c=relaxed/simple;
	bh=Os6slKuiLGxBWiHsIraIVXqi+PiGactCEycWMtcaDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja0PYL6JlL0ZoAn2H+U+afBLNpgVPveHRBgCwoDHe3rMb5U89mY/nrIhmAIuKEUgTzklJCtKZ3Ls0D68OAk8kXLoVHQwkqkJ8i8cpsyphmoX8PwEJk0OWvW6TmtoYBBbx/JLVbZx0EvhdOBstgHqR+YOR8V6fyiABuE3ixbCz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+SAXkBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777034444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Os6slKuiLGxBWiHsIraIVXqi+PiGactCEycWMtcaDv8=;
	b=h+SAXkBpJm+asdboB9Mkae32R5TC7fNP8IaVzvyciucf7OtJjffyPK1Zum659bdghrD/J0
	kkWLmrrAwHjcVvPfQgePo2TrbERY55qFw+srwy30AsSjW2zV6AWjDFv85NWat5FTk3KUu5
	GbdNotURPsmIuJpa+3ZU849zlhFlLxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-KXYT9KXtN8O36aMG-Drc7w-1; Fri,
 24 Apr 2026 08:40:40 -0400
X-MC-Unique: KXYT9KXtN8O36aMG-Drc7w-1
X-Mimecast-MFC-AGG-ID: KXYT9KXtN8O36aMG-Drc7w_1777034438
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84E00180034F;
	Fri, 24 Apr 2026 12:40:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FFE519560AB;
	Fri, 24 Apr 2026 12:40:32 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: RE: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting trust
Date: Fri, 24 Apr 2026 14:40:31 +0200
Message-ID: <20260424124031.834241-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB89861630A18B1BE712F14E68E52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89861630A18B1BE712F14E68E52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: DB65C45E91C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280990-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

Hello Aleksandr,

>>> You declare ice_vf_clear_all_promisc_modes() returning int, but
>>> ignore the return value.
>>> Looks suspicious isn't it?
>> Well, it is used like that when the funciton is called locally (the
>> function is not modifiedi, just made public), and really my intention
>> was to clean as much as possible (so error checking is not necessary).
>> In my opinion it would be enough to warn about the possible problems
>> (already done in the existing function).
> Can you go extra mile and add error code handling?
> Or at least document it in the code why you don't do it?
Ok, I can add the error handling in ice_setup_vf_trust and an extra warning
to indicate that promiscuous mode clear failed when revoking trust.
Just let me wait a bit longer for more possible reviews to create the next
version of the series.

Thanks

Best regards
Jose Ignacio


