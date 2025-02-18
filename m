Return-Path: <netdev+bounces-167143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13013A39035
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140393AEB09
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52566175BF;
	Tue, 18 Feb 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eST+RQbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93D749A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841363; cv=none; b=ahWImAQmh2576ccs+oWYDz2qkjN0q7Yy5FEMezIoNnj78awtZZTBSUCit+P+dLNGs12pgmr23gcGyFjceaZIoxxTkp2giP6THYe4WugK+05LcfE1TtLPLz3Xpeb3F5bT2TwiGwiFfKceFS/rboxetNvh9UCZu6gn/UDGs5OnGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841363; c=relaxed/simple;
	bh=c96gpI3S8UJG56qZfDxF+ZGdSngT0Uf5l40a4NVDdD4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XczzGDvW+ueTFsdASJ8UydqXTwZ8qL4+eMOfVP9MuXvVWSnxnILIxg2R8i2grV0LlNyzBCU/W85HqR3m2GlCi+nUEkqELTBXNlCtpkV3IPh1hxErUX7/lXqdHKLRFkSo3pKz+taCLYZoQ14Dr37C+mVEM9lWObvTTdKB5KqcC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eST+RQbS; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be3f230436so473489585a.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739841360; x=1740446160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHfk3HWANkUyRzgLTqKLxR+sNNQ7jDMgO3ACj8ZnzPM=;
        b=eST+RQbS7yfg2WJ8cuiaiJt3PmefdkXHaBGIsgWBcyTSLgxBHqzb3MpISMYY2zgFLc
         vHei0ManCSIRNr9EXgTpejbYKPSatn494UOXUipbXvFpllTTyPKJDPilfUNNjn+ZZ2U7
         ai3w6mAGkkPGFd0Bsjq5GcY7OxDxWO5+o5pKqxx1+JWaksMap0mmPWZkvuS4+gZ0laTr
         MNrx21ZoHshKPtkHCm33NT7TnTocwIqomiRugS7sq3ohtuiFmmuwqXriqUyIFUe/gSGF
         bQNc0gDOUNWai21DkwUKf8sgvKjqw16a3YLFjEuegDgPTmB+k8+xpc9mW6AGKrq69GAX
         Kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739841360; x=1740446160;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aHfk3HWANkUyRzgLTqKLxR+sNNQ7jDMgO3ACj8ZnzPM=;
        b=KUPpcp7f3p+7kjIxp4ASc5+8nsf62hMYBSgRluGrUk7c1/vQAWH9R4XqqfS7ZZt6b4
         FAqQVzB6thlDUGvXRBKk3dIaj1JnFrKO+iWc9YxVwThP4ybYRAQ5/eT7N09yhWqbjeqC
         NjlZ8IuD1Qd03aS2QPW1IAliR4KWCaCG6igsDEhrf9juhf5peWMdcZTYSpJlc4sjhZRe
         C5Pz4S2UQUahMT9ooDwOgCgkvwfmVxrCO1YwD6Xw2R8PI9uGGKau2OIIKT+sV70QxxfM
         NDg7IUpclRhmc2bhV0BlCXe6ukTGSCpc2FdQtfJabMpIB+bKYMS+ZDx+zXlVvhj1u9tb
         5WSg==
X-Gm-Message-State: AOJu0YwmWQyl1fKXufwOfZUBc7dC9oq3zwhHDWnTTYZnHFTiU8FGtnE5
	ARg9ieh5smjcMAHyRBISmnwFN6MWTEAx6CNJgbwtD928L5Bc7d06BrSyGA==
X-Gm-Gg: ASbGnctIp+BehIQ3drrSgHxl3nw25qRARxFOoV/tIioFUz34EwRr+eQJL04ybce40ow
	rA56Tm8BPk9y2ynbkDwlYoKz9yZvuC8EClbAp5rTxLJslgzZQnyhbR/DrOaXuC5I3PcZWUdDMxI
	Ha3PZLQlXtQcTkJ+4O8tazv6RAbIOpprq9fqYN9jAXq9klrZfcqnmJSR7aDfvRqoFmu5VzymDr+
	neooS0CjAgcXMfZJiDyPRchCOGwUi8ZhaRHUl720FhbrArFm4q/3kBlBpyAUq55PoHnyfrMu+07
	vAx4IN0fAl+IjejiYLfVXysKN0UdDC0I1cqYCV6eQP16lMzekGo+9fgJvElGurU=
X-Google-Smtp-Source: AGHT+IFwd6vMJyb95oQ3SBNnd71yV2Tzs+LQa4SNRCvfgKShZGVCc5MuZbJ0BgitJ3hePP1ow622cQ==
X-Received: by 2002:a05:622a:510b:b0:471:959e:bc13 with SMTP id d75a77b69052e-471dbe6d99bmr162406621cf.40.1739841360573;
        Mon, 17 Feb 2025 17:16:00 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47200649214sm2473501cf.74.2025.02.17.17.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:15:59 -0800 (PST)
Date: Mon, 17 Feb 2025 20:15:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b3df4f8d88a_c0e2529493@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250217194200.3011136-4-kuba@kernel.org>
References: <20250217194200.3011136-1-kuba@kernel.org>
 <20250217194200.3011136-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: store addresses in
 dict indexed by ipver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Looks like more and more tests want to iterate over IP version,
> run the same test over ipv4 and ipv6. The current naming of
> members in the env class makes it a bit awkward, we have
> separate members for ipv4 and ipv6 parameters.
> 
> Store the parameters inside dicts, so that tests can easily
> index them with ip version.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -8,17 +8,17 @@ from lib.py import bkg, cmd, wait_port_listen, rand_port
>  
>  
>  def test_v4(cfg) -> None:
> -    cfg.require_v4()
> +    cfg.require_ipver("4")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> +    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> +    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["4"]}", host=cfg.remote)

Here and below, intended to use single quote around constant?

>  
>  def test_v6(cfg) -> None:
> -    cfg.require_v6()
> +    cfg.require_ipver("6")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
> +    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["6"]}")
> +    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["6"]}", host=cfg.remote)
>  
>  
>  def test_tcp(cfg) -> None:
> -- 
> 2.48.1
> 



