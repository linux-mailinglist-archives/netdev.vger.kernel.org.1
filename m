Return-Path: <netdev+bounces-204267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF3AF9CD5
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 01:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480601C2795F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09383271444;
	Fri,  4 Jul 2025 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw4C1srG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CB156237
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751673262; cv=none; b=Lx/rlKerU0A1ioyCFfA5N6mhrnIcaA+kf3myXDBUK5LiLcOI0iGrGYlDr2mjQT3AEFaEVaABBAIEVWjxfSZj3n90SSzHn3SXZSRPlITAhWJTmJH0F8FtUjfYBmQhCNxG3NFXCFLyr9W9Axd6vmam5/lKX+m5CvcgacN2RZOphoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751673262; c=relaxed/simple;
	bh=V0xTBU47Qgx0GOfLF9JSCgbYSugS2nWrhW7eyP3cRK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7RaY0NMt3JLZLpkfwRDUiGUV9r2Nzhha0OoJBfQCRcZM9qRtChS4moObN5u6MORHxx5OOIN47Zd/AXykK1JSOljh7+IRjeDrpJmW2MJI0n1TNADfvIXylL08R7D5s4L89a7oaVfsKgZXdLoUlqXUU19bxZm/I6q9+9ILqN/kT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw4C1srG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23526264386so13422815ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751673261; x=1752278061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2L9kJem12eSgr6YZ4XMgbcF7suPbHcisGaW5itGFjBo=;
        b=Vw4C1srGAbUnbWS+TwZKLI9Wva2S7t++0P2kJ7Pimnnw3SSGaSOFU+FHlKUMfeMcKJ
         X8fD5/vHv/9rIMb+I64f9LzAAX2qjx2zhJz0EcN4T8LHig8ADP1RGBwuXNsfdEFl5x6w
         rPtqyiqsxWqnNWGIYP97+2xDQoOfYowUonY2Al9dWzdD3gYjv5EOO4Wpk4oYUIs94+PX
         /wGhk8M81zObh9cMYO1ykbxG5q2wU3zT8UrSJxIzg+W9Tq+yQudl6RIoLtZLe3EqkBE/
         ptjs8IpcAQKBgNBpRZRE+iUp5ucYmV6EvY5KkftFnSnLcHC6lkBF2G/ayQ0RTDSEzcSE
         F0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751673261; x=1752278061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L9kJem12eSgr6YZ4XMgbcF7suPbHcisGaW5itGFjBo=;
        b=dRY4VgCNNl63VvzXF96qEAXb3kx+QEju8xHEyrjf7xpwOeZ2eDdgjido6/m2DRZh83
         tjUBKiRS7SE+Gt/KY3dchDbtGfbpNHMYDiZ3E53aRv6LX05mbH4fsKRkZ1nqRr48iMFL
         S8l+yZPx+MAvWLg3HBAcIHADR+j9OqzhaF9JBuOpBxd4nesyRkDjYBxqGepU+dGefm5Q
         Pv0bjXjGLVazvi2eWz25WEQUoT50c6ia+zWnkyj1ZLNXD5VSde6v8FmYUrbAHGpzdYAc
         1HCCLAcUbRAz/X4EURXbe0YYO8l0zqxG4O6zFYj5LmYvgKzASVpvCz6Xp8thXKc3e5b0
         vXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8+4V/LLV2jm9s2KSG00yqVM+Cbxjq/Gom18Uc38xpyOGmRitDa/jalzSa9N8YyqJzbcPpP1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsaToKrY4TdDs1Dik5adZ5Vv7ROW2y8/fwRn58mpTmcBe41DwB
	f/vB89vTzOVJJYtSPvleumK/dzAx5wrv9e/oqC8h0xH8h4BU054GMNUl
X-Gm-Gg: ASbGncsePkpAmfBtXb0FTtcNCWGzPzRWRrZ11Ka0Ak+oVVinFoa5bl+ldurz00dfdr2
	RN9OgVm6wyExn+ntH7v3TlzagFeLFWBLsYnNIZ/V58gy/fm6oeHMEVtJgFY7w4ONmCY1h72qm1s
	4WA+XJilk9EtpnbxrI9UL0Oc+NGdwapuNx2xTawc9xGaJD1VNY1yMwHnJELDZA1C0NZMHJVYne4
	b18c7e/huHiIHtEn2+R5FZsiWnkotXkuOs3WmMRRU+tQ7Rm9r1DhycSSsJdP0Q2cx3KwVQOQvjk
	U4WhUt5bei8OoaGqZ+88m9Za1yiQFw5FvMnJXFCEOVIhrqv8hrhqKsipuMfof4klTxqh
X-Google-Smtp-Source: AGHT+IFwGakgYPzhEli9n98Rh+goCnmHPuXp6IsKxbcj93P6yZ4n7xesrbOSU/7HCGsJhGGoVcm+eA==
X-Received: by 2002:a17:902:ccc4:b0:235:e942:cb9d with SMTP id d9443c01a7336-23c8747dfafmr49291605ad.17.1751673260732;
        Fri, 04 Jul 2025 16:54:20 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4a21:dfa9:264b:9578])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455ba80sm28730215ad.114.2025.07.04.16.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:54:20 -0700 (PDT)
Date: Fri, 4 Jul 2025 16:54:19 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us,
	netdev@vger.kernel.org, pctammela@mojatatu.com,
	syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com,
	syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com,
	syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com,
	syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com,
	syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/sched: Abort __tc_modify_qdisc if parent class
 does not exist
Message-ID: <aGhpq58BI8mFpCEs@pop-os.localdomain>
References: <20250704163422.160424-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704163422.160424-1-victor@mojatatu.com>

On Fri, Jul 04, 2025 at 01:34:22PM -0300, Victor Nogueira wrote:
> Lion's patch [1] revealed an ancient bug in the qdisc API.
> Whenever a user creates/modifies a qdisc specifying as a parent another
> qdisc, the qdisc API will, during grafting, detect that the user is
> not trying to attach to a class and reject. However grafting is
> performed after qdisc_create (and thus the qdiscs' init callback) is
> executed. In qdiscs that eventually call qdisc_tree_reduce_backlog
> during init or change (such as fq, hhf, choke, etc), an issue
> arises. For example, executing the following commands:
> 
> sudo tc qdisc add dev lo root handle a: htb default 2
> sudo tc qdisc add dev lo parent a: handle beef fq
> 
> Qdiscs such as fq, hhf, choke, etc unconditionally invoke
> qdisc_tree_reduce_backlog() in their control path init() or change() which
> then causes a failure to find the child class; however, that does not stop
> the unconditional invocation of the assumed child qdisc's qlen_notify with
> a null class. All these qdiscs make the assumption that class is non-null.
> 
> The solution is ensure that qdisc_leaf() which looks up the parent
> class, and is invoked prior to qdisc_create(), should return failure on
> not finding the class.
> In this patch, we leverage qdisc_leaf to return ERR_PTRs whenever the
> parentid doesn't correspond to a class, so that we can detect it
> earlier on and abort before qdisc_create is called.
> 

Thanks for your quick and excellent catch!

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Just one additional question, do we still need to safe-guard
qdisc_tree_reduce_backlog()? Below is actually what pops on my mind
immediately after reading your above description (before reading your
code):


diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c5e3673aadbe..5a32af623aa4 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -817,6 +817,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
                cops = sch->ops->cl_ops;
                if (notify && cops->qlen_notify) {
                        cl = cops->find(sch, parentid);
+                       if (!cl)
+                               break;
                        cops->qlen_notify(sch, cl);
                }
                sch->q.qlen -= n;


