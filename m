Return-Path: <netdev+bounces-202099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93BDAEC386
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1084560938
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C52C1A2;
	Sat, 28 Jun 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5IsyW5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF017555
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751070962; cv=none; b=gflZ1IZL/mT2sDEjPns3JoQAlSwIp4bOUSPTyluuwq+OdXwGqD8z000k08VPqgoNOhDnOe/5NRkaRpzCTEyfkVezMBfUm1ZEhZxIzoOADh9+9685vhc36FtxeOSTTLX9u2VCTqetOA9JEkApxRW6F4M/IUf/Ag6xPZTCqnXGiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751070962; c=relaxed/simple;
	bh=+8RtwNif75ECR/pyq631t7K8v6hV5pqFu6sxBwkEOhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl9YRA5WQ51ikb1V0d7Yv28lz9BFM2rSG7h+mFoNs6pjM1Ua0JHuntsKOlGV0RRcqcZwmg/vVTPt4MuCYgqmS89ZiGbcSEAplCXKLq76GA4m1dxbiIHdDZMXGBgREYZ8TFXwtnW32HDP1vKTRNBezPOeu8+0aBVsqyKeMLWMP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5IsyW5t; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2958599b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751070960; x=1751675760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhb/btyNEeUoRmSLfpgRTyEQ0sXgLpYvAeWrjlaE42w=;
        b=R5IsyW5tRGjW+PXoNyVp00x3KftYjtlhpt4x8nSDbJWB5Z+yyiislhWE9wJkAnJ4Kb
         Yo1OLnnrIiboZLyLDmlLxt+JH1h5MN3LpskDKQ30HgLbKQsiR4ZrGb+paGibn9MwbvLo
         KFTDDsDA1TLhXzY7Zw5fCxq6bbsN7QqknYqWFBjfcuCyXUhV1LtAViSLWYia+6lK/gy0
         Ak/N7FEeys0qkWYXNmhW++vict4XJmgDRykbXtPBvyxcI4GIvtnEE6Dv5aMHn2Ezxtfw
         WUEG3j1JU+fFKU/r1ODS3gHwKr+cxLZU1kSR/GY+3N+sMtC0JGJh769r1StfiYugX/LI
         zX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751070960; x=1751675760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhb/btyNEeUoRmSLfpgRTyEQ0sXgLpYvAeWrjlaE42w=;
        b=Mfa+/25VbWjEjTmtjDvmS3iFzq6HcWR8HCRVBBrefcVsD2KK5giP0A7Zb9r4OgQfAU
         9OhWAxs/NJ65OsBHUtdntMmnXMPnOqc1clP9eEdjNpeFD9GqBRzCOfrI2uuGozigDCTz
         +KCopoEETzDjjkzjXV2c25+gRi8CEsp3tk7VElhc2EC10s43/PTNVn4m8wu2pNkcIDpg
         gsQ3ksGt+CUhsb+JMyA3Oz7eMNH2cNoEdtnRkru2djka4c2XlDasHyi/N/viaHCV1m9X
         PM7NFEg8y3xGmR7i87zMh+2L6norPwWR2apj669MvKe8m8MRnzBEFElmc54HD32+efDR
         qq3g==
X-Gm-Message-State: AOJu0Yy7DXCl61x2E08LpowsjUyUiGipcC0wk0G/0TmJnKB/EqGwF6H8
	HbtyccWRmakvCZkzUuNJmv2b04dhlYCKeD0PeZ1ioExk1j8mPgPwu4kx2EPyUg==
X-Gm-Gg: ASbGncvWFcx29kGyErk7TfwEnKKe9doV91Lv/mA5pRSmIRQI4m+m+fVHnKh5EBbaUxD
	FWyVQExVRLyDWgNNmraKL2ZDtkxbWH8kwsCDb+ydR4MoNIleMr9+CNS8JzKQccKyC2XTg7zloDv
	jrsmWmUVUzBeAgR49n/IxyFFKP+IIGp7mNCIOTAq9DdhXIzeDNXNBuutY9uRBxQBEuosl8CLNqt
	L8mYmH9+XjP5XX0co0/At2HYIMfGrs9l14SV1xNRrK07VoA1jNNjKrdX6C155JbzHxP7SR6R31s
	E6Si6AtW+RihPvc5xdkIqhEaIa6uh21bKTguEVkn448nhvFU0D7Dndu7bw3s9b4jEQ==
X-Google-Smtp-Source: AGHT+IFOs66O25Ge3DqKwVb8vWtNBD8p4gIRRytuUv6aabZ/2itS5OLR2WyASvuc5CBTC3beKroyPg==
X-Received: by 2002:a05:6a21:174b:b0:220:1843:3b7b with SMTP id adf61e73a8af0-220a0893143mr8817078637.4.1751070960246;
        Fri, 27 Jun 2025 17:36:00 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b37bsm3278712b3a.24.2025.06.27.17.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 17:35:59 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:35:58 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
Message-ID: <aF847kk6H+kr5kIV@pop-os.localdomain>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>

On Tue, Jun 24, 2025 at 12:43:27PM +0200, Lion Ackermann wrote:
> Actually I was intrigued, what do you think about addressing the root of the
> use-after-free only and ignore the backlog corruption (kind of). After the 
> recent patches where qlen_notify may get called multiple times, we could simply
> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is empty.
> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue at one
> point or another, this should always catch left-overs. And we need not care
> about all the complexities involved of keeping the backlog right and / or
> prevent certain hierarchies which seems rather tedious.
> This requires some more testing, but I was imagining something like this:

I like your patch which looks really clean, in fact I still have
troubles to totally understand the cases you removed by your patch.

Could you tested it with all tdc test cases? If they all pass, we can
feel confident. Of course, also make sure it fixes the problem you
reported here.

Thanks!

