Return-Path: <netdev+bounces-257883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCURBpxIiWm25gQAu9opvQ
	(envelope-from <netdev+bounces-257883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:38:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986A710B316
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99BEF3009027
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2D2D3ECF;
	Mon,  9 Feb 2026 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbXKQFTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEA2367B5
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604589; cv=none; b=I7lQ1WkpzJrVNbVEm3bJHcyDzF4eJjlaWWblNomW7CEu1rwCrM3phY3wIcX1/3YBhEfWlZyy4ldQQtRxvsk9FxUWN7iKu/tpyvSLGzTO4iK4iE9cMHYeKFD+pyV3kdWh1pusesmliX+REQl+3r24liufN11Wo3j83yFnQJOimw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604589; c=relaxed/simple;
	bh=kGH6l0rNT5LVm8Xr4TLlUWZvLKhE7Jw26DtjfMd1vVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QxJKYrdUYICmoqtuYNLe9rOm11MHZqRZErBuTbP/LV43PmvZ1SBfszhYHYFULd3zcXNcTvHgn9fblGqDJDspbevElUrOV1VX5VtxZmSRvcbPCLBuju8+bFAEQN1LH6vBxoPlPDlQvLNKwLTTt2L718h/fHFrYffvefrvwW+EioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbXKQFTL; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad62a294bso1499921d50.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 18:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770604588; x=1771209388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9stMa7KwLvBDX2P3Y2Txs0J3hJrlNNbY1m8SALZZMjs=;
        b=DbXKQFTLFJr4PWf28aKl7h+h5fwchvdweLw4KwWrshBTjeRxPo/lC6uuSsCsUQnQ73
         9BfAmALhKz1xCRrMbFNoQi0goUxxBpil9CIKCaCABY8lPnxSPlmLJNOTUJgsJ7hdIM17
         x93EWf2wNPvyHo0rG3cPVJ21UlZQnhMQFuxgTR/H2PtFotpuIBPBp8VITxhS3q+xyO4B
         C4YLAoZAckWDzjsX7qDVQZK6xqtupprIFP/1miGgWpRLu7fmFORta0KCxoGKEvxs/SUZ
         aPOe7KbXEsq9qLby5a+J2UHWG7zqBh0uzaQZdyttqFA6ezYIMUdOOqJdWPvSig/qG45L
         pRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770604588; x=1771209388;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9stMa7KwLvBDX2P3Y2Txs0J3hJrlNNbY1m8SALZZMjs=;
        b=YaRilxSura7IRy6VWSVo0Z6ATXkZQMOP4gadcHpYvcRiNXho79gAppaBto2jTlwh0M
         Uh4C2L3vs+lr9lH5keoo+xpgr910NebCiv70w0LXR2a5h1kNQVGymxYf2pTmZzBait0J
         6f2u+dfCac9PuTgesRcTeBiRzgx970WWYtRXwPfwGwmc4pUg2/9g37RedG/6A1H9g4CN
         AzUqGDf6hci/bslPPzJrGNqpYPFJ574ikt6XIr5hNTit2K6vd3Pa6nUpwkhX7MFlXsq/
         +UhZ4AgyDomQyNEnR1ehRsvXo1lgwopxVc5X+GjLuXI7BoqjXnRXKJvcxfgj6rOKNobd
         RzHA==
X-Gm-Message-State: AOJu0Yyu0sDA6bKeg8Hc+LKKadln2Bk0EQ3fx9xMRY0SJR5dOzOf5Sz2
	osQyp9Qts8/HaZD++lIqy1aQfb/EAfCBDMiQtmmOG4ySCnfQ8yzZZR5X
X-Gm-Gg: AZuq6aL2WBeDnTY4buO0QIrbXCFglUdIHXk8roS8rT+eoMGQut9dI4/ATOB70sJuYOD
	ydhBNZOFJ8ze7CVNCUtLzBYPOdd+gQUXh9CDuOGQd3EVlEPWk5eUdo2vvZM6ObfBR2gp9manQhg
	PVUAuBQJF7zgUXmy5t0+4k7Pmbv4ip6ESL+DjLEncSExHZzNE4rMJJ8uuAzIq0BRsXNRCaiqxyI
	qU0a7GY0g/Rjpp9YBF9F3iVlXfOzgnI17Qahhz8zvpjVZhJlUVzXtJViV0r+Av4tW3gIfsXSPb3
	7G8WPHpMVWm2PLg5+ACXzbpN7Q79WAMDWvX9O7JMxkM9nGLCcUhVIDGmsCEbqfjXmXcionxlTld
	T/PvwrOLDfhaSyC7LRMdt7tAMV1LkLfq3XyARtob3UDtsRSgqY+sIxUUvvGUvyADJxteeM87r7N
	hfMznq8kkqXvGZf7LlBmOKly+cicYu3k2v8VWT/aOXgVdPVcBd7vxzq0ozOdk=
X-Received: by 2002:a05:690e:2450:b0:63f:add1:e6da with SMTP id 956f58d0204a3-649f1f594b3mr6505572d50.57.1770604587805;
        Sun, 08 Feb 2026 18:36:27 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64ad8a12432sm5352745d50.21.2026.02.08.18.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:36:27 -0800 (PST)
Date: Sun, 08 Feb 2026 21:36:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2cac56bd3c52f@gmail.com>
In-Reply-To: <20260207003509.3927744-5-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 4/9] selftests: net: move gro to lib for HW vs
 SW reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257883-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 986A710B316
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> The gro.c packet sender is used for SW testing but bulk of incoming
> new tests will be HW-specific. So it's better to put them under
> drivers/net/hw/, to avoid tip-toeing around netdevsim. Move gro.c
> to lib so we can reuse it.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

