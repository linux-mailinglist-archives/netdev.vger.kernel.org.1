Return-Path: <netdev+bounces-209087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174BB0E3AD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00572177D25
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7FA283683;
	Tue, 22 Jul 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+tPlFFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344428312D
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210193; cv=none; b=GZRQq5CjTmGXCAm789Q1FNrZHOSNSTWCSezpGRWOU23wweGD6LLOAKOnI3zVqGkWvychlYTGOYqSBoZRSwRU9OCp4XiWYnbEUgzEDrkswzEfi3kdYMUAf1LB5/Zv8WKRxZyrk4EOuRf9Zk34+BwGv1xNSXhTMzd2Ku8N6r8yxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210193; c=relaxed/simple;
	bh=7ij9NpRt80LPFL8HR8TfaqnbnPFxl5ZU4S5TEV5tdZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyJQlhqQt39FVcPeg19eOPPx7tclX9/y+2GuwP7wEJmsZoeKNGla+FFq4zq4mJpcLPyNklbY1U3aAc5h2+vysQeMauadtrH+ivNDMK3+qYtg1MfPgyik1Ch+dSLLb5/02toQ4N7XyiNvw4wxKIoMq2HJM3jrXB1HAwBO6nUlZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+tPlFFP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso4582166a12.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753210191; x=1753814991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbmC//gG5YMMT+YnkzJjaAohtCxkf2risib+NKHtOrg=;
        b=G+tPlFFPbOzd/54LrUVc3UHsyza+oZ28wxHv7mv9o1DON7FwWMUn4LN6eGoiVQf6Hc
         AcxrdeSI+Oz0fTWBx0LCZ+BYEETsslWDvbfqmaVxL4oB4lRXRW06VqLmIeTjzgyRbHmt
         MGlDK0q2tECjugHt3Z8Y1l2TQGMaXijx32tu3+0dEKmioC2EoYOn5TII4UNd+bBBT0HO
         74zVF+FrDNA+evCVTqNOSmCQ9qJSsfH//l5rbTrjpoRYsBhClkFDaiCrExw/s+EuolcW
         +kEF8AVlFUH8JacmFFJz5smmHr8GZe2jIYiK1Be/011RwQDc9Q76KHVkAmuatiJSmBjB
         twBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210191; x=1753814991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbmC//gG5YMMT+YnkzJjaAohtCxkf2risib+NKHtOrg=;
        b=YqKA+3KZGsFdmXArk3RWhc3PkhOXJ3C3tbWEe5TKpSXL4JCQKCTu8vHHSGrUaQrT74
         2+dCl3WfOQUZ7VOE5unhXbTF8h3vT4yUTJ0l75PVekfiP+iMFd8jW6igkcBfTPFW8xV3
         JGV4zIEfSJUmHpDT3WuJ8fWMCKbSh6+EfEMCLgwIBUGh5yBDSzE4fTCzluZ5Rm2zcctz
         QfgSRY6A1CwgUZ/hbF8VhF6cmx+IuNd1HCOh8T4Wh+JYTTfEKVBaTBI9eb9w4Z+J0MPV
         i/GHAHHv3acbI5LCeUv9BiWyOJqh4oMa/ibvl1NSE1K3ad71HXC2U7nxNI6ZEpFeW+MD
         JmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG53qdhCw4Yjl0CRFf7IA+tZzYGkMhr4ysCkvfOuTx3Ovq7wbhX+rkXHehQNhsEH5wrfoEJfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eMIkXd5BEZ9OzEGy5g7icOLaas898XGUmcAJOBHOMrFeP6nS
	RsUSi/ttQRKlrLkZlKn03tglazIG3z/lRQ7av0epmfBE0C8Vz5wrYDej0Y6wprUhryOasIZ1f5D
	d3ZzvEVC9oKEEc4OEKTHeLGwes+Ntp9gkoJKzunN5
X-Gm-Gg: ASbGncuScJN1Kdps9IGO//TOYHwp6ia12tFXGauDfiHDbaXylCDjwiCCPB8jlDU5D1o
	L/OH9HQcBoVpKLZay80UOne68gpFMIRwmwKiBw679H64D6tEGY6cmLwvo+8d1fYoLRwkD8EHaLz
	7D+HxGUH0rVfNRLl4FsQ9K9OEbCc6Inl458ZzHhBNzzDLGxQ88yN9veGifxYixRnEeYur+RSfp+
	OtxIwF9lf0FJT6RhgNo8DvRq7bi+jlZh9epegk9pkluR6Eh
X-Google-Smtp-Source: AGHT+IEg4W97E07D/JlFeehtaiwxPWUF4AnFa19XV+i75fU3XCe4tqE6HcJMrlHWpbyEhBQz5BtcSmGxO+C8g2IB2zw=
X-Received: by 2002:a17:90b:388b:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31e506ef9afmr612863a91.14.1753210190763; Tue, 22 Jul 2025
 11:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com> <3db01bc9-f6ea-41f7-8cbf-fb33e522694a@redhat.com>
In-Reply-To: <3db01bc9-f6ea-41f7-8cbf-fb33e522694a@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:49:39 -0700
X-Gm-Features: Ac12FXyhexe6ErD4K44AhQAu2qUuwklTJsSiRV2SdD5og77T3xQkMML2F4JwTjY
Message-ID: <CAAVpQUBgDVHwCzw_UJBeh_SLf=w547fKy9v-ke_Rw7Q-C4rhhg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Waiman Long <llong@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:41=E2=80=AFAM Waiman Long <llong@redhat.com> wro=
te:
>
>
> On 7/22/25 2:27 PM, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> >> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrote:
> >>> Hello Daniel.
> >>>
> >>> On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedla=
k@cdn77.com> wrote:
> >>>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> >>>>
> >>>> The output value is an integer matching the internal semantics of th=
e
> >>>> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock=
,
> >>>> representing the end of the said socket memory pressure, and once th=
e
> >>>> clock is re-armed it is set to jiffies + HZ.
> >>> I don't find it ideal to expose this value in its raw form that is
> >>> rather an implementation detail.
> >>>
> >>> IIUC, the information is possibly valid only during one jiffy interva=
l.
> >>> How would be the userspace consuming this?
> >>>
> >>> I'd consider exposing this as a cummulative counter in memory.stat fo=
r
> >>> simplicity (or possibly cummulative time spent in the pressure
> >>> condition).
> >>>
> >>> Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? =
I
> >>> thought it's kind of legacy.
> >>
> >> Yes vmpressure is legacy and we should not expose raw underlying numbe=
r
> >> to the userspace. How about just 0 or 1 and use
> >> mem_cgroup_under_socket_pressure() underlying? In future if we change
> >> the underlying implementation, the output of this interface should be
> >> consistent.
> > But this is available only for 1 second, and it will not be useful
> > except for live debugging ?
>
> If the new interface is used mainly for debugging purpose, I will
> suggest adding the CFTYPE_DEBUG flag so that it will only show up when
> "cgroup_debug" is specified in the kernel command line.

Sorry, I meant the signal that is available only for 1 second does not
help troubleshooting and we cannot get any hint from 0 _after_
something bad happens.

The flag works if the issue is more consistent or can be reproduced
and we can reboot, but it does not fit here.  I guess the flag is for a
different use case ?

