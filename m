Return-Path: <netdev+bounces-151287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127099EDE74
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3718167E5D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC414A627;
	Thu, 12 Dec 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCzq9tZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C07DA88
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977723; cv=none; b=RiBu0TCyia+yvckMvMyk3pXjzTk7D8tt/LAqk81Zex4midZncNK+GyPzGw13Wd7zfm1BTrRy2+07gebp2a/tC/WMAhUxF6vTs/h5T4icwMtGDRs0snLnaMKBFNwQHl6wgmNYyGLAX6n1qjvTXNz7x2dcgay6PN7C8aeAa7loZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977723; c=relaxed/simple;
	bh=0yDzkkBU5zyRc7jKfO2KTV2GfwFLne4mqvqyS0+ZMLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4rVzU/tLtn03DiSuIQPERAZoI58O9Se64eu1MOTriVJ2iSNMxZCQkAEbz7lZOwoCimQsENorCoY21xcu8G+VerJDH7csZT13OH+KigxxxsM15mBxsKhFr8i4RFwQ6dVaXmrmsrn3qwv0Pv1MCCY5GzJzZbrU1vLOaHIKBz8TuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCzq9tZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B994C4CECE;
	Thu, 12 Dec 2024 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977721;
	bh=0yDzkkBU5zyRc7jKfO2KTV2GfwFLne4mqvqyS0+ZMLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vCzq9tZ5/oxGknMZ5NsjHelgn373rDrWm39LGizIvEa6z6jrjbctsWQBRBv8MLQQi
	 6wLnj2vFoe5QfbyKrQDgIkD8mt1nMLQyfKu1T2C58VK54JPhd1rmXf3ZK/iRfX2EQ1
	 TVpZ2rLDdGcOHSsQF//SPyr0iNY78Xo9BIAMR5m+REOnH3z2idwa0i/7EuMxMkRuVG
	 G728iRWyyjOYKPGVd/S2em5EfRSqPUKZQwjaLnylwVQQWRgJbK6lIxFHfwMuLoLdQv
	 XVF5HlOr61W6R6YhNbugh1/DggdM3XwbTlKDZbZLiGruUYHHT2Ssu2n6wLAMUrhUv5
	 84FIqlyLpUfkg==
Date: Wed, 11 Dec 2024 20:28:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>
Subject: Re: [PATCH net 1/3] ionic: Fix netdev notifier unregister on
 failure
Message-ID: <20241211202840.05c0a461@kernel.org>
In-Reply-To: <564b9d98-4d64-40ab-a523-4487712430dd@intel.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
	<20241210174828.69525-2-shannon.nelson@amd.com>
	<564b9d98-4d64-40ab-a523-4487712430dd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 12:59:31 -0800 Jacob Keller wrote:
> I'm not certain about the inclusion of cleanup to drop unused code in
> the same commit as an obvious fix. 

+1, please separate the nb_work removal to a net-next commit
-- 
pw-bot: cr

