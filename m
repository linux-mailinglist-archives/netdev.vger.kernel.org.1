Return-Path: <netdev+bounces-195323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B0ACF8B5
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C6D1795AC
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0B27C179;
	Thu,  5 Jun 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDa11dC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006C27C150;
	Thu,  5 Jun 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154850; cv=none; b=YkNfeRa5s3TYUCzDfraL0Wug+AKWJ1MMPnmVIOlHFLaTOhlpmw2WSI+9rIEHm1AmdGD9wJYWn/4tR+zNS9ENG/ws33ZEIJU2GXFtiJojtX11StckLXgqwJ9M71oz/SqdJVMHFqA55qUqZWVA8/gnAO6H+h9XA2bLDp8/KzBpLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154850; c=relaxed/simple;
	bh=r1utos8IHVUWPpcTEYj5oGYSf7pgmh3WfT8WkMKuzO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E83ISm4h/NCrWn3xZh4AYW43YXxn+QxQyS3KoJCZmcJF/BnnLlUm3PNCiFy82VRJbrn2F+kL8BWMSUm4pNPaGsbtTcrBRKTU7AR+4o8AOpRBDHtHDL6OdMsxnILzeOtA9YQ6Fe9oQ/1EOWEPjvaXWLUVhMkBtBXeUQvPkT5mbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDa11dC5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad87fec4400so21627066b.1;
        Thu, 05 Jun 2025 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749154847; x=1749759647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOf6kMkJBMv/kxUwMYAvC6No+wYBD2t+/55N4SZuCQA=;
        b=JDa11dC5kjCHUZSikzG31PL1YRcZ5PgPfcB8rcSMu8+Vg0P57Wj60RuFkNZ0yXS09w
         JVYyH5bjZlD93vSfc4HjEVOTqXVQIHFFbUlEHf2TrgL3TPCwS0AaXGFwt4iOHDkFTCPr
         /SZ29ugZUOfW+d2Ns895sQCw/JihUbQzgm5ZVQ1ak7eKU0Flo5UJHe7WJ1jClJf3ez2i
         qKIoPhMWcvPkvUnZ3Ry320llSpmx92C76cPuBEjiANh8yQD8hmiTodL7ukRaE6uCxPS4
         7RLx4PAeqWrxDQYt0N/tYziHL4xByK1OyzCHuys4GigIu8iMlGmlbeMsKh0JzZzE8Q1T
         0bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749154847; x=1749759647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOf6kMkJBMv/kxUwMYAvC6No+wYBD2t+/55N4SZuCQA=;
        b=SyNl1DxE+WmCHBvCzm/Hn4zoM6mhfjFfnkCTnupr81TroqTSAWBv/v97ceixKKbmjp
         iDuspn0MYiFWvvfCrlx+wAJnh18358Q8ZpGgudJjT4AYsPGdkHqO6Z8jimjMOnKZ/Ngv
         KLMAdbZ3+gAdQ6UFtTPAOfIUVmy9jCo2BHcshkfv4w/u2zGDNqXcobcn+NLio7afCzHI
         qbVw3cMiscRVOphQjPdWBNuPuXD6w/eNE1EVk6rO8aQ9sMT7nxWIen3P6cklBgPOcBD3
         sFasdmz9loQIcEyNy2J090nPYjHdY07k77kOm3Xsm6gJefHBqXPexaXiQSdcdO10DSun
         uNWg==
X-Forwarded-Encrypted: i=1; AJvYcCV3cHpg/vhYLSBw2Fxc8S49b4QOBIOSc8wyD7WfDjrGjy0UJWCnDhrpZYfjZQCMvSMQiG/RygUohU85P/0=@vger.kernel.org, AJvYcCWd5UDnj3kOa2OF6M0c/TTfCNO1sLWtrQ8OpKehrzY9RIyQeMeyVYPP0G1hfgS6NHr50JUl94LW@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOWtI2/dvhNETthN5ZkDO4s/NJ41aEGfg2EZmFrajYVEe1DmH
	NDfQzIODw36WnWbE3ywCu+pryEc+Qmu46wr1KEPS6zc8DiGGUH0JC+Gw
