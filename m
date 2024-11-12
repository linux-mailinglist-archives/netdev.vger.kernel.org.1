Return-Path: <netdev+bounces-143968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E447E9C4E7F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 07:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F7E1F23EA5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D21EBFFD;
	Tue, 12 Nov 2024 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inS5j3NL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E51A0AF1
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391412; cv=none; b=kGfuKF/awSJNwVTHKGxIbfmm6VbKFBun21KEwBjQgKi/ugDd9BpU9sjAH7E4KZ+l7SYUL4DfCaHBwlhKw/3xTP4tKvV9meBs74z88e6LftFRMNtXXk9A5xcAFxPDRL6dZ2/Ie1/jTaBQFJqLs3YHtmg3kgbV0guJl669NKk+Ao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391412; c=relaxed/simple;
	bh=FiFNrmU3RmqnJJgGNJZfCFm42hW+V9ebRE1DcWf0wAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhjc54soYb4I6f4jdAlfFKdBessDHrPfk1nvHjYVvv+2B54kzNuWQO9maLH0qt1RaUbxGWvWbZIeXQpHM4Pv2myA8f9F+paTH5FQsiwJBSo4nPFSXhq5DWAKhXCpZsZ+VD+Tt5wKQx2rt6Ype1wYkKRQxSW7V00LavC/9kDcsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inS5j3NL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso6710687a12.3
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 22:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731391409; x=1731996209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiFNrmU3RmqnJJgGNJZfCFm42hW+V9ebRE1DcWf0wAU=;
        b=inS5j3NL3rXedvCo44RThhYY2wNijxykJv41REaBOgLbFX/7UtW16MlOsmacSNDn4B
         EBqkgAOp1Tfn7aONOlOaLoC/LY6PYmvnE/xjZ1Bw8oKaNvGrmN4I/8pJb/1WBJeS1BEN
         e3mykLZvWCT+MDP+WB8rPbSi11+VGgxUEYZcs6en28yleJQcmCP12vboCaSUKFAZh/uQ
         KNeMpWiCBui6ca40yWTght2RFesSTZZeqm6VDJHG738gWiq7kBeiZiIhjRmmFPFL7eet
         uYCFbNydrFDoCXYG6QDSF9AIZyKi1isEiZnrDT2hfdmfw2OxIbFwHpUFJUW1328XnnnB
         SXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731391409; x=1731996209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiFNrmU3RmqnJJgGNJZfCFm42hW+V9ebRE1DcWf0wAU=;
        b=Mdl6t4zZoBDBsScKQlsRSJ8/P5f/rnSEU+HRsQ/rNVVMkZZYEpIcIv/oS940n3afle
         5MpTS5dqtvJfqHKDWM5YwJaSWw7C1+hWS6g3m44gQ24ZlNQhzfxGAgxAQJMKJtQ+wtW0
         aCf+LtRpI+KYRkrp/cse/ULh4olEN6maOc5YUXNl7H1/bUC/Il6BrKAHAgihG84DKCjB
         5xJ+V4V22uejBD12kNXFdPW6YSAYP33ViDGXXrl83222n+cDhYuRBJk/fRdScuumorUJ
         1zf15iTeO1WyaVxGfvK+pGzVXMsJBK5mXQpcYZvH0ksEXQ30eF1lHrKthlUDNSXqzDvC
         5K0g==
X-Forwarded-Encrypted: i=1; AJvYcCWnExjycDd9+HaBaPHuevvnq4CWw/erqqpvW6ipFErYeOHgzFmZHve6U3aAvEfCaGvqJQngcIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyimDUw0LLq+BG2Q+MHSvXgyrziaoqYYkUDWabL2HgJ8Gs4D+2
	Dm5PqTXD6YK3sfOoVAPr0Bx2DozyXhB5B8U0roUQFSEacQLy9WnwjWNB+9kZCRcou7A+RPSh7wf
	ePcKv9z/FcxKIqsASIBi7jBOAUjs=
X-Google-Smtp-Source: AGHT+IFhQByd6YxqF4opTR9WnZQh4unHmkcfX4FGPWMppSyC8whWAkwMcK9VrLGJ/J6zxGC2/O2jFdWt3abuIsWP/eY=
X-Received: by 2002:a05:6402:5241:b0:5ce:d53e:f27e with SMTP id
 4fb4d7f45d1cf-5cf0a26de61mr13207449a12.0.1731391409018; Mon, 11 Nov 2024
 22:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109035119.3391864-1-kuba@kernel.org> <CAMArcTW4RHWvNa-82O9D-NoqWALVuki0TpHeAn_NeT99C6+=7w@mail.gmail.com>
 <20241111105304.1d7db6d5@kernel.org>
In-Reply-To: <20241111105304.1d7db6d5@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 12 Nov 2024 15:03:17 +0900
Message-ID: <CAMArcTU7jiWgsTUY8ioqfEU1tyoBm6yeUjVWg1KgVrN5p4UBWg@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: use page pool for head frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Nov 2024 15:48:02 +0900 Taehee Yoo wrote:
> > Thank you so much for considering my work!
> > I'm waiting for Mina's patch because the v5 patch needs to change
> > dma_sync_single_for_cpu to page_pool_dma_sync_for_cpu.
> > So there is no problem!
> > However, I may send v5 patch before Mina's patch and then send a
> > separate patch for applying page_pool_dma_sync_for_cpu for bnxt_en
> > after Mina's patch.
>
> Another way to make progress would be to add the configuration for
> rx-treshold and HDS threshold first as a separate series. That doesn't
> have to wait for any devmem related work. And in general smaller series
> are easier to get reviewed and merged.

Thanks! I will send HDS patch tomorrow, and then I will send a devmem
patch after Mina's patch.

Thanks a lot!
Taehee Yoo

