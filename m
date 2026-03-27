Return-Path: <netdev+bounces-272298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePURHP7UxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:53:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F133DA1F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8481C3045244
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C6285CA3;
	Fri, 27 Mar 2026 00:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9D17B506;
	Fri, 27 Mar 2026 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572794; cv=none; b=Oh6PoYYqSnED+fQ6ZAd2cwQkxtFujjB0SYu8hN5hWv5vmN9dQdad3AQwWJHjD2qSSqdaJlFgf4lCoZ5Ow7vdPHGs8T9/hRcAA14PgQP6MSgKS2Q0YnoZcPGcH6LIlfhppmCb28/qBiOGs21Qua+RBKe7+1zzVfh2hQSrdsYsenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572794; c=relaxed/simple;
	bh=2Tj8FhYeYSefEX8K5EuObURho68fn3pVSAjbtBdiclc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/OS2Y31+Ib6HInb73NAFyN7T0AcJWcTLEMADkSYEuYatXQEurf/fZzJOW19ksoUIn4Rxd0Cls/aCoj1NSAKngg5EW0vWpko8k5nB9XxVWz5Jj8uRiFOEMGsC8Unxe3zh1LaDTazoL/390qac/MJLnVvavk82eSFjPSQNVOGBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowACHa+Lu1MVpacf4Cw--.52081S2;
	Fri, 27 Mar 2026 08:53:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: Re: [PATCH] qed: iscsi: limit command queue array fill to the ramrod array size
Date: Fri, 27 Mar 2026 08:53:02 +0800
Message-ID: <20260327005302.70741-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324105629.61282-1-pengpeng@iscas.ac.cn>
References: <20260324105629.61282-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHa+Lu1MVpacf4Cw--.52081S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW5GrWkGF1UGryftr1xAFb_yoWDXwc_WF
	WDCan09w1kuF4vgr9I9rnxArsrXrWUW3s8Ja1rtF10kryavry3uryrW3ZIkr1UJa9a9rZ5
	Cr15K3W2kan8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU18sqt
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA5F133DA1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

No, I do not think the existing feat_num-based check is sufficient here.

That check only verifies that num_queues does not exceed the iSCSI CQ
resources reported by the hardware:

    p_params->num_queues <= p_hwfn->hw_info.feat_num[QED_ISCSI_CQ]

But the ramrod field being filled afterwards is a fixed-size array:

    cq_cmdq_sb_num_arr[SCSI_MAX_NUM_OF_CMDQS]

and SCSI_MAX_NUM_OF_CMDQS is 64 in the current tree.

The in-tree qedi caller derives num_queues from the device-reported CQ
count and the online CPU count:

    dev_info.num_cqs = FEAT_NUM(hwfn, QED_ISCSI_CQ)
    num_queues = min(dev_info.num_cqs, num_online_cpus())

So the existing resource check and the ramrod array capacity are not the
same bound. If the hardware reports more than 64 iSCSI CQs, current-tree
callers can still pass a num_queues value that satisfies the feat_num
check but exceeds ARRAY_SIZE(cq_cmdq_sb_num_arr).

I can resend with this clarified in the commit message.

Best regards,
Pengpeng


