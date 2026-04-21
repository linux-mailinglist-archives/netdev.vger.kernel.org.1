Return-Path: <netdev+bounces-280137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMKoE0OD52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435B43BB35
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A5E1300C57D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62123D6CC1;
	Tue, 21 Apr 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Acp7UsZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A853D75DC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779897; cv=none; b=nCFb2RUwoFHzduZ5bjmojJi2lBkShfNGzxwG3blOV5a6dw2k55sepKASWTETkyRqEJVt/RQY04APPGPX6viwQ3F+vDmemhXT7PogfXWuX1YEq/zJslm2ueF02mqBcoP47XMGjvQoWQmIXkgGGCadPPFHFqwlcOMpVWv7ZySmrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779897; c=relaxed/simple;
	bh=Y9oqSZf+lq9/lSAFfm/qgHMUTOvYonxFrF86FRAuFag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g0aNbJMXOldsYEvB/evz46pMo2IANt6Wd3BUW7riZQzpkLwbESYSc7mMB1kNVvI6JoJ8+Bdb+MkkoGI1DFeIiG1zNZs3HQXH9OpdJHdY/6b+QStWSxiLzDaYtMdZm8azRHUUDR39NPUyT9vesNUHYP05UzcLwj/eNdrxA4zlPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Acp7UsZb; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d55b97f358so2661045a34.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776779895; x=1777384695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfI7O+oTcYo2t5jHKNj/FjyQslLuPorCXOC15JNOL9c=;
        b=Acp7UsZbDhgO44NOXeh9Y6DpmTzbRG8octt9xszTurZyidzPqaRJeOVka8+jzJ2xXh
         xG/rabLSeDgpBCmlhF9JNTG18h/XjK9cPnFe7CdepkzBYjHuIdpUMkc2BcJwGYrepg/O
         LkQPlf/6/XpGu/5BSecuU3N+hyiZEugKJpAUKjA4Ag1KApNlqOTwiL/pUMFxQoXCNbqb
         qt9+Gm6gCVJoddeI7oZ2eHiK6aHad5Pjd+OEjk+Rb1xOtDBa9ite9f8XtMZGe60LPwju
         Oyf/jOWJe/YWkt+x/7nSqBzdmvo0z6eIXCEkb+1om5r20zNBPUtqrmAH2UFMdsqGX13q
         5Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779895; x=1777384695;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfI7O+oTcYo2t5jHKNj/FjyQslLuPorCXOC15JNOL9c=;
        b=c8dIYFqWfNLDEA9WRfW9erimBB3xh3sSLEaXEYHPcQsi0M5w+GAHlsrbQ8QByUL7WD
         BWeZOiYvI5bBxmRUjJg9ZkVOSBkUmp3IFANqqgiIV4ppImr+pbrzJliLhsn1EqxKSve4
         qo2jK3iUnhm70ll72C4nm7QYs96KacWuOa0dZ3zQKy6tYvQVQj7qD4vSNXcJifu9xKhM
         nKsR4s9lrj6mT26xIJSyRT/BbzRPUFGT5RUA2Q7P5/+FdK3vyhelrNz1/oOPJVjz3pay
         c5aX23S6KStgfJYbo2zCxHOgjSQldRc6eM5H0uoTk78p9lxlIkFe8RpOfGQG26PEtHbX
         0wUg==
X-Gm-Message-State: AOJu0Yw/AwCT4q/2mgM/PYvUtBqGLXuW7dZYmFtEQQvq8XRYd4sapfTg
	OJOTX1FGpFCZYxQHQGb2iANYkWH+74r6lmN38VaLr9DycdG3E1FYh9pO3h4U1vCZPklfwKGlBSY
	aHtY26GQ=
X-Gm-Gg: AeBDietUUfN+ukvYOFnOC49QVfTztQsCpAFk7uLhVplmETVTNrbikKvFkWQNe6hx4Lu
	/Pgnixndnhb1lRsf6BK9pswA5ql2k/kbRcNHXF83BbaHpt6mgkfGbxxseSOa6t9VeXr9rLXDOiq
	pKutIchZyIx19NUj559GhEEkGkhLo+3ORE+tBQn1yeWE1+ycQb0yNfuaIWseIEaszUbgWff3cPc
	ru6ww4mIx90wSlZfF3u9NsvZzAImbLEUMwLb06R2ORXUhP4qgV8JRR/35qXpuSojH4L3EZ2irhP
	a1DPK0IUi1LUZQikwhC6axYnfAbkez1k+eX6+WhyizUD7FjarhSQe5AovO+H2752GURUIpkXQxs
	Gux7O6Kc6O4JtoWrpH8FViR/6NFUeAPNTGus+HIt8SKwGJQKz9Qsi7GWVc+4TjO1lk51POGTYMf
	LTW76DD6QYx90LQD4KtPEKGbwAOdYPZq0QeY/0B05sTYXk2c/xnoMgT5xTmHnTrPiTkyGSl3bXi
	bA6yGLsEAfy7NA=
X-Received: by 2002:a05:6820:180a:b0:67e:2905:83d2 with SMTP id 006d021491bc7-69462e3a8ffmr10404925eaf.21.1776779895258;
        Tue, 21 Apr 2026 06:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694984114f5sm1229359eaf.7.2026.04.21.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:58:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <2f3cea363b04649755e3b6bb9ab66485a95936d5.1776760901.git.asml.silence@gmail.com>
References: <2f3cea363b04649755e3b6bb9ab66485a95936d5.1776760901.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: warn on freelist violations
Message-Id: <177677989410.583761.7747351578414743363.b4-ty@b4>
Date: Tue, 21 Apr 2026 07:58:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280137-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5435B43BB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 21 Apr 2026 09:45:29 +0100, Pavel Begunkov wrote:
> The freelist is appropriately sized to always be able to take a free
> niov, but let's be more defensive and check the invariant with a
> warning. That should help to catch any double-free issues.

Applied, thanks!

[1/1] io_uring/zcrx: warn on freelist violations
      commit: 04756ab59ac4eaf2a4f807cca8f4dde859bc02d9

Best regards,
-- 
Jens Axboe




