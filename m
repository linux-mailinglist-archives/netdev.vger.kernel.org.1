Return-Path: <netdev+bounces-177194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F9A6E39A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3F3A29D4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAF190685;
	Mon, 24 Mar 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+BFQQeZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2E2B9BF
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844749; cv=none; b=d6OWBPtqokJtYwwLh2TBk/xN1qku6K7d7TN5PGelkwthz93ZQc/Fw/Edm+jZAC90UQqQvl7Ap+snotHIArpAYyj2SzCDM7ZAE8XEbdjPC8JnOW7YZffelPsSC3bKTcGeoBTd+NFxj2bkOLWO/T2I+s6mtmpXJoJh9ZSdNeKai7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844749; c=relaxed/simple;
	bh=FVVtU4oP6PHBXo+3gkSZ6ODZadUVutrM0XXoqJam5C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSwTDATLrTbC1Z78e58qpMdXXdSZqMS62FXpqkdZZKdZBdA7SSBA9ZzeELQcwWF/6p2Fxo+oWxEzh0uM49H+90TQ3FIoonBLmV9+ssYmgdzZnPCR9scHfAcxbIgnafKpT4H0L0h++E38d/RzpURnLBbTyRxlttggoLDHCbpDcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+BFQQeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFA9C4CEDD;
	Mon, 24 Mar 2025 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844748;
	bh=FVVtU4oP6PHBXo+3gkSZ6ODZadUVutrM0XXoqJam5C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+BFQQeZLOjjKw2kcVHFvKHY3LSGE9bKRWOfLdKLYBYF61YT+KN5nMJksFp+mcDhL
	 kOdzoouId6ITML41K9W1EAtAxGLbClzUU4mU9mVpxunoMqOByTlj/xlxyQxluXxJzY
	 0BnPXxYUQoKoRDeromvMFpeBn9Wuv9vwGPvC0HD3UPeEsLVdAwIKjmbs1ttBreCmcq
	 GubydTI+eF100TSwQktukusslP2iENDDGh8NI8arOVJ9b1rM7kS+jJiAiTlL7nM/uX
	 we8w6FAkIF8o/a11dBuqIKI7JuIvTE4AEhWFjK2JosYY7niGe+ccSnNMj5Njm9sLZ0
	 ZSbzI6gxXZHbQ==
Date: Mon, 24 Mar 2025 19:32:25 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 3/6] net: libwx: Redesign flow when
 sriov is enabled
Message-ID: <20250324193225.GO892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <D802549344E1B12D+20250324020033.36225-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D802549344E1B12D+20250324020033.36225-4-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:30AM +0800, Mengyuan Lou wrote:
> Reallocate queue and int resources when sriov is enabled.
> Redefine macro VMDQ to make it work in VT mode.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Reviewed-by: Simon Horman <horms@kernel.org>


