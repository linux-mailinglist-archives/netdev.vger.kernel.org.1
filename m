Return-Path: <netdev+bounces-307241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47f/HK4OVWrkjQAAu9opvQ
	(envelope-from <netdev+bounces-307241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8074D779
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AcEEqmGV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63157300DD4D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4E332913;
	Mon, 13 Jul 2026 16:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784A331EA2
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958850; cv=none; b=tUehmHW5y7XqhN4yT92FbdFhAw6g8/V6/wIlY1puFLUfwL/DIUxRhInkwFii0N+GaPQbDvVUgtF9UTf022zAf7xVuuVVmF263JbGJ+nAc6xEdhxAXeinSTHaPIfYXAZ2aGRjpWrBSrOlo8nVRT3Rv7HaJtDlcza+PGY3aC6oTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958850; c=relaxed/simple;
	bh=5CyTv5U6MWyCXFt100d8dtYFPsSpvqU3yEUMcAaHGzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDIa+X9nIDmbdAV4QicDE8IFhXzQtJ2OWD0E1bEL0TQGvRKccXzM/Z/sQaqVkxBm8Se1r5r26shZH1OQzH9vC6zcOGkcfUU65VDwtnKdoYnsltjdJShSS8NNL9deZtz6tF6RyM4cbGkh1UT2ZEm4EmyUpk3/wrZY0LayX6FiBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcEEqmGV; arc=none smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b0148201fbso2716021e87.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783958845; x=1784563645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYO24rPu7WlAw0W65K8PvddpNy9UhbGC3iAYCYYI028=;
        b=AcEEqmGVL7OGUnibqyviXrBdqwnpxDYj+fsLnOQcIuVdJqRiWpbCgAMm5x5rMBq4rk
         ACE3WPWw3ryOsqGc289uacU3ei1ZlqJblFbIIpchLKSiIUX3eq48BLT1XovodHHEzV/Y
         4NFjgnCNadP565lOGCU6iTD38DvIN/liENoJsW8fcKl37MxGLhoRUHR9GqTq2J0x5aE1
         r15HxdlMuu/1JYFEvjI02Q0HTGu7klL7ZDyflwPwqjLVHxhHfOg13D+5tyUQAkjvvhsk
         IrZcEh5MP728U/eDzq4kf50ztVVjykJB19HQfYd/UAicFGIrkbO0rqsZ1xvzNavyea/v
         asMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958845; x=1784563645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYO24rPu7WlAw0W65K8PvddpNy9UhbGC3iAYCYYI028=;
        b=Eh+ZNALXbBqQ9ad1OS2Hz31w+81yBiM+UGYLuzIw8bJky8IJCY6fnKZAS7ECO5g5zx
         7jsbWHOHWPW4ytCu4L2zQG6YiBmVuf80t5ZVTTl90MwqTvvovqDsclaSs5N1a+bmBomN
         jpd9k6i/rjOcW2SC2KXnI6SQOZgoRhWB/b/sKoYm4NDWaEjIZG64PqgANBzZ+aGbbdSh
         Db2YAkw9/LHcsswpLPImNaA2HygboC/AB29ONA9dE0Li7BaVJNp4eieCJGmJ4hXGPV0A
         LZMDwYCy53RitUND7f6ZQ8P/7Z19ayVM75TLS/3JikolVSocDR/NpsvQ8t3s+42OUAni
         ue3g==
X-Forwarded-Encrypted: i=1; AHgh+RpowUouSgNx3pVNwSDulu7K98jctcAvnivbpbgo5FoJSrcHBP+HYjuLmnyrqM4XmZRQHEs1Bq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9MYJLdR6SHpI1d/vs6i5U++dn65vapQqeBqvV8SoNtzfXN4u
	+vc18m1PrfhrAnhMn8InQyrkHrGEXe6fnSNPevtPm5DHPC0MuGHy5qYbemk3bX50uvU=
X-Gm-Gg: AfdE7ckg8T/Eq8CSCC6dxXIOT7gtMNr37Ht9+lqgOGL0vkOYKJanxECoOGmm+Tthg3T
	x/UVy7pknPr7XQi63XW+3kIeOTdEeydSIXXlHoe19dv0mNBhqDJDKz4oTXkm4ruOcK856+yhQ/6
	D2h5v/8PUCAVUn13lL5d37xibeFkkG8vZL3Px58b7nnRo7DByoTzFXhdCDSHpPx52dkxtUFMu36
	K1EHBeAtuOKJ7NBz+5C/0C3radfKPc6hACAM+JMYALYoy+SCZizKHvZ4EXOMGVoVEadXE0WgK93
	//qgxaMPV2Gg6gd5bJjcXF1brk7+07+lY4PuMkrH8RbxnRM1VNF+QP5IhGRKzTYfRKm4Y0KR16p
	r79Aap4U21Rb9wT56z2CuRlQxiWSuUH8d/XZnAhH4IrvDe4Dcv7YQpUUAyk0E//dhW0ZVqtpjBW
	2Ec8ZgaMZmvA/svpbTuVDZcb/pM5x1P7WuvNBMMf8jmcP5x8vZiw==
X-Received: by 2002:a05:6512:3d15:b0:5ae:ceef:7983 with SMTP id 2adb3069b0e04-5b0236c1c8emr2232228e87.64.1783958845166;
        Mon, 13 Jul 2026 09:07:25 -0700 (PDT)
Received: from grower.astra-academy.ru ([176.193.81.213])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84918967sm28901311fa.6.2026.07.13.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:07:24 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: imv4bel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Alexander Martyniuk <alexevgmart@gmail.com>
Subject: Re: [PATCH net v2] tls: Fix race condition in tls_sw_cancel_work_tx()
Date: Mon, 13 Jul 2026 19:07:11 +0300
Message-ID: <20260713160711.50482-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZgsFO6nfylfvLE7@v4bel>
References: <aZgsFO6nfylfvLE7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307241-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sd@queasysnail.net,m:alexevgmart@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13B8074D779

> To prevent this race condition, cancel_delayed_work_sync() is 
> replaced with disable_delayed_work_sync().

In lower stable kernel versions no such function as
disable_delayed_work_sync(). So could it be fixed by 
testing BIT_TX_CLOSING in tls_sw_write_space() before 
calling schedule_delayed_work() ?


