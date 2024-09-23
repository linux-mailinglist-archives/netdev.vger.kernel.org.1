Return-Path: <netdev+bounces-129375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E914797F174
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A65282ACF
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5281A01CA;
	Mon, 23 Sep 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU6PzxNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F619F42D
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121519; cv=none; b=KuzxLo5oLxh2hz+SItS5sAC8tWHjN+DsOJzC84L//JNh4f5eb9X/ynHPtxx4U+cBU1zrYL0nbQNMhGZFMGHtQ4IWOw5/dWrZjCkqMcSdpzu3pwEWWAjPLD8a/sd0pd7T9+YI+9a0bJGb2wneE0EWMCTaJQZxM29/szqUJwqecpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121519; c=relaxed/simple;
	bh=gOlnV8SASNYG4gGb2+vHAJ0z3uQm+3S6jhE8kprsoU4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s0/okj2P/xpS5nzXZ3evHohOxE+du46TJJaLyNfPbx8UE8IVhXQkR+Z/ZdcJoL2UWq5mlrNmL/QKEiSX2vZguGW57dFuyvb66JZVwbPvKd5TfWrl2PX6DDoE+N1V8dtvmxzKb83RYMKr6BuUgD22J9hfLenhkSdGsS76QUhXr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU6PzxNe; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9b72749bcso437795385a.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727121516; x=1727726316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaS0Ga9CMcZEpAzekXKdfXldkMSG5++2M3YJFbBtqVQ=;
        b=lU6PzxNeLABc53XPVip/hsGiHDjx6WRlc6O6Rm6sU1jxbWXPBdtoURBZweKxKVIoSh
         4XCgXdOIKoyOhFvloLgA1ZcvM0sYgdKefozFWk95B90Pso7FJo9WkSQZH3098n0mSs+j
         3xXnaziiL4+aC5F1d+Yi2Axjmy/HI2trW939QpLuRuTLTPfDyCfvxsuipQZ18pw4jTx9
         BPXUXC6eavt6+J6fUaqVCTNMA9bWKpJVSv/h4f6AWirx/F5g/57vXcFtbVv1CRNZ2qH1
         G6VpXUB15AAbsgCcukE6ez6Uevmf8kBQvEj49HX5Hc80Zvj2ISYuqEMvXVE4SO9hDzWt
         xHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121516; x=1727726316;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XaS0Ga9CMcZEpAzekXKdfXldkMSG5++2M3YJFbBtqVQ=;
        b=HVIB3u63VKplfYrB7AMxNze8NnAoBvorn1RTbnKY7rQqknxPJRMcoJTMm9RiPyoq5O
         q9rM5+VPJk51M++YtFCiUlDe04IzwEvyhGRsRRjiMJcZ4k94k7fTDALcmV1v86uC5YmP
         rCaXwJ1rc2ihO1KoTE78TPA95mbo7WHZV55L7okCmeiPkS2pdVX39UzJFSAPzLbnZqvu
         A4LUZzsyadTSqEDWQAhX7l2UwpGJDjQ/SYLWACAN6yNHU8A0Vaf1ZzyOzAhTwvsD14Oz
         4ZHsTbOJBh/5rCfAA//RFmc0MClL2sOEk72x7GkUtMB1+Nn1s8bVijZGi4au+QFSe1po
         Z4BA==
X-Gm-Message-State: AOJu0Yy9e7GIKlQTG09MKBHDpTdtOx5Ruzx1B1ayS5ChUQUvg82Hxw3V
	1FfJP4iPsL1UhnTa18OlsH6AP/H8E6GrCFT1vaLVF7NRbIW6cGKTFHP3o556
X-Google-Smtp-Source: AGHT+IEatPE42+AvOTzB8H2ytaNtmMbis0D/mPIzR/B0VotmBBT9Wk1HW/JEHyQF5kcNsTLS+RDXBA==
X-Received: by 2002:a05:620a:1a83:b0:7a9:8679:993 with SMTP id af79cd13be357-7acb8097b1cmr2412046185a.13.1727121516363;
        Mon, 23 Sep 2024 12:58:36 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde614419sm375785a.123.2024.09.23.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 12:58:35 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:58:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Florian Westphal <fw@strlen.de>, 
 greearb@candelatech.com
Cc: netdev@vger.kernel.org, 
 dsahern@kernel.org
Message-ID: <66f1c86bae4b5_3ee6fb2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240923165558.GB9034@breakpoint.cc>
References: <20240923162506.1405109-1-greearb@candelatech.com>
 <20240923165558.GB9034@breakpoint.cc>
Subject: Re: [PATCH] Revert "vrf: Remove unnecessary RCU-bh critical section"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Florian Westphal wrote:
> greearb@candelatech.com <greearb@candelatech.com> wrote:
> > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > index 4d8ccaf9a2b4..4087f72f0d2b 100644
> > --- a/drivers/net/vrf.c
> > +++ b/drivers/net/vrf.c
> > @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
> >  		eth_zero_addr(eth->h_dest);
> >  		eth->h_proto = skb->protocol;
> >  
> > +		rcu_read_lock_bh();
> >  		dev_queue_xmit_nit(skb, vrf_dev);
> > +		rcu_read_unlock_bh();
> 
> [..]
> 
> > + *	BH must be disabled before calling this.
> 
> Can you replace the rcu_read_lock_bh with plain local_bh_enable/disable?
> I think that would make more sense.
> 
> Otherwise comment should explain why rcu read lock has to be held too,
> I see no reason for it.

This path should duplicate how __dev_queue_xmit calls
dev_queue_xmit_nit.



