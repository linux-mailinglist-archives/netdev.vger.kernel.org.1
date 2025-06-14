Return-Path: <netdev+bounces-197687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92372AD993A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38693BD096
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D1B663;
	Sat, 14 Jun 2025 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kISyZmJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9AAD2D
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861984; cv=none; b=n3Nh0f3fRa4EHwZ3bwfLmaj6t4n/X61XpFc7L2U5rz30BKp9xWFadEpBchWyTJ2wVhOIiV3V512PIOBp9io9WUP2ytSBAF9/zMMuaMGhj0dotUegEkWiWQPGb/K7z4X6aJNe6klvnjv4COfBixsqyMA9YaJEp1VRy/wFf1k+LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861984; c=relaxed/simple;
	bh=kvLVR0rFkFm+KAuox1ofjtYqBvxSP/DkqDZLCgfu/aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPgN1SzRjhuxAs9ORjy+AhvWvzCj7envbWxVXEjKZfUKOZV6WT0eFD1RU8lMDhLumdU+ecSvPXoi7D7WMZe5w+CQ+eurrse4ZEbJmUZO/frM954fFne4IMyPusmZ1ni6EN5EYW+7pAEbaTbt22sdOJ8YY5yu1rzxfeYhfpJKjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kISyZmJ9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23508d30142so30244085ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749861982; x=1750466782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7a4YXtK9X7cluL5CJrrZT1WSfx5XqHDNZu9OH2FafwE=;
        b=kISyZmJ9vRJuDgoKHxVXSdnMF//Y96Rzrp6CFksbW7k/y/78kcuwFnEg7beNLDmKMb
         /eYOLXJtY1IRdwfoAAT6uJIVdUoiHOJVzowuQ/jRDDk7nWcS8MLa1h8iJXN5fhRxm/qC
         SS60MiO8VPIFPrtNA7ps+KxqBSmElobsO4QNx3ZdLx67n9EgHEZXB6RmkmlfJ9QYetwi
         +SkSvSvBBLFRMfvWjJXbBSJphqfFNuYZck57YQOiiplrcDL5u1+fEATUW2XmuBsSFh4b
         0SXkGqC2f1Ulm7AfQD61ILtNvhwVNbBwpC4j6fw09Sc9xeUtVgN9LUESQIsIdAhMrsHb
         wr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861982; x=1750466782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a4YXtK9X7cluL5CJrrZT1WSfx5XqHDNZu9OH2FafwE=;
        b=gwQg4uuoOC+fwQweJD4sFjsRkJz6Dt7lDjpRkvBSWZS+ZPk9Ma2mek7aEu6uC50AO/
         f5D/7K3eeriMnsWix/KJcEVriyp8E7dprB+2Nn6ITJPjgxzdBhNmLpHLTqpDQqJqn08+
         p7CJKXLhrQF+Wwo8ytMfyGEAKq4yOR8HTf+lMvzEsUI7nf335ScXI5onSoNamfkVitvA
         HDlZsHiTxqSVgUvZGglHBFamyWMZ6Tzrv4pfe4UCZfy9XdHt8AJlB7snk+hWPDVfz2Bp
         sFmOEv+6GXO/BzRZUutIUjxMr2urhbk2Pf+VkhuBt6SyC/YGZsU1aQz1obBZf/MSbakN
         rfWw==
X-Forwarded-Encrypted: i=1; AJvYcCVYpdeHvJbYZMEPBNWYOLyEo8h63jXrwMRpEFSndHB+n27vtnNM5Psuos+bCPowWl87n+CS8Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4tgP+3ztDbxVa0NK9taaKTpz2toVSqH+JiQ7rh5bPUd1qogA
	JfXqwMemukYd/WhT4+9csNvv1zmlLF7LkzcTh+MtPaRj4GRvOInx8cP0
