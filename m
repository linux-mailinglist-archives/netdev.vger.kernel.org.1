Return-Path: <netdev+bounces-203111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72BAF087F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DDD3BED33
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0816E863;
	Wed,  2 Jul 2025 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j51Lgk2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD453C26
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423713; cv=none; b=h2ixwRajFP6Avkc4fM6RfCmW0/poCrlWXDTPejDgQsA0x/7L/5UwGEoXL2gnYqCiUseAOkODSOz1AIjIoo0eEWjr554WPgaJATvI2Vb8Zb28r8mJprTMfJPzRVHrN00dQJA5cRO0qB5w8EjDJmwb9DuYT/OuCaxCI3PDrJuZZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423713; c=relaxed/simple;
	bh=kqsH713MLO0auQQbcr+Z+gi8ARWLYQBfU32WG0W1vHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igIaL3kBHBkHJbafyVxJ7Q8vyPpyPQDjAct6eGKvBZrLcapvdoHEb9My8/xIouAKSW30Q3PPkOZVrUq8XK0/xRNXy/K8uB0Ur8QdRjel2rQfgPQJWPgtEsOZvkuPGFb9zYICn20RVZyfTugOp0gk7i1Gl9P6jbgJIw38T9WkmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j51Lgk2l; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-749248d06faso6510964b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751423711; x=1752028511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kI3Fqs0qbOqnvteqQOBduVlneIj7Pqi9Z4xlMPSfBAY=;
        b=j51Lgk2lcaqpmOJVG+tsUE8/TH6WZlqM6pphv4HlgLoGri6CPAP3vr7FkPMpk1OV/3
         0oRp/b6QWK+HGMOAT/GMRQqm1JqZlbpj8cuoobmkFxfBJcKqZxOGJNbG4PsRihfIbkes
         beqw8OoZxJk1AUzVKSobaCIFF8zKXN6m7GR1O8aSs2JatZBNIYkK+SWjcnGhp3BT/Kdg
         x+2vd/e0MFsFhDXJ3OB7E6rGEWvceMlQeiowH+yyiXX5o6DDs/ZVOPkAGe5AKXGAoivd
         prbYNM0Kk9fDZI80N6N0YBe7zfm7p2PhJR+A9uvPhsVIrabFXoTJAA6W2/sehxk/bbHX
         jLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751423711; x=1752028511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI3Fqs0qbOqnvteqQOBduVlneIj7Pqi9Z4xlMPSfBAY=;
        b=ntbTHvQtDfydhJAowU625hAg6vNxb2zKGtubtn5t+ouCRhLseyJKvJOFvdPZxhXk+Y
         Cq55reoclywY51h68syXeU8+KL+nfi8a7phuAXxeYmBU4PaGU8hbJP1galEv8EcWP71B
         0q+a6PW08fHssqcDkZaGz+mv7v+ORmlDwrCKAK8+QwBZG8Zc+P80Cl0HdXTnf+jTfBiU
         QvvOybEu9fWEtim9Fb9HDvAFcmLOdLYMpszvk/IQMj2NgvMd5t6Skqd060TijknGSjau
         j4aKjMCus2sg+/8JccytxH6ULHYbk8J31GnhJvquWSCUEd/ST5UKhG+Pklyy23GWdUU0
         ZtUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8pt60YagnmddlZWG7O9cFVD0KWdvhyEFapfiZUsyfvbUSL2GNF01IFjfRHOlPBrnlNqbGqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcrZ2L3xSj4vgWNcJHu+2/azR0v1tKt4dpaRIM2Uu7m0BnG0N
	L78xiGHpDGZ2caJNUAxP5uIO7lcNWIO45MmTaFytDdho7bvog2zJFD58
X-Gm-Gg: ASbGncs0PpZHsn8gKridrXWEjDyUuX6es/Dhz7cDxr4PcSVUkWi9H5vc7pUlBJbyj0N
	RTTYmnH+93nA8cDCV27tyPDa6z9WI4b7F56CXG5ld7W+fPGvHqMKzFzHxMGWu/Cd1yIK+acLEo1
	e3TlkAaxcR0Lfob822LXEOX7oQ5yQ207BkE3zm1BlmTPp659unYBHEWNaWsxwXx6s6jo4ZMCj0K
	ydmPuFJ23yZPT7UuIKyF4Z+jLJtEwxtyxl/MAaocxGcRkuRDmCJPF7OPPYvvRPC8yNX8flXaAnw
	giWT5Q6fozMJiNRpmEDXefonASJuBi0YX5kwYKhHd4sB+xS1G8hBhJx5BizEpxI9DkhL
X-Google-Smtp-Source: AGHT+IGaMkwL58zv5Ty2D4dm5+wFK8TRcBxFvrIwkOdTgEgzt/08E/ITat5t824Fwwr8NgGwO8Zodg==
X-Received: by 2002:a05:6a00:2312:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-74b5104ce4bmr1557497b3a.12.1751423711259;
        Tue, 01 Jul 2025 19:35:11 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:9468:b035:3d01:25e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541bd1fsm12419447b3a.47.2025.07.01.19.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 19:35:10 -0700 (PDT)
Date: Tue, 1 Jul 2025 19:35:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next] net/sched: acp_api: no longer acquire RTNL in
 tc_action_net_exit()
Message-ID: <aGSa3bgijdi+KqcK@pop-os.localdomain>
References: <20250701133006.812702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701133006.812702-1-edumazet@google.com>

On Tue, Jul 01, 2025 at 01:30:06PM +0000, Eric Dumazet wrote:
> tc_action_net_exit() got an rtnl exclusion in commit
> a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")
> 
> Since then, commit 16af6067392c ("net: sched: implement reference
> counted action release") made this RTNL exclusion obsolete.

I am not sure removing RTNL is safe even we have action refcnt.

For example, are you sure tcf_action_offload_del() is safe to call
without RTNL?

What are you trying to improve here?

Thanks.

