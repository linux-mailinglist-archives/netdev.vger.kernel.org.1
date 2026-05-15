Return-Path: <netdev+bounces-288161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHKpKiOIBmr0kQIAu9opvQ
	(envelope-from <netdev+bounces-288161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE2548CF0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A86301C96E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E63C2772;
	Fri, 15 May 2026 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkZYetKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C63C3452
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812961; cv=none; b=gUQkx6bZnL17LIfpjo+H4gJg8CLxVVjf0FzQX5FFcq87IjD5XvdZknaVs8O2/Mu9tE34c66EU/IRBEZWDJWS2osxHfJzR9KdFFUwHkt3NAMDp2IucIRMCTxvF11XOLvMPfpsBxUj+bGkWDSLXBzn87FCCmq0uqXoWxbjaovI+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812961; c=relaxed/simple;
	bh=rWHGbHohgOySE830gytKZX7gqDyKkLV843P8Qr3kaT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGkOqxTdNhUCF2g4+pj3g624dv2r7b192t5dklUGd5GySCRagVOoboTwC+ZUi4ExVPwP1mPCG3zkvhFijkOqlQs/VoE14QVWBd+ldhQyJrsZGUMT5isGfVT6atFpccYUFaL/4B9C6QHZWg7doOAHti6vKzmYd+yrnlc0/EeFgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkZYetKT; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132830d8281so3572651c88.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812959; x=1779417759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIp3iYXnXNMmxZZYnuz+1KU87Bfjlx2A8Ev02qeKxgs=;
        b=FkZYetKT6Em0BHjsLVIielo0vCfbyQ4tQt3qxIyE+/RYdR+6iNYe7wC/Vxx/zWY9XU
         aFOXS3mPn48zYhb7tJ6+p69nHWihJ+RCHdrEZrCGHRNKZbtvlkwENs0Nh7MpF/f4ZLS8
         0pO9Yr1iQD9/b3fbVhmC2xZXMQafkKUiL4lYamTAPkPa/l882TSpFAqgg4aUoCx/79Db
         /L14f3XMS+ZlLlmC93IdDRrCoFWUKAbfWS+W2h82KO/spP0WIKuYUB4vzoS8M+jrTikt
         2p4qmmXpcD+GeXc0KfwmQ6KtXrD+HNJ+IX5Cwt8O/KGOAeZuI/3wYgXp5YtIqBCiZ6Br
         nVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812959; x=1779417759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIp3iYXnXNMmxZZYnuz+1KU87Bfjlx2A8Ev02qeKxgs=;
        b=p59V4MyTGFK1W9P+SJpoAvpJdpS8TFez38qRKHYMwBRCud8NHo5lg1Ld/8/SLI6IeK
         Ldg5FKH14m4kvrzefm8GpWJ0iqJN3ii3nEoqS7Tzqub+bTvxPq6Ndf9M3LGaVNXde0FS
         Hdc0mxaN393qDVEVvDZveIenLdROGLvwI8ln7h+WhOYmuOOL5UPDJcn0HoiBYPfob128
         zjVkdVV6wQRb4cJbS0krHG4JN/IQrmZhNNSiMVqOteZwwK4GqZMokoSy+jSGQ62vf4+h
         Y4xDd6twZiGOnOQ50gCxOh71u5L3ABt1kkTaS7YsuyxjUWZ9dy98AQv9CLJfOwTxqkWl
         unuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZWSu/QhzdY2mT1I39saNihsgdxCkijDISWDW3LOhLgyYwOyltlEaMTLGwoPxqa8uNqyhWkkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoJZkI1aY3pu15Id6E5pg9t80ErAHF/SvuFVdD+BA3DCnJNNr
	/RCOwTQZk52NHtWylRCS2ldDKMtqRyhpFk8Sto/P8fSTMmpKHXeRwxvt
X-Gm-Gg: Acq92OGRHyLG9F4U2OyPhvftTLSeVGspnK5JX4pjPSySrx5cxqC+Y1L58xvIDUoSDPG
	dLWw3Wg9HuG6Z9wqmSfeRmiEI6PDRQ1LWWR+JUXu04C+BuQ3H55ha2beRIbETh+dYEGMCJm8Mqp
	h4vosnD7n1+p+8WPcfpbFlQgvb/AReND/m1HsjoXlEpdjfx2sAC47rs/IVBULyU56ON+VNXmOUW
	TMCf8I8CWZL5Ron699M0WXePfCBt8Ffsj9Ytq2ZYG4wRkm2AB3HzA2xNUIvRrWp6mZT2YFO8zAC
	s+PCYTAhBk11DavyDvGGmHCSJ77p8K8qKzU/fCAV21scqpDaMGOQRtUlT6YvKl7ldDlh6zSBueM
	M0c4RtQtDUNbmW4K2HqJz2FSZ0dNNcd6GeGD5S2CRzGUUl3sjzBgWt1PWPFupm2Oa3eYYyBzOK7
	CrMqr1wcb0FXBbsH3ZSm6E41mnLGP4oYEi6g==
X-Received: by 2002:a05:7022:6612:b0:12d:ce34:3f92 with SMTP id a92af1059eb24-1350552c4c6mr924814c88.31.1778812959442;
        Thu, 14 May 2026 19:42:39 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm7328271c88.8.2026.05.14.19.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:42:38 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	horms@kernel.org,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 10:42:33 +0800
Message-ID: <20260515024233.204019-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
References: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66BE2548CF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288161-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Agreed on the return value, same reasoning as on 3/4: a length
mismatch here means post-parse mutation, and the unlabeled
fallback is the wrong default for that.  v2 returns -EINVAL on
all three CIPSO bounds checks.

The 8 is the offset of the first tag's length byte.  CIPSO option
header is type(1) + length(1) + DOI(4) = 6, plus the first tag
header type(1) + length(1) = 2.  We need ptr+8 readable before
dereferencing ptr[7].  v2 will document this inline, and use
CIPSO_V4_HDR_LEN if it's exposed in the header.

Qi

