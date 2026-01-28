Return-Path: <netdev+bounces-254138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H+ihINS6eWnoygEAu9opvQ
	(envelope-from <netdev+bounces-254138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:29:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C55109DBF1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 687D83009F88
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537828488D;
	Wed, 28 Jan 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Ao6pv7wi"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA5275AE3
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769585361; cv=none; b=JW1PfORK+I0VO8zVH/HiqJDsA1kTBbwTKQUr5iaeqJztdHJCY7+/AArvdB00MvTYK8UehTa0SO4A3zdKboP2gzHC5ZNTZrYIQWz7bJM4moKuXmkVj77/qqOGD4QmNI9t6IQ5lAuQzkprL5cjTR8ee1+JHop8xkdaiJZyhjOgPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769585361; c=relaxed/simple;
	bh=/YP16ZIBLlWTdBCu4v4eL30PGE/+SQKQBVeI8U7OPm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7CsC/WbNcN+ZrjwnQe44ayClopC3Zvt3QE4LM5utARupmbesDNmOnebeb/zjYi8rh2/UGMMPrN8CS60QCRj57woyaFO3xfnrIsz3E28IYdip9Tp1jvjRe6unt5uXuwLdfUcqFUSm/KFp/DIcXNIizFF1cL/Fka8mutOIbOFYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Ao6pv7wi; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (85.154.13.160.dy.iij4u.or.jp [160.13.154.85])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60S7TDIC049913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 16:29:14 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=cPiwWLDvghmCGt9oewTVK5ZkSP/BPQjzSlyP0s5Xx/0=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769585355; v=1;
        b=Ao6pv7wipYUxJGx2OOpfIlSMY6dOYa2Mna0t4f39SGgg7HJ5ip+6Xbxl5i0NIIxV
         v/3iGuW3XEC0GIwalC9Ng9BKaKRbPcpK4acRKah4OLAvtP9v/6tSy/dHLPxykUKu
         S2p00kY5ZG5wGsF+3zgIyikIiJkB7q6eVLX6Qcn131L4le6jq/knG2j2tHYSgI78
         xUVdzgMkYxeaDNdBcbw/bSCcxRgQliXfqx52l6WGaspMnSnTaRojD7CGM/3PeUHO
         7forZjVeBhBinQEv1c5YK2pTlf9EiXgX/VowSc/FRtnyXlyn+mWOKK5o0NzlR+UO
         Qe/s2uVs6qDxdQ8LggW7WQ==
From: Kohei Enju <kohei@enjuk.jp>
To: takkozu@amazon.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
        anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
        enjuk@amazon.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, piotr.kwapulinski@intel.com,
        pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: Re: [PATCH iwl-next v5 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Wed, 28 Jan 2026 07:27:36 +0000
Message-ID: <20260128072908.50245-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127085410.79645-8-takkozu@amazon.com>
References: <20260127085410.79645-8-takkozu@amazon.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-254138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rss_api.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid,toeplitz.py:url]
X-Rspamd-Queue-Id: C55109DBF1
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 17:54:10 +0900, Takashi Kozu wrote:

> Change igc_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>

Tested with Intel Corporation I350 Gigabit Network Connection and
confirmed that toeplitz.py and test_rxfh_nl_set_key in rss_api.py
succeeded.

 # tools/testing/selftests/drivers/net/hw/toeplitz.py | grep -E "^# Totals"
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

 # tools/testing/selftests/drivers/net/hw/rss_api.py | grep test_rxfh_nl_set_key
 ok 6 rss_api.test_rxfh_nl_set_key

Also checked that RSS hash key remains through admin down & up.
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 # ethtool -x $DEV | grep key -A 1
 RSS hash key:
 be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 # ip link set dev $DEV down && ip link set dev $DEV up
 # ethtool -x $DEV | grep key -A 1
 RSS hash key:
 be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef

Tested-by: Kohei Enju <kohei@enjuk.jp>

Note: 
Toeplitz test needs correct handling of setting skb->hash and its rss
type, so I applied the patch below in advance.

https://lore.kernel.org/intel-wired-lan/20260122134809.7765-1-kohei@enjuk.jp/

