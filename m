Return-Path: <netdev+bounces-193419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16418AC3E3B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31C4176DEE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D15FEE6;
	Mon, 26 May 2025 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg0sQ4GR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341D10FD;
	Mon, 26 May 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257265; cv=none; b=FAZg6J87QbOFp+p/brjdKWLsrmQiYLg4FNPEblwNYV5gLrEvHN8iUkjV6GJirK5RWGhE2iovWAE+rdUnZDmQY9IXBXHFJtuPBKkxBWmiF+Rg/tGy1pF5j8zxzRfIotF9d3lMuncU+bEjoLLbvcud5OLqSjlVykJcyUpOahcDoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257265; c=relaxed/simple;
	bh=P8k5cqwnruQ1x9W80TsUFMMyat57fGLTCZhNMJY7rZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoqFAAXTEKjp8i8VbTD41G+NglPnHeNofO+FQ1iKRBiLg5gKY5jB6VCV/SnjF6Ssn4211/NyuC786YqdI1hFOTrXssURga3JX4QW+dDqCHfb5mngzQbDwhBrITIPRVDc8pXQjrsq4yUE5FJh5TV/ZDjTGHc+gWVzJN1mf4aEVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg0sQ4GR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so2149954a12.1;
        Mon, 26 May 2025 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748257263; x=1748862063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P8k5cqwnruQ1x9W80TsUFMMyat57fGLTCZhNMJY7rZY=;
        b=Qg0sQ4GRpQyZKmqg5R0xUkr3MoqdyDC6uaF7Uiyj8BHrJzQr9rk6iN/KaMSVzop0YW
         SbXIOuMZzrs+5pb93KHI0w3q1lZGPVPzY9RvbW2qIVtbiaeWPuUpzbMWI57kh//ibecj
         +Yw4R5/UaCriy/3N2q3almvQvPpjs+1rpPakJbK1iydkVjn4skEuyf1jvqgKAFjisIZP
         dFJqqWLVnvswKlPmkItR4l0wGMGJJ8FI7RJN41sa6u0auVZExFfp+LiT0wLQt/8cssqg
         4q4/dacThcGNo2VpQx4IbkZgrhfpTLNqsMyd37MwzneGaDerBwbOvHbQJ+v3M6WPuf1+
         Ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748257263; x=1748862063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8k5cqwnruQ1x9W80TsUFMMyat57fGLTCZhNMJY7rZY=;
        b=wFZgHN470/SS2vuCRqkAlv/nCVcmnYYHlxBRrnHTm37mcg/kgMS8WQRDthlyrT5FWY
         +nVXOKQeG9x4LaXaCJIf6tu0WOkCuBRomNudspoNoIg4IsBg32nziKQ7Z9yV177C/DUB
         E2ZYTEt/EUEzrdkk9T8pzF1+8lFuEBADzPik4G7Ekp/sb2FTM2DFq41ZDPi5CE+7WtKE
         D4aQwXwvgcUrG+uj7IibmnZInsiB7ECmCelHI4rvH6Y7cyZ1RUL0ts2URyXEzDtqQQcW
         97xQGlerfqP5mCSbwIyNZL0yWwzrCI691rABZgGisEoPfK5brXwHMphclhrfYki3lEvo
         5kSA==
X-Forwarded-Encrypted: i=1; AJvYcCVV9qa7jvlgotMA3Hq7kcakT/JJm03vf+o1JEIw7N+icHbMfacOXSj0ZHpRMzTo3U68uqG+ZSOxnEnX9+Y=@vger.kernel.org, AJvYcCVrozKOgCuZ0L9o8CcLUaNBtuPBUP3GHq5ZXtjc0xZauZJe19Z40Hk/TT1ddQpbh5o5w50SufU5@vger.kernel.org
X-Gm-Message-State: AOJu0YySmn66TklphZV6BxEeSGv2kpY7gEgGyHJ2xX14m3jHOv+1CfxT
	syyMxD4N3S8dVk+AsPOiN/x+/O6LqvN4b56gV+TGPOb4cjZK18AGx4hDN5ryyYBJPjLlxqbN7zl
	s6R3JtIqliXzNGpItWHUktk4uCUjqqgrXH3x2SLQ=
X-Gm-Gg: ASbGnctA1aXrcqMe5Juhv2dVlGQUqYZWKOjTnzGjYQo4c/tvX0QWzjIP53+QQTUYWJN
	9TZQO1J85fX02dObFyVU46FnB/Xw0JlvDT85+ku33wuMduW5AEmQKBXi496iBOjwSOSNq+nGH2j
	S9q6jQXsLD7I+d7qv+/0rovssVhAced/G9cog=
X-Google-Smtp-Source: AGHT+IFzKALfpHYrl261f5UqzhKbxKXbyaXPEfSZRiUqquUXIhamqnDtqYwWSjn1xlfXmEci9RHW6Yv3ctXFpmAsmu0=
X-Received: by 2002:a17:90b:4d07:b0:311:1617:5bc4 with SMTP id
 98e67ed59e1d1-3111617a102mr11083391a91.12.1748257263138; Mon, 26 May 2025
 04:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520160717.7350-1-aha310510@gmail.com> <20250522145037.4715a643@kernel.org>
In-Reply-To: <20250522145037.4715a643@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 26 May 2025 20:00:53 +0900
X-Gm-Features: AX0GCFuBtvDmlIQiOi-FLJP0rr1olcYAogKIohBgi9-ICrvKDMnxZu5Hw369nvU
Message-ID: <CAO9qdTHuDb9Uqu3zqjnV6PdX9ExWv24Q9_JfQ8FbKigipDrN+Q@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 21 May 2025 01:07:17 +0900 Jeongjun Park wrote:
> > The reason why this is appropriate is that any path that uses
> > ptp->n_vclocks must unconditionally check if ptp->n_vclocks is greater
> > than 0 before unregistering vclocks, and all functions are already
> > written this way. And in the function that uses ptp->n_vclocks, we
> > already get ptp->n_vclocks_mux before unregistering vclocks.
>
> What about ptp_clock_freerun()? We seem to call it for clock ops
> like settime and it does not check n_vclocks.

ptp_clock_freerun() calls ptp_vclock_in_use() to check n_vclocks.

>
> > Therefore, we need to remove the redundant check for ptp->n_vclocks in
> > ptp_vclock_in_use() to prevent recursive locking.
>
> IIUC lockdep is complaining that we are trying to lock the vclock's
> n_vclocks_mux, while we already hold that lock for the real clock's
> instance. It doesn't understand that the two are in a fixed hierarchy
> so the deadlock is not possible.
>
> If my understanding is correct could you please clearly state in the
> commit message that this is a false positive? And if so isn't a better
> fix to _move_ the !ptp->is_virtual_clock check before the lock in
> ptp_vclock_in_use()? that way we preserve current behavior for real
> clocks, but vclocks can return early and avoid confusing lockdep?
> --
> pw-bot: cr

Your right! This deadlock report seems to be a false positive. It seems
appropriate to add a description of this false positive to the commit
message.

However, it is not appropriate to move the code that checks
ptp->is_virtual_clock. If you need to check n_vclocks when checking
whether ptp virtual clock is in use, it means that caller function has
already performed work related to n_vclocks, and in this case, it is
appropriate to perform n_vclocks check and n_vclocks_mux lock in caller
function.

Therefore, considering the overall structure, it is more appropriate to
remove unnecessary locks and n_vclocks checks in ptp_vclock_in_use().

