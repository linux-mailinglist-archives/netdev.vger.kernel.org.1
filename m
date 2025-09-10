Return-Path: <netdev+bounces-221483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA310B5098D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E311C27C22
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6D442C;
	Wed, 10 Sep 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keNonDDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952831D397
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462981; cv=none; b=jPgpH5yFGe+PO1ytjO4WU+vQ7D0cJEURCzB9OV9SNbcjO+Wd6dtuW2JbVMVjBDcevlXxF1DJJya3hFD0BblH6oRnJYn+Q6KKThQAPXlm/7kj1X3q0dXeFiiYwzFwhnBvYlR48tgLSP7sJE9PzidzsdhySYR2ayrQcKmeu3+JzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462981; c=relaxed/simple;
	bh=4Pxf71KmSZN8Pfrm1g7QS0Q2Dw5QRVagC+WzJO5laNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkfJpsran9OPNB07j7UyBcs1sMTkEDX22rrjdMYJU3SYGMiAcz7WIUItYWL7QTeDJLoEYCAMMxyAS9L335jV7O7jxzbOoOq+mW8RnbmneTd4YFizva2IiY5AO0gImeDfcURRkodAWMZyuMtU+VVxD9Ac/s8IrsXvxblo3iUJe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keNonDDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9058C4CEF4;
	Wed, 10 Sep 2025 00:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462981;
	bh=4Pxf71KmSZN8Pfrm1g7QS0Q2Dw5QRVagC+WzJO5laNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=keNonDDLhoRVAO5iwqEkT0FRen9QSsleusVvEWWGwpNG906GR65B2p3I/CN1o0Ghp
	 RqenMgXXUBnH9pKJuDGj+E+U8To7pj8a+hLORINrFou65fbFg3DijB868jbfNjk3vI
	 acEO4BvDqmV3xCumZVdWa3MD8MAmoR6nWYOOf76uNx+i3YkJ7szSg6nHBz5l3oHamA
	 2Ym7uACy32c1DzqDSBU571ItTrv0tZUHbDErpDeHfexl1V4c3LSUZXTq851cEFCWfr
	 jBbSvZzoGZKkynKRjJnwyqYudD5+1wHkggySb2HvqNoHwbZna59+QgVeVDv4++xTVg
	 8IfuOIQ0dwHvg==
Date: Tue, 9 Sep 2025 17:09:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: paul@paul-moore.com, davem@davemloft.net, dsahern@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: Potential null pointer dereference in
 cipso_v4_parsetag_enum
Message-ID: <20250909170939.38ec1a33@kernel.org>
In-Reply-To: <20250908080315.174-1-chenyufeng@iie.ac.cn>
References: <20250908080315.174-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 16:03:15 +0800 Chen Yufeng wrote:
> While parsing CIPSO enumerated tags, secattr->flags is set to 
> NETLBL_SECATTR_MLS_CAT even if secattr->attr.mls.cat is NULL.
> If subsequent code attempts to access secattr->attr.mls.cat, 
> it may lead to a null pointer dereference, causing a system crash.
> 
> To address this issue, we add a check to ensure that before setting
> the NETLBL_SECATTR_MLS_CAT flag, secattr->attr.mls.cat is not NULL.
> 
> fixed code:
> ```
> if (secattr->attr.mls.cat)
>     secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> ```
> 
> This patch is similar to eead1c2ea250("netlabel: cope with NULL catmap").

Please add appropriate Fixes tags indicating the earliest commit where
issue may trigger.

