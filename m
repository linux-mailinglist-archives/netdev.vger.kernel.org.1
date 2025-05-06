Return-Path: <netdev+bounces-188394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF837AACA50
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B591C7B6632
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AB283FEF;
	Tue,  6 May 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaT+K1WU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC848284667
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547209; cv=none; b=XmoqelGyA8Algxj6whq15yfVhrgqvrtLnHMBnB5jdifbJ9EKvbA2/YC4ACw22dob/toaWeZyN3OmdqCZPqkX+tiIg5uxu4LpHJq9MwraHFDK9aMyG4+r153jwJPjRUOAApQJtMqUqf+6OiCBo0u0CdpLTZAgYLsrq7yS39DdTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547209; c=relaxed/simple;
	bh=484I+MLC5U50gnDw9oFx3RURKBj/52zdm9lq+O80ffs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqXHfwzdUUNFUtNuOEAwJ73KaRSTgmk7E0sbFoSwiii0BdTop8XutnbvKBZkafF5c1q+fsYRD25S6pOCfIaPbF4jA6SHUyh06RuLrZx1XUg5k8lLKJ2CT3Q5dC9iCMXL2OHj+o2qia1jP9/Rr0xaLgq+PYSHpj2r3hVEHz1AkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaT+K1WU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b45cso76752885ad.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547207; x=1747152007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DeEpmQRwXolX/nkIjxhbBLC2UHTxfqYqsZypSvjmKIA=;
        b=UaT+K1WU1EtX1mIigMJuQMiKDb2OJCYvGnj2bth5YTReL8vhqY4ET0Gwb3/h+jiOyo
         fHZ+JEXynvIeoiEPn4jgpMF1AaMMfYgWpS/5lu+CiP9DCwGuSXyVcIY0nXyNfr5v9pUv
         0y/HCkiK7DtUOijsi3u/DBOAqv0mKp0Rrx7xAOKlhet4hyPtIqglqnUkPZQrofjYOtHI
         E815mwUSGysLOEMBk4HsrEnBEUnR+dlC+yzT2YZcLquTtQCshpQ1fuDlQddeVmjJWwzU
         9utHda+17noDxvCAvKHYhKYTpybMezLHF2fsqioLs/OhGLtjPTJHw6GjYEZEjPDUKwuv
         ZowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547207; x=1747152007;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeEpmQRwXolX/nkIjxhbBLC2UHTxfqYqsZypSvjmKIA=;
        b=S/JS6S12p7sm62CKmbNBYd+0ddiW40iV9DbzkhaXT3qR/XAjXf+jylkMkUY9R4DsYv
         Y0fl0eW4GsOcxTLQDYCq4oahLCQq02Xu+smnIOQpOn2jLIx8Qo8TKj8BPrnpSr5PWX7b
         etT2fa+T45/jrQwFPvUKFT2Fsl/SaQTP8S0qW/LtA+LDL7uOEFKA/LU0cK4/r4OIGcb3
         zDBIjwfLHKG/cVmvWyuasaOg3Je+ZWdes1USb2+uhka164jQ7/qSyagDuPc2LuAwECF9
         BScNdrDPDB2JYYe5iRG+9W0tzWbZjp2hf635/wufteIB8cDaw9hdc8QQi3PdMvgQnA/O
         kPdw==
X-Gm-Message-State: AOJu0YxeoJRj/TcLLXbkv7B7irMtpbfpjJB0ngImlZfzasbsorz0VgDm
	GfHem/iOzcFjvfe1ohRs++idIK0WzBa4dhGQTXAJqq7ZI/CxN/mU2tJkhg==
X-Gm-Gg: ASbGncvUfMSQJIDK10LCCY8I4Q8apbH8727vdt0KI2qH6rwfDEQIqsr3yRH71N1ImI4
	w+B1FDqAOOcTGdP7YJ9K6tc/x/bDJ3wpQT4YHbXuXoSS6okUH4HNnZh7JbxR0ro6gjf61KY5XKu
	N6y49eDZvqrzrkeIxPwcAAp7YPjRHnEck+4lrNrCO36POrT9gWZXT34nJV7BxjVp6Dtj5mZFHRg
	88zSmlZAhCtdGstQmUZ2Rs8VYiXk1x3Xt714LLuQzO5Kb8FHj1Rpheknvr6mYHHrRiAFeRr5PX/
	GZdqtCO7FxFbwYpfo2YiSTl+h0BBg+6LMmX15ht692cKl6LFeuMWn4M1WLdot3KUcohOhoKsMle
	dbEYkaX/O6A==
X-Google-Smtp-Source: AGHT+IHiDYyjWidn3HZeUQbkCKXBGWncwuLVNn7dA7dbpwyTeyu8iSw7zdSfbIoeUY9OAhOO1e5DyA==
X-Received: by 2002:a17:903:2284:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22e32f031c2mr50752505ad.39.1746547207081;
        Tue, 06 May 2025 09:00:07 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eb01dsm75676255ad.17.2025.05.06.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:00:06 -0700 (PDT)
Subject: [net PATCH v2 5/8] fbnic: Cleanup handling of completions
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 09:00:05 -0700
Message-ID: 
 <174654720578.499179.380252598204530873.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

There was an issue in that if we were to shutdown we could be left with
a completion in flight as the mailbox went away. To address that I have
added an fbnic_mbx_evict_all_cmpl function that is meant to essentially
create a "broken pipe" type response so that all callers will receive an
error indicating that the connection has been broken as a result of us
shutting down the mailbox.

Fixes: 378e5cc1c6c6 ("eth: fbnic: hwmon: Add completion infrastructure for firmware requests")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d019191d6ae9..732875aae46c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -928,6 +928,20 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	return attempts ? 0 : -ETIMEDOUT;
 }
 
+static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)
+{
+	cmpl_data->result = -EPIPE;
+	complete(&cmpl_data->done);
+}
+
+static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
+{
+	if (fbd->cmpl_data) {
+		__fbnic_fw_evict_cmpl(fbd->cmpl_data);
+		fbd->cmpl_data = NULL;
+	}
+}
+
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 {
 	unsigned long timeout = jiffies + 10 * HZ + 1;
@@ -945,6 +959,9 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 	/* Read tail to determine the last tail state for the ring */
 	tail = tx_mbx->tail;
 
+	/* Flush any completions as we are no longer processing Rx */
+	fbnic_mbx_evict_all_cmpl(fbd);
+
 	spin_unlock_irq(&fbd->fw_tx_lock);
 
 	/* Give firmware time to process packet,



