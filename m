Return-Path: <netdev+bounces-251121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD8D3ABE2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE34C313C03A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747C376BF8;
	Mon, 19 Jan 2026 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hwXUxAtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCD324B06
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832569; cv=none; b=FJlZ391Ewhv02KSSz9oe5JsxN/qqV8WoRuRI/E3xmZbYF+Ry5BQKIDnsebgZluDbIKaU/yDHkMqMotX2LikJW8HGgcGzdzj6dlX+qxAq/RLyGfBhchSscGVNYqoBPfXW1JOpd8PiTo5HYcHjqRlQ9Mlbt4G4+y1BDQtclv8d+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832569; c=relaxed/simple;
	bh=BKZYEfze3ov7Euj39JFKJrqMcsYTti4O8KezpkKFW18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgDkF+hWjmcDpOGtM8YMOmcy05qwQV3L9H0vbBAyiwp0Lxh/BTfuIJsxatqd2j9ZqYtES4GKxU2fBjbGn7DqNA7RJqAUVtJ7w0nFA38ntQQrTgAdrT/9YQcEPVr+d0kp8oB1VqgmRjqtOgL9Yipz9HIaGKCKRC0IdhKiAR37Yw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hwXUxAtc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so38681285e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832567; x=1769437367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqFFwV4fjXTNpzdt9lX728eBO/qXMUCVvMxwb3QXyS4=;
        b=hwXUxAtcAyhMspmJOo6vIAMZfIXeQNfMNc3PGuA+X4QQYwYKDMoTS3cwtN40+e+9mk
         EgE5IpUyfysw9svr7pGBUHaT9HRw+TD5MFno29fw9Vpre9pTlzAdux4XBDShpDj04nGS
         SAKkvwyi+bjNuDT5A6dGJiUDDzDt3gsdObU6xUW4ICii96AV6JH+nSEcbfdduhaSv+bc
         GQnWB0qStfVJqjvMO3Olb51r7ph5qgMr/72IT7ANkIP+vFhuijmhvWIZRPTDP0l9gHvh
         xkPujYnR98dwCq8cCHQAu3fx3c8auappCXFz+1bC80NvGAKNkj1CFAJe3EraGcWipmSW
         svRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832567; x=1769437367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqFFwV4fjXTNpzdt9lX728eBO/qXMUCVvMxwb3QXyS4=;
        b=k57A7VL6vIOuOqDh/HmLa2QMwA1HdRpODguAtbfN+RUioYn6fdCraxGOR2gBetnYwo
         NoENaTjop1ptQDxuUrFB+SzPkuDCF8Xk1H84eXUW+JbUQ2Yt3OKB7lm8zcLi+94r4sVf
         ir70Rek4AOsSYiq/LBXRN5tYtoU2aR2Jwl2fJTJBnhOlZGYBCG3jhKrDv43wChEPx9wx
         WTRVI6KvfhOTjcxohwRbDjhYW5CCaIQ4CYCL1i6i0Krm1tcyJ8ELXXEHwodhmLxzua+8
         190+02nbU81NFvXXyd0TEEGzqjgQEs9JVpFFxgvy4tiPXuSTMT0Dy4X6ljjYIDGl4k25
         kVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwQEtL6l05xtZPgNjGmjnZoJWlakYmqk7725DAo0o2BRPHPYI6lQe/bGydl74FmxyxA6RwcLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznm9Yywn/exSoROFymYZrOkGlIZO1Hf8mv0hjNaX30WYfqeUKm
	CsDPyu1yVki3W3aNMWL3ASKj9j0r1ZT9kCBftK25PflBtechh8IvtlblCb7lSx68dcU=
X-Gm-Gg: AY/fxX5Gw5dTavdnv+c6k6eejXtmX1GpucamFMlMVN2cqre2gYW/gk2s22UFxYocCb/
	oh/5EAY08B/ZuI328FNwUSLpbyifAFnHuay7t9JxKsoCaxgqrhrxEB8E7ft/+616UNg2ydFMMOI
	GnlOwNnbWd34x5CGFZMdkd2qEOgnqRWBufGchPYKU+3zXyj6BCFoG6v8sOb5kWtSh2xJ2tYxgJa
	MKMa3qQ5R6I7b4SnDfRSPqlD1s2lTs/h1/9Tm60PJ1k3tIKL9gNMD2EVwu3I9bcZ5C6MVyFN5rg
	51kzDQeqf50BADxTIsW6ExJDMpQrn8PjIa2bhDkIqMkIdvS5kknJWPbzdlVQRd9cgOic7e3m2zp
	x+FNfzAUH0AM8LqyoUCjbFUywdqQ5lJXQmqQ2yufWa1V5KnSDJrKikDz/76Eij+Vi1F2O02b/jw
	z8v4Lsk4T0f1fJOegnEcOKS1dI96nejIlmcCvgOL8jrxEgIFnuGfcBmRUnnbP5b31fy3kGRg==
X-Received: by 2002:a05:600c:3b8e:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-4801e2fe362mr140096835e9.13.1768832566278;
        Mon, 19 Jan 2026 06:22:46 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428b954esm250664185e9.7.2026.01.19.06.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:22:45 -0800 (PST)
Message-ID: <7dc69b9f-0b48-4818-9689-fa22a98fad22@blackwall.org>
Date: Mon, 19 Jan 2026 16:22:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 11/16] netkit: Add netkit notifier to check
 for unregistering devices
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-12-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-12-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> Add a netdevice notifier in netkit to watch for NETDEV_UNREGISTER events.
> If the target device is indeed NETREG_UNREGISTERING and previously leased
> a queue to a netkit device, then collect the related netkit devices and
> batch-unregister_netdevice_many() them.
> 
> If this would not be done, then the netkit device would hold a reference
> on the physical device preventing it from going away. However, in case of
> both io_uring zero-copy as well as AF_XDP this situation is handled
> gracefully and the allocated resources are torn down.
> 
> In the case where mentioned infra is used through netkit, the applications
> have a reference on netkit, and netkit in turn holds a reference on the
> physical device. In order to have netkit release the reference on the
> physical device, we need such watcher to then unregister the netkit ones.
> 
> This is generally quite similar to the dependency handling in case of
> tunnels (e.g. vxlan bound to a underlying netdev) where the tunnel device
> gets removed along with the physical device.
> 
>    # ip a
>    [...]
>    4: enp10s0f0np0: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN group default qlen 1000
>        link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
>        inet 10.0.0.2/24 scope global enp10s0f0np0
>           valid_lft forever preferred_lft forever
>    [...]
>    8: nk@NONE: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
>        link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>    [...]
> 
>    # rmmod mlx5_ib
>    # rmmod mlx5_core
> 
>    [  309.261822] mlx5_core 0000:0a:00.0 mlx5_0: Port: 1 Link DOWN
>    [  344.235236] mlx5_core 0000:0a:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  344.246948] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  344.463754] mlx5_core 0000:0a:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  344.770155] mlx5_core 0000:0a:00.1: E-Switch: cleanup
>    [  345.345709] mlx5_core 0000:0a:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  345.357524] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  350.995989] mlx5_core 0000:0a:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
>    [  351.574396] mlx5_core 0000:0a:00.0: E-Switch: cleanup
> 
>    # ip a
>    [...]
>    [ both enp10s0f0np0 and nk gone ]
>    [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   drivers/net/netkit.c      | 57 ++++++++++++++++++++++++++++++++++++++-
>   include/linux/netdevice.h |  6 +++++
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


