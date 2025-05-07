Return-Path: <netdev+bounces-188651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BFAAE0A1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C43A3AC220
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46F25D20E;
	Wed,  7 May 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDx/z77y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5534156C40
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624208; cv=none; b=r2uw7syc2JabZhWpkKqBVl2OowmKk+wVQdU6H/bVETFo6gmquLbSCVMG/UB7RHShe8CTNrcVJKFEjyx74JzMHmwFTUSCSgqx8waa434zlVw25rKsfGY8DKWAq67DqIFop6nd8V9OzcyR7anGQ8/6SaqYuCTVEv8wzVZ/c2ug0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624208; c=relaxed/simple;
	bh=eqee+p918ldr3sDf7M/yWVLxIViYM8rVasG3JFqKViM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TemTghHRi2aJVB25jxCNlMhqZSasV5tHMUZ0IX+pa+yp7dtaHamQbsMUYOHbFtJXfO7Dfc+ox/2jYsQT/+3S8p5S84BeMVtUcmNcOj1YDnEFMkBJ/Ou6DlvIJaddr6outB8RSmeS327G2AchnUNLmZRMh+ryDRwXHXKMX6gH6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDx/z77y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB7EC4CEE7;
	Wed,  7 May 2025 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746624208;
	bh=eqee+p918ldr3sDf7M/yWVLxIViYM8rVasG3JFqKViM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDx/z77yHYvMwrtKpIp9XZiC+v1Ndtm4YWzQhCX0FNEqdQH1RuLLJOXaA0fL22PN3
	 7Mu2OOf1xS2bkwa6Jq/Dv02lZ9cZYcRxz41OLq4gS1LjmFminwCkW3CeBVXmRoK8Yf
	 uMP9HfZH/Shc4crlDtaPzlBXOK7rPefs4Ezulsw7ZXqkXhsXhB/ZqQG+VJMKfJOGAg
	 AzldfVvnMz2l+Ky35KlYE2PJF1BZOejBx9PupG0mqQ1xkIyPpqczcfmgU4NtHqnkkN
	 MKl5HydIh0I5P5CJU3QD3e1Sq2Q5g1a6gksgjNaqMiM1YLyb9prvV1/PqoSKXZd/rR
	 4pemO9snufp1A==
Date: Wed, 7 May 2025 06:23:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
 dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250507062321.4acdf9e6@kernel.org>
In-Reply-To: <CAMArcTUx5cK2kh2M8BirtQRG5Qt+ArwZ_a=xwi_bTHyKJ7E+og@mail.gmail.com>
References: <20250506140858.2660441-1-ap420073@gmail.com>
	<20250506195526.2ab7c15b@kernel.org>
	<CAMArcTUx5cK2kh2M8BirtQRG5Qt+ArwZ_a=xwi_bTHyKJ7E+og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 13:55:44 +0900 Taehee Yoo wrote:
> So, it acquires a socket lock only for setting binding->dev to NULL,
> right? 

Yes.

BTW one more tiny nit pick:

 		net_devmem_unbind_dmabuf(binding);
+		mutex_unlock(&priv->lock);       << unlock
 		netdev_unlock(dev);
+		netdev_put(dev, &dev_tracker);
+		mutex_lock(&priv->lock);         << re-lock

The two marked ops are unnecessary. We only have to acquire the locks
in order. Its perfectly fine to release netdev_unlock() and keep holding
the socket lock.

