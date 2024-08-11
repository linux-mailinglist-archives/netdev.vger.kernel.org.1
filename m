Return-Path: <netdev+bounces-117515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2594E27B
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB812B20E25
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C614A0AE;
	Sun, 11 Aug 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/4gu/O5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6B146592
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723398855; cv=none; b=ZuIkhIcnGAsQ6PKdobId3nRw4fPfeAEVYUXO0aRrc6GnjMVxsIfpyclGhfFt9o67ruX50l6y9uGyI8awY5gozJsUCeUGvWHqjVV6KNVJTMDm59dk0qpygjlV5gLWAZaGN6+2Za4JIPFvC+St/ZL50/1v7fZXgHOCc9cbOBpmgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723398855; c=relaxed/simple;
	bh=GNLKVMX9SBhwqGQTVjxbKhEA2uvS457NOqqpXArCIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIisrvihWPEvCUOnDLaeGUhnLtaLNF7ti+RlX2F2V1KLrFCiOTPO13+9xUgWqUH+j8OD4tKKj9BSFaJO6q7PGEE0HIDxgUhQWQ9910rfnTUAkk3ixEzZE6z51ySt5o5VY9gThFWRTxVa0dX9lqGR3nxgp030aIX2vSHe6mGGxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/4gu/O5; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db130a872fso2723233b6e.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723398853; x=1724003653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrngI5gu/Obpw2lz8P7hRsmTrqlMYT43neDjlNvayjo=;
        b=c/4gu/O5+djyS1JZHP7CaJYQ7/sFpT1EV0KtnVIbIWI4kPnvqntXU1dDUhGu2od8Rs
         au0vZZY/fpa/9KnnJ8WRGnQVGp0zAoc4FcKPDPJBuGiSrRT9LzQEqxhR0tHkS9mIqQHH
         21qS8zaAAEyQzP29e5k3ZhnDSs5P/4YCx5r/t8w4Rr3yisXCeMkmlbogFeckqo7n8lKA
         eybGIhKCgDIl3T+vEfMcMr5Kic2Y0t6YBBze+5qRJJTiVuQbGzHXQ67q+eHU/rTg5Uxt
         MrMkV829RMsNHzkmvt6btr79ukUYq1b9+9r9T6sM9BUp1RkfK8QQ1465HSDdlNbR4wln
         8RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723398853; x=1724003653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrngI5gu/Obpw2lz8P7hRsmTrqlMYT43neDjlNvayjo=;
        b=QVB+R9yhqtcU96AODKUUjBm5PLgZL48xteQU+ICp6DSJI8U6fKnFD7JXsX+ZONfKiV
         SQIbLMpp/0b5XlT/0xvlblDDW7OipnD3+lo0J2nqhNsZuCurkQE7dMb0ksjcV8JW7Kl8
         bT+bLNXQKcYsKnfN4j6oINFWj7CZvM0R4OjkEhKRrZT5NJIyCMfgfx0PbcA3iDckY/rb
         guQkUAE8pPmkkXmjGcku6lRX5+A6tFDXi9x6BGp7n1KotfCQxHK97gbbKWoyiYuzWyW8
         +Z3s2BOHta5xpBaUUg6i761LNIz0R3eLqCe71DaeQQ3lmp9YTkqn+qr5ycXMQmG4F4F8
         Zs4Q==
X-Gm-Message-State: AOJu0YzGE6ktuZZ46BIMh+ZgZyJPgte4EUSV2hzXaXkcAe7FgWgaS4kS
	TqC3vxftHcydQVHBid0QLs02QZMMkBHJcC4W41RYTkzyVjdJZMN7
X-Google-Smtp-Source: AGHT+IG904uVJ5dsNZJBSEfdPllXxJEk0GDrhgb3DoIRtgp9qFrajxeEV46HdeTKHKI2NvWvvvA62g==
X-Received: by 2002:a05:6808:3a1a:b0:3d9:33d0:cc4b with SMTP id 5614622812f47-3dc415e42cdmr11986217b6e.0.1723398853575;
        Sun, 11 Aug 2024 10:54:13 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:8ec7:dbc7:9efe:94d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2d6bsm25032395ad.177.2024.08.11.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:54:12 -0700 (PDT)
Date: Sun, 11 Aug 2024 10:54:11 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com, horms@kernel.org,
	syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net-next 9/9] l2tp: flush workqueue before draining it
Message-ID: <Zrj6w89B7so74jRU@pop-os.localdomain>
References: <cover.1723011569.git.jchapman@katalix.com>
 <2bdc4b63a4caea153f614c1f041f2ac3492044ed.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bdc4b63a4caea153f614c1f041f2ac3492044ed.1723011569.git.jchapman@katalix.com>

On Wed, Aug 07, 2024 at 07:54:52AM +0100, James Chapman wrote:
> syzbot exposes a race where a net used by l2tp is removed while an
> existing pppol2tp socket is closed. In l2tp_pre_exit_net, l2tp queues
> TUNNEL_DELETE work items to close each tunnel in the net. When these
> are run, new SESSION_DELETE work items are queued to delete each
> session in the tunnel. This all happens in drain_workqueue. However,
> drain_workqueue allows only new work items if they are queued by other
> work items which are already in the queue. If pppol2tp_release runs
> after drain_workqueue has started, it may queue a SESSION_DELETE work
> item, which results in the warning below in drain_workqueue.
> 
> Address this by flushing the workqueue before drain_workqueue such
> that all queued TUNNEL_DELETE work items run before drain_workqueue is
> started. This will queue SESSION_DELETE work items for each session in
> the tunnel, hence pppol2tp_release or other API requests won't queue
> SESSION_DELETE requests once drain_workqueue is started.
> 

I am not convinced here.

1) There is a __flush_workqueue() inside drain_workqueue() too. Why
calling it again?

2) What prevents new work items be queued right between your
__flush_workqueue() and drain_workqueue()?

Thanks.

