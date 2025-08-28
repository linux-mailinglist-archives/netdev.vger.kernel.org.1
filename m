Return-Path: <netdev+bounces-217618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FAB394C4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063775E4F53
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E812E9EAD;
	Thu, 28 Aug 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1Z4dyhz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F732E3709
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364979; cv=none; b=CGE9QLigdmlkerNQYmcaBWlKuTRw7T0UmNO7WVRbiftZmSRzXwLSd8yNHhiclPxEJEPsOlNbjh6v4ksDkmh2fi3hoDAoeOylB8Gnp3wWO2MWfPNlyQBRkVVmaav48CrBDchF/oQkPZmAH0tA42sN/eJMoUq5prxvGEgA2rXxSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364979; c=relaxed/simple;
	bh=lURPkYJzF21xY2QquL/oWnteDlCb4vfGHfOnzqSwApQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOoMM6VY0o3ZVX4bxOvwZP/2vnor1CniDRCTJXocvjVENAh16PLIYsjVHZzB/qW0Mg9Jn8sguY24w6WBnBNPA5K2yitHJ998AF8JdtfKZiswyoDe3cpj1U4duZO6tyf5yez1yfILQUC79norXmy0urijJyfjFTuUKZk1/tO8WQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1Z4dyhz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f77c66f13bso70669185a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756364976; x=1756969776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvs5njM1wOnHzJ4hzbLuwCvVNmJOa7dYI9qPuTJeAVg=;
        b=f1Z4dyhzXv5ADmSboyQ7Wn+9L+xknDiw6NrUHNrkgDKKxereJq9Muvz0qnM+gJQq76
         0DaXprhdL/kruFypknzsyO9mbeL2jFhrhQfdqAzzZJgQvc5nah9e2LZRXpYeevQZJCb2
         QiU0jclssmi4nlrMb9umZUJrv/k3WNPvNfvvLCfRC4P3GdZ6AiTV3YYSjzqcaDnccUvN
         CGV8BP1git/TrFlAgUF1a1HUbCNGL8OcYXvlJ7LZ4T1jXraKQcTnshZLz2tZJ8/4RU5R
         k9uljz/G/qCAkWcZnXhdJvgV9GEl8M+YY9HAD4gcGHfKsSA+WIwc3iNg8KJlhPS4AAUe
         MwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364976; x=1756969776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvs5njM1wOnHzJ4hzbLuwCvVNmJOa7dYI9qPuTJeAVg=;
        b=TFUTMhxkLtZ/ydAtyAEPZK0cOMHyO2X+qzLtEoVAoIHkTmiAXEhioIXCW2/Tdc1GWG
         7I6QSq+c3DhCRPCZg156FHd3DfbYjM4qZc9LzI6uTZ6pfzSJC/cKEWQFb2p6w0m+VsLF
         Ql1SfLX4mOxqmey9p4fNgRULrA+R5Qh9/9jf9TYrkrEMmburPbkN8/k/1VX8uIfQnSpd
         aZylhop4QY7A9xmTJhrxy8+M8F2I/rh8Yb1ELNlz8+RqZiBYpd1ZgSZxSawhJ2mZmGXx
         vFr9Fx+urIBhpFiOamrsMz3eKknT0UaB/f8caHKIVVJZBx1+dafDI7OkHhhk88HFLVhR
         ZZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHCbqLE97HhRbrS7gQA/Z1kFMJBHYi9Z7QMj58TqeXptl3J7Re7yfkhnix2hS6wMV9fUWFBfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7DWVymLDQcljBRXzhp0EzAkvuINCQfC9voCAYuhbNMAd23vm
	gDmWFJRiYDMYO3L83M9r3+AMPyG1Z/gxIQ5CnL4tmCZtoP7TF2MJAqkCM6aeyUZVg1sHpbPKq33
	vvJyZBnpy9R/el1RdnEAcCsviNIQ3mBc35ipzAlBH
X-Gm-Gg: ASbGncsG2x4T0378CfCzZLGYOUbtf1V6D5Hva5AmiMqVjZRMA040/Qwj1uHKldCiySc
	y2AB5fwRkgCyoEDsIS0AMc45GX+m2ScC8jxj256AtbjP+Mjr5i4ywJga7/XVgP0oznhWtAoAYfG
	bCEdX0pBUb8Q/5pag8FaelsOOILQWcu0s8v1/JCjhwpN95tby58mOPeRLlBte9VwC7PuEZFenhE
	D6/csrapEBHx/5RsmqwHg==
X-Google-Smtp-Source: AGHT+IHxSqNH/ftHbBJ+fPHtJwYAGqsLTp8xOivDx1VKWMe0sNYk7sTPD/n4Agil+b9tyPi+N2/KpIicDTDhJp0h0hI=
X-Received: by 2002:a05:620a:1a27:b0:7d2:1953:a410 with SMTP id
 af79cd13be357-7ea10fa1344mr2611829885a.17.1756364976094; Thu, 28 Aug 2025
 00:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828012018.15922-1-dqfext@gmail.com> <20250828012018.15922-2-dqfext@gmail.com>
In-Reply-To: <20250828012018.15922-2-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 00:09:24 -0700
X-Gm-Features: Ac12FXzCOHbY-0cZG_DPV4Isb0S8nmhFOKMxM0fnoaIGHxRJ38be9HGtCcgGyWA
Message-ID: <CANn89iJ7DDA4gM2vDAwhOyc5KGXPmOBGATMQfXD8FHUAFbVDvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] pppoe: drop sock reference counting on
 fast path
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Now that PPPoE sockets are freed via RCU (SOCK_RCU_FREE), it is no longer
> necessary to take a reference count when looking up sockets on the receiv=
e
> path. Readers are protected by RCU, so the socket memory remains valid
> until after a grace period.
>
> Convert fast-path lookups to avoid refcounting:
>  - Replace get_item() and sk_receive_skb() in pppoe_rcv() with
>    __get_item() and __sk_receive_skb().
>  - Rework get_item_by_addr() into __get_item_by_addr() (no refcount and
>    move RCU lock into pppoe_ioctl)
>  - Remove unnecessary sock_put() calls.
>
> This avoids cacheline bouncing from atomic reference counting and improve=
s
> performance on the receive fast path.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

