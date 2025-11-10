Return-Path: <netdev+bounces-237364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC37C49A65
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854B04E3EFC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56D22B8B6;
	Mon, 10 Nov 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUiIdosE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15135958
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814762; cv=none; b=nRkUCvdz+vbzwkxaIG9UevENOLZOLXLl6gZmJptcbKRrtZPGwDbkY3l5ZeXg/L7K7O0i0mlDCF83hOa0xa1aXTumbnpKyx9Y6x3qzOji6GVGazyX4tPtpJUF+MdicpIW99ud1h4PuFBBUGTnr1k9qobyNExF1o0tHIbfs7jmsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814762; c=relaxed/simple;
	bh=K/fG9MS7eqhs/+yx4v9ZwKo0xyL1Z30Lj35m9pLCxOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3sFW1QMw/c8MudWhO/k7Xkd1wsW7gJP2bwJkAtuHECZg0C11ioQYpNdeljqayQtAQgKnXspUk5fWXCImCjwLRXcWKRaKx29HWzA0z0gvkHAckgqvUKT5VXkiWa3lIf252i5Y0+eLttjS+8HD1ZTtxivtH+AMlJm7gnMd/A8BqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUiIdosE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3437af8444cso1810123a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814761; x=1763419561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bXTWK5dy5u4IB40hwHgx6YI8Xf4UrwZEMyOj058c28=;
        b=HUiIdosEcn/1C7AFsOs8NmcZ6gxVY/iBXUFwwIAEFrFKmkvr4nLiDRKit4/RCj5nHQ
         2m2I7Ge6lUGUxUSmkgtfc/4O5LqlmNa3WXzeap88Rjhlf5le2G+1QIo5pzOR2HCYJqqu
         o6C/SmG62f66PVr84OzY12r4qn1/5Qu/w7NX/sGBDkeDyp+TddYReAyVpMyAESCjy4+A
         07qawYKdxkqcxBKrGN2pkxAYke9HWv6s+inyD8MgIOWrDWccdA8CLczCScCBjIJe5o1m
         D1Ul2hZjzGNRE+hzhq1oxRLs/zCrMXWcpegdaY1fSBgVyM2zZJaOzlc3XNNgMajCZWrl
         Kyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814761; x=1763419561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bXTWK5dy5u4IB40hwHgx6YI8Xf4UrwZEMyOj058c28=;
        b=JFQX2CTKCvDnUkIo5aGDRgooe8AmLqqXlNq6GmcQHvzHMVZOlE1cEqnOzOGHb5OeMi
         Rc6LaTVTK6ZXvtG+zXI+EynGIVuwih4Uehhvk82a6hvNyvquK9yrxkBPzz7CrIWj4OYp
         xtqprqB/HLfeCuSzynndboySQvwjfP3HINJrwqXj9WsZ2+LjpIua7g4BaogHF9VR6kug
         dwHleNETIXenYbnJ2yzYAaksHxwm4PywGPKR0w1SEuJFfgPiy00Z5UI8oRoVS6IWTGvf
         bRX+YDpop1kim9Un/tOfatBjVDfiRpR6/DJXdktvwlmdUwERrRGLZMS4MUbVDrVUZhN7
         1ilA==
X-Forwarded-Encrypted: i=1; AJvYcCWkZLw4Yfq6ptaFmgxbVUUm2tIA4byPcUcZoUxsffgUkf0qlRNgc5x8IWNtgB5AmgdSz9yWNIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzET9GNQMwgsnTf/yT4Jn/AxSvpXhCcQERjAMylXLOCQe1gMR4
	RUxP07G6x3QfnKhZ4L3P7Bo6ansB3oCrWVsV6YVf37fO0d+UA/mjA7U0
X-Gm-Gg: ASbGncu4k39sMIq1Hotoz0SNGHdis+3g7mCqKYZJVBhJTbeSZ5enG8I8RFH7vl8StsC
	b0/HDzv1ldGEyLE/WKVGf+6ot+cHPC5EkfplT8/L/xXz3rODaCw7zjOjI1Bjf71jp4SMtDCOAOm
	RgatCBt4lfDCUUQMdZ9PJPfPpdwic3ca9cSSVbJnIOEFR1o11NU1a7a/D/OSPiB9aY60AS52HuD
	9tmn6650xJ+O5AiQBTjopn88s7VqxxrsUoreZh2/1k/hEwXSI0g3eVRz3gihapS1hBoXxlMkMbD
	d8VNvL69P7jIeJ7rzcMpFlexCaYf47rLpy0o/8UFWTpTYb8fYUny/jfD9X2T6WC0IgVVZ3kszlg
	eGFSPoxwDnG6kctBVdVLr8HGH0vgY8I28yg5yg3NfUYRK/zf7Qs8t3fk9YtMTM2zVxvlDXVhDaB
	a0GqM=
X-Google-Smtp-Source: AGHT+IH8SQuEuPFfERn4i7j25XYcNVaTxnOQIa3JdEp8CVYnfIEpY3I76GkKxI29Oh6pOmVWFS7WGQ==
X-Received: by 2002:a17:90b:4ccd:b0:340:6f9c:b25b with SMTP id 98e67ed59e1d1-3436cb89d50mr12491830a91.11.1762814760598;
        Mon, 10 Nov 2025 14:46:00 -0800 (PST)
Received: from localhost ([173.8.162.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c708c08fsm21153a91.0.2025.11.10.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:46:00 -0800 (PST)
Date: Mon, 10 Nov 2025 14:45:59 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, wangliang74@huawei.com,
	pctammela@mojatatu.ai
Subject: Re: [PATCH net 1/2] net/sched: Abort __tc_modify_qdisc if parent is
 a clsact/ingress qdisc
Message-ID: <aRJrJyjyif/axyxf@pop-os.localdomain>
References: <20251106205621.3307639-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106205621.3307639-1-victor@mojatatu.com>

On Thu, Nov 06, 2025 at 05:56:20PM -0300, Victor Nogueira wrote:
> Wang reported an illegal configuration [1] where the user attempts to add a
> child qdisc to the ingress qdisc as follows:
> 
> tc qdisc add dev eth0 handle ffff:0 ingress
> tc qdisc add dev eth0 handle ffe0:0 parent ffff:a fq
> 
> To solve this, we reject any configuration attempt to add a child qdisc to
> ingress or clsact.
> 
> [1] https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/
> 
> Fixes: 5e50da01d0ce ("[NET_SCHED]: Fix endless loops (part 2): "simple" qdiscs")
> Reported-by: Wang Liang <wangliang74@huawei.com>
> Closes: https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.ai>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Cong Wang <cwang@multikernel.io>

Thanks!

