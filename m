Return-Path: <netdev+bounces-246605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E0CEEF63
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0403300B838
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7278258CCC;
	Fri,  2 Jan 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFj0uAYu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F175D53
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370984; cv=none; b=HdWdsdAWNLZLk9AzIrnCWzKa6aeRMEI7I7Eq0smK11YUAnfOmulf3cjEqOoUayeq2raKWwP9CMQrVWBO/1au4A+7k+Z3bEtWMJ6peOrdpGDK6jZFauQA9r4IWrfk1R8f859P8z8AjW9RWADV+vR95JtZdonLqteA1We7ji8eRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370984; c=relaxed/simple;
	bh=7QLNgQ6QIpM9QnBjm5RhBs/mAlNZ/iXshQK/y/2Vuvo=;
	h=Content-Type:Date:To:Cc:Subject:From:Mime-Version:Message-Id:
	 References:In-Reply-To; b=rvmaX+JPNdTdbP0VVdUOYR/fkvYPqWXpqbiwNOhH3rYiJuEmCVGU/XMAmlHi1RYkbDOJZn7Eyl9nfY+tJPcMKBfXyjZ/C6482b7JGQzrwO/F2NMSas1TvdJ/lPvPLh9+TObCSEyfXSFI2ZDxE+TBhtu5Yyx//eW7UQY5u3+Pphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFj0uAYu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so39653445e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767370981; x=1767975781; darn=vger.kernel.org;
        h=in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:from:subject:cc:to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QLNgQ6QIpM9QnBjm5RhBs/mAlNZ/iXshQK/y/2Vuvo=;
        b=aFj0uAYudAV3vUm1mxts9O+qKB8c+tZyIC1UFQeOX4ntfXz62551ZJRGQyPrxX8FCS
         OB43JcK2NA1z7NnMgRGim0nw9tGCOVDDyO6K+0jXh4K2XxqETYpFAapSkyEWI7RZqAqa
         IscxmQRqYuPg6vGKTwDUMb8OxGd5dD04ZSbtkZpS+8Qk43YpYaEVxcqLR7XA9Yw24PII
         /Jcq0Yw6PWvI8JkMgfouj30aeFqb7ThloMn8Hu/GUsVNBsFgvPdaGkh4thzzSgFaCU2r
         A5YQVnTZ6oZsaGg87QB4zsv8o8VaoFJTSgy2PrazpzJwWpkptwAYPZCO6KH76X2AZCft
         zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370981; x=1767975781;
        h=in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:from:subject:cc:to:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QLNgQ6QIpM9QnBjm5RhBs/mAlNZ/iXshQK/y/2Vuvo=;
        b=UBu4wcE+7SqWp4YF8sxjScUgI/DuCfPzNyYFqQqHhKkPPTAzGEzw+zUixiHfyqXG+z
         F4KYHuIfLJti8THDJcX/F4Yuacy4a6D/4igK2t2UmzScZMpNkEFT7qFEGYsoUMaMCk3z
         SLLdy5D4+Lxi8jPFvF0UHjQzfJHBBLJp4aT0fu++qOzT6ZK8rbC5hp9vz/bBrCY4+WFU
         Ap1zzlNTKT54IzzcVbt9MpOD2NH5HtrObKf5qaHRqMMirH6KYntglw0j+mRKTCxDi1qW
         V1VB0o12Hd9W2N8H4u7/GF9Gp5PWttWGh8kk/YOnZ1wU56TWR1zhkEZccYhnO+SN/Cwf
         ETPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZoGxI+nxXdExF5K7PaDRx1ErzILyv2wfJpu3tBXQAVkB0qP9xGIiAt2MqDzDyBZK95TpNUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtVBO9srhViwULAt0DtRlOA0S+gJE73qepGuK9TAj+dHQ8oMU
	XT1brOMhi4tQ92Mn6EXpEB8YBoh4L2qkToPiGUmHssrBUDLptoimM22Y
