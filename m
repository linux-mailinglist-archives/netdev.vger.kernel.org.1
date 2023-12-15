Return-Path: <netdev+bounces-58140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DB815488
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 00:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF621C23064
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1318EC6;
	Fri, 15 Dec 2023 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM9M2F7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6843487AB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67ad277a06bso7917106d6.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702683067; x=1703287867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXyd7JwSYM5vT6fkB/KBkVxMYalc6j8ligugQr4gKwE=;
        b=FM9M2F7PdGUBbXa60oony/2vya5LHG/3bTuww9phL7Q8M6LcmubkSMIsA2CuVQ1/3L
         DLN664mjr+YMP9YfnCD+EEg8qEoRS1Kv0gwdknBYj6l2Ur051zbc9TQaZG2BNc/oSZu3
         yTYJZacC6XLK9VyYCBFeL7McfUUSlrXUw53OEjRNi33q/DhHaXgOTzvUvDpxFpC+EsZ4
         Vv9s1ypAgd2vjti/Sl7af8uBto9uEh55qaOOrAlo9AtaK13KKYwvRmEQDvaMK0YQ4m/c
         8Q2f0655cghhj6OF6MGFDL1H4FzWQSvZj7v/nza5A0Urv94qpCdS6PR85cd/RlUQrGMm
         P70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702683067; x=1703287867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXyd7JwSYM5vT6fkB/KBkVxMYalc6j8ligugQr4gKwE=;
        b=ivQk3IXmL22Ak/teByYW6ERxdtma5c3hOG5IkJyUoDxgCbSoFOQA8Jvix/5HU85bdU
         emegJnZN+XFHKSLFIx7h/7bj1RCjd+kUn/FUYT5KRnsGmf4WjDN8aee+Gi5E1KL0f5i5
         sm+/DjEQfEFBpqvJtuyFEVJm7vMyP7hE9bhtjSBdAzfAu8Y4Etc+FO75veMgP+G0/UoX
         uuKHt6yupY0NDFRZLbp6HpvvEhp8NYnwIXdBtyiZ3TDm1McFafW+ZOys2OHINbVmzyr+
         KONyde9rX34UneuqfCkUpd5C2wEdD5Hu7hz+aHWJim+6wlUD9ohq2SthoTZuTqyCobJW
         GNWg==
X-Gm-Message-State: AOJu0YwldRAGa4gcPeGol8Kf93OKoOGFzCkECSDRIEARC5nP6b1pHJvI
	4kabKJzEwAIxAVlzImKv5gU=
X-Google-Smtp-Source: AGHT+IG53KnmOiBoDbVw1h5Vg4HYpz6lr9dN1oqAd3CvpFKyXRLVERDU9Bby2KzeDjuJtIyDuAsx0g==
X-Received: by 2002:ad4:48c6:0:b0:67e:f713:a07 with SMTP id v6-20020ad448c6000000b0067ef7130a07mr5353561qvx.106.1702683067523;
        Fri, 15 Dec 2023 15:31:07 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id d5-20020a05621416c500b0066cf4fa7b47sm7248275qvz.4.2023.12.15.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:31:07 -0800 (PST)
Date: Fri, 15 Dec 2023 18:30:58 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Patrice Duroux <patrice.duroux@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXzhsiSX2bPlEkL9@d3>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
 <ZXqpieBoynMk0U-Z@Laptop-X1>
 <ZXt6_4WCxYoxgWqL@d3>
 <ZXu7dGj7F9Ng8iIX@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXu7dGj7F9Ng8iIX@Laptop-X1>

On 2023-12-15 10:35 +0800, Hangbin Liu wrote:
> On Thu, Dec 14, 2023 at 05:00:31PM -0500, Benjamin Poirier wrote:
> > I started to make the adjustments to all the tests but I got stuck on
> > the dsa tests. The problem is that the tests which are symlinked (like
> > bridge_locked_port.sh) expect to source lib.sh (net/forwarding/lib.sh)
> > from the same directory. That lib.sh then expects to source net/lib.sh
> > from the parent directory. Because `rsync --copy-unsafe-links` is used,
> > all those links become regular files after export so we can't rely on
> > `readlink -f`.
> > 
> > Honestly, given how the dsa tests are organized, I don't see a clean way
> > to support these tests without error after commit 25ae948b4478
> > ("selftests/net: add lib.sh").
> 
> No worry, the last way is just make net/forwarding/lib.sh not source net/lib.sh :)
> Although this would make us copy a lot functions from net/forwarding/lib.sh to
> source net/lib.sh. So before that, let's try if we can
> 
> Move all the dsa tests back to net/forwarding (actually only needed for
> test_bridge_fdb_stress.sh). And add a forwarding.config.dsa.sample. Maybe
> a test list for dsa testing. But with this way the dsa testing will not
> able to run via run_kselftest.sh.
> 
> Or, we can remove the symlinks, and add the dsa tests with exec the relative
> forwarding path's tests directly. e.g.
> 
> ### in das test folder
> 
> $ cat bridge_mld.sh
> #!/bin/bash
> ../../../net/forwarding/bridge_mld.sh
> 
> $ cat Makefile
> # SPDX-License-Identifier: GPL-2.0+ OR MIT
> 
> TEST_PROGS = \
>         bridge_mld.sh
> 
> TEST_SH_LIBS := \
>         net/lib.sh \
>         net/forwarding/lib.sh \
>         net/forwarding/bridge_mld.sh
> 
> TEST_FILES := forwarding.config
> 
> include ../../../lib.mk
> 
> ### for net/forwarding/lib.sh looks we need source the ${PWD}/forwarding.config if run via run_kselftest.sh
> 
> if [[ -f ${PWD}/forwarding.config ]]; then
>         source "$PWD/forwarding.config"
> elif [[ -f $relative_path/forwarding.config ]]; then
>         source "$relative_path/forwarding.config"
> fi
> 
> What do you think?

That's a good idea. Thank you for your suggestion. I made a few
adjustment from what you show and the result seems to work so far.

I'm working on the full patchset. If there is no problem, I'll post it
next week.

