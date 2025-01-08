Return-Path: <netdev+bounces-156110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015CA04FC8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3DF160533
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633986AE3;
	Wed,  8 Jan 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/o+ZEPw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237A53365
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300384; cv=none; b=D3hvqoYrPxZfd4JwgvP3gnfZVz3kHEUGiSr9KF/DMyju659nkgqOQlBHnJW8amx08/QRfGWEogfW1mg5OoG16Kq780uLrsvM2AyhQmR67cSE15UCQbrhTPAmZ0azb8XJY3IdZ8eOK9nrY6YT0jr4PQEq5spZoJwKROREZZAa9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300384; c=relaxed/simple;
	bh=TucBxwC6uHYd7Pz9ksRUzLV80b/CPpa3MAsZOTO/h8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggpvQV091EI/NQCEBiPiFiNQ3gqjKxlzJBsq+crrS0+846X2UyTtTtUjV17byZ41EkNJolLA/zIwoEUjjiUrqD7tn7OMSTIcwHke6LVQ8gDoWPPSiRCZQRl+AJiL8VXkAx6Kwte7s3Qn2+cEwOYmzgswPGQMThR7t6T+NB+4CnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/o+ZEPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38000C4CED6;
	Wed,  8 Jan 2025 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300384;
	bh=TucBxwC6uHYd7Pz9ksRUzLV80b/CPpa3MAsZOTO/h8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E/o+ZEPwxQPVoPI4Zyt0b2nKMZLi4INaI3e5aCliZn8AsvfGMlOgqRfRO7IDeiw3e
	 tYHrlnGIg2r2zq0lNvf60UynSfCtJd+zMyuB6BEW56O5mBUqo4AMjEPW+fvdm/hXNB
	 WFC3+4PwS3PpEvi8OHTJTiDQiF5vqj45f4uMwd+4/ws6AOj0ns6w8yvTr/gTgSUgPr
	 t6nzDfY16dTW91nGr8REgEG7980OOQxH7dg4NyXz7inIei81Ii3Tgj5aW52l8bmeTr
	 DBpw10HjEkwaITn9M9GpAD/54/INPCY6oTxjzhHO3ePI3+7AFYHK+H4dngGnfcvyEY
	 KhTNB24vI4tVw==
Date: Tue, 7 Jan 2025 17:39:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH][Resend][net-next] net: ethtool: Use hwprov under
 rcu_read_lock
Message-ID: <20250107173943.223f62f9@kernel.org>
In-Reply-To: <20250105084052.20694-1-lirongqing@baidu.com>
References: <20250105084052.20694-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jan 2025 16:40:52 +0800 Li RongQing wrote:
> hwprov should be protected by rcu_read_lock to prevent possible UAF
> 
> Fixes: 4c61d809cf60 ("net: ethtool: Fix suspicious rcu_dereference usage")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

In the future please make sure you CC the appropriate authors and
maintainers. Always use get_maintainer.pl on the generated patch file.

