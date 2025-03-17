Return-Path: <netdev+bounces-175417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3252A65B5E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40BE17DC52
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68D81AF0C1;
	Mon, 17 Mar 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIRDLMr5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6B165EFC;
	Mon, 17 Mar 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233597; cv=none; b=jX8XR1RPDQyccaZoxzzt/eBTWKNXgruPOvBxj2Ky+ZnIbeBhk+FjUlpmWVwpmMUqfI5z83WY6OTIijl0dUNyeKAOspK7dsIVqHrzRvyC48sny1aZMebI5MHC4TeFVowC43vFUoJtt1qnvupACzM6rfqqITRUhpuS6UUEfCU8Fns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233597; c=relaxed/simple;
	bh=3w54rrT0XKa7mePn43Dqw7SU/w+2DiXmoRrOcz+b9U8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S74ty0Y29H5gBNJmfzm0WssjzWq/G5fqBuI3+zEBayrBQoQyA5swBsP2FXq6wbwIwr7Hu2TALvG0YqusQof+N9mIxsC4+wHjJyXQPVJDHK6PIZpXnFcIrRZB+dAW9/2eWvfOqLYylT/x5odYuupgJk5vrkr4qXfE/xWISfjKobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIRDLMr5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e90b8d4686so38996906d6.2;
        Mon, 17 Mar 2025 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233594; x=1742838394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0GCrUm/aSPyWDEWnbUiPadV5q2YuvnsVXl7Ccjn1OM=;
        b=AIRDLMr53CngtA/rEo3IfLM2hdwntUCEnduRiIlqwwmO579PllLEc2CHZ9D983QVo0
         od46M16pId6AZjWlaQoRccx4ufsZXa9EOpEDCWGZjq3SXWwU3NZzVakkslfyrVM423z2
         VDGLfzh7K+EllEiAUxAxfdR2VFdQzQlyDvfEmqJ5ls4axAioHfofxKzmYx1dH2tVdkUs
         NlOYwvI7msr67A7J3bQpPzDJvgNAVtVR5tey5P+OYCao11N4vLa77UBUf5QmPQ6AgnWZ
         BnFoBIVcyVzumj4cxPv4QmowGM3Qa514aF4pF3uaORFm+K03o71fEgP4JfnWjHVEwacG
         U/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233594; x=1742838394;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0GCrUm/aSPyWDEWnbUiPadV5q2YuvnsVXl7Ccjn1OM=;
        b=PFH8BRIC8iP6w6zsD9StlYLMivkaJ/FcUzXPSuwJrwPduy96VO8PmEATh8G/thsiWi
         /t9iewYet2zOpq5EmV7ar/5xX+EdDupD69WIjrUzqEGLBYQH3QselCVwFwt/JO38cefK
         H0H9XZrfThVZE7dNTgaq0rCE1NcDXOUp9m4ch92BKZ1kAD++L9oGFwYSRN9Q9Lu5Hsfo
         ny7/2sJb7Owjcm50amM8Lf1C91LdI9XiSO8IemR2jC3dQRteykEioG2hcf1QLMPDKHyS
         PXapvVUHFvA2fN6GIMCjmg6VO9rbI1R91TSPh6/jg+SGXkAA8E/+AZXEvGhdL/ySaG9p
         Y1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCX3iPvCnqcDBUE1UmUqf6XK/u1FyHfHbtx5Y2PmaHhuvMqlfsgY6jr2MuHWSvm91NGGpJalpNX3@vger.kernel.org, AJvYcCXD1y2TGHaVAZIW1WBU23QojB3l6SgXDOiDUrMvDbN84ZYttejFzWY3oeWzw5m9UfmuCO8DMnmtYg8xyrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPmnZSU3Sp2brCiJYmDwA/VwSPCvGVkN02ywP8ChJQTYTzqV7
	1pAZHEEMabiyjmNJW0aHJaO2PjhrZYhieWVxyMq5Isl76idd/diXeb1Kjg==
X-Gm-Gg: ASbGncsrmXTrCLJuQW+ND88+dbGQEM7n83c2FXAHtjipUtgjxOmYzzSFWYBwbQfgJDR
	3z25ARpjDfIuxP7cWHR4Wm79VWGWZ/kmLzmmrv0iY10XG8hf9GovwQUhTnePrpDD8YlalcCNssY
	fvWDr8LUyZGJmQBGlIf5rz/F9Aohthl6UMDGJ5hdVANJFzBK32mkizpLGrqacmSVRVlliuewxD1
	qFOOqj7YZah0JjvowR8MTZsPUiUnvPpSz7+Hz0VHEUG++YskClpO6clmfTW1J9FtLfAUdtvg77C
	5p9MOehTlh7C711yUg5ayGgeQVkuvNx+Ad9tvodp8Y30GRI6zfIZ72FWX9wlbgumb0NYPsbG9sF
	qJ5iXUsawtE4f1YDKFclXKw==
X-Google-Smtp-Source: AGHT+IEZ8ez8ucF+VqjIDPLmMMP6yS4Ntls80LfV30fgk9nmK0SlrdMn7fQNQq2tLqtCx3pRcGIgHg==
X-Received: by 2002:ad4:5c4c:0:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6eaea9f4500mr211005816d6.3.1742233593796;
        Mon, 17 Mar 2025 10:46:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea1dsm57176006d6.65.2025.03.17.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:46:32 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:46:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <67d85ff870c78_32b5242949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH net] tools headers: Sync uapi/asm-generic/socket.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Mikhalitsyn wrote:
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> 
> Accidentally found while working on another patchset.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Link: https://lore.kernel.org/netdev/20250314195257.34854-1-kuniyu@amazon.com/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

