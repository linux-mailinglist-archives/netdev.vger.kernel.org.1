Return-Path: <netdev+bounces-219454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC37B41555
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE42164980
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237E2D6E6C;
	Wed,  3 Sep 2025 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdfpPUB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8E2D77E9
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881625; cv=none; b=h22iUK2bXdmGS4pZx4K49JSu6JuToSf9L/bdrbW08j/ssaYw66+VXl/MnBsmPEX8ynlu7D//1M1BrbPueblclC+07ifueKwuSqsL/DfOq9HWtRtsW+S1Wx1bULwGBDA8Y/w7Xo4Or+v7yM2cK3bxpHBKudRDjIge1yGPu6JCvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881625; c=relaxed/simple;
	bh=I7dn+ByUDb13NbtwhJa5c65T8gw93qnSbGbhwt6saoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUCQjFET1dfjZoIvJe4SSF5pn5cg7fjYqJjukOfuoM7xDzvwUYRyfZhwVPcrO4iaowm+Kt80ihz8Lfvam2mX83iw12HDZ7sLV0E8uK9X/BnVCcKAxUFkFQ1HtabRXlYKr4zjUbL6WSXfQFGwS9guTdoCJMnohtOhFCGPeavevLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdfpPUB/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2fa418ef3so58778891cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756881622; x=1757486422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZROVpDLsg/RMaGyQc2L1zm8XIhSAwyyqCJqyKcSBkc=;
        b=UdfpPUB/XxosTHLYSHkWS+AdGscbknowdpybrk87RX7Uc+uAmo92SOom2MgMqRUlR1
         MjEkvdCKX7Ds38JwQ7HVmtb30s4zFZ3tA/ddUBKEEYp0ViKq5vXuJHZ4gYhjKHpF5miz
         7mCBaW+UoEZQDQwPpjGajla6W4T3/isAUq1oqJwKodzT/4e8BCCS/nRcRv3rwIA7ENpq
         5k3vN/2mzhUGx+M4QmrO5mSsdfqU/gc87258v1QeHz/uQr07A3/gRDIS0kTtArKBrQ62
         +RwmPJsgSl/S6A/froWFRhqOBx92KK6cRqcqGthCGfUXHxA2J+kYKEeyQ/kadgVo1EsR
         +RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881622; x=1757486422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZROVpDLsg/RMaGyQc2L1zm8XIhSAwyyqCJqyKcSBkc=;
        b=s1G9cEvVzsi8fKPVBtPNPJdBXLNHcaID06z/tQ3uVGnraN4tE75uvBzWfYR3tw2geY
         KeFrKD2tz8bweFHlfIu7QeYgf+iiqyw1+Fgn/5HYr87pqcaSr8Xp/CTboLrOt/0frUFs
         jgBvOU2j14wpMi4lGTp2jZMRcDf0KMMIz4uGMqjd5L4lXNBBpMXkQaTChZrAlV7LxiD1
         gngFz2egWeQNAGBvHo+Qi3xVcOfQQx/WuKufMcJO75WHz1+5UzgEECprs1bLQN3NRMa+
         e/wp5kxlge8JNiV3ZXzQAyd2igxC55MCOsEMEHYp3+NH/0Hh2O5iQU+qIVxDUPozmBjN
         1IVg==
X-Forwarded-Encrypted: i=1; AJvYcCV5xToAQWCH/SDBml21HdMwL9iQWin67YeHcDAmJozG9j6gfbHOe1+jMmmgtrOe38RItVxXlxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwUTiD8Nd/Xjx4j7i71BlAc3cb0jg3pvTJk9F/E/chq+HlXkf
	2CD3Knb1zZpUXeT63In33F4xH6ZRlICvGo9Cu2m1Oa2nmRyk0MDkDtMQKhUG9Pqy47fzxKRUEP3
	xg85jjKfTkKyKyYUaQ+m+yGh+4Q6odMO53GQMYUl1
X-Gm-Gg: ASbGncubVCtCtKe/+V7eR8jsDaCIFsQzZCqUhuGQ9rcuwRGMUMvVDNkjuBkcQWz7DyC
	eZ73CcO9/oV1yBA+o7qM/vTbfJCqb7WSUsSTgJTTEEjaqa9/Hbj5wtyNOkOGmh8wxZManLgWA2g
	rAGp30MRwB8xxf60MYLfmgrEFQqtpswc3kGGAg3aqQ9xYLETWCK49wogfDt6tXJ0KCshemRKeEB
	viVDpKt/Rk3XxzHdGo9rXRo
X-Google-Smtp-Source: AGHT+IHARsXXGrtwJJveuJtqCTwyZ1Wed6t1P5yMrOvhki4ZqUEPp/Dq0VXQZ2cil2KfojtklOQxf1XEcDeYXoxFGEg=
X-Received: by 2002:a05:622a:1984:b0:4b4:95f9:ada3 with SMTP id
 d75a77b69052e-4b49608f3a5mr2366221cf.60.1756881621977; Tue, 02 Sep 2025
 23:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 23:40:10 -0700
X-Gm-Features: Ac12FXyZI6Czfydvl7ogRcbkHggDSoBwxCpKPzZK1zSshOwTmdUAUCkdFFHVQMc
Message-ID: <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, 
	kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:46=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@linux.d=
ev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since the lookup of sk in ehash is lockless, when one CPU is performing a
> lookup while another CPU is executing delete and insert operations
> (deleting reqsk and inserting sk), the lookup CPU may miss either of
> them, if sk cannot be found, an RST may be sent.
>
> The call trace map is drawn as follows:
>    CPU 0                           CPU 1
>    -----                           -----
>                                 spin_lock()
>                                 sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>                                 __sk_nulls_add_node_rcu(sk, list)
>                                 spin_unlock()
>
> We can try using spin_lock()/spin_unlock() to wait for ehash updates
> (ensuring all deletions and insertions are completed) after a failed
> lookup in ehash, then lookup sk again after the update. Since the sk
> expected to be found is unlikely to encounter the aforementioned scenario
> multiple times consecutively, we only need one update.

No need for a lock really...
- add the new node (with a temporary 'wrong' nulls value),
- delete the old node
- replace the nulls value by the expected one.

