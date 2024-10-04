Return-Path: <netdev+bounces-131858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2C98FBAA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E51F22995
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9617C9;
	Fri,  4 Oct 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiXv+n1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C217BA7;
	Fri,  4 Oct 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002504; cv=none; b=DjtsZ4ZKKRyrV1CGz2qqSQDl32vH25JFv9TQUrpwrnU1Ki0USt8tFi5q4+lozsKTj6CshAq9sz8emXcCrstsJ9rPQ+hzLf5/a7vo/rTB7e0fh5QYlpd/1AVIKc+ovJHWNmUAZkcv9j8SxGTtAiUSbbaQ7XwyTWB79S4SdR0i0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002504; c=relaxed/simple;
	bh=Pj7/4JkZKTEjFnWPuyqp8I9QcPbg+NwjUmF6x3+YM0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+2tlo0+koHuCHIPp+++lVAkcHm3vDZFuC760J0en0ttHDDqBvURt+RYclCX57LH14BNMXmld2hSg/bu/JmCJ45nFW496gSzPb/kHSUhUYAs+VV+4WEeSw8GXnJ6urk5TiKz4MQEjTyuwyyfXAzlLiS+w0MrHyWhwFPfJCTDJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiXv+n1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EE1C4CEC5;
	Fri,  4 Oct 2024 00:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002504;
	bh=Pj7/4JkZKTEjFnWPuyqp8I9QcPbg+NwjUmF6x3+YM0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JiXv+n1DEbkU8Z50yZLhQtEtgdr/jj7N+8a2xfWp2jaeiVZ2480PT/vvAt7hGU2j2
	 4w9UeeaXT6dJ5iPrJQGSELnAFdg3YJGt9AfGom6y0Qi4gujs/AlGIwvUSa7Z0TB027
	 a9+JsYlHhdKTNqv241tqJ9rCUrG1itLI1S3IJ+h7dREIy2jR6Jao2NA3agEzK9bZ6R
	 4TUEkWNuunTHXcSqZiyEn1sXF2nULPkeGOAKtzcEDfBupQ4IDbAG78lkzONbnsJehf
	 e3LYa3xI+/dF7V53LbRK2DFyxAslOR73C+SClsJMw5u3c9Qrv2Cibch4ae+Kk+EOOk
	 KpkFJOU7A3xCQ==
Date: Thu, 3 Oct 2024 17:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
 <diogo.ivo@siemens.com>, <andrew@lunn.ch>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
Message-ID: <20241003174142.384e51ad@kernel.org>
In-Reply-To: <20241003105940.533921-1-danishanwar@ti.com>
References: <20241003105940.533921-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 16:29:40 +0530 MD Danish Anwar wrote:
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index bba6da2e6bd8..9a33e9ed2976 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -296,6 +296,7 @@ struct prueth {
>  	bool is_switchmode_supported;
>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>  	int default_vlan;
> +	spinlock_t vtbl_lock; /* Lock for vtbl in shared memory */

This needs to be kdoc, otherwise:

drivers/net/ethernet/ti/icssg/icssg_prueth.h:301: warning: Function parameter or struct member 'vtbl_lock' not described in 'prueth'
-- 
pw-bot: cr

