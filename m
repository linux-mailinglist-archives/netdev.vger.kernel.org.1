Return-Path: <netdev+bounces-199284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4FADFAA1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4103A6B30
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A629CE8;
	Thu, 19 Jun 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="gfCJwvUc"
X-Original-To: netdev@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA61CD3F;
	Thu, 19 Jun 2025 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296118; cv=none; b=FMfaYI8l46/Obq57uR8GEf8KXRmGLcP8nSZlE7XGrFAQZtrFMPDqedeKXC6x8L881EJICRBGBOZrtKkzjJ7E20q0TMDiEGJTSS5udjwOERtCYMjXDWxnAEXX72Y76lVdIvxyrJdjOXr3F6DSYmcbiJmsC4fxcDdmARIjdVvu0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296118; c=relaxed/simple;
	bh=MUo5HN2+4eHRF4vfZmOzGNcpIH8Cpomm1JQPO2fKijo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHAGewiVjn1TzPX2iw1sJKjfB+x+vnpIaot822oWRWcRBfBv+btqEk/SyTwv1tOoMrdUh8lN0UkMoKeEh9cQa9V1EDcOF3vQXFJWfgmYlEsx+WelNvKq7pseIrczV9p62FMJcvtmKRmCIH4jntiW6JU8/0HcfBjOHEmohLs7qnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=gfCJwvUc; arc=none smtp.client-ip=51.81.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=7zg+LvQChxQon/g4lI6tNsUEpvSR500gVyAdwM
 5WaKU=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1750295183; x=1750899983; b=gfCJwvUcqLLM38NLBeyPWE/2Q+g
 QMPpcUYDwDFAD0vfwst+6+hVhEeBFTXTQD9q0HhvA0ceE/gYk9ZP5QItV1ZmscWFN+Qo1od
 dVL0N7ufgUqbwGt4qZEwl4tBERL1qjTfgDeD33cP+h6bpBeh3jzUq5tcDalCKnqdUipbgrf
 VdX79RjWTteXqmnJD3h9uzMkPJsCl48cJH3JGuIzlieNv7k7lvaQ+ezdg1Z0jAR8//2EvWR
 rrAH7m5i4ERhqqkWyc1RJJQpsVIHtanvnCF2cvrKwBiAfwhwRS1/lnYxAp6pXbeFdRYlZco
 /1iegGoYPflHH048LtVIm2Z0x69W3TQ==
Received: from poptart.. ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id 91a5f48a-184a4c317d2edef3; Thu, 19 Jun 2025 01:06:23 +0000
From: Shannon Nelson <sln@onemain.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shannon Nelson <sln@onemain.com>
Subject: [PATCH net] mailmap: Update shannon.nelson emails
Date: Wed, 18 Jun 2025 18:06:03 -0700
Message-Id: <20250619010603.1173141-1-sln@onemain.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retiring, so redirect things to a non-corporate account.

Signed-off-by: Shannon Nelson <sln@onemain.com>
---
 .mailmap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index b77cd34cf852..7a3ffabb3434 100644
--- a/.mailmap
+++ b/.mailmap
@@ -691,9 +691,10 @@ Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
 Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
 Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shakeel Butt <shakeel.butt@linux.dev> <shakeelb@google.com>
-Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
-Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
-Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@oracle.com>
+Shannon Nelson <sln@onemain.com> <shannon.nelson@amd.com>
+Shannon Nelson <sln@onemain.com> <snelson@pensando.io>
+Shannon Nelson <sln@onemain.com> <shannon.nelson@intel.com>
+Shannon Nelson <sln@onemain.com> <shannon.nelson@oracle.com>
 Sharath Chandra Vurukala <quic_sharathv@quicinc.com> <sharathv@codeaurora.org>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
-- 
2.34.1


