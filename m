Return-Path: <netdev+bounces-205589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75612AFF593
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4618999EA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BD173;
	Thu, 10 Jul 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0Yis8ee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61C1FDD
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752106300; cv=none; b=QjttlvzfwSHEdg8cwhcjCAC3oWj+9FhMrwVdWvjHFCHoKO0ZBmYDZnAfr8HJwvP89D9H7swOomWNyAJGXPCcD4va9X+MOCbm+PC2PAxJYBpnGGUz9ezbR00CnOrc1LAQmLEwCIn47hbSX2miObxFVYpRkfNbfJ7/glIufel/CDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752106300; c=relaxed/simple;
	bh=peGkjYtU3r8S3zw+g3kQOA5/1Mk2k3FWf/hFlW948Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpMIZ9YJSQARk11jLYZs8j3c7hZ+kcGJKxxosVkGuu+OFtD9XeleFTkfc4HB3acWgEf5X9KajD919QGRm1FfTuUYRfkYk96fa8M9oetfzSQGoLWp03+vmFqsOkzWS+z0G0ikHwfzjDZCKwdCtj1c81qNkQ2GYZHdpqNrobvR2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0Yis8ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7415FC4CEEF;
	Thu, 10 Jul 2025 00:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752106299;
	bh=peGkjYtU3r8S3zw+g3kQOA5/1Mk2k3FWf/hFlW948Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0Yis8eehD534ymD/cSf6aWn21z7JogYBcpn/tmUoiIoXvZLrni34CCnUAXz8nFEy
	 qyGFyzAXkxXPVhbcpBS1RmktW6ajAJwSi4igekmg6sNP8KGsGKVVXCD+JU0S7/3Mis
	 YZ6E2k3Np/DHjO1BlE95rFtWqGMZCgxAP+ps+c2cSUyggmaTEQPpAllvIZPMeJga4r
	 GKe32OkpgzTckJ/z57b91N0VW1eLVK05fzgioO34m/vCQYGMw7xDj2DsCG37k8HiLr
	 A0RQV111lMLCwRn1lgzVMjAsGhTbLr5LSujamkWn8EC9gU+dTd4RX/fy3Y555PEtiO
	 LbVIQpJFcaIVw==
Date: Wed, 9 Jul 2025 17:11:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>, Alexander
 Duyck <alexanderduyck@fb.com>, <lee@trager.us>
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
Message-ID: <20250709171138.5da9df21@kernel.org>
In-Reply-To: <bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
References: <20250709205910.3107691-1-kuba@kernel.org>
	<bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 14:23:11 -0700 Jacob Keller wrote:
> >  		head = list_first_entry(&log->entries, typeof(*head), list);
> > -		entry = (struct fbnic_fw_log_entry *)&head->msg[head->len + 1];   
> 
> I am guessing that UBSAN gets info about the hint for the length of the
> msg, via the counted_by annotation in the structure? Then it realizes
> that this is too large. Strictly taking address of a value doesn't
> actually directly access the memory... However, you then later access
> the value via the entry variable.. Perhaps UBSAN is complaining about that?

Could be.. The splat includes the line info for the line whether entry
is computed, but maybe that's just a nicety and the detection is done
at access time..

