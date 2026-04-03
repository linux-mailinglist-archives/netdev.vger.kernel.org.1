Return-Path: <netdev+bounces-275028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EV2Kfe2z2l1zgYAu9opvQ
	(envelope-from <netdev+bounces-275028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E0394358
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E756303B442
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0352389114;
	Fri,  3 Apr 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbgrrhNP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9963624CB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220097; cv=none; b=Hw9grYlcKCCNWUJtULysLf5TZZJQssLT1yH7fstF6xIRwlzMAs3BkX4n1B+TYXPDym9Iw77WZoSI5ben+OaQMBD7QCNAQ4EcmcdxEWHfnDiSo5Rc30iwxhET5O47WmzRPoE4MQRhGqmfzKaEWQgw+Qhfdzx06gDsEc9jdO5yAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220097; c=relaxed/simple;
	bh=z8NrtHzt34fo5KWYtZktd8j1ets5GtZS/kxrf+Fhp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN++RZdl176Vq+RmyN2keyxOqMXXNRWoTuIOEw5v0oN/NBQTx5tQwA67Rp0V6Y/Ug7/HeIY0UysJ2LKn3R2H95binvBk31RjnDXGqRrKzp1r+WRije84O0lnQcJ5IAZ+PzT+e7uma/T8EzTQAX1CcpYy6wBHhOd/sUwwUaDsU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbgrrhNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571DC4CEF7;
	Fri,  3 Apr 2026 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775220097;
	bh=z8NrtHzt34fo5KWYtZktd8j1ets5GtZS/kxrf+Fhp5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbgrrhNP88JauZDGnFRmvL0Tyl9EH9aDuxtxGwkP2c27zutg9k95vwgi+UqBYlU+T
	 0EWA/e2I3o6BD9Zjtqel5L417KMLBoDq2Qdldd4pXthUu7B14D1Tzzgb6pzQS6Mak0
	 E/NKXwyztGGzdtnLBHctLbKhGSlKtLBvTuoAcFFqRo1D9OerHEkGr0ltrN4DM8Wy4d
	 3yCBPiTdh+PttysA8khDho+JOcfPHOKiukP0JlMaV36vvfJz5izt+LQ+KlVDbQM5yx
	 MLjUjKDrVNAAg2X/652SDz13DxabyrpYf36tl4PKsjPW1V7BFR31S78WYc8EQYR5FQ
	 59XTwBfAt7RAg==
Date: Fri, 3 Apr 2026 13:41:33 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH iwl-next] ice: call netif_keep_dst() once when entering
 switchdev mode
Message-ID: <20260403124133.GA94926@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260327072236.129802-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: EB1E0394358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:22:36AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> netif_keep_dst() only needs to be called once for the uplink VSI, not
> once for each port representor.  Move it from ice_eswitch_setup_repr()
> to ice_eswitch_enable_switchdev().
> 
> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")

This problem seems to predate the cited commit.

> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

