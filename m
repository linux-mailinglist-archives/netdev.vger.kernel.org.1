Return-Path: <netdev+bounces-228213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105CBC4DAB
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFBF3E1B1F
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36900248F5E;
	Wed,  8 Oct 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3wOw4R+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E288224B15
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927052; cv=none; b=MqYnHONz4hgiEC4IjdhOsJXd9E0cO37CNqCKNzSaJVUFlSwX0YwRo3M73QX8Mek+7OYXK28fbAA9h6cmrB9c6CHn+9nYcLOAhndxNv0PpNekvzcffH6ztMWSQbdvANLt4NvG/PmT0VYbbEOK4J/k9+3iC6MiY99sd6kBDj2cx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927052; c=relaxed/simple;
	bh=V0yyKxqZgbFO/0v6WO5ujCe0dE9JkSsBVJjkd3iB3MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3piYmuTbUxAsYvkZp0QDJlowOwLlvMaWbFrCYCmvfjuLozManzgZUT7RQy5cY8i3UKRTm3SwI53RJA+vv5L0kNCgx/wnbD919JCOPqJPrA4YW24L+A6ANmyN0wSKXpLKv2eqKYBDtllFaVlLMjdsvKAx08+DFYUIfJZK3vYQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3wOw4R+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4257aafab98so2922768f8f.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759927049; x=1760531849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2TnAZHPDozLT5yZkEQn3hUFYpt7Se4zx7CRpBYQteU=;
        b=O3wOw4R+3mpFzsTbjWPo7xmxvqC7o9eL/zeXWB6zf6doU/HrlHW4xirCdykDrCJtOs
         EagQgH4HgbcqUUNii1c2i3ATcavt8Anh47RfErpDDyNhtOBLQ4XjIoUWdWk6CNGtGwCO
         CVDzt1AsUktpk2O0H1Q9C3D7rsAEWNZHyX3KWrRVhhq2UQgulYfGgCWmckp1mRjxyEyP
         2Eu1QRqpcyFF+zNPEattuAQvWMDUcCfIK4Rus9k3sAjhfuG30SaMP7+THnHrMFiqp+CW
         aflVMijw1EPXB4DEZzq2c7TYbYDSoNyL4Jgd5VweG7sfYrrhGouT6qsY5g2XppccsIhd
         97OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927049; x=1760531849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2TnAZHPDozLT5yZkEQn3hUFYpt7Se4zx7CRpBYQteU=;
        b=c2UfjxuJ1SJAeuhjKSV40NXsVMMj1y6+LCIZcXy7AJtOZ4OKfxPzaPWEYjnlK+S7Ah
         hMEB52PmrTfDfaj1y81qlcUghQJGli+epbBSxgmsozuGTyQvVO1MlRs5IdQPyk+dykWo
         AGVc0DIUoSPZlSrTW2pOePdzSt2QFYC43pVBUCqVCrXFOTfiLgTlYXtgMwAj7Lq49M3Y
         vGdB/in/GgPjYXFefOakaZySsn6EWapqCdmLaKvjqmnapl9/axhNz5DQrrVuNVYDqLCa
         /n3GI1Jpdcjur4Gxi9+3UHIp/nbXaAhruPv66QL3z0/RFENJgsUSZ2Ylq1R8RLWbqs2x
         KYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBTxFqwJKhoJeJL2VhpLc7PJRh3dCrkca9PHnF7+KO/JxwCYJZ/ouco0BEEldenSbJeGcdlxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKE+KiKw6FlG1QI+2NgXLWMRJl9StIRk/Hn3g8fb7+zIbsqPn
	BGZwzUIAYJmyfxh67j33f2wvtnFgJiWORvGjN6SztWo16NUI8YG2e04u
X-Gm-Gg: ASbGncuSNMMnmuB2yDCS1ncTcXwTUhC8ghODPW7KmaPDVhNioqK227g/aw3ds7npqwj
	BLjiv3brhzd//KS4qEuOCrYPjRpZgjpKJ9Sw6jRE1LowPYOmr77sdqpfvG7u/SzvyeT4v7SfQPt
	n+FGhAZdMv6Nyj66gnecyGMn1zQtFexwnJxBT/8N3gSDXE00hofLnJDSNlDK6deL8et2cWpJxAW
	ImehxtBxIydbpDw+DIErNByAapz9Pz76SjOcKh2kFQ31/RXZS9yx2fjHL+ZcKmfqAfUPlXX77jx
	ErrDUAty1sdKBd4IlaMbhixhrZEIMiRTXkING7IHvIXQRCKhgSJl0r580tHgBmb1q3w1DOH7Nh+
	Qy/aqVA92Ux7qjspoNOJ0Y/Jcjl6yBocPMESfzQsL
X-Google-Smtp-Source: AGHT+IFw4s1qDph/qnRfxEwZxh0I5sK3smzwrgDVM16o1rujr89ogmGIxIuGoFXY4FIUDR/y29IEaw==
X-Received: by 2002:a05:6000:438a:b0:425:86ae:b0b with SMTP id ffacd0b85a97d-4266e7d9330mr2343788f8f.38.1759927048667;
        Wed, 08 Oct 2025 05:37:28 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:b002])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b8bsm29727055f8f.4.2025.10.08.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:37:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: increment fallback loop src offset
Date: Wed,  8 Oct 2025 13:39:01 +0100
Message-ID: <1b3a55134d4a9a39acab74b8566bf99864393efc.1759914262.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't forget to adjust the source offset in io_copy_page(), otherwise
it'll be copying into the same location in some cases for highmem
setups.

Fixes: e67645bb7f3f4 ("io_uring/zcrx: prepare fallback for larger pages")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index eb023c4bc0ff..0a43acbdef98 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1079,6 +1079,7 @@ static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
 
 		cc->size -= n;
 		cc->offset += n;
+		src_offset += n;
 		len -= n;
 		copied += n;
 	}
-- 
2.49.0


