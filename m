Return-Path: <netdev+bounces-96456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C38C5F98
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7733C1F22C35
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 04:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C065381DE;
	Wed, 15 May 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ba/rrUgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA538F98
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745988; cv=none; b=iKywrpMZjm5MkVJAx3JpIy09hTaq18Uf/CKpAyczafeFRFVYWPk7aC8dSjFHXoJjNWbJ2QiuX3Y3SREYO3NEqe6Vcp/dLIvEyJJWIbh7MaWzcYeUs7dVbVsCVDHFhr9nLNtVCgYUYqyxYObFdkQS0SUyLcxUvheQLTwYpoYG3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745988; c=relaxed/simple;
	bh=oDK0dZjxuFm0H+MXlbyx+nVtTUik/dIpxYkVCNyTtUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDhlSqxlU/yFNeFL5dQsO4ZYWaZ7QhC6fH8pd0RpdLIs/6dL2o2q+XTru3L+3Eo9X2yrt8FTplwRte24BhA37sfgrLFQs6rqqykKLeqWH86TyEfTbSFEyqYWQpcv4VZjXTkY0opO8bR09a0rczgqc3N89xReAHaIS/kZGxZ32X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ba/rrUgM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so1169850a12.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715745985; x=1716350785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=ba/rrUgMqTY3COfZZjp0hpAesSpYB71Oi6ydTUngd4rWDWzhCFGmaNI5K6Bi1nfxmw
         h9KKZY3XlUYkn7IbXDib1H0auNWB2+ZPcVEjKJh39ZUygevs4kXjA/cYkR8QXJMrpGI7
         yPAUe8xfCRBsFcMkkQ9fcCq65dMvLhpUPhDm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715745985; x=1716350785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=ZJVYl62iqIYMmEwid+x1+ccj7m3xX6ae71GFU6gSAtPvNOjSrHABi/sTQWwijEU57T
         +Co35Ea8QysvXhK1uBndLPdJrp2F0LRTmfvbIdiz86wApANvPLsjYhud+7NOOvVsAJEX
         OszBdWYJLuvCLD2odcHfTlzhgg+fzY4Ow+XPb6GRe0UfWR1s98F/zJ+y6CHg6GYmU49Y
         VxBakI/4t8x/44Gg59oFXCjUlTzdINhDekcKtrAEIK8ILO11h9IoSo01mxZ0t2MG5YkZ
         FolgNFe4dqXY9sm28Q2PaUlRXfk4d+WN2Ntgsm4WH53GdhyiMqJ60u6RkFECs15dfe7v
         xWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKwRdmIhBnL5TpcQ3VaXVNC0mhpcPDl0PwouCAz4e5Vku0uEX8T4I4cqQw/izj1LedjQBoFaNuQrnnr5I0X9pmPwmUn/0k
X-Gm-Message-State: AOJu0YxQEgFEWTvHg+89xwTV3rTDiJpnelhfoH+/px5eH+RLTlL70RdA
	QxVbVA0W3vaMIEw+AnrBSTg5co4xTMkZBAITBsJiFQxl9XBQO+z43Jb1/Gzhtakjh/Ndp614bzA
	uw9FVig==
X-Google-Smtp-Source: AGHT+IGw7PJ4p2mWbM4y3pVWG/Eb+eCBdF5vNaaTCVY0Ex7x3T4TkNM4sPfUFiDksJ8jj9oJBpveYw==
X-Received: by 2002:a50:9353:0:b0:56c:5990:813e with SMTP id 4fb4d7f45d1cf-5734d5bfbd8mr9214292a12.13.1715745984674;
        Tue, 14 May 2024 21:06:24 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ec273185sm991432a12.42.2024.05.14.21.06.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:06:23 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59c0a6415fso117374866b.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 21:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViN3O7Iok7Bb95QbDTImalssP+BsXqzn7EpKSZSJZ+qVVl/vk3ap7EVIybS/rOmuVV0mqDWt/bKTq/0kVaFyjdTWH8DH8Q
X-Received: by 2002:a17:906:7196:b0:a55:5ba7:2889 with SMTP id
 a640c23a62f3a-a5a2d5c9f69mr956803166b.42.1715745983374; Tue, 14 May 2024
 21:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org> <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why does it do that disgusting
>
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>         ...
>                 *insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
>
> thing? As far as I can tell, a bpf map can be embedded in many
> different structures, not just that 'bpf_array' thing.

Bah. It still needs to do that array->elem_size, so it's not just the
spectre-v1 code that needs that 'bpf_array' thing.

And the non-percpu case seems to do all the same contortions, so I
don't know why the new percpu array would show issues.

Oh well. I guess the bpf people will figure it out once they come back
from "partying at LSFMM" as you put it.

           Linus

