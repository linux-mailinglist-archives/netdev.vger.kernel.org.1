Return-Path: <netdev+bounces-132463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D38A991C74
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 05:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C384AB21D69
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 03:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDF1684A3;
	Sun,  6 Oct 2024 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0WvuoJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7914A0A4;
	Sun,  6 Oct 2024 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728186764; cv=none; b=BzvMStrjM3srqwJORjhhMMBeRQ+96eNhLySJau/ZwvcWDQjfUKzoPDd2y4z9w77VkZHz9tltJWiA3Qcwd9K0OSf4UANKk17ImXa/Sv2EAAn37mx184bQHqZnWMc75MVGJ8R3cxkONTvg1+6xE3K64FEJ+nBAnihRW6PJULIKrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728186764; c=relaxed/simple;
	bh=sqoKFx4ckzKFeUm2RV6/VwWvdqyTFwqsQAGVvuO1vO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjatG1QM/cwftJs1bdRkMYKSqGm7k3BNRaCrdHRzVy8+G7SE4uW2a4UZSSy23RQ8eVCJTUvH6+HJ2SrMGSMPCimu9l8tW1jQ1pasg2f5tLH4IMgrbXphRYoTscn7C7o98msoY+2JTprAdLgAXCLmvsJDC+C8KX1b0fGjdJ9bJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0WvuoJ+; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e28ad6b7f1fso532460276.1;
        Sat, 05 Oct 2024 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728186762; x=1728791562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KLxMc9KE7ql6n4IGzigqpAhLj3RURiWvBkkJH5yA5s=;
        b=C0WvuoJ+NcLTGQ3z+540oB4XcAaLsdRt7S2d85VCqy+sQX5+by3QmMpxJnVU0HwWyy
         W621Tur9ozjf04IwHp59qMTsyEjpeFKVYfGWHbSAbJMpOlsQg1QYwkXHLTtSJTdsYHb1
         SyJC4xZn0yUUA9mQ+eAIegQQzBDOgUXT2JTFn7b5cFUOa/QV7Xf2Xjz8qWZp8g4vkely
         auD5YPjb41qWrTKJcJQKVBntlLIbuGD1M2RmMUdxARkexyqvhBJXiv2LMyPXUc3KNcw1
         v9uiHldabYcu57mbl6Tfr/lNQx4ncm0qws0sq/AM3tE/SKrI6yWuLx8e7stMyWwBGX6/
         wuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728186762; x=1728791562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KLxMc9KE7ql6n4IGzigqpAhLj3RURiWvBkkJH5yA5s=;
        b=q2XToB2XiPNmR2YVCGIRN3YNA3J5d27c/Ct5MilplgnIrnJNLgak3xC9ZmpSlAH4ma
         zc8u4gk3aqa4S4uwSKBvvH3ovus38eLUAXJHEuHU0kxxMWJOdYeFOJfQGmFt0BcHYPMf
         FyopbJOP6RyrR0KXklLJ5geC140CXbhgRSIs53ug31dG0d/5RQf+QUzQCndDNhWYlmG/
         BYUb0BOKth+3gCS8Rj+4DLhvWCFRT12aNUELlFWTIAstCf5jWv/C/0fkINdUAYHgnj4b
         UJol2wDzhcItEWr0UsTUAmdU9KrFoAEmJl5gzkoFYtu2BZ4wel0n/Vf6/WfNzInOd15D
         /7nw==
X-Forwarded-Encrypted: i=1; AJvYcCWEJtf0+wxR+znP90Ta57VCPfBERh3I/qski8Rw5Rp69TlkaivFLtDSUUXirdVWg+6JMBaJ5DVAYsfE67c=@vger.kernel.org, AJvYcCWPEgNZB3bfvEfci9Ud3VbhogyfgCybkHjo88mvK40K9JICFaVK6o9x82jvs9Jdv8VRP0dY+mqy@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcaoHtMWddpE/ZEAPL5wMABOrdzIog5QbvZF+9SPpEI4H124l
	H/rCptJGLbLCadwQMVVZX/+QzjzeOIead3JauqrT91MnIKzPIGtdRb1yd2Dq9DQXvpxZrkgf5GE
	ebBb//cbHtXcc9lj29wZKCiJhGlc=
X-Google-Smtp-Source: AGHT+IEJ9KdRg1WDBQoTncKK++Of7CLlpXjvTN9qol6tJ6LueV59IWL2zDc1A4q3YNskFiHFBsyk0yldB9RC/uc/jco=
X-Received: by 2002:a05:6902:2b8f:b0:e20:16b9:ad68 with SMTP id
 3f1490d57ef6-e2893951b87mr5430464276.45.1728186761928; Sat, 05 Oct 2024
 20:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-8-dongml2@chinatelecom.cn> <20241004094630.129b900f@kernel.org>
In-Reply-To: <20241004094630.129b900f@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 6 Oct 2024 11:52:35 +0800
Message-ID: <CADxym3YJUWA549n2C2_BqEmzgn1RE6RFqbgDLz9oYtac56YRcg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  1 Oct 2024 15:32:20 +0800 Menglong Dong wrote:
> > +      * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to
>
> capital letters: MAC
>
> > +      * the mac of the local netdev.
>
> mac -> MAC address
>
> MAC is a layer.

Okay!

