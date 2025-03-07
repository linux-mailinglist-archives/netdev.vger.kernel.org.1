Return-Path: <netdev+bounces-173084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD38A571F3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9B7A35E3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189B24FC1F;
	Fri,  7 Mar 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McuRxN67"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156A1A3035;
	Fri,  7 Mar 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376127; cv=none; b=obq296Ah9D6RfLyAFbVlfvpsebjM47OoA82IYHVAXuHvSVWRw6C0fK/PG6u1tRXE3nholygBgh5uG8jxmZkaXlB7dIHMxkeqvtxw37gAsnrUACd32RFGe/4SMZ1rrWB8gD4cLzo4LMOF42VdpxcKyq2O0l7RFB2gIEG8fWYiFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376127; c=relaxed/simple;
	bh=b3YKDd4f5VM0/bYXYdj1H2B9mEQNOdGupx/drXrREsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMPex/MeDgidOeGT4IUbTIRYO1Lm5bkR0770oiwV9v+VM9Ke0Lv02HZgPStknXC7vxxETDYv+z/d/Csuw39Ii69gAkupSmz/1Ff/FsIgbUF6i0kN/wG1sdIdz5Ns2s9l3rCeHGDv+oOPw/BJxxmnckDItOGF+96arcdc6rv2+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McuRxN67; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso47624385ad.1;
        Fri, 07 Mar 2025 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376125; x=1741980925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8BWp7SYMVhayY4CKxIe7LlJTrQSlVuOhnW/1p2aS4w=;
        b=McuRxN67rqeNwb8r41mYaMJYW31m1uJUEMQlwzxPp+8FMdLkpLK+i0D2DR4ufQLY/1
         mXdhXZsPKXt0ta9HiYo18nUWzT2cAbquzN+0gksm9GGGYwHgbQNwh+rxs7LEWCEBVFFY
         A2hVW4r6pql8gwrc4YWl39kZK2KH7vnE2CMKvnHDoi02gtlcv/XdCGmWFisVlz2Eaftc
         QBdlksR0DPnMqYf/h0//JKip6CgGfeqSnsKcSC6XWHcR+9WcbJSjfigvgNDWDjatqj39
         ql4GZSmVolDZiFJEyLzUg8tCLHVMsVbtsyacxGJQofd0sTBZprocgaSKUz/QvNPhY4P6
         kMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376125; x=1741980925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8BWp7SYMVhayY4CKxIe7LlJTrQSlVuOhnW/1p2aS4w=;
        b=Wu/ogzMxoTOhmuQ/SWwDEngF9HsVxFlGG/NgEtXaCPMOjfpBfSKDf4eAQ5zBeHuIi3
         GCx8iT+iK9Q1Mh+7ljrQpVcd7AJBG3z5FDBOUrPAY1S7Opi22bDOi9jPfFsupGJzoF+y
         QKg1nv+BAW/fnffFCW3wtDWayfDX+0lJX6it+di7Luk9NhRxYhV9wYlqeiZqMNV5x5df
         WBbtnXxsEyqa0c7Hs5FlQ5V/Uaz2eoxtnvRSf4Y6WPbfU0WdO3p85i1TD6ekwWDe/WHG
         6Jmhue3KuMkUcLsretacOftq0a6023qJ9g4iPCPbcq/yV07pTuJgecDNYYzhBncISNOX
         OSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZl6GOeE03Ooz+QrNTOsR6eQN8W5bQXAUzKIVLoeEbBM1u13j8+4Znqb3ivFPrgdHnw8XKlFcx@vger.kernel.org, AJvYcCXojccpn4Ov7vqpuS2cxsjzTMDnYNUZEJzpq5Hp0/rqvqWM8TaF5tlPTZnH9FCO730KzGPqQoIqt4a+usU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEaJMs5+a4+IjJM7tv482ztnoIJFOmm0XOb6lZasrqdnDoCBVg
	uMu9aEHFsJSuGjrpVwkWXKUxDFpgAVOn2TQpkom1xuVcWPvEHeY=
X-Gm-Gg: ASbGncvMBHGIkkz3wAfSHWRRtmRrxvEYV22Phwky2kWxO0vwXUH6ubk11PrTwcsJLWE
	JvCsQATS36ARf2gl8FMfozL26syRIf8yfcluitGG1ms2BDFHiI7Y3tmdRWMGbavCOW099KKmUXy
	Inof44NB6c9ZHcurA0kfPzStRVda+U/B5dSi4WVK/E4ymwMfT7Q6htaXo9PVbsNssQ3rUj+CWC6
	J4T7+ixTwYqCnWOpT80EOiXmitwcWQMkrXd5+Naz8zVY+JLnW24UbTlHkN5MLc/WUfw/Vc4GszG
	BIenU86UUTn0EolsQrYT3dUlfmC+tcuG37LW1PyeP8eB
X-Google-Smtp-Source: AGHT+IEE0ql92Xapw9wLKAOKUtGO9j+8KA94RO/jKP8EfxcqJZ3AEbydlBJnrddqp7jCteCnMnGH7w==
X-Received: by 2002:a17:902:d4c5:b0:224:76f:9e4a with SMTP id d9443c01a7336-2242889249amr79831735ad.14.1741376125143;
        Fri, 07 Mar 2025 11:35:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7369820697esm3634589b3a.8.2025.03.07.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:35:24 -0800 (PST)
Date: Fri, 7 Mar 2025 11:35:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <Z8tKe5O7ICE3xK80@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307155725.219009-4-sdf@fomichev.me>
 <20250307095049.39cba053@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307095049.39cba053@kernel.org>

On 03/07, Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > As we move away from rtnl_lock for queue ops, introduce
> > per-netdev_nl_sock lock.
> 
> What is it protecting?

The 'bindings' field of the netlink socket:

struct netdev_nl_sock {
       struct mutex lock;
       struct list_head bindings; <<<
};

I'm assuming it's totally valid to have several bindings per socket?
(attached to different rx queues)

