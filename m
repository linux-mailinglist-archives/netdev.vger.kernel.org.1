Return-Path: <netdev+bounces-189723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC5AB3596
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655DA3AA615
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98827BF7C;
	Mon, 12 May 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y11xouni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AC27B515
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047832; cv=none; b=nDq5WPlsPprJwYQ3nvgvx5St3dFLmN05/5c0DrTMQswoKx+gL+ctDwivtF9RPG8gCdxMExkyRmItzBVXRLQixqKwUrEQAKV3yhrHAGqJ2/sVJt7IwP2tsa8FKIxU4rtHouaGufdvTcKYM5X5KKI+5U4I7AY/DYOroqtbrNQwHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047832; c=relaxed/simple;
	bh=h8h58x/wKNXUAXcsKndUxqxjJOiTVBUIWC75dYW2C5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxOeczP9RnNSh9jELskorqF+m87eQzVS3UxZ/FwsCwokq4yXUCJiEmSgl2PQWrMyt9r9bxVymQYPPWBItbXiiATh1BcNVmhizpEbyY3zh1agbDCV0xQKWgUJl8byQr6pta1zdqkxb5Z7kTgrPpFKWZyS27Jkli4FNEIXqGoO56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y11xouni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD4BC4CEE7;
	Mon, 12 May 2025 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047832;
	bh=h8h58x/wKNXUAXcsKndUxqxjJOiTVBUIWC75dYW2C5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y11xounisc+5m3j+moIyQbQVpyX+VBg11PWSSl6E6p/ugqIZn02f/eIV6vY567Oh+
	 JI1K+31+80FwfK/FpumTuILV0Mq0FHO5AYxKdTu9FU6F51bQ3nDi7+63dwmf7/un0V
	 cYgGIGFlr5SiaLWkNEhUQ7gsxa+MCYjFhpzn9AlYoltuyeXkEUYM8RxsY05XPVs7cD
	 BxqTgwhXzNFtihuiy4p3Tx4GJFUxfPXVvyiYIqJNiwHnwq4NTL0IGbbojIID2YlwuP
	 vYksdyKfZtDD6Vx4OW1jVtclN2NrSoRlcI1H8aYohYAPy6+3Qlnk/aUKzvd3w3gDFh
	 uJDzAnXyL8loQ==
Date: Mon, 12 May 2025 12:03:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next] net: txgbe: Fix pending interrupt
Message-ID: <20250512110348.GZ3339421@horms.kernel.org>
References: <F4F708403CE7090B+20250512100652.139510-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4F708403CE7090B+20250512100652.139510-1-jiawenwu@trustnetic.com>

On Mon, May 12, 2025 at 06:06:52PM +0800, Jiawen Wu wrote:
> For unknown reasons, sometimes the value of MISC interrupt is 0 in the
> IRQ handle function. In this case, wx_intr_enable() is also should be
> invoked to clear the interrupt. Otherwise, the next interrupt would
> never be reported.
> 
> Fixes: a9843689e2de ("net: txgbe: add sriov function support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>

