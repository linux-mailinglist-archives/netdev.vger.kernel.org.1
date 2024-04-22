Return-Path: <netdev+bounces-90242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8F8AD421
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D96F283261
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B69115443B;
	Mon, 22 Apr 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjzrndEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658991474D3
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811316; cv=none; b=uy4Zm1btDOU8ZjYLOqFApZ70DvuRw2ihIBwX25HFtQ71FAMRXXpVEbdfyoJ3DDVmjUxwOREB6s3xMLYhTHfg7AUEBf1Jg0cdeGGKfPAWl3izwhwkbrdmKQtNSMO0rLzla07O8rVw4hiqI0Vhxk23ySXy2hyL+Nz8dk4BGvX1lbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811316; c=relaxed/simple;
	bh=2rxG1QnlpOaiyxeJFnicQEzVMBs4YVj02Qx/6x2z7HM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0Iq75MXHwwh3LJJDiN1MfePlzrxgJ3Y4JPxoxfOC6ezoMaRX1Xh56ex77HZAiR1GKvTYUwflfCYNwgrCfPlGx+S6p6CgrSgKNxCZRox2ZUVU2xB18UZldynYC4f0htJaZQATRvSp3H2bXXxYjhf1PSrOjSgPtgLZ5YlyvPUG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjzrndEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3606C113CC;
	Mon, 22 Apr 2024 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811316;
	bh=2rxG1QnlpOaiyxeJFnicQEzVMBs4YVj02Qx/6x2z7HM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RjzrndEyXPHBoXI2EY5DXjN6AmcHUDnnjsnitXk4Le3pzplOGlLywuqAoyHPPk5kF
	 N50h6It4X5ivd8cTS90dXfiQHLBrFLK0zhLAGlq0pLl7EK2+3ZSJUoZf0ewi7HN4tc
	 rIAuQ4z9lD9/2GzyHeyChb7iGjSAPBUh8ITZO4zRxx8y6Nd9ZxgmDtBBz5lQuEvem5
	 2HofotJfrgusa68G46H6nzK+O7mdWN/krsPA1XgbsfbSaWya/agMEkIP9qeEkhB+k2
	 GsfpYrlPjJSrPqFxtPtynbWA/rdfl2YlP7fpMtQsqUX87+mCo+F/iN0vl085Xa4o41
	 jdNOmmR56fCyA==
Date: Mon, 22 Apr 2024 11:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
Message-ID: <20240422114154.1896bddf@kernel.org>
In-Reply-To: <CAHS8izOEbZ6wdw2=pPt_P1F81qQxjw83foeQ9baZk0XwYEmmpg@mail.gmail.com>
References: <20240418195159.3461151-1-shailend@google.com>
	<20240418195159.3461151-10-shailend@google.com>
	<20240418184851.5cc11647@kernel.org>
	<CAHS8izO=Vc6Kxx620_y6v-3PtRL3_UFP6zDRfgLf85SXpP0+dQ@mail.gmail.com>
	<20240419202535.5c5097fe@kernel.org>
	<CAHS8izOEbZ6wdw2=pPt_P1F81qQxjw83foeQ9baZk0XwYEmmpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 09:58:38 -0700 Mina Almasry wrote:
> OK, sounds like you would like us to keep this bit of the code as we
> have it here. Let us know if you have any other feedback. I think
> we're working through final testing/polishing/code reviewing
> internally and will be submitting something very similar to this as
> non-RFC for review, with whatever feedback we receive in the meantime.

No other notes, thanks!

