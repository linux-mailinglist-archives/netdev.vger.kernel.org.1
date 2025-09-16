Return-Path: <netdev+bounces-223326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19775B58B94
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94A63AB86E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78C221265;
	Tue, 16 Sep 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgwZPaoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A951A295
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987816; cv=none; b=tuwlbLzs/zjvyyno6eh0mY5dP80bgLGNyE8xgTOhacfXW+JRUVJB+yYf++nJc5xUwmrKIen64sU4hk9H2sdFnYN+Nip35wEoHUPlXNYv2s+aLypOA/f2QEZhh7XwcDEaekOpLoHYjYA5J1+NsFAw5htWmBCpIn9H507ZP0QckAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987816; c=relaxed/simple;
	bh=VFyNjh5pRSJKK8xGtVTv7B7ae5WwYNdlThQjBdV4TrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHCR9/wUzHIEZYiEwWNz/PYwbdoR+KLjxXI5zlmOIwNqEXELgepIK1SIVyl7mhZRXwTgJ5D8KEA/v7vO/Z30vun9cOYUYE7VkmFdMv5TV0iDIZGqegr15yz1iozzuOhrC+UaedAnzDaRUF9O6zgH4AczRWpVeqxKN/PY+cwBokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgwZPaoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F5C4CEF1;
	Tue, 16 Sep 2025 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757987816;
	bh=VFyNjh5pRSJKK8xGtVTv7B7ae5WwYNdlThQjBdV4TrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rgwZPaoqJqQPhBt/6hEZQ+I882YuzQqS8e0fYC+xzYwc9OGHxvA7o4jaogtLZdzWn
	 WLQD1FYWnsTZ9LiBPq+8CB8MAWS4nc3k0Q/CA1Eu+KnsF8E3bDsU7P2fV/+4tYspzu
	 k9Q0Y9CnztW3/fRJDl0Thm7nE6r9HJyM+eH6VeFX+X4msR76KnrxnntfnC5vl37GEy
	 5bTVICi3YZqwQ9M7RVXtNWnwtcacFpVvRT8fm4Hyx0KK0FiIDZraGBi3nKGrOPO5pb
	 XZ3KgYTS5DvimOEswH7SScylyBOoFEQqS0k//1p7VwcCRdYLOMGQo959UnLDM0Kv0s
	 4taiXukEJBQUQ==
Date: Mon, 15 Sep 2025 18:56:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 8/9] eth: fbnic: report FW uptime in health
 diagnose
Message-ID: <20250915185654.26097169@kernel.org>
In-Reply-To: <1f99551f-5037-4670-9c2d-a4ce4d5c017e@trager.us>
References: <20250915155312.1083292-1-kuba@kernel.org>
	<20250915155312.1083292-9-kuba@kernel.org>
	<1f99551f-5037-4670-9c2d-a4ce4d5c017e@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 18:35:40 -0700 Lee Trager wrote:
> >   Statistics
> >   ----------
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> > index 0e8920685da6..f3f3585c0aac 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> > @@ -487,6 +487,18 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
> >   	return err;
> >   }
> >   
> > +static int
> > +fbnic_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> > +			   struct devlink_fmsg *fmsg,
> > +			   struct netlink_ext_ack *extack)
> > +{
> > +	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
> > +
> > +	devlink_fmsg_u32_pair_put(fmsg, "FW uptime", fbd->firmware_time);  
> 
> I originally added fbd->firmware_time as part of the implementation for 
> logging support in D51521853. The original idea was to correlate 
> firmware logs to host time. This proved to be difficult. Instead I used 
> firmware time to detect firmware crashes in D52065019. Time is to set 0 
> when fbnic_fw_log_write() is called in fbnic_devlink_fw_report() because 
> we don't know the actual time firmware crashed.

I don't see this in my series.

> fbd->firmware_time is 
> only updated with the heartbeat is received. When a crash occurs 
> fbd->firmware_time is reset once firmware comes back up. Ignoring the 
> crash case this should be something like fbd->firmware_time + (jiffies - 
> fbd->last_heartbeat_req) * 1000.

I don't understand what you're getting at, TBH.

> Another issue is your using a u32 for fbd->firmware_time which is u64. 
> Firmware returns its time by calling k_uptime_get()[1] which returns an 
> s64 as its the firmware uptime in milliseconds.

Ah, good point.

> We also don't use firmware time in its raw integer form anywhere in the 
> driver or firmware. Its very hard to read FBNIC_FW_LOG_FMT has the 
> format used in the driver which is based on what Zephyr uses[2].
> 
> IMO this doesn't really have a use case and I would just drop it.

Knowing FW uptime is very useful in multi-host systems.
NIC get into bad state and digging up when the last NIC power cycle
happened from orchestration datasets is a PITA.

