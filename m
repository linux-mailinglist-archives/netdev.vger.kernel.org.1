Return-Path: <netdev+bounces-258907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKVEBlM3k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:27:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 714591458C7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104643009B36
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5E31ED7D;
	Mon, 16 Feb 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="F9UMX6ya"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E731ED64
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255087; cv=none; b=mt3z3guImnDzsnOWQ2RngaW9N2PKBJbbeefLhk6vANDrIFWrOVU4yjhpp4hzswdZfCtllxrqut1M3yi76U4cqClY9vGF+4v11HReObrUd3yQief9P+Xw2s7FxX3Nmq30ca7jI5lHhSYUghk6JSfLjCn4RibeQ55jHi/ikFR3h94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255087; c=relaxed/simple;
	bh=PZs64egFf98D6opBi9IV2y365g3VInqjaTNcAEapzfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWboOz0Yz6HOqjrOdzyCVg7ELe6hX1HYraIICy/uc9jpCpxJj6gRj4Q7nAsxaEhEYOnFKLO7BjDjmfrswbySuiZnhZLEQvd4fZWE77y2U5so+b14gzbanaoj+qibx8zhQkNIIgnPDpIKinvqFhaMbwCrhWVKxryqGLMoliqG2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=F9UMX6ya; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61GFI3X6062805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Feb 2026 00:18:03 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=m/n8MKEJn0WJ7xvqjv3qtGNNa5RsDItXC/ssgM6lK7Q=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771255083; v=1;
        b=F9UMX6ya72x+x2gUSm1dkXAaAJxSVe7eNgrggINHxJS+/spMQPWJX+qjBJAXvVB3
         i/j1oSRGAP1eAdl7lf9CRxSU7wmotZzR87QsDUdyFdzd9ggpQarIoXJmRcMadl5V
         uzGzNHbbrnXm8KVbvoA8y2WFbqTlOFY82OuMHaKoBt2uHDbjEghmitiabUE/uaTT
         TB3b9jbiq2RQD8g4OTdOCFtFMlHaBwaZV29yp5w6Wd64toY8GfwbuWyPu07Ic7Ie
         UsWcGFlnPNhQdw8bE+twxFNeYMxaOXIyGSAoWNOVOJIH7SHvFKJn7LtbqySblK8h
         DcFTn4kaHubYXilEgq5D5Q==
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, jedrzej.jagielski@intel.com,
        kohei.enju@gmail.com, kuba@kernel.org, mateusz.palczewski@intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, przemyslawx.patynowski@intel.com,
        witoldx.fijalkowski@intel.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
Date: Mon, 16 Feb 2026 15:17:31 +0000
Message-ID: <20260216151802.24884-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216144457.19871-1-kohei@enjuk.jp>
References: <20260216144457.19871-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,kernel.org,lists.osuosl.org,gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258907-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim]
X-Rspamd-Queue-Id: 714591458C7
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 14:44:57 +0000, Kohei Enju wrote:

> The scenario flow lacked netdev_(un)lock, my bad.
> 
> Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
> netdev_lock()
> iavf_set_channels()
> ...
> iavf_alloc_queues()
> -> alloc {tx,rx}_rings
> -> num_active_queues = 8
> iavf_schedule_finish_config()
> netdev_unlock()
>                                                    netdev_lock()
>                                                    iavf_get_sset_count()
>                                                    real_num_tx_queues: 1
>                                                    -> buffer for 1 queue
>                                                    iavf_get_ethtool_stats()
>                                                    num_active_queues: 8
>                                                    -> out-of-bounds!
>                                                    netdev_unlock()
>                             iavf_finish_config()
>                             netdev_lock()
>                             -> real_num_tx_queues = 8
>                             netdev_unlock()

Note that the flow of Thread 1 is based on a recent commit
b542fa9dd830 ("iavf: fix incorrect reset handling in callbacks") in
tnguy/net-queue.git.

