Return-Path: <netdev+bounces-106406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E299161B2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49892285146
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D618149013;
	Tue, 25 Jun 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Mum1Os"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940A1487EF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305559; cv=none; b=Mk+7L1Mj+ro9c/2Q2l7ceAkBseGw6q6uAmx9KKHK+3k6btRh211vVotD+VyvbXvzrJ5Vi44g7Jdg1BsskA08m6czBfZPDWuTFm24F9yBdzAV7tQgeOmnKatvUlcZNub7BKlttLWemnrEMerNgZ+61LwVqxb4IrjAoRyR//JzA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305559; c=relaxed/simple;
	bh=DXPQghrURCEtnqbwvFdBNXwhh+7+92iZI2Eg8RVOu6E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kgd4tjCtf6Vy2lghHZC1pOwScuXxTUUS5KIh75K7U0PiAXRPkhi61/+cC0wr3TzBUj3sz+XHthnudim3lKn1cxlKBrst5kl7WHzWgJhKSbOSFlKEIYFkyE3KNeUt7EaAPRY0dXcUhcszcdoMMqohioNNg+b30K6Eqax5pCiCCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Mum1Os; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b505f11973so44718646d6.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305557; x=1719910357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DirazO2OzkyqcjeGtMP2CsdsSfOuajO7keu26/WYlY=;
        b=R4Mum1Os/ruH7vy6u63l0H14OItJlpo33L02xHFir60xwqnCLye71l4ExV9cX61BR/
         bY4YQk09tKmP9W69h36BrZ8eaROft6iGNsHp1WqnGNN39v61et7D/dxpCJKFU0iEN1OY
         pI5xntfVp3SJ8kPLqYqSUhtROVCLyUPYM2NYi+MSAmI1LJRxrC5+PaxHyIzNRrbAXwUP
         PEjxYOMmXbll0O7ktzk9njoyyiJuvalX2fChSjGydW06n1Jp7Zr+c04PmcsMaEcJBrID
         KQ2U2DXH1q+mBOwQ9HAb2axqBaIBmprrmRREVRCnzHSBMkfxJ81TiPhPuzc7E5WUPHtE
         chBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305557; x=1719910357;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DirazO2OzkyqcjeGtMP2CsdsSfOuajO7keu26/WYlY=;
        b=PvQcgg4SaUTKgDE/wqdY3najlvRdUmBFJEL7Ox3lS3tqcdVTGTi9hjYZzmQ5Hcr+Ms
         GlgaAzDLaw36EnCo26Z+cW4/SMRQvjrpnMc8DvKIWj/ypbWc0ZnW9ePWxOtZkFsnsAi2
         ZcTT1cSJlorFqqjP7CN8HykpRbIAGldqLVcBCCZ/WZ4bD24tFpG8yharlaGyfGfL1IBF
         Z4Qv8xutr564V6sM5sVUouy9U8YZACg1i3szPU4Pbh+69KYhmJhveflaVBt2Gk3Fbv2O
         3ZrcMSvPUcU38dZlLL7G2r3o120lGJo9u/n7kYun+UiQRmi9KQNDoTq7FJwGhi5I6pGL
         gjQw==
X-Gm-Message-State: AOJu0YyAS+Mh9hebOJOLdCkNJr39AdfTz+gtnuThIYiwBMds25RQ5QpC
	yvJvPRLCKAJRSU0WwPloyed2Lp3USLpnLjwRaSlA4ts3IcGun5hq
X-Google-Smtp-Source: AGHT+IF5Io6UmS43Aw+edeJS8c/FzAGYmm1uSDIHxkNM+iczd9mMiSB98ESFKtFYyy2ki719UzHzKA==
X-Received: by 2002:ad4:5ca3:0:b0:6b5:16f3:94a0 with SMTP id 6a1803df08f44-6b5320d02b6mr124450566d6.18.1719305556529;
        Tue, 25 Jun 2024 01:52:36 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f67971f9sm4905161cf.84.2024.06.25.01.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:52:36 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:52:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667a8553dfe16_38c6b5294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240625010210.2002310-1-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 0/4] selftests: drv-net: rss_ctx: add tests
 for RSS contexts
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
> Add a few tests exercising RSS context API.
> In addition to basic sanity checks, tests add RSS contexts,
> n-tuple rule to direct traffic to them (based on dst port),
> and qstats to make sure traffic landed where we expected.
> 
> v2 adds a test for removing contexts out of order. When testing
> bnxt - either the new test or running more tests after the overlap
> test makes the device act strangely. To the point where it may start
> giving out ntuple IDs of 0 for all rules :S
> 
> Ed, could you try the tests with your device?
> 
>   $ export NETIF=eth0 REMOTE_...
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..8
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # .. sprays traffic like a headless chicken ..
>   not ok 7 rss_ctx.test_rss_context_out_of_order
>   ok 8 rss_ctx.test_rss_context4_create_with_cfg
>   # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0
> 
> Jakub Kicinski (4):
>   selftests: drv-net: try to check if port is in use
>   selftests: drv-net: add helper to wait for HW stats to sync
>   selftests: drv-net: add ability to wait for at least N packets to load
>     gen
>   selftests: drv-net: rss_ctx: add tests for RSS configuration and
>     contexts

Good suggestion in patch 1 on symbolic errno.

Will leave one minor comment inline.

But overall LGTM, thanks.

Reviewed-by: Willem de Bruijn <willemb@google.com>

