Return-Path: <netdev+bounces-280123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEz8IsJ552mZ9QEAu9opvQ
	(envelope-from <netdev+bounces-280123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDD43B3DB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37BD23046059
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07D3D6CAF;
	Tue, 21 Apr 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhzsgNec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77883D6CA9;
	Tue, 21 Apr 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777307; cv=none; b=O92wUV5JR9tRxNwyZq/P8idsB0XOpA4Kxid0xoX9YbMaqizcPHHb0OpztE1a8IlGvZeuB7WOwkOqaYDk8FIj+mEy/TlfU6lpgf+owxGK72oQ4H82OIH/7jt+atkBaPL56yU4e34fVouzycOS/Z4f61BA3foNS+7nx/LYH1Tc7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777307; c=relaxed/simple;
	bh=lWOqMJEcZTbud0ra/7EwmcfJYhyxUs+uayIXcDuHxjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPG51lYiND4jH2JeKc1QrAqz/fgQOGL49EOF5SXjnf2pepwhr5fTUz7UDMwHdwPGuwHPdiNrBjGuT39y4liOoRhxLM5RAqOJQVLVaRkdqcUhUaJpYaSKVaZjdqVHPC1MLsshLfmqLtWdHcwFIPWlEyPPYlsXltzD+Ob6rYeWTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhzsgNec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F8FC2BCB7;
	Tue, 21 Apr 2026 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776777307;
	bh=lWOqMJEcZTbud0ra/7EwmcfJYhyxUs+uayIXcDuHxjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhzsgNecM4qH1GVRfXxaSwJ/Gy8Q/EeMpjpO425F85tsumPCKaIHw/hg2nKzS65VH
	 tmBB5ReHXkald1Z4H40bqCmqkFcIN3KeE8OR5NIVfTUBqCltMLHWMVECeD9FNhd3DA
	 1EUzrFWvvimRDjrhih7FntfekkKOqY9Jt0DRVwXvdXroxxFUgHrPEg79+AOQrmsyfW
	 m1GUxDahDm2pBREpeJ6+oYTDOjd9I16sxPb0RthDd+Ey5QDTi2a4gS+AU17pwulys4
	 y59wcoQ1lEk/oYaF+useH0+V2Evu3HDxLroGSh/pSseEzCK1ZMzu4w5NjlWO/Rl/Qz
	 TymWtCMsJFaKg==
Date: Tue, 21 Apr 2026 14:15:00 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin Ottens <martin.ottens@fau.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v8 2/6] net/sched: netem: fix queue limit check to
 include reordered packets
Message-ID: <20260421131500.GB651125@horms.kernel.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-3-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418032027.900913-3-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280123-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: E0EDD43B3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 08:19:40PM -0700, Stephen Hemminger wrote:
> The queue limit check in netem_enqueue() uses q->t_len which only
> counts packets in the internal tfifo. Packets placed in sch->q by
> the reorder path (__qdisc_enqueue_head) are not counted, allowing
> the total queue occupancy to exceed sch->limit under reordering.
> 
> Include sch->q.qlen in the limit check.
> 
> Fixes: f8d4bc455047 ("net/sched: netem: account for backlog updates from child qdisc")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Simon Horman <horms@kernel.org>

I acknowledge that Sashiko has provided review of this patch.

In the case of the commentary on the use of sch->q.qlen in place of q->t_len:
this is exactly the intention of this patch; to address shortcomings
in commit f8d4bc455047. Follow-up issues can be treated as such.

In the case of feedback on us of qdisc_drop_all(): if this is a problem
then it predates this patch and can be addressed separately to this
patch-set.

...

