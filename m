Return-Path: <netdev+bounces-281243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sISAJ4wN72kq4wAAu9opvQ
	(envelope-from <netdev+bounces-281243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:17:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C228546E394
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 959673001A4F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81141359A6B;
	Mon, 27 Apr 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="iTz1C/Wp"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EED34DCE0
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274247; cv=none; b=QETlvIoy5XLv+ZRlHFuCF51fzU3g5h8pKwqesQQwABlzOHBKMTN3Fg55kY86ZIal5yHWFFt+J2g85h/fDHIWF3h8HaZFexCMbB952rekaLduSt0xhplLFL3Vysd6N4ivA8YlwX2NE+oJ3Y2h2+9UPQUOB/XrcY5JktPyn0xDWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274247; c=relaxed/simple;
	bh=fGeZOnmmGwuz5zFzxO9EO1GTsffOF/l3CdqV29Nh/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puWPjfFT9mw3SExv1720+CEsEHXl+dL922Tib2vNH2wVt2KZ+crhWlWuFf2RhIxTP8lzvKMb0FSTgjApE3aU5eLxyPv6/N/4a4jsYpoG8SgtNsDIAfYqzRmvQzStPBNtOc3dMBk1Ld4O2iGwGrbtzE2lBRpdhcSWBgaRFv1U2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=iTz1C/Wp; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 027501FD5A;
	Mon, 27 Apr 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777274237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sD5b+k6/URUavnovOXdTKO2GszejptHQbyYMDz+Yyg=;
	b=iTz1C/Wpme1tB03wTfKST6w1JN1WbvCvcIu3mkLVG/dPwQkeARhepI6vdn9zjLALxo9Uld
	yIAEC682MUyFt5rCBU4mgRKtqgm1w0gngEtUTE+AtT665a5tsM8n38eCuSo9zpYtNXAQji
	vVbI575VKik1sDalNNo4UdGx5cPbtZs=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Ren Wei <n05ec@lzu.edu.cn>
Cc: Sven Eckelmann <sven@narfation.org>,
	marek.lindner@mailbox.org,
	antonio@mandelbit.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	tr0jan@lzu.edu.cn,
	wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions during teardown
Date: Mon, 27 Apr 2026 09:16:44 +0200
Message-ID: <177727301354.13864.1397859878214766047.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
References: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C228546E394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-281243-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[narfation.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[narfation.org,mailbox.org,mandelbit.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,open-mesh.org:url]


On Mon, 27 Apr 2026 14:43:33 +0800, Ren Wei wrote:
> Prevent tp_meter from starting new sender or receiver sessions after
> mesh_state has left BATADV_MESH_ACTIVE.

Applied, thanks!

[1/2] batman-adv: reject new tp_meter sessions during teardown
      commit: https://git.open-mesh.org/linux-merge.git/commit/?h=base/net&id=f68c93519b3e59a8039bdab9f930681a8e64f97e
[2/2] batman-adv: stop tp_meter sessions during mesh teardown
      commit: https://git.open-mesh.org/linux-merge.git/commit/?h=base/net&id=bff1888c2c5d7453c40940fdbe3215746817f7d9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

