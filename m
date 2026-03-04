Return-Path: <netdev+bounces-263834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIneIPVIqGnysQAAu9opvQ
	(envelope-from <netdev+bounces-263834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:00:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBC2021D2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C7C31A419F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486043B3C10;
	Wed,  4 Mar 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX68Q39j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DA39FCCB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635949; cv=none; b=eoZ3ytiltoe7aL82wO5deChLPoDtzJXZr4K/pkXelIKmHye7X0M2ZPOw0PBkqxZzc/b0hL5Z3EqEneisPtWUtGgVqTHPmQu/7e8TPC8SYKgikE4nRRKY7V8Usp0A1Qw8Bu/bGJke/XGnqPpOwDn0efTO0KsVVRg/H5sLpUKLdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635949; c=relaxed/simple;
	bh=z6uT7O+CT8FhEGZthzxAia7oQbmDcyMrk6r/+n+jDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LijphYt6Sr/tgwPDeE/bg6PjfqNBgnQEEuQTXPB/pf9USyrEgRZsvfInwvwE7bZJzKgEKs0rjp+7GJUA73hpfD5Cx50w6UQw7KEGFBEYggsA3HnuU3RSE/G9CPmrQ/vd8Ta+ZoSa6NfPiZYyh9KBRCQmkB621on+rsL8MWT4DDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX68Q39j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439acc60f9dso433051f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772635945; x=1773240745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhKHc0NTgAalEfYn0byG9UfswGgGUZojG8TrMIMwxKI=;
        b=RX68Q39jCrmG0QNGZVhS7jsmSC+3mzGFheii5mRCL81QOfkQjjhO/y006Ehp+fJSX4
         88yebQK55s3+gE2bOOPdr/qR+Vw1lKRpiXeTdsnnshX/QU8xI61MNFVBCN5phlLql4tS
         K+tSnp/e7nM6f//y7/Ngz6H+4+tMsVJoPYb2cXMSv8F//RE1isIyVDdVSrzxxQ9/lorh
         z0IX2xP/xuTIzGqD7RhkB1kLmIiEgXMjp218ydW/6lvOelZumJ9foGbz3wOhOrwgwHan
         i45/k9DVFGmAeBrlNAnD+r/8uI7AxpYGKqcevBXQfB99oio/wDjlQDh9rHK2bicUK9Ee
         ipcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772635945; x=1773240745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhKHc0NTgAalEfYn0byG9UfswGgGUZojG8TrMIMwxKI=;
        b=wyuIECxHIETWUI0lXgBj4TBjWLK6dWugPzBknzYRBdmbuHdbW8axhYL9XIvbk6cmEo
         qA3mluca1jg6FNPSC5rUsuqCeCjpoWSJHn09iqpovBq5i06Y9kJCG/IpaapXI8KowPqr
         alwZ1eo8idWIVTqphooFLHOCfUFopy+LrzrA2HzGqjFxBLNmJt47VXiZysnhIyjqXlTf
         G3We6q53bY/6NnDhPWbmRiip6gKA2lN0tC7t+oPuY+Bnnq4aIiUM1eK16dhL7c/iVM5S
         MX/tRMkE6zFqm1wJgFQjWnMkYajhaa+XUZCb/yX0jtkYOM+bEJzgTsGvGZeAJnBm2357
         hhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu1KIkyP+h3oAdpozMKMlyUJ1aM/ik4zC+nq7l0rvx1W1++xA5INdcgUCgMv2lXV0iTE20lbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhXuVsZjeNTf1a5YFUCbIQkR6SMzpjEMkbfW2g0lp6cNLLR/+
	XgYV4/uaa7xxLvjxnjCyycnHV7W33Nj639lUo2yhyHXVBvz96Q7KtBrk
X-Gm-Gg: ATEYQzxhF6fEPlbIKfJHDvama1WlNxDc7eWfa5DZfAxiiKdmgBG9IpdpkzMG8UcBzUs
	qrF4Et2fqcwJQWwIYOCmmUhu1TyUBzigp2F4RyRr3IHGP38Ew24EdD+5hXL+f4mgvfZQIBIPT/7
	CWI34CTPgLBFebxx3KTk3+dLX9BhVELqSmlRIBi5ylBs9VfJS4gWdOa0ZhX8QMUj92hgEYXxNAS
	WrzAgJ+RRbH1/IZJcCKJhBgZ7NWzWZ1UbL75sAgz91mmVoOBKAZKXhBB5a9PBRhhYq5hn3d0nWW
	AT9xsf5n7RdW4PJZtAwwhH9zcm5Ejnh0/fcpg8LVxWzNKZ9vgPC6unuHuOiYcUw31dwNgQYH3h7
	M9kzPLOLCV2gdlnxqhjRnNW1OYgmAxodBLpjVRsYL57f++HNlUqWp3/XDSLkjYhtD5N+1uLYTNk
	gZBpaOTPjVf871nEU=
X-Received: by 2002:a05:6000:288f:b0:439:b7c9:2efc with SMTP id ffacd0b85a97d-439c7fe0339mr2393701f8f.3.1772635945098;
        Wed, 04 Mar 2026 06:52:25 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:3896:e6f1:29a3:961b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4d06c27sm23295313f8f.17.2026.03.04.06.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:52:23 -0800 (PST)
Date: Wed, 4 Mar 2026 16:52:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/8] net: dsa: lan9645x: add vlan support
Message-ID: <20260304145221.ae3bxf5dh2v4itsx@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
 <20260303145955.s4kjiwjv6ahn6zph@skbuf>
 <e30d9e84ac37142c26af35b6e589fdd23157aa35.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30d9e84ac37142c26af35b6e589fdd23157aa35.camel@microchip.com>
X-Rspamd-Queue-Id: BFBBC2021D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263834-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_aware.sh:url,microchip.com:email,bridge_vlan_change_awareness.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bridge_vlan_unaware.sh:url,bridge_vlan_mcast.sh:url]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:40:30PM +0100, Jens Emil Schulz Ostergaard wrote:
> On Tue, 2026-03-03 at 16:59 +0200, Vladimir Oltean wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, Mar 03, 2026 at 01:22:32PM +0100, Jens Emil Schulz Østergaard wrote:
> > > Add support for vlanaware bridge. We reserve vid 4095 for standalone
> > > mode, to implement fdb-isolation. An vlan-unaware bridge uses vid 0.
> > > 
> > > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > > Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> > > ---
> > 
> > Have you run these from tools/testing/selftests/net/forwarding/? It
> > would help to know where to look closer for potential problems.
> > 
> > bridge_vlan_aware.sh
> > bridge_vlan_change_awareness.sh
> > bridge_vlan_mcast.sh
> > bridge_vlan_unaware.sh
> 
> No I have not run the selftests, only our own test setup. I will get these
> up and running.
> 
> Thanks,
> Emil

OK.

There are multiple ways to do that. What I tend to do is transfer the
entire selftests folder, then cd selftests/drivers/net/dsa/ and run the
selftests symlinked there with ./ from the current folder. Doing this
inherits the forwarding.config which makes DSA run well with those tests.

