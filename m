Return-Path: <netdev+bounces-183140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFEDA8B1BC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F233ADC72
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871C22A4E3;
	Wed, 16 Apr 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="ilooAQAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4D229B17
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787633; cv=none; b=HIuaty9wrhQfMxlJkhveZr+YjypPARHj7GFSBbZN6Y5yxACbBua4rSq2DZJGIvJD3BZTNg5t5mMg43g9Rb9XOB03tnVybgW7AuJI0dQpuqEpHM/rTFvhd7MJKCHyyTZzxm7JcrB9Er5ycfoOwLkbkB48JH2H6HY5DJuj8e9jbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787633; c=relaxed/simple;
	bh=fDqaGhFkh6JXFKvZjvaZXwBrp6VboEd0If3gdo0nOI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivy0j8EkzjpihcrETFOJkrUUclnrY7Ft20cisv5ALNFsENQFucSnkYcfvQipHO1NMNrQjPmx4ec2I32puZOBk9yvpkjbqkNa/hj+Q90tI52wO51oq6HXmiog8+ltYWFlaotReYcUAW/1O38LzL4IkhGsXzUxp7sXhrCReu8x7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=ilooAQAb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac25d2b2354so1002154266b.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1744787630; x=1745392430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytps9MXFkYQg2HKzXOohF8qIk+g98tpzMXPoSm4dxFo=;
        b=ilooAQAbKqb3NV/CLR4bNJK0XTtTFCZDfGZ5RQu5tO/X+tDUoBH5+QJYjS8RkGQbi+
         ekXWFA9RuLyBgYlLlTY3KqNtvIJJkijybGYg4n7RNJ+nl68IjsY9Fg/OaYCtB78P4RrU
         75zG+5GyjlrNhqSIBqZ4OLe2lsfqYLPir0kBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744787630; x=1745392430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytps9MXFkYQg2HKzXOohF8qIk+g98tpzMXPoSm4dxFo=;
        b=Kn+DB4spztgEN//NFxNffJ2Ew9SCXaEXo0bJ4RIXkcTN0PnE0y9tdbFFE5l0b65unR
         kDWO+huhPHWswDsKq4Qbpk4NFnZb+ORGZl8enMjEpcOVtVwA8ujB1ragR6U7wxdhReQw
         SPNJmhS2whKH36o61SCuJEOzCgxyY3Fd0kxK028pLX2QiSb58n70Q/Mp+RgVoy9WAy8C
         unM/YMogzfED8fOkaHppRUUVY0svoZgGsmYVZjLiblYuScwYyCyNzH5leqaQW06wdLrz
         Sg3DCvXajqte9vGgv2phww3bhtbW85USTrRv2CiGbvwN73uvW/bvh6mOm6oxu2ET4eXT
         21aw==
X-Forwarded-Encrypted: i=1; AJvYcCXaCZx59iFLjX/Egbd/X4kZzilpejIKzaFtnjfM5GUa4w4zXyFX+Fzw9VMt1LJ/+DQrUBV+FK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdPIgwLY9+wX22Rg+e56zsl9yHw+pYxZjkzGVNPCIs0KQ8xTp
	D2lqDUiQH6l4Zz3elQp6WBYa0kJvSi/iHpSUAVQfin/H9leJc2dKInECj/qigeqg85tGUmEBi1o
	ZAUSjXgqGZPjQFIp//Yx31qI4xawe5PfVwpOW
X-Gm-Gg: ASbGncuf6fsb+BBF4XZpY78duj16/iJeg1Oeu6Ule2RsgKm/Tsl1p+58CWxals16FdM
	TRAp8tQzMoz6KbyZwqDm6eTseg4t1sMR1R/taR28MPFIgGOQlo21Vo/qYPZvVKOCwU05lh5aVh6
	FJj/a3PNLbdhOmWQL+q4GA66A=
X-Google-Smtp-Source: AGHT+IHlTpFnMolX4gA/g52IlQ/tj+gId1djCIyzYs3WB7wppB8zFUXCjOn8eLYzAYWPBdKWahOXUFyZX267yJlGJFg=
X-Received: by 2002:a17:906:dc92:b0:ac7:1350:e878 with SMTP id
 a640c23a62f3a-acb42ada144mr47984366b.46.1744787629490; Wed, 16 Apr 2025
 00:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com> <20250415175359.3c6117c9@kernel.org>
In-Reply-To: <20250415175359.3c6117c9@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 16 Apr 2025 09:13:23 +0200
X-Gm-Features: ATxdqUHJ7umUsa5H672lz0ujM37fgVLtcRbHcVnssplk8IlpJ9rF17FKH2YfqGI
Message-ID: <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
Subject: Re: Increased memory usage on NUMA nodes with ICE driver after
 upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, jdamato@fastly.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Eric Dumazet <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 16. 4. 2025 v 2:54 odes=C3=ADlatel Jakub Kicinski <kuba@kernel.org> naps=
al:
>
> On Tue, 15 Apr 2025 16:38:40 +0200 Przemek Kitszel wrote:
> > > We traced the issue to commit 492a044508ad13a490a24c66f311339bf891cb5=
f
> > > "ice: Add support for persistent NAPI config".
> >
> > thank you for the report and bisection,
> > this commit is ice's opt-in into using persistent napi_config
> >
> > I have checked the code, and there is nothing obvious to inflate memory
> > consumption in the driver/core in the touched parts. I have not yet
> > looked into how much memory is eaten by the hash array of now-kept
> > configs.
>
> +1 also unclear to me how that commit makes any difference.
>
> Jaroslav, when you say "traced" what do you mean?
> CONFIG_MEM_ALLOC_PROFILING ?
>
> The napi_config struct is just 24B. The queue struct (we allocate
> napi_config for each queue) is 320B...

By "traced" I mean using the kernel and checking memory situation on
numa nodes with and without production load.  Numa nodes, with X810
NIC, showing a quite less available memory with default queue length
(num of all cpus) and it needs to be lowered to 1-2 (for unused
interfaces) and up-to-count of numa node cores on used interfaces to
make the memory allocation reasonable and server avoiding "kswapd"...

See "MemFree" on numa 0 + 1 on different/smaller but utilized (running
VMs + using network) host server with 8 numa nodes (32GB RAM each, 28G
in Hugepase for VMs and 4GB for host os):

6.13.y vanilla (lot of kswapd0 in background):
    NUMA nodes:     0       1       2       3       4       5       6      =
 7
    HPTotalGiB:     28      28      28      28      28      28      28     =
 28
    HPFreeGiB:      0       0       0       0       0       0       0      =
 0
    MemTotal:       32220   32701   32701   32686   32701   32701
32701   32696
    MemFree:        274     254     1327    1928    1949    2683    2624   =
 2769
6.13.y + Revert (no memory issues at all):
    NUMA nodes: 0 1 2 3 4 5 6 7
    HPTotalGiB: 28 28 28 28 28 28 28 28
    HPFreeGiB: 0 0 0 0 0 0 0 0
    MemTotal: 32220 32701 32701 32686 32701 32701 32701 32696
    MemFree: 2213 2438 3402 3108 2846 2672 2592 3063

We need to lower the queue on all X810 interfaces from default (64 in
this case), to ensure we have memory available for host OS services.
    ethtool -L em2 combined 1
    ethtool -L p3p2 combined 1
    ethtool -L em1 combined 6
    ethtool -L p3p1 combined 6
This trick "does not work" without the revert.