X-Gm-Gg: ASbGnctqU3odNXAemdZMRmzady6XHWO6QmAesIByh8GN9qG659j4b/8b+qudm08Of9n
	4TIgHrYEQzhEUPuoOWRy+ZP/gbaJweCkm4xpy75UvIE5tXthsyOEfR3DSa45MBdaZfJyZ7T835m
	dODND3o2ijgomGjRsPp9bOZa7qdr7a/bNz/edlGu3K+c2asKYncMC6H18jmmuOlL4W9ebwE+K/E
	cImcO3M2e8C84zAujyHS3U4+/GBtiQYsQfSORNXoYgFK5WZKUzbno1M7cAdgyt0vfshrOubyY25
	SGsHYUPdCXvI3LoGKGcIDscUqsaQfXdxX3WlExr/qWAGE8RDlQ==
X-Google-Smtp-Source: AGHT+IG1rF0vK+81PB6gHlhmZyzr6XShnt5ZbsRu+W2TX9OAKnZ16UeydPdB8eGaw5MVCH1Bd7hU6A==
X-Received: by 2002:a17:906:590b:b0:add:fa4e:8a57 with SMTP id a640c23a62f3a-ade1a9abadbmr14972566b.9.1749154846506;
        Thu, 05 Jun 2025 13:20:46 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c7a0sm5095566b.82.2025.06.05.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 13:20:45 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:20:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu
 tagged with VID 0
Message-ID: <20250605202043.ivkjlwtvzi6jqhqx@skbuf>
References: <20250602194914.1011890-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602194914.1011890-1-jonas.gorski@gmail.com>

Hi Jonas,

On Mon, Jun 02, 2025 at 09:49:14PM +0200, Jonas Gorski wrote:
> When Linux sends out untagged traffic from a port, it will enter the CPU
> port without any VLAN tag, even if the port is a member of a vlan
> filtering bridge with a PVID egress untagged VLAN.
> 
> This makes the CPU port's PVID take effect, and the PVID's VLAN
> table entry controls if the packet will be tagged on egress.
> 
> Since commit 45e9d59d3950 ("net: dsa: b53: do not allow to configure
> VLAN 0") we remove bridged ports from VLAN 0 when joining or leaving a
> VLAN aware bridge. But we also clear the untagged bit, causing untagged
> traffic from the controller to become tagged with VID 0 (and priority
> 0).
> 
> Fix this by not touching the untagged map of VLAN 0. Additionally,
> always keep the CPU port as a member, as the untag map is only effective
> as long as there is at least one member, and we would remove it when
> bridging all ports and leaving no standalone ports.
> 
> Since Linux (and the switch) treats VLAN 0 tagged traffic like untagged,
> the actual impact of this is rather low, but this also prevented earlier
> detection of the issue.
> 
> Fixes: 45e9d59d3950 ("net: dsa: b53: do not allow to configure VLAN 0")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

However, this situation triggered a bell in my mind. But it looks like
I am about to open a can of worms, so I don't expect that to gate this
patch.

In the configuration below, what will the packet look like on the wire?

$ ip link add br0 type bridge vlan_filtering 1 && ip link set br0 up
$ ip link set lan1 master br0 && ip link set lan1 up
$ bridge vlan add dev br0 vid 2 pvid untagged self
$ bridge vlan add dev lan1 vid 2
$ mausezahn br0 -t ip -b 00:01:02:03:04:05 -c 1 -p 1480

Testing both on sja1105, as well as on veth using software bridging, the
answer should be "tagged with VID 2". However, you make it sounds like
the answer on b53 is "untagged".

Depending on the answer, I can try to make some suggestions what to do
about this.

