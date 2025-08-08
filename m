Return-Path: <netdev+bounces-212160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC33B1E7A6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE223ABA77
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3058274B26;
	Fri,  8 Aug 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ1bHPb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272626E16E
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653637; cv=none; b=fMI2CW89RivyAjBGf/1JbqekVlH2UtyHwiWbAflwC1KgEAWu996MORY7d1Zk15C9szbm1Bf5qnMQ19HYptvMC6vjSKSbkIIV0wigcp2TenLOEWcoLr2ArNm0goMMwtlOuqj7cyvJk0BxACxPuLYiPtNZpitMcoP+tJkRxBWI38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653637; c=relaxed/simple;
	bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUMPcI2X9h9WloPk1B/nLPjFLPbWEBU3Lq3NNuEvcsUTgUkpjECTwB9/6Dn2E+LYpbwH9OQy1NEGAd4q6E1kuU4uWU6MK5sITVS1v4Up0xzIkniktm7wyh4aIanYGAwObjg+4P3FnDSZVEnj7FrjpPooyXHWDxJc9UavgCThbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ1bHPb6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b09db20abbso14569391cf.0
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754653635; x=1755258435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
        b=UJ1bHPb6UzL9EriM7f3kInw0RqOOVTi4Y3qSx/mDqD03MFkcv6NTXrF45U39VGPlNb
         mJp0JuFSYq2fYXNU7fZsWNgWasu1tuokZH8QQYgxX1lWsOZHIrxoNEUSNLHRLhPx5tEZ
         LVcMezNcrYZCgZFItxw9YdE2d5V3e82C1EVBLSR0MzoFvGsbBdlcjTYBaIa8oQ2m4Zo7
         0rST969nCOR6Ik3Ikc/uijvnxIn9lPQPFBww1lqSJ9wwjV6ttcrAJh43MmDIXx9Q1lW4
         j0Io/yMvJ1ArvEIsCgYxXVQkTGfA4gruVoSAiTLfWDt6pYkO8p4V9wGZ7KqOFdcujEUc
         +rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653635; x=1755258435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
        b=ZkAkcuDb/SDNbdi4MtZBuIyYWx6IA+OdYS/xsdQx7yF4n0jWyiUAq0NovX/Bj5DZQ+
         6sNCuCSVPL3mULUrdAysbWQa4zyMACc0u3HvgTilmStihrR0XV/KX4cDLqebQHU+Mfe2
         GkQ4ji2oEwXHxTXU9ZBWypyY1B1pxZ1wNaLjlQyko7NPgFt6NGtVGWCuyK/1kS6M53+C
         TqjHjt7L2ddNfU5rUHi5Be3B/9WaE22WO8N23yCduBipzmU86KMyimpMzFI2MhpVzWFX
         ia7OyGCwurWH3WCHzUohG2Yhbo4ofFXZujqecAoNT+pPCmGZAEfDNOuN1YHL4kJhu8EE
         3BSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJgbwgs5j5ib9dM1RkVI6mSYT/n4gWS4diZJTN0/fnozIvxLgVCCV6FzWlPfsMANecyy5d4UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4FGXMHK6IFpTPeOBhclO6gXoRvne7Po0GVWDZcdJO6fYADJ0G
	ZfqA9VTsHkkEWnuBhjIdWzzSrAVNsvch5FOJH2BtXgvoJd6WtELoOfeGTTTKwCQF0TLXRqmxyTG
	TqYLqkzJjEGzmuerWrXGP2FIkvrB8Yj4c24XSuheJ
X-Gm-Gg: ASbGncvqK2EV6Tnb9obr8x0iI3g0fyKXAAEmWPR+FQO8AF0Td8xvQVGdEu121vZyrWv
	hWqqPYtWOBoiCgu77c1XCnJlU3LxqLA8Pc92vS3cXXHSENdEFFpoyjgz42GaX7KhGwQaeyUnXvv
	80KlFdEkB5xTXJyjd25dJd/PgAz87pxC6s+dkNQjdEXKDR4zja3lrDBcT3bpcTYSZ4dzDKd8/Ff
	LnnXEXZuSWA7a8=
X-Google-Smtp-Source: AGHT+IGr8F1RGtQSW2Vtwz/Msi7bNt9IV8AE+f7GDLRdZpYIcYHn2aNXfJBHn9HR8+ZFzcOq4gB+P5UPdJ6DwCKZeJM=
X-Received: by 2002:a05:622a:4107:b0:4a8:1841:42ff with SMTP id
 d75a77b69052e-4b0aed0ba6dmr30476541cf.8.1754653634882; Fri, 08 Aug 2025
 04:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
In-Reply-To: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 04:47:03 -0700
X-Gm-Features: Ac12FXwpok3ZpqBt50Y3zhETSQWUuwnkl-hL9VfDV_Of0cOBpb5spcB-yqutsTY
Message-ID: <CANn89iKEXJHxrpCLT=DNJ6W3pXO0L7s193b-a-+uWjRHeAGQpQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] ref_tracker: use %p instead of %px in debugfs
 dentry name
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:45=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
>
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debug=
fs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

