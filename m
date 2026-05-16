Return-Path: <netdev+bounces-288659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGLeFuLBCGph4AMAu9opvQ
	(envelope-from <netdev+bounces-288659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B255D79D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00793300F976
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5F3612E7;
	Sat, 16 May 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BanioSKz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E635E1A1
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958816; cv=none; b=eKS2Exn15Ju9DSr6yIXLgXE+UlfnzM6q1cE2Z1xB+D/63nLrhA6sVZ2vObSWd9a3N+cj0eX1RwY0O6vWA1nvs5KR1VechtsgNHYgdEZn2Pgp/BwouvVMoCMmCmZQIm1HfyE82NP5wc2ezAxaP4YhvDOEB3B1hk5elef/T0XitiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958816; c=relaxed/simple;
	bh=uYdxhjtxSWQ86j9Ri6q9Ri5HGawJoUiQ8Oum3a9fAjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJCHF66dxXCe/tUAWuIkYszUqfHy59PsLXKVFAoYu9WF1FicSnXITBbKXFO3EUJDJy6LRa4WLD4qGo00eugoDXEAcgigdYaAjYBBXogw9wN2drCIAJ8vNrmYq+hnAqw8pih9Yznd0QkbZOH+X2pEfp1J+txOfs3qP2WFxPHwBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BanioSKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778958813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NXEhIO/kWVQY3MYBpdVIfZZ6/6wRraSrPlby3wijiHE=;
	b=BanioSKzH19Iuh4UK4NHzR/YlhhFb4Vm9EhHFZVJ0IeIR+ZnnPSxRLM3jYvbvGg25p160l
	kQYIsdG18usdsNrAiS31BnkjQthsUTbP1urlmkuevkHsvoLu/cnWT7+S8aypg5unpQGRia
	tFi8HpOlbVNVUyFdjvfitpvOQtoOY2E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-OKN1KBcTPWKy_k43LoTvVQ-1; Sat,
 16 May 2026 15:13:30 -0400
X-MC-Unique: OKN1KBcTPWKy_k43LoTvVQ-1
X-Mimecast-MFC-AGG-ID: OKN1KBcTPWKy_k43LoTvVQ_1778958809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 962DC18005B5;
	Sat, 16 May 2026 19:13:28 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7EFE1956053;
	Sat, 16 May 2026 19:13:24 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Milena Olech <milena.olech@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] dpll: fix two teardown races on E825-C
Date: Sat, 16 May 2026 21:13:15 +0200
Message-ID: <20260516191317.1005612-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: EC2B255D79D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-288659-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Two independent dpll core fixes for races observed on E825-C with an
external zl3073x dpll chip, where ice contributes pins to a dpll
device owned by zl3073x. Both regressions date back to commit
9431063ad323 ("dpll: core: Add DPLL framework base functions"). The
patches are independent and apply in either order; per-patch details
are in each changelog.

Tested via repeated kexec stress on the affected hardware: patch 2
cuts the WARN incidence from 1-4 reboots to none observed across
several hundred reboots; patch 1 removes the NULL deref observed
under parallel rmmod of ice and zl3073x_i2c.

Petr Oros (2):
  dpll: fix NULL deref in dpll_device_ops() during teardown race
  dpll: filter pin->dpll_refs by cookie in dpll_pin_on_pin_unregister

 drivers/dpll/dpll_core.c    | 20 +++++++++++++-------
 drivers/dpll/dpll_netlink.c |  6 ++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.53.0


