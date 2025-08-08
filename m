Return-Path: <netdev+bounces-212148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576DB1E661
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5883C1AA4DCB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979C272E7F;
	Fri,  8 Aug 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4By9oiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C626F45A
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648265; cv=none; b=kGjZJ/GYLKpRARAfxGrVsWixQjfT3H6a5x6Zc1BtzmGID/z/LP+GA5KY+RmUcIigNNkgMWApnA0NRuDQL4xJV9aSTZoGxiOsbTYdcSDAYythjNV2Kc4cC+baLi7819WvLFLMQ6iJ8siQiBlL8m9qNbQzUU8d0qD45+aip5G028I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648265; c=relaxed/simple;
	bh=bra15cadH/YMxd6TPp1ICwvGj1H/YI0lTg3zirS9Owg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj7rhOQqVmueDL/tj35eNgXunJGSuPIYXiZvokjIfxfrKxnphFFe4sk0OF+GAG8FOjrXN02wXVJ2APwFVBCMZ4uimUAooL9Y0hHEuup8QiJxcq7PXb5bf3b8t39AkIcwaaQRhQw1EpP7lIMAKkgE58ZLnvSBlx3LDbXWpkzi/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4By9oiy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so2152438b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754648263; x=1755253063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWj5Uk3NWNvLkgMwK3OcXvZNdtWZ5xKlXTjDfPMuCyo=;
        b=a4By9oiywaLMVH/rdVTPte7g/JQt6VZGgR2U83hCLBO2LGr8gyY0X5kLAxoS4VVpWr
         AcZFHeJ3+O50y6h8iRoVJP3+QHmRQw1K+nFtFLwlWSyBGkoiQBIAoJrEyDN35+7tC75I
         jZ8pKO0I3OmCmJmLLwFm0PHlALXcwvMxSJODELbWYVtOjseYodp8dl3dBk16Wgds/CUf
         FnbclxblUkwtonj1fC//Z+irY2WkCrk2JQxL2JOjjm9hVbo8kpf7U8IOCrZYtLjOhENG
         jD7prFZURAYk5UcyOv+8ryTz9mjNIF1xlesWutme7bxlSyAOxvEkfJYdj1oYVFF9ETGe
         8BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754648263; x=1755253063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWj5Uk3NWNvLkgMwK3OcXvZNdtWZ5xKlXTjDfPMuCyo=;
        b=Vdc1LELA68MxhdQmqMXHBB6XM2kKH3ip90dMm9lKX9IqiiHr8nFbZS8cgCyZHbXz6h
         aNOgIAbhxutoiqLWDh2BtTwUCgclBY8+kBDgIOO7PrARP5N27GQ34RA3oGsJs0gv8tGK
         OH4ARJ8IM0dM5H5znIeT7G+9nwrEuhF8KDxAWJ4c7iWOAmz7cr8qJ7JiE35F4Jobc0n1
         U/zb3o63qUQVyB97JsJCkm46Vr1jT24EegzF59L/D0gMWiiLd8T40T80kegf3h0eBIEm
         SFGBImruhTwMdbQ2I4H/JJfym2IHfEynyXnzUd+3SNbQzbUh5e4HOC2C+wlqIG/TxjbS
         g9sg==
X-Forwarded-Encrypted: i=1; AJvYcCVmJ8fdKuoUaNXRTptx0KI/knrIDixwlFwOycOEfTWBp6jq4tuCBuwLyYcCN/e6XXUFJIw4+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kQLDvkl4JhOsKSVqciirhjWUJIArklt1CupkUt/WM3YE2M1j
	6PJ1dcT3UxSDXLIv51eSgf3f2jMrAqnLu5B3PaAEyCEHASzEwVsFGe3WxmJUCfMS4r0=
X-Gm-Gg: ASbGncvulyzV1jkjF+8bwKWdOioMdPt5Lbnqo6lU5y/m27vuP24nYWMiL6UfQawhmSP
	IbEtMT5rr6UcLYmzbzo1BGQBu4f4LBJAPFzR3l1wh4/94UkPd6f12rvgGyf7h12YB5sb6kKeb5v
	7Plb6b5N0c/BQqIrXNL/RgxXpLvOjKlHx5PuRbfsR9/qdbj9YsQp8MnQPE/DZ3KS2//kTn08QSo
	tHzSeHP8huiBii+uj/tre89eq21N7KHaqNmj/06vSxIji0TPIN8ajE97gPlCW995gk5WdPDrk67
	zv7ZElSwpUXcWc/DmOXrcLx/C2fZo4vF4lSWvc2RgLZStHMTX+PAiS8dJD/cXg0mD+NuVM69Fzc
	XNOh8vkHKERCewROR6HmizFYcF3InJnKz
X-Google-Smtp-Source: AGHT+IFBbFPnJ7OxBG3jOKZmMlshjdyclSSEfRm3kGHXUR1KMfbMfZjMqSFQKVORAvHXCSNS0/RUeg==
X-Received: by 2002:a05:6a20:729b:b0:240:1b99:1595 with SMTP id adf61e73a8af0-2405503b294mr4484602637.17.1754648262951;
        Fri, 08 Aug 2025 03:17:42 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee4f42sm24849079a91.23.2025.08.08.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:17:42 -0700 (PDT)
Date: Fri, 8 Aug 2025 10:17:35 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: David Wilder <wilder@us.ibm.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
	Pradeep Satyanarayana <pradeep@us.ibm.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>,
	Adrian Moreno Zapata <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aJXOvymrACCRkd3k@fedora>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <aGJkftXFL4Ggin_E@fedora>
 <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>
 <aGOKggdfjv0cApTO@fedora>
 <aJQtzYe0XyFAEKFz@fedora>
 <MW3PR15MB3913268E49B5D040CFF75107FA2CA@MW3PR15MB3913.namprd15.prod.outlook.com>
 <603132.1754590220@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603132.1754590220@famine>

On Thu, Aug 07, 2025 at 11:10:20AM -0700, Jay Vosburgh wrote:
> >> This is a key difference between IPv6 and IPv4:
> >> In IPv4, it's possible to get a destination route via the bond even when the
> >> source IP is configured on a different interface. But in IPv6, the routing
> >> mechanism is stricter in requiring the source address to be valid on the
> >> outgoing interface.
> >>
> >> I'm not sure how to fix this yet, as it's fundamentally tied to how IPv6
> >> routing behaves.
> >
> >I am thinking that we don't need to do a route lookup as if we are sending
> >from the bonding interface.  We only need to find the interface we should
> >send the packet through.  As if we ran "ip route get <dest addr>".
> 
> 	Assuming I'm following correctly, the whole point of the route
> lookup is to determine which interface the ARP (or NS for IPv6) should
> nominally sent through (based on the destination address).  This serves
> two purposes:
> 
> 	- collecting the VLAN tags,
> 
> 	- insuring that the ARP / NS won't be sent on a logically
> incorrect interface (e.g., its address corresponds to some totally
> unrelated interface).
> 
> 	So, really, I'm agreed that what we're really looking for is
> "what is the proper output interface to use to send to destination X,"
> which we can then check to see if that interface is logically connected
> to the bond (e.g., a VLAN atop the bond).
> 
> 	Is the solution to call ip6_route_output() with the flowi6_oif
> set to zero?  That seems to be what happens for the "ip route get" case
> in inet6_rtm_getroute() (he says, looking at the code but not running
> actual tests).

Looks reasonable to me. We can find the dst interface first and check
if it's an upper link of the bond interface.

Thanks
Hangbin

