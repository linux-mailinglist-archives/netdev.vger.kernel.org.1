Return-Path: <netdev+bounces-70683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0684FFD7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3281C28189A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E9D2134B;
	Fri,  9 Feb 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHVYeHAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7A6AA7
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517538; cv=none; b=jKwyd5ClKl12C+Rd9Ywp9sMEXIPmv9AJ1o5/K0LRU5Ga0wq1GugjOSJdfQi6GNlA2ht0Pm4+8sHAG2b5N2vuD+Q9Dp+2kkvKzpotN+c400GyvakdzwX0DLWmF9/j1+PtNY0WKsAFWJ+1bUjS2cfVpDaADlV2DTgs/WdlwSsJVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517538; c=relaxed/simple;
	bh=RrIJhRZog/C1vzMz6iahRpLn/+/UM2WtsXznIa+KB8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOMXcw/o0LVeDEeDoLduIPoVBUcvnmicJl4Saydg5km0Tqx68CEtctcc84YjjG18yfWhk/8qMTQGNptOWt1j8IIb60gLinNpAHR5r+4lt2p2z8Ku8jxaEqZnwMxb4PjJWKEBNx1T/aeWe24fXBEdBzWdL50x4LKIkgvbbacTdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHVYeHAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BB9C433F1;
	Fri,  9 Feb 2024 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517537;
	bh=RrIJhRZog/C1vzMz6iahRpLn/+/UM2WtsXznIa+KB8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mHVYeHAx+pkE1Qbb4TS/p6t2tytxd5maiZ+7VL0OTf8qK1HNiIwKK6NArbup942iY
	 ycxX2xcQipSaX7trOlS9oQNcxroMc3booIlzL62GVMH0jgShFPdTex1hXWQ7ep+sdl
	 zpAx0Unc0tWvQjmKlNtcPwdBXd0kQrZ1VkA8mAZ8+jfnN3pR584Q1W5t4Xuvmt/JHv
	 aht7aUJncZZ0L948bolh/ON1ACwwZfdhdTFUgiiv3uXmfHODW1HueYFf6BTVOAMC7K
	 YdxwiGoTp6DaXHA6YCpEInJiHZgiwo2yTmA/6siEi6NeKVTFgszP8VdjKhk9K+CCUR
	 ++j3LEoZpfjHA==
Date: Fri, 9 Feb 2024 14:25:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/2] vlan: use xarray iterator to implement
 /proc/net/vlan/config
Message-ID: <20240209142536.583f10a2@kernel.org>
In-Reply-To: <20240209145615.3708207-2-edumazet@google.com>
References: <20240209145615.3708207-1-edumazet@google.com>
	<20240209145615.3708207-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 14:56:14 +0000 Eric Dumazet wrote:
> Adopt net->dev_by_index as I did in commit 0e0939c0adf9
> ("net-procfs: use xarray iterator to implement /proc/net/dev")
> 
> Not only this removes quadratic behavior, it also makes sure
> an existing vlan device is always visible in the dump,
> regardless of concurrent net->dev_base_head changes.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

