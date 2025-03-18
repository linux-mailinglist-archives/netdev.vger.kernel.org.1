Return-Path: <netdev+bounces-175558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D42A665BE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3017A3386
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DA13EFE3;
	Tue, 18 Mar 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI+q1jtz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF21E50E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262895; cv=none; b=hW1AAZv/ZKwT/rrSirGkSgMu3M/+ygaboIwAtbg8FdVA2XflXVgI/paztA1RWSsRpVwu91KdExuC3skeVcJVg6RZlZ6I16bfRaZDED6n47Ggx3XETl3hCQpd/BHm6uRnXhsGeEzTChZWx5sc827G+CabhVU6O8WvLpsHT56W4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262895; c=relaxed/simple;
	bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMOcwQoiXGxpC+FIf9YK+SFVCUW2HNVY1n+cYiBKhWi0v/1V11ea4ZBCMRpR6IK5uoCbuqbr3zxPY/4aTyxYU1DZmDyZ5ywCIgBZIAgU/zEcF8Z+NWNG9i9ISaVmo4k/bor2cMp20e1T7JtxpZ0fWOiEd/oP7PJ0r9Tg5GCGBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VI+q1jtz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so2146a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742262892; x=1742867692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
        b=VI+q1jtzhvKmoyh7hBXwUEeTaydPuQj5XzasNDhXFPhVjFIn/r81sgewbsN1oZDgfX
         BPey053m0oKWodnCcetlG516U52Nf9YqjaN368PSM2BbvfhKOjs8SvgrbOH7ACxjr96g
         qLAoyhw85BMCie/9InpP/2krrRHEs/atjVX1hC+sgLzusMv9+wliUYM9iJuwN2f9jyWd
         IMhOF9b7CRyA48gTh6Hj0ZyukezuuYaonARc4kMiSHtZvt8iRnNHfzmhnRFLK81Yf7Uu
         NESV/0v2hGczctOpqODSGF9HtPbLbBA//0VjLEmY19sJuzdCHXvQyTlE7sj0PhguYd5F
         NgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262892; x=1742867692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
        b=XA+3Y+gO3avyy//FmGUvjRy3vjLyw/jvlo63pmzsVkx+jRwUTBn19IAlXFX4KbDXtd
         /PCbj735h0dXEvnqa7++5/dkHhHUQr6YML5/T4e9QK4BEnoiepokNA5Jk0RQnzNy/14E
         OG447shknNTpKHSXsy4lFO0Kfl/lGsjTnjwzlem3UXU2Sl/X2yFQkhfdn2O/qZ+HoeBP
         pHmaGLociZIagUN7/H8Nd/Fu5BbXU7IFJVqXPfaZbGqO1YAJ1O1iQ2UOlxG0A7BoX+zP
         DP1KDXjcdQTqAk6p/qF6lK2oLMWeTVlSBts4tMEcqHJlfzKQd6V3jFybCvrKKhRZuOI1
         MkUw==
X-Gm-Message-State: AOJu0YyUhKd+emmXkErVasDQqSwP9mSrXstzj97C15xHRRW94OreF8qW
	iSEjf10CF9kNbt024sKNsL10hpU3YjEogoXPLBk35rTRVEl33raT5sbZIVnMsmoSJsN1ZrUa6wu
	nmxJmFDcGvPwiA1wSc9o4UWv+moHigH/OsoJ1
X-Gm-Gg: ASbGncs+LOVDjDDdqcmgg/FHO9OKRzgfU2bLOe0nrYxnSXOsTsCPB0fiCdoYi6YpP2Y
	g1IxIsZjY1z6XEWn2BhzYMGnap1ek+88nOHnp1MB9aiO0qNyqWird1KC49C4fOWMls9x7UXKA03
	C55A9sNCq3BXfa116ZCxykwgnClh8riBHtv8NvRON+mC/7WkT9rsNvUXNiycE=
X-Google-Smtp-Source: AGHT+IHuugh5dIyFjTjpZ1QrK19v1S72Gk6SUbtmNwSwV8IeEV0H5viiTr47wENUDKVL66goMUI5eVuX6pKUk8AFR9w=
X-Received: by 2002:a50:ab14:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5eb3c17c749mr8928a12.1.1742262891986; Mon, 17 Mar 2025 18:54:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <20250313233615.2329869-2-jrife@google.com>
 <67d860665588c_32b524294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <67d860665588c_32b524294cf@willemb.c.googlers.com.notmuch>
From: Jordan Rife <jrife@google.com>
Date: Mon, 17 Mar 2025 18:54:40 -0700
X-Gm-Features: AQ5f1Jo3kmEJCxxxNAevGijG8_5YJ0Zw_XIXYlp5TsoBEKE2NP_Ah8F2Hl82ulc
Message-ID: <CADKFtnThR8gTbn7023cRihQz5D=G=z7AqbB-ZnJ4pkvE6PAtUw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: udp: Avoid socket skips during iteration
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Hi Willem,

> Can this BPF feature be fixed without adding extra complexity and cost
> to the normal protocol paths?

Martin had discussed some alternatives in the cover letter thread, so
I'll see where that discussion leads.

-Jordan

