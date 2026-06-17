Return-Path: <netdev+bounces-300000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZk3K2n9MWrYtQUAu9opvQ
	(envelope-from <netdev+bounces-300000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C74696011
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:50:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IiKJ5mST;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300000-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300000-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18AC53003815
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635B2EA498;
	Wed, 17 Jun 2026 01:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCB2E738F
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661017; cv=none; b=I6a7DtNKDOoJf6de6chUeOCL2+F76CApQ/RpWsIRyt3Na+419COzxJ3N3f3Sq2SRFfbDmoa3QPfI7rDq10fmmrifOnR3NFwlaNcseXlSIHbG7OgS0WBafrz1ouTeNWs3mK/AfrtDDsDHKdhWSigC2I+JZIOZZG0cxvIPT+7F3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661017; c=relaxed/simple;
	bh=Ob756nkZ0JvHZi9Z046yzZgecDgZuf7ZPZlE9vU2tRk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=hxCQ1CCWWjbjzfnDoG9MSQCt3TXFVsVL1VEDpdcN19HffIb0AW6eNsXBbuDGtv2voSTunEtQcXUzG/VTR8tMylp1RkgZ/FeqioyrZX3pFrLxlSy+XmWG5nncwJbO1Y8MM2rLjLymixScDVqWQkF+SyslnZ3zkbQeBqCIGZnJ9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiKJ5mST; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so365579a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781661016; x=1782265816; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob756nkZ0JvHZi9Z046yzZgecDgZuf7ZPZlE9vU2tRk=;
        b=IiKJ5mSTuzmK8cjUqB8u1UXuLSdRrbITBHG8kFqmSA2YhMQ35IfUyU2WUTkdVPg3sy
         0NntTSCpKrVmlxHMzp3Q78JpavTCPgxkvPt1RBBQT/EjkyshXAsJ4iLAvT1i1weVJD1/
         H9Q6+Y/8mtVpW5QP26s1RVmkVK4IBBSKUtwVztIcGw1v4ILO2Mp+VdrHYsFJddEqaR9o
         5GravxQHnggX+IeZVyXfL0O3aabPGhKsaYc4eN/ZXE/uTV8vssT+TGcs22A2fB5trkvE
         8CxYMDfBN2l54I+vxmQ5Qj/umNPqYomgstKxxJ7KOk5iGzlXU4T5FrsLQD+JSU8zkJu+
         +pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661016; x=1782265816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ob756nkZ0JvHZi9Z046yzZgecDgZuf7ZPZlE9vU2tRk=;
        b=iEWecMl4eLIUDDaQctMV3MNgiAW26uchayXiz0cBpcKZ+ASwFujXxonOTGxvEseutU
         2fUR+mfRJHSQW0lCmKqHrVhASnXZWpySNGnD8j6uREtmsJ2IcRR+048GBlnZUaLLSCjW
         Y+fLFZ989eSF9yB3E++XbTayg8fiup3+Nc+AaivZKOv68xXin/lJ60yEPEpJAtGlF6qt
         t8T/1mySiGiFFiSAc1SeozK6ZuHO6dB6AeOh4NqQcj4Z3nDZFTM/SxNIRBhkhTslPcHz
         lOrinRtgnr5NOFXE10W52yVUq1hvAeW4fyegnl7Tt9AKgCaYewfsrVgnCeKYt7P4cNnz
         LHUg==
X-Gm-Message-State: AOJu0YyqXb87w2goKNtH4asRqNAG3aQqxqf3wxFgxL3U9hruisl6KLUX
	+pJfTH6RlWvEhyRFNj5qluIYY9nvLCNeag91iTGz6caAwMT6N8LlxnWBYLRlVbvL5nI=
X-Gm-Gg: AfdE7cnXYAZnbvInDBG8s1qbSGJw8G5w1hOt1lL1GdwwryhGui1IteB+XrlbnTL9gSQ
	+yTFjgBWn+6gk65FsUbzokHgby1KQMFoopile0dCvvV4T3M6Gn0auq/NjJGRoO41NYKzIIJxYA7
	YUtvWL4OCRj6g+QYiKCk2xvNUlDrF1Z7a8fyyVAC7BMg+SjhvUF45tVb4mLWOHzm7C4Xz6JKfp9
	qOTG89RkO47pXalMlCISMJusQTyiKtVcn4fSmnZ+l7uRZcU1rtyjFMr5Hgd7xaj1hN9Uq2KOMZU
	cjoziLJK3sTehQo70FwGMv3DXaWcgFswuD+TDGLLkn2hi2BBvrQbiXYVcIeliYEmFWgZRWajs/N
	4SilzbHv8R4zuAebb7xUsG2EkQnND5Uzh8l778XpHQcIJQ1NW+NpjCMkd/vNj43nf05HulVn3ZH
	YBWaIaog==
X-Received: by 2002:a17:90b:3ecd:b0:36a:8254:8eb1 with SMTP id 98e67ed59e1d1-37ca6a6c890mr712381a91.6.1781661015649;
        Tue, 16 Jun 2026 18:50:15 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ca1dbc8c9sm434740a91.2.2026.06.16.18.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 18:50:15 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Wayen Yan <win847@gmail.com>
To: lorenzo@kernel.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2] [net] net: airoha: Clean up RX queues in airoha_dev_stop
Date: Wed, 17 Jun 2026 09:50:09 +0800
Message-ID: <178166100984.2204581.7770239909241189310@ai-server>
In-Reply-To: <178161160256.2165161.14322392784449633554@gmail.com>
References: <178161160256.2165161.14322392784449633554@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300000-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ai-server:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5C74696011

Understood, thanks. Makes sense - RX queues don't need cleanup
on device stop since they'll be re-populated on open. Looking
forward to your TX cleanup patch as well. I'll drop this one.

Regards,
Wayen

