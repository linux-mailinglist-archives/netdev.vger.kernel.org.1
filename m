Return-Path: <netdev+bounces-279060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMjdASnn4GkhnQAAu9opvQ
	(envelope-from <netdev+bounces-279060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196E40EFF7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0730E30B1827
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39883CBE69;
	Thu, 16 Apr 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbUpCenv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC183CA499
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346482; cv=none; b=ck01lcavG+H7Z/n4DjP9cMawKuGFO0PFvtnBj9shelpYsr8Oco4XuuH03E2ql+CBpckbVV9H2aqdz3d8IOYcpQQr3OKtsxZflDrSEVIlgkVtyoPo7sc5038bNzA8MlYCwhvbZynBgzhdqHznTFc9OyocWnDnqWEnxoYRBdaEG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346482; c=relaxed/simple;
	bh=RcaVWaCiQP+bnoNvwFn/YKAmTXyM0Ttzw2dCBLOLGdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=conj2x8gcgCVEck8z9tKUb7eROVeN2qanR2PXBl/+o73uv4kZu7+hXDA8hSUalhk1R9cPqf4reVHVVrS++T83Rv5IzZtdiaveZzRMXqC4a4AnaDXlfMdFzRL4OOgVwwyi8+UHy6azhxNh0pXNfOfMN4CfXXUjtKRGIZ1c3+omEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbUpCenv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A118CC2BCB3;
	Thu, 16 Apr 2026 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776346482;
	bh=RcaVWaCiQP+bnoNvwFn/YKAmTXyM0Ttzw2dCBLOLGdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbUpCenvagEBkMOZY0IM6XaZkV4xD2m+j2JPFi6hQgWESjQVwOYcQA53uef+tmoL9
	 K0QfHxIq5/T6QiYXxsjwoPtI84JnF9ApbXilB+Nnye/0xxJ7vWMBAaG/6pmpPxuLY9
	 etlYZFOD70eDsnI+aZCAEgamgXoLeSdZXioL+s9t6mt1C87lJrBgkjuXProspbWYc1
	 CHkfdTN4C76qE4uI6Rodd3fEnXhKYVEg47eDMwnDZeAlneF4/qyZQB+C6Z+nT5faP1
	 Xq5Me9v8C98GXfzTg/iMsv81od9y1Tey5lc24vDRDAbVfDTEmo5n4dnMOArh9WoMcL
	 9Xc2GvBitmeEQ==
Date: Thu, 16 Apr 2026 14:34:37 +0100
From: Simon Horman <horms@kernel.org>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	ylong030@ucr.edu
Subject: Re: [PATCH net 1/1] 8021q: free cleared egress QoS mappings safely
Message-ID: <20260416133437.GB863718@horms.kernel.org>
References: <cover.1776039122.git.ylong030@ucr.edu>
 <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
 <20260415151545.GM772670@horms.kernel.org>
 <d22967f1-789d-4f53-baa8-492f64fc725a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d22967f1-789d-4f53-baa8-492f64fc725a@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279060-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,ucr.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ucr.edu:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 6196E40EFF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:35:19PM -0700, Yuan Tan wrote:
> 
> On 4/15/26 08:15, Simon Horman wrote:
> > On Mon, Apr 13, 2026 at 05:07:20PM +0800, Ren Wei wrote:
> >> From: Longxuan Yu <ylong030@ucr.edu>
> >>
> >> vlan_dev_set_egress_priority() leaves cleared egress priority mapping
> >> nodes in the hash until device teardown. Repeated set/clear cycles with
> >> distinct skb priorities therefore allocate an unbounded number of
> >> vlan_priority_tci_mapping objects and leak memory.
> >>
> >> Delete mappings when vlan_prio is cleared instead of keeping
> >> tombstones. The TX fast path and reporting paths walk the lists without
> >> RTNL, so convert the egress mapping lists to RCU-protected pointers and
> >> defer freeing removed nodes until after a grace period.
> >>
> >> Cc: stable@kernel.org
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> >> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> >> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> >> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
> >> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >> ---
> >>  include/linux/if_vlan.h  | 23 +++++++++++--------
> >>  net/8021q/vlan_dev.c     | 48 +++++++++++++++++++++++-----------------
> >>  net/8021q/vlan_netlink.c |  9 +++-----
> >>  net/8021q/vlanproc.c     | 12 ++++++----
> >>  4 files changed, 53 insertions(+), 39 deletions(-)
> > There is a lot of change here. And I'd suggest splitting the patch up into
> > (at least) two patches:
> >
> > 1. Convert mappings to use RCU
> > 2. Fix bug
> >
> > As is, the bug fix itself is difficult to isolate amongst the other changes.
> >
> > Also, AI generated review suggests that this bug was introduced by commit
> > b020cb488586 ("[VLAN]: Keep track of number of QoS mappings"). If so,
> > it would be appropriate to use that commit in the Fixes tag.
> >
> Thank you very much for your review and suggestions. We will try to
> revise it in this direction.
> May I ask whether we should include your “Suggested-by” tag in the patch?

I don't think you should include a Suggested-by tag.

My reasoning is that I'm only providing feedback and possible enhancements
to your approach.  While I think Suggested-by would be appropriate if I'd
suggested creating this patch in the first place.

