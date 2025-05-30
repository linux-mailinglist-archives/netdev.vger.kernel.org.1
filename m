Return-Path: <netdev+bounces-194283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20CAC859B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 02:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834EB3A5BF4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54259635;
	Fri, 30 May 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqyHFQYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D5184;
	Fri, 30 May 2025 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564203; cv=none; b=VAus7Y+X7MHqjN6hNJWShToGEUSZEe4l10jlzxLdw7ExHjcEQEy+fbOvHI80SdNqzXfd7siMK4UvldK9I3IBRvW7O01aQETyDYUcnr4N5WLttabJxfOZ6YhnAT1yGKOYl3gCC0RzxzN7sSBBnnA/r3IUpYPXHptDhNO7FRRjiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564203; c=relaxed/simple;
	bh=moLDOQjJyL3fO6Wf/7ZQqvgVhiJmnI73vJU9DS5AoYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sILEJIh4mXrvw0gnTaZmNB63oA/wNC+0+0Pp3HEG61F5uuVIKqPHkrr4hb1ZI+5vcdxbwRLVUI7nfWHvBnONBMOOvTsljL19UrAgxeB/kN/M1JfHuTZDEE8yuGo328oNt9dEgFYtfkx3c61gNhBL3s7+10FK6HNozcubUEAaFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqyHFQYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC94C4CEEB;
	Fri, 30 May 2025 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748564201;
	bh=moLDOQjJyL3fO6Wf/7ZQqvgVhiJmnI73vJU9DS5AoYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqyHFQYDTZ7+9f/9Qak7jwdvVIOTiQx52AYvic/dq3DiEK8ZvKaqWmDJa2Wd3qpM1
	 SwI/mKZOYqgJb2Qx6mZhMKa0/3+VLmvvo3+9tZAGulX4OrN7fMgm91nlqPwlfG8EqN
	 /LwwBFoAi93qp8OtEjwGzBvnVn26MBVooVyQ/8MG7b14GNSSLf9jYkuw/hoYDd4HKq
	 A8k7yobtEII9etheV72fIPR86rwlQ35EkLnR7AqDyh7HxBBDjp8t2kwMvkZuxy/6nt
	 bMc4nyUnV3lCRyL6XblIfNzIAtUIknnH1thJMeDV891N7JApiUwiUCDFn6I8s8h6cV
	 zp6Mo4GI/rSQg==
Date: Thu, 29 May 2025 17:16:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, John <john.cs.hey@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] "possible deadlock in rtnl_newlink" in Linux kernel v6.13
Message-ID: <20250529171640.54f1ecc6@kernel.org>
In-Reply-To: <aDjyua1-GYt8mNa1@LQ3V64L9R2>
References: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
	<c9b62eaa-e05e-4958-bbf5-73b1e3c46b33@intel.com>
	<aDjyua1-GYt8mNa1@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 16:50:17 -0700 Joe Damato wrote:
> @@ -1262,6 +1258,11 @@ static void e1000_remove(struct pci_dev *pdev)
>         bool disable_dev;
> 
>         e1000_down_and_stop(adapter);
> +
> +       /* Only kill reset task if adapter is not resetting */
> +       if (!test_bit(__E1000_RESETTING, &adapter->flags))
> +               cancel_work_sync(&adapter->reset_task);
> +
>         e1000_release_manageability(adapter);
> 
>         unregister_netdev(netdev);

LGTM, FWIW.
For extra points you can move it after the unregister_netdev(),
the existing code cancels the work but netdev may still be up
and kick it back in..

