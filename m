Return-Path: <netdev+bounces-256679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA77BMUtg2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F97E521E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657EC300EAAE
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A83E9F8D;
	Wed,  4 Feb 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2YqY09F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf9X3Jv7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846F3E9F79
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204596; cv=none; b=djsXYv2+bCZVu7f1YyC/FfJYOzDcUtCWrJGrYvOtqBtT6zWGoBeHbakbltsQ6MGUe1TtB8VhE/QnjaPTdgNYS/M7QsJ6nIds0d8DH9CzH7jWcN4tlF4QbVXkpRuwLnnHUFMUMryg5bsIRLqvAyY2pRNDoiOTobFbWf/zcrgNNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204596; c=relaxed/simple;
	bh=ShwI4jCjSP8+m7Os2djvrxNO/fA9bUZq/Yv5KhSFlvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHOq5xbvuad3f2msTmcJOWJyAX1jiTLh5kVjtX0QXzRw/0fKv8HluW/sPK4hAVqnuqvuAsqgUkeDJYfh1oJQ4N3Y6KlawHVE/PD7ysjYRN5ySdQW+eoHxnt9JN77SDofyzIS9Bmvw2UkNnYNQn/o+Zy8E6WWfFQ+/Ia1eUIm3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2YqY09F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gf9X3Jv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770204595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zqOiwAx1+q0FKyReAOUgZRpz2E1HnCP+W30z4rd0Qx0=;
	b=V2YqY09FtnfjqepMkYJRHTgJimMpvbyLSe9a3u4+0ksKxEwMeJbvVw2VowxA/KBZhNCb2m
	oZGQo3LDLKM1Vs7a6qhli2NQM4yYNMuzMnnuk2TCAuij8A2fHIZ7mv2XREwrh9VGSz6QLN
	Cd+kG9PzVqaIGzXdPJilNLT10SjG0dQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-S0fHzIy6NpSZaQZN0OiAtQ-1; Wed, 04 Feb 2026 06:29:54 -0500
X-MC-Unique: S0fHzIy6NpSZaQZN0OiAtQ-1
X-Mimecast-MFC-AGG-ID: S0fHzIy6NpSZaQZN0OiAtQ_1770204593
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so4163696f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770204593; x=1770809393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqOiwAx1+q0FKyReAOUgZRpz2E1HnCP+W30z4rd0Qx0=;
        b=gf9X3Jv7fhiuOUmepNhbiaGAZgkeQ+v/SlFxuLNajgjPXQGPl0RhUF4Pcnbl23E7Ft
         JC2CsEWLlkuBUUsHhE1Todr8N5lfLrTzQjPzRTaunn5pIq67nt9pR3K9Pnu21blsuxjW
         Mp5na/pMww1CsVP0YO7h4Jz7rTs+E1prBQkFoi/85hWr51gS8UdVyqwxy9xEUEb7m4AG
         rdX56sYMN3c7MVlcOfZ9mIpMCURYXx+vuQAIeGpbVnZutJrPjRMlINDFTt+wvBnuNBqI
         XAj7hEQms0bL6/pq3zfV1MB5ptF9eAKKoyt9kQMYLuuXvkOK0nNC9Yd0CZOcptZZ+XP7
         icoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204593; x=1770809393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqOiwAx1+q0FKyReAOUgZRpz2E1HnCP+W30z4rd0Qx0=;
        b=ThSG2ltXNb5qpm/dKHg4ONXXztg61HXLDmFYgiAkBA9j0PhnhutCYi4fEa0n98l1Te
         BQ0WgCCMCSWRaTmL16HxFjgj046CabIEs0MW29RfM+qSa7zwGS/NbopyCgFUKfzE5Lv1
         TuF1cNsll40XjihL6eOrjGy2vnLSvZSiM8dNJRHPEweosDeO+P1w+uKMHEMLVESceGrp
         XroHGgEb9w1H0Ga341o0wuo+OOAOYVEljANEDqhWtfb4ObHEcdkUHAOX2qm/alNku1o/
         vS31MNc3D0buqVQNafR8VOZrWcDLYxiopyiHNqOZjz289VDGfXlVz3PTcp3Iw5SZaUzt
         4e7g==
X-Forwarded-Encrypted: i=1; AJvYcCUpY9D5JfKl4Kl3QoqyaYfPOQreONe3UJ8/FPYrH11b1wlCjRnqk5CJTii16cJKIg17YZCHOjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYh64vNGAnekBjByEkoCYziVVltoTDTZ7RQXEoUdeoYHs5L/x
	IAPeMOkd9slnsw6yJO1Fk1zwcTDgB4+phGpicJbnF5g96uaq4G4gH6rIU0Qtk7iQg0hplA1D2Ph
	HPmI9RioRHG1MHZbbt3LyrxYiM0VU/ELfRqzKl+583AEsnuL7voz/JVIqhg==
X-Gm-Gg: AZuq6aLQmVgfXC+T8V3R74vGEcW4Q+lER6Aiyw1dqdCCLTC2vFoH1kGMbS15894ITZI
	pnyXCL4pxySntjTcHJko9MzobIa2phbsaokj/Df2yj1pE1OK6vpGDxlVVQyIkm04txzlEG+lDLe
	YmFSQhsX/xYW1+RpG+GvEal27j4FfN2W94vAv3Q5U2NpbQt4n8bavXzWkmKV95xjcB56iCpTW5a
	jXrQQU4TaXYsrmerU/YiFmtJ3fYmpfhUNti5uLixD8WS+VLmzlad+5+OCS6ZghPxVJl8rVmDrEa
	xEwmQOUcOOl0aS5sFMQnovTtiN7QW+QKPp9Lt+E4af5e4LuQvivaLEbYmBg8h0n1AE/l9GJPAFO
	1xFV6810V2WkOeAz2mxlRZSN7Iiao52jkESIcVbs9VK9xMJZsGN1ipy9F7cI=
X-Received: by 2002:a5d:4573:0:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-436198946c7mr2085555f8f.15.1770204592610;
        Wed, 04 Feb 2026 03:29:52 -0800 (PST)
X-Received: by 2002:a5d:4573:0:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-436198946c7mr2085507f8f.15.1770204592143;
        Wed, 04 Feb 2026 03:29:52 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f87sm6371139f8f.21.2026.02.04.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:29:51 -0800 (PST)
Date: Wed, 4 Feb 2026 12:29:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman <horms@kernel.org>, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <aYMqw2HbtKi50b1e@sgarzare-redhat>
References: <20260203163406.2636463-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4F97E521E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:34:00PM +0100, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The gcc-16.0.1 snapshot produces a false-positive warning that turns
>into a build failure with CONFIG_WERROR:
>
>In file included from arch/x86/include/asm/string.h:6,
>                 from net/vmw_vsock/vmci_transport.c:10:
>In function 'vmci_transport_packet_init',
>    inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
>arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
>  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>      |                 ^~~~~~
>arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
>net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>      |                 ^~~~~~
>
>This seems relatively harmless, and it so far the only instance of this
>warning I have found. The __vmci_transport_send_control_pkt function
>is called either with wait=NULL or with one of the type values that
>pass 'wait' into memcpy() here, but not from the same caller.
>
>Replacing the memcpy with a struct assignment is otherwise the same
>but avoids the warning.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Not sure if it's net or net-next material, maybe net to avoid the 
warning/error on v6.19 too ?

Anyway LGTM and thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 00f6bbdb035a..a64522be1bad 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
>
> 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
> 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
>-		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>+		pkt->u.wait = *wait;
> 		break;
>
> 	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
>-- 
>2.39.5
>


