Return-Path: <netdev+bounces-271850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC/sNePKxGmA3wQAu9opvQ
	(envelope-from <netdev+bounces-271850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D922632F8CC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D818830138F9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D113AD524;
	Thu, 26 Mar 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI5PnyBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352F3ACA7B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504668; cv=none; b=hcL80hNs+SOibrPm/IhajZi07wv/f/oLmSo45+QZBNiRv3c/dRTZCcduvq7Hrh8LScrmWBNs0A37bTFMfkhpAr/brlJY4TMbAV/Vv9atO9Rfz1M0+Le3hRjD5j2UTVqJAInV9B9eby+3o1CABDmC6Cffu5aYh596HGMpOL1jouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504668; c=relaxed/simple;
	bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ntSlRwmipdaFPNmIi7/cO35gC852ZKuyfBuw/AMVllyd44utWJkEMzFieH02mXJc7I9W1u9FG5f8eKmH5iAXn0MbJU3WMDeU/Z+w4fPRMmKRAV7q6kcw1fUWjz+vgQ1Mrb9gDROXzP0f4CYIEe8LKX0/0V4ZemcoofbvwlUNMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI5PnyBC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0603ee486so3727035ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774504667; x=1775109467; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=XI5PnyBC72LXWQBnmQvPuQxKDxpTzxKuAurZWPww5n5f1RgNZaTpTXcHzhxMN4Dckx
         XUtTLRMq8GwS0s4/zXNoQExUS1NQF7E3EshnanroJMScd/FKUzRdQbsuA0rxJ+zX0bj3
         vVU99WErMB5RjlsccmlG7Idyqpp4JQYSzSGBQFB8Ex19x67zSvUNRDy5nVicdFX/PZAx
         AKIZELXF2YJxE5cLOOdLs5FNpE+omtCkDvFqsuiojnTPXLIh1GThN+xQsD1HTIHulG4N
         ibu44C5QYodFBk7H0aneyJYBS0GZ/yiAZLnmiwnGJktTz39HIfDVg0T5nHgNUmbod55I
         gr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504667; x=1775109467;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=b5em0jmyZSamCV1Y0wcVkm5NIpYRy54bnirAudP6ZpFex9QA8VbnFrQEe+y03AJyOu
         ozVujC7YwMQMr2zBnzz4YtRQDWmt7GVWgYaT6HdJMIYf0qtqKGwEerImb08QzJ1eeEE/
         sx2Mfc4p2alf4368C2jr50j0B5xRjU9SIjqug5xD6UEVkB1mnkaB+SYhfCS5kXvmxa5V
         VEMqZfCsk+gkJnw7KeKHf3OIJK/GDmdg66PO7GEAd3ny/NiyuDnaQ+7hTgr5maPMJbWs
         C1Q+vdPUQxLRa+hcoD79Sq5KQVx5LqEKORsx9KsQJEk9B+IjXdmQC2tiF9empfQW+H9z
         DRdg==
X-Gm-Message-State: AOJu0YxGE6j0zbeUz/Pgv8ecmkl2S4KGJ8yswAC6wpv1QBxT07bxhfJL
	c00QLQvyU9QyaEo2nnHCIF17KHuNjD6zZzhz+bAqdlhrO9Pe1AmJlWha
X-Gm-Gg: ATEYQzx0iiybjVvXE6vjrI0SabsMZeyNZ0iIwviSyyjP/QZv3vWfhUy7E48tW43Mtyw
	7SJNx+T4vjzQTicNgxDKr/uYPlTD26b/+MZ57Wd2bXuiv2DX/YQ0Cnw4XOQbS0GebTDaaZZM4Hp
	jkfqTtWWkE1jBxjGbgX4Dh0r66wWnYxzOsjELtxtrmji38laEtBZp0cKH4Pv7RWRecjS7Q9kaIf
	5KeONioJCaqHWPFSJ/IhCLSPqhBqOCcb8OqHiVfx4dFF964yVQskbAQvNhZ5WjwNcewSGE4qYqT
	zrHD+piMKQEE5huGa2gmptsLMi7HTR10/mm30SVVuH9lMWCzgAzsPtYFNPQnZXTE58FfUGUvCik
	REoQ6QkznMiue9YuYrYXqOE7LpkTkBxDjFxaL8UcVinxHzNmYfRHAxfFnUdtrROriji9gS82zm2
	P2TE1dc2wgMM9tgRCBwAbXAYhFtoUZ
X-Received: by 2002:a17:903:2292:b0:2b0:61d9:77ac with SMTP id d9443c01a7336-2b0b0a15977mr65774345ad.18.1774504666871;
        Wed, 25 Mar 2026 22:57:46 -0700 (PDT)
Received: from localhost ([240b:10:ff26:df00:3001:9be6:4399:d681])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm17437975ad.59.2026.03.25.22.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:57:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:57:41 +0900
Message-ID: <0328d0852f0a27d625e1bc629a4ccea9@gmail.com>
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
In-Reply-To: <20260325171532.GI111839@horms.kernel.org>
References: <20260325171532.GI111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271850-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D922632F8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 27 Mar 2026, Simon Horman wrote:
> I think the Fixes tag should cite the patch that introduced the bug. The
> commit cited above looks like a related fix, but no the cause of the bug.

You're right. build_polexpire() has existed since the initial
import (1da177e4c3f4), so the padding has been uninitialized from
the beginning. Sending v3 with the corrected Fixes tag.

