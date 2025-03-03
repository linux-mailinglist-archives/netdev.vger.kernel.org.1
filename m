Return-Path: <netdev+bounces-171276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CB6A4C53E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D691886F69
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF22144C1;
	Mon,  3 Mar 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLOsbZCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5715855E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016032; cv=none; b=nD7l6p1tux4d7bU1OpYZG6i1opFUqDBPWq3YGQHB+FOVotVTyIh742muJ7YVIOCAEPLeUudjep/l1/oTiBiGdM9FOyETT/+N0RW3tI5iftJe+76JlY0NUsQ+zAlmxl+YVviyOc8DsyAX4pOlKvyylVma1Fg7zfh+3ynCNjXUAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016032; c=relaxed/simple;
	bh=qWv/DZ3PiFKJkOq8v+Tqx/6fZRmjNa3E+abq+HZ9bDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc57wF+svKqujxZQ28rjpwY9CDYJpjU4wOXG+5psnpwTO6PgaLn3qDaadjYRm/aNs9Ptgh5mb8WQHsahzdEXGo3nPu2yPtL7ZvbqSbj0cyUGmmKH8cdcsabnKvKVc5zZegf4ivavGABbJeeHt8v7t2U/hqaIe8B4rQ1O/BCOa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLOsbZCu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso2678956a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016030; x=1741620830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDkOh2ZRzYOeqKDXPVKif9e+xmcfsWiy1In0ytBdbIU=;
        b=iLOsbZCuom2mWtd05eLTDNljWr4Gt86PWppSXzjS33tZnACSilMI5RG29i941VXihm
         xjRB5GjtGAK/Emm1sb3ixXfIdhPrmgjQ8tjFDbDbOHxozADe1wJcCM5xdrHT6phwmwvw
         lIe6Kh/dNetJs8WYjSaUpgeGK+CDEIOBuMLSZ8xGifsy/+Waq3K4iErqs7BeQpUtqupU
         XEezJ6H2EnfgqyMLybA26al+PWjRQ7yi9YTVcuT+Gu9GKSMfeMGOPS3z/+h15xYabKfc
         kGpzD+FRQb1wZR8j4YzPcw6vBmPE95fyzwiuTxxKXgnA98c/1Kf2wiTyy10zeA2uf83G
         GU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016030; x=1741620830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDkOh2ZRzYOeqKDXPVKif9e+xmcfsWiy1In0ytBdbIU=;
        b=GMVGG3KPYgsxMbsXlGJtfanZcG8UYMxj8Pp4MXWt8r+vAh+rHAKyFxVqPThSo7Oz23
         c4Ocl0KQfgwhWSLqy6G7w0Pen8m/zapYLxv+L/XNaFfUqj/EN+ZPSeCgy3nR9XG++99q
         h8oum6mZwunxkIKIUCEGo92A1qQgXvKMy59Joe+y+xLK57sKlWif6PNbsj3AM0CRIyve
         rGMPJf4ksQ6INtMOUzpkBeiFxMkdeVA34KHDY5pnoHsR/0DRHv2VGnAPDogFaoHzajPq
         FV/8xDZOS2MGmd00yL9pYeBYkI1FTEI8IhdZv4K7nXLKMtSUfHgaiv4YEnzZW9bx1/jD
         29/A==
X-Forwarded-Encrypted: i=1; AJvYcCVr99f8WJAYShBZAMUJPn1jqYsLvTFGHesf9g24bq7bLO5Zcr98ASmk5qLr008vPmRwCP3L+Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VBF1wczRXmptdESKlas5ELv9NKmdiBOK8uUhJyQDeLOkFzFt
	KWPttQi/la0/z+ehhVrhtuO/Sxc2F+cDC4jR3OJX9Gg4IUE7Pjo=
X-Gm-Gg: ASbGncu0fYexyCJJmSC/FDgephZaIKc0hMEq+DFnPEUTIu5NuCQaKFqXmqiNo6mgcmx
	iln7bXX/XJgqg9WcRBBuh/ReZpF++fcDqFiSevzYV5mbx+9JuHPvyZcGmRacIVKmy21xpdPfPj5
	zblqqgEQnDftc0UMO210zgjBl19o4oHi1AaEEkb/jZHJPE7ohK977Op+xBOLpYZclzT+tPO91/3
	/ttr86o+6/Sm8iiM6OroY0KXFr3U4VUHqQCX11cOl4N8DDRsnOdSnopUyVX32ct3X/yYCL+3A75
	T6i0MDprn8p3ld4VsR0YrJgMg9MBoBbGAoq2r1nfwNZr
X-Google-Smtp-Source: AGHT+IHVaNVa9eRT3dmAeGrEH3YRyB/YfOIfETxcR7saQg/2sPLRiTrY5v9n6nR13V2gnAJjOapSNQ==
X-Received: by 2002:a17:90b:268b:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-2febab7863amr24650912a91.16.1741016030260;
        Mon, 03 Mar 2025 07:33:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea679dc51sm9138225a91.21.2025.03.03.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:33:49 -0800 (PST)
Date: Mon, 3 Mar 2025 07:33:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
Message-ID: <Z8XL3T8sOM43BnEc@mini-arch>
References: <20250302000901.2729164-1-sdf@fomichev.me>
 <20250302000901.2729164-4-sdf@fomichev.me>
 <CAM0EoM=jOWv+xmDx_+=_Cq2t5S731b3uny=DWrVX4nba3yjv7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=jOWv+xmDx_+=_Cq2t5S731b3uny=DWrVX4nba3yjv7w@mail.gmail.com>

On 03/02, Jamal Hadi Salim wrote:
> On Sat, Mar 1, 2025 at 7:09 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > In preparation for grabbing netdev instance lock around qdisc
> > operations, introduce tc_xxx wrappers that lookup netdev
> > and call respective __tc_xxx helper to do the actual work.
> > No functional changes.
> >
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jiri Pirko <jiri@resnulli.us>
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/sched/sch_api.c | 190 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 122 insertions(+), 68 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index e3e91cf867eb..e0be3af4daa9 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
> >   * Delete/get qdisc.
> >   */
> >
> [..]
> > +static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
> > +                          struct netlink_ext_ack *extack)
> > +{
> > +       struct net *net = sock_net(skb->sk);
> > +       struct tcmsg *tcm = nlmsg_data(n);
> > +       struct nlattr *tca[TCA_MAX + 1];
> > +       struct net_device *dev;
> > +       bool replay;
> > +       int err;
> > +
> > +replay:
> 
> For 1-1 mapping to original code, the line:
> struct tcmsg *tcm = nlmsg_data(n);
> 
> Should move below the replay goto..

Since nlmsg_data is just doing pointer arithmetics and the (pointer) argument
doesn't change I was assuming it's ok to reshuffle to make
tc_get_qdisc and tc_modify_qdisc look more consistent. LMK if you
disagree, happy to move them back.


> Other than that:
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thank you for the review!

