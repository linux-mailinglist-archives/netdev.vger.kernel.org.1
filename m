Return-Path: <netdev+bounces-176280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE7A699B6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A451887CD7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344EC20AF62;
	Wed, 19 Mar 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8r30kjT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80D18FDAF
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413715; cv=none; b=Ll4IRWj3DbyNEGQ2GKYQ4ssMH6wa700zK4PKQbDzHwcI348wZ2aFii3lMU9t4wetaThQ7SCPTKbMmJTrg2uWryjpJW96kMpsVFdNt4LkFPIu0TSOs+53zju2F0ixy7fFAWporDJ3T8yamL/ZE9WAG48I5ql7pTBstvrNbcV7+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413715; c=relaxed/simple;
	bh=BLDKQdbpNYDW6IGLkGH/hrgaXJgs14nnBVaIssBihrA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WJK6j0vJWtfNelN95dlFnApMiKMmuHAGxEsJyuskyJsBfuSi1K72ZF0v6WKVUcWaJfCdj+a3ifipQ65yIDPilWQJ3bhMhWzwGZ59+weyT4aJaH1lwgzL6XBrT/eFQCuKo9qIS2eL5yo6Izm+S80mUv3z8lSyHucloF9BXdXFhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8r30kjT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fe5e0a80so601241cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742413712; x=1743018512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5QSZ9nHTtWNGOMKfkz9T1LY+MnYeD1HP5JGKgXrC9k=;
        b=a8r30kjTrppFFIO1ZvRg4sdzeHGG5l6ECFwNI28wwYlLPCEC1ZLC2i1Ssbx9CDC7fp
         9+kyzcukHhTom3z5JeskLX90myqENcsjdi/8rtLG++ldgyFOs1ELiAnO3DLtIbo38+D5
         AYgk0cb0E0MQIBlqvnjIcO/ZjegtSf2mYkqZTiQwBbKD1G0Iy88p6+Ca1cdzLUWWk3Ya
         Ax4+1kkvP4HSgRqtw4oUTPIuF/+X+1fAHnCiKRIzGlXlbRwjY0qA5aEZ6OWyk/nHCjxn
         NJ8gA0h/NZviV/M6Gs05BrvBpxiaKt6pLowyncMUwHwAOaZx5SvaZ1IuxZ2TgKBbC0cd
         W0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413712; x=1743018512;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5QSZ9nHTtWNGOMKfkz9T1LY+MnYeD1HP5JGKgXrC9k=;
        b=nW47mEnbtB4Fj6/tY1rDNtjna+XQMsgMoblNArR0h52avlrZEZKKtookop8k69uP0+
         PYM04jUldPKgHXSPimbtWGtr57zVQZ3dEkUhkIxDfyDxdhsLtmwpxcr7Hshi1ZzRBhm0
         ydepNz528/Zh/JZ5z8f9zW9C79toMHNmoQ2RT0+1J1+VEdyER8FCUKAifbyYsS3Yj1aT
         Do5JQyikiVVqnjhNPeZdCc8etbnat3cC/jhxCdJC+9vzOGWQW0tuT/8RNaHUZAcxcN8Q
         vhSAJZ4PNXzWLBFa8k9JRkqnvujF2zbjFnqA1gf1LDkUIWmrQpmGfmV2eYoPo94TM6aP
         AChg==
X-Forwarded-Encrypted: i=1; AJvYcCURkz9TBQTeSaFRywVXGkJ3hVWjemN0sNYEmHr0pEyBQJ4cd1don2wH78QhnkA/H8Ff0S84oag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMFDUK0Dcl3nfolRM5n9pVV8SvpHu3sORFGuKSqV9J/59ef6t
	7Qae6E4HWbkx6qEEVFh/ceBNbbxSV/e66O0sLvygt6k/8BxRdiUJ
X-Gm-Gg: ASbGncsE0/2XXT6Qd1GuTdJd9TieJeeH4Tr40XoYvZod5QyC81PV0AimBRkl4sBfZRs
	dag+iYOjHW0jUd8q0Dkbu78XfMZHyIU6NuUJ1uiJSup5DMiMJl9nN5/0XaFzPllbzxINCWhawqv
	lJd53szgj72r9knJXRs9pfBVrT+1xt4Podu3YmsIMtDWfglvU2o1I/qTR6ht0ZTLKwvExkq/MGh
	vhH6aADVJ87e9EXSiYoJ8s3EimnGzYW/LTXjSnVo/pXHSVwXDY18FgaPTcG7wkwvWNg0sugSMem
	B6IBM2rreNGqMfAKauQcfBdOK8BlzvyqRM01TW8nE2TC/y60HZuUcmlfEn6iyWNVBLYSxo376Fz
	pmSNeznfZ8dDHocWHVfXj2w==
X-Google-Smtp-Source: AGHT+IFfLubXrxasbaPNkDiU7ay340aWHUf3USRGQyY1Pf4gvExVVI60BRr0qlgZpo4TyJnacp2wdg==
X-Received: by 2002:a05:622a:598f:b0:476:8595:fa09 with SMTP id d75a77b69052e-47708378529mr60643091cf.40.1742413712452;
        Wed, 19 Mar 2025 12:48:32 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60aac8sm83028341cf.15.2025.03.19.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:48:31 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:48:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <67db1f8f1e49c_2a13f2941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250319181821.17223-1-kuniyu@amazon.com>
References: <67db03aba87a1_1367b29420@willemb.c.googlers.com.notmuch>
 <20250319181821.17223-1-kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 2/4] af_unix: Move internal definitions to
 net/unix/.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Wed, 19 Mar 2025 13:49:31 -0400
> > Kuniyuki Iwashima wrote:
> > > net/af_unix.h is included by core and some LSMs, but most definitions
> > > need not be.
> > > 
> > > Let's move struct unix_{vertex,edge} to net/unix/garbage.c and other
> > > definitions to net/unix/af_unix.h.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > One trade-off with these kinds of refactors is that it adds an
> > indirection in git history: a git blame on a line no longer points to
> > the relevant commit.
> 
> Right, and git has a useful option for that.
> 
> 
> > 
> > Whether the trade-off is worth it is subjective, your call. Just
> > making it explicit.
> > 
> > I still manually check out pre UDP/UDPLite split often to go back in
> > udp history, for instance.
> 
> I often use -C5 (track 5 times for line/file moves) and hope this
> helps you :)
> 
> $ git blame -C1 net/unix/af_unix.h 
> Blaming lines: 100% (75/75), done.
> b24413180f5600 include/net/af_unix.h               (Greg Kroah-Hartman       2017-11-01 15:07:57 +0100  1) /* SPDX-License-Identifier: GPL-2.0 */
> d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  2) #ifndef __AF_UNIX_H
> d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  3) #define __AF_UNIX_H
> d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  4) 
> cae9910e73446c net/unix/diag.c                     (Felipe Gasper            2019-05-20 19:43:51 -0500  5) #include <linux/uidgid.h>
> ^1da177e4c3f41 include/net/af_unix.h               (Linus Torvalds           2005-04-16 15:20:36 -0700  6) 

Thanks! I can't believe I did not know about this. That
certainly mitigates the busywork around refactoring a bit.



