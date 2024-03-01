Return-Path: <netdev+bounces-76673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DC86E7FD
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869791C24961
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5720DCD;
	Fri,  1 Mar 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3u1OFBlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCA17758
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316647; cv=none; b=Ed29vbhzwyRZ9EtUiEdgid5MLQCQ0Vy58eI+skHGVOW8IaPzp6c+W2wupgZzPc80uhLBTpC4Pd4hhljeh7ooHTwPh5YSvmlESVze+h5ELMGOAs3WOC1lXwswO/sJpzGEXIxZeeKso4WTyvgK5eNsIEAf6t+oe69LbYrtEdtEQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316647; c=relaxed/simple;
	bh=/6jcISU9a2lnag5/ubrKOxe+3HSP1o+nV0AIAXp30PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z7VMKxKP8/JmSDHKNXMJgLzM7+pdmcQhRxeWPhjfuzK25LFd2yMOY2rZJhCQ+hYypfe65a6TX0l4f8ZECZnDEYryxCE/BDEVlZtkOUP7pQKHkmjbn4mMrueHRoHXt8RI9YKgoBRg0bMLo0ttbDCVfpIVRvFl0OqJYJ+WoCxj8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3u1OFBlZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso3177332a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709316645; x=1709921445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgwkJ5zBKIvalm1RJIrALe5y36weQ/YKYrh2qwof5jE=;
        b=3u1OFBlZYlDwYDMaBGNvYsP/Pe7bCrKTk9rO35Zkj2EH0Y2HN8qyn4tCt9hhbrBOQW
         060bAX/T3CzjtXIl6zmDevL1mQnfzPDQM7tnR+iyQAJxOeULy57SMTHdGuioYEJLVxQG
         XsgjG1HjuPzImNJfCRK2jeta+85kTzFWGxwHuYz7AkwOthWV5VX+PDiRrXK0Lh6K14jw
         no/WqSgV2aCib4O/QQ1S8zc5y4ZyyrUXiCX1miul9XZ9AEy9JksbG77PLebrNJDrzoQ8
         ylseZTbjcDFxg7TcpMYPEU7QO+SvPoZNeSLhng04gwoWGqOLEzGgjihRjwo1E7qtkeOD
         746w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316645; x=1709921445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgwkJ5zBKIvalm1RJIrALe5y36weQ/YKYrh2qwof5jE=;
        b=M9Z3QHMX8zRAkPncbmOL5aPpHvdFOUg5+oy/UiMMONbTRQ8pyngs+HSNjPDlQY2oxm
         2ghhjNunvpuT5rE1Pk0ITI9fRINYbf0rhBxqMJO5tRtZKwkzWg37Dn2q9GZbjrSsaOsf
         fWhJ5WLNUbJw4+xqXNMw7V+CctANK2CKNHvQ3eJO+Y9DVAASSEnGs3DHi+E/iP3ZPyYS
         fzpQZRZ00IvfdQgKIyDTFiQpZxUz7Q5pkFyh4gxzgFiO1h/6MXLboxWYj/iDD/ToIx2Y
         RJT7MMcAgKefrdPbq4CyUls7GB0Twvsm5fj7v/RLJC0GSwc7jd5KipLJvntTumEMIEjL
         irQw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2TGyKajTL212DjEqgmulCPYJNOZ6ZGchz9o+SSqeJJXPpYKEUcYu0xNq1LppGyFTmWbk8Psa08dG9SV44+5+Wo8Ep+zB
X-Gm-Message-State: AOJu0YytqH3XFme69JQOvRVdUA3PPxPokuoayz/fenaOvQDdEF0+a2K3
	+JLCRApreMiz86fMj0kO7vB/lUljAt0oHe6rr9fqF6hiKQNioF2kaJKljQVVVWU0JQ==
X-Google-Smtp-Source: AGHT+IEGDx0IBS91RwXiEWVsOKX4bVPCV9F+AXiFnctjT3PsNi+Tc0z/aXyoMVHCH/0MRr3/ArbUUwo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:3741:b0:29a:a70d:e5ce with SMTP id
 ne1-20020a17090b374100b0029aa70de5cemr24534pjb.3.1709316645070; Fri, 01 Mar
 2024 10:10:45 -0800 (PST)
Date: Fri, 1 Mar 2024 10:10:43 -0800
In-Reply-To: <20240301162348.898619-2-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301162348.898619-1-yoong.siang.song@intel.com> <20240301162348.898619-2-yoong.siang.song@intel.com>
Message-ID: <ZeIaI4TNqXSxU4LX@google.com>
Subject: Re: [PATCH iwl-next,v2 1/2] selftests/bpf: xdp_hw_metadata reduce
 sleep interval
From: Stanislav Fomichev <sdf@google.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 03/02, Song Yoong Siang wrote:
> In current ping-pong design, xdp_hw_metadata will wait until the packet
> transmition completely done, then only start to receive the next packet.
> 
> The current sleep interval is 10ms, which is unnecessary large. Typically,
> a NIC does not need such a long time to transmit a packet. Furthermore,
> during this 10ms sleep time, the app is unable to receive incoming packets.
> 
> Therefore, this commit reduce sleep interval to 10us, so that
> xdp_hw_metadata able to support periodic packets with shorter interval.
> 10us * 500 = 5ms should be enough for packet transmission and status
> retrival.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

