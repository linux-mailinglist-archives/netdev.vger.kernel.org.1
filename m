Return-Path: <netdev+bounces-165322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2305A31A26
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF67F162411
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B21367;
	Wed, 12 Feb 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quk0iudg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6E10E0
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318876; cv=none; b=oxBg8/Rat4QqCcNuKyssP6Fc42l/9Gh08xpnlujuN998u+7zveNK3XQ2cevPZyIt0g52865T22t6QQB6dcPgZXcfbD1+duBEVOji7sqirhU0aNm9kIAbNtirzkKcynhA7n5sZrCgcW5HNDEf9ZaoJ+1OMWh5eNVL63KL/m/qotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318876; c=relaxed/simple;
	bh=kzoA+ytaf4qhjif87953YfRzvV8Bak6bywv80WnvoMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZ0i5BM+Oqa9i/kkhWstJWFx7pFZMO5q9t2goTYclIVqRq13O1GJllI9ygOM94S2zz3ha/gxRtWo66Nyg3h73ZokLHEmZDhZfILNIZt12C8/4wgj03UGywG8Ng8FnyfyqK7d06w1MVEseG6ZDKVnJdIM6g+b/ndTqSmzzQKqoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quk0iudg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380E4C4CEDD;
	Wed, 12 Feb 2025 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739318875;
	bh=kzoA+ytaf4qhjif87953YfRzvV8Bak6bywv80WnvoMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Quk0iudgqKtV3TJSTtF8Khv13IZwe/s103noy3MS0GnrLePL9/OHc13ddgt+BqD/n
	 pT+LpGwZK5bdqvvMXfOdei2QcW0IR4a1moESizWNF3YKxiQd2zE2Ychl88Y4i4AWHJ
	 O1IZMMUCQjGu3EjKXsF1F1enIzrrS0yeiWIux+qRLT0silNPf3XOdoXVcC2BMY5Av+
	 UnLd2vgBt2dQTCaDzUqH+40jLcpmtkLmw/f3GqYcLuHZXzumPaHwwz4JACn95lbpK5
	 +1ieqxZqy3M77+8prO8m/yxkrBW9wy2u74/lV04O4PGqe5TPIfgQjGy/sNpKGxOirV
	 BwfGMzDxP9uCg==
Date: Tue, 11 Feb 2025 16:07:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v6 0/4] Support PTP clock for Wangxun NICs
Message-ID: <20250211160754.5093037b@kernel.org>
In-Reply-To: <20250208031348.4368-1-jiawenwu@trustnetic.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Feb 2025 11:13:44 +0800 Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.

Going forward please make sure all files to which you're copying code
from IXGBE retain the copyright from Intel.

