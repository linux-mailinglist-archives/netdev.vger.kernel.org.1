Return-Path: <netdev+bounces-293251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEzZGA72GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:24:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80A06087E5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B12631741A1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18D42DFE8;
	Fri, 29 May 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGVzRaTn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jwPPooFL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7F426ECF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085062; cv=none; b=bNjiyfPXytBR7fYNjWhlCDu3o55uJtD0C7PvOrJvSDfK1FVl45Kp5ln0dllShQUZ5Jkj8oLfS5GLoKP5NoBWtSvnsTFkS3Fy7LcD7iTBZSwj6PsnbXXDn4EOVJw11rBhZBSdVbe7ALXNtT2vYqdOO1RYO2npfT91+Yjce0H0fcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085062; c=relaxed/simple;
	bh=19te2L4R7X9KgHW/okJn55tkovMnD2HKiqsXZmxnaUg=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=h4IHUZJmprBVudZOrmiFD47S0g6pYCCgvBPOkXE/QBNLYq6Z02XdN0MhMIUWzgHe0ggDQjuzc+1MQ+f646TEyGKqtbu77et4af3bnaGafP4EV5PqgOkG/Ed17W/8TRK+9tt0vwDoxXZNCiMYR1P1nd/H0RXVfSiRcH3+C+MFy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGVzRaTn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jwPPooFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780085060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKdte5oW96Gd0xHHGygvAJsrAnMBrUSbmKf7IApKNk0=;
	b=LGVzRaTnTyIIMxm3o+7JoqKdRQuM/d02o0ZT9BxLgorEBpDWkqanWS7Y86qg3z0qhu45qH
	uNfWOXeG1RWIEQ4rwTExkMxZe4oAln6GcMK5ozOs0APwNbOJKgdnFB2ER9tECCg032pRu0
	Lc67z7wr9VI5B/gCkerqMSdlP54tl8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-rtYVHIgrO-amN3YnroaDAw-1; Fri, 29 May 2026 16:04:19 -0400
X-MC-Unique: rtYVHIgrO-amN3YnroaDAw-1
X-Mimecast-MFC-AGG-ID: rtYVHIgrO-amN3YnroaDAw_1780085058
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso89040795e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780085057; x=1780689857; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKdte5oW96Gd0xHHGygvAJsrAnMBrUSbmKf7IApKNk0=;
        b=jwPPooFL5bn99N+eH2ye0zg/PJQSRZE30B983XJ03fmYvOUqI6z7CgpTaWoNkHOoCy
         KRHzDwIQ7q8fG944njAz22wzOoqgKchd4RUWUu7aOC9gzDQka/JBLeEkaA+zix87mozw
         EGgHivVjMCZJwCsz8kUOoLYntUhaxiM8upthSVWKZAcgtJ2dju87IL+noH5L8bKFS8Oe
         rX92AdeCaWgRedkqB5jv8PudrtGxLiehCEUXO9MaESdUKFLw0f2631dQ42Fv0oYpTU2E
         JRrrBaB3lc2hh+lYngeJ0pd5ExwTQniDRS5XeLMYUggOqJ+zexVHbZbgARBUnfjulRQg
         j9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085057; x=1780689857;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKdte5oW96Gd0xHHGygvAJsrAnMBrUSbmKf7IApKNk0=;
        b=lI1ctxHRUraOnfuE059hEJ/dNO9FN/LssoMrbJOOKlimyBD6Z3ETvG3VsrTrPcNUVG
         px4fFWdSDu8n1rF2a93V/Km2/+9/QQeBSZ8NttHR21irdIBWrlszGfBfVFRUWvDLWa6T
         m26RJPOfc3ip7F/iwx0H8+t7UDd5Zgm6sv0pAhpiZt4PAiVvUwd8WtN+ryrBxNXZdCG8
         RbLAtGqcdpGWkEiU029ds/S+++VWDcQfBZSfWvEXO8CA+111/gVlJdG/O0Fb5mNVV8XT
         vYgrxwB6TbIhkfEV/NLAdMk4ZlMJSXnUiwD9TjdawwM3LnpKmQw73X84ae03f23XWUHd
         EMGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MZ41EHp0jyc9fYbLLzQZjmBxMru4HadPIsGdEKPTJZIviPQAhmWDGP5SHjuCUp8E4LgvvDGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8usXk5pLlJ+ABdUn78sZ8sj6sMXmlcuEuxFJC+L/9aVqGlsp
	NgJjxg19nD7IjECbyGS42qRk6LBKcnfdFDxEDNQmHjO6nCsKQOO9hrylXT1uTIMTuu863d+qezG
	0J6wqxluifj+XRfyN78tE1O2wEyZPZ3IMtOv3na+kCoI2jRLb5v9Vo1znIw==
