Return-Path: <netdev+bounces-217705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40AFB399D5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF227C54A8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101D30DD1F;
	Thu, 28 Aug 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQaiFOMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01230BBA8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376750; cv=none; b=qgLnA7RSdEdsrQcf+usVdo/9fu+cyBqAg42R2OANFOo+QLNmja4WQAI+7cZcq9pvyYOZ2suppNlycCAlny1Kko/gNa5/lJYZCX1EgCkQ31SQu+8LpdB7nzh6w/IpcYRcCrAwSIZIK9IBIZrkKc/xdDU512Iu8QUyWoCW9yssSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376750; c=relaxed/simple;
	bh=TezVAca9D75GQUJTeshGDV5IkoW8vWHsZuPhC4L7/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf+58QcADQzpr6juDJp9wo7YmZGqXUByAykqiKb18VyGALHPAWoSYs9YOhurXEmTJpVKsq0yMkr3137+6hXdWmy/gSVPYmfD06CApViKqIS3Z5xa3ReaLF1V9QAHw1ZSv+jjI916ydhPS1G8mmdyh0Z4F4ZiEp2y06w6Jscxxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQaiFOMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7424DC4CEEB;
	Thu, 28 Aug 2025 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756376749;
	bh=TezVAca9D75GQUJTeshGDV5IkoW8vWHsZuPhC4L7/vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQaiFOMZgzulH5Sl/soyIoRD0b14J/43nUcybg8vjpDcqheebeReikN7wG6HCUNFC
	 G+95SbbwSel74/rpRm+1UhryUhUp1HwtS68y8HVTciUulwYSIzLuMHrP5iL0FMjg4z
	 D//pMXfSUInZYICN/F6sbsMRxkbhrPcHGMkaN8V6dkOwmEgZ/HLtgCk0YI7+xBg1dL
	 efIwQmJa9Qo5JZlVzlfUqtjfF+jK8HZ/EeKXoO57rCH15qUbxpMsWWedLCZAL/4o8k
	 DLddu9a3pfBgPLkIBfNVahiohzkVLyM1LId2yXc0Vr4q0ugCWU0SMYK41o0la122/s
	 yy/wV4DBsS/yg==
Date: Thu, 28 Aug 2025 11:25:46 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 2/4] fbnic: Pass fbnic_dev instead of netdev to
 __fbnic_set/clear_rx_mode
Message-ID: <20250828102546.GW10519@horms.kernel.org>
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <175623749436.2246365.6068665520216196789.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175623749436.2246365.6068665520216196789.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Aug 26, 2025 at 12:44:54PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> To make the __fbnic_set_rx_mode and __fbnic_clear_rx_mode calls usable by
> more points in the code we can make to that they expect a fbnic_dev pointer
> instead of a netdev pointer.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


