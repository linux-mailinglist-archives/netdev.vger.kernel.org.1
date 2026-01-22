Return-Path: <netdev+bounces-252540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CNhG4OXcmnBmwAAu9opvQ
	(envelope-from <netdev+bounces-252540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A637B6DC8D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF4D3300C7C2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B033904FC;
	Thu, 22 Jan 2026 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGjdK4a5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2D3B4C84
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117551; cv=none; b=BUDkABnh4AFl++0zRVafY1nErryCSowfnB7sXK40/WMleepfnXiBJ0I0Yc7WAMrzISfeIqnY6qThtEYeVt2VGr26XaiTw9x5jv2IWxBZnNLQOagt2D8pflR1H8OntUK8yTOsoyzEkcXDAb0CvKACQGAYXSPBPn+RBZ+VOF6imws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117551; c=relaxed/simple;
	bh=v0P96Z0aRmf4q0S4zq2JgoGYTQnkEs7zQqmXU6ar3HE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2V7zCEqqnX7azJhUjGE8ahv9CXDK84vb2qzISHpi2WhMwY9oLaH+gx4QiRJbJL2yJOblPmZVygGE6LSSW2qAgIOjPT3+xgL3xgpMXql89rQM7q3tH2WQOohDHDD8kwTQzIhdcZb5EgNZXck0A0fteqnvE6pV8IjBa5H6dyRQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGjdK4a5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769117540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLjsVSVWp5TxJT1pf9TFdMJsBUtHxxrgfqSXsvcsR5I=;
	b=dGjdK4a51auOfxeYqCAH10gjizhFeMIzp7O8m4jqGYFNirm8LjWzJMj+ZAWVVkp95ulpJ8
	SrcksRm1zRbk1Sn6gXwArzIvIVQdvdpPf/e91RLNJZFxcgBBgiM4pNFhdhe4XcISkok4Dy
	glwuTj6UvgnuvO+PA4gZnZ2m2LdkKOo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-qTfaNDFsOH6O-dzcd-SG5Q-1; Thu,
 22 Jan 2026 16:32:15 -0500
X-MC-Unique: qTfaNDFsOH6O-dzcd-SG5Q-1
X-Mimecast-MFC-AGG-ID: qTfaNDFsOH6O-dzcd-SG5Q_1769117534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B63918005B7;
	Thu, 22 Jan 2026 21:32:14 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.171])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E18331956095;
	Thu, 22 Jan 2026 21:32:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests: net: make ovs-dpctl.py fail when
 pyroute2 is unsupported
In-Reply-To: <20260120230558.328423-3-aleksey.oladko@virtuozzo.com> (Aleksei
	Oladko's message of "Tue, 20 Jan 2026 23:05:55 +0000")
References: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
	<20260120230558.328423-3-aleksey.oladko@virtuozzo.com>
Date: Thu, 22 Jan 2026 16:32:10 -0500
Message-ID: <f7tzf65uyed.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252540-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,pmtu.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtuozzo.com:email]
X-Rspamd-Queue-Id: A637B6DC8D
X-Rspamd-Action: no action

Hi Aleksei,

Aleksei Oladko <aleksey.oladko@virtuozzo.com> writes:

> The pmtu.sh kselftest configures OVS using ovs-dpctl.py and falls back
> to ovs-vsctl only when ovs-dpctl.py fails. However, ovs-dpctl.py exits
> with a success status when the installed pyroute2 package version is
> lower than 0.6, even though the OVS datapath is not configured.
>
> As a result, pmtu.sh assumes that the setup was successful and
> continues running the test, which later fails due to the missing
> OVS configuration.
>
> Fix the exit code handling in ovs-dpctl.py so that pmtu.sh can detect
> that the setup did not complete successfully and fall back to
> ovs-vsctl.
>
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---

You should also include the fixes line when you post another version:

92e37f20f20a ("selftests: openvswitch: Add version check for pyroute2")

>  tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index b521e0dea506..848f61fdcee0 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -2583,7 +2583,7 @@ def main(argv):
>      prverscheck = pyroute2.__version__.split(".")
>      if int(prverscheck[0]) == 0 and int(prverscheck[1]) < 6:
>          print("Need to upgrade the python pyroute2 package to >= 0.6.")
> -        sys.exit(0)
> +        sys.exit(1)
>  
>      parser = argparse.ArgumentParser()
>      parser.add_argument(


