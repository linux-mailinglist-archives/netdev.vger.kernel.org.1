Return-Path: <netdev+bounces-266965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Po0IMiKsmneNQAAu9opvQ
	(envelope-from <netdev+bounces-266965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:43:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED826FC4E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B6530B89A6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF063B6349;
	Thu, 12 Mar 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWXluIG9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3963AD508
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308458; cv=none; b=FJImHMBh2U3umrVPDFMsHmG7tLuFPirXvhAs3lxjTZSbPXeGG38gSreFXkyCeimQsbAGM6vITFRXxfnIBqvra/rJqy/EyMxcZCh40PIRhcc40KYynouIbZwEQFVF6WoVXT3t0JomgrM1riPGYRdjxGXd/DUFU2+DPet/8FPeZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308458; c=relaxed/simple;
	bh=PQlAftZExJJEhtve/BXdj5xplMSgKtLse+ZbbPfDIYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYh0cMccxhNoLbd0PyWW8M37MZCSQa5ESr533q6UFn01jNKI3HiNP6+FQP2KofdfMFRqr3JkK2+w442VzbYB3IoiwxzUlITFXKBEEImUZ632ycJ/mMv3/E7mdpVY4yJemi5Ct8xmaa9GcKa0sTNcZe6VC0k3jvCp1EgBRt8M6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWXluIG9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773308455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLDD1ykdoRWruNygOA/Gi52min0abqQeBslR7+2fT2A=;
	b=eWXluIG9WNqd2CkvaBk05h3JSQsBjH8DCW2/VuI+teyWnWe5p1UkRbO+q61//eUEW7s8rb
	QmG2uZDo/HW1m70wdTlJhuQTgtK2qiM1cxb0lDndEhESFc6oQCWVZQ1TvxJgppqMWfWSmo
	LS6gHX1UCizc/p++HU7lIBTTudqAuLI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-s1jAbPTQMMi_diXEFQCqSA-1; Thu,
 12 Mar 2026 05:40:51 -0400
X-MC-Unique: s1jAbPTQMMi_diXEFQCqSA-1
X-Mimecast-MFC-AGG-ID: s1jAbPTQMMi_diXEFQCqSA_1773308450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E00A1977698;
	Thu, 12 Mar 2026 09:40:50 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43740180058B;
	Thu, 12 Mar 2026 09:40:47 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: jramaseu@redhat.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	przemyslaw.korba@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: enable NETIF_F_HW_CSUM for GSO packets
Date: Thu, 12 Mar 2026 10:40:28 +0100
Message-ID: <20260312094028.1394467-1-jramaseu@redhat.com>
In-Reply-To: <20260310150557.1138437-1-jramaseu@redhat.com>
References: <20260310150557.1138437-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266965-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jramaseu@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14ED826FC4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For whom it may concern

I forgot to include Reviewed-by section that was to be copied from v1 of the patch 
(to be found here: https://lore.kernel.org/intel-wired-lan/20260310115556.1004263-1-jramaseu@redhat.com/T/#u),
sorry for the inconvenience.

Regards,
Jakub Ramaseuski


