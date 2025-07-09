Return-Path: <netdev+bounces-205301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B0AFE26A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF5F1C4276D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BBA2737F1;
	Wed,  9 Jul 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DXGtTvLo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357B23B617
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049335; cv=none; b=gC5oSZkFAeKCG4PGmPqRAtwcwSkx7K3iBHAtPTJQtHfBYvB7lXpQro33bgwFttDTMGTgq0+IxFvlXomipbMQnt7slA9tQ+khvHY6eCvwXIu2UTGHBDH4mWHmLekIij4oTzfhzeHascGwEvd6GsgQMcoyDpcdEQ91nafJq7XsByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049335; c=relaxed/simple;
	bh=bbp563xB+k02ZQyw0bOuD8J55G2HzTY7zLjAKvmY3ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ryQ3aWHI22xEBpkqDrkYgeSiDqpIXtUmq/1yKnQTZr14ZEUsuiKzaeV4gitAAtKoQOYPXR0ntdmhBYmvelC5HV5uuy2NOZHh70CuEA/QtNRT4e65jigd/w/zM6zCVdE5PeOH4fnD7YJdJPHj0EyCseg85oODsTqP7cYscsQrM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DXGtTvLo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so837633366b.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752049332; x=1752654132; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=DXGtTvLoNo9ePfndqiQvjdbLT19QreUvafcDqWsaltkRvG9N7353sp3YvYuTjEKpI7
         FRVYHtUITWrJwPC7YsdBNBNjyHq6U6l36Qp2zX5yFiCJ1LOn3K2U+Jl30ptasBSTvpKr
         ZJ59K/Ny1Qv9OWk0znGZSGZzr4WHY0nQIs0HuPfHjFo0Tb/CtTz6Hyc8G4p760gpwS/E
         X/s9bKxiLMMiT+zXUUVrnmNGR5LGGPxr2CKg5rAtszoydGpE7HbGvKfqYJdQ9ehIN62v
         eqsM3YAIuOrQ2i7c8DFkWUkLSJSmT3GyE1mQv0YXumEFJWosaOjdO+0UYotKIndnqDD/
         2nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049332; x=1752654132;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=IaU46uXLueY7T6e+JI45y2Q3BG/uJB3pvEFLvUqzqwkBLb44J3DxJZJuy6XyQQyq6h
         i7u0e3hCaffVonmaoUlw9AMlBoJmTb2J0eiNeHv+Aguve/2RxLAhAsYAql8htppjVR35
         qVCHwYOVnykmc+bzJ2hQh9V2cnY8mFTmHKOyaXZN/RT1/QQPVn0r8XnrBOL2cpmBECXg
         GCiFMHSj7AY33bGhPK63Oid4dxXSAg+8CnEjh9Wr8oBMF3aillELaS92h338rZmM+ob6
         MBc4X+wVq0reSH5wPz5NJT5VCax9fr2xjKq9dg80biBP/0NIpw/Z2BhOgvrpKuc4bZmC
         NAGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5aQ4QIAcI4gUUOS6YMmsiTJzsPny2JNjxC/16tp8djoqX8AIhb8m5juTGbuTkrNXclLSWUq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDjNWDLN9ca4tG9Ow4ESkJ5uCo7R5zY794iFowHCPGYx+aEYc
	uTqFMQo/xvT/+K8gzgz8tETZ/rQJfu8JxhSXvcpyGs+n82eHb5ZfETG2S6Aw0vBFOM4=
X-Gm-Gg: ASbGncsVzDHyMfIK+940fpWF6YhOiEeAdYNrAzU0JzpvlJUrN5Uv5nvGxCvvDR2yAl6
	Zhgs+9aIRJ9YnR0MNvxtbIMZQkSnA8Uz1z5YhXpwFH5rgFSMAvpfm9SY0cl+u4kapMXmamrplrW
	1Ck0XX740hKrc8ay2dRCQPF57iVHQF8XK66ppSj/ADwEEObWAcJi+poRUSb90vWkDR3tkCBAsZ4
	kbojrYvTw2NDxfijWyZmzEkfwdWdDXeR+Lr7FdYfPWTfQHjhXysdo0kEezS3mmhdx+HLOe5zJrp
	fepiIbtM22ZeLgOz/QjgYaTmqnteLXWNiDS0asOvpd3wLpS3WRrD7NE=
X-Google-Smtp-Source: AGHT+IHhjLw7axM+sfg+4JbrvZ5uzjMQFSsgDBtJdAVL88Qnq4BGK12a+lUwgHht3jMZ3xAMt8/spQ==
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id a640c23a62f3a-ae6cfbea8f3mr137410866b.61.1752049331750;
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1f8856sm8372942a12.56.2025.07.09.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net,  razor@blackwall.org,  andrew+netdev@lunn.ch,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  ast@kernel.org,  andrii@kernel.org,
  martin.lau@linux.dev,  eddyz87@gmail.com,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mattbobrowski@google.com,  rostedt@goodmis.org,  mhiramat@kernel.org,
  mathieu.desnoyers@efficios.com,  horms@kernel.org,  willemb@google.com,
  pablo@netfilter.org,  kadlec@netfilter.org,  hawk@kernel.org,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v3 0/7] Add attach_type in bpf_link
In-Reply-To: <20250709030802.850175-1-chen.dylane@linux.dev> (Tao Chen's
	message of "Wed, 9 Jul 2025 11:07:55 +0800")
References: <20250709030802.850175-1-chen.dylane@linux.dev>
Date: Wed, 09 Jul 2025 10:22:09 +0200
Message-ID: <87zfddepu6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 09, 2025 at 11:07 AM +08, Tao Chen wrote:
> Andrii suggested moving the attach_type into bpf_link, the previous discussion
> is as follows:
> https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com
>
> patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
> will init the attach_type field.
>
> patch2-7 remove the attach_type in struct bpf_xx_link, update the info
> with bpf_link attach_type.
>
> There are some functions finally call bpf_link_init but do not have bpf_attr
> from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
> now use prog->expected_attach_type to init attach_type.
>
> bpf_struct_ops_map_update_elem
> bpf_raw_tracepoint_open
> bpf_struct_ops_test_run
>
> Feedback of any kind is welcome, thanks.
>
> Tao Chen (7):
>   bpf: Add attach_type in bpf_link
>   bpf: Remove attach_type in bpf_cgroup_link
>   bpf: Remove attach_type in sockmap_link
>   bpf: Remove location field in tcx_link
>   bpf: Remove attach_type in bpf_netns_link
>   bpf: Remove attach_type in bpf_tracing_link
>   netkit: Remove location field in netkit_link

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

