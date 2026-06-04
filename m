Return-Path: <netdev+bounces-295219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JjeOXtrIWqeGAEAu9opvQ
	(envelope-from <netdev+bounces-295219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789363FBD4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:11:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cb+sPJ4w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 224D830094C1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A342316D;
	Thu,  4 Jun 2026 12:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1B413235
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574520; cv=none; b=qhO8KLbvwV6qalDM00zecl7XbpicAf5D6AiT3nAPoZittf+kO2aP8RYbH/Jj7x6u06RW9XY+hOLaQNZ024jbF5c0+jRW663UWtoItr1Y4px90gFf0sfzjLS7p8LppxGUW46PJsFTdJ4jfFRApod0jWVYBT5/YZQoZcwxwwWk0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574520; c=relaxed/simple;
	bh=RaK54vKkefWUddst5/mDk+K7Vz8cnqba+Gq4BTS5wdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOos6N3SVwkoPt2g8oAjkmzm+o41nF/cOFbH2N1xb6SfS0yEox5Y4ZL4SUbhQnyHOkNXgVsJeeh+tdP1nZBWyCqDxdoee/0DXfEQQoAWnkOwSxBRD4IkD+akX1RO+cWh9+IfsjCmXvqcYZzykZK/qyFgQepdxpfYTWcfrXWZVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb+sPJ4w; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so441676f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780574517; x=1781179317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=03+Qa9RGrwe/KYIyq7vOdduMenMTTw8VAMY6ULVuEt8=;
        b=Cb+sPJ4w9r+21GEwz41sXProHdmw+0ns84JZFSdYnqyHJdMpUb7anjH/t7/2LzPpe8
         /No4WSBOt95FX3/3rkdfGjxJyso/l82vqRxlhA+WSoyauHTAzvshQMltujBwRN6F5omO
         tqQXiIII85WjZVKM5V2aCmHE1QqUwCdCVXvTrzybW79TRV5mPtdIeOxGolLX5mBzMLNg
         Fs/hcqI5XX0f0rbWNZOb1JDSIdS2GeDNiZllPwtooNHbBC1LIRyPC/hBvTspYH/Bgacz
         UMf9NEOcHtyiJvpCBGxhSX2w0/jRZmqSMQg4ZKdvNvbiyBc8Aym7e8oWD832DoN4FCQn
         TTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574517; x=1781179317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03+Qa9RGrwe/KYIyq7vOdduMenMTTw8VAMY6ULVuEt8=;
        b=MXNGkZKr+zpL+YOnOI1cTsMg7IHxy2BnJN1yqv3yKKPxRGBEbNo2NKPHmEtsC4L5rR
         jlzqQUuPZAYFnzwvZOHUsL7eW10D4zCykfw6d3njY+vvDf0vF1V1vExP1hgenM2fWgyD
         ka9LPIjvzDy2jxnyBvYxJYxAUkuvnX6hSjqbyFvn+MqmJOz8HYXwfs4/YvapjxWFoNl+
         y3ZTbLh/mhV2p0fI12B4buq64v6FkRVMIaNnMksDSHl194v1zfQZmtijfSxed0l1Prdw
         EaMv8pixxHRDB5JG7d0welukftq4RaUGSkVMQIypQw/yEj3CpUHJv2tCuOWoWEuvlEnm
         W+1w==
X-Forwarded-Encrypted: i=1; AFNElJ9dJhbaLy4L9mNDpAEJI3TR5VA45ZFcm98yIvvcGQOOtfpgI3+JJ51s0liM0xYxZiOWax+zang=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDjSlu0gVc3+iM/FLGCWvrarZQPp8KU/eys/UGn1ZqqNDc6Yp
	XAyCV4zZET0iovk44A/4NrZo1bEnQ1F/N/piaZ4kK6iLVbJQBlyEkg/s
X-Gm-Gg: Acq92OGrpBRmBlQdaX4YUySfi4XA2Pof6TNn5W4KMOzdZeumP5wjYEoQjuurisaxiLV
	0RzoSorN/0ldNhgni0VI3BnaXlGcCbT9EwhTPv4lIOvXmVLPVPjBMXHsay5gMP88626pi0HNOLn
	ZY8Wu+ll1kIYZLH9K5XsK/bq47PCRhdhtsCBtrRCKfMITQ4w9JHyMJ/SVVMdasXyCKR/oYWLNPL
	NgZXzb9B1M5WxPHixj0sIloIyHb+jILEO9DnrdT9NSV+mkN9ir3kr63y4YVzEfNoE0+8o7+I6ez
	KsIJvqLBJgie+Unydy9wrxryvetIki8mMWYZpOxFrLM6WGw8dSt4CVyLLAaAD2Izwus4kEZ8BxP
	C2dNU0bYfwqNI/JptrNHWSUK7IXecwPVOQFOrSsQKG3HaVhhAtxyoaoAnkVbdfnhmVJa09FScRD
	bFjpxpXRERTJswp8tWI3BXcqWqaNPkhKSqqQo1KFezDI0NEe6wIdNGLgyW0e9cDeLnxtCyPXmrT
	w9nzYvawj0FffPXIqGkoSRwyNLByKnj+B6SHbmnQdbG5ac=
X-Received: by 2002:a05:600c:1381:b0:490:a1be:6b01 with SMTP id 5b1f17b1804b1-490b5e64659mr127812455e9.4.1780574516866;
        Thu, 04 Jun 2026 05:01:56 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-431e-bc70-7e83-7368.ip6.access.telenet.be. [2a02:1810:cd14:9200:431e:bc70:7e83:7368])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm77839325e9.1.2026.06.04.05.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:01:56 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:01:40 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb
 pcp app
Message-ID: <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wq2elxqwrucf:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7789363FBD4

On Thu, Jun 04, 2026 at 08:37:17PM +1000, Luke Howard wrote:
> I still need to find a similarly natural way to expose the switch’s AVB capabilities / 802.1Qat admission control. Perhaps there is none and it will need to remain a local patch.

There's a devlink port param command. I've been wondering if this could be used
to set a port's AvbMode. However:
* at the moment there are no drivers supporting this.
  eg. devlink_nl_port_param_set_doit and other return this isn't supported
* i don't know if AvbMode is a valid use for devlink port param, and if it
  would get accepted

Cedric

