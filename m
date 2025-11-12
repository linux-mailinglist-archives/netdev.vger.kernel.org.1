Return-Path: <netdev+bounces-237836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F1C50C00
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A6C3A3FE8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD292DCC03;
	Wed, 12 Nov 2025 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4O6yMtj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DE1990C7
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929875; cv=none; b=Pmdv9Sj3xqoKl24QsOyygaH1HJXc0nv0LvISyozfuqNBXtIbk5kfBDuyiD6L92PY8DAvMCLhqJQOnHNjhRKYgjxBd0JuZUbl7Sg1dB5yu52pOLTmqylRwRKrNGVtzhzE0YQhjLSLHF0+rJlLHfUn6sPZJpp7qFryAGiF1CGefL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929875; c=relaxed/simple;
	bh=IELEeu7LGoirbxe756K3GovBAPYIdZ64MpFG+M3zlV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgOy+2nwOUJn+gbcTD4tdQTf3kToWWCS1Jea+thQsLQ28tekIOQb4rfOFQX9oWYpfmLWUtPQ7D8rQ/XS0WkZOgiKDwYsCkV39tXiOl2k0FFDNZ2WIjtUbel69Y51anr0Btfocb2Sa3NVr3v+wR4uJbtfIRwaOKT2F6+mphDTBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4O6yMtj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2984dfae0acso6103785ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 22:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762929873; x=1763534673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufAY6cOfQn0j0cNFuxbnlo7w/oe8vZbBRcBh2SCbBhM=;
        b=U4O6yMtjgo5MxjWag+7IoeygO41qJ+nTyiwUG13RmEPxXoD6GQ3CxWDCF8XhnZEb7u
         VQx7pp16eCcj1mZczzoIEi1wVltQE6oDVPj8QbOTz1wxXCU/4qlgGnk+EF6mj3shfvA0
         PQR9BW0wbGVk+IQ2zOucjpiicn4HFvxJnxG7AlgVrdCBuZc8tKgo9cMbtIy9u2PX93II
         ybKsw2kRCR0VtO9fynUAiFni6XqQ4Xkua6MXkVpKN8O9rb5AcYBqF4zfrmSgWOoOKLfA
         0akYHOau+dASNZIGra9/CfvLoYJCbaRjhrqBD0FQprP0CAtZjPo1DnY0wDLWIKUgNYkI
         3sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929873; x=1763534673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufAY6cOfQn0j0cNFuxbnlo7w/oe8vZbBRcBh2SCbBhM=;
        b=TAlWUz+OQVKGkVFQnIbMNak12Av8MYMfbvnAFCaWMLdmPvgODRnx6S229sOUVMbyer
         r5156Fi8NUxsUFb60JbZrBioaaHXc/gZn2btjeXlJ0FCQ8+iypRNt3zU/EycwLtC+dRX
         0Ytizh5pOschWg+R7uYJ38e6p9zSktbf3pR6bI+kOMt67gGQDAvHAO953oFsh3cS8I94
         xkwU5z2muzNIwOT4iA/euTP8HPwSEUpDJb//KtR5Yt3/3DkGow/4DEIH44uMupLM/Uil
         TE8W98UX4ccv1Vrd1QcchbLk87IO4ah413z8NJJHPxpap981UYnIQ6bIs1a06hGAnH60
         6pXg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPVcLnNC16BaGa0Ct2il2QzQ8WC3UUpl2jCS8Pv/V4wzXjRo3+BRJTc0ieONlINL31h/OgSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqjvGCMbVG4Pf8G+loVicVeHr3CiEPgINQQucnY8wvZ4wjBOK
	dEyxp/dfQIxzTjlXbqUu/envILwqLF7uKYS+0RQIPO9lagKiq3if/Jbp
X-Gm-Gg: ASbGncvEWb3FRA7IBhtCFrQrIskY6SPStY8mqZ4ZAZ8o4hfLsNPBRjy77ZXVB363oc8
	gGGs5SDiJQ7Pu592j/0qFubuvj3NPL140B1gil0yp+DPuhWXAiwMuomgzo6h8J/oCyHe7yJ/VzR
	zqITSRiCFuGmsn+J2vM9MT6c1lLzxEi4ryP+vFGxalDu/yc1XlnFvbRygA6YKDFmPdDsVYEiWgO
	kyJelRn97V0pniCaXKpp0VUs/Z1OPCzByC3O9CKGy2likw48+/j5vEtyPg+vBBWQruwubs0ERqx
	gU4SaaFsGOXV6BtSjO4cYVpqstOO0dkDNaeGdsPP1HIZ39mgVrzm7p/w8E0h02bQs56zxcgvcLJ
	hSzz5f/gfDIZaOnic2Qpk/TIT10Qo0jCEsnw7/XRbz/HhIq9qRRW8MiCuPoQMSxup/GJHCr6As5
	fk9NUj
X-Google-Smtp-Source: AGHT+IFBuLspXHV5fNvoRqtTudPFOnal2usY6QqHd62gBNO7qk1b8WNXavFrAnWC1zWUguQs22yurQ==
X-Received: by 2002:a17:902:edcd:b0:298:450d:6926 with SMTP id d9443c01a7336-2984edcaeb6mr19331065ad.34.1762929873528;
        Tue, 11 Nov 2025 22:44:33 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9fed7sm18444795ad.68.2025.11.11.22.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:44:32 -0800 (PST)
Date: Wed, 12 Nov 2025 06:44:23 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Wilder <wilder@us.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
	amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
	horms@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	edumazet@google.com, razor@blackwall.org, shuah@kernel.org,
	corbet@lwn.net, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v14 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aRQsxwgtra6L5cQz@fedora>
References: <20251022182721.2567561-1-wilder@us.ibm.com>
 <20251022175033.7daec7f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022175033.7daec7f6@kernel.org>

On Wed, Oct 22, 2025 at 05:50:33PM -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 11:25:27 -0700 David Wilder wrote:
> > The current implementation of the arp monitor builds a list of vlan-tags by
> > following the chain of net_devices above the bond. See bond_verify_device_path().
> > Unfortunately, with some configurations, this is not possible. One example is
> > when an ovs switch is configured above the bond.
> 
> Once again if anyone thinks this belongs in the kernel please speak up.
> Otherwise let this be the last posting.
> 
> *If* someone does speak up in support you will need to find a less ugly
> way to represent the attribute within Netlink. What you invent must work
> in YNL and be added to the spec (Documentation/netlink/specs/rt-link.yaml)

Hi David,

I haven’t tested it yet, but for the netlink part, instead of using a
randomly sized binary structure, maybe you could try using nested attributes.
For example:

IFLA_BOND_ARP_IP_TARGET (nested)
 ├── [0] = 192.168.1.1              old format (no VLAN)
 ├── [1] (nested)                   new format (with VLAN tags)
 │     ├── IFLA_BOND_ARP_TARGET_IP = 192.168.2.1
 │     └── IFLA_BOND_ARP_TARGET_VLANS (nested)
 │           ├── [0] = 10
 │           ├── [1] = 20
 │           └── [2] = 30
 ├── [2] (nested)                   new format (no VLAN tags: leave empty or use nla_put_empty_nest())
 │     └── IFLA_BOND_ARP_TARGET_IP = 192.168.3.1

When parsing the attributes, first check if the data is nested using:
nla_type(attr) & NLA_F_NESTED. If not, just copy the IPv4 addresses.

If it’s nested, handle the target IP and VLANs accordingly.
The downside is that this approach would introduce three levels of nesting,
which might not be ideal.

Thanks
Hangbin

