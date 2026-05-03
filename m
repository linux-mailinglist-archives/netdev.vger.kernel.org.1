Return-Path: <netdev+bounces-283521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKBeKHeu9mlDXgIAu9opvQ
	(envelope-from <netdev+bounces-283521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F54B4182
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B5D3001CC6
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED5245020;
	Sun,  3 May 2026 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6OjuG3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A551A681B;
	Sun,  3 May 2026 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774194; cv=none; b=iG4R5ebAtOWu8R19aKysrUrq1u8LVa/1bF4gkR4XQk0qJ/CrrBOslVZ/0vOWJfuCGahcMn89h2nVtjpkyk8t1vR11ppndovWu8drwayXnfBBrpUhKUL9wf3+k7+bErmrC753AMCuFEzMuaDTBSns40PAJ2NlELZNHqEn+UmUtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774194; c=relaxed/simple;
	bh=pKDHU/SyXZpppjvZKiIRsrZ1hCnDApBqnw6PQ8aHkEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYSYgyjlSot2V24O8Z9e9dEJ58jeZLVwqjKN4Y+SIju9/sTohHd/v/1mvEBWq1ZJqaAgu+fBOlJfcpVi5lN2WjZr7cSh33mn8PFaR67dnq3KJm4YFhY4ltrpAZmkg85FzBEomgTWdFGi4NI39P+tQsdfGYECetKB5trTNG82e8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6OjuG3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1DC19425;
	Sun,  3 May 2026 02:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774194;
	bh=pKDHU/SyXZpppjvZKiIRsrZ1hCnDApBqnw6PQ8aHkEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6OjuG3QLiU/RfKNqEKjgTSxQBynMSXWAHj4cI/fTx0gqvgV2MhaMDcJPKIDbL0iy
	 Pt/h3l3FfMHxU5HTqh5yRhkpMzP/pQV+OYmwTNjWvzX15POys0qdh2u9TWmQB6/bHG
	 I2sMkP+P2rsEB9IJ3MYh7LpdPqMRPsXV/w4f7+AYB5DUfpZ1DbY9QIlHWZaJMyGtxU
	 KFv/GcOPARXPQgalLsMDILzWf3DAEyiCqtmajP9ZnBYsS9Dp/wmujBoow/t50fA7DM
	 Xk/sktTy6nkZzbeoXtToanC/8vkXrJJug4SVofAAGryQcDjVuSXhpKzNWVnF92F2Zf
	 rEAaU9GYWxAYg==
Date: Sat, 2 May 2026 19:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
Message-ID: <20260502190952.063d3eff@kernel.org>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
	<20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A03F54B4182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 23:37:25 -0700 Jacob Keller wrote:
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")

Why are Fixes going to net-next? 

