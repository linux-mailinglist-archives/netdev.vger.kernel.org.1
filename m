Return-Path: <netdev+bounces-201998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA805AEBE86
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0D57B54F4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCF2EA757;
	Fri, 27 Jun 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVFfi37T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1C2951CE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046116; cv=none; b=UYCJgBzTYkS3ZWlgJ1LlMkw2FDzByh9jyEh5qoNASG8ng3wc94jf9sMzVlqxgIene5kTmdw3mL/x25KXiKaRUTmm8qgHJl9UFo1uYlyiK8MvzbxtSSvp/rLWEc1OVJ2b0jg1tSZUndN7M5oeLIx2MOveMWpizRQNrAso3jLeZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046116; c=relaxed/simple;
	bh=PpVvprFUNu68OZuG2arnkCWYvblM9z/rQB2nOUJoHIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR2nh8yI3pjylXq/F2T/ZYzdYGnay6QZj3ZTsxQj/FyA9LAu2xzhn46o6eQI025UtpyFB46B1R7l4XzpTc748Bmvfto8rzPpW42aoqdnmyQDNwGHsWu+TmNWeVPsFZKT1rrsUeIMV6EiIDnz+Try1Qfr96ewRR7ptZRmL/U3w5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVFfi37T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1fd59851baso179475a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751046115; x=1751650915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpVvprFUNu68OZuG2arnkCWYvblM9z/rQB2nOUJoHIk=;
        b=iVFfi37TfhljkUxLpXIF72mmvUFdaUgoXyne9ynVV9eipMmC2tOZQlIsPgxZGc9nF4
         t9PYg5wnfITbDRQ8qXmsOlJbkOHPBi6q87EM5Lps/wdSVW6MBNndNbCb3EJEC1YcCKBH
         Uv9q51ZY26QcA7+/dG/fAbEyO1hG1vvD2PqqaW9vRaK9gWvRtKlbhmIKUIv5NWlgLVu7
         POlJBnOUh4traunMxciYdyzfVM8n36THI507er3fUy6bO0ivSJEyzdAqIHogyHgeLc4i
         5/Lj2QZJME3y0iWf4XVIiGG6SbPXBb29VTrJAIkDUdjXmHY1z5AViRT787g7MxlH3Emx
         BcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046115; x=1751650915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpVvprFUNu68OZuG2arnkCWYvblM9z/rQB2nOUJoHIk=;
        b=JPlyz+0NfrXvTSV5ysZEs3m+PEwL/bIVGi+ttsadtDs2ScWTOjFZwYt94VsHKs5caL
         e2DZNpwzRyqr+a2ddGhVMPZ8iEXAq8oH+IMHG4qV5HJv7NHwPpMlgIcoCJoD3Myik1n6
         pBCHQYuqMypFq41i9gLNBdBMeIdg8z/Fu6twcwWVbQDa0DN5/n/Ftsrv9TKoy5ZUycc5
         /vVRc62WBMz8frIbasTQJanKZM8uVSvQharv5tcB7icEz7/SJL30k+idQx9opQvl+MYH
         3YyQuR9ZX2CwEPE+X0FRCVIHIQx7Yqsj2BaqBq9MK33/d26lyJexn//UY0lCkeND9BKC
         UPKA==
X-Forwarded-Encrypted: i=1; AJvYcCWLSTyYWYhwKcytOQjrpxtW4B8f3gOY0d8mBTafe4Iml8uVieo27BmtywSnpN7SF9PpQ7kemxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyibjl1Ko2FHQ97qFZuuNRqrd+oTOqTr+z1DYoaQ+4gylXqPccR
	hcKvWHkv3jr31wQG+DjMc9DpPqPgqJK0leSVC9Dz3yYtiYWa5bWWMJTGcMCICHCCgR41/EpwxE4
	9yf11TIod5mZ7r1j/7tELwcc3m11uB9Vjbyik9/zC
X-Gm-Gg: ASbGnct28HIyG43xxkxvkD5wxQe+DaYZsZSgSy3RamxnQmtHuJRJCfvzkgB10kTdPXj
	zqmtOvZkGw892y7cG0neQNiPU8QlaGSsFqtIIvoRXKlPg5XDVHk6qUnRcfXwC9Cb+O9KDZC0NJF
	EVhTzKKmLRatzvHNOB50gHXzq9htKenLF8QA3mTctXmWA5GuWc5JtSkpWqClKvBFv1Onxzc+l7A
	A==
X-Google-Smtp-Source: AGHT+IHZrenQT7NgNH+Uqfqlob7YscxEGU2nFR2G91sFWWq7H6bAnHoV0FyEgHU3MH/QLRNp3oB4km5yHenI0UrJbPc=
X-Received: by 2002:a17:90b:1c09:b0:312:e445:fdd9 with SMTP id
 98e67ed59e1d1-318c922f1e5mr6128035a91.10.1751046114457; Fri, 27 Jun 2025
 10:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-3-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:41:42 -0700
X-Gm-Features: Ac12FXxtGPVlkH5OwwTxzCorXQzOgAP5JqNXwPKFa0cKYrAMFIX4HOqgX2o2nRU
Message-ID: <CAAVpQUD_c0ALWsbmVcn=geMFv+yM3pfb1OyTrRswUfzye6F7Uw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/10] net: dst: annotate data-races around dst->expires
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> (dst_entry)->expires is read and written locklessly,
> add corresponding annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

