Return-Path: <netdev+bounces-305133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6FeEh3wS2pVdQEAu9opvQ
	(envelope-from <netdev+bounces-305133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A739C714585
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iuxSjCnJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305133-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305133-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8529C30558A1
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F039A4A7;
	Mon,  6 Jul 2026 16:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111725B0A2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353937; cv=none; b=JvMQ8N+dKzUlyGhvL1BJemk4SZGsqdCXzhC0JZfPwS7/D6DB5+k6RMj/KwAHYWOon0AD7/vLBFi9lqG5d2lIakbJd/BYPUpZHrSzxRx4xYiR0606R9KInzw1yYSXiz9LFONkIqYFQn/tz4MPcjeOLlTuEk8dvkQX+oNrpHy42To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353937; c=relaxed/simple;
	bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNfu+FAT3P0shYqizgNTh/T3XR3PfwIMrszXMg+bTQ5zlFJELUp8kiIYfkmnlmsTzs4iBYwuaaDjW7okOHSgMh+6mzF8GWEzTh7bUEYEdL1An2uHyzYGBekNBoB+A0zvWcWPj9csV8yGOOzzIninhxuQYmy9jwyO6OHDPX2zeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuxSjCnJ; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1290747a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783353935; x=1783958735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
        b=iuxSjCnJM6LBXRrOwGJ4Oo0T0hQIp3E/E7fCXqi3taSxdyzARmaOLRUkuXQnHNaSQf
         cSnDcSapbeV/hSyQ6wUOFMg0oiWGVSckhoz3g/Kh8IEOgeL8LBvSA7OpE0P7SunIaukd
         kpvsqkVV9J7X7eAddLFXUsq33eGIQqtOC7B9yxdgroYpWjd1kA8RdlshuUMxdLUV8TeU
         AWeOj0nD3BcrgKWbNEi6VC47sOa040ZRh7raYkVbZbkwTqtU3/z38P5b8qYmay4dJCXL
         9rlfeZpcAOehe+2ygh7+waK+LigLmbpCmxlj7wX1KdU3ORLkBDSWUtKrN1HI9fHuIa/3
         5yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353935; x=1783958735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
        b=GQdiwx2DeggeY5wUcgZpYSn7yS29cUI3rVPOxF52oaNp35LgXauMQ0FkQMxpckZGwx
         b4d9TZF/DdyyyW7ETxM77cJ00QL2LNdTgfwtB7gdn/+pxa6pmTcdD3ReOB90hnZ2lswK
         dVqkxwSmyOdD5fPt0yj+FU9OGA8z+4JCCut4ycggsGFFAxHFF3H0s7EBDMxsN492Eykf
         l82yK+UhR5/EcS/oN2IRX74BSMF6E9as4n4FxP1A8NyDNISJKsNL0MG8nHUQh7MxhwmC
         hcH+xT/AQZHKamvei1rSqitKGfCoxYSWoS+YpW3HNHsj4ptmFHsUdU9nBKtkwvrW9GRc
         Yaow==
X-Gm-Message-State: AOJu0Yy30hzqHrKI22geOGBqzIqSLlmXlpjGGiJqum+3co1t0ApuMrI3
	fQTZVKeL+eMF/ZYlhf0/W1oXy7dG/vVQUoq+A2qyzqDM0qTEIVD7ZXHy2I3bfCHq+/NZ5Q==
X-Gm-Gg: AfdE7ckXU6eJHm8OfBjCEz5rRBl1zD6vRlWH1C7VZv9/AOu5qxIxVD9uvxQThZZZHRu
	e0tLVimWfK6QAqXQznTYj4hegJnIglzx57+jK3xWZWS/slao/3EB3yOMRXTy6U0C+AVvCfxLGbO
	/GDFx5pg/YgjbzDXW9e0gxE41EzNzlMi7yAMhdUSExek37AQ7bxghGAhhILzWbhFaNDfz+sqqp9
	rGXvwrEaD1g+mnwz9Qh2qZUK6VuhTSoVh3UXB25qlLf8B92YMw1XVID0uZsCx5lLRA2AZWdF8Hh
	fqkwMKB8v3VK9FNHwN6osXSAXQywq+QUhplBux9/QMCo8jwrEau7V0eWZPJ1HFvcl0fBqvacDqW
	tqadFB4VI84vkBfomsiz5z/X7v/tOIZP1EAgIIA9xo7cypQv4HDWGVD2TzvkjkWNKLqstM+sr5t
	gbUxCDCe96ePccF5mAX1UFLwY=
X-Received: by 2002:a17:90b:3d87:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38757a838aemr1134432a91.27.1783353933738;
        Mon, 06 Jul 2026 09:05:33 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:1840:f07b:ed1c:fca2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813c4dsm51596676eec.7.2026.07.06.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:05:33 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: netdev@vger.kernel.org,
	lorenzo@kernel.org
Cc: aniket.negi@airoha.com
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be lossless
Date: Mon,  6 Jul 2026 21:35:27 +0530
Message-ID: <20260706160528.38665-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706154730.36949-1-aniket.negi03@gmail.com>
References: <20260706154730.36949-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:aniket.negi@airoha.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305133-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A739C714585

Hi Lorenzo,

I noticed I forgot to include the link to V3 in the v4 changelog.
V3 can be found at:
https://lore.kernel.org/20260702171814.11165-1-aniket.negi03@gmail.com/

Sorry for the oversight.

Regards,
Aniket

