Return-Path: <netdev+bounces-260567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJFXD9HFnWnsRwQAu9opvQ
	(envelope-from <netdev+bounces-260567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:37:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679E189259
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7099A3194859
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0414272801;
	Tue, 24 Feb 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5tW4k7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459B26F29C
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947085; cv=none; b=nYWP4eKuCvNP0L49tNcfZzGd9H6mKihpEqwVKxSv8U6asUxOjHZRrwOgPH+YK1YxKerJsjqqBNw6i9OODzLCaGXlHRKa/4gfQveKQLAsOfsOWo9YBe6ZLp553jAF/oJJhXaW0zXAGQTCBoBzAT758barojQWSFnDqAsthccZGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947085; c=relaxed/simple;
	bh=NmxLWvbIlebeZn6AKtgHcEK1/JKHs8ZQvP1lC80mkiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvAnAf733AsH63osSmQ+cDOyIQn1Pnp8heDi1AJ4BJsLrqOKeVoUmcQ4aZwisphIiqIb0j+t2KRxvKHa+vyQ1MLLaea0w7NgZPcvkIMLjHFdlaGAIgiMSKtd5G6u+KnkBbpXPuAg8jiV4OPaGI85oRf2z2ORIK1/WGhZDTQ8Lfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5tW4k7h; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso3257848b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771947084; x=1772551884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0m5QrjYNnqHXl9e832+w13ILtwNiaT2S5RFUJztWJo=;
        b=d5tW4k7hUuhL753TR8iuSm5cwofevY9NY0hc3GTHZ3cYuvG39atcQm45aIHrLrtBHg
         +bG2N/9vm8xsBesmhAvk2kmzdlUx51+p9ulqo6AGDx9w3Khs4E8Q27BwNO25bJWpf9+f
         eVFpyvp5AR5CWivZQv/oE18n/67kO46RwdAW94h6AjxSzRRYjalnzDAYBbb5QXJgsqb6
         e0TvgVpQh2w7jFaj2Z9NZRUDIcNivXx38wKA80LT7Jb24iKhzLJxRjreO/KrzVCXOKn7
         372BOBEwBiMSuYPYL6X5oOpAzcAzir2OzL6WlksdMMl2KjXcc4GlJfECm/4z29UeRWAm
         lKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771947084; x=1772551884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0m5QrjYNnqHXl9e832+w13ILtwNiaT2S5RFUJztWJo=;
        b=XQwCs6Z6TSYVemm6fcy0dBDeF6z2PEpGn6ifzdZvJPdCU1wWGvX6K9o/ekGjZ6KyDW
         nWzds6ONAo56Kv0ULhkZ7XWT+x+vIIgTIxN055uKQ2pIIg+2EwaM17s65F0llvGLzjhj
         /GaLoe8l5dd6AZQopkegcCdnmsFmMb7ORrDzMi4j8D4tCCn+S/u93Wyi/pzGaGq6bPwF
         cvZRBvj8WJKatbls3QRlx0QOwwTbjWVii8mLuIqJyyhcDNxHt8Mx4CtXx/0nNUps7hqT
         aTLUvZ8a2QW26aUGLdETNfApxherRDg/aRPymACE8PnCRxwAR8j284YNvyzinROpM4Ua
         fR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6RXNs+fVDD6hyJPqQ4Mg+ornKO3qa9iytJyW5i5azVKm5ER8nu7SM36pwPZwxCKSpckJhbbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSdLfEmwYsHybozevSSTeskJX+QVQtaty6aaJRyZ5wkZmJuVI
	Adknjyjksp6vssNC8t13hNPr+rfa6eFTECoyuNRtzn0FFvFyh8cTjXmv
X-Gm-Gg: AZuq6aLySHyUhfRPSPA/t5vkuppKzPqUEq+J7kWswGzzEoD5IHozgsHIKP7BmQ4S9sd
	YDO8ZliIj6QDEPlJ4kk6y/wgq4EhRvysDzYyusCYXB6jqixP/x+svvEkwBiUqZFdU1c0MvtnpyI
	Jq9szh7tNhX2SwuHl6KZB9xCHYITzYCJy5G3X9ZXDbwusesGPiLoFJb9ZGyaHDmL/YKH7tmz1Ub
	MaIVUEaetFceJo4jE/2SuZqwh1TccfqQkEb5JH3G2KX/vNXx6XRPfLLsNUFLULi7pRXNyLXuOhI
	Lr6VOWg8hnodTDYWpq1kMIjPc6iV2RXnkGdy0k6OANFPx9aoxKiKdR1m1L6CR4JRNrCqZy7J9Wx
	zw+QqY6Xt9NtZdcAPfKQZQegnc7W/qH6KIJQDJfCNGkJq22i5uMomBpGgq1Ps4ymIqK1vx4SAaq
	TMPik94UFX38HDACMTBmLnDX2oOzUEM7d69Uc7xNPdJ6ADDptagEDh7UnM
X-Received: by 2002:a05:6a21:4002:b0:363:e4d7:2c34 with SMTP id adf61e73a8af0-39545faba5emr10493737637.57.1771947083953;
        Tue, 24 Feb 2026 07:31:23 -0800 (PST)
Received: from Ubuntu-Kernel-2204.local.tld ([49.207.50.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7243c24sm11028389a12.22.2026.02.24.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:31:23 -0800 (PST)
From: Abhilekh Deka <abhindeka@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	nnac123@linux.ibm.com
Cc: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhilekh Deka <abhindeka@gmail.com>
Subject: [PATCH v2] net/ibmveth: fix comment typos in imbveth.c
Date: Tue, 24 Feb 2026 21:01:01 +0530
Message-Id: <20260224153101.16935-1-abhindeka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,lists.ozlabs.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260567-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhindeka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9679E189259
X-Rspamd-Action: no action

Correct spelling mistakes in comments:
- Fix misspelling of gro_receive
- Fix misspelling of Partition

Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3108bf50576f..b2a578e6ff31 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -355,7 +355,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 
 		/*
 		 * If multi rx buffers hcall is no longer supported by FW
-		 * e.g. in the case of Live Parttion Migration
+		 * e.g. in the case of Live Partition Migration
 		 */
 		if (batch > 1 && lpar_rc == H_FUNCTION) {
 			/*
@@ -480,7 +480,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	 */
 	if (!reuse) {
 		/* remove the skb pointer to mark free. actual freeing is done
-		 * by upper level networking after gro_recieve
+		 * by upper level networking after gro_receive
 		 */
 		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
 
-- 
2.34.1


