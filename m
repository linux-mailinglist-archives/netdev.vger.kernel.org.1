Return-Path: <netdev+bounces-271248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JlYJyHgwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:04:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090D31B2C6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C967B3026ABE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B993BD24A;
	Tue, 24 Mar 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFYiSSQN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA73A1A54
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378806; cv=none; b=J31xfDje0k7WTykfIpxyASGqVxS4wZo47Tl4SbR4dDd+1UtdJZtDFw6HswP0E8M6LMzZsZ72Zs7+TiIbqaF7xmPAXWTN8jV9bBDzwhepN+xnHrIYpk6KNeuX/ulmd1W3WJltG/OpMKv/DinYayWmXv3ZSh8INXsMELI7VhA9f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378806; c=relaxed/simple;
	bh=jUFJvtaq69nRHMngc02znHC4Tix157JRHOphEm1e344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4El8gwR2OZEOUFf++N/MJMBx/iphyi/MEW0Jmm7DE6+wioerJL2SjuAaLbKXRY4MvUKlQMFcCt/Yi4oaax0/3rTE/uX7CXqEuy0dEzQKT4mzcJfHDIqDUcytCKi5zGPoLb35SaNqcPNNwCDSeSYFK/5m+R0vP+TsJcb+v055vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFYiSSQN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb14227cso17471425e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378803; x=1774983603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUFJvtaq69nRHMngc02znHC4Tix157JRHOphEm1e344=;
        b=ZFYiSSQNv4KpQKmAMOrfP1CH/SlvSKEyOSfSlwNXgAXDFN3XHRV/5nQJFBks6keLCy
         u42OvH7vA8FhMXPkXAcS4KNIgmbDQvyqZ98hhPGZoandyBsBL6NJyfxvlwA4m1sxDH2x
         aVchJnGH1ruvODq0MirxQDfJSh4q6gveaq6AAb3ojto9oPAgwnARcGuZhpae20iAW5vo
         aK2T7xugPewi3/AjDh9+kwYM/ebhIxt9pao5a5rITk3ZyIb27/9p6h8IQw/BxtIev4hf
         tK2jEgq6INjIBWKuClp0H+Sn++OD1OX/2Oqnwhy1czR7/6lm6ec88Y6goC5JD47BFd1l
         ydgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378803; x=1774983603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUFJvtaq69nRHMngc02znHC4Tix157JRHOphEm1e344=;
        b=ZdsTzsF8XMMJgnEXvCYSJ5TWWb3OCfix4b9EoOFB8z6hibvnuriwfH/64F0vf9OQ96
         SuRylMnJ4hECcz7ywnl2KGtATAxeMo3BtEdTCxxFaSo8Fxbe7kdFOdJ8w1SDMjJFMrxB
         vSha+07iqGH8C/sLVT3mOP2T+moxuAaz8Mx92DC3I5s5bdk4DcJJJaTXZPmTIegDsmd/
         mAMluDofx7y8VmtRorF0AlBAPMq/kepn48LARUuXsDqBMZGTRAhrU3j9XilHjuZ5JtjI
         9zlOINixYO6wVhC617kpb/GE9hLEQTDsahf3n1w66UveB47CGoMbsD1ptGxht/RNQmWG
         szVw==
X-Forwarded-Encrypted: i=1; AJvYcCV6MRmFE6xh7suLMxo4PMOEhbjT+ZihQ2tXBzEapayPchrc582iyAMbFfkx3hcqMWIhlLdp0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmo04rfi8FAG4ix/UDn++nUi+J3mZaspUaJ7H1xeV610jTt42Z
	EGn711G/wYQcDZHSLuU/yqK9kgP37psg49tsMfl/bEry/Yr7QpqQe/IS
X-Gm-Gg: ATEYQzx0rEwiQ78pPjoNWjWpXxFEOTYDFNvY3UJ4GcR0o7ygn2/i3RrO0xeMLXgdYQ3
	ZapuYo/HY6ZcH+TBy8jhexMCwGEe1mA/aoEFD7Hb69IEzmkWV/bOP26vKEE619UFZ+SzPrrHriT
	79xQeObT3fM/gh9VVrWKzS16bcFZ6JhJkqM2uDzHhQdw1Zu7Sz2h5UAMOoyXkeabgfchiK/gY5H
	nH/kXFeR0ZP6VqLSDOHB2O8KBNnmfhBcchfVMh4qKSu5C7g9/Nc3torcEZfyyzSvbmT7acXsnpV
	3z7fQE3RtPYNT2TLSNLXthuXmHm9oopdc/gTbYmEA6qQ+VcIVjwwwMplqd1BRq8pCLa+VEaOrt4
	+dQbl/WIu9Wh7EUtWO+cXDo813jco8kCYpT7XFUH8mG53UMLyXbAi2dxdh8oDDbRnGcu2ZGhO8e
	2u+72pLEipTmTWSVdDuNgSoht1VdDE0xEfLBFOgKc=
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-4871606c9e8mr11861135e9.23.1774378803195;
        Tue, 24 Mar 2026 12:00:03 -0700 (PDT)
Received: from localhost.localdomain ([102.164.100.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee57esm64387355e9.14.2026.03.24.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:00:02 -0700 (PDT)
From: David Dull <monderasdor@gmail.com>
To: longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	linux-sched@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Dull <monderasdor@gmail.com>
Subject: Re: [PATCH 1/2] sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
Date: Tue, 24 Mar 2026 20:59:29 +0200
Message-ID: <review-monkeos-20260324@monderasdor>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260324151827.2006656-2-longman@redhat.com>
References: <20260324151827.2006656-1-longman@redhat.com>
 <20260324151827.2006656-2-longman@redhat.com>
 <20260324151827.2006656-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[monderasdor@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2090D31B2C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I went through the series.=0D
=0D
Patch 1 correctly updates HK_TYPE_KTHREAD to reflect the post-041ee6f3727a=
=0D
behavior where kthreads follow HK_TYPE_DOMAIN. Keeping it mapped to=0D
HK_TYPE_KERNEL_NOISE is no longer accurate, so the alias is the right fix.=
=0D
=0D
Patch 2 properly introduces RCU protection for accessing the=0D
HK_TYPE_KTHREAD/HK_TYPE_DOMAIN cpumask in IPVS. Since the mask can now=0D
change at runtime, guarding against potential UAF is required. The=0D
changes are minimal and the helper wrappers keep call sites clean.=0D
=0D
Reviewed-by: David Dull <monderasdor@gmail.com>=