X-Gm-Gg: AY/fxX51Zi87THBOuKqfb8o8lMvvwaFcKIQK/nocCRUi8JR1g9BIlVBsP1GkfSqGPJy
	uJLj7v8tM4xs4pD4irmho5lOj/l5PsTJdr6nzaxKKYorCS9Tw/v9eBRz+oijkP80GqxQSvOUEj3
	vHib7ahI3UJwglNgOt9pFJpAQbeErahO0cuxnl0Emyvc142A1uB9gs9Jp7OHadl3tKsGxOVSaST
	fW4MOQaWP3UrtgVfTBLLsa3pUsJLK1sNf1fXH8HnSaRBBbR6ppMvvHSP8sq+TYUaoeicLDGU4OY
	ip6SRhfIVWPT5O8b9kIYIpDNZ5nikAVqe2sZCS09vMJtS9jwNRt+7sljvO+lezdOmW5Eo6JtCFT
	C3kcPIggfw7CifAUOGYPSbfj76l9jxt+IoGLJ4ag0gayXHkZSB+xUc96ceksSu0LHOSCIxITasJ
	An0vybJZuDQEXGTJ3ZyLkYfBeGO5PAutghJx5E/hXn+6LUGAKG2g==
X-Google-Smtp-Source: AGHT+IFcWLCFbeqtQtLKfgM5usD/ivqIPxKD+ZeuzW+hm1fp2YVgjHI6zJfUz3GOECJvJ/AJ8hzivg==
X-Received: by 2002:a05:600c:64cd:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47d19595042mr515977435e9.17.1767370981400;
        Fri, 02 Jan 2026 08:23:01 -0800 (PST)
Received: from localhost (bzq-79-181-178-61.red.bezeqint.net. [79.181.178.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba3a96esm1761605e9.5.2026.01.02.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 08:23:00 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jan 2026 18:22:58 +0200
To: "Pavan Chebbi" <pavan.chebbi@broadcom.com>
Cc: <mchan@broadcom.com>, <netdev@vger.kernel.org>, "George Shuklin"
 <george.shuklin@gmail.com>, "Lenny Szubowicz" <lszubowi@redhat.com>
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFE8DLTGB5Q0.1184HJSQ0DHK2@pve>
X-Mailer: aerc 0.14.0
References: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
 <20251224165301.2794-1-noam.d.eliyahu@gmail.com>
 <CALs4sv0BdhVHawBkkxN2v2o_jqGyFRAe1RVJjGu9d08HM2Jwug@mail.gmail.com>
In-Reply-To: <CALs4sv0BdhVHawBkkxN2v2o_jqGyFRAe1RVJjGu9d08HM2Jwug@mail.gmail.com>

On Wed Dec 31, 2025 at 5:10 PM IST, Pavan Chebbi wrote:
> OK I now understand. You make a lucid argument. 9fc3bc764334 does
> indicate that the problem it is trying to fix is very much limited to
> R650xs.
Indeed AER suppression is needed only because of the conditional
tg3_power_down.

So both the conditional tg3_power_down and the AER suppression should
be scoped only to the platforms that originally required them.
This preserves the intent of the original commits while avoiding
whitelist maintenance and reflecting the relationship between the two bugs.

> Hence while I am almost sure that your proposal (about adding
> conditional tg3_power_down for R650xs alone) won't break anything for
> cc: George, we need an ack from cc: Lenny, to see if he is OK with an
> unconditional power down, and that he had no other motive to disable
> AER in tg3 config space. In all possible logic, it should just be fine
> because e0efe83ed3252 is fixing 9fc3bc764334.
Sounds great!
I'll wait for an ACK from Lenny confirming that this approach -
limiting both conditional tg3_power_down and AER suppression to the
affected platforms - works for his setups and doesn't need broader
application.

> P.S Sorry for the delayed reply. I am on vacation.
Totally reasonable - between Christmas and the New Year, I haven't been
very active myself.

Wishing everyone a happy and hopefully reboot-hang-free start to the New Ye=
ar!

If it helps, I can provide a pre-approved patch so George or Lenny can
test it on their hardware before I try to commit one.

Thanks,
Noam D. Eliyahu

