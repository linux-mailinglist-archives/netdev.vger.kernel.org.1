Return-Path: <netdev+bounces-139356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2A9B19D8
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BA1C20F39
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F269959;
	Sat, 26 Oct 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeT2kcoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5C2F36
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961250; cv=none; b=qpYdbopkNcKN+ldAmVduWglRMCcmh/3Xe0pssBWGUWOxAmganaiIaU/wF1tS+s7wCo4mZR5E8xu6a74pKbjDjqqpVkklr6xlDMtByRckiG4tpLVq8UcVJ0qNtjb6ssAVSzcr3aYDOReX01fj+9YyvE1dqNWCotJH9q6KuWkkXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961250; c=relaxed/simple;
	bh=X7DVLS3/sCBlAWVt5YtgOjsFvz94fqJSmKS+j8a18JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzvYq4RS77gexfhGCIhme6YBnrq/2jebLCd8Hgu5W6jR37xfmWPeQoYIn752r2erlu3C1UtsAihaP/ZL2yvxbSdSXifO8GP3zWCkFpIkCSulrNzEpBDMAPqoMux15tbfDbjyOluAt873CsuUoxbXFPdpXpkFP6qohhdySM69JN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeT2kcoN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso1898942a12.3
        for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729961248; x=1730566048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wpIBIIicuSNlg3gn3uyabrpusCvBcm/tLy58x7TWnw8=;
        b=aeT2kcoN953ZQ47y6RO0uNyzHMwlNIxACVuvSi6ZyLMBQQhVsPpJdT2zVtYouxc2LP
         Kk4ULnMfw/zNbApBc4KroUL5SfKJ3bb59BrLx24h6KjYk+5CmIxPEK2620aoH95pc8De
         UFpdb8YK0IGXCQB3MTz8UAeBWoHrO3hI4rzMqmGEXKosgQP+lKIZ6APIsu6SDSdemfeI
         +Z8l3VaONgM7nZmxkjAsCTJBQYmrQg67kynD46P8kso279TmZmH50A2xW1ibIriH5iHi
         BjWAc6/+ukdg4ZNY2GHQJfS9rMcW+rKi5arsS4guxfgdTUiQFsrgS9hPE7jKFptM3QZc
         IvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729961248; x=1730566048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpIBIIicuSNlg3gn3uyabrpusCvBcm/tLy58x7TWnw8=;
        b=k9rG0TW/AqQm+V2mW4CSPtxJxeox9hh6vR5iBslKzkva5aUaxKgiUGdWzd8XiOtKcO
         dcAuUD9Nj5x56288INdXRsWyrKfhhOad6n0IfbpU19u2MbHs9OTDiGwbq81d5SjUVGK4
         OvDeP3vK9/4ns8h9mdrQHYKT1Eb4CWy9mNlO81isYyMGAkQ8QZV8BaawyxOhWqdt6Gt2
         F9/IAjNC50FMI+sY+N5xs+Mv+kjRFktpuvfHgCBYsuGwjeI72nLTE/iBXsxgvQFLLWj7
         D+oPfkNL32mp7C3s2iFzMJr3xySzv5dzgmU4qRcVPSmVGOK5B//HZVQojy69VxILreec
         1aZA==
X-Gm-Message-State: AOJu0Yzlin+/0R45vYHmbegHHsWniONHpmKJsPz2F95+qvQ/u1Pjg4cb
	Z+Kjai6fSIxypA3+hEarQjNjgS+GURK9sWtwdcuQ/ipulhb9PwAH
X-Google-Smtp-Source: AGHT+IGo+7UbZdbUV7fqcmrlfigORx6n1qOBVaHnY5rUSxtuV5qmgnqna0lSBLFSzuueUj/yv4Rs2A==
X-Received: by 2002:a05:6a21:1690:b0:1d7:cc6:53d0 with SMTP id adf61e73a8af0-1d9a83a3fd9mr4705999637.5.1729961247850;
        Sat, 26 Oct 2024 09:47:27 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6a46:a288:5839:361d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793190bsm2902105b3a.54.2024.10.26.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 09:47:27 -0700 (PDT)
Date: Sat, 26 Oct 2024 09:47:26 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, markovicbudimir@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us
Subject: Re: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on
 TC_H_ROOT
Message-ID: <Zx0dHmOtsI6FmOeN@pop-os.localdomain>
References: <20241024165547.418570-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024165547.418570-1-jhs@mojatatu.com>

On Thu, Oct 24, 2024 at 12:55:47PM -0400, Jamal Hadi Salim wrote:
> From: Pedro Tammela <pctammela@mojatatu.com>
> 
> In qdisc_tree_reduce_backlog, Qdiscs with major handle ffff: are assumed
> to be either root or ingress. This assumption is bogus since it's valid
> to create egress qdiscs with major handle ffff:
> Budimir Markovic found that for qdiscs like DRR that maintain an active
> class list, it will cause a UAF with a dangling class pointer.
> 
> In 066a3b5b2346, the concern was to avoid iterating over the ingress
> qdisc since its parent is itself. The proper fix is to stop when parent
> TC_H_ROOT is reached because the only way to retrieve ingress is when a
> hierarchy which does not contain a ffff: major handle call into
> qdisc_lookup with TC_H_MAJ(TC_H_ROOT).
> 
> In the scenario where major ffff: is an egress qdisc in any of the tree
> levels, the updates will also propagate to TC_H_ROOT, which then the
> iteration must stop.
> 
> Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix qdisc_tree_decrease_qlen() loop")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
>  net/sched/sch_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Can we also add a selftest since it is reproducible?

I am not saying you have to put it together with this patch, a separate patch is
certainly okay.

Thanks.

