Return-Path: <netdev+bounces-237712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD0C4F458
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D66534D316
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C3335082;
	Tue, 11 Nov 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4O2sGt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77F3A79C2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882634; cv=none; b=gkcvBcOmz2HWRU7PmSF1kMDQNogj0fFK9n4nEUoy5UGLaF23cJKkM373MQ0O/0Aet9J6Ycyn90y0TGMocN8OYg6mnQ3NTr9H8ujZuTNQ54QRpyOoBxP4KprOz0Rapzx1xyct+slevGkCZGFO37cn24+HKDLCCpt31GoUU68gxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882634; c=relaxed/simple;
	bh=vY92TuF7Ej3Ez3brm3uCohFAC0n7L0hYCJSEeQ1xG/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PF2BVvAiwTG3jXy4EfVge1z29rZw30w8Ic5eRZunBTzZ+TyL6ifkc45xO7YWQOlSUCYUnfy2xJ4UFtH4L9i0+2Gr5mcH/oZCjm0wB6qZgQh7jPbXbHxL2L7yyISC0wTD+K+JyG3aOyFBz4OVrZR2iJnqb7H6iiMhyfGIkMDuDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4O2sGt8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29845b06dd2so6091535ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882632; x=1763487432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMvZzcseQYn3wwdrSrl5c1ZbByxcCXtXHqWe21yxXN0=;
        b=F4O2sGt8oQfDHD3uHt4XIzyIh9QgjKjU612asDdVUfxvy4iiulTT01u53ZnDG8To3Y
         +nSPGSd2R47oXQxBdoFTS0RXm7LujKyquflX21YwFykB7DzrmDOmLlIf4uIqE0tpoIaw
         PSzQ/oYxJ3aU+8z/RME2cYO5RcuZXhQ18VBkHRYTbLgCDCsHUR/KtGNFsxS/9LZHNS8w
         6dJqvcas+68HzFHetZYLvlHnqGc0YIFuWzFutujlWki/b0XpcqN0snPn5ItOzeFiiI7f
         mxW3+spdOONkK0TV6pinLFffmdtM8E4lZMTCDcsPF7Q0HT/61I+V4R8b8Dtw2vZM4J/c
         SoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882632; x=1763487432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMvZzcseQYn3wwdrSrl5c1ZbByxcCXtXHqWe21yxXN0=;
        b=WFNtG1KhGP+eGfnU3JY7jxW8XOd8wjLWeyVoP1IpBmLu3EBmEXD9Z2HvJsbKQ6KV56
         /Zbv4SUXLUk2gWE0orzAh49NsYqMrZXso4eBtLGvHEWi1EJ34TbENfKv31QjcJ78+GVO
         Bh2E89KCgh4GBhKdkZWSVVh7QWQwxZMPzEJ7UcssXQno8YLSkm7kfnDBRLIKAHJl/tVv
         QeJZHcNdL0p9F8oV7o5L9uJ3tYH/2PAFHo9ERLxzNZeK9yPRDJp4uFOYr3VS+xMBKLoP
         nM6NydVLme96B9dWQBPp5NLzGUf6IHw6gLDE2GWI2Wwd+fUtIOivb5B2owZIK4FW0QnH
         L1Og==
X-Forwarded-Encrypted: i=1; AJvYcCX2KCNyxVird8LQyNYlHvHlzOF/C7xrrj0BbZCPzsm3VqvUH2TQJijQ0HClvAXTSEgo7NIAQrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasL5gI6dsQWEEaZ19gClYoRJOEAJYDDHnzc0Exh2lmdJNGkaS
	eXbpzkHOau8hFormX2xAw0l1AqUxt/EbSyTXjLaeSvKk9CX1z81hAngu
X-Gm-Gg: ASbGncuPgeV0EXJ9Ze50gJrYiATnjOkL3Znts4Cdc7PXEsM/+Una+/4OCLChSwbOnA7
	AEeUO+YMF1sBGqvF0xLSmWe/cBaOvJkZWh69XoGR/InvUQU0hyHdKWBdIiQ960upVHtLbOKKXP6
	hIVLppWbCrZTB8ZlU+DSczKcGl4Qo+iwmMtIOvGyNQ9d5Xu9beyrMATJvT3txdNNBsuLTZ0FoVd
	1iyngL4WuLsAK0oDMkx3vkaoRSnNu0dkNyILAI+oIo42ncP1avi9UyGaNZhNMXYWm9IUGh/sm/t
	kBoGo3SE+kesAxYL5zonBYUNnKur68wmB0x+RRdL/n7oCMThrg5tbndpvLwjjM9VjVMcwNUcpnu
	kU3tWhYArkXZJvJNmTBI9SynEx081dwpyaINpJRskjm/dB8b65EpkXFpOQRNlhqiYpdk/jr4WIn
	svMasuaQStPt4=
X-Google-Smtp-Source: AGHT+IG5LBnpiDfUi5HlGeAIfhNNNhESoyuw+5Tec48NzHUFnX8+L1Hy73HslnZpG+1krOeegrC8sg==
X-Received: by 2002:a17:902:f60a:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-2984ed78ff6mr1696235ad.27.1762882631265;
        Tue, 11 Nov 2025 09:37:11 -0800 (PST)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf10c9sm3162625ad.38.2025.11.11.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:37:10 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kory.maincent@bootlin.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v4 0/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Wed, 12 Nov 2025 01:36:51 +0800
Message-Id: <20251111173652.749159-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103171557.3c5123cc@kernel.org>
References: <20251103171557.3c5123cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Sorry for the late response. I have updated the patch, NULL check
is moved from get/set caller to generic_hwstamp_ioctl_lower().

Please let me know if any change is needed :)

v4:
- Move NULL check from generic_hwtstamp_get/set_lower()
  to generic_hwtstamp_ioctl_lower()

v3:
- Add Kory's Reviewed-by tag.

v2:
- Fix typo in comment ("driver" -> "lower driver")

Best Regards,
Jiaming Zhang

Jiaming Zhang (1):
  net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

 net/core/dev_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1


