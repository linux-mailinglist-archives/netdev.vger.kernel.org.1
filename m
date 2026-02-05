Return-Path: <netdev+bounces-256910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJrIOSP8g2kXwgMAu9opvQ
	(envelope-from <netdev+bounces-256910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:10:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A7EDDFD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8861A300B10A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BA25CC74;
	Thu,  5 Feb 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVnudtFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14E25A64C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257342; cv=none; b=Zf9UbXrmMDlPxGkXmt17eZDhPeM8Yxnh7cQBgW3XRJVECsX3dTPK97IoOAfsjzTKCp2r7ChpZqXjoHAc35UcvRhgDBf1iMH8RaUUy2WafIuOWwOetEfFkPo1R90fAcYOxRHifp0nQYvnDkEsyLt/14kgiiom52P2UJy7qgiXp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257342; c=relaxed/simple;
	bh=tBzbkz8256Vih7pxqt0jVZhcy/cBPl5M+E4b7BEl88w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFqP8ePIsAgR9m8tlnGtRpsvev3eXN9CT+C45wRY5ZP2fgayG4qQxMIfrRNQnOJ5MjMPHiQnXNd0cAxZEGbF+Nd8fSGGOXC5Al/CVDW6zqxAHQAceMsYo/iPyI9aN5w0yZFdQ4FF8h0fMjokOTBm+hdgmaaz3S1IxMmfch7TMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVnudtFS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7950afac0ffso11392177b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770257341; x=1770862141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GxCia3YTkeFkXiAmt+I4fDEo9RUscZAHfRM1p4DBO4=;
        b=hVnudtFSC8tn0RChyKvz9/fK92rwtywiP+C5SsoNnRxekkmSe1HPPAd1QYKzjlOIZr
         TkmlcIPAcnMmr6LkY2my06vbfqzSCUvxxrGv0Rzg1PAGY4iTN9O+3KvYzIWMTuUfjnNU
         Sft4XcN/AuggoCcUwjRN1gKK2TZHJG8XXUaPGrzfo81WEPt2vmPwQUUu6ZPMl2p+n9oe
         IoZjfPlT0OB1VAEY7lc8BdCYt7eHCEPiC37me1GM0DuQ+AkyraaCfgrUOToGLTiNc4rb
         XzmQOQ40BkWN2PNmOXGCPcuT/xCdgUUmWPVG7I7fz/fZPKkx3+XRGMwb+9L+MyMTAWza
         SW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770257341; x=1770862141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GxCia3YTkeFkXiAmt+I4fDEo9RUscZAHfRM1p4DBO4=;
        b=QHY7+0QBYeHzsvCJ03NlsPKDJX/G+Rle1A6TIBV2Dy22vfNA3c0fech5gh+b1nLcGd
         3n/YVY8pICZhTeVdqm0PJD6wNfzvWw5NjysnN0AtIU2oaoDvhYrvBeKymz/bGWzmmMjT
         p5/Z2UJc3rpQmi3iWaZ+DYBE34I9tKofmIepRT0LeDFXCldxTKLkdCShPs9+r7BVG2nB
         LpTD1K1Dpoji3GpVonnxpO8mU63QJND7TjYUVG2vBVZUjdo3YKx5OtZwk8SMqDALk4BO
         AWyaBfrJwBrMJO4uMwtLeM2VOSMwPHWr8NJel1TrZbbGlKaz/eSnjo31kNmxR5ziwi8K
         Gs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSg16YNgs1INsUVwZR6jUwkcnybuWlZeq/0gNuqXK4uEKcNrGXf6gzY11Y1SbPBuOGrHbDWT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbaV0kaXblWcALpIXkgrkJ5gVfQ2QVjjoLCoqAs/apRPhOuefW
	RpNm7QRJn0XGTc2Lcb7+XOPsMIxPSSOIi5wfhLbowIoEjsFf0D2MycPK
X-Gm-Gg: AZuq6aJHIZjKPbD/diLR6XH4yQXj/AHw4rZbC4Dq0O74BFRPK52SnYZDyjAyoiwcoCr
	GcJnemY+KzkIqpzGDXMk+yJ3ylyzU4nXqNy9e/LxdbCL9i3FSMLDlWM9IDHhusc2zmNd75Ix/YZ
	X8tnKNUt+Qx+rs0kLQTuztbrRq83XfOSamGQxsiptX6Fy7EhTO+XJ/Ffr8GRk4cgR0QfXLswDuP
	awFLRVPAVEpqU80so8SRjk33v4IUMbLRLVjzz/s8SPY9Ml+UzsrFhVO7c68p6HghJ+C+viv/Dk2
	Hnwljkx82b8XDhg3RAodFO1puIIsL+Bw1Xjm73EXDnEZW8bTLKCLAPuT/eYDEOwkEMlMlavBglk
	80sC3uQlcXFoBk311PZsqXNPFX3joe7dtvVA3KPG25ybiUhf1Xh0WHjZB++9l01KjadN65/aUgk
	8VduRj/gbMIJ+7lysWoVerhNbQwM7MIn3iv2I=
X-Received: by 2002:a05:690e:118b:b0:649:d5f9:6770 with SMTP id 956f58d0204a3-649e871b6e9mr1257455d50.6.1770257340589;
        Wed, 04 Feb 2026 18:09:00 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc494810sm4033837d50.4.2026.02.04.18.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:09:00 -0800 (PST)
Date: Wed, 4 Feb 2026 18:08:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
	pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
	john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
Message-ID: <aYP7uiuPWAbJEgLD@devvm11784.nha0.facebook.com>
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
 <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,bytedance.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 498A7EDDFD
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:53:34AM +0900, David Wei wrote:
> On 2026-02-01 09:38, Jakub Kicinski wrote:
> > On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
> > > +class NetDrvContEnv(NetDrvEpEnv):
> > > +    """
> > > +    Class for an environment with a netkit pair setup for forwarding traffic
> > > +    between the physical interface and a network namespace.
> > 
> > A little diagram would be pretty awesome to have here, and perhaps copy
> > it to the README file too?
> 
> Sounds good, I'll add one. I forget how much you like ASCII diagrams.
> 
> > 
> > > +    """
> > > +
> > > +    def __init__(self, src_path, rxqueues=1, **kwargs):
> > > +        super().__init__(src_path, **kwargs)
> > > +
> > > +        self.require_ipver("6")
> > > +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
> > > +        if not local_prefix:
> > > +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
> > > +
> > > +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> > > +        self.ipv6_prefix = f"{local_prefix}::"
> > > +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
> > > +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
> > > +
> > > +        self.netns = None
> > > +        self._nk_host_ifname = None
> > > +        self._nk_guest_ifname = None
> > > +        self._tc_attached = False
> > > +        self._bpf_prog_pref = None
> > > +        self._bpf_prog_id = None
> > > +        self._init_ns_attached = False
> > 
> > I'm not a Python expert but the pre-init of variables that are set
> > later on in __init__() (on all possible paths) seems like a waste of LoC
> 
> It's so that exceptions thrown -> __del__() don't complain about
> undefined vars.
> 
> > 
> > > +
> > > +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
> > 
> > Would we be able to do this with YNL?
> > no big deal but always nice to avoid the dependency on very latest CLI
> 
> Hmm, I tried looking into this already. My understanding is that this
> can be done in C but not currently in YNL, not without adding a spec.
> 
> > 
> > > +        all_links = ip("-d link show", json=True)
> > > +        netkit_links = [link for link in all_links
> > > +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
> > > +                        and 'UP' not in link.get('flags', [])]
> > 
> > And of course if you use YNL you can actually ask Netlink to
> > echo back / return to you what interface it ended up creating.
> > No need for the scanning..
> > 
> > > +        if len(netkit_links) != 2:
> > > +            raise KsftSkipEx("Failed to create netkit pair")
> > > +
> > > +        netkit_links.sort(key=lambda x: x['ifindex'])
> > > +        self._nk_host_ifname = netkit_links[1]['ifname']
> > > +        self._nk_guest_ifname = netkit_links[0]['ifname']
> > > +        self.nk_host_ifindex = netkit_links[1]['ifindex']
> > > +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
> > > +
> > > +        self._setup_ns()
> > > +        self._attach_bpf()
> > 
> > > +    def _setup_ns(self):
> > > +        self.netns = NetNS()
> > > +        cmd("ip netns attach init 1")
> > > +        self._init_ns_attached = True
> > > +        ip("netns set init 0", ns=self.netns)
> > 
> > Hm, refactor class NetNSEnter or just use its enter method?
> 
> I did consider this but I didn't feel like it fit the very specific
> purpose of NetNSEnter. I needed the init ns to have a valid nsid from
> within the test netns, which I didn't think many other tests would need.
> 
> > 
> > > +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
> > > +        ip(f"link set dev {self._nk_host_ifname} up")
> > > +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
> > > +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
> > > +
> > > +        ip("link set lo up", ns=self.netns)
> > > +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
> > > +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
> > > +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
> > > +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
> > > +
> > > +    def _attach_bpf(self):
> > > +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
> > > +        if not bpf_obj.exists():
> > > +            raise KsftSkipEx("BPF prog not found")
> > > +
> > > +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
> > > +        self._tc_attached = True
> > > +
> > > +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
> > 
> > Don't we need to also add a qdisc if there isn't one already?
> 
> Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
> know anything about qdisc, though.

The ingress qdisc is the attachment point. I think we need
CONFIG_NET_SCH_INGRESS here too?

Best,
Bobby

