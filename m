Return-Path: <netdev+bounces-296165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onCNKrebJGqk9QEAu9opvQ
	(envelope-from <netdev+bounces-296165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4264E776
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:14:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=YRv9gY3I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296165-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7543017092
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DA33C1B4;
	Sat,  6 Jun 2026 22:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC8264A86
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 22:14:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780784051; cv=none; b=UZQsp5JyaWdd37tGbM6EVtoNA7KWcxVnnWL9+nNielvGD3LykCwiodLo3aSLwuOdbEtzWotbirZbr5ZUCnk9vlfgNCI27GOFj0K6+H81yKIeTdqpnmCifW2drGwNC2y++5pPwP5N09HKFzlod8qCHHWqAaNUrydisiZpAy9X5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780784051; c=relaxed/simple;
	bh=s5c6ul3C63xfvEM9cD74J3TRSk+sjNTozC8i6Xue4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImTkLlBQsF1E6o7clzscdK6YRGo9dN5et7q34iatUrTXgpVVM2o0Glv37i9g0yLGsPDZcMM7eQtY3RY3iy3vucHlEXTUwqSfH2kc5LLZvL/YuHqCsFIYEsD5kO0vRzs7VL28V97BTrOFSENaLaL9tcRMcE4e+7Hn6MQqzBgXkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YRv9gY3I; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso35694445e9.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780784048; x=1781388848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9c+Hlm2LHsdp+Cs0S88z9ZuS/e5nxWWRGBAgwrHV+84=;
        b=YRv9gY3IAArwcZYyYbAHkBgGLpc49JS96vN2NQez0SLcwwM2SV81G7+skkOXFg/UZB
         3agt32ili4/3p+nc5srNKxGDnGrOiivOUupgB0+Hfde0xDR0VHDLY4vwCzrP+F/N5t5W
         ycqFGMUaEcAj/jIlx7DQGWEmwyu1id5AY5YGDCnmIfTZFUJkZA7WRrltOThcSk4wwadM
         7e4TNOdcJkiPM9e+N4grjJLeBOnO2khZPHmuwjjKkEVewUsqdeWLifR+r7fa+lkQqa1H
         tnCWZGqU3aI8nUwOfKdojOxGKuk/MieXkGFMseRi4hlR4OZYqSWSK++KzF0tbWY7TRwh
         XtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780784048; x=1781388848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c+Hlm2LHsdp+Cs0S88z9ZuS/e5nxWWRGBAgwrHV+84=;
        b=BV/pxbvldjfloleDTGMDoF/b3wi/KzMovGVhu7Dx/AU/FYrrY9rw7sVN48pir4idnb
         CmDMgt1tfw2pcZYIhuZlZjn7jlMmwY6YKfpckqRk1Etm0AVImJpl+fujvZfV5wo8v3Mb
         wG/UHG21IKI+zgdBgrA+UPWaYMKbsladI7FmKNnplMyg+JoB/oL9BtEJgpmEyd0wi6v/
         AawCw6RQ8WZsBCs4p3fX+EglWx2Xoz8s1kyoYYpspGxNDw3bKeoZr5XYVd1TDZFbhjF3
         rLAJc1sBRnxquYVoRqmsvEfqcKpMI8zF6hq5My6dPtLBBAGURTjHIP204fNparTMIKKl
         Fgvw==
X-Forwarded-Encrypted: i=1; AFNElJ+VuYAMrYGhdYCUAtnPNXRgA8N9eIayoZPKg6WQ8Y+bPsATJBWkaDK2Ti6lOt+iElq6r/2mkjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4j/TBtwhU6Fkf+VSj8/WgFqUqWWkthxpgEe7fcG34OnsYE5BO
	tW+C+q42Oyf7++S6a2Txz8UyHaZVf2lT1jZvAjvPtVEY9lz+8Al6hW2REUxo3x4sSaM=
X-Gm-Gg: Acq92OELlJFe2IGXGny1bfKf90aQbM4Zo7HR4ZhadMENd9dfxh5Rx/80KWVmDsHG3NG
	kEjzcjMYahv5V5fTkp7lUmjVFu+F2bZz3qDIL4j1fHN5BMTeL1vplBZ2qWPJyI/MizYdbVQh/SA
	UCfEDGQdDRfttlnhcZo3aiu8pr34Pe3dlKEqo+EJZ/xTmF9mSn+s1I8KlhHPP02OlTYiBuJ4R4d
	4A9VUJ/aX+1P5/bWZRd+LLGOh+Md0lgQR534mwvZ7aFWNUde++6KMEClxBJZ+rU04oQGY06Wl2u
	fL+F9/KkLebzDIf8OjBfzyeSHyoz15ytLqEM6Yv8FD7dtpZyLzKInXskk4iJcoJzMvTuyK6ZmL0
	8RsRUyNSuIJZx0Vu6aBMpoB9mjRtg758imF6tqhgTWmqYhqxadB+PtyHHSEuHYfgcB3b7H234O7
	cETm/SI1GTzK78FyxVlWkfnoqIJk1QTsjc30YvH6qVJKjNdTICVR9UJ4uy
X-Received: by 2002:a05:600c:6995:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-490c25dd66emr159444885e9.17.1780784048113;
        Sat, 06 Jun 2026 15:14:08 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm269237185e9.6.2026.06.06.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 15:14:07 -0700 (PDT)
Date: Sun, 7 Jun 2026 01:14:06 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Luke Howard <lukeh@padl.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Cedric Jehasse <cedric.jehasse@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Message-ID: <aiSbrmlOunfxwvGu@penguin>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
 <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
 <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-296165-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,penguin:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C4264E776

On Sun, Jun 07, 2026 at 07:49:26AM +1000, Luke Howard wrote:
> 
> 
> > On 6 Jun 2026, at 6:21 pm, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > 
> > On 06/06/2026 11:02, Luke Howard wrote:
> >> The definition of Dynamic Reservation Entries in 802.1Q (clause 8.8.7) might support the addition of a new MDB (or even FDB) entry state to the kernel:
> >> - add MDB_DYNAMIC_RESERVATION (a state, not a flag);
> >> - the software bridge only _classifies_ packets against  MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. Classification sets dynamic_reservation_hit on tc_skb_ext;
> >> - dynamic_reservation_hit is visible to the flow dissector so can be used for policy enforcement.
> > 
> > See, saying the bridge has to classify doesn't sound right. Why not do the
> > classification where such operations are usually done, e.g. tc?
> > You have to manually designate these entries anyway.
> 
> s/classify/mark, i.e. marking a forwarding bit for tc to match, a la l2_miss.
> 
> tc can’t see into the MDB to tell if a DA has a dynamic reservation entry so, without an explicit DRE bit, the SRP daemon would need to maintain a flower permit filter per DRE. Not needing this allows the user to set a single policy filter prior to starting SRP, e.g.:
> 
> tc filter add dev lan0 egress protocol 802.1Q pref 1 handle 1 flower vlan_prio 3 dynamic_reservation_hit 0 action drop
> 
> It also maps cleanly to chips that support 802.1Qav with priority regeneration or filtering, but which can’t support tc-flower.

Yeah, that was an expected answer and I've seen such claims multiple times.
Just because it is convenient to add it in the bridge, does not make it the
right software model. There are layers that do filtering, marking and manipulation
this must be done at such layer. If you have to create a new table with the entries
filled there then that is what your user-space software must do, or come up with a
better alternative. There're also bridge netfilter chains that can do packet
filtering and manipulation, that might be an option.

For the MDB to have a dynamic reservation entry means someone must've added it,
these are not dynamically learned, so you can just as well build the table
in a more appropriate place which can tag or filter the packet.

