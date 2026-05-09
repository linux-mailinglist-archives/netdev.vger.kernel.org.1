Return-Path: <netdev+bounces-286081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE9LNV+V/ml5tAAAu9opvQ
	(envelope-from <netdev+bounces-286081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:01:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5234FD7CD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E06F73007BAB
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC8283C89;
	Sat,  9 May 2026 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOoMh6Mi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAF1F37D3
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292060; cv=none; b=O8Q4aVX5TvX36CNCA25bWM3o1OWMg50yydozJnJ6E3rIA07aYZtddkTQfExEU2cQCha3xOlviMVOiK+NuZuZnXjUY/tY+JmoXpyg3jXp87zmBbe2M0iAKEgUPdhIspHTdkPy07Z4mSx6fW1e6JWIusA9SMEYhQ2i1Wtp7fOLof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292060; c=relaxed/simple;
	bh=ZUlrchNmavF+XOJTMhvM5FxuzcLD/PnrtijAxlXR2MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC8CVf0AyrLHEEVfl3TTA4gD7OQ2D5mRjeuAlEiNfIbB8D/PHh/uZbTL3kIo3gfNEoZqHthomiS1o5icRPzPWXLQbMM40UsuKQUbnuP6UHfohwdeRbwkMYcoJcSPA/4WSf2geGnDyKLF9NhEqhMpnWxRBcer++mamJg1Y1FEv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOoMh6Mi; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1309f4ee973so3081771c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292059; x=1778896859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOneBU/OuRXjCQ2vWtkkfBO4kjJLbNuqFII3JyL71bg=;
        b=YOoMh6MiynJMcVHEm+p0NZyq8mA9Bq4DsJf0e7qydBWdmC2XgK6ec/bWKocNq/bQGU
         mt1zyj+1ipRDdFAbogwnUsY5bVrTvRJunvW/WP4/EROL2b+mK81AqUD67pAhiUF7/ouT
         Wj9yZCxbnajXKyGJDOdAFxPdSF64zJXIU9zrnHxLJ6aJtBPTQZs4gQoD9/HTQdREMhPV
         z6F4XPgvx7T4fBguxd373XJaTfKEKSW2uFEi7gV48b37aWZ0MASGqEoodOqHoGVMJ7fP
         CPPaefwzxsSYzKbdAxErROMCYr2+NxdY5jBpGcsNaafCqlOZYuEExaQpfi8nW9r3GcWG
         R/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292059; x=1778896859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOneBU/OuRXjCQ2vWtkkfBO4kjJLbNuqFII3JyL71bg=;
        b=Q8duCexmRS0bWzvlSWd/2Si/ZnBKutu4Ib41rhL/7T+Bn+sytr4xePtGu7So+9Qxr6
         4sXqrw2fT5JKnXEoJlVwb7BA/e3lJGZRsG4tEjmUvpdo4FxTYH3OYMa7O8uT+QafY0m+
         xlBEjiqqwDl60wpkyyo5APuJAK65Ep2nbXU7kbVp9MYuCivqRzjc83rwU4IKwvIsNsud
         L3Qjk1lA21Fm3PsdgdJG5hVtHHfTsB9rCg8NyAHuL7zYCnCZoeMEcHHmXRj4KA1zepyZ
         3GNIPzfARl3TwkmojF5RcSSrU0xbaefqfWG9sj6UcPOdoYO0JKI65uXehqeLSX2tZhsX
         5cqw==
X-Forwarded-Encrypted: i=1; AFNElJ9aWDlhPkZ+i2/WI57f9nDLAKPKfypFh85Tp2ChJdmHj1KKy+R/z4oZlZ8vsyoCSSVPeYosNa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMvHoUbu7hSeaRbNiE8VEilG6fssVHYDaHcLXLf3WvhLsDFsN
	TYM/6TP4TpRn6xmcak4TPFMo6MzKgfL7jaYjtTxhsu0uY7u17Whz8IEkv1bauQ==
X-Gm-Gg: AeBDieuhrNbhvbymd5zH9SzSCmi0CI9hQt7MHzJzQHbsue+NBDcSZu1FVpr8CBJUpnl
	3P/+WzSTgRnk/00oZPK70hm+zJPHUAdVt5WoIabC2YEeIYojpQEvm9XB7i1NDa6f2nLVLdQD3kw
	kF+lV0cuTVSn1hCEu14etOpP2UHjw6nxwGuPhG0mpoat3BMmlANYq5+3RknSIJlBQB26VF1OBYB
	Ou/jn5jBcsNCLt+6WWImJ25khehfRLGu/QFyy+DgHWiUf95TSiPTTzGFJl4JiyH53Y06SY3ZcRX
	Fxv6WGaNU98vaYCbaK8rmjf4YrYpBKUBFzqwr1PuvmeyAZZzu5HQtFOVKiavqeWUWzzGtlHfpQt
	u0KzuGaHIOHCA8qOLzIf6y4VAa9jOfW2vGtqL4+LkCnJrZcoLo9WMm0RN17khfwbKhAhkBjUhtp
	WJUza1FUyLv+a+ReGmVt3oQM4fEK+1miG6r9o=
X-Received: by 2002:a05:7022:6997:b0:119:e56c:18a5 with SMTP id a92af1059eb24-132a7ee83d5mr356066c88.13.1778292058492;
        Fri, 08 May 2026 19:00:58 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1329fc4bf3fsm1436242c88.5.2026.05.08.19.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:00:57 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: kuba@kernel.org
Cc: albinwyang@tencent.com,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hannes@stressinduktion.org,
	horms@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	shenyangyang4@huawei.com
Subject: Re: [PATCH net v2 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Sat,  9 May 2026 10:00:54 +0800
Message-ID: <20260509020054.1792674-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260508154243.3ce21bee@kernel.org>
References: <20260508154243.3ce21bee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D5234FD7CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[tencent.com,gmail.com,lunn.ch,davemloft.net,google.com,stressinduktion.org,kernel.org,vger.kernel.org,redhat.com,queasysnail.net,huawei.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286081-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

On Fri, 8 May 2026 15:42:43 -0700, Jakub Kicinski wrote:
> > +wq:
> > +	destroy_workqueue(macsec_wq);
> > +	return err;
>
> nit: err_destroy_wq: would be a better label name
>
> rcu_barrier() is needed before this

Thanks for the review.

Regarding the label name: "wq:" follows the existing naming convention
in macsec_init(), where the other error labels are also named after the
resource they clean up ("rtnl:", "notifier:") rather than using the
"err_xxx:" style. I kept it consistent with that local convention, but
happy to switch to "err_destroy_wq:" if you prefer uniformity with the
broader codebase.

Regarding rcu_barrier(): in the error path of macsec_init(), the
workqueue has just been created and no MACsec interface has been
registered yet. queue_rcu_work(macsec_wq, ...) is only reachable
from macsec_rxsa_put() and macsec_txsa_put(), which require an SA
object to exist. No SA can be created before macsec_init() succeeds,
so macsec_wq is guaranteed to be empty at this point and
rcu_barrier() is not needed here.

The rcu_barrier() in macsec_exit() is necessary for a different
reason: at that point live interfaces may have been destroyed and
their SAs may be in-flight through the rcu_work mechanism, so we
must wait for all rcu_work_rcufn callbacks to finish enqueuing their
work items before destroy_workqueue() drains them.

Does that reasoning make sense, or am I missing a path where work
could be queued onto macsec_wq during the init error unwind?

Thanks,
Jinliang

