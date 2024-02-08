Return-Path: <netdev+bounces-70168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C184DF15
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADB8B2A0A6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1776EB54;
	Thu,  8 Feb 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ghGKhaLf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628F6E2B9;
	Thu,  8 Feb 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389743; cv=none; b=VPl8B7E8LM5L6DU2cqrw7VkEW4K3EYieT/ausO6o+hTkI8f6mPEBcZbpu28smAk9fT2DwQSggaW83u0mOj1JuI0TKqF3NhTXP1qXOVVX+X7HQao4dA8Ef0eWPGK3JS3lILMkHzdL3uoUxDucXzEKYwDvg6vGSIiMEMzMLbjp9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389743; c=relaxed/simple;
	bh=m8WDBbHwDVXg4BqL2QjfT6NEHdX5ALO7jAdypOyi4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR29jdx9O6EnLfcd7EvWiCImbJ6Gk1KuZOaYPtXuoqdx+7R7Avlq2FICjuK4fk5Q7zi0Sr3/1WjqZtPD/i+Qp5LwCIOn9Aia9tKXtkZky+au84aFTVlwmiyfI4ZkltYkkwQ64xid15AXqSquWHNDR5Jva2Ro0YjmfQdnWTqnCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ghGKhaLf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 568B740E0196;
	Thu,  8 Feb 2024 10:55:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w9Aw71IIhNTF; Thu,  8 Feb 2024 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707389733; bh=4dqcHEtm0V+r2N9kdvvX85ax2ZPQFWE0+wTfUSVpdEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghGKhaLfKcO9MsqOMeD5j324GN8bDG/NkTmK8dST6js3y+mke5vN0U3DhXYWfqTHK
	 Oo7hO2oi4L7xuoL1rDP2MequqL95Ay0uwXRoS/wTQDM4vBW2k8qsy9DiUGXgYA5YND
	 LTXfGSfODoe6xlGYC04aDbMzAQPt61oD9jf8SAZaacsEzVd86Ruf312DRRD22F/ROV
	 lOF9/ABzb/TYvVQBvmg8QvjYlfHPVJr/euKQ2sYrKtPtU6Ln1aSJQUJpcAGJnGVv6Q
	 NqHFXyDmOMbNeVtZ6xT+syamyultxxcHkCA+PGySPVJ1TkaZ9s6eZtUhnAKA7W67wr
	 +uJGAjQ7aBD3dEB4xKxTxQURHmVnxhEa6GYauciGHqG1qsJE4XONzmCIjBSaCNydXG
	 uOhq0oNprW1k6/h/Ubb2WaVHQD9nMu74zvx1fXBOyN26APGF5Z+04IT6D5+cUoEhc6
	 CThBcXPJqZjf0NNj1jiy+/GpEJbXFdo8LkvN4eub8L/BB8mzt1r75L1rvFXXv+aAL+
	 KCJj5H73RdMlXQmsHcoScrpFlwyY3QJFk99pjhIyIG+GLfC7yWcNd91QK96xsL7EOK
	 XnKyAqnrPZn19YQA+KxUpY2p4fC1cp9rtUXz2hJFJ81C1qU5NYqnpAyViu83WkUedK
	 Sovsk6r8hrxKS4KdRyTkufdU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 912BC40E0192;
	Thu,  8 Feb 2024 10:55:22 +0000 (UTC)
Date: Thu, 8 Feb 2024 11:55:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Elver <elver@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: KFENCE: included in x86 defconfig?
Message-ID: <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local>
 <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local>
 <20240207153327.22b5c848@kernel.org>
 <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com>

On Thu, Feb 08, 2024 at 08:47:37AM +0100, Marco Elver wrote:
> That's a good question, and I don't have the answer to that - maybe we
> need to ask Linus then.

Right, before that, lemme put my user hat on.

> We could argue that to improve memory safety of the Linux kernel more
> rapidly, enablement of KFENCE by default (on the "big" architectures
> like x86) might actually be a net benefit at ~zero performance
> overhead and the cost of 2 MiB of RAM (default config).

What about its benefit?

I haven't seen a bug fix saying "found by KFENCE" or so but that doesn't
mean a whole lot.

The more important question is would I, as a user, have a way of
reporting such issues, would those issues be taken seriously and so on.

We have a whole manual about it:

Documentation/admin-guide/reporting-issues.rst

maybe the kfence splat would have a pointer to that? Perhaps...

Personally, I don't mind running it if it really is a ~zero overhead
KASAN replacement. Maybe as a preliminary step we should enable it on
devs machines who know how to report such things.

/me goes and enables it in a guest...

[    0.074294] kfence: initialized - using 2097152 bytes for 255 objects at 0xffff88807d600000-0xffff88807d800000

Guest looks ok to me, no reports.

What now? :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

