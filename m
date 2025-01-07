Return-Path: <netdev+bounces-155990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0C9A0486C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37108166E65
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA371D8A16;
	Tue,  7 Jan 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y/RlMGXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A618C924
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271537; cv=none; b=d829lDP3fwfJ/dGbrsg9rocfpAv6yT3Zv8R1GLsqoXwDn+B7XemzAGENmTZetptRs7WC+7Lgit3Y/RT25UAKBEjKOtm7w5UyKX1nmB2ltaBTwIcsVJ9nYRzWye4sS5WGtr+bdyQnAZJoDh4CLBP/msfWwABtW9ql+FR8gncUH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271537; c=relaxed/simple;
	bh=7JAsg0jMIqzjpHUocaOM4Sl0iUPdIcl3GEIH/mgrNko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raNPrWOtAZire2+SoNKz8z/I8QCf2JVGG6rVzinOBSEPnO14XrLdAbzAiuhsXaFc3P8Wp2HqzKDTG46ppKJmMi2uHlog9W0smtQ9Ra/RB7xMzstBczUo9/V+omgPSLV2VoX20RDo13Uh5uvhqimK/i3ImvyfBxQ71dWbI+HJvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y/RlMGXR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso26955157a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736271534; x=1736876334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+YiOaS/WwM+ePJ+wu5aFgqLo7Wb+boMYAzFfKRkDCE=;
        b=Y/RlMGXRZ7yH1TLw3YgF0Q5XfWvHZDu/bPimLmDV4jjCFPwTzZGNFVISwu/PXgeblR
         juuVc1acWc7n0NqQfHzvcyIms2GDfys36T49cYtp40Uvd361LeUUvF3JS+EO3FVNf7aW
         4EHprOnZGO3R1OGC8tY/tmlzEWgsHGWjpI4uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271534; x=1736876334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+YiOaS/WwM+ePJ+wu5aFgqLo7Wb+boMYAzFfKRkDCE=;
        b=m70oFydo7fHoUP6fdt8lZ+nm9UhY35YinBmOmDlCOXYY6d0+5sXeJKdzGSXgYY16FJ
         srH3FPvGli6pBfOT06FiFNfCwvTepVywXpN3Ppf2zbdBtIUdWBWbrrt0JopQ2d5QC+0c
         cmwNQp2MXw1k+JY9fupAxbb5a6o/1itq3sivYPbqpWbGKSoPFJpE+99YAheaqLsAKpRu
         WGnwx4ArD/nYWmDD3PknsDFeA+ivBuyoe8tiplZMHfmnkiLZLpSIkhwPkqeb15D3UgCJ
         tB/tKQhW5o1QFbcDWi4hLtgnYsP+62dw0MPbVfVKomkaQTgHQUIEn0egH3wCBwT2gGcM
         6qrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGFbpifDcGDtNmM4eOXyGjF04q34RFxDFOgwxRhATfGhct40Ajb1JPX+ecRH/uaRik60LruCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4WbzyQvKnGOMcHWbdbpm/otu2ZHYm8N3QYsW/PlLazF4Ybx8
	sdXu7Iy8DmfqZ7L4vA1u1THBIyH3KzApw1X+9O2j061v2+gGcLjEXJoqmKKhq+afiApITf6HHOK
	2Vrk=
X-Gm-Gg: ASbGncvj1SJFcmscBdkedSocja1FfJrmnmLsWjtfD4aSpc5avoW57rUq8offtvtFoUG
	qi6G8Yx0e43a3PulhxOl/eFEVmLshDO3iOya0kfoJ3qIgZXjhnSnvb4Ay0s5VHxAo4r5dCkcIew
	kMaTjtextUfMDDzU+1ZHprK0x4ORCcuWz71+BfFV0V0xPXfW2DqWNrup0duCyKuXmGWa1i+XfJP
	FmmnknkAG+aVkq8WsrbichlX71G4pEsloa8hCTby540zSlDLVSNy7VQvUG+/PM51lxvscqzUNT3
	F28S5Elzkx1XIZ25CCh7ncua5fxK4+A=
X-Google-Smtp-Source: AGHT+IEWWRz5qGI/kBu7ZEZ03fzlCDh1ezwoWcpS1LLfQ+zHdClDH+VD/De1WmI4PE2flNc49ggUNA==
X-Received: by 2002:a17:907:60d6:b0:aab:daf9:972 with SMTP id a640c23a62f3a-aac334c0ba9mr6226724066b.28.1736271534086;
        Tue, 07 Jan 2025 09:38:54 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe41f0sm2381094566b.114.2025.01.07.09.38.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:38:53 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so28351788a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW83quLrr6HDXDUTPVm9FkbItHbFM0pvFiq0VmgEMbL1G6J8Bsq7EgVZWPniHh1ib5CHvqFFx4=@vger.kernel.org
X-Received: by 2002:a17:907:3f89:b0:aa6:9624:78fd with SMTP id
 a640c23a62f3a-aac3444eb22mr6324195566b.48.1736271532650; Tue, 07 Jan 2025
 09:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107162649.GA18886@redhat.com>
In-Reply-To: <20250107162649.GA18886@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Jan 2025 09:38:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvpziaLOTNV9cbitHXf7Lz0ZAW+gstacZqJqRqR8h66A@mail.gmail.com>
X-Gm-Features: AbW1kvaB-leK12kGlT66BV6_b6FtwbtDH9VocCPIxNTa3S3Gc83wtFOKyImflWY
Message-ID: <CAHk-=wgvpziaLOTNV9cbitHXf7Lz0ZAW+gstacZqJqRqR8h66A@mail.gmail.com>
Subject: Re: [PATCH 0/5] poll_wait: add mb() to fix theoretical race between
 waitqueue_active() and .poll()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 08:27, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I misread fs/eventpoll.c, it has the same problem. And more __pollwait()-like
> functions, for example p9_pollwait(). So 1/5 adds mb() into poll_wait(), not
> into __pollwait().

Ack on all five patches, looks sane to me.

Christian, I'm assuming this goes through your tree? If not, holler,
and I can take it directly.

            Linus

