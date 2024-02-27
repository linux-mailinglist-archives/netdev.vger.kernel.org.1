Return-Path: <netdev+bounces-75352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2018699B4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC4E293C91
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8213A890;
	Tue, 27 Feb 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMamoNIq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0C54FB1
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046043; cv=none; b=SwdWn7cVkTU89A/uMcNYZWKPVo8bSusrYCtCPyPtCoSf7NR709JdE5YdSvbpYvFULqQt95NydE24trAniWHhlme2SKvEfVYZmLqTiP8VAEbIpnfVzTFUrZ2K+f0v6JxrS4IZdlV+zJlG+QU1HRH7u9Qy7c3QcB3XvmgpT0g5frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046043; c=relaxed/simple;
	bh=ESSATTN5RBpJIcOmczuuNsJfKNsA1F0ttFhZPTp4i/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tt9lLj43DqRTpxNZcr1Z90+PLqCE+dFNNALk70a7RNTWxiTWvnQ6WkWXgLLrLnS+F/FwBFJpWJS50a9/tCi80mP53tbRt5hns0XuS/AAaVKHEv9dJi76Gb88SmiqKFpzJML78xM50WCKjtsv5lgLi4WF5AmnnShCmL5PAsV1f1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMamoNIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A7C433C7;
	Tue, 27 Feb 2024 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709046042;
	bh=ESSATTN5RBpJIcOmczuuNsJfKNsA1F0ttFhZPTp4i/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cMamoNIquaCDH+yOy3rvz466BZmUWyCto5lwPJqAa+ZeUymHeOMxP8TCRE6wvsMTa
	 623II65oi7dSirXdXGxDkeWVbAHALoIrjDV9GXzl97iF438hBVBswVjGj7TS+X9eX7
	 OrcGLBNEXp16gyKSkxwRnY99iBuI7hdn6vSWI1cv2689118wa+csC+WCzV/u+TFM2o
	 weSHwNGkpd9Yzex8CFmU1Sz9zsqZ7WLtXEtBocyCUR2WKv5zzY+bswVjg1AjOeSyvQ
	 KNerqhIRQ3l6/SHQa/Qe7Y/I7ls/Mpb4pUvnr8/7gy67Z92LjXAFgmPMUAaEYuxCP7
	 EYsczZ9qWhK2w==
Date: Tue, 27 Feb 2024 07:00:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <amritha.nambiar@intel.com>, <danielj@nvidia.com>,
 <mst@redhat.com>, <michael.chan@broadcom.com>, <sdf@google.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240227070041.3472952b@kernel.org>
In-Reply-To: <e05bed50-ef3f-466c-92e9-913b08bbc86c@intel.com>
References: <20240226211015.1244807-1-kuba@kernel.org>
	<20240226211015.1244807-2-kuba@kernel.org>
	<e05bed50-ef3f-466c-92e9-913b08bbc86c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 11:29:02 +0100 Przemek Kitszel wrote:
> > + * Device drivers are encouraged to reset the per-queue statistics when
> > + * number of queues change. This is because the primary use case for
> > + * per-queue statistics is currently to detect traffic imbalance.  
> 
> I get it, but encouraging users to reset those on queue-count-change
> seems to cover that case too. I'm fine though :P

What do you mean? Did I encourage the users somewhere?

