Return-Path: <netdev+bounces-73831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9585EBD6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B251F23633
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFED37701;
	Wed, 21 Feb 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGXnYO76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7117553;
	Wed, 21 Feb 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554677; cv=none; b=LjKP4UMSz3+8H7m1ofZjTw54fV5gUbSKmOazMxRh7oZpYsJ7kIbXyofDJPt5iizls66KEySDS5QwVGxLCt2UDBk9H5oZBvtP74fpCjMuxYaNqQxDYseEB+PTRLCqSALKpiWv+zHHQ5I2/YVE4DO1JFN1FvF8beoYx3u0OVlDomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554677; c=relaxed/simple;
	bh=4Mt9fJw7fa0dBFd5/WLBOVMdYpRBrP5VofjvRlqAkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFUV+2re1yEeLRGwfx2e7e4PTHSWknxLBwO/vMS3u1cEOCMMJhhVwjjCleKb2lMBcg8PzkircDeCw03CIUjeUIzTGqVbWJ626HwC7QoWwX+u9t4+LEXf0sFQjBlzQs34oPUiFhnUQHZcNXIngVL8+ONCmRQrbVURm+YMy7djwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGXnYO76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968B8C433C7;
	Wed, 21 Feb 2024 22:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708554676;
	bh=4Mt9fJw7fa0dBFd5/WLBOVMdYpRBrP5VofjvRlqAkU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KGXnYO76RDcpFem8nJsp/iijVHis5hc/cBpUKJERo80Qq+IekxwunJGZW7PHoyKDY
	 Hs8+oizK4a0ELie6FgSWxf4WK53DFsi5WsBnbG7diy0G+2im+Tv57vyorPwR2HyPk7
	 g9s9cL3h6D6nvg8POOCel77FfSvo0bBjXnjGviR2NVqbbPOlsrB4zi/A9C0If7J+Lj
	 hhxzXuE518LNl3HZy7iFCButJlN93vmFFNHJH616jhN4X8nFm6lEz5ETrCa0oWlCyO
	 p1vz2zGxML2hd/1qz1QJq3rmDSmgfa20JsKWU0slu0n5WtxiN6wV03Lx/XsahPtgHb
	 laDH+U5hP7c6g==
Date: Wed, 21 Feb 2024 14:31:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Thorsten Winkler
 <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/af_iucv: fix virtual vs physical address confusion
Message-ID: <20240221143115.6b04b62a@kernel.org>
In-Reply-To: <47789946-0ffe-462e-9e2e-43b03ea41fe0@linux.ibm.com>
References: <20240215080500.2616848-1-agordeev@linux.ibm.com>
	<47789946-0ffe-462e-9e2e-43b03ea41fe0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 14:36:57 +0100 Alexandra Winter wrote:
> I would have preferred to do all the translations in __iucv_* functions in iucv.c,
> but I understand that for __iucv_message_receive() this would mean significant changes. 

FWIW we're assuming this is going via the s390 tree.
Please let us know if you prefer networking to pick it up.

