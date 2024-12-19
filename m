Return-Path: <netdev+bounces-153239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C5F9F7506
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BC67A1386
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AD2163B6;
	Thu, 19 Dec 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHldMQm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE286352;
	Thu, 19 Dec 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591587; cv=none; b=fyszzWDXDVnar6q/R/9oX9axSK2Y7WUUdWCF8xLcFIEGDpskRDCcOOFrAg/edcy7OI97eVhNEqLtLL8wJkEF03TR5XZQ4sl65n2wbVQxzualN03i+PGwaKIuMRJ9bfxDxcJgX1YBQFryNIByyRRnuI9/sNsidocxO0jbrAgU98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591587; c=relaxed/simple;
	bh=1z2DrkdjR+MMQ/ZPu4VEYudxtI1fK2JtpHg/KGrFIiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJm9+9s8vb+g1EreYoW3b1klldVpE+h3Xnfw2BiGDA5z0Lvn49NsJcIfeSQ8M7StQ2emig7DYaWRrBPWcZlNXLeEFLheK0Ghqni1wP+2t+M8KKjWArVS0DCCBt9T4J7Ao9ERfXgzXMhDWC0o2d3ZtZb3aGwqdRSDW9BP6V4N5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHldMQm8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc88476a02so274835a12.2;
        Wed, 18 Dec 2024 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734591585; x=1735196385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doG6JtIS9OU4IiBAbuXfDEbqofaWaa+uj6C5Y49lGE0=;
        b=aHldMQm8xeRVlR5JEzGEQ/8zBVhCIRtGNUSGBj2mR13nGSbt3G4AVSJElZAx6ekAPx
         e1BosDeCkoK2X0VzHXYZpVxFQhhK/P6BjdLOnYb7Qy4arik+zTOHkzj/VCNRWPMoY7zr
         mSZ3DmCfmSN5CSqKlN7wCCFNyOjUjlX6pD22tMvgSboD+FkWH5Rj/9/7jQKOyNqmpPTh
         +GwKL7pxBU/gxWoM0A+ZTOUQsvKHnKPos3AMhn4ZanesrB4wx3nB5VeY+9E7J4mI+uPw
         zjuEh08KKa84iWtWkQ+Y3P+QJumddbImaEKjZ9UqNHucWQAwhB8BVVALTdaUC7o669lC
         EmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734591585; x=1735196385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doG6JtIS9OU4IiBAbuXfDEbqofaWaa+uj6C5Y49lGE0=;
        b=o8kuX+qg7UvIGSnBNkmX6FvWcVHc+v6fyYa91QTELLbtoi5CsZE2cRcSVNUhXw89Vy
         a8RnZTjKnd+XdI/H6jp3c5oY+yqswgU986c6s3Gy2ORkEorFASpTUe+l0NTjMz7U2pPj
         AAExuJatjaFgR9aq8QNUiFGTi25+oLgEQ1U//eIp2nNtDCD737uoZ6UQ8pBAhZ+hIQ96
         +CdAdF7X43VGGLm4g/d578LD/f1hBpz/RxCjPjA5KhfkRNhJjqjQtTGsh2ShX66jwS6E
         XnKsoyRUPd7hean2PFSRhuEK5dN0nAITlqVju30at8WTsTbA+0xCg4JKA6nunufCBLfj
         gzgg==
X-Forwarded-Encrypted: i=1; AJvYcCVoEsoStxtp0xSzAdXaB7v/LAIm3ZHhjrop1Xnq4eGYbcPkrUHMOpvA3f3Nzwy5wLLA9ZFk7mqpVU+ygdk=@vger.kernel.org, AJvYcCWDaz+jjZwrTsP3y8KHH0eDhf3MLKuJ58gxtkjCuMXHy9tC1z7CGSIpfPeDFb318o0RfvbJ+bRs@vger.kernel.org
X-Gm-Message-State: AOJu0YybiQ7ohf7D2deyju3RqLi+qZe3eZgMj4bUnF0UE0STik4fFu9g
	4y9PpWQZ0vLo14/vmwpe+R7FEAVp7GkXdNU/ixbJWqwugMDurpV1
