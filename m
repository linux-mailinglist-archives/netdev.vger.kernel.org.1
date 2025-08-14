Return-Path: <netdev+bounces-213852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285CEB2715C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04877686DAA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E327F011;
	Thu, 14 Aug 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3PPGdMJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10A277CB3
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208816; cv=none; b=SNHQhHELcfF4nQHlpz5xoYoUTu3wWxjkW7Ot9NE/qHG4uwryk+Tk5JtfG79rBevbV2MZtCbCjgTPJVwSdktQkZUuAJZBElz8S+tAb4w4GqodAAeC4nc6rX7sXaZg6RA0y89XLpQoe/4IsQfeiCPBJARrnwzQejoi5RYaVdpQ+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208816; c=relaxed/simple;
	bh=4f1a8bfzcaElPZCGk5XhNbWyIDxXWhv+CMxMkhuBFXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owj2ozF7UM+AO2G8Ms6vWMWZ3pZSLR7HfqDmAycC8mUlQFZAtMjRmH9utZy0e1GLPBJ5+noOlmx1SiveL/TPhinZ12kiEmdnt/0b0i9+3D0NKCdPF2bi0OjYujpfJnt/v6Iu4eBBigGZ/pGKo5PBZndqGZf/sd2YohHApurNCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3PPGdMJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 15:00:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755208812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anDT9Myam9siQZ6MO+5nA7/YHXUugpAjr2OR1VCdLsM=;
	b=l3PPGdMJQHFbfQIGSmCznlTBp4b+dcz315PCI9QqME7LBd37kTyp9hqriupi1OpVIHKlXE
	YQSi3GakzDxwvQTeIVAUQ8ejCYX9XZi6jtRXtLogJIxmmo6WdHzJFOgsLs2NBkJj97Y5J9
	r81c2RVgOWQYDz99sDWKSuoo0b11kB0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to
 mem_cgroup_sk_under_memory_pressure().
Message-ID: <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-10-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814200912.1040628-10-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 08:08:41PM +0000, Kuniyuki Iwashima wrote:
> We will store a flag in the lowest bit of sk->sk_memcg.
> 
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().
> 
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
> 
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Please keep it in the memcontrol.h.


