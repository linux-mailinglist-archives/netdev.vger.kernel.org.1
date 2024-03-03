Return-Path: <netdev+bounces-76863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19586F384
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 04:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4685328167C
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 03:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E529AF;
	Sun,  3 Mar 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSgspHu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF47F
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709436969; cv=none; b=NmtJ093W0wuX1eQwxmS7BGCl+evuHLi0gRVc7II8d2W474aORG7yWm4kVEBvHvdPQ7LQ4fj1J06s1+qJxad9nPHGaWPu/CxhNlU5yxex8DorKxTipiB3J7sSdRgAiQlt5Ktxb5FYEW87QZ48fmImrYVhbDwbxECFHJSvW71Hu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709436969; c=relaxed/simple;
	bh=9nT15dEXrFUdw+8R/+9BNgfXA6wdfLHgMX/tNwMM6ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUT7aueum4ZVyRpjIjkMWe+7vIEd6toJSYBfPx2AYZbFWoQ1LA5Tc1+apH1ids7KURJlwwrkqWzVznqeFUdK7FZRVWCmWcdj2SFjZqyku4c9X8U77E93TYS7du+NhWYzyZc9UyzODu6DKcsyc+vQTP/V+gyW6x49jJ8PLM+vVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSgspHu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B475C433F1;
	Sun,  3 Mar 2024 03:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709436968;
	bh=9nT15dEXrFUdw+8R/+9BNgfXA6wdfLHgMX/tNwMM6ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSgspHu0j6mL2uA+zo2w4x66IE+O6+cTYdXGgfPN5WIO2vPBIsPX7aznHDen2riQ2
	 KXrwwbKfLOwzOu++GJrsfoRBF6KmCl/vKtvWNxfGVTAL3dxOO6+mnBkE56SaDuuLam
	 h8Qc6nRob9KQq12dAy9cdCQwG3ams5T3RM9yQREm4KhRfT5CkVHaNNqOwpBtNSFqyh
	 hjsssQhhIyZzMChlE4KiVxt2Sd8oZ4Qe7ntQ+OlF3cGOCb+ZX5YMYb2DktUITTEfPk
	 CE/j/NvqZkPNK63RBXcEXUa/dr6aJhBxsmxXThrlW3ByeSoYMyf9LVyJURogKsZDVo
	 yMbRxQmg254fA==
Date: Sat, 2 Mar 2024 19:36:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group
 stats to user space
Message-ID: <20240302193607.36d7a015@kernel.org>
In-Reply-To: <ce6e8ffa-c4c6-4080-a54f-7acc4371c81d@kernel.org>
References: <cover.1709217658.git.petrm@nvidia.com>
	<223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
	<148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
	<20240301092813.4cb44934@kernel.org>
	<ce6e8ffa-c4c6-4080-a54f-7acc4371c81d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 19:45:27 -0700 David Ahern wrote:
> > I need to find the courage to ask you how we can start using YNL
> > in iproute2, I really worry that we're not getting CLI tools written
> > for new families any more :(  
> 
> I need to find time to play around with the cli tool more; my attempts
> last weekend were a bit rough hunting for the right syntax.

Do you mean playing with the Python CLI? :(
The thought of packaging that did cross my mind, but I always viewed 
it as a quick PoC / development tool. Maybe you're right tho, I should
stop fighting it.

