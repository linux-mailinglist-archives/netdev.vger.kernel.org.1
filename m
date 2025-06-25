Return-Path: <netdev+bounces-201042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716EAE7E8A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEDD1895634
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF882BD03E;
	Wed, 25 Jun 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evrb+liZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0229ACDD
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845982; cv=none; b=UpJRzxwYYc40Kcm9CDzgqOaxiL51YBPAFfUlKFQ9z6SKS2QlB7mg1LCnWHEIR9rUkFVE7IQS8SMUnAfBF969jHyuD9Y6K2QBahKaTK5hkPWLulb5XTIYpiornU4zWEMZDE8A1sE1gwIII0d4lTLE3j0fytr7zriKk9LR6KKmaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845982; c=relaxed/simple;
	bh=AMPOq99F3Kt1bA7Ez7lGcZLg8OnGJnn6TVYDJzFcdCE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ggPUbH7nFqixiAywpjlVkJzUHSWpkVl476EWqCKPfkMtDl6LnTBtTYOS3pqwV3wF0V4/A3zfYHNoG7lRjkGlgEnuvWmF8JTMz5fq5y18I4+yMTkr0lZFfqLTijekzY6K2F5n5zhP3UxZxVSJZ2U5F0DD5YbIHRIRvPneCB2fMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evrb+liZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so8147895e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845977; x=1751450777; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMPOq99F3Kt1bA7Ez7lGcZLg8OnGJnn6TVYDJzFcdCE=;
        b=Evrb+liZCAwA5hxtlCembfcN4U7WCk3eC38x3dfhkbfda4uUGPEgaD3iC5TVajgFcE
         jSVdJDpngH6KkHN47vWdPOptOxgXPhcAM15D+cfu9oaBQAz1O4eJ0EWa99rmPkX2ksua
         iDs0MkPSLr8m//kJ5MiKcDN/YrD1bT3DnB1niO5c9Q/VWMqmTYtZP4GMq/DBAurE2Cax
         Of6KoqDeA2uEh94wIBKPBPdU7oLiLL5GTk0Y4XAWeUYes7BjsOO1KNC9PHvU+oatZ8Xc
         fEQKHywVQSvOkgv6Dpl7lleZ/82L26uVc833aCMQcBwqfGl143Zz5YPR/QbT8whADa60
         mG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845977; x=1751450777;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMPOq99F3Kt1bA7Ez7lGcZLg8OnGJnn6TVYDJzFcdCE=;
        b=qNSetThksZQuL0q9A310XnsOJ6VXFLKba/QuEq8qqP1Z7OYoBgn30PICjwV+pZmDwC
         q31lwAckUrfq7dqQf5aQMNCT/juf219srUOlQFUN6rP8zMGAtgIvMtQrcINldGUJtZgO
         bIiiWRKaBHGXuDawvAqNfuL8g8Usi8E5q9L1uwJoVrnDiJo35qLd4/ZKosTSK7GhHX9z
         gTfCE9wkxngP0vzSQv5HD2dX6CR1JCerfL7DSEChqYZd9ijOJSKTaejhev3WNUiMscr4
         hc8Rl5luqAYkw8NbLBW2TTobnyYPVNl0xrBe3HiJgpoUJc73cqPfPYKohAXwcQtpZK+B
         sSXA==
X-Forwarded-Encrypted: i=1; AJvYcCUSqQyywPO+8Wi3vDHq/cxvxOavYISKLsCv78i2GAERTSBwiiEVl+BD1JPHXsYgvj/O2A7N7Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCJGIk6jt6cTcvzMp1CyZ5IVIYGQJBpoHQpwy1dew4G6TAC3H
	6Z/yRCTGTTvpLnm+FTP/O8lZZPvcFthAX8DelUetkHwV1Su4w1yAqKg8
X-Gm-Gg: ASbGncsvf+X0Gq9RceX65OgiHmjowbrZhItmOUN8Ie/4fQNS16oZ4ouO4/qNQtq6sfm
	ZVFviEGyho1zJP5budjLYxtSgXn+37NSfrDq9IEvago35dbSX3Esq4hkAlEVchp9180aDuRepfX
	x5EyH30+8OU3oXyj/nbLgDfwtxUbV7UkQ/M7wPjxkv9G6MIygJtMRuc7PQ0pl2ZH+8p3qlqZbnk
	W6Eile/XEhkBwxX76610pVQxe+Sr4H5B144QTngmai1u2mAgCKabuohY/lNejEFgjiONAMQN1xm
	L+99+K756uq9FIGeubRdvHe/bjjSsh6tlqdDrYu3TvDH+wKAsd82zPfu9Dg5m3QL4JwA0Gkt3Hc
	PHb3PkOKwQg==
X-Google-Smtp-Source: AGHT+IEkbOLuQrdO5ygXW5N2lFlkNMDfVJql/tjj5AkdaZ5Fxhyj+RFwSFBlQ0pV1fyp6d1E2kZGvA==
X-Received: by 2002:a05:600c:1c95:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45381aafecemr23655345e9.9.1750845976895;
        Wed, 25 Jun 2025 03:06:16 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f22c7sm4208848f8f.53.2025.06.25.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:16 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  ast@fiberby.net
Subject: Re: [PATCH net 09/10] netlink: specs: tc: replace underscores with
 dashes in names
In-Reply-To: <20250624211002.3475021-10-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:54:52 +0100
Message-ID: <m2plesb0yb.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-10-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: a1bcfde83669 ("doc/netlink/specs: Add a spec for tc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

