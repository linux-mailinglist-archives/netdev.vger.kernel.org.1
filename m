Return-Path: <netdev+bounces-286450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJDVNyFcAWpRWQEAu9opvQ
	(envelope-from <netdev+bounces-286450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:33:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E3507D8A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E059330097E5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565FA35DA6C;
	Mon, 11 May 2026 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBGLo12Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1E19D093
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473994; cv=none; b=AI8yHhqbfIkEClZEor3jtbUJOUlCSuir7jeeur4a/RKJVMjt5B+OzOJD61jRUJb+696Gb04JVE43+oDhmOfARB5bhhddiPQfVsjttJ21beTVRuyokMK7T101UpdLQVYz6CMqmljuWZUKP9wN/HPszduF2aGrGNJS2kdsbS23H5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473994; c=relaxed/simple;
	bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fD+vQKzjdfSA+FBuLNeNPUNIh7nl4zrIdEtRu1gLAOvoLU0mrmsKApIfy6HroQOPG8KbXXbedLHxQom8MdYXpNQyLIdtW66lat+mF/duyp5a2ilG8kldujDPxx2b3Ea/n4NsYa+1PLgbUSrRkRMBAa9rJGXE5+13U0EPi6jNpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBGLo12Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9a9be502so23434665ad.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473992; x=1779078792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
        b=dBGLo12ZloAc+VJzSH2CCD3+cx07+7oiUkM174fM1hYWagO+vtdO4qxCgqOtW9Bbdi
         Y2WYZ85b/rbWYQ1DL4hz5/IJk/xoU5bxnX3zFF1X1hnOad+jYi8y7shas5fGyAQBsuSY
         hkbJ08A8KNH0GJ6rq9bE8t6Z81rNNXuT+++L+nFqjs3rixCDrE7PVC2UgmnIjPyEqzbJ
         FmMOOhzjQhbxHPrdFJhJYAcLv9Vm1yCSJooagYEaev40Gp0QxdaLLP8uD1fUpaKx7e7r
         koZpHx6h0HgkOesnqb+PN4ekJ7rj9/gNQrI1ajnOAJhF+MRIHxd6NVs+MXjP0d//8081
         C/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473992; x=1779078792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
        b=P/+teROZoiiNkONkxAgK2FokAAy3nw17ZUVQAJ9/+f4qMK1uKw7/kW9aheBMNdmIrJ
         RUU2YH5pugwnolaE67CE16J5N5oeuSKtpVJlv7J2zqYBC4ZUJtIYIwvOzrMoAW8UWHpM
         mP0o3IyOPVll7/UjWF+3aj7Dc/ophITH/0zpr4YyoBMVeDmOH08BtFETXRbd622yW4WB
         3e/1doHcgHA9sW0PtRvclv6l4xNGkN24zVQ4Rj+67XQ/wTxpur+qE3hc8+0V9d9+PdPx
         Nc6NxohgH4aKyUcTXPVugcX+vMfAR73jdGDbBegxzj7QZyNfo5+JGw72EXYj2yP/WzTu
         29LQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/AdIHxsNY22W0tA7nazg2GAEPRmZYBvvvOaXbTCXwuhhBL5fsBtOrxQqTQvdeuEXbF9pIYT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHa1ehSYzlVqTJjDTpV/OiJ+FiPuwOd6Vp04bqH2uWbUm0dUr4
	UQzLhaPFmYGE+inapOUOUBnTI+7em6vsx7fmadC39FQn0WkRS3C2jxVw
X-Gm-Gg: Acq92OHQ+RSlyQeJ7cXRedC2p0mSnl4HOJ1TLPXYtXATk9dq9bqR1ox7PeJ7DRtIKDB
	DUCxIAXpB1Zw+u3OGk+y3xKEMRdpHx0Kgv35uHwBdH3oifKjbY38LNiwk8xB2RXxjZi61W2M9Y8
	422ObzxF5V99VppKyboekMVI2Aackrniv3/t4A0Pe+ShRMctSNck/nr+00lLDZyuiY14Xrcbgld
	XgmZuyJVIV4m2ko/sBly3U+qWbEIc44Z+QJrJ+OVxhiNdsAE93IoQzXbNAJQFd3ASZrj6b8yLqe
	iyYC4/bDFzuCLaKoinmOrEt9Epui1XibKrT1TW0Byxs7D10ia7JXMqx1K4wRhFO0L/4E0C4UveR
	FIR1jqEYEYU4VgnTBDQu2NB/BpBkbp03Y9lgqyeL1JHNoSy/tgwHljoBL/nnQuZayRvDpeuZG3v
	iz/TNqv9BYwfoA3Z2LH+Wa2grwtr64VDqap+e3XaCFzbddLA++uhw7KMQxrjvpHA==
X-Received: by 2002:a17:903:903:b0:2b2:50bd:83b3 with SMTP id d9443c01a7336-2ba7908b656mr230847755ad.10.1778473992394;
        Sun, 10 May 2026 21:33:12 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d271d1sm89109725ad.11.2026.05.10.21.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:33:12 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: ajay.kathat@microchip.com
Cc: claudiu.beznea@tuxon.dev,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Mon, 11 May 2026 10:02:25 +0530
Message-Id: <20260511043225.1000323-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B6E3507D8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286450-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:mid]
X-Rspamd-Action: no action

Please disregard v1. The author attribution and Signed-off-by were
incorrect due to a local git config mistake. v2 with the corrected
identity has been sent and is threaded as a reply to this message.

Sorry for the noise.

Thanks,
Shital

