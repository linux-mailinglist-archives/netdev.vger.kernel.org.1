Return-Path: <netdev+bounces-301589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIYqIfCkO2oQawgAu9opvQ
	(envelope-from <netdev+bounces-301589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF76BCFB5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MSH5b1UV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301589-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301589-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8075E314DD8D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1138C2A0;
	Wed, 24 Jun 2026 09:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE83A7F60
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:30:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293413; cv=none; b=GA6KV9sk5GVBhjvCEKX3SjIQ6h+o5TTuYKQU5k5kMVx6o08yucyV3FAZqOl3FjTt3z+pl4ZkWoVb3558nha//SyCZ+Eq5aKE0Emb2+LSP7lBu2XB6J5yNYkR95snIrpKOi35VNivbdpJvRMjvM4rBiQMkSWeKq3EmkgpdQDUvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293413; c=relaxed/simple;
	bh=D8CFwLPp5KatUW5AZ7GtpjRwh++f82p7zALAB4npO7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsN+RfFfwxy6A+QhnHZ1y9s69TsVFBft6UFEgb1pyz0u1HcMCmPX0grH4N7UkpdWbbcqCwyDoslGblIs3kQ/S6Qn4GD0KHH4R3ljrNti+XHTKbhoRMmlgBcUp3ohWolHMAjVBPZtYhEMdxdftxGnlRem8vNpn+J+G0O8AHwmMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSH5b1UV; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84531988438so1111074b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293405; x=1782898205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04Y/Pe8XmMfRpuwlfV46g/2VJTxETiC/sRNVRFinUHU=;
        b=MSH5b1UVo9mDNudBLwv/KkdWEX3cM1XrNJwmnVpGpVQgM1cAq5G0oGy1KkLl8DAus1
         6Muo1CLjhv/t+nWaMZSqwqicqUk915yntntUlhQ2VOQQdRdrYReIJ1O+DW+BT+AZxCjo
         PrLswFn9kP3Am34VvvIpK7RWV5ApwYRzknz5ZHaRlQuuf3CXiZrHOBppaPht1S7wP355
         8MvJTGTX9er6c1VYK41UFmH9GCVcgFVrDVR7+cJp++XsV31dkONr/akjr/+tJ6SJDRGj
         b9h+QzHmJPDCjbXH3ByvLkgzWPrfEbynVGYjsR6qLsUriKN4uH660aKgGjwnaM5xq3M/
         I7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293405; x=1782898205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04Y/Pe8XmMfRpuwlfV46g/2VJTxETiC/sRNVRFinUHU=;
        b=GNamj+0gUHrk26Zdv+iGb1bxHvRMnJJjw7ZLZ3XHaZtBVt2yz9qvstmfhykHKf44cq
         EVd/ZCIPp+XWd0Te7O0JzY44OZT/zonCCNdS1OH/P3en+wwVzIrC8vt8JVp6wcgjyC4a
         RYmvwIh52XcZqX0NqJCWedPh3cWXU4Kp8nhNQwkLQHCTLvggb+pd3IarClXvM/jGQFJ+
         XbB+zJKyEkZQXYyh8Mn5DcqPhnmYq+SpiOXcQwdtDmNzEMJh5ZTaPv6CTX7/zXJSo/t5
         jrPhWShlI7XATMKcrlt4//qcBeZFw6iQSeURGdajd+1FY9WHXMWkZ5qXX5plCOCPkg9N
         4Igg==
X-Forwarded-Encrypted: i=1; AFNElJ+kGpI3dL5yU8wx6JDhFT1sK3VPru4sljJWnnCaochGpwt7xIkP+BJ8f951rKHRaIdf1u6HCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yf5QEM1C8EOZzify/PO2d+HbGt0utxRBsR8/AcSdsnjUaELm
	p+v8uuy0RYjhc40sCEYA+18XRG0WCY5+0CxsDKFLfErdDHYMWbd0P5Cn
X-Gm-Gg: AfdE7cnx8fSPERnkWNB2Gjvp9M/PjR+ea8Ah1YPeuvH0rIdmbD9x2rCKZGLhl9VJyja
	kcJuCzzbvztqxTmQDvbtK1KPan0mRPDtqwsVXL3cEtqEAfud2d+VVGPo6wqf7cpFqsahUuBnfj/
	bATAlMLmrJm+Ixl0dw1Ho/hTJfW6+oVhWVZtlB0NgFs6QnN3hiR1Pbnojov0vCzzzvUt6GUw3MA
	fV4l1y0b06bDSJB7w36TK7xtP6rKNlZY4M+TnTIWxe7qZDi3i8GJNusPnDINkgxQALD2pPkeHfT
	EraThhPIcAaqhZvlN5DHno/4uTQOpGFlcpEuog1F2fHcpfIcqb/wt6n681uyej79rWUQaIDzuhD
	+pKC8608pNha2NPZXcHneG8h32/ioiElPcbklAvCFk/u27C/6+reI5rJF8Vo+7Fy1ACBTyc8lbg
	hEk3/ENNX3E4/0Osvnrp6sZ/tZpRgOE1Re+DZWiBwGYMmKU+Rxcmkr4+i6aYPVVcJMsg==
X-Received: by 2002:a05:6a00:2e9a:b0:837:f111:b70 with SMTP id d2e1a72fcca58-84591b23fe1mr6791752b3a.4.1782293404586;
        Wed, 24 Jun 2026 02:30:04 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm1679883b3a.22.2026.06.24.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:30:04 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:30:03 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062417-conceal-driving-0ebd@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301589-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jwlee2217@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5FF76BCFB5

On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > Hi,
> > 
> > Could the following upstream commits be queued for the active stable
> > trees?
> > 
> >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> >   ("ipv6: account for fraggap on the paged allocation path")
> 
> I do not see that commit id in Linus's tree, are you sure it is correct?
> 
> >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> >   ("ipv4: account for fraggap on the paged allocation path")
> 
> Same here, no id of that one in Linus's tree that I can see.
> 
> thanks,
> 
> greg k-h


Hi Greg,

First, sorry for confusing you.

The commit IDs are from netdev/net.git:

  736b380e28d0480c7bc3e022f1950f31fe53a7c5
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0

  eca856950f7cb1a221e02b99d758409f2c5cec42
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c

They were applied to netdev without Cc: stable@vger.kernel.org, so I
wanted to flag them for stable handling but I send it too fast (before
merge).

I will resend the request with the Linus tree commit ID.

Thanks,
Wongi

