Return-Path: <netdev+bounces-115778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B1947C31
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2595B1F2326E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA762D057;
	Mon,  5 Aug 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcypCbh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86B44C7C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865791; cv=none; b=K7pF/TADrb9yswEOAGLXjBl4cdtnwOdlRlzknKWLXZLZZwDgp/Ke+iuXfJZMAmonqicfWLikvYzau1Itqy5pXaamgIpJOucqZV08EOC+PgsVSObVLPxEDSl/XMFWd/oqRF/nqg1YXHJXhPwOtLUboctwPi3J/YITyiK0zVVeZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865791; c=relaxed/simple;
	bh=QPoQ4fJd6e9uIgBhk+yzuw+yKMH7jJO4Kh8CWzgO0zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBr9V9KrM2YS1WhPyZS6dqxXzp/db6UvgbjriQDBGQdTvT3+kDPvSBy0iqrDoSkqkcX51G1tiySY6hh7rIZqtae1XyxmYh1rCxIoFtpZ+Nvd3VBgVVkurn64feVi9qtzbD9DoZXf9MsZI+QoUqdrphbA6RBSB3NbdCFpe+JRs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcypCbh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE3C32782;
	Mon,  5 Aug 2024 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865791;
	bh=QPoQ4fJd6e9uIgBhk+yzuw+yKMH7jJO4Kh8CWzgO0zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcypCbh6bbp9sfBiutA3AJcwdlAn8JxuZIARaVZKUadSADyqikMOlCjTcAtXI9Vbu
	 BoGyUQf3KBF9nl13ZEIOMOOjbCFEShm7b65rKUejW+RXPVsQCplwL+AnHpavfd429O
	 FTAcEIIEPr38OC2bTOoDr/Kl+s/CXOjBWAI66zdKDtKtJLzvsKZ5T9LGYMiFZiD343
	 PpWjKMNIAf33RB4EmXc5g34J8NAWDyItiE2UfjZzWQP4Xxfka16x2ekrYBmhafIKD8
	 ttNNf6Z+ISVgVzytnCgEPajRGxPKJUkeOHsSh7arYgozoXMBFBY+uWY7i0lZWEc4rH
	 ER/zv7PpRLz1Q==
Date: Mon, 5 Aug 2024 14:49:46 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmai.com
Subject: Re: [PATCH net-next] net: airoha: honor reset return value in
 airoha_hw_init()
Message-ID: <20240805134946.GA2636630@kernel.org>
References: <f49dc04a87653e0155f4fab3e3eb584785c8ad6a.1722699555.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49dc04a87653e0155f4fab3e3eb584785c8ad6a.1722699555.git.lorenzo@kernel.org>

On Sat, Aug 03, 2024 at 05:50:50PM +0200, Lorenzo Bianconi wrote:
> Take into account return value from reset_control_bulk_assert and
> reset_control_bulk_deassert routines in airoha_hw_init().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


