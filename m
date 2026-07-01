Return-Path: <netdev+bounces-303711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GndJFe0oRWoV8AoAu9opvQ
	(envelope-from <netdev+bounces-303711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5F6EEF77
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="394jW/JJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303711-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5243A306B8C1
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6935E1CB;
	Wed,  1 Jul 2026 14:47:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5635E1AC;
	Wed,  1 Jul 2026 14:47:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917275; cv=none; b=Vpk5FmMNP+lnEFPcNEMUSCYM/fGmcKpsIjRcEXuIS0Lu0kRg7m5RPTnJeeIqE2M7yPEJul5F7E4+VZ+we9RxzFV9jACO6LgO7yMYUnhOxae4W1tDLz0HsTIIYibQZ7beKFxSvB4/0xXUl/bapXDH5xL2tria8sLnsOUb0O+DsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917275; c=relaxed/simple;
	bh=+YDaJDyGb8xZrVbN2iD3LxVfqXcvFqd06rikh36uTjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6fEc9eqV24lwbVSOww7AD92QeIeqhP+ZF18ELYCaZN+1Hnyr/DuCXHrNdr7kxSo2tyiM+2/xkBtTjlhwf0PsDtTjaRgrlkL04CG3ke81pKqfvMFtqCwjNSAy1MmifXWea5Q1fk39zp+AJqW+v+BuFyUlYaVszd1HSfiPyPfxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=394jW/JJ; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lzO23dF/yCOKFNCgqBrdjraf+bzC5qpqDx3mwunUZ+c=; b=394jW/JJG8LQx5mZyrPZnVIoQO
	YVSBTEzojcZ7/EQYehXTlnFV8lwlWvt8DFkdO9DxioYE7sMfYU305bFruFc8T8qT6OMmtRXkPkEjA
	prKQftqT4uuD68vZK0ap0jvrFBlTW/VeOkrPElcdQqIU7wFkPUCgmMLwfTMhm1cS1nHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewE5-00ABUO-Eg; Wed, 01 Jul 2026 16:47:45 +0200
Date: Wed, 1 Jul 2026 16:47:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v2 1/1] net: rnpgbe: fix mailbox endianness and
 remove pointer casts
Message-ID: <08c1c12e-5990-46bf-998a-525c36c69da6@lunn.ch>
References: <20260701032208.1843156-1-dong100@mucse.com>
 <20260701032208.1843156-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701032208.1843156-2-dong100@mucse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303711-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dong100@mucse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime,mucse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5A5F6EEF77

On Wed, Jul 01, 2026 at 11:22:08AM +0800, Dong Yibo wrote:
> The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
> little-endian wire format. The original code had two problems:
> 
>   1. FW structs (with __le16/__le32 fields) were cast to (u32 *)
>      before reaching the mailbox transport, hiding the endian
>      annotations from sparse.
> 
>   2. No cpu_to_le32()/le32_to_cpu() conversion was done between
>      CPU-endian MMIO values and the little-endian payload, causing
>      data corruption on big-endian systems.
> 
> Fix by adding the missing byte-order conversions in the transport
> layer and introducing union wrappers (mbx_fw_cmd_req_u,
> mbx_fw_cmd_reply_u) that overlay each FW struct with a __le32
> dwords[] array. Callers fill named fields using cpu_to_le16/32(),
> then pass dwords[] to the transport, which now takes explicit
> __le32 * instead of u32 *. This eliminates all pointer casts on
> the mailbox data path and lets sparse verify the conversions.
> 
> Fixes: 4543534c3ef5 ("net: rnpgbe: Add basic mbx ops support")
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

