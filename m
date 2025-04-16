Return-Path: <netdev+bounces-183335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0988A906A9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741733B51E2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA91DF742;
	Wed, 16 Apr 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KcHTWwBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959AB1B424E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814366; cv=none; b=OQ4BrD5uKTUDmt3pYCGX8Q/dzNNurY0/p6gkhbQDy6OG4Zh3eG4yjv5QUA9uQgd1E8ssTT3g5CdDL8xPq4MUtWB73zn++jez04fsjoGBrgBaLeWbXBnz5on/9qk8GmrOFsgg6g4DiQx4CnQA5NThpgR2SSzUvDnQ9hHc9hG+yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814366; c=relaxed/simple;
	bh=WJh08LV0qm9kWN3Cy8GN+GIMh022q74+V0HiLsKm2U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBx8sytzys9myM7WqgDb3wbzdI/VAixYqhJ5b+CH7nzZcD4fPtjtAEKYVjViJBs5CTDaQMlgdIw5fSUxs+4WLJDScaPJUrykLBeCsOFwcNNjhUA8Q58QWtGhqUCE2HMWVXvWSSrIX5NtrDLPwYokpnnP6mmSpe7afxoI+Ha0GeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KcHTWwBQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54d42884842so2463366e87.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744814362; x=1745419162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJh08LV0qm9kWN3Cy8GN+GIMh022q74+V0HiLsKm2U0=;
        b=KcHTWwBQ/QEZ+1HJGV5+C+i5bs53PKCPutkjNRDFISs021x2In+wDuCRecFCfJKWJ4
         JlhQgiyCbbccipzIk6LKdyVYvh5cE+LrGOS/x9qCOOHjZOs31NrsXVSJNu2ENNxWGhL+
         DxOqjrI4NR4pBiOboBrauzSXES6NqUoQQ9DP0eY4n3H5ifBw4Zp9ZwGz0skvYuldlaxK
         awaZ7gvX5Hu9JnclagjjsBimhjmosbOd6PjrJ+1Fi20/ohNJa3fzlJHz6/j24h/btpCk
         U37PNZUGbQroYzuC2KKC8JCynb8ecoySdvfbcWtAOiMVEbIiv23k8ZEeUyY1YjVNgCjF
         bdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814362; x=1745419162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJh08LV0qm9kWN3Cy8GN+GIMh022q74+V0HiLsKm2U0=;
        b=LOgiKIeSaQyr7T2isQo2T4f5KmSLNnT6SLj4eUho+il40qnjfrsc5jDOfZmjyzlD/r
         sz/kyUYl88Ol8MAyXDtW1vDSa/M8oPLxUkLkRM3MoECBndtZxs9pAxkcc9zykfS91VtZ
         AR7bhbGz6ZRA/v9puo5C4INy+9giup7N7nIktrpTupOvHxvz7ftmv3adKZPOpIxzMr5U
         iMGOkJivXXqqOrKHkkYX/kVxQ/ErALPjRE0Gt4eFjrSxPipdVdcQ4LcIX2lPUO5U6Q2B
         gT2DMT/Z2W/fKg6AB6Fjaloshid4IzaluvYBxPiAdoqhOjTnujVEKqEZkCqvSRI9mnci
         Z6cQ==
X-Gm-Message-State: AOJu0YyXyp52KLuruqySTWAlbl5rNkGx4C3cHYOYsDjAgcReL+09ciFm
	ulV83aGNPSJPpzOSazTUICCyx2LQAHJLQcXPLv44tJUUvwnwo1qRWdXDTNV9gSqyKJHHPCIA7SK
	kN1oFajY6UI9Tm11LO4JkpGI2YzBx9gb4mqBOvg==
X-Gm-Gg: ASbGncuVPfsJxcWUYd0/3x/fC7sx2sqUOgBOAkHh7JjkXpp95114C58E2Sslq5J+eXH
	1FPp9KiZnbdBjU0QuAYD2TKOPxAtU9GRRC7B8nHQF4bwexhtLq0JbuTTYZ4bWftQPxAXuxL3Me6
	75sFnihSSPZMasrJAxH1+7jJk=
X-Google-Smtp-Source: AGHT+IGDhggCqZR/wfD4G5vG6m+nROXkABaFtZ8N2L4HFJmQF+uI4OPt6JGbpnVdmtFqXAuC1aBfqXwwkcNfFZ7YNY4=
X-Received: by 2002:a05:6512:224d:b0:549:8f4a:6baa with SMTP id
 2adb3069b0e04-54d64ab0b3amr627152e87.27.1744814362592; Wed, 16 Apr 2025
 07:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP1cthn5mm3H7Gi46yNrvzRD-mbbjzQWLUFiBeKbzo6x27uUTg@mail.gmail.com>
 <20250416024329.43870-1-kuniyu@amazon.com>
In-Reply-To: <20250416024329.43870-1-kuniyu@amazon.com>
From: Jacob Melander <jmelander@purestorage.com>
Date: Wed, 16 Apr 2025 16:39:00 +0200
X-Gm-Features: ATxdqUGwQVuQKxYwEYrY6ZFRs62tqxdRaumnWgjIGWimEkmfdsqTmVPF2P8qsuM
Message-ID: <CAP1cthk3YfwAqT=4p++==b=nN7hsJ9WS95FiaGdP=t7TKtU4NQ@mail.gmail.com>
Subject: Re: [BUG] permanently hung TCP connection when using tcp_shrink_window
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

> Could you try 6.6.87 and the latest net-next.git ?
> Also, could you provide a packetdrill test ?
I've not worked with packetdrill before, so will need some time to get
acquainted with it. I'll try nonetheless. That's probably my easiest
avenue for testing on a 6.6.87/net-next kernel as well.

- Jacob

