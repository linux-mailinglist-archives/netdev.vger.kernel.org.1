Return-Path: <netdev+bounces-218138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40633B3B42A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFDE1C843DF
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E33265CC8;
	Fri, 29 Aug 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTX13nuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F854279
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452004; cv=none; b=J6/jxm19BDC6V78dM0ouKJKj5Zx3qO/XZZ8RpPR3qE3byvJmWjHPM7hR+XdVeismmZ+X/XvJbHrLX6veirCUiAqNtF6THn44kIp8MX4Ke1mvZlzdGgkHjuKhOg2KPwPEOooJ9eqSKOqQn5agWmslHJXfyCsyrlNj0x53CugyREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452004; c=relaxed/simple;
	bh=8v8f0d88ljhLJbAQzYIc+XOWg4MAyXlZkHVrhNJjDwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHGR5OJqAMYA4XswSTUcj/iAtnkDxPiNx39+2cqHz06CCNiLbUF09L4EnfzMYUyWQVSugrY3tTE5pmbAbuun6mecABHb5nUpJiMIPlhzTuN73pQuz89u/xS3RLhOeondItK/0+e5o32M1hxMnVXP5nXfiZ8l+JMS/e1Ny9Y4720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTX13nuT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b2979628f9so18542971cf.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756452001; x=1757056801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4WmWnlQJPKm6CVBo2ioC99XH+9OEvYsN0cOhGbcCvw=;
        b=fTX13nuT5n6fuYUqx4h+psj5mSujckJ7STNMRLuFKmMzFBZpR7vLeN/FGZT81ZQEqq
         hxd2jGi6f1cmKLxGSQyUZp1n9Zbuw+WxIFKh1fNXD5QONi0uP4jIMyOGAT2LUNkby9dU
         2B7vBNPmIHhPXDflp6ylAM++i/PVc4SLH979t+i02PGrWjK6p675v4T4GLnDZLG7MKqL
         OuUG/DPIzCAmRm/ULIQNfgT7Q56tnzwrXB/kRtVfUEZCYtivRT3WWxijyVU0/oxRPjBk
         YHgxgXwpPEpyUse0NeY3eMxw23aZua5DH0S0G6Ge6CZg/l6bTHdshcObgsn9uwMcUWqZ
         crEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756452001; x=1757056801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4WmWnlQJPKm6CVBo2ioC99XH+9OEvYsN0cOhGbcCvw=;
        b=xDqZu+rSiSHq5LsJ0oGnWr1aBDkSuY40UD4tb7t/WVergusKWoTALSgUdr0lm0nDb9
         OKROeZZCr6AeKfvAhTEy95kvLsFID/ngGLCY1KPlWWHdIBIcKweyeS/+X5tYLL00aldK
         lkVprpM6o+ic2mPeTrQ/H13szJ85Ia8ZJlDj+U/VU+K8r9B4RCrsgyMo5uNEHuE1yCef
         eXF2RfQZvvVE8yTu4N7rRBsORTIFplOsA6rDU2sMM39eyXOryH5dJMhdV8dys/EVuLPA
         DwWQb3V1x4zrc0T018p458khlpw8/8M4lbDw5fg9bcT0I4PLdF5tAUAvET80xZCWrDlk
         k4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUgklre/bo1+dZ/P5Fu0KP82C5a2LaYcJMHXkmLi+aqU2QfUECXXnKouN0mXXgCHCQutEp8jBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBtgRzsMBc5fcVucDdhIR4ateBxShsFJTdCKgyfZG53T1wGo2
	SKq0KyjnOiHgCik33xXVeARCYR4yMP0UmIy0TgfPYyzPl1qH/WKgLA++ehY8F91M0ZGjNNWvJ8Q
	2t2PHLqV8nbquBp1zT4jqP2UMvC6HCU/km+HxkDZw
X-Gm-Gg: ASbGncvFSaPOveS9hm+Z3RVTCyEtiZ1iYhJ6j9IPaPHfCzoTKrG9YpGjWckcf93tzlk
	ypvKEwfAD+t5renvC4ki7YwRfU6Ln93QEP2PtJc9tH/NcHWrqL7/f0X9NHnhCDRpuAKd31fcR54
	x6mE0xZBJTunSYTIHuBdyiax7GG5089QdSPUEz3G+tKKCt/HyrQXeO5+n0IPUbuJ6X9EQuDH+5G
	j72x9Idllsk8ge+ZIp3Djg=
X-Google-Smtp-Source: AGHT+IFKRgNnYQo5SKXeCq+aR4b8daUlYumRT0vN594Ss4sWZrwFrQUvkCvgu5KcpC1yPZeMRtXCZsENUgGOxtnC6Ag=
X-Received: by 2002:a05:622a:1f15:b0:4ab:37bd:5aa9 with SMTP id
 d75a77b69052e-4b2aaa561edmr285260951cf.17.1756452000894; Fri, 29 Aug 2025
 00:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
 <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com> <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com>
In-Reply-To: <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 00:19:49 -0700
X-Gm-Features: Ac12FXzWRAQM0EEHa76KEudTNjmkTtWGSKgfhYsP_k53scQmYqSWajgh04eqAXg
Message-ID: <CANn89i+-Qz9QQxBt4s2HFMo-DavOnki-UqSRRGuT8K1mw1T5yg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Aug 28, 2025 at 11:26=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Wed, Aug 27, 2025 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Followup of f45b45cbfae3 ("Merge branch
> > > 'net_sched-act-extend-rcu-use-in-dump-methods'")
> > >
> > > We never grab tcf_lock from BH context in these modules:
> > >
> > >  act_connmark
> > >  act_csum
> > >  act_ct
> > >  act_ctinfo
> > >  act_mpls
> > >  act_nat
> > >  act_pedit
> > >  act_skbedit
> > >
> > > No longer block BH when acquiring tcf_lock from init functions.
> > >
> >
> > Brief glance: isnt  the lock still held in BH context for some actions
> > like pedit and nat (albeit in corner cases)? Both actions call
> > tcf_action_update_bstats in their act callbacks.
> > i.e if the action instance was not created with percpu stats,
> > tcf_action_update_bstats will grab the lock.
> >
>
> Testing with lockdep should illustrate this..

Thanks, I will take a look shortly !

