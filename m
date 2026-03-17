Return-Path: <netdev+bounces-268759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMLHMULWuWnEOQIAu9opvQ
	(envelope-from <netdev+bounces-268759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:31:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFF2B31D9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3381308300F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74264315D43;
	Tue, 17 Mar 2026 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG4ZqSiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506351C8634;
	Tue, 17 Mar 2026 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786688; cv=none; b=UD9irN1l1Q29aQzhvmnQK3+gNYsasxX01+vIIpCCcOkfWZNqf1eD9KGU/lfG097A9rSpzRoJhEM/kBXsZy9xvyCHIwpAldJC6UnTe0Xl64pvD42NDA8ep3EKgt+FcVpAPbfjveDHG2RQxJnFGuQoHETIur8ayu90q2x4U7rIAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786688; c=relaxed/simple;
	bh=alcBalLr5y4FVMqOBi6v7NQyMi7Sq806u4+VmW68ZCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eneYuMMcoUsmzewfaIZ8fmeuLtXUrnKd8G1VH7IfMMhAhkQOfE6o9Dt9Fe8oThDC8+seXGHAPPbQMd/qPT1srmSLjogFK3j3svDCke/GuwpKVPAdN4iElmQimQDwtn8GH4tSKt3ApdyVVDgluVInWO7UhIffrQZBCelLajfhfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG4ZqSiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB47C19425;
	Tue, 17 Mar 2026 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773786687;
	bh=alcBalLr5y4FVMqOBi6v7NQyMi7Sq806u4+VmW68ZCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cG4ZqSiOM9SVq7bDQt+DRhyUOSi3iT0QyrwBjElpwRxtSK+6NK2bKH04T/rryOQhM
	 LrLCoQSk8rHq7NW5N/WDzgYeDB5CWTjp+cdhpx5aQ0qOVoKEhj2ynnHe9W+QKrTTbQ
	 XiMCjCX4y5wy4hvJ6JYgYsNaqIoQexJzpIVmIvsN+ckq/1HOuHjvYIP5MOL3l15XNO
	 m1x6dXCJOxnDFQMo2YYKfUeWE7+ZHf1vPRNVUgM1d6tU65KlMrtfQMJDEwtA8Q2Ejs
	 FsSFBWaPuu5SuO4Fgg713yq/0C8ij8cppB1mKUvAdi7r+qEpgDQXhAs86vp3El3odp
	 6XYgIHcEIWqbg==
Date: Tue, 17 Mar 2026 15:31:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Di Zhu <zhud@hygon.cn>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <willemb@google.com>,
 <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: Re: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260317153126.61f7d3de@kernel.org>
In-Reply-To: <20260317113433.927022-1-zhud@hygon.cn>
References: <20260317113433.927022-1-zhud@hygon.cn>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43FFF2B31D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 19:34:33 +0800 Di Zhu wrote:
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.

This is not a sufficient justification to make this a fix.
As Michael was already alluding to HW GRO usually covers fewer
protocols and is less effective than SW GRO. Normal config is
to have both enabled. Please explain if there's anything special
about virtio here, because I haven't heard of people disabling
SW GRO because HW GRO is already enabled.

I think this should continue to target net-next with no Fixes tag.

