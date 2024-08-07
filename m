Return-Path: <netdev+bounces-116516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028D94AA15
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CA1F239A0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8A061FC4;
	Wed,  7 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKooXb+T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649057CB1
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040831; cv=none; b=t8VNWN61X/2r6lmc5QgrJl22VsmJkcaUCgucU0/kVMuxvM7p0yHu/mKUU/+jWOoJ1b/0DH2ZT6A/EXtmSN1zrx3eGN8ykCa/BqUVMrm3+te2C1BtTgMWqsFSkrMS/kTMIc2EtibCvEhrxzLWA520+T4Pvo2nnDf4iV9PoW/WnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040831; c=relaxed/simple;
	bh=xw1kJizDT2lrJ5gcxhvayJ1sfmmm76z8c2OGO+GxpUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8kdyYcB9IL6nIrBKMqAPCe6VNdZ+IiGwxKAIZqlg2a09BLfzNYERJ29tdeaAbUQ8Z+2Qld5Z8NW/+GnYGEhCpIqAB/qZpyMfHQtzBZQOsRAT6Z6W2rBhmEB9W9G/jOMpwo2sYhEtPYHWrxWvXWPoF2P2PUTYxIAO+8R1J3D+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKooXb+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D212BC32781;
	Wed,  7 Aug 2024 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040831;
	bh=xw1kJizDT2lrJ5gcxhvayJ1sfmmm76z8c2OGO+GxpUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKooXb+T2ST766DazzRiD5bwhj6RJ4e30G0b+AyCSnCkSt0/DMuRYzybLHnPmUXdK
	 aQBtNp2aAnZnkZByuCad5fzapG0jI87mclxZMPgoHrl99EDccs9zgMSTrEg56DHAXI
	 2h69d4+908/zDuC9j3NvaPKmNHSR1ZGBhsbYmKZFm3/9uvexAhYC0SyZA6gtAvREJA
	 DZZHxJ9WnLq6IUIo9FXpD10/9V5h49uNbJxNoE5rhvXCAr/xUrT31H7p1s/x7+MmY1
	 CbDJv4IT6L8TF7R2SXQ3QzeV9I+gnwD7ymLPMIfv0PEdc/CDZos2sybiKkC1B52TfW
	 Say+44lxrYyWQ==
Date: Wed, 7 Aug 2024 07:27:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Liu <liuyonglong@huawei.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng
 Lin <linyunsheng@huawei.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240807072710.0e7934e1@kernel.org>
In-Reply-To: <e4b58020-4ff8-44bc-9779-54bc9e1bf593@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<e4b58020-4ff8-44bc-9779-54bc9e1bf593@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 15:03:06 +0800 Yonglong Liu wrote:
> I tested this patch, have the same crash as I reported...

Which driver, this is only gonna work if the driver hooks the netdev 
to the page pool. Which is still rare for drivers lacking community
involvement.

