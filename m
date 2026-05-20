Return-Path: <netdev+bounces-290124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PzhNqkzDmrj7wUAu9opvQ
	(envelope-from <netdev+bounces-290124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:20:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4659BE5E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11FAF3027344
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1403BED4A;
	Wed, 20 May 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIgwIZFt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EA3BCD25
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315621; cv=none; b=VOBmB6cAFS3xie38KhzKTlJWE7r+vnPNxLBfE0trYsMfScPQ88IqnyrCbyBtyorGZQwzqVWTjHUZy1IECoFy0uWOR5sBqYpyAwMVwJ1Tcf/Sp/8uyv7WKHB6izrG1XwYEg9CTWCeZWcwBvbJCnk94gDV5/8PWfh7CzIUlWOuAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315621; c=relaxed/simple;
	bh=qdOJ45f2Y2Xyd3ErcriORmBDXVnX360+H3rW8kRv7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns/zKRG7opsaggAt1PCdTfIef5thaLnAl4D9oFpWzqlQzKrRAy9Rp2Sv9QxTu6rTwjUtxLF51X9YqfrReT9SXSqBa5ANi0/HTtdf3dYVdpWBRZYL1248eYpAUGTDcSi9eb1GA7ObQzyqLe97nqv+wjh53uEUChlF9rtxQtyD+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIgwIZFt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8401F00A3D;
	Wed, 20 May 2026 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315619;
	bh=ywskEYz6oKrn5jDQ55pCouuLncWvkhkp/plxmXN2OYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PIgwIZFtX9gmYS+YjWYYe3s7fzC3ooKgEuv5J3Vbb3JtWMLBtT9gobIJfbIe9a0Is
	 sPJ6fp/0sgrNrbw0GUQ7OV6hqO1SOGhiBf5nB5ecwQ2kZgNsXMsgxnSpw6v4/EyOMQ
	 PNAgT09foP3ZeOuI7lJmbaD6AI/dvSEeYS9ZLS8gMGmMfuyrdRR5ZUgnLtv+KLfvh7
	 5WyEI3h+kRJF+oxWvMxSBnK7pO5/n7dyTEaMeiQwDTf7B+Yv+9sIfsMpuTAqhJ6UZD
	 58lqMD7W0V49f8a/5eglR1ULmmauIU8Kr29umzbdsb0axCe9q51g8iwDRrouCv0ypQ
	 Y0UShlJohZ8Yg==
Date: Wed, 20 May 2026 15:20:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260520152018.1098f9ed@kernel.org>
In-Reply-To: <ag1PTfcsbowK68g5@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
	<20260510082509.1530a1a3@kernel.org>
	<agCtGqWLK53TWCaS@Air.local>
	<20260510095937.598c27a6@kernel.org>
	<agrdjt6CjpJo3AYF@Air.local>
	<20260518142230.4403b3ce@kernel.org>
	<agwJNX-q0NmmrMpy@Air.local>
	<20260519162145.524da69e@kernel.org>
	<ag1PTfcsbowK68g5@Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CC4659BE5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 14:14:10 +0800 Weiming Shi wrote:
> > From looking at the repro it seems like you never add any ports?
> > I suspect that the author of this code assumed that if there are 
> > no ports there must be no traffic, so it's safe to be flipping the
> > modes. I'd rather prevent the race than make it safe. Could we defer
> > setting the real handler until after the first port is added?  
> 
> The next version will drops the release/acquire and replaces memset/memcpy 
> with per-field updates that skip transmit/receive entirely. They stay as dummies 
> throughout mode change since team_adjust_ops() already handles them based on port count.
> WRITE_ONCE/READ_ONCE for tearing, synchronize_net() before exit_op() to drain old readers.
> 
> Does that match what you had in mind, or would you prefer a different structure?

Please post it and we'll take it from there

