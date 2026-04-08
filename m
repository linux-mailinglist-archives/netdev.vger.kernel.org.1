Return-Path: <netdev+bounces-276608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDUjMd581mk0FwgAu9opvQ
	(envelope-from <netdev+bounces-276608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271033BEAA1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD31B300F9EF
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49B344DBD;
	Wed,  8 Apr 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V5AgcFi0"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F1148850;
	Wed,  8 Apr 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664279; cv=none; b=jyavwWtTNY882safnig+d2GLejIe2Pg+2W782AO5q2yStern+/q4zlsb0RGk7I2FftE4vmloIGHG7LaQFE1HOEDchGrmgN6iSpWb0LRUHuHtl7yif2j6xOiiP1bGMQi447H6B0RbPTtoF18i4xOafYRVPQVIjvbiL6wW+nZ8RNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664279; c=relaxed/simple;
	bh=Wd2m7iU2mZDA+tWAdM5/g3wOKXumvDnuegND2duFs0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUjxnhNTWnYPifw7ernPQvaTDxEGYvVeCePjjvM2dGtKJMiVCgO/htfEoGyQJrUwe5mucBcbeMohjmlFo9xCgayO9ir5YDWzGMhb9NejxEASE7VwESVF8cNt3ZCjBc5QaY3LhfaZYmuKZc0ltaMIrZaBd0MzxrGKtqpp4N0EeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=V5AgcFi0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFkm80ao5m8gPxA3JZ1S6iv01ihu7bfqaojN7LVM90s=; b=V5AgcFi0b1wtzKM/NSKiEn9N8K
	Y3wobGjDB+l+acpdJ24MtFql+43JyQxyW/fcL7Ystuko5pLDqKLplh9ihlKviiOaK8Ubcj0IFFMoV
	r+3HiG+2hyQ/VKMDtuKoVNSdFijDYEotvQXgH+kWTipNLA4kPB3fsxR9RKG1dJvOW6MFplqyQZZxD
	2v2sWmI9ZGuMpJXTuAAhmgxydpqgNT9xIGIh1VmcVw3wGmlFZpsW2OC2C8cd/8oyrv1+cDw4AsltV
	6RE0vst++cl3Qce/9bz4O239/FvLKIv5lq08pI/wlAV+nV6Ov+v3oNMFZRW1bCQFxEFt/RtgKx2nP
	yKQqD7FA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wAVOC-008XMz-3D;
	Wed, 08 Apr 2026 16:04:25 +0000
Date: Wed, 8 Apr 2026 09:04:20 -0700
From: Breno Leitao <leitao@debian.org>
To: satishkh@cisco.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com
Subject: Re: [PATCH net-next v2 01/10] enic: verify firmware supports V2
 SR-IOV at probe time
Message-ID: <adZ8LrpNZbQgy3NO@gmail.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com>
 <20260408-enic-sriov-v2-admin-channel-v2-v2-1-d05dd3623fd3@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v2-1-d05dd3623fd3@cisco.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276608-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email]
X-Rspamd-Queue-Id: 271033BEAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:08:11AM -0700, Satish Kharat via B4 Relay wrote:
> From: Satish Kharat <satishkh@cisco.com>
> 
> During PF probe, query the firmware get-supported-feature interface
> to verify that the running firmware supports V2 SR-IOV. Firmware
> version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
> CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
> feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
> admin knows a firmware upgrade is needed.
> 
> The VIC_FEATURE_SRIOV enum value (4) matches the firmware ABI. A
> placeholder entry (VIC_FEATURE_PTP at position 3) is added to keep
> the enum in sync with firmware's feature numbering.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c   | 18 ++++++++++++++++++
>  drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index e7125b818087..3a4afd6da41f 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
>  static void enic_sriov_detect_vf_type(struct enic *enic)
>  {
>  	struct pci_dev *pdev = enic->pdev;
> +	u64 supported_versions, a1 = 0;
>  	int pos;
>  	u16 vf_dev_id;
> +	int err;
>  
>  	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
>  		return;
> @@ -2669,6 +2671,22 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
>  		enic->vf_type = ENIC_VF_TYPE_NONE;
>  		break;
>  	}
> +
> +	if (enic->vf_type == ENIC_VF_TYPE_V2) {

Maybe invert the if case here?

	if (enic->vf_type != ENIC_VF_TYPE_V2)
		return

And then shift the rest to the left

This might be easier to read, and the code looks better, in general.

