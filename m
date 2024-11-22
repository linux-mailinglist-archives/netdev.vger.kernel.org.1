Return-Path: <netdev+bounces-146787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D79D5DB0
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCF51F2486C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6E1DE4CC;
	Fri, 22 Nov 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9thAhIR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA711D7996
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273368; cv=none; b=fpG6MMBySsgfLelRX0ScRP5jCfkp+f5Y6YRcMtY84YqRVoBsLKly41HKo9gJe9NfUxcHMBPTB6ksylbgUQJIELKOS9lLIHiepOMP1BBjf2w7K3D0mAQYaXZAHKXfdaeA9QNyHkt7jZbKAG9+sEEF2E2gqG3/kqLwkCm8JrNWRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273368; c=relaxed/simple;
	bh=d5H8mVZELxvz+g//t/ffTjKE74QihTD57aPjtKAZW6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jaau24V/UZM5H7YpIlOpvD8qkomyrTMAoCSFg74dgVH35QIGFVq9MSkjvcj6Ed/4/Wk3a20UzLSVMMYVRtcK7V6Gno2fpje6tEakARJDAjLvwCJnSyw7aUh9lLRdjd1DmerJO3d2TXTkXZq4uaqbkZLGShb5uM/CB7JSitfqSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9thAhIR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B/7QjoXDa5upmrbgOvGQdy5qmP1I/4qfUpHxKzDJbfU=;
	b=T9thAhIRvlPY9aByY4quMveX2dhXFRj2EjI9k4i0NS/sOZ91HoVcMMygQcUErPErrI3MhU
	H8pUCNXBOHJapQGMXIqpT4JR7UCMyZ4n5SrZ3Zg03o6NRE4zgOvl+gtWxHVxbiYWb6dXhT
	24FpSmH9UwU/0C9n9WJY+SiRQW5GG40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-zG1JiLfzNZ-A0KACgxBMtg-1; Fri,
 22 Nov 2024 06:02:42 -0500
X-MC-Unique: zG1JiLfzNZ-A0KACgxBMtg-1
X-Mimecast-MFC-AGG-ID: zG1JiLfzNZ-A0KACgxBMtg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E9A1955BD2;
	Fri, 22 Nov 2024 11:02:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8F8D19560A3;
	Fri, 22 Nov 2024 11:02:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: [PATCH net 0/3] net: fix mcast RCU splats
Date: Fri, 22 Nov 2024 12:02:13 +0100
Message-ID: <cover.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series addresses the RCU splat triggered by the forwarding
mroute tests.

The first patch does not address any specific issue, but makes the
following ones more clear. Patch 2 and 3 address the issue for ipv6 and
ipv4 respectively.

Paolo Abeni (3):
  ipmr: add debug check for mr table cleanup
  ip6mr: fix tables suspicious RCU usage
  ipmr: fix tables suspicious RCU usage

 net/ipv4/ipmr.c  | 51 ++++++++++++++++++++++++++++++++++++------------
 net/ipv6/ip6mr.c | 47 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.45.2


