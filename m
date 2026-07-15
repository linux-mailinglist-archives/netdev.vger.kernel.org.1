Return-Path: <netdev+bounces-307739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 60KzAIp6V2q3OwEAu9opvQ
	(envelope-from <netdev+bounces-307739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F875E029
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=CWW3iAbn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307739-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3586C301F841
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67444C641;
	Wed, 15 Jul 2026 12:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D244C67B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117099; cv=none; b=sYguZUIzBsEcmXyDdofEKsSKqqxZPzDu4Zqebr2Uwn+qpUEk8N58tsc/HrgKaPYPo8rVHHL1T1JR0m9LsMnR1qaVEibtBFAXbY07U5ip/IzXN8Ayl7MnukJ/yXMLyuoKQOyxE+A0vANvldy0yn4xa3q2At4mRypAG0lhP3CEf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117099; c=relaxed/simple;
	bh=BQgS4PSc6iKWPRdiaBG9tqPO+qRoWiapAQs3fO1eUUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8pnmDqYgnAqGZE0SozF78m+BM0VQs5ZnKRvZBszmXKdm2vB3JpUhtfdYAmaL7EwBidkCZ27YgZqVXT0sjv7XgBCl+SYrKUjF5xbMpUcockOvdIIPAQfZzvXiR2pxxdnhqckvz6+AcZzIMgTXtw6Y0qDFf065zSYftxdnddjmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CWW3iAbn; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4223F3F281
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784117091;
	bh=+z+RzjMGuQ/YSdTKVlvqpqDBNtM7z+VQSzpuoiUHP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=CWW3iAbn8bp3UeYqlftDMXC76PRH9qyZw2bihjOoexP3WdLAG5ZcSBXDHZu19A/85
	 D3+9tZZ9L5n07agzwhqmMZgvtd7N6hL6HY1ciR48OweLxBvxAYnedyfBOXiT5UyLBL
	 D93cpxg9fDRytEI5Af0f71c8YxXa8zqFBq+pB9NJ3+x5yH9cQ1/8MUWLWvXVHRp1hx
	 lA5GMwdsGJWpT7aUAA99GZwmxrlbR8ydYDSRkzwnpbxsgFa+PIbOWKzm0HGFuT3aTY
	 ldFAwOcZRm9XmV0LDpK0N1qZ3k0gzwWQrTUF0AZgE3ry1rRMrU6n/xqYca6+msb6sC
	 HSbSglVc7Tkvz5hIevUmp689SMsa+la/31oo36BezXer0i/vKzr1l9cOE82fjT4NlY
	 fYyuNSDcQOn8L90CojAk1w+ALv0CEd3R8x4TlMIEFhxLYWicr7pMVqMNzMYy5Qi/ez
	 JXxAjwHiMoxGa7D0PxpOEWRCXISlhX/o71Tf0ExQcJmFdHRGm0sjl27ys/wzEUHUcd
	 RMu3dg2b9Op1h6ojwms4nudkn1WEgJ9rc1OzppW0q7FFSsp90a6NjhjEfJkB+/K4U9
	 Atwx/53Z7atU3rNGNFlHO+j/QjUSu2Cd1Nabt8PtWcgAnsViLkRI2wycvqDirkNZvo
	 sbB6e4EE83BtF1ij97U/j3zk=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b21b1fe8so18066595e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117091; x=1784721891;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+z+RzjMGuQ/YSdTKVlvqpqDBNtM7z+VQSzpuoiUHP8w=;
        b=Z7i/sg5xqJX/mjVB9QF+vOqEVUO9Mb+OhwQjwYcdDzmazaD1O21Buy/STErvphVXsm
         1ISMHuXTdGbxiG1yUZC4xu7LUCCXEUr9cdbJ+/YHq7i9RF94mtJPjxDRYOlymJNYauCi
         yvZOAneRC42ScWr5488q0mOgZNqf5nFV4cy3hzIGIWYd54GoI51HcL9gcdTwMwVRKRok
         ZkYwIQa9mO9KPgq+S8KrtU9iWIZHVsQ+yReF23oUOYjlfZ7okyROW7sKn5QSa28YbiRp
         esvrSdVlXzJtvkglpZLCD/qbOPdAjLBpgeMgX8ydBU4rJwIqkEp50bCJ9Y/dGnTbmFBv
         zBWg==
X-Gm-Message-State: AOJu0YxnkMNbRmHGh3igsZVGe9v9bIgyQpviRdtmpw3KGSo1IMl7Sv9U
	D+LMcCI+bGywXMI70Z89YGIrFVUzwHVKumQV7RfNZXhEY1UEwlEcPk1vQT5/RX95ZtQvvwVqkp8
	H112bYVn18ITT1BiL0RupF9K3njp2FjsPXHcRHq9cYY+FTqSlZoXP0Ltkb6GE6RuoG5P5XSFKkw
	==
X-Gm-Gg: AfdE7cnT2v7xiyTVh8DR2uXPv6hXnEcZsvR5HgSp5bcTPQAF5wj9UrWVazb+BNbKRFP
	3tVZ9+SdKkr2WqA9lprA7e3kvV3jbPlI3ZtRrVCvTxAWnej2u6aIYTrvIyUF+JHM4I8Y0QNMLoD
	6G2grlls3dSiE+xl0dqULiGFWYaJkvU4VPK30KTyUxL1YnWhFBzx9duzAuBCT0e/GDclGgCptc4
	9vhrjev8qsp3PrX3vKZv/K/zft+clwXBmc5DMR+WFG0YPHzyIsfPAe6ApQLHDHsZQFHWYsfbLrW
	Wai0LJrO/tNeJP23fsapwRCsfI9r1c693nrPD2JSqFBG7pmX1AcrA4KKv+zFoxc7BSNFaYsMtHl
	oWzVPRZaBZAdXwTeZIIEw2GJdUjwFRoj57dIfYBYzo+i93wHavJf1qKYufyasFB54U0LpJ4ri8+
	+tUeqrmw==
X-Received: by 2002:a05:600c:638f:b0:493:bb0:3b43 with SMTP id 5b1f17b1804b1-493f87d8aa2mr189149335e9.2.1784117090836;
        Wed, 15 Jul 2026 05:04:50 -0700 (PDT)
X-Received: by 2002:a05:600c:638f:b0:493:bb0:3b43 with SMTP id 5b1f17b1804b1-493f87d8aa2mr189149035e9.2.1784117090415;
        Wed, 15 Jul 2026 05:04:50 -0700 (PDT)
Received: from localhost (93-40-66-109.ip37.fastwebnet.it. [93.40.66.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950873270esm142818155e9.6.2026.07.15.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:04:49 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:04:48 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net-next v2] selftests/net: Skip
 srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Message-ID: <ald3YDcHxtoR4B95@cicciput>
References: <20260713095750.2671173-1-alessio.faina@canonical.com>
 <20260715111530.fc982bdd10eb499cef8e9196@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715111530.fc982bdd10eb499cef8e9196@uniroma2.it>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:po-hsu.lin@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:stefano.salsano@uniroma2.it,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:from_mime,canonical.com:email,canonical.com:dkim,urldefense.com:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cicciput:mid,srv6_end_dt46_l3vpn_test.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E35F875E029

On Wed, Jul 15, 2026 at 11:15:30AM +0200, Andrea Mayer wrote:
> On Mon, 13 Jul 2026 11:57:50 +0200
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> > In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
> > the End.DT46 support is not available and the host_vpn_tests test contained
> > in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
> > This is the result of those tests:
> > 
> > ################################################################################
> > TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
> > ################################################################################
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> > 
> > To amend this, check the current running iproute2 supports the required
> > feature and, if not, just skip the test to avoid a failure.
> > 
> > 
> > Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
> 
> 
> Hi Alessio,
> 
> Thanks for the v2, the code looks good to me.
> 
> One question: since the check now exits the entire script before setup(),
> should the subject drop the "::host_vpn_tests" part?
> 
> just a nit: test_iproute2_supp_or_ksft_skip() uses spaces, but most of this
> file uses tabs.
> 
> Ciao
> Andrea
> 
> > ---
> > v2: 
> > 	- skip entire test suite if iproute2 is too old
> > v1: https://urldefense.com/v3/__https://lore.kernel.org/netdev/20260708152745.2430714-1-alessio.faina@canonical.com/__;!!O5Bi4QcV!CGb1HmTUSZ4JwCff0mVcoY_KnoHJmrGDAdGnPOEYWRVFi-J05H-ZtpLVZBNK12kwLaNmhzw7mrQw4M_eY5uuSft8PRuFHqU$ 
> > 
> >  .../testing/selftests/net/srv6_end_dt46_l3vpn_test.sh  | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > index a5e959a080bb..cd7ac03e3907 100755
> > --- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > +++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > @@ -536,6 +536,14 @@ host_vpn_isolation_tests()
> >  	done
> >  }
> >  
> > +test_iproute2_supp_or_ksft_skip()
> > +{
> > +        if ! ip route add help 2>&1 | grep -qo "End.DT46"; then
> > +                echo "SKIP: Missing SRv6 End.DT46 support in iproute2"
> > +                exit "${ksft_skip}"
> > +        fi
> > +}
> > +
> >  if [ "$(id -u)" -ne 0 ];then
> >  	echo "SKIP: Need root privileges"
> >  	exit $ksft_skip
> > @@ -546,6 +554,8 @@ if [ ! -x "$(command -v ip)" ]; then
> >  	exit $ksft_skip
> >  fi
> >  
> > +test_iproute2_supp_or_ksft_skip
> > +
> >  modprobe vrf &>/dev/null
> >  if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
> >          echo "SKIP: vrf sysctl does not exist"
> > -- 
> > 2.43.0
> > 

Hi Andrea,

Yeah, I agree with you, the subject should be updated as well, I didn't
think about it. I will update the subject and the indentation in a V3
soon.

Kind regards,
    -Alessio

