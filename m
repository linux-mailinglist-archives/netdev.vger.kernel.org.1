Return-Path: <netdev+bounces-282375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SELgF7798WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:46:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D754943E4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E3383014577
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08E3F9F5F;
	Wed, 29 Apr 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cjdOky50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B43F9F3D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466694; cv=none; b=j+iomXP9/IMsC3CVDEU8oNzmk8LExljDznf7jZxfgKgPwEdvzgs5DfJkNiiZuVajpYNScdkO/ezsSmsFWdvSc6P4vLvp9CFhQp+Hg1w7XDTfhFttgjI/HjYQQPd+DaqIsx87NzEthac2H9devRzJ4dt+iYzmgJ2eBX/9v0NVuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466694; c=relaxed/simple;
	bh=cH/0qZ1LJLqk2hgeVUqmt+2yHUuaR5aF35EFiEHHd1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK8bzSszMUHjreQaPCulcyv2Xbv452lX1H2y5OmJos45qi7kzjbbx0q5J3ZfFnVLKB619ZF+ag/EmGYItwBLJZ3oQn6eHYqZx/wTV5q1fNmHJeAIqh54Fa/R2jrShuFbchosmp2vlWS0943X3zVWpz89/iCI+m+vfRlnusc32fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cjdOky50; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso115851976d6.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777466692; x=1778071492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cH/0qZ1LJLqk2hgeVUqmt+2yHUuaR5aF35EFiEHHd1Q=;
        b=cjdOky503JQ9yaX5eUxHq1FyaTqO6CmB0Lxv5TIoctF+80Zj0oBshdaoS2+bsgV0Da
         pO6PrLwbXT+hFJCIwhoK8x9wkdkCXrTEbEnjyaTxCV7eh9uYnkNGg5zzkwanvFcIT0Sd
         j72sRmqFoSgWZv8Y2GVgbaYzh+osMBCIIjpbXhiyKxpfI3viVP9DjvW1nOO1Mx/Sj6sJ
         IIiRMEUk8JUJmYhNdNVL1sMID2TzAVXhDYQDyYfi/UMRY/7sjkoA2RKH9clpF9maeByy
         xbzhCUKiXviH4utGdllvkb+1gf6gAM8nJ1YMJqkw/1pWHBC3hjntIe16Xphy5zy201nQ
         s7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466692; x=1778071492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH/0qZ1LJLqk2hgeVUqmt+2yHUuaR5aF35EFiEHHd1Q=;
        b=bItUpr9wYVkxXiAq0lLDaAu17iIgoEawFKOwoFtVE8Lx2DURFGSxnN/W94DNDDuMiM
         7c4fn4686znQiNf2Dd8tvJpPns+ud/w0UqTqLAeMPQJCOAn+TeUFXLnJdMJMkqR6m4Gs
         kcnJegicWcV5/62mD/jdkK/XM5H/ik0SGPAM9YSLuq0lHwbncJ/bcHQHHQPTqDu2A4Vr
         BrHRd1m7/RQbf4XwgUPU9tKPrXaAhxYT7q4+XmTACpSZBrYOJ+iQgczxqVnMZ4iyXTJX
         GRz01NlvfMbcxZ2E1nRx+DZlDzh2kM+F5E0Vt7fp7JxIb3icnz1ZEijFS/2taLrQ2ikt
         XixQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WJgWn62yvl+0fvwahuEb3EIVFCcQ9GEx27JowM1WJddIrc9CYnG6yUNMByZgZ7QSLsoW4b7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqdwS4XUODltAY9tGGwzcNJO8+hJ8dfx+YlDY7t7V5nK8UzaC
	GkkZeOJr9TvQb8tuwoIyjY6oG8fKwGyKEFdAAxrpYy6gyAF64U7PwXSQjt4P6eJuWzM=
X-Gm-Gg: AeBDiesBhHjpnTY3aS2ghKGfKT9eYSzGFpEXtE3EvZ0CWPApiT10zjUBmvpTcacHpPQ
	XIqtOvdb0SgDDKenhxs1c2D6xLWyLVwrCrvfcjejECd3eqfw6mn1moTTYj1R3XNbxCgQO4f5kqs
	EmVUXhOqPXfLxComonXLQDJAg14H8dTwiAFxdE6U5oZLfZxiH2IiMnvhRQC+pzcgqSJCZ6IOARF
	0TRmrSnUaBnqCRx24+jjKB3iFawQfEgLqpvL1aItRXXBFtVQ7lWlDaDU6QWrZ4NKMqg/Q1wS2OG
	Xadb+to9CwD37kGCKUANy/+Xb41CUzMlN3NOU84hyYKw2a3ejLbYV9HWCGRg73HXMfzatubEvNa
	H4bjfYHdw+wReSqRM7sUsfQRuKSuN0BhK181GgXTufaAz1E53T/FmLY8AxAeEy586rStrteLwqA
	OITpI+k7F7NAO9Gg/bck01qpPzrDdgup2M99rmYEja3i9SAVvekeqw7Pmt0lakP1ZkX6eG8Lh2p
	+nAmr5zQbAszsCj
X-Received: by 2002:ad4:5dc5:0:b0:89c:d7e3:7f01 with SMTP id 6a1803df08f44-8b3eddea081mr56284876d6.48.1777466692493;
        Wed, 29 Apr 2026 05:44:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef6fb56esm17072716d6.7.2026.04.29.05.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:44:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wI4Hb-0000000HNPu-2ciA;
	Wed, 29 Apr 2026 09:44:51 -0300
Date: Wed, 29 Apr 2026 09:44:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ginger <ginger.jzllee@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, ttoukan.linux@gmail.com
Subject: Re: [bug report] Potential refcounting
Message-ID: <20260429124451.GN849557@ziepe.ca>
References: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
 <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
 <CAGp+u1baSuC9z9rGkJR0v1+eBW==9ppxh7tSn19jJOA9bX1Ycg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp+u1baSuC9z9rGkJR0v1+eBW==9ppxh7tSn19jJOA9bX1Ycg@mail.gmail.com>
X-Rspamd-Queue-Id: E5D754943E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Wed, Apr 29, 2026 at 06:13:40PM +0800, Ginger wrote:
> Side note: to see if T1 (i.e., IRQ) can fire, I checked the calling
> path to 'mlx4_cq_free' and only 'synchronize_irq()' is seen, but not
> 'disable_irq()'. It means that T1 may still happen after T0 calls
> 'mlx4_cq_free()'.

synchronize_irq() is supposed to wait for any concurrently running IRQ
threads to finish. New IRQ threads will then be guarenteed to see the
radix_tree_delete() and can't see the CQ being removed here.

Since the refcount is != 0 until after synchronize_irq(), and the irq
can't see the cq after synchronize_irq() there should be no issue.

Jason

