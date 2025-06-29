Return-Path: <netdev+bounces-202282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62102AED0C4
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3C93A95C6
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6332512DD;
	Sun, 29 Jun 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcXYxd49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A212494ED
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228208; cv=none; b=MuCPdgEHctdCpLNaA+o9cz9LsPSoC3Bp2T25rnWJ956tEuGc89rXb0TouIZxtRRzopUjK9qrq2etMTSi9sb7DrBgRFZEM/wgrutzSJWTOBJFiKM/wmV437UQ8bnDWskCfqtKAaYSqkZmM0Vmxq3AjjbHK6QJO1UrgZVRXI9Xv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228208; c=relaxed/simple;
	bh=obW0PJ4h6gB+B3Ezt0SWUUTstj//t8flS/u5Z3Nr9do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erdHq3ZJPWUo0tyjbAvMWWqn32EWYNr313jfasJwNo8A8KzDAm3zVRoSzrDHAMdscg27faMhyGwIY3KFSgGzEONo5f5C5oOe1l/dZ9INrB0QrcfH2xtHNPsjy7tEoBx5BoTQymqztzdcMAsBvq5RCC3bxcB6HJJiZKxp//G2WbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcXYxd49; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23649faf69fso9909505ad.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751228206; x=1751833006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdyYnVjKk0Tyl0BrsQVVQ2S9jTD8e4+tpgCRmmyGEg=;
        b=AcXYxd49Ws9bYiMmejeiVnn4Vfh4ZLrrKCY1Sl94t9pYrbGql2c5JzH8dVMkLRwQ4+
         l0uoyP3Hqi/FrbbREszsyzboNMO/2GVC46EJjfzDOc3c0/21mpzZr8C3FLK8P+G/3O6R
         zJyfowyq1ZxRTQtIGRHMfkvHSp31vn3gsJnIFBabTFOLmpmO/Myp+2fllENht9kIC80a
         otf44IE1O8vB8h6aZbeBG5bq5JKzdSg/Z70e7lAwTW37ViyxuBun2rEFWHY8Ofa36c20
         B4J8UmjcVryEZMeo2gVWbBviWvyHqXyVr7qDksZN07jmGxPQSM8tmLLlcmnpasJvvgDj
         wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751228206; x=1751833006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFdyYnVjKk0Tyl0BrsQVVQ2S9jTD8e4+tpgCRmmyGEg=;
        b=ilw/K+XVOt+nx9gWmnncv9776+LsOEzWd4wmsuFwtdxtmmhzUAAxhpB4a/GW/dDE0G
         QOh7KDqbsBE3ob1pG6BNu1Rwx39bW9bTDUThkhittaF/BS9vNZMOH/rWmVOqpFm9hfhY
         W9A+T/x4Oe8Gv2osmi3vRJ7j8qJjACWZKEPH09M9pPKEZqHseBAFCqBxFJnwP2J25AOf
         P2QQ/Ag/AOGZztQcEqD8hwPoPQZl93/tPhRo3uudLa5uCMdGPVgmmPrnl+b4YirtVnDq
         YUnwlGOL+mOv+MaxSTw2/Gde2VkqSrbksXlsa83RD6zHnOvJuDQ199fP5E/ALYl1gcXX
         dtyw==
X-Forwarded-Encrypted: i=1; AJvYcCWMOD3eFrOTio93na7rvR9W/iSnvQKnNGKqs1MfKLRhQSpG/RX+chVV0hSlJ3jUPTCauiPsSl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/b7pIHtPjkDwM1guty72rvf90CMO5uNZF3OMdScoXqCdFTOd
	Tftze1NzFNXaGYJuSCQZf1IL5g70UuYP00EbQO5xNY0JsgNIp8wu+kRu/fC6ew==
X-Gm-Gg: ASbGncvd40vEBM5CLEPhs9W/GXsEOG9cpiV0RjLIndpEzqJzdRzWjXM8izBvuUw90vL
	SAnikoqFFOkj+gdbPHsoSHCANmpRUqhSFBMPYpZieYk0SkYe1mU3BjhmGTkSlgI4a3o01TWvqDK
	N4Mr+COaC4g1IdIo2Zlox50YlmYFc/uih8Nt35OslcsPibH6vKEEqOEjh0lPQmcn3AMpVVBuFYX
	XOK/1C0EmLg9qW06IRe42y8TTLqMxxlK1spBmb7A7LUMoDC/f8rfHbTrgU/bdZCGa7Dwhxmv5Q+
	D1/h/GRARlTz9eupikvvJT4Z3wUP8ZVO8dX2tIO2AXFVEcEltG9KNm4Lijz1Eggdu72t9MZGUXS
	K62kkDXM62CBJUO2i4VEAfWRFexE=
X-Google-Smtp-Source: AGHT+IHB6MJOq6vdVWMRYrCEii2teBGCsUmpukbXkC456Mhn1CJhVa8R3LYPdHBgfjuKXeZtvEa9/g==
X-Received: by 2002:a17:902:dacf:b0:234:adce:3ebc with SMTP id d9443c01a7336-23ac48b3dcemr160923755ad.52.1751228205948;
        Sun, 29 Jun 2025 13:16:45 -0700 (PDT)
Received: from localhost (ucsc-guest-169-233-124-66.ucsc.edu. [169.233.124.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d27dbsm63039385ad.256.2025.06.29.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 13:16:45 -0700 (PDT)
Date: Sun, 29 Jun 2025 13:16:44 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <aGGfLB+vlSELiEu3@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io>
 <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>

On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> your approach was to overwrite the netem specific cb which is exposed
> via the cb ->data that can be overwritten for example by a trivial
> ebpf program attach to any level of the hierarchy. This specific
> variant from Cong is not accessible to ebpf but as i expressed my view
> in other email i feel it is not a good solution.
> 
> https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com/

Hi Jamal,

I have two concerns regarding your/Will's proposal:

1) I am not sure whether disallowing such case is safe. From my
understanding this case is not obviously or logically wrong. So if we
disallow it, we may have a chance to break some application.

2) Singling out this case looks not elegant to me. Even _if_ we really
want to disallow such case, we still need to find a better and more
elegant way to do so, for example, adding a new ops for netem and calling
it in sch_api.c. Something like below:

// Implement netem_avoid_duplicate()
// ...

static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
  .avoid_duplicate = netem_avoid_duplicate,
};

// In sch_api.c
// traverse the Qdisch hierarch and call ->avoid_duplicate()

What do you think?

Thanks.

