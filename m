Return-Path: <netdev+bounces-148113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DCF9E0636
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5D2284CFD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9BD205AA8;
	Mon,  2 Dec 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLtraZQH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F331FE47F
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151896; cv=none; b=WASLZpNOdcRCuGCsBS7KNYvfSgK2dNrWHdF8oGp+fYgJ1hn6HTjg6TSPNxOLnR1ki5wSEpa6C1ZDQCPwExBL5EQf1dp0COWhBDvon0+/cS3FRQXV4tn9MoANT4J1onkR+4Z/nu3hkea3fBihqw0VH0gdlU5TucJwUIfFVUPNO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151896; c=relaxed/simple;
	bh=nKPz1YY8z9eVQgn3Z1CFf00Z+fJBx2iIvDW8235cJHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVzKdII1DxIXbIuCsV67+YTz6ge4eO2kS6KaH6UX8DrcHSOffUK+A7jSIyULQxEw74tayzMO/BsQ/kixTI+bm0GcCxQIymnJVWv54+O9/s8RUAnBssJv4iNJ+wvxcnYhTbcTbwHanTDMICXdSJJd1rP8bbMQN48t5bCIKhkFCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLtraZQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733151894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFDi5MCDReFoFa9/JUYYh+TH5TgtLAOTwQ3k4sJjTO0=;
	b=QLtraZQH8rWx5BL1Ygb4EwABNMCIg4yzn2hZ5OxyVJPP2O9rVsIkEKKY/SM2lXKP4OXC0M
	XilytyWbQ4D0H8/8cFhThwtFvbw63xA4JNEX/Rxgbh3lAw9lzpSQZsbovTwjigQJBNi+by
	xZn4Uyex4/PUpCZK0Dozr6mr+69AGGU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-iu1ewAzwN4ee6tCR_3-aAQ-1; Mon, 02 Dec 2024 10:04:53 -0500
X-MC-Unique: iu1ewAzwN4ee6tCR_3-aAQ-1
X-Mimecast-MFC-AGG-ID: iu1ewAzwN4ee6tCR_3-aAQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d0ca174864so1502571a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151892; x=1733756692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFDi5MCDReFoFa9/JUYYh+TH5TgtLAOTwQ3k4sJjTO0=;
        b=OZ+FSMG+1GdXf3oYEBJs9PeRpE2/DhFHXpExxqUnWJlJE7IsrCOz1zAaUIAfBy2mz7
         LsNferjE50jjIMKJpjmi7hMUVC2FZPNnixuX8B0nJkGW8cHZCCu9cMBKA7NtHgmw5Zxa
         5hapDVOsGH+n1p76pwRS69cjfdVECqunrSu5dsVJ06ttxW4iGWDLd3UoIDknZl5t38K9
         NSfg02T6jTF5hXloeSimbSs/1r3aKUUwK5BxCnIq/YsxDqL8I0TEirXRKDx5dD64dpzL
         W2mlnQK6qCJY2T/S4GKoX+lw9IUa3r7d9bdaDDyw+VJNpk/advoTV1w/MAXbniA/i+89
         xyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAp9y4O8IYvCDbT7FZsO7qSGKCkg6rz+ytuu8p6G7y3P4ypWQQB/FbIoLUWeMx/eUn+zhtlVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgxISL8ykJFhO7ATIqZUNJg8jPq5kRMxBLw3OxA0OiBUaNW2K
	bE8qKPAiqQ2XLDAjP81BHsp32cLLFyke0xFijcLLqpzt1zM7V9xF9QCkMpajZ2rpCENmZ9u5fk8
	LLN4+tgFTPqgYWu/tm5EmDExwgJl5+b0kz9ysBdgeXlt5+1kLBl/IyQ==
X-Gm-Gg: ASbGnctE3RZ1B9ofT3WungosA4QSLn6IdQt+oOayFizkRWPPcVk9fwf4uzExqeU1sS1
	CQDuVTgHnXQXPtuxl6FfnIlVhQzkw1fyVjaTC1TudXAwcAGdSQMsQKTUHtsuy6tzJdoyRjIvwBL
	6P8G1nE9SX+GFBNCEWgaxyxEJ6KwJLQ96Lw2lIkcgseZT8MzcbHf4o8Uui7vCFMxLxBl4R+Lke2
	IhTeAejo8Ga5DtUk7Dec+YLynB4ANxofj+d6u9nSHxeIkfFR63b1yXjTjrmic+llFWGCY3VVJs=
X-Received: by 2002:a05:6402:34c1:b0:5d0:fcb9:1530 with SMTP id 4fb4d7f45d1cf-5d0fcb91ad7mr1824368a12.33.1733151890171;
        Mon, 02 Dec 2024 07:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLR/sXsq6Fk998Z/jlBpMBEgh4hn4DMDmdQypRs3S7xxuQPi+56Hm4GoUjp9vR+XHyq443Q==
X-Received: by 2002:a05:6402:34c1:b0:5d0:fcb9:1530 with SMTP id 4fb4d7f45d1cf-5d0fcb91ad7mr1824264a12.33.1733151889387;
        Mon, 02 Dec 2024 07:04:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd6902sm5061534a12.45.2024.12.02.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:04:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 070A3164E98D; Mon, 02 Dec 2024 16:04:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpf: cpumap: Add gro support
In-Reply-To: <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
 <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Dec 2024 16:04:48 +0100
Message-ID: <87o71ugm7j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce GRO support to cpumap codebase moving the cpu_map_entry
> kthread to a NAPI-kthread pinned on the selected cpu.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Pretty neat with such a straight-forward conversion. Just one nit:

[...]

> +	rcu_read_lock();
[...]
> +	rcu_read_unlock();

napi_threaded_poll_loop() already does local_bh_disable/enable() around
the polling function, so these are redundant :)

-Toke


