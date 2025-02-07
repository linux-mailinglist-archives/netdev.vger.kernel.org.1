Return-Path: <netdev+bounces-163866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11CA2BDEC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C35188C3C0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB491662EF;
	Fri,  7 Feb 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTdu4kTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3807DA8C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917046; cv=none; b=EkqEZ/djQ0M8FwS+deK4LdkrcH5QBeV3WFStuxuA+jdpuC/SemeGIvYzRuBs7pJfUUUwXqq/y00L6qPQ/xQvbsFuZPtYiCIm151gAI7ceXCAfVz+S9RXiGSvTHPYYDXqdmPH5AtjZlL8dfuss0GmXe+Z+CSFs6jcySPhvjcUzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917046; c=relaxed/simple;
	bh=kB5Y2GxiyyEa5GUZGs6pk9Bj4LmmFq7pnQMltJ8ngFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4Jk5nTG1N2RGrjns5QPecdw4FK4sdariqdo5BPn1drukUnpMJDV3KNpOkH3y7cGBzKYmEbAlISkBAuSbOSz717k2TnD2nj6LgiL8jmsjTigYweFmwalC9WUtoDBSawN3oSjPC2lsWSwaYUt5w627jeIfOAOjep9j2oFVmiunAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTdu4kTx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab77e266c71so199536866b.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917043; x=1739521843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB5Y2GxiyyEa5GUZGs6pk9Bj4LmmFq7pnQMltJ8ngFI=;
        b=uTdu4kTx6aDVoI6ZK+4OPUSBJIdsrXrUL9qGCLVrSZP2ChopyuGtonHnixz/lQJfAh
         PvcK2gv3KLh1HQ503WjHPt8LUoxfKulxtkAu6lbPgQFOSFibY0feyMS4fG6zK+krDu+0
         3HOZHEjLJAxD4O8tIcI7464EBXkYy8a5mrUJdJcyZylvWUJgg1P2dWVLrfEUGQedFKh7
         ZPd1jjrdwVyCoCMIZLGgQUhPNTUvtUwQagkBikWVMBV3y+bQhoYD8Dg/YIONw4KaWm01
         IOuOQe8bBXf+rt0//M+pSpCeaHtqJEWVZ8ApGOaveeGLWi/gdIyA0ldNDLkSG0ljfrcs
         ge8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917043; x=1739521843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB5Y2GxiyyEa5GUZGs6pk9Bj4LmmFq7pnQMltJ8ngFI=;
        b=ta1ZCOJqe2devATzPmNRHkThZdAfNKi2PXjHavno3dBAxT2VYobBhY51Wgl0tvVrPH
         oUdq0zq4plidHADi96SLu7kqcJaD3jotnLQM6UOOe+JpMSWqtAo10UJMPGGb7o7IP0IJ
         t70Vm5aQGZ/NndRydyb9Lh4lwHspwJ5SFUrrREG/ucvnsL9jaApyci21emPqNx+SKhlI
         no4fd9GKO2/A47hpslnv/GJPtETGQRLpz7eralS6GJoZxy8Eu7lBmiGC/Dz+02+zfX3a
         mzAAOcnnExstHpLkWdS1GmgxXyiSbvmG8jyqp2gVt+TxpqvgJQo8RbJ9RwRbpKQ1Z1FP
         ITrA==
X-Forwarded-Encrypted: i=1; AJvYcCXvsjBa8Ibx4SuhSYFJDMCaLaZTkwgMqHKaaId8I7sroaM4LpdGNLMFvsKMJBz9X226KOdWeFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHT54Sh8HdoTvLaH8pr3VHgEwWvnoHM7/G/qt1myM6VpbEhPK
	OHtwm2NtAvClsrWZBNF5+aIWvPlSwrlG1tFiC/uzybKqlHNNhkjiIw+xY2plAuTfqz2Ola2vwSw
	uh/rs5NrsIAqBB8XfjjloVaWQcm0Y1yoEkOAZ
X-Gm-Gg: ASbGncs+EXKova678nHSuyubFxkCalEEVq8pqysk/D59m0fFSFCeDoUdi9m+k7mOyOb
	JSKYdlbDkoHR/zfb4+ZBoi52sf6CDwW4n3nAXl0Mt+GKuV70iR3asSNTwsfpgYleLxhRIZ/t3
X-Google-Smtp-Source: AGHT+IFTndVcv2C7826jkPpirucC4nDA8Ds1lAuAgUS3X1HPYAUAkHscl7Qyhav5KduK9iMKPn8hfqbrhPmZD2M+kz0=
X-Received: by 2002:a17:907:3f90:b0:ab2:c78f:e4ae with SMTP id
 a640c23a62f3a-ab789b76697mr208780966b.20.1738917043123; Fri, 07 Feb 2025
 00:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-4-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:30:31 +0100
X-Gm-Features: AWEUYZnix86k0CcDfXVaC8J2j9UapVMv-Q7WBpVTTgCMMXP6GGlaQNeK1wX9OZk
Message-ID: <CANn89iKzU4Ju+uQMMjCcg38wg782w=Qo4-UBY4YtuEFfT_8Wrg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/8] net: fib_rules: Split fib_nl2rule().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:26=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> We will move RTNL down to fib_nl_newrule() and fib_nl_delrule().
>
> Some operations in fib_nl2rule() require RTNL: fib_default_rule_pref()
> and __dev_get_by_name().
>
> Let's split the RTNL parts as fib_nl2rule_rtnl().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