X-Gm-Gg: ASbGncuFAZ3byEIfY3iqIKkINQpZZOkaWouNYWqk+GRIONaV1hnMVInz4GBtcFg04JL
	OCF39p+g1J+UlnMvf+gneEWw831sKi0otlnN+L59tU2Ys4NvCPurDvdtzF7EDRrir6mngiLDsts
	ChAm62M+9pcPcRluf6ERnLiYmWl6TlIWKRrbEu2gD2nnh7opuKVhWa5oyWuQDvfHvLyQJn4vW7b
	lxgsZJqskAJ8eC7vF5cqYsUXCqep8fJzfQMBUTEfkkiCXWiDVLbU7bnEbtmgA==
X-Google-Smtp-Source: AGHT+IGqs5Oeb2kD9wMinoiuL8IofSm2+B751M3dvmQejT22T3NJ2jw4Kftlax2nXNOrHlKzjRND/g==
X-Received: by 2002:a17:90b:264c:b0:2ee:7824:be93 with SMTP id 98e67ed59e1d1-2f2e9388b80mr7574916a91.34.1734591585555;
        Wed, 18 Dec 2024 22:59:45 -0800 (PST)
Received: from HOME-PC ([223.185.132.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm2823221a91.15.2024.12.18.22.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 22:59:45 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: parthiban.veerasooran@microchip.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH net-next] net: ethernet: oa_tc6: fix race condition on ongoing_tx_skb
Date: Thu, 19 Dec 2024 12:29:26 +0530
Message-Id: <20241219065926.1051732-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race condition exists in function oa_tc6_prepare_spi_tx_buf_for_tx_skbs
due to an unsynchronized access to shared variable tc6->ongoing_tx_skb.

The issue arises because the condition (!tc6->ongoing_tx_skb) is checked
outside the critical section. Two or more threads can simultaneously
evaluate this condition as true before acquiring the lock. This results
in both threads entering the critical section and modifying
tc6->ongoing_tx_skb, causing inconsistent state updates or overwriting
each other's changes.

Consider the following scenario. A race window exists in the sequence:

   Thread1 			 Thread2
   ------------------------      ------------------------
   - if ongoing_tx_skb is NULL
                                   - if ongoing_tx_skb is NULL
                                   - spin_lock_bh()
                                   - ongoing_tx_skb = waiting_tx_skb
                                   - waiting_tx_skb = NULL
                                   - spin_unlock_bh()
   - spin_lock_bh()
   - ongoing_tx_skb = waiting_tx_skb
   - waiting_tx_skb = NULL
   - spin_unlock_bh()

This leads to lost updates between ongoing_tx_skb and waiting_tx_skb
fields. Moving the NULL check inside the critical section ensures both
the NULL check and the assignment are protected by the same lock,
maintaining atomic check-and-set operations.

Fixes: e592b5110b3e ("net: ethernet: oa_tc6: fix tx skb race condition between reference pointers")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602611
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/ethernet/oa_tc6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index db200e4ec284..66d55ec9bc88 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1004,12 +1004,12 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
 	 */
 	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
 	     used_tx_credits++) {
+		spin_lock_bh(&tc6->tx_skb_lock);
 		if (!tc6->ongoing_tx_skb) {
-			spin_lock_bh(&tc6->tx_skb_lock);
 			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
 			tc6->waiting_tx_skb = NULL;
-			spin_unlock_bh(&tc6->tx_skb_lock);
 		}
+		spin_unlock_bh(&tc6->tx_skb_lock);
 		if (!tc6->ongoing_tx_skb)
 			break;
 		oa_tc6_add_tx_skb_to_spi_buf(tc6);
-- 
2.34.1


