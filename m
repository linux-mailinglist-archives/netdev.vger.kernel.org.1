Return-Path: <netdev+bounces-101088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F58FD430
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4056B21755
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658813A86A;
	Wed,  5 Jun 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2/TVJ8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277025777
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608944; cv=none; b=WHxpEHbprnJHrDRI1qTW2EJ6PCcezliJob4sCII//z1fTvpCTyoQUlVVr4Gli+nT/PPOBZFWOnHAjzblCvqJ/GID+0EnLOb47gfmvNk4nBtx4qje1aXvmW9QEFwSHAI/mhhbU2o8S4t3Z+3ByPkH3G48h8UcC8t65awYM/Lh3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608944; c=relaxed/simple;
	bh=0vuPJ8mp8gpjouUMhPjdJdlQWCT5C9c3PRYpTb1N7Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/IA8AgLco8ZZqebv5g7fXsO7fnlU0RQ7jReTQMG2vLTJrdYzhp2+RdD4aQ+yJ6YZ6cFVXCp51547zKtJYuSR9Z3EMhzjKnNiNyDagVj7+nBVDww4rfUTtif/tpvU/N2UewyC9nGCA96CtDSa6lttF/hWO2ysnfNADWXx1IRgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2/TVJ8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B1FC2BD11;
	Wed,  5 Jun 2024 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717608944;
	bh=0vuPJ8mp8gpjouUMhPjdJdlQWCT5C9c3PRYpTb1N7Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2/TVJ8+tSLE+at2tyT4ef6H9ZgVKX0Ru6WHowXg7VDXzEw70RQnDx3dGLfDaSrGz
	 b8mgxnshMLEz5w7MfhdT6KxPuYWUNeXh4Yw9x0ob5hIfrHTW23Z89RIgL/oSiQUMOp
	 eQR2t/eAc3UNT/twUpmlfg/B4h9G2bx1If0EEZ9QgWrzyeoLub0X4C9itDx0AvpWb3
	 jJSBxyHz4uPsZ/KvIbuEI9M9Re4M2s/HqYLlp19l5+uy0gCe/6m5huC47cWE21+grx
	 nzQVFmAjKdVth/Di+eS0YtuSjnoX/OnYAoSfHKn8Et55kO6xiN54tQUqYx6ZVCemI2
	 CMDJvVz/b7GSw==
Date: Wed, 5 Jun 2024 18:35:40 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bnxt_en: fix atomic counter for ptp packets
Message-ID: <20240605173540.GP791188@kernel.org>
References: <20240604091939.785535-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604091939.785535-1-vadfed@meta.com>

On Tue, Jun 04, 2024 at 02:19:39AM -0700, Vadim Fedorenko wrote:
> atomic_dec_if_positive returns new value regardless if it is updated or
> not. The commit in fixes changed the behavior of the condition to one
> that differs from original code. Restore original condition to properly
> maintain atomic counter.
> 
> Fixes: 165f87691a89 ("bnxt_en: add timestamping statistics support")
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>

