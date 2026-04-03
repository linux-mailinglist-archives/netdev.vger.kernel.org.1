Return-Path: <netdev+bounces-275104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBKnH4Xaz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D15395B66
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C257230210F0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233F313535;
	Fri,  3 Apr 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoKnDj51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32B3D76
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229517; cv=none; b=i+QON0coG3HKgYdBHxnKZRyNOiGa2OC0WQP7gUn5c9BZPGjXuUOKbO+h90j8onsdIrbfpP/f8gPGgvgpiQWjCMxBP8AEl9RM3K9MQaDRYEUQuppkFnKm/qsd94NR3KQ6JFrGiaVTscgVxVMNooyPSWbU1HUsbK7az4tdOfou3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229517; c=relaxed/simple;
	bh=X62u++GbKjKs6HX3LchQE4r05yJOf8Cci0iZtDrxreE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CuZ0aW5A0hYlGYcjiOdcRurrWpalRu8YXxL1QmCIdJTar7YRoXCF/VwirXhDfrHygJXEe2E+ZrCZ7dhfQ2IRGzDcJCkONTLiN38PBVcFs+7SKiY5Qzg9LsWAEAjMVLZU9QIYPo6Ma+aRY3aSt71Sj9olZyL9NyipwCqiVacqB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoKnDj51; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ab5fd969aso20673547b3.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775229516; x=1775834316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEzOBamhUqvu1O1wLQNrqniJtzY/fr1ykFSE5CqsypY=;
        b=aoKnDj51e3EGRPCPJxYJIQG2/xYrNgwQh6jcRzGjk07k1JLI5wPzthjMSjaVfLJ39N
         9HiboBngKPnmZsBd++x9nbFhEGAMBXuetBvLHs2uNN7iWqG1lQo91D9lOE3FqrFO6wgk
         LGDwmKfE45Vuj8KYR/hDcQLqhEfMl9c0Lkwbl2QlBnWJvB9iJi46yxS6scMaPj9cIPG6
         SrjvSxh8GjtEKft3Sj198bGUlj4pKJpZL4WB9Dt8vk1BedDt138cGuFVfXHtDw6LZ8JT
         W/LvNwNBikHRjWZUmmKxETXG7p07jFj1/6Npdgif7mXtB3O+yNm3wG9fDXmZK6/+TQ5q
         ualw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229516; x=1775834316;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEzOBamhUqvu1O1wLQNrqniJtzY/fr1ykFSE5CqsypY=;
        b=eSqqf4Yn4Lf1Zo1uHsld4etevu2IqMTcVMsLTMdU810wnfvfhjbtp2P7DrsNedFVOs
         aaijozP3Qhs7htKppVvQhO8PGJZ+QtmTQP22w3+4b3bRC0iYzxvUmD9FftyWwfN0wKcs
         L233K/61+J/14YsgXcuaw9vqyMFsSAbTLtGsZHlkBIAlB6Uu1XtpR542cJb/84rh9nCu
         OJtYVoZA3iQGfUt8fU3PwIEa/0BkRL8vKLl+z/3oSRqU5vr8eS4+fD6IhVatEbk2LC6s
         eNhEshtmx58TWDlgJcKftbyKWalxc5EEoWdXgAxMCdMNW3gOGKHWSJ1Pxq6YkS2pfGqk
         AywA==
X-Gm-Message-State: AOJu0YyoG+L0gKH4Bp4zwnkGDPk8DFp6PGK1bNe4+pw3V71Lwq/GfwEU
	XoYx6Ej/sC/hgjfM3ZCJvkBt2hCPfuwS51+Lqd9otXMh/HIECEyskVM5
X-Gm-Gg: AeBDiesriiRs7mLw92P3hcyO81THo83FzfU9MDHolyuJER9IhaHVHb+QVk6iMGTPRPu
	CA0UBEK4j9tR7wMhWtArsZPy/EIbE/cL8C1fvsdOPbsx0RZyGHMOKIjVuBA6kym6Wq4NulvfQDw
	wpjMVa+i44N508nT0x/wrEvCUi6fOOa1g72JIQI8XlH4csAsZ3fyDg9YVfdVp9e0sbwwYA2cibV
	noJrGerQzul11UQqKOb7ZUY9Y+BdYe6KwnFlxqjZrQWc5IUOBYGHP4H0F/nT+Mu+ijz5jfm7DC5
	0V6yXYSPtbCBIXVQ2uSdmn+74lN6JE9uAtGV/Cysb9nO66Ussb38PywHk6ecOORL+iYO73arUiy
	dhMZB+WgHGYmzqP+KnxyFnzBQB77F3q1QLIrcKaPzjf3rXF/Lg5BBe+kRwSQsezUymECzqkFdaW
	N7BSlvl7OnlUj3wsI1LtKRqUtwfywBkYGovRbjTK/mNzZrAKcZA3+W3JSkY8LEPCWFqRtjCYb2u
	pra
X-Received: by 2002:a05:690c:c4fa:b0:79b:deb2:f5d1 with SMTP id 00721157ae682-7a4d644733bmr33551917b3.51.1775229515765;
        Fri, 03 Apr 2026 08:18:35 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea2872esm22830477b3.19.2026.04.03.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:18:34 -0700 (PDT)
Date: Fri, 03 Apr 2026 11:18:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.12f4cfec4b07a@gmail.com>
In-Reply-To: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
References: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
Subject: Re: [PATCH net-next] psp: add missing device stats to get-stats reply
 attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275104-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6D15395B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Daniel Zahka wrote:
> Commit f05d26198cf2 ("psp: add stats from psp spec to driver facing
> api") added device statistics (rx-packets, rx-bytes, rx-auth-fail,
> rx-error, rx-bad, tx-packets, tx-bytes, tx-error) to the stats
> attribute-set but did not add them to the get-stats operation reply
> attributes. The kernel reports these attributes in the reply, so
> list them in the spec to match.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

