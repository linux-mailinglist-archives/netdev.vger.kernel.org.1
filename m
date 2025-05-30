Return-Path: <netdev+bounces-194410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8EEAC9574
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531C7501133
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851A253B67;
	Fri, 30 May 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmX9XATJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475D320B
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628305; cv=none; b=oZaWXTYpAMGp5tSqfYo84jwJWuCEr0kX8Z5bifD/cGmnFtK+ZnOXYkSVC82+LldjXK8SGHogHZcSLZ1qTSLmauLd7BxL0fAH634BlAcjaoE671/I2/HgoYCDRwihtR+KX2S4mdKzqrdRmT0WIa88HdHpQ2RM/SJ7hYlkQpz3fi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628305; c=relaxed/simple;
	bh=tQpBvjWo6fQcYB1zRJnFf6X7KFUMIqebgPWBvhFMjyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3oXyHJ3F9GSqmBC6Blij68VmU2qhts5e4ZqmrQoKMh0TEyyxKo6zhB/5bOSh/6+uMbYJHftU6GxWaEOkU8yYiYqSEowpN4t7NqvHf8nEpyqe6jIUGnra3hqaf4bozZujNfxndsPPcysP+rg+OlJQZjRjWJgoMXHm2SyxbAD5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmX9XATJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA28C4CEE9;
	Fri, 30 May 2025 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748628305;
	bh=tQpBvjWo6fQcYB1zRJnFf6X7KFUMIqebgPWBvhFMjyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmX9XATJYAPtUmZolpbebzc0KHk9SdL+M4W9kGFcTtD12VCQ/gvikG8/VatI5NE9q
	 o5Keb/Aishab28SR3sLWw5khn8V8U+kU2uIBOIOBkwxrj49JmZ/YexpFLKVmk2keeo
	 dYX//hLxHMedFMuXgBD89kePPhteHByakHJnT7LfrYUt+R63j6XHvHpxWLsEhgIROL
	 YWHrbzjgSqvkBoaZgEUussLpEvwB2hubu273inRnshRulvi/+K9/NLVTJfKqWAYlF6
	 rT74e9a/Wvy8t2yWPlrOzS35jtYXcPWglYRjmX28Gpbi61t5A76Ty9F/EUb+J0fMH3
	 1S5yKab1HqdZQ==
Date: Fri, 30 May 2025 19:05:01 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: airoha: Initialize PPE UPDMEM source-mac
 table
Message-ID: <20250530180501.GQ1484967@horms.kernel.org>
References: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
 <20250529-airoha-flowtable-ipv6-fix-v1-1-7c7e53ae0854@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-airoha-flowtable-ipv6-fix-v1-1-7c7e53ae0854@kernel.org>

On Thu, May 29, 2025 at 05:52:37PM +0200, Lorenzo Bianconi wrote:
> UPDMEM source-mac table is a key-value map used to store devices mac
> addresses according to the port identifier. UPDMEM source mac table is
> used during IPv6 traffic hw acceleration since PPE entries, for space
> constraints, do not contain the full source mac address but just the
> identifier in the UPDMEM source-mac table.

Hi Lorenzo,

I think it would be nice to also mention a bit more clearly what (broken)
behaviour this fixes. Likewise for patch 2/2.

> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

