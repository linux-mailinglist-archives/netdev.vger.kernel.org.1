Return-Path: <netdev+bounces-217161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADFB37A3E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C8201D5B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EDC2D0C62;
	Wed, 27 Aug 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnaPAuAU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632F2D2388
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275725; cv=none; b=BKdYwJGm1ci6GgZMmAstLeDVoTrkPBWjjP5pcSCyobvzkj0Qtid5laC6a7FAMxj+5GxFp0rCsnShIeiVCXRmL5XzIADgF2hHFjT0CYDKDeeCS+mTyvWK04UokkpDaeolYjVcUB0Npcs1X7OoQ9WKvsLB0ygFXmQLw0rAtQ+eiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275725; c=relaxed/simple;
	bh=qLTy5C2dGEjAw/4OL8eYtf366J2gpBTkVIFNNML1MGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB3BnBnYtdZBbyuLqUpp4LAPJ98NZAGpIkiwKEqtccdJwVYOdEGEHyK8+C0YyHVQrQx2dR1Ev/kDWRBtPLyzH4notE//FBZkLeQtXJB7OknByBQjlRWeMKzDu3QI05PSVtaPtxUfJj86/bjkoN4Z+RNDU0HdHBBqZUDCiHjSUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnaPAuAU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c53892a56so55946a12.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756275722; x=1756880522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLTy5C2dGEjAw/4OL8eYtf366J2gpBTkVIFNNML1MGM=;
        b=rnaPAuAUU7dG9EbtS8wLKDvdzUkCMryBoAUVjWpvkdvraK9lsEx83LBZ4DI/o/JCWI
         5r54Pf2JTFRxsltTsGW87mqqpxwUuplt07gabqk3ipsnzzPrr9spIRa84Blx8XMIg8Bm
         YMwRJfIMA2f+dRGhEJfZibvjIW8XoKCeyr26nxbKfjwWIMNGqzdg45OtqSg6l+W9m4RW
         78tYu12mPTkIhKnuEF2KaXWkEhrhkJO+GSEypWZ8AMHNhSX3oQNB2BnuVgRctPpG44tz
         PPD9AkT5dw9hI8iMxzwhpyDOPWYty0GvE08y2GC57yXewD/+ce6hu92WJva6GeKTBmM1
         kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756275722; x=1756880522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLTy5C2dGEjAw/4OL8eYtf366J2gpBTkVIFNNML1MGM=;
        b=QiQDElmCel/pnmIYfL6iwH7PrjLsYy6h6nqeZHx5NDLRs3bgM6kutLsHLPGJbLCnVH
         Uc+9/H+Ncfv1KVd9yDNrMNO1TSUDu6G4aZsUNTTVUFkCoSotXChE74MKtYsk3fjKcJWy
         doqu1WlN+dao7OZjKwixegDXQP9OzT73tVq8iYjjlBvQg9QE9xwhxywQF1bA4/SpbJ12
         IMeWi1Hv68X9lwTxlj8ne9hxigPRamgi9FynEbELUf3fXm/Lrd6ymcViLCATYVjj8a9I
         s0hxs0EDueiHJmM4MiIvIDoPM/mv2QILneoFinRIf6A+afUR2q55jnNUxB8VGNykUImM
         A7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQbIqVjPhNv0eAD1CJwC7Z8GxDEpvTkMKalQeGehhSGzkH0+kRfDces6ruc8MaV66zrHNdkmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtQDjpYH7XT7jfh1+UYwdLxwIa/0b21Jifrmj8vFQPArOy5pt
	VYHkXPggQqZ8IpTfdfXZCcas7lKM29K6c8S08jbnCWth011ov2Frd3DWd8ASBNYzQ5rjEFZ6MWw
	SCXuYpaEWaxkFhhipRaRrAUCCNl6GcryjEg2HQL1A
X-Gm-Gg: ASbGncssUdu4kcnw8qrava6kVBvM9flnHziFH7vdiRn5hQDlZPftlRESPSNZdviq/eo
	Jz+QFPBJgqQA60W80beDDbIpIUGzYmzVqy/evI86+AHui1YIH1Y7UU8V6bfVt/9wX/jIBYT8E4x
	TPfzxZUbQBr2i8kKa07j4cRd2CMY7DLTuaOWOVeOGzlBWokb7hdBLI+4EkiWfgRadK1CRaQB4le
	ty7a9bGCkZjr1zyVZonb4cpqVQAU/tT00gX5GRwnE5jiMlKY8f/8ZRn0Lz6Kbf//H1rJIv869A2
	ylY=
X-Google-Smtp-Source: AGHT+IF7jzGKwhBs3pL9OuYd7gtObX8p++nn1QWf6ESVamZva6AHRWA5C4h1KdRnHeraZ0FOsbdKT9twMzVlH+RX+Z4=
X-Received: by 2002:a17:902:dad1:b0:246:2eb1:9c09 with SMTP id
 d9443c01a7336-2462efad608mr216159465ad.52.1756275721423; Tue, 26 Aug 2025
 23:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823085857.47674-1-takamitz@amazon.co.jp> <20250823085857.47674-2-takamitz@amazon.co.jp>
In-Reply-To: <20250823085857.47674-2-takamitz@amazon.co.jp>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 23:21:50 -0700
X-Gm-Features: Ac12FXxGlXiuIICtDl2pUKJYc29VkTGFl6RVAVQ5m9yhCpp_rN0yUWRt5x0jzhQ
Message-ID: <CAAVpQUBhyRevCUqAjLYEFFqfDTZT42KHUEjRpARbNzn3V_cYbQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/3] net: rose: split remove and free operations in rose_remove_neigh()
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kohei Enju <enjuk@amazon.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 2:00=E2=80=AFAM Takamitsu Iwai <takamitz@amazon.co.=
jp> wrote:
>
> The current rose_remove_neigh() performs two distinct operations:
> 1. Removes rose_neigh from rose_neigh_list
> 2. Frees the rose_neigh structure
>
> Split these operations into separate functions to improve maintainability
> and prepare for upcoming refcount_t conversion. The timer cleanup remains
> in rose_remove_neigh() because free operations can be called from timer
> itself.
>
> This patch introduce rose_neigh_put() to handle the freeing of rose_neigh
> structures and modify rose_remove_neigh() to handle removal only.
>
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

