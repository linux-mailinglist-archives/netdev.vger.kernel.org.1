Return-Path: <netdev+bounces-160116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB2A18515
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E5B7A4E16
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A21F7903;
	Tue, 21 Jan 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP9QMz+8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667F1F6675;
	Tue, 21 Jan 2025 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483070; cv=none; b=M18R794s7gSMYXv3R5DggGLwjz7F2BBXYgBTyksKhw2obMVtTaICHSUYSXiEvyndus++7IdcndYpBLdp6WtTLjitTKzXTs0BURRr7/UC1oOWGqSLSlGQa0jheVZ1asgch45isNRuE5/t09XezLCLVR5S8Q1KUcdpLhY06NGZfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483070; c=relaxed/simple;
	bh=1ulxf8i+2RU1zn2kgiCf4LlbKB34o1waTb3CNoLabTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/tqFknpHiD4Mn4xwtgNWYrEMq3W2TwQT1xnvGY6Hkmo36dckvtmYNAw1UmRTPRGrrMXnCkCb9W5XnuADM1uh3Izx9yNfE3EDyTliFD8162V2n2iEIAXHRZUizauRaF4QKWhkZGpdJCieRuOZhK79Za163mEpjsf8ww6tgqUjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP9QMz+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1579C4CEDF;
	Tue, 21 Jan 2025 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737483069;
	bh=1ulxf8i+2RU1zn2kgiCf4LlbKB34o1waTb3CNoLabTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iP9QMz+8UdIfzzOPjYhtteNfLwqIvqF6v7Ha8GcDGTXCacwm+yuKJXZn++slMAO/m
	 L9XLFqG2ctThJUiwQr39gOEokOBFoNK1GDynfvhngK8rJbWqeWPN27WfzcnpnvDbi6
	 beWOEO0vFoSsH5bcuqFeE4Bj1sRX9GLWM6ZWzZPHE/6XkK1p3YxmlWghreRS0uWBI9
	 lo2sPSccF2Iw/ooPUmycn7ZU8oXnuIDd16CiARImKqUpohPemZ2kKd2I2kaFeBthBc
	 eCK4PRC8N1xex0UCUsMRtJoJF0yIwA+96ObqNFcVaFP+ozv1asvis2/fsJGH7f4AN/
	 HAP8ZZT1R9Zsw==
Date: Tue, 21 Jan 2025 10:11:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 si.yanteng@linux.dev, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
Message-ID: <20250121101107.349a565b@kernel.org>
In-Reply-To: <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
	<CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 17:29:37 +0800 Huacai Chen wrote:
> Hi, Qunqin,
> 
> The patch itself looks good to me, but something can be improved.
> 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() callback"
> 2. You lack a "." at the end of the commit message.
> 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
> to 6.12/6.13.

Please don't top post.

