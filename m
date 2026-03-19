Return-Path: <netdev+bounces-269552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDN7F1QpvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DB2CF202
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACFD5304116D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676143ECBFC;
	Thu, 19 Mar 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiN8Pqwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F43ED5DF;
	Thu, 19 Mar 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938657; cv=none; b=cqj5RH5+iCJkoysfvqF4xLqHtct9tP5rK0Z95ZJuqszm1ms2EMth3MgpPPbhKuYMxTDGiTT62Q/6R6bwMvudw93zkF+QN+rGd+EjXngEn7Jo1zJFiLJTrDhcx4X80CLJl+4cMmN5M5276+HDrdWADpSqgvM83o+mIpyjm4Qtup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938657; c=relaxed/simple;
	bh=x/CHnrqPCzLlqdDiW9q/5L8UmkRLlX1/m+oDt4ETty4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKY6tqqaIM6j5lY/vQ7mlPB9bX8Z3CrzedITK77Qyxx2uxytub2Lv15P616KewRumr4eIZDOimBIKoQVhHx0nfaoRzfXpa+9CNmU1pQVSmXBYXh8tNrChzgl93nq2zNUgcRR+9wjx+K/0+UDemlaS5dJxO32w0sMoClVVkFTGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiN8Pqwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972A1C19424;
	Thu, 19 Mar 2026 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938656;
	bh=x/CHnrqPCzLlqdDiW9q/5L8UmkRLlX1/m+oDt4ETty4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiN8Pqwe0FuHUtMbjSTA312RG5694wG08XzyxjRl6cRy6pAxCqgOvVpsdX2VFK0rT
	 C/mas4vQ6T0Xf9QSlD9AuCAi34psT6J2lFXLRttHTCxZ6VY16pQAjNmt6TXpGRM2Tb
	 Lm8WpNEjzZsLZekKOseSs5jerKNKQjwVmVXlQjVvq80gKRMDLGL9omu0AYAtP97OJA
	 aXiDC9fTMYkuFxJc83iXG+oTeAbt0U9m2dzCmKDceiiVgFnyy5mTdsxExaAfb+b847
	 0yFEeUkIdAvixXz/iKnY62ajX+cr0Pjl+DHzP8RfM5tSyzaRuDLeVRnDvzEwHeCbW2
	 vRnxJucemrOWQ==
Date: Thu, 19 Mar 2026 16:44:12 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: don't read out-of-bounds
Message-ID: <20260319164412.GL1753385@horms.kernel.org>
References: <83356ad9c9a4470dd49b6b3d661c2a8dd85cc6a1.1773803190.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83356ad9c9a4470dd49b6b3d661c2a8dd85cc6a1.1773803190.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269552-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:email]
X-Rspamd-Queue-Id: C24DB2CF202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 03:07:52AM +0000, Daniel Golle wrote:
> The write loop in mxl862xx_api_wrap() computes the word count as
> (size + 1) / 2, rounding up for odd-sized structs.
> 
> On the last iteration of an odd-sized buffer it reads a full __le16
> from data[i], accessing one byte past the end of the caller's struct.
> KASAN catches this as a stack-out-of-bounds read during probe (e.g.
> from mxl862xx_bridge_config_fwd() because of the odd length of
> sizeof(struct mxl862xx_bridge_config) == 49).
> 
> The read-back loop already handles this case, it writes only a single
> byte when (i * 2 + 1) == size. The write loop lacked the same guard.
> 
> In practice the over-read is harmless: the extra stack byte is sent to
> the firmware which ignores trailing data beyond the command's declared
> payload size.
> 
> Apply the same odd-size last-byte handling to the write path: when the
> final word contains only one valid byte, send *(u8 *)&data[i] instead
> of le16_to_cpu(data[i]). This is endian-safe because data is
> __le16-encoded and the low byte is always at the lowest address
> regardless of host byte order.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>


