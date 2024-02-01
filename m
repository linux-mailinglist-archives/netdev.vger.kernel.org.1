Return-Path: <netdev+bounces-68188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9EC846094
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C8628B4C0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623685264;
	Thu,  1 Feb 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSE/Tr62"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FA84FD3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814181; cv=none; b=r/Zm5JFAHryy+b69az2qbupuHiFzvFrPIlFvHDVWvgOZMarwYLyGW1nWDRbZc4BcR1qrD0B3WEa0inVoVWEtiyZ9VrlAuq19CitmBxd6nSQZChphO0z0jb0Arc2RP+y8imH1jlsEpsg8QqQBmW1Qq86La49qFO4NsV/tdF3m1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814181; c=relaxed/simple;
	bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Gr7W0ETgtgSvcd71tKm8cp2iFX+XB5drmUdEfb+xDF3AJzPkN458lg/jcM+J8LnR57WMmDjaSIukHDk05+5tQpLa5POPRwgF0LZ10tyJL0cLjw6lEoF1RqZesME7VYDjzQLmuap+B61kQKNlSym7J12tdpGMejyNE4fOmEOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSE/Tr62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
	b=RSE/Tr626ri4Cf7nvPi4YjkGK/eJM2qXVOhAO9ezVEoolDpmHOELArt3NwuxyoaUCTJFKr
	PkQK8mvFSd6TikHjo+P2qOnWINyPyVnaMJbxn9FKmJW/R94DluQJ9/Kfn3EDZ8mv0HCuCa
	LdZAgwctrubRnAC4QFZkTWtPKudUr8k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-72RzohBJPWely82u7GG0dQ-1; Thu, 01 Feb 2024 14:02:57 -0500
X-MC-Unique: 72RzohBJPWely82u7GG0dQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d081966c58so2144811fa.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 11:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814176; x=1707418976;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
        b=ubVcOVRIbRyyzZ20lv0bBC67P73sPsLDiqnFUQ1ElsKllts26cqv5gZEoCerQNPeJK
         DYyFbKmMqFOBXiUJwIOxeoH64a+owDAfg45JY1vmWA/nNKWVdRltZfanaJIO0ABIZMJa
         65gegCFrvEVc20sERIkakY+fGjvFb918nJYhfTl9erV6HptaOXeVZa0CkfLKcNE6+l3u
         HSDzrgnL1Yau+EhRNuIVrlWdzgYLdoyLe40kurWVwD+/JcTs3NWDQy8WEcg9ZCh4YGp7
         v3SBZVAhUv0pi7n3fSlgZW4O5arihMlqc9OP/KL0l9n2bAQ/6Isw/ZCUgi6SnW6f+Or8
         cktQ==
X-Gm-Message-State: AOJu0Ywe0aCpBNP2wqOc3q1B7Kt52H3611WHjUXfymRxoZhni4OovrQS
	6x60HovaAum3ra5Ve/rg/saAOmHO/4Tyr9KrZQ/BF/QbfPZSDg2oMA+HuP7a17Fc3tucW/dkOaA
	0k3719nGlul36UhFdBbKa5IAlsvuC41zyDADrpOOv+Do8pc384lMg4DoXjO0txo2Vj750smocHY
	ArPgURUvdp1+dDL6HEdED+SEmivIfO
X-Received: by 2002:a05:651c:311:b0:2cf:276f:83e3 with SMTP id a17-20020a05651c031100b002cf276f83e3mr1803374ljp.28.1706814176014;
        Thu, 01 Feb 2024 11:02:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy4lBH4E+hDaZ+LWF/+yr0kHTmJHCD3X/mQ+0iuenxVQPxxPHjUJJGsksFSXcvp8DiwsHDdMKJYLId4rRMLNU=
X-Received: by 2002:a05:651c:311:b0:2cf:276f:83e3 with SMTP id
 a17-20020a05651c031100b002cf276f83e3mr1803348ljp.28.1706814175691; Thu, 01
 Feb 2024 11:02:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:02:54 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-5-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-5-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:02:54 -0800
Message-ID: <CALnP8ZaqDp1e5qRQ6o3cs6bSt1zJ+m6u3CpVoWsN-nLbAb76sg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 04/15] net/sched: act_api: add struct
 p4tc_action_ops as a parameter to lookup callback
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:50PM -0500, Jamal Hadi Salim wrote:
> For P4 actions, we require information from struct tc_action_ops,
> specifically the action kind, to find and locate the P4 action information
> for the lookup operation.
>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


