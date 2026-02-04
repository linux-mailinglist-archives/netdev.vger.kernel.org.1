Return-Path: <netdev+bounces-256700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJR0BOZEg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:08:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5EFE6322
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70F97300E269
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B53D7D87;
	Wed,  4 Feb 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="ucRnCnyE"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67F2D8375
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210409; cv=none; b=F6W9Zarf6RtnthNlmDpA61iJW0MCtawU4fF3AemyqtKO0Z2yMMspppkw5Qnwtog8J08vuYyCFneUazqwfM7bqR5kRHEaR76kBWwlHCv12bV/rs7LMnsxe1Xv5CJ4KCZoWj7tZU/vOgLtsiG9QoxmT7YTgSamFtCj65MDBLtDKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210409; c=relaxed/simple;
	bh=44I7wce6c1wgoTtpsjHIb470HBrnHkyP9sRP9i0xxbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0mC/QrMzAf5tlsNzRfD7iMcikibGrwmeVG0g8qWkvziAZKLj696V/1xVCmFLyBRvI8EE6iUwKHN81DSasycMmLH8WJJ4RzGufrnwHp5Yt3yY+itOgogzqCIv+glzO79C4XPdeHWT20CsTKEmpJ26Jz3vlCk4xqcSyuwwYfhXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=ucRnCnyE; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 614D6exD077301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Feb 2026 22:06:40 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=VdXwBKcrE9BrvSzYjCxLIeWWc0bH8ZFH76JP/NHx/1g=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770210401; v=1;
        b=ucRnCnyEEfDxN0RHzFIGClBjpdvjSfNjKnK/LC24pVLFJKxGYZ0xdHfmjYBav7s+
         F9AMB4KKM3QaCuKlxQWrci4cFDPF/6dcxRA1m5x16rM3b6TJB2Z/zOFXeMZ8I/A8
         Gt1NKknr8E6PcDB75qYtK8qoaRV3U27lnm+vW0XNRLqiYCMnxt8BpB2X6siXmfgb
         f4EKjNJJHEol6q+094RrCLGdX4UTkTRS6rZZkBTR9kBsHExYPY8XEkDLAs7CiXvg
         4vUgBlEPJ2Ub+vhBQTIVAphx7yfyXYHHep+2wjxVdOZjaZBjPy98miO2/LkEMiEb
         VHXhr7TBjrGOGHis4xa54Q==
From: Kohei Enju <kohei@enjuk.jp>
To: aleksander.lobakin@intel.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
        anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
Date: Wed,  4 Feb 2026 13:06:40 +0000
Message-ID: <20260204130640.3597-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cfa11f8e-7207-4bea-843c-d111038c63c0@intel.com>
References: <cfa11f8e-7207-4bea-843c-d111038c63c0@intel.com>
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
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256700-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7C5EFE6322
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 12:52:19 +0100, Alexander Lobakin wrote:

> > Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
> > the commit hash will be stale soon, and I don't know how to handle this.
> > 
> > I'd appreciate it if iwl-folks know the way to handle it. Thanks!
> I either way need to respin the series once the window opens, I'll take
> your fix into the series with the appropriate credits. Thanks!
> 
> Olek

Hi Olek, acknowledged.
Thank you for taking a look!

Kohei

