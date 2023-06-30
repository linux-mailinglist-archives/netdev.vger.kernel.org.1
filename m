Return-Path: <netdev+bounces-14803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E96743EED
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A5E280F8F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1B16421;
	Fri, 30 Jun 2023 15:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0616415
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE9C433C8;
	Fri, 30 Jun 2023 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688139130;
	bh=AaZqyPu4KBOIBEEtN7KU734n/yfJRfTaIKV/pcXHMI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWkZU+NBE41XcbwVwdV3ZqQxJF1C0sDONYK/q0gkBc2mYZ86dnEMCJBYRdvBdpWTZ
	 /IY5xBnjRyatC/zVUooQpVgyk7rbJQEVukFcqEA1+oASVvNBHy/MD6DUIZTXecQ1Yd
	 2g8o6ut49TDe7nn/YdRRCI/MmHfzkXmInTyR4NgJN2iCxVndPhu/r8S4GLlHbwVHpb
	 e6NO4AtYUZieIYMr8HkhTlKgsy46tjaXaj+ao2NVUlSGmap+5Cg7013PKXqkAqtEPh
	 mIrpyy5ryVJSChhFFvAfjyjieKw4WFoJnIV3Zh/JMMvRcn0QNO4+Ez96FeHpynWYlL
	 GucCEsuGsWLMQ==
Date: Fri, 30 Jun 2023 08:32:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: Destroy previously created kthreads after
 failing to set napi threaded mode
Message-ID: <20230630083209.05efaeaf@kernel.org>
In-Reply-To: <20230630054353.28934-1-qiang.zhang1211@gmail.com>
References: <20230630054353.28934-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 13:43:53 +0800 Zqiang wrote:
> When setting 1 to enable napi threaded mode, will traverse dev->napi_list
> and create kthread for napi->thread, if creation fails, the dev->threaded
> will be set to false and we will clear NAPI_STATE_THREADED bit for all
> napi->state in dev->napi_list, even if some napi that has successfully
> created the kthread before. as a result, for successfully created napi
> kthread, they will never be used.
> 
> This commit therefore destroy previously created napi->thread if setting
> napi threaded mode fails.

Please don't send two patches in less than 24h, unless someone asks you
to on the list. A lot of people read the list from the oldest postings,
won't notice the newer one, and it will split the discussion.
-- 
pw-bot: cr

