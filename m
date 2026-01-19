Return-Path: <netdev+bounces-251107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3AD3ABA6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5838C309984B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAC37BE7E;
	Mon, 19 Jan 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="k1nj3N+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8A36C0B3
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832452; cv=none; b=ppeyeFopE5wXj49DDcdUN6keIyiYIfde1LCfyWs14jI8i0TgtIXTV7eUEPNkO1bb5ZUC90SQBTW+/eoJGFoO7QJLJWPf7aLIUlSgNDcPpGWlXhbfXedln5CY9GJpN0+7xg/810MzmsI9M5mAWPWeSY3DUU0yw5BbMV2mdYPGlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832452; c=relaxed/simple;
	bh=SjLVpqnt8fk7vWyU2EsGa/I8aVJJEULwCucQR6RT43M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9/4o0dC79cGRI0eIqd9/Lx5ll9VHIivV9STV5SE5HKRFBfGlneXNT9KcdgXFVNVS1vysi49+RRcwUTWiy3kNMYp0mWnxwbo794bJJIVnGPSQO/+KlPgU4pPK3CnmPKU78UDaJIwxqP6A07ISuOQGIOwrwVb0Rau8JziI00+5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=k1nj3N+m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso24581275e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832449; x=1769437249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1koJv5Jon1nq0jP88QFYFGf43MZ4yFVhQZFKEqlvTNE=;
        b=k1nj3N+m0TPlG/ixQP3XQtdiG/xPROfgPrqEjsfG3n9SO3I4VXGKorKkFMrvb4/XMW
         2tEKKGfoMf4wYklHIgLwqcg5EHbUBBx46e5Fa4gludbBmG5xHRgKI8m/CJNfvv25nPQj
         L69QgJSFLuJ9XpfEJ/WvuzKyt803vmfE8o03UHfDfBmDm9xo/QwOLTcDeYNBVqoMtpaP
         IylzmIIKiSWV3+a7bIHwQuZu0VC3n3nNPKX+RHZgHN3PiqOREc4/p8RkXD1VR/pR9rk7
         YUEFQCQWi36MBkV+IIjI1/1KFVhF7zoNuqdMiPULTixEjj5pBON76ZkA+h0VjZAP8sRW
         8Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832449; x=1769437249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1koJv5Jon1nq0jP88QFYFGf43MZ4yFVhQZFKEqlvTNE=;
        b=QGJkyqx0vi2kk/K/PoXd91LuO4uHeioGzuQ5aCS38/rA60yxfmFfjG6Ay5eporC3BL
         XkeNx5fGRpoSNgbRVGf+cYVQeSk7IU1h8V8EcqRDB5/XuYkPaoPDoEFUox8MGGUcxWdY
         UXVO9R7wmNhf+FCBAicQzFvihntU3S418zhAf6H6UgY6ovc2BafXsmdDmbfrNWbwylMr
         x0XkdhXusO9o+R+uydpWg7l4iTTM/qyu+0W9sm+M27UFhOB4hW40k4JWGiDWvLRYuVg0
         i2Ky/wTeyhtjaFcRo1ZvvuySpg/Zwufs0GC07bGAvfQxpIv95FY7NseG2VmSHYtjIdRf
         OkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwodCOHFn62vZnopK5dk0VYX1/M6VqGp1/4QEnRkYo06I6ivTKhGKtTXCRTuBmnEd2+R43BAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4JmF+fV9KyQW2zV44V3XAMLujeB0wZLqIizPU8t2cX2oX6Bu
	+ZstGQNXQbyfLX5kqfLhnZYQf1LP2ptyylzxKsn9doNeAfonfxMLtSzvG0b0Dap3qtc=
X-Gm-Gg: AY/fxX5OK0mhLULwx4mEOPF+zzbtggxv9kEz9kiuO983Yh/wnPAbmdbBL0iUkxZhPhR
	gg7EQ0UeUd05Ufi5w3L57F6S8MEVYnmc3V/MPI/nq6HN6oLrZCK2G2SvUUOgg0qKqlifaQE+g8A
	puEie0EUNq8BzJ1ZhfzjwLVt0dLZzGGBQJCFD/pmcDExGO548lsTfXhMv5fu97Bi23xkHyCAQes
	xVgxVXf7HRgFCNXmE9PTZLrnR00WH7W6F6gxcxWx0qPX5T9crHtrObI0CrmX2ol7aLjIkGWuX+N
	b5TL5iR6KYbyJvDXZ9D3mSBuAsewbwfzAcmsfPwK+ZFh+Bz8QoLzzRtBuU7AG0rXiAOdx/TtfL6
	bVGcxgG1/XicjBHbIknF7srIonO90dNsoCkRBnP9vL4X9aU9GW+SFvRBjKOilM0p+pTege2mk0i
	gDmYw3Ho84SqWWx4qLi0crfAYvN6EvaHpeVS6P8HCGIQTTTQDM1noyXTMCu3istRCJRG5w8Q==
X-Received: by 2002:a05:600c:3554:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-4801e34cac0mr129291445e9.28.1768832449115;
        Mon, 19 Jan 2026 06:20:49 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428b954esm250582025e9.7.2026.01.19.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:20:48 -0800 (PST)
Message-ID: <3f9e1db9-71c9-4df4-88c1-4fc54d962682@blackwall.org>
Date: Mon, 19 Jan 2026 16:20:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/16] net: Implement
 netdev_nl_queue_create_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>    # ./pyynl/cli.py \
>        --spec ~/netlink/specs/netdev.yaml \
>        --do queue-create \
>        --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>    {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/netdev_queues.h   |  19 ++++-
>   include/net/netdev_rx_queue.h |   9 ++-
>   include/net/xdp_sock_drv.h    |   2 +-
>   net/core/dev.c                |   7 ++
>   net/core/dev.h                |   2 +
>   net/core/netdev-genl.c        | 146 +++++++++++++++++++++++++++++++++-
>   net/core/netdev_queues.c      |  57 +++++++++++++
>   net/core/netdev_rx_queue.c    |  46 ++++++++++-
>   net/xdp/xsk.c                 |   2 +-
>   9 files changed, 278 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


