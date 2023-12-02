Return-Path: <netdev+bounces-53288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A8801E7C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8901F20FF0
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FE1C6B7;
	Sat,  2 Dec 2023 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2WvaQh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1BC1
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:31:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db7d201be93so1232140276.2
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701549103; x=1702153903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48OMsolS9lZ4w/TFT/6xEIFIyqBtXuSVHIXwSvM3sjk=;
        b=b2WvaQh0zNjjo8mdZnu9ALTrU11kWTjc/x3pnJMBuzPIsTBcZzUzrlW0BRdx+wyuLz
         3qgkWodPRXjfXl6frw5tpeDO3GUXbCxLOmjf7fAbMP/8C2hBx1oga879GzM9Fh5GI35f
         ffHyh33SCJDZrAwPSTGY/4f4JMUkFNtE1dWxuBUB8viWB99PBrePgm8VzcYJtxRzwc8V
         /tBoKEHG35NCU/glzE4p5ftN8IaaiyW6z4CqEaAsdPQK6F1iYgK2qvQjttzeOISWrvuG
         JOMrdL3nQyGLrZ025MmJ/zwaTuDaan9PDjM1GE4sqmFnczx7YogxKjBuNdWYBMrzbdn7
         PybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701549103; x=1702153903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48OMsolS9lZ4w/TFT/6xEIFIyqBtXuSVHIXwSvM3sjk=;
        b=ddW48TFAZmMEfSarQEJAAZvrxImyZ7iVTEPvUHQiJMK5jsGYWJVU7dM4mvANrLNB3E
         WqMSjmriFFq+kEsm17T9wr3pHcGDJrGGIW6wZHm4kMey5qBF7raPKlG6n1XJ1ZNAFMNv
         Ix5Wn1IBSR/gtmtiP8lKcJmosl7WL+BRN1j1t0EMugUYjJkNiCXck9a1HHxm3w8X6boF
         CNAIulv03ynxgEcAaC/Qu3ZlY5/e1g6b556Uhl8GCJiaHqkbCciogfrRMccBWYUFHDRt
         MHHVwie57BmuSDgdJo3VfWHYkkCaIVa9WW5foCfVtVXn3uK9cCT8devbIuYIDySVERXT
         inmw==
X-Gm-Message-State: AOJu0YxzHiNhDExOQdR+Bql5BVk1h/h4utIQcGm7Pf43fk19DSdQM8Ij
	uF4scu4TjyOWcAI6UnUQFdE14HKKJwtihA==
X-Google-Smtp-Source: AGHT+IGBvcQFZuKCi3snp2s9tWKmB5PRIuGygGPHVSxmWQiUTRcu4EbEHsUNxu2qOXTCkfea7bGZyndBYmtQOA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:1083:0:b0:db4:5dc7:3a64 with SMTP id
 125-20020a251083000000b00db45dc73a64mr790877ybq.5.1701549103627; Sat, 02 Dec
 2023 12:31:43 -0800 (PST)
Date: Sat, 2 Dec 2023 20:31:41 +0000
In-Reply-To: <20231129072756.3684495-6-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-6-lixiaoyan@google.com>
Message-ID: <20231202203141.or3hyqqk2pel5nfu@google.com>
Subject: Re: [PATCH v8 net-next 5/5] tcp: reorganize tcp_sock fast path variables
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:56AM +0000, Coco Li wrote:
> The variables are organized according in the following way:
> 
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
> 
> Fastpath cachelines end after rcvq_space.
> 
> Cache line boundaries are enforced only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

