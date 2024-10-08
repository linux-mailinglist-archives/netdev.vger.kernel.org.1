Return-Path: <netdev+bounces-133331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D95995B42
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8C1C2189E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6201216459;
	Tue,  8 Oct 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YQLOBc51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1C215009
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428448; cv=none; b=Wl/b9iwjGfZL/hZWrMWV+GlBVc/ixo21QIhxO97h2hNRk3PFkeLFJXAnFw2a6xfVLSUBSSymDwWgzDjCmrrNzbkpxEgeW6A82vV1MzBQK6INF33i3g3tpKEZdwAENbxBd8Qb59EDY0tCsGT6CyVL341FX1jrW/OU0BlnStiUw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428448; c=relaxed/simple;
	bh=Cv9bt1/ACmXKfPrd1pnpAyP9ihknxRE9I28Y+VS6+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CshCx/OVo5auH4uCiYWFScgaMioSlCEk1vwWJPAySUCpbMFBJx66jsiIfxstugTAhgtE0T0ht5bjbUk7ieuQUi/MghrwkqpGIi/FRun6UMJIyJx73VU40W+uk8AZPfcOQtWS8eZ4UnSmA+ZeQb3INy6uzeCiBE8aGJydY+sT/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YQLOBc51; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso3927391a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728428445; x=1729033245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggxo0hJfdXuejdLNmnLqT0CDSeWl04Q3c4Lz2CofDmo=;
        b=YQLOBc51BrDsa1a5zeZzhXbRKGZ5irqLhOgdc/hmUd9w5d7iIka5OT42Ufj12XGNQn
         w14jV71B1hEqQEZ2uKff7lRNYe4iYHoAygRifNLxhf+aQgcD9BrnFOhCIF2BvZ/X0ir8
         9kmzHqn6McUQy+o4m10Sg0iQshAnDFVOyNv6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728428445; x=1729033245;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggxo0hJfdXuejdLNmnLqT0CDSeWl04Q3c4Lz2CofDmo=;
        b=UrSY4hF+J4HvjV8T3iVNhwegiPU6DwtZLMNIgrmdDw9aku9FVwQGd8xTO9/Pr+cO8l
         2YpgCRHHLzRGEB7zK9UHlr3996Pnh9PZ2+KD32Z+OkrrU2l5mx1EmKK6hNjAK6yZxYvp
         ka6LMitK1fVhW+w9KNfLA2nu8tteR71fcolqiBDfYKfbFgND5FzwnnaSZmqWDxRBON6Q
         UmsmDgNTKqECvRtjPHUveY11guYNMpo80ie9f53jpsbvU4MYSQ7Qv4Ur6lwdTf+s87iK
         J1v3nYXBQej4oSNSQj4eWLuPLHjSFGDeI1k9Qc2CzmlW7yuYJaqJj1G/vQD8QMrHuQlg
         4SqA==
X-Gm-Message-State: AOJu0Yye68eAjmqwZkBKQNeVuzDpl6KrwCShva1pU4s6EprbyVRmOGnJ
	rBH/xtm/FN5/gAVNuaIU90nmESJvIfmzWKoO2FiqQEH7iZL2qBpPrkSJc9oFizY=
X-Google-Smtp-Source: AGHT+IGtCrR4i+f9TZK+BjFld4tVhwASIHDB0qyCNXIxMvlRm4zwHXJPO5kJdqKf8BskWqoStbzm9w==
X-Received: by 2002:a17:90a:eb18:b0:2e2:9de2:8563 with SMTP id 98e67ed59e1d1-2e2a253be6amr559916a91.32.1728428445240;
        Tue, 08 Oct 2024 16:00:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a571fe8asm128302a91.34.2024.10.08.16.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:00:44 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:00:41 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZwW5md5SlrxBeVCN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-7-jdamato@fastly.com>
 <ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
 <20241008151934.58f124f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008151934.58f124f1@kernel.org>

On Tue, Oct 08, 2024 at 03:19:34PM -0700, Jakub Kicinski wrote:
> On Tue, 8 Oct 2024 11:20:47 -0700 Joe Damato wrote:
> > Noticed this while re-reading the code; planning on changing this
> > from NLA_S32 to NLA_U32 for v5.
> 
> Make sure you edit the spec, not the output. Looks like there may be 
> a problem here (napi-id vs id in the attributes).

I'm not sure I follow this part, sorry if I'm just missing something
here.

I was referring to NETDEV_A_NAPI_DEFER_HARD_IRQS which in RFCv4 is
listed as NLA_S32 (in this patch):

static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
     [NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
     [NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },

However, in the yaml spec (patch 2/9):

+      -
+        name: defer-hard-irqs
+        doc: The number of consecutive empty polls before IRQ deferral ends
+             and hardware IRQs are re-enabled.
+        type: u32
+        checks:
+          max: s32-max

So the type is u32 but with a "checks" to match what happens now in
sysfs.

That's why I mentioned changing NLA_S32 to NLA_U32.

Am I missing something? Not sure what you meant by "napi-id vs id" ?

> Make sure you run: ./tools/net/ynl/ynl-regen.sh -f
> and the tree is clean afterwards

OK, will do.

