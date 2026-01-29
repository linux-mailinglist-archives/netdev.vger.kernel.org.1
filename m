Return-Path: <netdev+bounces-254867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFCNIIaWe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:19:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB0B2C16
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72733302C90A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69A3382CA;
	Thu, 29 Jan 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnlGX8z7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A948304BDA
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707041; cv=none; b=CSOwVDhrKvI0W3L2SwTiBDrvS6+Qky8p7ecz8ai7mHtggt0TbjT67Lj2ieDW6ABQFEXP/ZOrHOLVW2gFRwDuMFjuybBnq49TlP9qMb6juuXWzzkbAP5OioekzmJL7utnrLjmtLvgwTJPOZPEEesJdDCWOfaKHdv9MVYe8LIf4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707041; c=relaxed/simple;
	bh=ZsEGzLjdbDVM4FWUs5Kqag0d2mXtAN4mUc8ahPmKLWA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=N8pRcnDjFzPoYwpbM/b5eK2BtUSKthh+P2fZzJK20aYww3AGwy7l77NNtt5EHENzkaRbZoAbSwGXvGdi+Fl6+AVKPa5x9ipHNhKCKrV9EvDFPtEmFUWPLMMdqNCrIemWXAVoHqqdEhUMZW1xSjQ1OF4bBH2Fg2/pMIT4jSr0d84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnlGX8z7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-794915fa6eeso12396967b3.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769707039; x=1770311839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6HQv96L/OmgPy5YAt71t2IgfEvjAD3Iexzh66ZQuW4=;
        b=TnlGX8z7uaCAzfRjQAp9unkn9d47nULfG1GNVnLiQh9YPNB7FkT0tiU3QD4Nrt27IN
         IKt1Yep6bxyxg5BaHEvZ88JAHLAIfBlhdl1hOpwGBH+FW64yjY5HrNtLlYUsegkueEUo
         w+X6LBDmu5pXysAG+kmxPFUjE2SrHIs0zcT9E9ID6NsAs/WZCpTSt5KaBDQScKOzOwAk
         DMjswov1NH/TgvNlKnnJzvO7j9Z8uOrLb5H2xVCyMGUJ8PHGzbi5veG/dYPqMlgRAWur
         +zcDTB+iuEdECMMPqeTzC/GbPWFGOw8qXrTBZHnKdyLtpFOp/xGKW7mEW2F0gJptLsvq
         TlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707039; x=1770311839;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6HQv96L/OmgPy5YAt71t2IgfEvjAD3Iexzh66ZQuW4=;
        b=cnDhkReZ1xm3B174iIUI3MxRuJi7fFnLsLrWi//AZM1po65ahBGu6y4ZUjSh4WwS7I
         ks+OdfRMKjKhME3gBOZmK2d+BFpD0h07hs5BNw9UlJPlp9sRGDfEVDGVxSpCW53zu6Up
         Wi1Ggl8XZm7ZLGatL4X4YImPyF+2OTaz59n/ZtG5CGSh7KJp1UAtYBX0jmBWb+To+0hl
         UhN/mJg9U/Z4ZygrAPyNs3PjPAqpE2u2O+8Cbk/nmI0j9HQkNmxYDOx89tO/uzeXB7mh
         lrXr+I/L7KEJ2k+rRPtODB49B3nGxGFgeyKZM+CTiRGdyD2hRC9sd+mXJ3M7KTfqFzdA
         QkNA==
X-Forwarded-Encrypted: i=1; AJvYcCU82bgEM/seBRIA3bQBzg0KUkPBlA0M/kurJv++YSFZ8SH/cLp5b37HEHj7M4Ok75mkC2+J8G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnV1NVTee0DdAHkWzXbv+Z5IMayxN1gkPbLBPEa8Dt/uGxhjT
	1UV+qPLmrSJKxzQk6GV5lZKRyf2pSu5sgDdvxNpLZDr10qPtgUtSznm9
X-Gm-Gg: AZuq6aKewLGFue8NM7i0x5z2qXX8qwwLyRO3UuNQtNNZ4Oi8eSkFlI7NhlTNu+6Seo4
	nO5OSWe6n0ti4ngLwPgrQETSKxiqE/gvvzzqfZVCfMG7Y4DaE+insH6Vwk+99PUxw8Ots5gysfT
	UpkG9FZPcZXIP9VXmQFOCpJmNIo1FUjkmN2CZ5V2cqtjJxkpUzPR6D9c10E/t+iqzte76LmG+2h
	2IBViPeKT6dFRwJ3fFg41YojDHb+wmsyqmASu5OR89i4RZSVX69qKPyuW/xX/PXscNF1hHdC0uv
	0lFq+pi0d86RcKnGSYs+uPezsDVUfpRXQKUv63vjCRASJA0sA78Is9J3fFsq21JVTGYMZbzPTWq
	3ZKr1cA0FHuOwVgrwm4t0MziBhK9duy99LxSQrN6W3BKUfRzCw01PbtXca+wkWI4/sT7H8zwt+8
	GZZRhUtJ2qbEVdHJXnkqTC+mUbxnEpInMPVrBx8DbBv6M7tG2FFYh2Pnk3r8VJBV88YOlgSw==
X-Received: by 2002:a05:690c:dc8:b0:789:3166:25a7 with SMTP id 00721157ae682-7949e04c6b0mr5054917b3.46.1769707039341;
        Thu, 29 Jan 2026 09:17:19 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794828f75f9sm26817347b3.53.2026.01.29.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:17:18 -0800 (PST)
Date: Thu, 29 Jan 2026 12:17:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org (open list), 
 kshitiz.bartariya@zohomail.in, 
 Mahdi Faramarzpour <mahdifrmx@gmail.com>
Message-ID: <willemdebruijn.kernel.1622279a11643@gmail.com>
In-Reply-To: <20260129083806.204752-1-mahdifrmx@gmail.com>
References: <20260129083806.204752-1-mahdifrmx@gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254867-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,zohomail.in];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08BB0B2C16
X-Rspamd-Action: no action

Mahdi Faramarzpour wrote:
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues"). note that SNMP
> counters are incremented currently by the caller for skb. And
> that these skbs on the intermediate queue cannot be counted
> there so need similar logic in their error path.
> 
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

