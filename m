Return-Path: <netdev+bounces-207954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5560B0923C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74A65A1296
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B72FBFEF;
	Thu, 17 Jul 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXiZjeSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222C2F6FAD
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771109; cv=none; b=Cs6X6LJewc3FBFjV/WNpNyKU40SMaT3AI4MkFpPy8xADQFBVrxTeDrbooO34LFdkkh7fHXGjGXDC06SsQltWKTSJW1Mr2XjeiAyyNuQkLJHYi58qPJ6Rt8yJgFm3p0uzV9dEakDIVQIh2nDvluSxXCL5RL1c2+MRU6yDC0iDgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771109; c=relaxed/simple;
	bh=vSqIIMpfjDEWSnaxVcmQ57qEz8Dv+TT7CN+JYewOIio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pSCrhVX0oZLHda90PnkicDrIEunSwaE80VoKFiW1Fi4M5iSonGZfEop18OIw+46E7S3ZFIyo+/Z0r8dSe1+VvTn16kM7nAMj8jzNvAvh7CfSKxUVxXXBsptUmB8gDdBcQKx3l/eXE2PR2Iwo45EeAmdt2wQqUaAkTwAiYGgD3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZXiZjeSZ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60bd30dd387so560302eaf.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752771106; x=1753375906; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IX/EGcu9u1or1+bK6N8sAv8SP5I6DFunSJGDg5dFz/I=;
        b=ZXiZjeSZPvZkzPBU/vqct3bx3Y0Xof8PsdE4IeAJvi/XkAlNCdtJzhwyNv/enSzx2E
         f/Y6Ji6WRS2mXp8feDmBLHk46eiS5EAy/rvlB4H/ty/kh8uPERpbKBhWH6lZerQNYWGr
         owe1K5wloOuDS6C4P4n1w2Gh3nhr+zZ6FjRpbJrR0L5iWtSBiY6StnFyN/giTxe1Fm+l
         jDTRISzqJizzddLvxqCE2QjcOuvR7DkW91B0c2lhRQMZ05yOHaCFynZwFYCo7diTuT0s
         2IFp+fuOWAJtjDDd41Aniu21GxdMA3QY7C24+uKHVwzUtvXT/ddQxDSHVIEdCEqLNZLN
         RRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771106; x=1753375906;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IX/EGcu9u1or1+bK6N8sAv8SP5I6DFunSJGDg5dFz/I=;
        b=PGggWnMYcKbXO5axLKdwiI9DApDzTDzjw41nWDupE1G4ERTHltgqbaYF4Qv7U8GTaz
         ed9Ecg2+Gmm/b8AH0wQVhao4NziCuhY2YGAxOO3QLjgHz9WeHZFBVMVfvupgqvcpgOQ/
         wRkuBwQd+LKDYcBanwUCyf20aqDZbhEM7xS5BSYLYt5A4qBbihP7lqp9Lf0qqtBet72N
         ibJhAQ105H5Im1uQQrhT7KwwCwWCMlj6gseWm26wCC7jtZqNhUrGG0EqQ1xei9zSIbRk
         eOFUewJpiugix1/6iLWLp77yajpr7E3ZEciwVJNLvX77sdWgYW65pJUs195eoMYwpl7x
         8ggg==
X-Gm-Message-State: AOJu0YwWmA9pCrkjKJZ3ggcafPP6CHcyrDGsyq5IEeAxpVpFQdJF5jKK
	uaVU93SJfRfT4vCefwjeRZE7uhOgQbEsSo/wXtDxavNdqul21h273B4JGvr4zLZ4/Lw=
X-Gm-Gg: ASbGnctRKxLB8e5kUd3UY4iA8rP9EsTVV3NQDUn80MYFyz1nMlxvszO56fP9rW+cG8u
	TrTMMByv25RDLcmi1rZ0oI11oLTNM3RyoDuK0NvcxsgxKgmkI63BC8Rhmv8thnxh86l7tfrYNzo
	M22I89W1QBJexa98xx4y9iQTS2vtey0TFCz1c35VyknD1CHYQC75xiRRnL9py5x9WSmRNGZwfJ5
	L9+dpjiCCML/iPTHJHJirUxAmz0y5NV4r8jVaa5LAzqEwyit7ym8FaS/OAKgt7hlWDdljEXHdTU
	8EMYxF1wCCm34RU3TAeu66THbf4zQbVJ/FE76Gm23N04GdxUH9W4aWXeif1cEF9QtEha/0Sc7f+
	wFAMx8smlUuBVrkfFaJzrhyTBFijRf202Yw65bh8x
X-Google-Smtp-Source: AGHT+IGpMRlKFp6+Tx1aiNEsjBTQRpgdihAjNdvFBEYYiqVdDGpDMyRUiwQBaWq2JnGOWxXQfDsyUg==
X-Received: by 2002:a05:6820:1994:b0:615:b1e4:62e3 with SMTP id 006d021491bc7-615b1e465d9mr2250757eaf.0.1752771105825;
        Thu, 17 Jul 2025 09:51:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1982:bb13:46f1:2e60])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-615acda3a39sm645825eaf.20.2025.07.17.09.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:51:45 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:51:43 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org
Subject: [bug report] net/sched: sch_qfq: Fix race condition on qfq_aggregate
Message-ID: <4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Xiang Mei,

Commit 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on
qfq_aggregate") from Jul 10, 2025 (linux-next), leads to the
following Smatch static checker warning:

	net/sched/sch_generic.c:1107 qdisc_put()
	warn: sleeping in atomic context

   547  static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
   548                              struct netlink_ext_ack *extack)
   549  {
   550          struct qfq_sched *q = qdisc_priv(sch);
   551          struct qfq_class *cl = (struct qfq_class *)arg;
   552  
   553          if (qdisc_class_in_use(&cl->common)) {
   554                  NL_SET_ERR_MSG_MOD(extack, "QFQ class in use");
   555                  return -EBUSY;
   556          }
   557  
   558          sch_tree_lock(sch);
   559  
   560          qdisc_purge_queue(cl->qdisc);
   561          qdisc_class_hash_remove(&q->clhash, &cl->common);
   562          qfq_destroy_class(sch, cl);
                ^^^^^^^^^^^^^^^^^
We used to unlock first and then did the destroy but the patch moved
this qfq_destroy_class() under the sch_tree_unlock() to solve a race
condition.  Unfortunately, it introduces a sleeping in atomic context.

   563  
   564          sch_tree_unlock(sch);
   565  
   566          return 0;
   567  }

The call tree is:

qfq_delete_class() <- disables preempt
-> qfq_destroy_class()
   -> qdisc_put() <- sleeps

net/sched/sch_generic.c
    1098 void qdisc_put(struct Qdisc *qdisc)
    1099 {
    1100         if (!qdisc)
    1101                 return;
    1102 
    1103         if (qdisc->flags & TCQ_F_BUILTIN ||
    1104             !refcount_dec_and_test(&qdisc->refcnt))
    1105                 return;
    1106 
--> 1107         __qdisc_destroy(qdisc);

It's the lockdep_unregister_key() call which sleeps.

    1108 }

regards,
dan carpenter

