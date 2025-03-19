Return-Path: <netdev+bounces-176088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FACA68B90
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A19163D98
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1585E2561C2;
	Wed, 19 Mar 2025 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+GGYSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C025522F;
	Wed, 19 Mar 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383359; cv=none; b=JCQMa/pua5b8Eu3YPKuJg1tUbi9yRyxrI12J2UfIjB2NiEa/P8KBKESKbVUyuNRvg587XYbcOnOFq3TTSH2I3Cf046revSWUSNQ2/MS/q8XUzwt/rqcrq+5hPFixxr2W6EtupHi699qdITcHmXgszlpML4ECeHd5RXLGQB25V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383359; c=relaxed/simple;
	bh=6h7bnQpHtPCW6xgpQ4IOScIZSu9bbeGGjJjoBgCuU4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG9mwOZeuzTVf4BnmG5yiRSJpm4pdsE5LUw0wjExn1HK6/bNoV8rNXFAkP9xoyDWH4/5iAi8COAFYbZ29q0PA+Vmv63Z1hXHejXAdWRSt7CXHhvFkq+qnr2AbG85DLrL6x+tQ3P5YY2cUPcWrgWNcjxyYAzJPLc3JLxT5X2xt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+GGYSU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so43852065e9.1;
        Wed, 19 Mar 2025 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383355; x=1742988155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4koewqxDTHBpZ5lG3AGHNZx2prhe+ZMYSkvtcR+jWI0=;
        b=E4+GGYSU/XN6y1LTpzF0Nc7lLDCPz3QkulezfxHCtlj2ktJT8XIaAesGS4p/9obVNH
         BHF4mkROjjwRbci1RXtFDvG2qAn3OTbMC4d/zRiKRqg89zUCkIb24hpl7sGhTlhsvYdF
         unFHdVM33zH4k17jG4fpiNCoCFGMOkNRpjTu0bV0fzF6VNmu1P2Y6lMTfDNUXtQU5KwL
         Hpo1dg5c/vVALmaA9QKr7ABVUSJr2M/fNUjRmC5cuMrN6AjQRXFGNzsGlwPfVlc2BED0
         N0ofOCR31uP4KnN4lAY51BGx8xX5MwlvSE0/cg/50AWn4mafV9mc73wr37wNwFgW7Trk
         p16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383355; x=1742988155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4koewqxDTHBpZ5lG3AGHNZx2prhe+ZMYSkvtcR+jWI0=;
        b=nIq+4sG8cE988lTiqqJXDrEXXOtGYHAwHdBP/rldtP9EcNSR4HiYHDsoUokAnl0wJf
         8o1uQir23A+N5M+WFEdwoteDZitrEil+IS+4A25FmAdORRthh1uyr9p+OWgbb86nAFgR
         jASgQNaOoHAU1eDol+3jbEF2qq8VzALuhzpwXyqhYYHv+vTKJ+f8r/OVBkZWiriDCLaQ
         FtQc35haO0kmz3gcoVIYHxUZzHUBymtfXfTjq1HT2lO6togx9pV6+SBbOUUtpF0747Xp
         fatgvfuGVqsqEDxz5g8CmuMS01Yvc9xrudnEGdGc1IY19ktvviyc208VvOffVY43B8zM
         0m/w==
X-Forwarded-Encrypted: i=1; AJvYcCWz1kEaZ0A5/YRMDBajRxIbsA44vgnkacEgxT6V/uv5/WA9yzI98fJu+cisZbESZA+8Zgx2XLNtqZnLGDk=@vger.kernel.org, AJvYcCXtuh2tIEaFKiiNf6117RicAFnlTJY41Wxx4Q9CLwVLwLQQOuQk338S6AyC/TDylo4WC2jCXo7E@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxQLveWCc2I72zZruWnk4nL0cpWHU17ss9q83a4zf0Cw/iPUT
	651DRnePHG4L5P7Oq3VplYxlZKvD++2c8EnQbqJkN5imDaBpjWL6fXz/kw==
X-Gm-Gg: ASbGncuuqnq6aIetyuik21s6MtXmdOJKVz/Hh96JkBy51ntyBYlc682SED7+KDrid7Y
	ouigcwxXwUutNbs2MVFXC4XL+L6KRJ+UCQa8t7FGkAxpNJmnIsQ1roJEoTW5qJAbbtKOVQ5TVbr
	7+6cG2zx/uZYSxm+tdUmMctYGTEaZ3Y+kabQMoiPF91BHCJGVuKl1H7mflyOncveM2Yyc2jN8po
	jwgGXoE9L0E7ail4H8TCKct0TqKtLUvQECOfQVQ7KP9E8dOpOJyy+8FctWj684ffG0y3Ff3XgMm
	EQ2JTkyX4+ep++vRke5yjPkqcpBfQG+tn6JqiK3y2p4j
X-Google-Smtp-Source: AGHT+IFjh8y0LX65htmjE2swKmejXWXdaxkB9KzsHz3/x3m6UmpICPzfObosTXJmlXfCz0tN27HDLg==
X-Received: by 2002:a05:600c:1990:b0:43b:ce08:c382 with SMTP id 5b1f17b1804b1-43d4379b70bmr19613965e9.16.1742383354964;
        Wed, 19 Mar 2025 04:22:34 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm16129995e9.8.2025.03.19.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:22:34 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 2/4] net: ch9200: remove extraneous return in control_write() to propagate failures
Date: Wed, 19 Mar 2025 11:21:54 +0000
Message-Id: <20250319112156.48312-3-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319112156.48312-1-qasdev00@gmail.com>
References: <20250319112156.48312-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control_write() function sets err to -EINVAL however there 
is an incorrectly placed 'return 0' statement after it which stops 
the propogation of the error.

Fix this issue by removing the 'return 0'.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a206ffa76f1b..3a81e9e96fd3 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
 		err = -EINVAL;
 	kfree(buf);
 
-	return 0;
-
 err_out:
 	return err;
 }
-- 
2.39.5


