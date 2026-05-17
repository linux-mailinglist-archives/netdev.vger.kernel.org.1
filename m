Return-Path: <netdev+bounces-288737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +dzrB07MCWq2qAQAu9opvQ
	(envelope-from <netdev+bounces-288737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:10:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6595617FC
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92641300131D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8E2F3C0A;
	Sun, 17 May 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="V+heROO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A82F12B3
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027014; cv=none; b=ia6SA3hX82hGQtVkFoH3EB32vSd3UE1MiyAW4PmB3yLb7rCOuQ7GmH9XI/cHQAg3cnVNoSM/SaDWX5w4Y3CSE7iYRiow6BZa8v26K4WoRNdYzyW5bMB+Md//RRMI3iuMS5qua3RYpXGZfGrlq2mXERdzMcyZCa5qFxhcDDK7zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027014; c=relaxed/simple;
	bh=Dt4gtk/9t8Q0pUGrAZDK5wPM+YunpJ40zv2ggc6be7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxte/8T+rmeJxq9vtArLCQgt7M/aAhobkeE8srTqYbTzXeymEjDAPXFU/dRUXx37cPpLWovM6Y63K1VYSevkexZtnymztgYAGjQjUMH5Qw8bRr+cBfrxlbNV2/0VstrTluqbDBIRJhPNjmVqKfe8WeuWuEj14v5ANU4hYd1EIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=V+heROO6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so11402445e9.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779027001; x=1779631801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2PRQ96kutFisa+sIMLWv8AnJneLspgAcXkKd0ULNdE=;
        b=V+heROO6mqXEjFuxGBBKDNzic+E4cZGuU3Jn+GjmOh5EjAXpXizE9Kf7vDJQKxndD2
         HTdscyJiDo8bf5UaVyPZFRCBat6dJRBBS9OEXByg2+eJpygJGbhTQ9PfDhScP0H/8yJF
         n8zOTYdfDnbGvKj4J+Zxcvd6krRDdLtxOgfeMexDVvrh4sXyB63517sCfTr5O9YeALF2
         TQyui+lwgQNTbD2GJ9oRO2f06XpXbGG0IADlu3j7B9kfoJUjz2Vn3dJQDl7ixpNSQtte
         lkw1OeKqDI8HlEam6X9ZCnx1H7/KoiaF+PbyXxBiEbU/wbiXz4T9Lh5ME2qmUdIA+rEs
         4WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027001; x=1779631801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2PRQ96kutFisa+sIMLWv8AnJneLspgAcXkKd0ULNdE=;
        b=X0t2PslN+FhZhAeHDnD8LEyoCWVdM2dUS1p+zBGS6lWsGk/wvJGm+u8RcpXk632o8u
         Iw5oEGTeLp1FtwIPt8rTwt78Uufypk2AW2A2x2Zg+o6fUv6qvDtla84iwt4OcNERKod6
         GQFuVIUf8TX+hWrmeJ//dJRplBwoNdghEqLOySDpOhQX2Z2HIQplfTaWXrv8hsB2cyjx
         z2siXJWIUs9tLBaukMDGm/QFkb6n+NjMa2ETP1uV6fnNXA7UQYgyMhGVblDAvOIK1eVC
         gtvEn/hX7QX3YPgN3XxCIAKIAZhOnZz/sIKfmKFS/k2DxpvQnIawY9TGeQFSGn1bzxep
         uJhQ==
X-Gm-Message-State: AOJu0Yw0pbqtOtFsO84qULKi8cfVR6xGnE+uPSX2cQWFytuVVMw+47t+
	1vH75Ax6Cmhmt1OE+28ASZANgCK6iupbpx+peAQ9kuN9YuTQhfzsYawBSe3WZq+pHnQ=
X-Gm-Gg: Acq92OEQE7yridcfs4d0xm6b6l0JTOIGbnVOo3TOlT9NGgqIwiG8x65kulYposGdsdy
	4R63Ape4unl4fk9w7QntqBEC3gmTfSueOAQt8ijnf6kStdHrL5vDZh8VXaV+xDL8UJnY/BolV9z
	U1BMZAC2m+FPW3gZ9Nnt2ISvTGHIZ8vJa+csxEEBKc4kHC25npNacMUhDPnuG13n0bEMki+cCg8
	IkRVCLbItWMC0+UOiZOtjJe0PxPPUfuEQ/eYSrLq2HLKiL/DEMTsTWLjebc325ccF1JLwvijabJ
	pm0sDklVzyAxjoK08hOJkkpUzMqJPVmiCgbRH2cYuJOnxXiEjnYwTADzkOfo8HbBCC0/F0mitXW
	bUtPpflO88SfUCqJdcvfhrml890u0YpiOX/RGleGbALCe5eb3wGqm1iIBJClF8hrKoGYEk/Jo/k
	rj8C7vhZKxIWfx9+fT4/0qikfSRYFuogpthuukW8VvrHNHVEv3BNLWS/Z8gg==
X-Received: by 2002:a05:600c:3096:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fe5fcdf39mr106171095e9.3.1779027000790;
        Sun, 17 May 2026 07:10:00 -0700 (PDT)
Received: from localhost (176.111.181.159.kyiv.nat.volia.net. [176.111.181.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm3292965e9.11.2026.05.17.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:10:00 -0700 (PDT)
Date: Sun, 17 May 2026 17:09:56 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH iproute2-next 1/2] iplink: bridge_slave: Add support for
 neigh_forward_grat
Message-ID: <agnMNKyca-ba2-b1@penguin>
References: <20260517082501.899009-1-danieller@nvidia.com>
 <20260517082501.899009-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517082501.899009-2-danieller@nvidia.com>
X-Rspamd-Queue-Id: AE6595617FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-288737-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 11:25:00AM +0300, Danielle Ratson wrote:
> Add support for controlling gratuitous ARP and unsolicited NA
> forwarding at the port level via the neigh_forward_grat option.
> 
> This allows configuring the option via:
> $ ip link set dev <port> type bridge_slave neigh_forward_grat {on|off}
> 
> Or via the bridge command:
> $ bridge link set dev <port> neigh_forward_grat {on|off}
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>  bridge/link.c            | 14 ++++++++++++++
>  ip/iplink_bridge_slave.c | 10 ++++++++++
>  man/man8/bridge.8        | 10 ++++++++++
>  man/man8/ip-link.8.in    | 10 ++++++++++
>  4 files changed, 44 insertions(+)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

