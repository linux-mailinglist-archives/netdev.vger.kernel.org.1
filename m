Return-Path: <netdev+bounces-68187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EF846093
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B461B26C6E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75584FC7;
	Thu,  1 Feb 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJDcAfp8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9482C64
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814160; cv=none; b=anQ8E8lmhZccmB+rxNSDnCm5YUq2gXbK6jxb2SZXb96xolghaHIfw+ykAURMipysUCymVZyzJuh5Q9VlrDnatl04W6otLQCZtnliOKU6BM+GMpZ6+hmyGRX4QqFSyflVInRpJGtzJAQ71SIEgD3T8Z3HF1HJdzGBx/q48xnPkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814160; c=relaxed/simple;
	bh=cKSo+ZdocbAwsXGKGoY4JPKD8I5PhfWrpIDFndHCILI=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+DOcftpbbSuMegmDJDxC0BcupEU9SPnDVX1tsVMAPOPq1D+JEixxYvxg27lo/P6LXbK6Jd2RP2Qy54RBFx+arSqwLGvn7HwjJJvbK8Byjp96Df316gVS7+KBCthnUwWXiBBtzVdMcFzFYLmVXGRuErBsNN/bSKeGY+ShdEgJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJDcAfp8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vla01HC5d18QbyC/g/NZpcu3TLjytQcHmvKQIYZFOjs=;
	b=JJDcAfp8z00Dx6fyMfxLOVJwg/VKGlsHxU34rA55GGYf5vQLcJALDzB3WEQOaukBkwiLih
	hC63fnW9CSAvma2A+/VW8rZgpf3P8X0EBcNRpvfbSH+jzjHAiO6UYyhEcTQ6/vNyFeOgY2
	W1jcscpXtmBGo9pG5A9DkJG7Huxp9YM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-MZX4VD_HMbyK3jpdl_sDBA-1; Thu, 01 Feb 2024 14:02:36 -0500
X-MC-Unique: MZX4VD_HMbyK3jpdl_sDBA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55fc2d46d14so463495a12.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 11:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814155; x=1707418955;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vla01HC5d18QbyC/g/NZpcu3TLjytQcHmvKQIYZFOjs=;
        b=SP4laiyVAXCrcxywPXJ5cJueI+6d3IUBM2kstmXqWTBpSA9nFW7hshe92b3kQMnW2b
         USKU9TjSzHjaW2jirrt2A+TQIZLahx5pXc9pv+sJlmTRG7T1UH4KsVMRgABtAnq1Z/2o
         ALDsXZsOiLeeADFlLRZj9KeWzYV9f+YtPs0ELtErA/49HwoGCNFq3/k3iU1s/8Y4bQ8G
         R5/GOMK0gZUvaS73bEz7JGEiz9/E4f5nbuMmiMSF7bSpf25QaXPAGlP/vB4CMRmPhIG8
         EfDkXt8i8fu5Rx+D0PSmunhE7XEHLIjgFPHRJr9tnpOSeaYOLqc7kidlaDhuIwMFwZXX
         NtKQ==
X-Gm-Message-State: AOJu0Yyt8uP1RDsGZop/FOV1OeQRm1L37MdHvNEQRV0aZNOr76JSDTzW
	474vAPOfxufHSIuZ4K9Q2BfqCLj9ENgTrhD+PAcfA4zvrOeqcUgKO4dRkbkdDdiCQXXM9+q6i/H
	4cquWt2qzwrD+Jya5DY8l/y25GTqNO++taiLqyS/+sPVBV0k6+3QiHyWvj6gBWuLR0OhVSQbq3U
	Fjz6VIOcvs4gNDvfAq7fysbGvcT+ix
X-Received: by 2002:a05:6402:510f:b0:55f:8ddc:6c8b with SMTP id m15-20020a056402510f00b0055f8ddc6c8bmr5218419edd.10.1706814155563;
        Thu, 01 Feb 2024 11:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhia/PVmPTEloaEh+gwGCMOBuqwr4n7Oh1M5KvukMHZ70h8TybR9X6aUiHp35O4XXN4HhiVpTzB+0M0WrB3Ps=
X-Received: by 2002:a05:6402:510f:b0:55f:8ddc:6c8b with SMTP id
 m15-20020a056402510f00b0055f8ddc6c8bmr5218377edd.10.1706814155236; Thu, 01
 Feb 2024 11:02:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:02:34 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-4-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-4-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:02:34 -0800
Message-ID: <CALnP8ZYJhcQQMKgSgPK0D35zvB0r+S+=XL2zeS2tNx+DmkLpGA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 03/15] net/sched: act_api: Update
 tc_action_ops to account for P4 actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:49PM -0500, Jamal Hadi Salim wrote:
> The initialisation of P4TC action instances require access to a struct
> p4tc_act (which appears in later patches) to help us to retrieve
> information like the P4 action parameters etc. In order to retrieve
> struct p4tc_act we need the pipeline name or id and the action name or id.
> Also recall that P4TC action IDs are P4 and are net namespace specific and
> not global like standard tc actions.
> The init callback from tc_action_ops parameters had no way of
> supplying us that information. To solve this issue, we decided to create a
> new tc_action_ops callback (init_ops), that provies us with the
> tc_action_ops  struct which then provides us with the pipeline and action
> name. In addition we add a new refcount to struct tc_action_ops called
> dyn_ref, which accounts for how many action instances we have of a specific
> action.
>
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


