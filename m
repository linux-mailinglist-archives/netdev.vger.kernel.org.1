Return-Path: <netdev+bounces-190732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A9AB888E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B291189ECF3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676C143895;
	Thu, 15 May 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blNXYurc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C461FCE;
	Thu, 15 May 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317288; cv=none; b=IdSHSa7nVB46mZWugUtwq10IdpfA0YpTkeL05dymh7IrOlptPkcacuL/09LOD10As/koG4mGJPBAbJV/ifhAWXNeBiV5YyDOobwttO0ZlJeONhpvtXW3CTTrjxfaPzzzR+DXvRnUqpYrRIshuz1R5gcFzcY+WRl3IoW6k8O+97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317288; c=relaxed/simple;
	bh=DwYIY8Z+5lq41YhvHpTSD/sEClinlMmnggDNbzx1XNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvXPoVgkDYkZV27YyMO6E7BgtrCmlu/qptoBU7lo6bTPuUH9MMSGPrUsRWKV32jZaoMgAFNohFcAX0pHdVyUt2qcDesgl0ygHKGgH4c9+szFo5j8c/+MjRgq/+5IEyQntgd62Sj9KvpfyAVBxtBPu06lMJwDhlbs3ApGn+i4xKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blNXYurc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D329FC4CEE7;
	Thu, 15 May 2025 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317286;
	bh=DwYIY8Z+5lq41YhvHpTSD/sEClinlMmnggDNbzx1XNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blNXYurckmoVa7fjtLKqzP4GpQD3MnKv0TLSmG9kBhBdQqoC53jG4Q0O+3Q2osPDX
	 Tu4laPQ7r+qqdNxuWL7x6aGzcu4y1kYhnP2U6/xnx6THfxHuHt9n0LBTbo5/jk6mVS
	 w0/rE5i9QwH9kqesD52Yj+a7Wt/uvGsk+Vk+KC4subwNbe61+bvAaNV7Ab2oQzP5ud
	 4jCDeMisWKSC/ysuZxvk1vGDPQgoaarwK368FryFDMyIrL0PaZS8vXOKfP/5BLinCf
	 fCem7KE6BKs498nZlrVBHD7aXZxHWG+g+qrE9bUU508/+icqY7VIheV4nFh+nHJHYM
	 JZiu2mwtPFh2A==
Date: Thu, 15 May 2025 06:54:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, Guolin Yang <guolin.yang@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ronghua
 Zhang <ronghua@vmware.com>, Bhavesh Davda <bhavesh@vmware.com>, Shreyas
 Bhatewara <sbhatewara@vmware.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] vmxnet3: update MTU after device quiesce
Message-ID: <20250515065444.60df21c0@kernel.org>
In-Reply-To: <20250513210243.1828-1-ronak.doshi@broadcom.com>
References: <20250513210243.1828-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 21:02:40 +0000 Ronak Doshi wrote:
> @@ -3619,6 +3617,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
>  	if (netif_running(netdev)) {
>  		vmxnet3_quiesce_dev(adapter);
>  		vmxnet3_reset_dev(adapter);
> +		WRITE_ONCE(netdev->mtu, new_mtu);
>  
>  		/* we need to re-create the rx queue based on the new mtu */
>  		vmxnet3_rq_destroy_all(adapter);

Maybe a nit pick but wouldn't it make the most sense to place the write
after all teardown related code? So after vmxnet3_rq_destroy_all() ?

