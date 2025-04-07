Return-Path: <netdev+bounces-179617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E30A7DD7F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE641893763
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C012459E0;
	Mon,  7 Apr 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGgTa9O0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5423BD16
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028151; cv=none; b=c09FpSWYfS5kdeI/dmc+HyuSDrw87QbSb0lyPriVjyJxYiBVJ3P0o0Vx+05jwY7ppL8BSdjxBRfL4XpahMoO8QMzolQ2eY19ldF3YOlV7BlnXEMy4LfWGSq98CbDJ7p6bItIpLyI4LBToQVBp7caghSRUpwXlm1cknKSv3cY/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028151; c=relaxed/simple;
	bh=ReskKg86f/zWZ6AsD9tDVlImuCGdo47XxhMRr68hdGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n088HnFVXEHbVGk102MsApkuUf/BYRohe0omWb3K1DcyaDuI3kGoeOXYzGuSFp3TdsqTKewnoa0SE4nN6kaNei1Qx7HLjph5XQ2UHLer4mbjV4Phm7EZInGXYeFDWiTkB579/t9qynmO9gG4FuJ9pEWoXmSqQivLgIlEsgiVRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGgTa9O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D79C4CEE9;
	Mon,  7 Apr 2025 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028151;
	bh=ReskKg86f/zWZ6AsD9tDVlImuCGdo47XxhMRr68hdGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGgTa9O0W9W2X7GHwioo0Xb1yQQ5ivNLlclMq7hho3m4Hz0H+PRWJ/ZoPwMVE3GcE
	 Bp06Bx8Qp5wt6ld5ooDrB1yKJ7BMR8bejNDKmZvteIqCSlYtD+NuEqIyRrVQnlgh5K
	 G8t4RuEdFXEu7h9sEx/86Ufa/CXkIWz/tZz/ttAAufEhk1kkWqzLSqy5f5GbYVOXa2
	 p8q25/RSDCWA+0cSNN9u6UT0rzhrqZrKco0pgVJv0GEFmw9aa0sQKSQUSFd4riEGpm
	 2YbtuUssqBTcsvg4Z/hn6WlSl4vozlvPr8fXn1Ex7mwiTYP3lO+fcr6rxTpSiwyBie
	 S8ZYZlKQpMxOg==
Date: Mon, 7 Apr 2025 13:15:48 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 04/11] sch_qfq: make qfq_qlen_notify() idempotent
Message-ID: <20250407121548.GG395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211033.166059-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211033.166059-5-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:10:26PM -0700, Cong Wang wrote:
> qfq_qlen_notify() always deletes its class from its active list
> with list_del_init() _and_ calls qfq_deactivate_agg() when the whole list
> becomes empty.
> 
> To make it idempotent, just skip everything when it is not in the active
> list.
> 
> Also change other list_del()'s to list_del_init() just to be extra safe.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


