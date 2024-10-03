Return-Path: <netdev+bounces-131494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661698EA57
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CFB23D9A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03B84DFE;
	Thu,  3 Oct 2024 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OZR5F0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F553363
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940571; cv=none; b=Dr+Ifcm70TBm5ncLjY0JFhQhlFy6+ug8GyQ8QjzGT2LP6QbZpJt1DVAFCB5B0t6Gz3SvK4tpcsQZKm4Z0CtobqBUint1K59JJzzjUHmmDmF524Yhoa/FiL7JD4GwLR5Gh/ZoLEcu4903iHY+jtMzS2/wZDv/OCvXzoHkxlhYpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940571; c=relaxed/simple;
	bh=qqlqfeEhdySgQeiowdKNUkoJutE/9XkKE8ReNsTcPc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3yDZ29Jas26SFfmRpBpksiPYdXENF5UpLXavQJsliO8msa1Ny1wbNvHt0jslnOUtki9U92Lx/ONScNDVqjie583HmwIwvotE3RJRVO64zgNORT4SLA5Qx/H3+H84r+li1iAoaDohPNvFvYavF3Lh2TCTpP2b2waeJjfdIoLb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OZR5F0L; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581cec6079so176461cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727940569; x=1728545369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqlqfeEhdySgQeiowdKNUkoJutE/9XkKE8ReNsTcPc0=;
        b=0OZR5F0LBbWUrnrM7WtFg8m/F3P8tQ/XoD8pk0B9qKbECMn/LEGUnzw98lrUjruDBU
         XyXwS7cslhiRywYzAo2oDjA1taw6CJDOccYgAtk9Yb1GrVBWgR5ChmCHlQ+ui8idMNV7
         b8Df0Y1+Rpv7FKoeOZjxyS3qgzj5PmRjcsQ4sHBGnIkJLn0w9Bu97brVfoSnDG8Hn4rT
         BdasYRC4ZY3kJ/N7oN7PxsQm3FJN3cY8RRzn9lG38KC1lmPQ2B/mhMeFDl0P6AZf32Pb
         vs3HcoqV2Iem7uUFipRBizmt22TEY4bgo6AAJwlx4p09Xf24sHc6W7deTSZnLtWOpaku
         9Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940569; x=1728545369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqlqfeEhdySgQeiowdKNUkoJutE/9XkKE8ReNsTcPc0=;
        b=VAYGrWlWhMlk0zdQhkeuC1rd3gNkO6yG4XMOMc1v4V+ZSyHPChNQGeSj8tBSWvECNr
         QeFBr2odDlRzUqWsKmvv1J3pFJ3REKM58m5OwkTI7uaPxlgjftVNIXBzPFk6S0sClmS2
         +aIFPAwWvthT+L1dnUEbcmYtCJu7SXDpm+X/Wx7r1/CtaV6ZdQ7RhgCFuUvorJR0lmVe
         vaand+S6+KehLko3hNwyKyF8GRLGg5sc2LG3dDYlSlL5JUy+kBw5TotG6M7T/YJecI5o
         LFmfe5C2xgN5hXj7/hHZVwrS03Lxddigb2xeCHW8gXyhto1VLsgk6/2ESnrXrcMRRkoQ
         EcwQ==
X-Gm-Message-State: AOJu0YwbeSXzfo8RNooSpgJywHLomozRDyFfiMT7mPFzD3Fu36UnAwv3
	WoVlWtdU8KX/K84/OGP7FLrP7zoyNjqh++FWFTtWITxbCKAN7hwAI/Yu5B05Em6mmETfYQ9rGA1
	BSxmbhTgtyyKJMHapg45yWQSxorTaPf/l7kf7
X-Google-Smtp-Source: AGHT+IFaxYw5QXru6pofzWItX09wQ0dBd+mCIhrIxGK6WPGyHtUIFQImx9bg4um7ZHcViqWUpD+fYxZxqEyS5phNvfs=
X-Received: by 2002:a05:622a:4687:b0:45d:8d1f:c505 with SMTP id
 d75a77b69052e-45d8fa60867mr1584121cf.15.1727940569269; Thu, 03 Oct 2024
 00:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-12-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-12-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:29:17 -0700
Message-ID: <CAHS8izN6ePwKyRLtn2pdZjZwCQd6gyE_3OU2QvGRg0r9=2z3rw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] selftests: ncdevmem: Move ncdevmem
 under drivers/net/hw
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> This is where all the tests that depend on the HW functionality live in
> and this is where the automated test is gonna be added in the next
> patch.
>

Tbh I don't like this very much. I wanted to take ncdevmem in the
opposite direction: to make at least the control path tests runnable
on netdevsim or something like that and have it not require any HW
support at all.

But I see in the cover letter that Jakub himself asked for the move,
so if there is some strong reason to make this in hw, sure.

Does it being under HW preclude future improvements to making it a
non-HW dependent test?

--=20
Thanks,
Mina

