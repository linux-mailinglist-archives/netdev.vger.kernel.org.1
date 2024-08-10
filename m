Return-Path: <netdev+bounces-117355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEB94DAD3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43E11C209A2
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208113B5A5;
	Sat, 10 Aug 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPznT2qy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56C1CD37
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266343; cv=none; b=KpTagZkG1NfI8X/B4ZQgH3cwCzWgPO2W0LIs4WSlkEMOKsseuvOPG3w6jw4Qyvx9WjygFKzwaidJIFUFhd6ih8EGUECiSsQoAE+vYI+CvU7SDcL0ueasEojBNxtAkMHeMPoEoK8LRs5VNT+URxzIZmrB5yHU0jIFLb5TX1cSBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266343; c=relaxed/simple;
	bh=2xTTaTKh9K7GKu6XtcXqyT+YpJiwOOhad25GC3T36Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgj/afCAoYUA04mZZ8Xf/s55wdfM2qMq+e8WQ6RUBDAKG5QMXUQ9WdeVxgSc5MgGtL9kN+yHYodqGnNRt7oYIrZioYgR0TVYwerkpKHXvl3YHrWHK3n+I2/M9umyDotQdYdLYbNRTctTQ8geSA1/2obZV6Vo1TugFJ9V/tAnZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPznT2qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AE8C32781;
	Sat, 10 Aug 2024 05:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723266342;
	bh=2xTTaTKh9K7GKu6XtcXqyT+YpJiwOOhad25GC3T36Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fPznT2qyG31yybQ0A5o6gK9GpaG1+Og/qMZesGwtKASJUPbPbK688BAmVzVlMI3/x
	 w1qGNu7lneTjvYEPS0GYOsB7OkOoWjl8VAHKUDHGkokjhv2qx26xTSeW1izJKltzM1
	 +lYiTAD+0pEvWxAYxR4JL6Lx/ZKJVA7YOmxsHBZlaFdGGVmLsfLcfTZoc7xZUcglBi
	 jWtk8P658IdgEQW+Jb42cjLxu75O35757AxSsarmVnxV4Dc9Nz7pQipZNzpzgwwlXJ
	 FxrGc7eXFTSI9v5W98J42+uwiDYbVYNJgb5vK/iITDmrVc3Lz/R9jR6TFPy5iH1wh/
	 W7KFyWfU/jcnA==
Date: Fri, 9 Aug 2024 22:05:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Ahmed Zaki <ahmed.zaki@intel.com>,
 madhu.chittim@intel.com, horms@kernel.org, hkelam@marvell.com, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, Rafal Romanowski
 <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 13/13] iavf: add support for offloading tc U32
 cls filters
Message-ID: <20240809220541.58c0257b@kernel.org>
In-Reply-To: <20240809173615.2031516-14-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
	<20240809173615.2031516-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 10:36:12 -0700 Tony Nguyen wrote:
> From: Ahmed Zaki <ahmed.zaki@intel.com>
> 
> Add support for offloading cls U32 filters. Only "skbedit queue_mapping"
> and "drop" actions are supported. Also, only "ip" and "802_3" tc
> protocols are allowed. The PF must advertise the VIRTCHNL_VF_OFFLOAD_TC_U32
> capability flag.
> 
> Since the filters will be enabled via the FD stage at the PF, a new type
> of FDIR filters is added and the existing list and state machine are used.
> 
> The new filters can be used to configure flow directors based on raw
> (binary) pattern in the rx packet.

drivers/net/ethernet/intel/iavf/iavf_main.c:4077:33: warning: incorrect type in assignment (different base types)
drivers/net/ethernet/intel/iavf/iavf_main.c:4077:33:    expected restricted __be16 [usertype] h_proto
drivers/net/ethernet/intel/iavf/iavf_main.c:4077:33:    got int
-- 
pw-bot: cr

