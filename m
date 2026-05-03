Return-Path: <netdev+bounces-283579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK2yDykN92lmbgIAu9opvQ
	(envelope-from <netdev+bounces-283579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D94B4FBD
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DCA93001CC0
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8D39B482;
	Sun,  3 May 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUGLidhi"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BE175A7B
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798436; cv=none; b=OusHLByZPE88yD/1+rvvlNSTnbRe2KRPrd2vJhjWPxORQxqptmyhyqUlwJNcdsTSsvWvT3jM+fpDs4PdTB0MldkVwwCD6dHzxviVtjkfHCjOxOXB/mEO9AsTOg1ITignIOV61QwA0dSzKUcpexHM1Xh91dImm3BFJZIP8mwe1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798436; c=relaxed/simple;
	bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	h=From:To:Cc:Subject:In-reply-to:Date:Message-ID:MIME-Version:
	 Content-Type; b=No8wg5EOk9ldjNJMNKdKu1r8Ary98BGjb5Uigcr411y6ceMpVlkHDLQrlnWnchVeVaJcz76Po3aC4mzNLiLlKcc+BtaAyOdkYhvtcyYm8NsK52HEVObGaqHumvZwEMrDklZ5vRXKzkMEk/klL0udlLyWzXwrNSb+M9TDPHGO+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUGLidhi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777798431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	b=ZUGLidhijoJB69R8DH0HYnyFbQWMYPdpUXmJdWD8thkB428vt6ZEtg4soJzSO1TPW88Xnf
	+jh8HcHm5PpCQ8UcJbnLttsJ8ZJxwOF5/3Q9uQBL0+YvvSohIgASq88VS9uBYEplJiHKEG
	AXACJv1FNkjqqklcFerPYCHhpVYEI20=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn,
 wangjiexun2025@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions
 during teardown
In-reply-to: <14078459.uLZWGnKmhe@sven-desktop>
Date: Sun, 03 May 2026 08:53:29 +0000
Message-ID: <7ia41pfslvqu.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1A9D94B4FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283579-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,castle.c.googlers.com:mid]


Sashiko's author here:
Embargo as a feature was requested by Jakub to prevent people from
posting 10 versions of patch per day. Currently all netdev patches are
embargoed for 24h.

Re writing feedback for reviews: sashiko support sending reviews over
the email. It's an opt-in on per-mailing list basis.

Some details here:
https://github.com/sashiko-dev/sashiko/blob/main/MAINTAINERS_GUIDE.md

Thanks