X-Gm-Gg: Acq92OFqbAUCsN+Fon+GACLE0P1fQvM7v3ZP/YM8Lfxb8lMowi4prXKgVu8vMI+AC97
	7X9N8qPCqDkpYhXut/MKkrZrJKohvXly5Ku6wBN017DpENAeGjEZ6UWWwYNJz5ABRM1ZA1DcFEb
	U7EPbv75f4FgU5qwyDLteVtpSt5Zj7hxxssE1llh4X9DYG2d9Ff9WOhqMVMRMu4Ksmaw8lotWYf
	l/2Sbe/M38vMD3AdvkfsXnWYhA71S0+lRGWfTFyV1LCV/26w9P7rWsLg1xgORqlwd7WzCpG84jW
	wXx9L0nXY5pvFwhG9XZt6tkWb1wEJHwDvUCXmDFKQiwVCT46JVyAxkh0KQ8kqitf6fHB1UIRcu5
	/4ow3oCUEi8OFQY57cxF6kp6krEnh1s/ElEdZeT1f8fby4BIY1cCE/HXjCaHE
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr11562905e9.23.1780085057328;
        Fri, 29 May 2026 13:04:17 -0700 (PDT)
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr11562545e9.23.1780085056875;
        Fri, 29 May 2026 13:04:16 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef358c07bsm5968003f8f.36.2026.05.29.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:04:16 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Tj <tj.iam.tj@proton.me>
Cc: =?UTF-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260529220415.22d0be8d@elisabeth>
In-Reply-To: <ahnaz3ppxyVHl3xB@mail.iam.tj>
References: <ahnaz3ppxyVHl3xB@mail.iam.tj>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 29 May 2026 22:04:15 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,suse.de,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C80A06087E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 18:28:58 +0000
Tj <tj.iam.tj@proton.me> wrote:

> I believe I hit this on a router using Debian 13 with v7.0.* kernel this week that
> uses systemd-networkd to configure IPV6 RA and prefix delegation after
> moving from v6.19.*.
> 
> Symptom was the router could no longer reach public IPv6 addresses
> itself but forwarding was unaffected.
> 
> The ISP (Starlink) provides a /64 prefix via RA and a /56 via DHCPv6. networkd
> allocates a static suffix address from both to the WAN-side interface.
> 
> I discovered after much experimentation that instead of the usual /56
> address being the source it was choosing the /64 and failing.

Do you really mean an address configured as /56, or a /64 address that
systemd-networkd derives from a /56 delegated prefix?

Because more specific addresses / longest matching prefixes (RFC 6724
Section 5., Rule 8, implemented by ipv6_get_saddr_eval()) should anyway
be preferred as source addresses, regardless of the order of insertion
of addresses with the same scope.

I'm looking into possible assumptions made by systemd-networkd in this
case. *If* this is confirmed, I also start thinking that a revert and
exporting the correct implementation as non-default using a netlink
flag would be preferable. at this point.

> Router uses policy routing so my work-around was to add a rule so the
> /64 address is added to the WAN interface's route table.
> 
> [RoutingPolicyRule]
> To=::/0
> From=2a0d:3344:aaaa:bbbb::/64
> Priority=30100
> Table=starlink
> 
> The WAN interface config for  RA and PD is:
> 
> [IPv6AcceptRA]
> UseGateway=yes
> UseDNS=no
> UseDomains=no
> Token=static:::ff
> # when RouteTable is set a table name is explicitly required in any [Route] section without a Table= of its own
> # names defined in /etc/systemd/networkd.conf.d/51-RouteTable.conf as:  [Network] RouteTable=
> RouteTable=starlink
> 
> [DHCPv6]
> UseAddress=no
> UseDNS=no
> UseNTP=no
> UseHostname=no
> UseDomains=no
> UseDelegatedPrefix=yes
> PrefixDelegationHint=::/56
> ## asked for in RFE https://github.com/systemd/systemd/issues/31566
> ##RouteTable=starlink
> 
> [DHCPPrefixDelegation]
> Announce=false
> UplinkInterface=:self
> Assign=yes
> Token=static:::1
> SubnetId=0xff

-- 
Stefano


