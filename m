Return-Path: <netdev+bounces-106865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E90917E34
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AB1F241DF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217F178387;
	Wed, 26 Jun 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKQ1aPg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169217C7B5
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397796; cv=none; b=bynK9E2GP65okIS2ZwxQpTHjTGZdSdYwFXS0mpBHZ4Sfy6ObIPUOYIY1O/2gSQYkwKVzhMtUlqoX363y0WUR3F2g8KRu5PGW5dIyep5q+uu/eyOkKgKmaJ1rR0LA6vwa7RcGh3kSr3B2D4hIoUUVwOrKbq5s+ukD5PXyXU2+dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397796; c=relaxed/simple;
	bh=wjekB8m8ChF5kx9Qk41htDn493BMVTB5wxKrSJ1lWY0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jnzgWqgrpsXHziX5xI+RUBBmgEdjg3GyNhenesk+xlgOPBciqBo6fuhk7zzOYElSE6HTcB4cm1it3BviezRLG0pvcRhMbVyFbLjQGV8ixKngRnpMZtWfIJRHZkX2gULPSrYWGlYsfbSGG1wvbbUlCEb/p5t/wjg3cNHF3jlLkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKQ1aPg1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55ec570a7so629928b6e.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719397794; x=1720002594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtNgr7+Wm4izg88av2ITird9BbE8D8DL//9+Wd2VuhA=;
        b=FKQ1aPg1JuMHdy+mEiwLi+HEQbAwo6Ow003TAxhh1KAocp+N06p5hYSpt4u5rOFXrC
         hrjryx0EJ1A7nlCsipp78mTJcBEKrIZ72FnY98n1ykSqq0d1laRZ4FEUoAnDgozrpzf4
         lciR+bXJAj9XGuuF+qxstq/YfqKYZw/OS6hKS6boXG2btw3titzGLxwi17ryizmDOKt0
         OlKz8jWuS0uTk47sXZ8WCxC84b1XmhHFiQXMl8MaBnVySiW3V/o4TLlp9zIwvKKSQeBj
         jEueARL1x3DqP2UjyhH1RZ6eC8g+yS3Dzk5w9+Vu5FWRRdsHVx2/Bps3t4n4Zj+L6y/C
         gnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719397794; x=1720002594;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NtNgr7+Wm4izg88av2ITird9BbE8D8DL//9+Wd2VuhA=;
        b=TyJUDZsCmP3sUz62vRiDDRj00uAQpJqfRmblzY+j4XEJkLlHQmViHG8+fUMf3gB5+Z
         dZtHT+Paj1oeLIESolkeI7JgdBkuh9TxqE0UCFsAhLbzOOfBFNLIsCZjWKTwcRXJalHJ
         OstKD2hegX6klGrZRZuxXpz9WcLGIaFfeB0cc7llvYXQLkuZZTSSOG2CpFjOqCOKwMm/
         oir5rN1XybNtu3kh93ux5X3CGyK8eilg2tss0q9pEQtKO0Cfv5HyBHLF9/FPniTxGoKJ
         dqnXIzL+ceTJz/LbQYlZEcSyrOfrkxSkbRTUve97VhCY/xAShAL2Qd+WMlCJLiebPQ1a
         U8lQ==
X-Gm-Message-State: AOJu0YwEoawbzQddO/xUJW7zigsvc9VcmE0ryvyIpBNG2BX++TQlr9Sm
	UyUAYwrb7Ss4J3EhgtnPbbM2EB4goe3Q0foBl0z0F7amx0z7EHxE
X-Google-Smtp-Source: AGHT+IFbtStdSwLBF161wEFPCu6mgTVWqRN3nKUAdJ/qtloFS28ecwl4grcWcDkuMgwlo1OlwBnAmw==
X-Received: by 2002:a05:6808:220c:b0:3d2:464e:538b with SMTP id 5614622812f47-3d543a7c16bmr11493182b6e.7.1719397793970;
        Wed, 26 Jun 2024 03:29:53 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d54be835dsm22359885a.43.2024.06.26.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:29:53 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:29:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 leitao@debian.org, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667beda1654c2_3cd03a29467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626012456.2326192-4-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: add ability to wait
 for at least N packets to load gen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Teach the load generator how to wait for at least given number
> of packets to be received. This will be useful for filtering
> where we'll want to send a non-trivial number of packets and
> make sure they landed in right queues.
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