X-Gm-Gg: ASbGncuINbaPIp/31Cmbj7SKOuKlPW9qoOT6uEu/wWiVekrQ+woT/u2+F0vnI/82Lmz
	3I/fbX/9l6ROFgCEhq/EPH5x/7ADQZzFtr/xxaJr1lNMHAWBCSfrudGManHhbA+JbaJCAMJnZ92
	PQqtrE6ZuKfi0R7GjUjUddUPj4ydJAAXRD6ulKznLRsw/0GrRfhsRmYzhIBqeTXtJOZIi5mMs02
	3r9wfaE7BMkm5bqEdoBIvmZr2jygYKOvrt/FEdluj5FyDaWTwSqKjrv26Y5ozhRO6CQmCRJSgrd
	icd/zxpg+FJ6CE9mxPjJT8ofXMaA1gTy+z3TQFLxn3vmz/M9C+yXcvs6xwmCSwQfQCygWyCplp4
	LQw==
X-Google-Smtp-Source: AGHT+IG9thfcw07lVz23IVsM0piz1tcQd3aU9WLKQfxV3Glfch7VPID3Yy3pdM7VYNwbVZ0rHZlDQw==
X-Received: by 2002:a17:903:1aae:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-2366b149d07mr20388955ad.40.1749861982024;
        Fri, 13 Jun 2025 17:46:22 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bef8sm21096555ad.30.2025.06.13.17.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:46:21 -0700 (PDT)
Date: Fri, 13 Jun 2025 20:46:16 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, vinicius.gomes@intel.com,
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io,
	imv4bel@gmail.com
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aEzGWJcwga+FyNo0@v4bel-B760M-AORUS-ELITE-AX>
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
 <aEs3Sotbf81FShq3@pop-os.localdomain>
 <aEucrIuj7yxTX58y@v4bel-B760M-AORUS-ELITE-AX>
 <20250613205206.fssf4bi4wjgyy53x@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613205206.fssf4bi4wjgyy53x@skbuf>

On Fri, Jun 13, 2025 at 11:52:06PM +0300, Vladimir Oltean wrote:
> On Thu, Jun 12, 2025 at 11:36:12PM -0400, Hyunwoo Kim wrote:
> > On Thu, Jun 12, 2025 at 01:23:38PM -0700, Cong Wang wrote:
> > > On Thu, Jun 12, 2025 at 07:16:55AM -0400, Hyunwoo Kim wrote:
> > > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > > index 14021b812329..bd2b02d1dc63 100644
> > > > --- a/net/sched/sch_taprio.c
> > > > +++ b/net/sched/sch_taprio.c
> > > > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > > >     if (event != NETDEV_UP && event != NETDEV_CHANGE)
> > > >             return NOTIFY_DONE;
> > > >
> > > > +   rcu_read_lock();
> > > >     list_for_each_entry(q, &taprio_list, taprio_list) {
> > > >             if (dev != qdisc_dev(q->root))
> > > >                     continue;
> > > > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > >
> > > There is a taprio_set_picos_per_byte() call here, it calls
> > > __ethtool_get_link_ksettings() which could be blocking.
> > >
> > > For instance, gve_get_link_ksettings() calls
> > > gve_adminq_report_link_speed() which is a blocking function.
> > >
> > > So I am afraid we can't enforce an atomic context here.
> > 
> > In that case, how about moving the lock as follows so that
> > taprio_set_picos_per_byte() isnâ€™t included within it?
> > 
> > ```
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 14021b812329..2b14c81a87e5 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -1328,13 +1328,15 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > 
> >                 stab = rtnl_dereference(q->root->stab);
> > 
> > -               oper = rtnl_dereference(q->oper_sched);
> > +               rcu_read_lock();
> > +               oper = rcu_dereference(q->oper_sched);
> >                 if (oper)
> >                         taprio_update_queue_max_sdu(q, oper, stab);
> > 
> > -               admin = rtnl_dereference(q->admin_sched);
> > +               admin = rcu_dereference(q->admin_sched);
> >                 if (admin)
> >                         taprio_update_queue_max_sdu(q, admin, stab);
> > +               rcu_read_unlock();
> > 
> >                 break;
> >         }
> > ```
> > 
> > This change still prevents the race condition with advance_sched().
> 
> This should work.

OK, I’ll submit the v3 patch.

> 
> And I'm sorry for the bug introduced here, and elsewhere, by assuming
> rtnl_dereference() will be fine.
> I mostly use taprio with offload, where switch_schedules() runs in
> process context with rtnl_lock() held, not the software emulation that
> changes the schedules from the advance_sched() hrtimer. Somehow the
> different locking requirements for the 2 cases eluded me.

