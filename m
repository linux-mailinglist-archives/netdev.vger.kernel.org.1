Return-Path: <netdev+bounces-285082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBgkFTLU+2lxFAAAu9opvQ
	(envelope-from <netdev+bounces-285082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47F4E19EE
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782173004223
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB70368975;
	Wed,  6 May 2026 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlnoGexS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FA30EF97
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111535; cv=pass; b=oRzRZybfLoCCpkXNu0t4B3ElCa7flb2UjmGH0y6svjoCDqFMHXW0sDcrIXc0SnE8cThNquFsWsUBLRCXwff5zfcE5e/ENHrbHiLq15xhkv4eopDEQt+LuW/yQqfZ7q77/WGZROYWJo9XcArtdla35Cz6DIoV5xnRZd6n1av8Ra0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111535; c=relaxed/simple;
	bh=cjqKyBLdYkMJts7PTnGpcqVDRrSmwA+ZUnjwKVNZs/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXTIgR14DlMEnDjpbMN7xqEz7eXv11C4EPGp/dB/epOdwRbCPuCzq7G6gcVdzNsSNpGfwGaVJj0wmOt/f6RJT2GEZQ7Es6mAWrybXWojYZXqBVWTQc3tBrxaApdbr+yAP39Xsgzap8OJz2A5anMqCfARBXWo+GhOrZCvrpQVmJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlnoGexS; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651bc83e74aso188143d50.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 16:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778111533; cv=none;
        d=google.com; s=arc-20240605;
        b=fMQdC20gNaoXkngyYr40NufoF5ig4ehnkUxfJCnA4M/iOqH7zTs6XPQAZZjTfjkQYw
         92a+rBOivx6VitwbGo7lCkWY0m9eRdhd8weizey77n4Goi9F8xHXxb864tNlWP34nkSi
         9fVbqHvkyRWqCGkdlteCY3UB6cdm/RdRlDgAwsrn4/gJkRULWuuHNWxItpNKwK3UaOwu
         mNCBDkRIVnkXwp/tSTIBYoj0UGkHJFXX9T7KurMQjSnUvYm7iJOJ6WlZm4cW2JPW5DQG
         FPaCZzvc6R1bTpzSjM0GlvoyYp0CyzR5A5BxY43RsbCCC2DrKqdF6Lj6qLPTNg62qyUP
         fRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cjqKyBLdYkMJts7PTnGpcqVDRrSmwA+ZUnjwKVNZs/4=;
        fh=GnpVggLKmb91iR8r6a6hkN0y6HYmthxI++zhCdg/mXc=;
        b=S2ZGhPgASRihQ3bLobBkxTTdh6ySS08EYs08ZafHIRKJCuFpIOxWfWYoURSGCAldd8
         BlIUIsj3VuLqCqh9BPSzuSGb5ZOygv3Nwh0qOWVZ7K+foD+8dSZeP4ZHqTUaJtn8BDOz
         7yl36wY1awB1PRDHpP5OrDArnf1odk2ZHJk0eu4yJIU46p4/3PF96mlOH2jnyE15cqaA
         hEQ21b57UxbJAP0btAXtqN5KjPNKGId9vUyiLjbXdM+NN9huefT8KwYriayXlpYgQru2
         6qFQalYqXWCSlfVVCttfJuPgaj8YRVymSgM806E7wsHOJyfreIsmTyoAOaj2xD6z4i36
         mZ6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778111533; x=1778716333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjqKyBLdYkMJts7PTnGpcqVDRrSmwA+ZUnjwKVNZs/4=;
        b=qlnoGexSLQbzpGyZacdYZO5a89NIlJzwdK5hJ/Kt51lcRUstx1iaCz8Rr8x9Wbqlp0
         mBWln8X31/h/GUq2Js2M9CdsONWk94QJj0Wh+s+LG3KJ+6rCUR67eFDiShaCll0D61+t
         IwjdQR6gYyIzTLcihRPSp6NykhKjIZmkME9J2guhYbToxAydVfSPT9Ka4QFUfAGMYbBp
         jZavL6SK0gvWQvqqPyB5c8msBrSFwONEMrz7O3+T+Cn9PP2hVaO/fAYsKS4fsFT5duKJ
         YtO1RBFwALQdLFUEO534oCdNMizzAbNhoraAYKOAblhYZmKUF9QzpWYg08s6s0C8btjf
         kHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778111533; x=1778716333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjqKyBLdYkMJts7PTnGpcqVDRrSmwA+ZUnjwKVNZs/4=;
        b=J7zbcWtW1dc4+Hre+NGn8EX67r4HPIVJmP+MGUYz0QerSdm6AF/qRiyoyoXY/TWTTM
         Dg/xre+Uypcrl0bttKMtFRwKdVX2A+TIRalQcsR+P2KwumyjkxixwFCdv4mHk3qgiXLz
         y/M2XMyY84RDzkvPkTe1QvZ/YuzsERULp8w1jHZ8nqml3Fcgt92CZ4N38z5eFJTyY6AX
         O5+RBbJw5FNnbF0EAzSRya6wcHs/Zn8MCdCPffLOxHrt3DPq1mBKCi7uZmIg5r+kkKY0
         /vGchQSRGNKOX3fq11kswldaL28aLVT00Z6S1aHmghwn/826op0wU/QWEa2gOIb7cSal
         TTWg==
X-Forwarded-Encrypted: i=1; AFNElJ/G/aGixEzbvDtyyadxevBH+75for/SZjf6KV1h+fpEQUCvnOyXkuaHwY9jK7lZNg47EUj7cws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAvaXCiwiBPAqb0kqiOnRZevrrQqQC9y7ekFFVeRFqWif3B/q
	haOqmj9d+QF34jpKbs14IHABdKfRHXlr0ScIO5L6TabLF/mWTJGWjh7FJQuItPAPNHWe051m8zT
	qI2AXRxgIzpp8QDQ6LtqxMFihOju7/oA=
X-Gm-Gg: AeBDietUjubP9OFUnM5wn4Ja31E4n0qgqJ3nVs8LhLMSqibU3nbpIg04ILZxibDJDC8
	RLIO84chKWsZUeCem+gy8r4yj4f7eyUChL3Q9uiFoVb+jLJXNDts2vNGnH0UTbeswQ8E8ecvgeJ
	uoXASijziDqUxRQcWQz8iQ/M1CybSnOOfG8WDi+1Rt8M3ZO68YaIVJ4TpVKZEns9Or/6eI9NX1k
	CIOE8swlT0HnCglow+vDEJw/HbvFxjvjGZE+AIEsarqqMHn631tcLn5v4siATXqpjsW61OMEAtD
	WmiF0qGIhHJGhdeMovE=
X-Received: by 2002:a05:690e:2419:b0:656:fc53:12e0 with SMTP id
 956f58d0204a3-65c79c698e0mr4219891d50.12.1778111533102; Wed, 06 May 2026
 16:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506211415.16343-1-alvaroc.dev@gmail.com> <20260506154252.65d673c2@kernel.org>
In-Reply-To: <20260506154252.65d673c2@kernel.org>
From: =?UTF-8?Q?=C3=81lvaro_Costa?= <alvaroc.dev@gmail.com>
Date: Wed, 6 May 2026 20:52:02 -0300
X-Gm-Features: AVHnY4Jy6PCJ6mSeyd5QEqTh8UX1uHe6UMv4n1gqmVIgwWKhD03pQbWsx52iiMQ
Message-ID: <CANRVa7yLigAOv0dduqY1smethUoHXuiNrUGMH3Bf1jtW976_aQ@mail.gmail.com>
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with strscpy()
To: Jakub Kicinski <kuba@kernel.org>
Cc: jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:DEVLINK" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CF47F4E19EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvarocdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 7:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
> The current code validates the netlink attr is nul-terminated.
> I'm not sure if your patch retains current behavior.
> I am sure, however, that checking whether the change is correct
> is a poor use of everyone's time.
> Please don't send these sort of patches for networking.
> --
> pw-bot: reject

Ok, thank you for the quick feedback!

