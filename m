Return-Path: <netdev+bounces-117598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E0E94E72B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B71C2121A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EB14F9E1;
	Mon, 12 Aug 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEZz87ec"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE614B952
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445499; cv=none; b=mpTd536LQ38jj5dG4x3gMncIpYpFyd8q7czuoLo0I2AchUCZyH/gim+rF04misw4Fp0viWc8/notCv9pqteHh2rmIi+W6rLLCcd1NOJqOhsu9426RG6GTvbPsDcb1uraJCvfBvD6hSjSGD9lr1WKi/q1JLEekUar1A8sZDYROI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445499; c=relaxed/simple;
	bh=NfP47b8rhgr998pR0MP4dgFPvijX8qMvLBCsegVfSKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i3GLDhy8yCoGPhS+rO33KqbyEFUxPN+T8S4DiEVNCB5Bts02Vgfv2ai4fjZGFVncFq4M0d925Txr8G+eOVgMaGkjzFqG5YWizCvzUFraQjyLuVfcOHj4HQLsOmJ0O7Uli0qm1vsM9KGgvY3cMHuHh8ZPfOXSvZ/GIs5GreweJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEZz87ec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723445497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1JSqOjQOoZJPvMdrAEuSnMSUbbXI2WZ76CPXqjhdTnI=;
	b=EEZz87ecc1Fdog14h2xshr+V1EQ7G6uyhClUHDBsR/ulNUxfZJBNPGnwA5aaXNAmvE+TSf
	ORPKbJ/DQY7MlK8ctVSbp7USiPnb71/1S16x78WWyGK9d2FRWMoADLxBykZKN+ix8kCWML
	dHzQ85j9ggZckBlt/6QMLNlR//n4g3s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-KAUrqsgHOtKwJHkJ29eYFg-1; Mon,
 12 Aug 2024 02:51:34 -0400
X-MC-Unique: KAUrqsgHOtKwJHkJ29eYFg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5871218EB226;
	Mon, 12 Aug 2024 06:51:32 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25188197703E;
	Mon, 12 Aug 2024 06:51:27 +0000 (UTC)
Date: Mon, 12 Aug 2024 08:51:23 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET
 reserved size
Message-ID: <20240812065024.GA19719@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

ssn_offset field is u32 and is placed into the netlink response with
nla_put_u32(), but only 2 bytes are reserved for the attribute payload
in subflow_get_info_size() (even though it makes no difference
in the end, as it is aligned up to 4 bytes).  Supply the correct
argument to the relevant nla_total_size() call to make it less
confusing.

Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
v2:
  - Added prefix to the patch subject
  - Fixed commit message formatting (line width, "Fixes:" commit hash
    prefix size)
v1: https://lore.kernel.org/mptcp/20240809094321.GA8122@asgard.redhat.com/
---
 net/mptcp/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 3ae46b545d2c..2d3efb405437 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -94,7 +94,7 @@ static size_t subflow_get_info_size(const struct sock *sk)
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
 		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
 		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
-- 
2.28.0


