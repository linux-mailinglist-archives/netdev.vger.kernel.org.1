Return-Path: <netdev+bounces-265845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD41HwF5r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:50:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F69243D10
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7A993043509
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2772E9757;
	Tue, 10 Mar 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5lxUnog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E32BE02C;
	Tue, 10 Mar 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107173; cv=none; b=WUYCV7z9DkkYeF9wMlDElHSyN+b4m3BE4ZG6WSySHJkepMNskTj2EnyW7RBdw1hb+0/8c5jhr+R56iiwEfLuGx63GaXOWRnolIXIMVDIjHKpG5dgYm5hM4NwQ9ET1Qlr+aKq2BUFg7YjrsySY1gJD7pfxcL+O/3mHMOeofwZqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107173; c=relaxed/simple;
	bh=0w3Wlgx7Fyv1ZfI9IbsITSNPK9IC53a4vpVUlZH8tRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQEbpvrk2wUYQrcFEDWRyYR5397QA7l9mlVLt8G0sw61DEk6cFqsCF60ojVyx0OCbYsEd7NhAoPRx5y203GnS/QvqJUrXewJZovnOLDt6KbC4g4HnIlCMN1jGteuzzkyKN1V2vO1OOr5oKq8j9GjC06AJljGDz8j6Iwd9xu966Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5lxUnog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6842BC4CEF7;
	Tue, 10 Mar 2026 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773107173;
	bh=0w3Wlgx7Fyv1ZfI9IbsITSNPK9IC53a4vpVUlZH8tRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5lxUnogrWbnhG0Z8aY3RGut64/Q1uFwhnpBTF6LrBlosUnPqL7KsVaHWA9UFP0+d
	 aWzU4qwkz2UF2BlOvbfDXaGlC/PxQCwQv9+2UmZV7R28XY/sAAWEhIFoK2eTnIZJTu
	 ozZlyE4UM+Wrl/gwi0GFEHcTHzcMkcdCCNvGsdsOtX3tC0BLKMktd+D0feE6zTHNp8
	 j7+sOv8jfqGAi7a2estenaQmfwFDifIUW4ZZCXW5xs8nbSBB4cnJ1Mu4UNx5B4WPgU
	 i3CUrJzdqliokruQyn+kyZOz1Yy/9ja5bhSnX3546oUSRGUcRVMCBUtXS5NDa/aGcL
	 ZElyIwpWK2OFw==
Date: Mon, 9 Mar 2026 18:46:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: lan743x: fix SGMII detection on PCI1xxxx
 B0+ during warm reset
Message-ID: <20260309184611.4a98d42b@kernel.org>
In-Reply-To: <20260305090355.4946-1-thangaraj.s@microchip.com>
References: <20260305090355.4946-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 76F69243D10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265845-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 14:33:55 +0530 Thangaraj Samynathan wrote:
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -32,10 +32,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>  {
>  	u32 chip_rev;
>  	u32 cfg_load;
> +	u32 dev_rev;
>  	u32 hw_cfg;
>  	u32 strap;
>  	int ret;
>  
> +	dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
>  	/* Timeout = 100 (i.e. 1 sec (10 msce * 100)) */
>  	ret = lan743x_hs_syslock_acquire(adapter, 100);
>  	if (ret < 0) {
> @@ -47,10 +49,11 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>  	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
>  	lan743x_hs_syslock_release(adapter);
>  	hw_cfg = lan743x_csr_read(adapter, HW_CFG);
> -
> -	if (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
> -	    hw_cfg & HW_CFG_RST_PROTECT_) {
> -		strap = lan743x_csr_read(adapter, STRAP_READ);
> +	strap = lan743x_csr_read(adapter, STRAP_READ);
> +	if ((dev_rev == ID_REV_CHIP_REV_PCI11X1X_A0_  &&

it may be a good idea to a add a little helper like:

static bool pci11x1x_is_a0(const struct lan743x_adapter *adapter) 
{
	u32 dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;

	return dev_rev == ID_REV_CHIP_REV_PCI11X1X_A0_;
}

and same thing for b0?

> +	     (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
> +	     hw_cfg & HW_CFG_RST_PROTECT_)) ||
> +	     (strap & STRAP_READ_USE_SGMII_EN_)) {

I don't think this implements the logic you describe in the commit
message? You say:

 For PCI11x1x B0 and later: Use the newly available
  STRAP_READ_USE_SGMII_EN_ 

but your condition will also look at the strap & STRAP_READ_USE_SGMII_EN_
if cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ || hw_cfg & HW_CFG_RST_PROTECT_
is also on A0
-- 
pw-bot: cr

