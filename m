Return-Path: <netdev+bounces-28526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848577FBEC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991C61C21486
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628931641C;
	Thu, 17 Aug 2023 16:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6A1549E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6FC433C9;
	Thu, 17 Aug 2023 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692289350;
	bh=BiHl3deEBRiifvhk1+E9nkSfJCf9Bl2uVTRZ861Ta1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c9KCm0cwB3Yp3ckGxZ2XKyj5dWCLe178Td3z3NU0QNOs0A+jcj/dfvPaTldEN8xGq
	 fjYM9gpELm2wDLl3ZaxuUL36ZrVxz1vwF/thx2XfqjYOQTkqbrUQ4F+9S6bxLfVCcb
	 h2H4vVRyx+KjFgpHh5arf7hVI5udR6ivsrm/m1SPQxEW5M/KTuFMIM3sBx4ORy1Wxq
	 +naqg/v4L9A/A2Ibo6bIkKROIlGv8SK9apcYXRSMYCHI8/Bnwduy4lY7Ao1eMZI9Z8
	 hdX7m8ctXE7tHU+WNDoV2or4ISiDsiJbMK/5JUoKSQOII6o+r/xURj9YHIHrwe++YC
	 A1mbSc9jy5isA==
Date: Thu, 17 Aug 2023 09:22:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com,
 almasrymina@google.com
Subject: Re: [RFC net-next 05/13] net: page_pool: record pools per netdev
Message-ID: <20230817092229.4cea4e2a@kernel.org>
In-Reply-To: <ZN3LkR+b9Onpy1XH@vergenet.net>
References: <20230816234303.3786178-1-kuba@kernel.org>
	<20230816234303.3786178-6-kuba@kernel.org>
	<ZN3LkR+b9Onpy1XH@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 09:26:09 +0200 Simon Horman wrote:
> I'm not sure if it is possible, but if the hlist loop above iterates zero
> times then last will be uninitialised here.
> 
> Flagged by Smatch.

Hm, the caller checks if the list is empty but there may be a race
condition since we don't hold the lock, yet. Thanks for flagging!

