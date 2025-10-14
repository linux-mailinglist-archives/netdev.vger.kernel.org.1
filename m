Return-Path: <netdev+bounces-229217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF9BD96E0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8781E3A3B76
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017F313554;
	Tue, 14 Oct 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G167CHZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FE30594D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445893; cv=none; b=lThqE/AKA9iOaktjhSM7rBCanED3qV9kxkVwYoFmwraKIDXV7d0nua5QSbIkqDnzkTi7pVUlnBzpodRu6UBDaf2nuvmESNL/uZ98FQq1oJYRkyMYwLj0mt/ADv5uuRE7OtSKEtEsYNIbi3PMqfUFcVtqt2H7ye1LJWHT/vTicA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445893; c=relaxed/simple;
	bh=dneaycE8iKApW+fwsjcx5c8D+x9zckwhip7LcpS9qA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT8MBE2MTDgphdOCTTj0g9zPcgJx7u9E/UeyxbwuPieKaiOenv1TklQ1hCID0chJkA62bPKy1dhxJb9YmDoseRfoF0kr5xIJnWAq8O5y83O1RiiV/Xb7fDLBsxnmMtQ7TjXCYVvk2sekxcWAmJpMSTsjNWu11r9LY6XP9pPt46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G167CHZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE400C4CEE7;
	Tue, 14 Oct 2025 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760445893;
	bh=dneaycE8iKApW+fwsjcx5c8D+x9zckwhip7LcpS9qA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G167CHZPA49hlPl/LwFcZEWjqVqi43EA9dMdxhE7YTesjSvVQAX1EjVYMNz48IGDR
	 NKH5976ZU7dM+XRTiu99QzzSDDc6hakm1vmCTU5YVz1ZomfuuBpV8WFe69nrV/8w6h
	 nEc5mRk9EG9GrpiHhOAd2W2erwzbmqXCkBskuw3D6+Axwq5kXIMpPOanpO/XiYH7m6
	 0tB+vajgs8sDZ4KFS4dncw3YsHnqMl75Gn3NfpBhPnho/vD7/8NjDFfA/z4TdnTajN
	 6wkuXgm9Bkz07oFulVniD8Acff2heF5ka8t7dr6m6UuWatIKu1+N8+y27KDEDq2E51
	 oMdbqBEF9/i9A==
Date: Tue, 14 Oct 2025 13:44:49 +0100
From: Simon Horman <horms@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: fbnic: Fix page chunking logic when
 PAGE_SIZE > 4K
Message-ID: <aO5FwdsNaO_H7s8i@horms.kernel.org>
References: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
 <20251013211449.1377054-2-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013211449.1377054-2-dimitri.daskalakis1@gmail.com>

On Mon, Oct 13, 2025 at 02:14:48PM -0700, Dimitri Daskalakis wrote:
> The HW always works on a 4K page size. When the OS supports larger
> pages, we fragment them across multiple BDQ descriptors.
> We were not properly incrementing the descriptor, which resulted in us
> specifying the last chunks id/addr and then 15 zero descriptors. This
> would cause packet loss and driver crashes. This is not a fix since the
> Kconfig prevents use outside of x86.
> 
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


