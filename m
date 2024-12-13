Return-Path: <netdev+bounces-151585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA39F020D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AE71624E9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B63207;
	Fri, 13 Dec 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjRO92HU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82210F7;
	Fri, 13 Dec 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052918; cv=none; b=B2yHhRafMKikM3Ht9vp0pQ4a9LnY5dVI0xkT2y3+FcAtVCF3cYsfh31/NURrgyKonuGuDmNw0FZbxCU0KCH9i8MyB7xYlpjqYhsibFXE8t1ZnqvDWpOX4P9V3Snoqt/Y895QWjS1e4LXv9XwDAqGOr0PSnEP8PM5eJWjcOwQtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052918; c=relaxed/simple;
	bh=8UfhRE0B+xbCZ88Eb/WEw+UzVSGnxlupDdTsKbvsVEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8vjhJA3oZCPCORqzTgz1lZIItv2ZybkVCH06QpNPZaGNaxkOAMsWkaEMA8egFpJrKHOvh4a7YUgquc29HAzpUkQM8a/Al4hG3nioW18rWS6WgnWvzQqV70nu4f4e1r/frCKFZJnmsZ8iQMRkB55MQtPS4Fg8G9y3ilPSWuY88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjRO92HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579EFC4CECE;
	Fri, 13 Dec 2024 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734052918;
	bh=8UfhRE0B+xbCZ88Eb/WEw+UzVSGnxlupDdTsKbvsVEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PjRO92HUZUqqGScgUN/2ey6qub1k2I1EfiGjytcQQ42xfrSiuX8eMGcWFjs2BxHzL
	 vxEJKgUn/IjYKnSXUz8bIT3bIivFkSV8VIInPw+zPq1JXyUr59HACnxXEViyspDaVb
	 OllMRPy/wO6cgVoY6DsARlXZaf8gDMSc7FNwTGyR32jZoPS/HvQMB9fP1ASb+D7MMt
	 rKTregP705bXdVI64IDSx9FXOxKg+CL/g0kzw99vHHbi2axQBNOPm+nf6YpXhfV6LR
	 sa/ey7EKa1jgPVZBaEm+PPQ+zkNceY+ldatt+aHVUMn6c4kuYIrDYEl1ZKn7xqkVdL
	 HACBm9hxrI+cw==
Date: Thu, 12 Dec 2024 17:21:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Manuel Ullmann <labre@posteo.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: keep rings across suspend/resume
Message-ID: <20241212172157.40c7bf3a@kernel.org>
In-Reply-To: <20241212023946.3979643-1-lorenz@brun.one>
References: <20241212023946.3979643-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 03:39:24 +0100 Lorenz Brun wrote:
> -void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
> +void aq_nic_deinit(struct aq_nic_s *self, bool link_down, bool keep_rings)
>  {
>  	struct aq_vec_s *aq_vec = NULL;
>  	unsigned int i = 0U;
> @@ -1433,7 +1433,8 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
>  	for (i = 0U; i < self->aq_vecs; i++) {
>  		aq_vec = self->aq_vec[i];
>  		aq_vec_deinit(aq_vec);
> -		aq_vec_ring_free(aq_vec);
> +		if (!keep_rings)
> +			aq_vec_ring_free(aq_vec);
>  	}

I'd suggest to break out the memory freeing from aq_nic_deinit(),
and conversely allocating from aq_nic_init(). Then explicitly call
free / alloc from where aq_nic_deinit() / aq_nic_init() are called.

The booleans passed into init functions are pretty error prone.
Pretty quickly one needs to grep the entire driver to find which
callsites pass what.
-- 
pw-bot: cr

