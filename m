Return-Path: <netdev+bounces-292274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPl7HQLkFmpIvAcAu9opvQ
	(envelope-from <netdev+bounces-292274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F575E434B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7325F310625D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4093F39E5;
	Wed, 27 May 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="RqnP3vL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06713F5BC4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884710; cv=none; b=YNOIJgWFdfHXNJe7XBP4jj8+Wj+7GdcW08LJPMo8aHaU8PkkADdeHXJLR9LFbZuZooFxSeDDko6VaC4wxsjZOVWTsDwEuX13CWHHa4cGwuzT24/agzRbZJ/mk05MtoFoEH/ibXaRW2zlKKh74lCmsxgG/lfv1RNsmgGO6CKzdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884710; c=relaxed/simple;
	bh=mjwGIZ2kZHJmgR3R62XVlxDdBSkKuWbIdCvpQcxxNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKATEGYSExb2ziBQvbP7/CVbO3RkqAPozZR0/nQJpZovy75sHdGjlPB3c5YLIDYFmi0S5JHQ56CDsE02CaaOa8M9ElTziZqXRGBrwnAiTqGenziUSXaMn/PCK36jyzGqKQiyjLOCD7K4sCibG5TLnq2uMhYrJb1yr+CJudvnuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=RqnP3vL/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48584e7bd2bso302668b6e.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779884708; x=1780489508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOs/E8rK/exLB/8Zk3Pk8ZyyhyccLxwjQ0Syjke79QM=;
        b=RqnP3vL/pYGXLZQpnic5o7jfnMb0U7HkWjm2FQW1jsO01TdtGYcKMy4ZHpcsZb1Ycy
         jiKy35rI5r2hgx+gAtTC8b3a38Qdaf/JFq1Uof2Yg9qsBjgGVqsouKpZbYNqznCDsc1J
         jWIrb309XqqfCmy6zcGemXybFEfAdPoiFoKb7D+VsLSKIZ+I1iDwTBKQogpX3pPU88BL
         Q77sjKCU0oyq4/FXhYplL1k1Qihnnp1VOsBw0ayiIj3imdsDCMlXWVnw/ZDhwL+J1/2l
         fragFjpF3oxlQYeqPOtB3/jflGJ2qxqQiF4XLSDyAAo+r6KKBVxCtsWnnCt2WJbCGfwl
         h0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884708; x=1780489508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOs/E8rK/exLB/8Zk3Pk8ZyyhyccLxwjQ0Syjke79QM=;
        b=pn6nU7VYIrsdRsC53+a1kMT7q3898LNLyswRW2tINxSAoykbpGspTPCKxRx9DQIuvP
         aXe2lz3coUdKJpitlAnX0ZG9y9vXOicHkAYDownGpDsEu8ugzIRw3WwLkdjptI38oCfF
         4hNEi4o7KtgBxxcYuaTKZy5kTJjNUq/76THEbxjDrDCLiLEFhSyLFwp1Zdi945x9/2iP
         J2/8Xn8wb7fuZOdVRmzO4mgfEZR8FF2pFmIMfPwwV0zeyobDLnN9m1gik+430ahgr2dQ
         X5zed/0gtAD8gOtboZXMEkQX3/o6Jz805+LctXTJsJ4vTqqw2k/RBipPiI1r5J1b3NGn
         txew==
X-Forwarded-Encrypted: i=1; AFNElJ96YLSx0QU6Z37tYOUPk0ktc48X0EdPK9IjEQ7a9762ytMyi7j5PwBuVNQpjVDy+SNmdtB5QfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhmLwcQ3++euTFR0ZCGJMo8fGPOdAp6G30iLv1kos5N7SU62q
	d36wbrOA3be0NRvcKGhSYiKv+QMIC16AbkaaH9UMy0moTUWx+BkX2Gh1re63qYRx9oXT
X-Gm-Gg: Acq92OEGvfbMzNfT0hKJ+IOTB+CLGksU9N1ygRfiPRrxnGcv0r82LOtsx+ClGGMbNFJ
	vtf+MFjWRYcGzhKNgLB0PhSvG2VIN2/64UlLdIulXmtm3xfOY/iQIHVzICTd0vuXkHEzU6mvNcz
	j+xqrc6Ez07Y+8rJhua5pBHLEwspWsjJ4Q78swaTrrB8Mty0YbKp4r3KWWFC6/94vLEIGVLE0ry
	yFz5WzraUp55TmL6wfJHzRb/nZThZ/dei7ctGVxA9zjOe1zyAP9au0NEN8ge8wh1D2ca0B/d6Hp
	Ujl3yMCRnVJ4faEQ8+kWvNDcY7NX+rnext9yQ7lmf50gnzXDotzhsVR4V90UocXZ83daWN2D+U7
	8DeoAeuvIkXet5Gm9Ysq5YKvMk0+yK1WJ74nbGAnPjTKAszaTcdc68Vw0WuQunSZCYiPcFm1rxq
	2RCsG/MjZxDZELniUnT1qjjpOeRko1/e+lhi/08TvKv0WhERmeaXFE/Afnr/8a0vGdDwX0BsM6Y
	P0EBypzn+Aj7Tk=
X-Received: by 2002:a05:6808:1523:b0:479:f928:44dd with SMTP id 5614622812f47-48549ecff8amr7221156b6e.1.1779884707715;
        Wed, 27 May 2026 05:25:07 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485b5f0661bsm1475842b6e.13.2026.05.27.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:25:06 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Date: Wed, 27 May 2026 08:24:54 -0400
Message-ID: <20260527122454.66639-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161101.691d4cb7@kernel.org>
References: <20260526025154.60607-1-clusk@northecho.dev> <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev> <20260526161101.691d4cb7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-292274-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,northecho-dev.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E0F575E434B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:11:01 -0700 Jakub Kicinski wrote:
> module params aren't a great API. If we want to deprecate it let's just
> remove the integration in net-next. You have my vote..

Happy to draft the net-next removal series if that's useful.  Let
me know the scope you'd like (sk_msg verdict path in tls_sw.c +
the sockmap-attach side + selftest cleanup; or a wider sweep),
and whether the stable trees should get a narrower fix as a
separate backport for the 4.20+ tail.

Christopher

