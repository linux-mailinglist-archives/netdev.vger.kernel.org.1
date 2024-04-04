Return-Path: <netdev+bounces-84916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE64898A86
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6D1C278DF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AE1C696;
	Thu,  4 Apr 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns0Yfjz1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C91BC57
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242766; cv=none; b=g5fVYlrk4BDpf4VxD+CNKVse3Cv2AXJP8wPqdeuZLFtB7souMLuzwv8TcQ3bt+SgikPJVklqKJ61usMR6UkfkhVFxLdP6ZFbECbRnzj8wtqp5ABpa0345Lqe/bnetV0WxIttfVmuEAaoF8q1YnvtWztj2DeRyORiGwy+Pjlx+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242766; c=relaxed/simple;
	bh=6m5m+X7dTXXV7+ob+UnQPkHFs7tsmLskpxdcCUfdL1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVr9+D33IYgP1Vuk27oalHazJwGsJVrBfYPyABFUSa+oFW7TzLFYIaGwM42W2/Pz7KuhALx44/LXmixojmq1a9bTIkaHnPYh/lDayGKkTm5LqpDfgnkJTxzEZsYbYZQkH4Hksd7p2PASdDoSi6JqDNzQIUH+bXkHOpJwgqbrVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns0Yfjz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D45EC433F1;
	Thu,  4 Apr 2024 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242765;
	bh=6m5m+X7dTXXV7+ob+UnQPkHFs7tsmLskpxdcCUfdL1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ns0Yfjz1zD4+lwcMsdGt36EgOSbvCecc6bXHhQ1k8JgMRnjXL+9VWgxsDcuasMhuz
	 QJ7wrOGxXqo7569tniQiYJ2PibiSQcpxsq3MgUaU7RhqIIbTj3qVDsb286j10MQ/9K
	 OaB/diHRq7wdggAbCiy4Sr+XRtUiIFMH3v1RKJXSlvlsYLg8aIRF3cMfo13yFuNhON
	 IeGvfNL3P6MxfC3XEOPYRS0mXXJnCIgq4Ult3Z5+83l+MzS0CBwn5rJHjbR4wUwqqZ
	 H/UutIV/QckfJNqCReY9fy6qLtTzhSmexQooZepsXAanOuG3umXaXTBhLoEmIK/csR
	 sWzaaMUCbSFZg==
Date: Thu, 4 Apr 2024 07:59:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [net-next v1] pfcp: avoid copy warning by simplifing code
Message-ID: <20240404075924.24c4fdec@kernel.org>
In-Reply-To: <Zg6yMB/3w4EBQVDm@mev-dev>
References: <20240404135721.647474-1-michal.swiatkowski@linux.intel.com>
	<Zg6yMB/3w4EBQVDm@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 15:59:12 +0200 Michal Swiatkowski wrote:
> Ehh, sorry, misstype in netdev ccing
> CC: netdev@vger.kernel.org

You gotta resend, feel free to do so right away, just keep Arnd's ack.

