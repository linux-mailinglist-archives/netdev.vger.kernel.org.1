Return-Path: <netdev+bounces-182923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51705A8A5B3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F081784ED
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068F221F14;
	Tue, 15 Apr 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGtEdYxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B948221DA7
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738440; cv=none; b=rxUm090VXpEQHIZDKp76p1EFZBIgTb0Z6BsSh4s8GjKxJdnAEPhC2/1ftLLmFretKACnJfWz2Rp4WASYw1KBbIPlDXIpRUfK9QGweib4RvpWy1lxMZmWjLDh80hio1/Dbe/nvqxMlcvjkIRA1z8txRlI1bEWUOpLkyQIgIJxMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738440; c=relaxed/simple;
	bh=yqkDFVH5cTtROEViSFjuCSu86e6i+NbrevL8URPuYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3GRPbGXCHWDCmLx53cVOAl6TNeLbDxEO5l14GknrjpSElmZ7QC1vgZjSM5IBuDbEPuCQ/rdeWn44RLSJgL79OVTsTqE/RN2aK9lqq5rlXx0obJW+5n/Fuggs4JB65tL9PLGHep3YHphAcgxW6AdX4CWP1T6OPAGLDFFXv3DYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGtEdYxr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso63878455ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738438; x=1745343238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcmO9he2/RNDLdjK2zSRDjAudFuUnVv9pUzsshxyYgI=;
        b=BGtEdYxr23221GYlVMy/2Tw+Z9zjvW+ed+4kfi8JmHYKVayITy9GRP0kJtXpFxTUX/
         CT0FTvM0MMFJEXX30FmV5eMxbdgT+315m3vSW6UyObeUloQ2y/tlibNqkqsyu8Avr+18
         6/QTJ7DjPYGVe++HjxtAnR/Zx55bequWBpm72Bw7BTADMJgsZQzcRjR2DStUAtuE0REW
         aT41WqmA1q1Vdh6xSiPStO2OHb/MTdSHcgTXvYuWNgphSeas9iHAVcMyTJp91rglMcbU
         39rPtRdAeuZUbhVS2tj1D6Xfb3LZQEeqAsiyQ82iT7qhG1PSEQ4RhPYUCb25SD90pR7R
         iROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738438; x=1745343238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcmO9he2/RNDLdjK2zSRDjAudFuUnVv9pUzsshxyYgI=;
        b=qvHf6kX/Vgpj1eUw6A9LfBjLFWrsUm/WiNou5c6zu/tqi5kMkRtuR2FAZhqtee83om
         AuX73C5Tc5abF0PatFNcHECHxo7W1RgaIPW6XlpNAiyAkaWLjV45sAdyHIo5u1mcNChU
         yqheMAAU6T8jnReoFQzhypQdF5qE2PH99TaLcuWge/usRfSgYUezJBOtMj0gbfYOdwUT
         lsRjFelD4u68f/aADtVk2d447jqGWoSH2t3MsBPYx19j5I3uEkuht6LjzZ9LkTy4IXaF
         76vMA/r+5mhdyWEl3p/e/zfXYpYDzg5QgLHlbun9OM4V+ZSKUHe8H41Ifh1wp16M9rV/
         YRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGsLEEygh8mvLzI//6v6nvvdO+Eovr9PFTqG3qT+nr2+++HJZJBxvD/A3NYGNtagD8DBs0Hpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhbRSo5gha3Fm+ssbi4VReRLx7vJ/H/wdgtd+cfCMNNpR+84T
	rAYy7paxqtg86sfbn+73vOU6qDxQDO6BEzgdYsFaSn1nru1JKb0=
X-Gm-Gg: ASbGnctg/rioTSapax6njKLj47NDNNON1TxrlgaRRIyUcn7j9G+VqxJ58XXdJjkiKzF
	PRi2Fe9AcyAb0sFTJ8BqjNyBi8wPhGspUO0kgOhBH0x+KzfQmZkBG4zqC45CguvgLfoUSZC5bHX
	85QIWXTVv/bteTZPt1b6WyH6KMHyGCNBsiezOisf1rtae2dKIlMZ2RG8wooXNVjOzIwW/Pu6s6N
	sO0DtA2qYeTEvKkJyFsiEe7bsh0lid6btCh69JfPL6td+EFq00X4pPRrmhfSbpsIKUkL3tVqhR4
	Vr86no4wSyth2WC75ASI7T/aLZENccLNGvtpkxky
X-Google-Smtp-Source: AGHT+IHdyJns4IFok2c3++kSZgyquNYxRGNY+sSn2rwhpt4+vrcNxvnREFhwOgGY6lD3WPJsf46Qcg==
X-Received: by 2002:a17:902:da91:b0:220:f7bb:842 with SMTP id d9443c01a7336-22bea4efafamr218851455ad.42.1744738437695;
        Tue, 15 Apr 2025 10:33:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7c97a1bsm120629765ad.148.2025.04.15.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:33:57 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:33:55 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk,
	sdf@fomichev.me, skhawaja@google.com, simona.vetter@ffwll.ch,
	kaiyuanz@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <Z_6Yg5UjNRLQA9mH@mini-arch>
References: <20250415092417.1437488-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415092417.1437488-1-ap420073@gmail.com>

On 04/15, Taehee Yoo wrote:
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
> 
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)socket close    (b)pp destroy    (c)uninstall    result
> 1                  2                3               OK
> 1                  3                2               (d)Impossible
> 2		   1                3               OK
> 3                  1                2               (e)Kernel panic
> 2                  3                1               (d)Impossible
> 3                  2                1               (d)Impossible
> 
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device.
>     But if the interface module has already been removed, net_device
>     pointer is invalid, so it causes kernel panic.
> 
> In summary, there are only 3 possible scenarios.
>  A. sk close -> pp destroy -> uninstall.
>  B. pp destroy -> sk close -> uninstall.
>  C. pp destroy -> uninstall -> sk close.
> 
> Case C is a kernel panic scenario.
> 
> In order to fix this problem, it makes netdev_nl_sock_priv_destroy() do
> nothing if a module is already removed.
> The mp_ops->uninstall() handles these instead.
> 
> The netdev_nl_sock_priv_destroy() iterates binding->list and releases
> them all with net_devmem_unbind_dmabuf().
> The net_devmem_unbind_dmabuf() has the below steps.
> 1. Delete binding from a list.

[..]

> 2. Call _net_mp_close_rxq() for all rxq's bound to a binding.

This should not happen in the (C) case, right? mp_dmabuf_devmem_uninstall
removes the rxq from the xa. Can you explain more on why specifically
the crash occurs? Are we missing some check in netdev_nl_sock_priv_destroy
that makes sure the device is still alive?

