Return-Path: <netdev+bounces-266840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TjILKJUcsmknIwAAu9opvQ
	(envelope-from <netdev+bounces-266840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:53:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4126C089
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1727630490DC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0D3537DE;
	Thu, 12 Mar 2026 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ//Zvhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167233D6F;
	Thu, 12 Mar 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280402; cv=none; b=k/jfXUvydurjNYcZaARlngAEDIyGJdNbHfOh8IwtSShAk9XE6is2kLgjtKxCI7l4vw+kCNscoe9aP9VibRsH7ZrVlvX0924zKtngAtGNHvYyJfnNBS7PPk5qV8WMtvqVo1sIyfvv/RzorSUBLOpJIz0DYsXyD2eU5dPdEzyYlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280402; c=relaxed/simple;
	bh=mUk1xS5+6RdeNMuzSZU2mHir6aOCaBKvOGmvjVnaP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAkP+cuCMVH2mXABPbXe0ib/b6tdpIyjwKiySSq75cKPNgU4AX7SFjkPTpYBfa8j4xaGRLfrJ21d8gAI4HpAGlULACZv6Z6txEVzZzuH0GpHk45kxtZNC1IGYOidswH8J98S3CiqeVu+FrHGtKvapgPqPr00qFjtYRArs8cIxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ//Zvhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696ABC4CEF7;
	Thu, 12 Mar 2026 01:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280401;
	bh=mUk1xS5+6RdeNMuzSZU2mHir6aOCaBKvOGmvjVnaP3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJ//Zvhhe73isZBHsXyRq/SxvtFz0LgvGCI5xRSR6ZCMqfcb7DOL/nyf0jZspn7eI
	 2gly1Aab2ef8op0g0Ap7Ip1BT9hCIBoejcc+TqpxdbZkuUlMgIhdL43gnitim0GD5h
	 /rZaSstNW77LEptgB5tZrRMyfCqI5VxHoyyLtFGFqS7f6PqYygYISaRItTGdAibVnU
	 GqJiKOA8y2baPk5lfkP4DjzKGJAex5Ovsq/EA1SMj338JmxjYg3GVNc112eeeyCqUy
	 EaT5dc660DW+gO5rzppwBvCZKRLTT9X0JzGy+h4GRUbztdPLYd7U6Ug/jVweopry33
	 RStd3TwTyZY6A==
Date: Wed, 11 Mar 2026 18:53:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: tobgaertner <tob.gaertner@me.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, oneukum@suse.com, bjorn@mork.no
Subject: Re: [PATCH v2 1/2] net: usb: cdc_ncm: add ndpoffset to NDP16
 nframes bounds check
Message-ID: <20260311185320.29e5aa7d@kernel.org>
In-Reply-To: <20260309203449.2594858-2-tob.gaertner@me.com>
References: <20260309203449.2594858-1-tob.gaertner@me.com>
	<20260309203449.2594858-2-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266840-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[me.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,me.com:email]
X-Rspamd-Queue-Id: 31F4126C089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  9 Mar 2026 13:34:48 -0700 tobgaertner wrote:
> From: tobgaertner <tob.gaertner@me.com>

the From line should match your SoB tag
You probably need to commit --amend --reset-author

> -	if ((sizeof(struct usb_cdc_ncm_ndp16) +
> -	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
> +	if (ndpoffset + struct_size_t(struct usb_cdc_ncm_ndp16,
> +				     dpe16, ret) > skb_in->len) {
>  		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);

nit: maybe save the size of the struct to a temp variable?
To avoid the awkward line wrap

