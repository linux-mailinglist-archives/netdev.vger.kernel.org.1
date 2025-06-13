Return-Path: <netdev+bounces-197319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D81AD814E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566481898A8C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6D1ACEDE;
	Fri, 13 Jun 2025 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNNtOzYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A418DB1A;
	Fri, 13 Jun 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783648; cv=none; b=q7LHhMo8XiymHVYlwkPTNeU1wsNvYsTm1Y/ycVBtPjvVCpYnowzs8lzeoChoD8QU9ub12l4C8SXLuJ6MQudsyR0YNd8+mhgbFaBuuvSJ00Figag40/E7fVf98A+LZBvR2HN7D26z/QXzBHP4H5N6Mg/+rFDITr8YkGpWEvt0EP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783648; c=relaxed/simple;
	bh=qG4WKJKh37Jr3xBbsawrgoyYZib+EN7XMZc5EdCykW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvqmAiapORdo93xoNZsAnn0G8Ik+uOl2W92rDGKNjABA0hJfSi1PtM0BjAagi5Do72Z+40YOUeeW44olZYjlHzHGNNoEryV/g3kekJQAiEhZ/4eJlvpSnUX4ly//oJQaWUvzZrWVewzq2kcAvYwnYYRqyROVAxlhsGoYw2q/VGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNNtOzYO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2f62bbb5d6so1221946a12.0;
        Thu, 12 Jun 2025 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749783645; x=1750388445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM54T19dtN0LeJmR19GsXrqIRY0k4iOQq5Gcw+NKT0E=;
        b=jNNtOzYOl0l6giQqre9aHu6Jzs0W/UQkdREidFZT8gmyT7R3dnpT/D4/j2f8rj0wsV
         vWbQEN2+GxTs1iNe7qo6wQPicnX3zW7rPpufLW+89v6ZcgEIy3Vrq/3xg+9IQ1ysNyDM
         mr1nAp4r3sLMe8Ns/BTgblmd+ggPUEbzfuwPmw6XSDtCUV2qvhoSSVKHchby5T96tIhn
         3dndg3YDZBfa2V+4WZLLlFsf2/BCtU68JJacMzVZbSTnkqMRHcGbR/wYIw3kj3o4kTsM
         /CvIST/CbpWCiQMC3Y5jl/yGyJvBCUco8t0SbFl54LryXYmH3aQkwK//Hg9XHRxqSott
         78Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749783645; x=1750388445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM54T19dtN0LeJmR19GsXrqIRY0k4iOQq5Gcw+NKT0E=;
        b=Zyhm+JBnXychPI3Uob2qzBL3KbHCdctb5XYJwy5qu25dVNSL2AjxnNcR/ozXF7/bT2
         alZxJ2jQ3cBAe3n3FiHc32EN3KLCI3Vhv0JHOXiypbW6EtGhBxol2aKirRYd1TXHnaCh
         6rwybIRv8YE1TaSxuDowCLaBnfGvXHCNCxZgt7bk8anAfF0ihLIdi9hpyyXGtFc8akph
         KVmvJieT3KI3I7ng9JeIzUJFnUV8HcRRo/BR3ho7NLIk7SfWAx2t1OheMf4PI8lC8hN+
         R7rKk4mI+vvyIgSy2n7fneQxBcUj1Zu6XIiW6TowbG1oQWS7cgX3XGkgIqhdVK5mitdT
         Wa6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUmR4s39VVi0SXEsCNyZKnTtwOcluPfkymAsLiUKkGyBGJY12OudfHDckTvXJve+EoZZPg1rBl@vger.kernel.org, AJvYcCVdKmbERXVqG4HeLYslpk5nnQG7FcPNu+I392FN04HKtZaCQpAc68T3CI2JrwG/Rj/MR8Fbc7WYvA8oM1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZct1tecV9kIx139nXRw6qaynmU8ZM/T9Cc6zKK+JyYhR0yO4
	Y+Z1bO5Jr32Ms777XgHNQ0pLlkxAqqyFPq3oOpisqhQgrkwe9ZV7BiE=
X-Gm-Gg: ASbGnctH4Jx9ZNulr4erYJYO8R+/7l3Y8aFawm3+1Ghj+ImfwSqcrArQExvzH+i5WRk
	F78sKZ+a+kV3Rog2dw9B8XIhBqZahb0ucF0+xIyMdNMCgtK8HwSOkTUc6X6HXurB6801vlrqSZw
	6E+A1aw0v8Vjp63XwlFoIErpqIru4YPI6/WQJy1s+svGtxvlQp0Sv6BwlAroMaon27p25ffy1PJ
	33OlnkSc1Z3mbgoT0CsxxNrU2dVkrh24u6R1ULXAjPmPSFAuIuQLbCWVY5i+TjwRKIwMKovoEi1
	JCxNIrZeC/XXdc1ZbcasX3f+0q4ccIH4wTvekjOomvHnhmYIsg==
X-Google-Smtp-Source: AGHT+IFRJjiV0MJJiCFVzI9F4OjJ7vuQi6crKSmVViAXsD4MrsjBzqOziSGAY1QNhS05waS6XWhRZQ==
X-Received: by 2002:a17:902:ebc1:b0:235:7c6:eba2 with SMTP id d9443c01a7336-2365dc0a6f1mr18578935ad.37.1749783644935;
        Thu, 12 Jun 2025 20:00:44 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb0484sm4468505ad.142.2025.06.12.20.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:00:44 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Cc: 3chas3@gmail.com,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
Date: Thu, 12 Jun 2025 20:00:38 -0700
Message-ID: <20250613030043.226990-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684b8f83.a00a0220.279073.0008.GAE@google.com>
References: <684b8f83.a00a0220.279073.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
Date: Thu, 12 Jun 2025 19:40:03 -0700
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> drivers/atm/atmtcp.c:293:24: error: use of undeclared identifier 'atmtcp_hdr'; did you mean 'atm_tcp_ops'?

Oops, I forgot struct :/

#syz test

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..96c0969ce584 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,11 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (!skb->len)
+		return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		return -EINVAL;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {

