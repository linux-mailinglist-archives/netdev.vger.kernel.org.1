Return-Path: <netdev+bounces-256105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFLtDZ9qgWmwGAMAu9opvQ
	(envelope-from <netdev+bounces-256105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC9D41A1
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26D4304C09F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE182F28E5;
	Tue,  3 Feb 2026 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="d66njHCG"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFA2628D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089035; cv=none; b=Bh03Vg0l0sz72m1gL5DxjK6YjdDjfJNdwpxdeJwvB1TUKdwh4vYVmWnWhuCIbEzfArR49KTNDzgN+v13SD17D4kxZ3Yx2/C0qQ32EK7mMtT40hWZQc6VZg4jrmTYlUfGKA8tBoE8lMZNo7kGn2M4zIElXObT7QhAQ1yBUg/dJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089035; c=relaxed/simple;
	bh=aaC+Qz9A0pJrnNk8jpr6it0T4w/AKeyF+rjeM19giVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci9k60KPDoEHqKhfGiVyJch+VrORcifWWbCUDNk11soGp7ysqbdZdlO2ORvgJxw2eTlMZ7Hbrs2SGidRyX5a+RlXb1mWGd4Z1HM5VOrBBIYUvlNfDmgy6MK0XDUvd6JdXvEtUuIEpVA1+O0Ci2UZ7NKPVjq3Pv0kgXhCT0Q4Mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=d66njHCG; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6133NoIm047314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Feb 2026 12:23:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=r8R9mdHzi1BanaqnL4M8yh0UPiyKYCb+NNWJzWjF+Sw=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770089031; v=1;
        b=d66njHCGVShvbGRQ+ySH/5sqN0sBG/oUj2nU5hUCNmMhxM1IWjZJEZsQl1PGHdAr
         XFTvXL7d/+sjRHIgqLH4NqE/oS9lxoqeKj/Pm6Q4QFdFbiu82tQ25vYsnf+Yd17R
         p6SGkOPXlUYFcPUxO8OyHynb//4vMgAvVLNZvv43O68lfMR+CcoiHpQJMEBX39Lr
         Vif60gGuZxinMi5PvrhjGeZeEp1A96PS5t/i0PPdqB5+kmDS3RZcWv1MLCOjqRHQ
         8gRqx65KyZ/qXxRa6hcl96OqdcYzTRnhgo8Nrf/0aWeW1jSH/BbTHOE0iM+l5Abz
         n8xTh37bqSowjEV0XoN2YA==
From: Kohei Enju <kohei@enjuk.jp>
To: jacob.e.keller@intel.com
Cc: aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
        andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
Date: Tue,  3 Feb 2026 03:23:35 +0000
Message-ID: <20260203032350.3221-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bcefc3ee-4704-483a-8271-01677e47eb8b@intel.com>
References: <bcefc3ee-4704-483a-8271-01677e47eb8b@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256105-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:mid,enjuk.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89CC9D41A1
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 16:31:39 -0800, Jacob Keller wrote:

> > I see the Fixes: commit exists in only tnguy/next-queue.git, so I'm
> > sending this patch to iwl-next, not iwl-net.
> > 
> > Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
> > the commit hash will be stale soon, and I don't know how to handle this.
> > 
> 
> Yea. Including the full subject line should be sufficient for Tony to 
> find this.

I see :)

> 
> > I'd appreciate it if iwl-folks know the way to handle it. Thanks!
> 
> Ideally we can squash this in with the implementation patches and 
> include your Co-developed-by and Signed-off-by tags if you would agree 
> to that?

That sounds good, and I agree to do so.
If I need to take some actions, please let me know.

