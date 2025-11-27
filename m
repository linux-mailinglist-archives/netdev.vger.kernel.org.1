Return-Path: <netdev+bounces-242375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D499DC8FE53
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27A14E2EE6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17A2FFFA6;
	Thu, 27 Nov 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry8hthPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BD24886A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267700; cv=none; b=XV7LjGNCwyeOqjZLbj3sE55942wmI4OToJth1EOy7PhtccSvVjcAqyeb5Z8H9NiXRASt2xovngLqEhsLEVqzs+VX5VIjNF/fY9DbFWcEbNz2xkI7k8swI91OOiu29k4VKHcDlXsaoha+VWMEfShqog0wpdu+ZEe6orRk0g/CKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267700; c=relaxed/simple;
	bh=igWAjH0xNQvJLP11ckoZjjC7ciLsokNpa7VjOwFJSMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFvQ/GvWjhUjeYBg/mRGqWiiL1R1x9ntDixNUmCr0b5/LyJ78ObDWec6gAXSgabblgfpClPwEcPvqek/EhDu/y0U/QY76SL61KZHU9OWSit4yuuhm3mTuWykWuWqImLz8oFkR5nZbWmrDnTBTZ1q7Vg/RE7cmZ5BkSfkunnFqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry8hthPc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29845b06dd2so14865095ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764267699; x=1764872499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S832dEXRRuljnsRC8l5OHuN+DNSJW8AFtuJhBdXtnKQ=;
        b=Ry8hthPcoRaxhU5rUfrj0+ggSPuvHjYR9cfw3AGrRRuYyRLWTLMDggAT+x4Z4H87ID
         Ls0pYZ8FCbgzaJ+VMy0z6ddbiAoCmzv0D5EwhtieocNtpzPOQzsjdZ6nAQ8aLcMoPSfc
         os24/nqVPxwl6uP+cKZHj+zrFVHrOa+XFAHJxem1wOB4R+Bed5JntYyY6nlXm5JkE8Y+
         pONmS+ahw/JoBYPZ8evCn3VYUvl83Gbt/da4/Jvos61WKhXnVHNQAIwMQbSfnJP6gc1m
         prjc4LTYr/qWO//5wFFdMeocsmU8BPUbx6ERs+1gyMZ2bMaUeG5nDQpddooMsQb4dzVY
         v9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764267699; x=1764872499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S832dEXRRuljnsRC8l5OHuN+DNSJW8AFtuJhBdXtnKQ=;
        b=ISQOqr64SsOGLqAYEiPI+zBg3DpWD/gs0Xw28XoTC2pMXLVRO9cq7ohHS4bptkh2XC
         k7PB5zYz9lGa/H7gcUNl2MAUCYpGqH+ZYL9jFYmd9SPyGM7aae1LimZTzAhx38IyQRUH
         rICDKWmarbLrltWWRDvTDbOnsTigN0Ud6mgW0BIOjEL+9m/X23vTcObxgYwnzu9F6jPO
         1GPIZPwNWhVWvuqTQrT+M0AuMN+gtJvSjVdWxcOmjKjf1FVdXepoNqdmHxV8leTow3It
         gG9LHUhAKGlmlPIgI5D93J+ogfwoolTpBwSyzk8yJiU03arwTOAvGI4929vhiWB429It
         2MXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW41JGcWyhUi2Vlw0O+GKagMBcjG3RFgNEAxO2QccF4cvud6p475p4nl2PDIDXk+/1/CowQJ3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iiK1QYnmrQyrY8weLU/K8ijs/cQPqPG6p3nuU5i3HJ7EQAup
	V5Y2p00tkAFYhvs+ZVOyHycFR/FYUMHNP1cSkxc28yFL2CcmXMoWgnhnguEJ3LRg
X-Gm-Gg: ASbGncuGYBXRoN+hZxRrXrjTOTXECY+Af8XBd2fs/Di9gY63ZsXfHS5DKsWS74KbJT9
	GtvXqHd9LoNUuSUM3bcrHeTv1jhROll0e3xZa3QZ2hfeszPjv9k+xAPrcVF4X+5oZPls1w/U91r
	98i2YzShshitLKPQC+aTAB0IlQh7A3CnKXXeaGr3aQTHa4zWyWsE4FPf1qKBXfyV4vV6O53HppF
	LNMRWRU3qpOk2QE1BqWEiqTEa0qaYcVkuVvl4CLH7C6CZtyQtZKgkzEQrywHe/54UqJF4uZ3GYR
	PQbdC8zYheiNgFDAdAtQg9u8rxyUSWllQEqGoBIjK/liIECz/K0QFwtSoXrv7vjYuHProauJEh2
	om2JnArZRaV3J+nBrUNu8M4zPKC9Fh4PnKtk81OdKbcbfBHXSaxCP36KkNTg/mQtypoYicIxxhm
	aeyd3fe+0b0RnYkEVJFQ==
X-Google-Smtp-Source: AGHT+IFQ4/2Vr/mxY0n+SqNV37TuiRIhfMDvknz5AL9lBvrVetHKItz/kUdW0miXU+pEjIjEpFDdWQ==
X-Received: by 2002:a17:903:2c06:b0:290:94ed:184c with SMTP id d9443c01a7336-29b6c3e86acmr242338025ad.15.1764267698678;
        Thu, 27 Nov 2025 10:21:38 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:ef22:445e:1e79:6b9a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be508b06867sm2467380a12.23.2025.11.27.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 10:21:38 -0800 (PST)
Date: Thu, 27 Nov 2025 10:21:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v7 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
Message-ID: <aSiWsNrWQ8PDhk29@pop-os.localdomain>
References: <20251126194513.3984722-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126194513.3984722-1-xmei5@asu.edu>

On Wed, Nov 26, 2025 at 12:45:12PM -0700, Xiang Mei wrote:
> In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> that the parent qdisc will enqueue the current packet. However, this
> assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> accounting inconsistent. This mismatch can lead to a NULL dereference
> (e.g., when the parent Qdisc is qfq_qdisc).
> 
> This patch computes the qlen/backlog delta in a more robust way by
> observing the difference before and after the series of cake_drop()
> calls, and then compensates the qdisc tree accounting if cake_enqueue()
> returns NET_XMIT_CN.
> 
> To ensure correct compensation when ACK thinning is enabled, a new
> variable is introduced to keep qlen unchanged.
> 
> Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Acked-by: Cong Wang <cwang@multikernel.io>

Thanks for your patience!

