Return-Path: <netdev+bounces-170875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1890A4A614
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15A717761A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E81DC05F;
	Fri, 28 Feb 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4aQMcRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812D23F39A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782453; cv=none; b=NQnrZtRB/DfYHjFrH38NPJbMQdJdwVaY/+4zsgvIFHt6ty6t4En4ZSKf0GPz2l8lS3tKxwSQCds4/3erpaPPFs7KaeymW29tvIS58HZyanRjN2xVbXUVzlJx/Jzy3eWeTUuLY1KoQxUOT/VYNtkz99WklV+z0YCkx+KSxT+sX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782453; c=relaxed/simple;
	bh=B6JatvontBrmRfmNBlKjt98ltkODFx+96updorEn+DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHH8EYtu4aGEIKFJ02WagQ/9wugcCACg98+66agJLezMqJ5C24c33hJnro1pB1ZFCvne0fzvtui/t/SkuTCDEkV7UcRboFdl3VdQJm0CLxfLLAdCs6ibYlIsEdXfH0FnBGc2vlezj3E+C7rqPTRM36OEvlq+U5vxo+KpL3pmr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4aQMcRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC4C4CED6;
	Fri, 28 Feb 2025 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740782453;
	bh=B6JatvontBrmRfmNBlKjt98ltkODFx+96updorEn+DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4aQMcRUvkrsIo+x/amnQT2Eqlj9JaBnrONGPMa41w+IuuUJhKPRerdqU06HjMQ/F
	 UFWiY6VefrjVTsBffZdMGoyCXinyXhNOYBHKLks3Ti85iLEjN+n7HMmqYGt4ZCH7Gg
	 iO/0HSbgbtedNd+UaG3Ugx+y4+D+vA8fr0UFyzS/O1KiM63z+3W3f9n/tdtPgx22Bc
	 ucubLnyGkjTmpk+pNkkpWkcZka7xp8GQXHFBQ4E6QDvK3rLi6LGDA/pJOtk+7DYleM
	 51TZe6kkZdeYEy5JEK/9h1TOg3jqczecnEl3BDmr6LXMwnc1qam4JDXT5r2HzGjgKo
	 LnulGQ3N+R75w==
Date: Fri, 28 Feb 2025 14:40:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Ahmed Zaki
 <ahmed.zaki@intel.com>, willemb@google.com, Madhu Chittim
 <madhu.chittim@intel.com>, Simon Horman <horms@kernel.org>, Samuel Salin
 <Samuel.salin@intel.com>
Subject: Re: [PATCH net v2] idpf: synchronize pending IRQs after disable
Message-ID: <20250228144051.4c3064b0@kernel.org>
In-Reply-To: <20250227211610.1154503-1-anthony.l.nguyen@intel.com>
References: <20250227211610.1154503-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 13:16:09 -0800 Tony Nguyen wrote:
> IDPF deinits all interrupts in idpf_vport_intr_deinit() by first disabling
> the interrupt registers in idpf_vport_intr_dis_irq_all(), then later on frees
> the irqs in idpf_vport_intr_rel_irq().
> 
> Prevent any races by waiting for pending IRQ handler after it is disabled.
> This will ensure the IRQ is cleanly freed afterwards.

You need to explain what is racing with what. Most drivers are fine
with just ordering the teardown carefully. What is racing with the IRQ,
and why can idpf_vport_intr_dis_irq_all() not be moved after that thing
is disabled.
-- 
pw-bot: cr

