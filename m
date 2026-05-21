Return-Path: <netdev+bounces-290621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP1CKTh9D2rLMgYAu9opvQ
	(envelope-from <netdev+bounces-290621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:46:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6355AC2D4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390423013799
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B332494F0;
	Thu, 21 May 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d/P5yDMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA81A275
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399971; cv=none; b=qSj1r9mYemg5EJQ2S9bxqU1FS8zAZq1o/z+UwtugCLBRETzzK4HSBb1w56Zz5SaIxIlM6hHjgOroc90//1cS5KdIZN30vExc+kRR89htJOyDPdga4dtdzkjWZTAJqVs6w9ksHL2wb6MVUgV6lMbj6rptLcXGDkSoGKCwwiC3xEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399971; c=relaxed/simple;
	bh=QGFwCYm62pRfBMKZ2oCnw59SryglSN5PHN8XcB3oYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XORWBZTTgK6eLVGKQBhpPQBorRJYzJ47k2tA9wMAH7+LKds2Dyq8XS/36KUrNKTNtHfPCuzBPrEI7hximMQPl6cF9eHolRgpphHbEvhil4DTaVA0M4mS9uXCKYJdHIDjtPrzLVkmgkZ9nOTpKTdSkmxjKn4jMOeJudR1naSq6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d/P5yDMJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so14753472a12.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779399968; x=1780004768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MP3vGb2XHZMWEOywtu7VIbBhWRaVTquDcnMYanKoxFQ=;
        b=d/P5yDMJqB47aWB+w9A2ozd7AJxruYpMkXPwpDX4nL2o6hInxMD8M0ODl/CfuTPTvE
         K3sbjxoe38koYCUjsP7cAMjiO3WoXkZNRgQolW7cAJt9WaNmHQsJiFrl17URkOqtBNbt
         RIvhKm7goTYQHw1kBXWj/GRZhU5nBQYzEV7AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779399968; x=1780004768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP3vGb2XHZMWEOywtu7VIbBhWRaVTquDcnMYanKoxFQ=;
        b=lssmj1z4tbeh/TbZrKWfw+ue0y9s5CvnDBf3ngRxthhAmgan81EnrORs9ljeaqGfzg
         8zXnDUSkCk/dgfpNfEvvf6kRMXp6zzshcCM92PzK5Oh3cZk19T4NmqqAYBxTQy+/xJnJ
         96E904DISR5IsfKud+eQuk9m3UX1AIDApS2m8Oy2zkdO5CFzwluf9ADlvqGMz2PMve+O
         bd+077SoxufvsGhII6YqGFWX6hq6/hVeUKSsFUMZxgdM2ErMi1B8tsTLfNAR5k1k4Dzr
         JTn4NRKCTGkjtf3fTKy7Vk2zPqnGbb1x1s5aDwboK82gDgCZJsN2sCY/IqJS7llNVgUm
         FRsg==
X-Forwarded-Encrypted: i=1; AFNElJ9R2+KO/oEE1yFVBnF/JwYM+7w3k/V4Ae/ck/iL2Z/1timFdM1p9cwN/aupDO6VZHapeWQ93Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuLvLbXvFKxu5Fl9CEpwaGIiyA/5JA5kApt0jOFYRAycKLFDT
	ehULyldyT2Y9S4nMzGPUdwqRvDsdZuK47dMXJ8lvwtH3GwfXlIFVarPm8ZjJmpyLyBGb/qXvIGn
	un/KtWoQ=
X-Gm-Gg: Acq92OGj7MpWpotWUJYjgGlBHq/BBUQOPKbJq5QFz7+o6JU2DZGHMT9t+Vu7uD3s/PA
	13ztu9gfzx6nJJCDRCCRmeDV3N71twu4xmg7E9lQaeFp0PbPusBI8Lwcr7AIIfEgMNlPp3H0kvo
	dsEa38RjbHdLYm+ys6d1GfelkdRh7ffyaoqj54bIxMlvO1ffH9v3ZjG8fzQc2EBKDbAVDvERJRS
	UgBaWkvSBanbuwA9RPBeHKRmYZflsSKqlffvevr1DCyl8QpHWv9KrIShh7IR5QZkWtM32S2Sf3/
	ShmJrKIk2rBtGEzxRxGE/mXqhTNdx4Y8suEpoZbuy1CCLpu0NONY9/qpIenyfxXVhoBpfEjNa+3
	NV9KxD76lyjLthfHkIVqDvrXzoKXzfwOKRPAkXy8VsumWHnNuVcbu5JCaKi8PW+J30y+LP3noQ3
	Ka6Q8vn+HT19NVSDNa9lIzVdal02xiERXXKR21fHKZoDMsT6WJwvTSWPvcqQba8mO17RBQ3/zz
X-Received: by 2002:a05:6402:1ecc:b0:687:bf35:f049 with SMTP id 4fb4d7f45d1cf-6889cc4cad0mr315945a12.22.1779399967952;
        Thu, 21 May 2026 14:46:07 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b22bee6esm45523a12.21.2026.05.21.14.46.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 14:46:07 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so1321369066b.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+eyyN1sYCC5syAlO+LwB/APtWgFXZLG7fKvVgnetpGwoXV9ffNhrwoJakVj76exBm6TidtqI8=@vger.kernel.org
X-Received: by 2002:a17:906:ba8d:b0:bd3:a1e5:65f1 with SMTP id
 a640c23a62f3a-bdd281a5d63mr62055566b.44.1779399967053; Thu, 21 May 2026
 14:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521184315.3654490-1-kuba@kernel.org>
In-Reply-To: <20260521184315.3654490-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 May 2026 14:45:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_75mNMP6Rmz17E5ZwxGJ2Re6foOif7+gQbC+9Ox1r8g@mail.gmail.com>
X-Gm-Features: AVHnY4JhC0pZGedKfOu4gC76mC8TO84x8hPgCuI_jKH13E4cLZ8s79drFIOwt64
Message-ID: <CAHk-=wi_75mNMP6Rmz17E5ZwxGJ2Re6foOif7+gQbC+9Ox1r8g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v7.1-rc5
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 0E6355AC2D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 11:43, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Misc:
>
>  - bring back the old 3c509 driver, Maciej wants to maintain it

Well, while I was hoping we'd be shedding some pounds in the kernel [
insert "buff penguin" jpg ], I have to also admit that the 3c509 was
the one I had personally the fondest memories of, so I'm not unhappy
that it gets revived...

Not that I'd ever want to go back to using such things.

            Linus

