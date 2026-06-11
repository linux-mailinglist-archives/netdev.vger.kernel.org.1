Return-Path: <netdev+bounces-298259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGF0JW7zKmrAzwMAu9opvQ
	(envelope-from <netdev+bounces-298259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:42:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5D67418E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="J/nTNmGc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298259-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67080302E932
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0711DED63;
	Thu, 11 Jun 2026 17:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637802D94BA;
	Thu, 11 Jun 2026 17:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199673; cv=none; b=jnERQn9Egrft7DsLCZ3t3kZJqDUQBaggk0Q6zisnu2dcd4uedCxoj8et7SuaNztfpBuq8iTbrSLycvsLFoGHKFz+En5ToiiDGTUBxSn8Ip2XvbCv/y7AePShCmIaIg3QwI6sBEGOPpJiuleBtGE28cwZEF8+qOAYCm5PJnElENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199673; c=relaxed/simple;
	bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMszgXRVMk9VyNFPgaNuiLXzWFu2Wfgu1G9R6pX7OOG9VudG7uxk4cdGdZE0wDvTshJIF/eJyeTo+Qoiyx/cGaQmcOuiXwQb/qPJhLOxUeed1kLdOvTKGX1uBp70R6KsWvm04CUs/VbiS9CyXnX5chSvGDmVUNifDYhORCHqW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/nTNmGc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E61F00893;
	Thu, 11 Jun 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199672;
	bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J/nTNmGccMsABDlTrZ04xGfARU0xvILX58TUYB3dA9f2a6q5eibxWpSAERdfHx8jq
	 Fgf/eRyx3tSflBAn28Cw48+TP/7OJcfQSk07nT0+Kydb5/ifQcQZxF3mptkTTyNSFm
	 xu8oxnfc2QH8tVzeuqVc0ch/J9BWJIqy1U5JzOtvejme9C+2UpSrI1/56Vh2sOy0jI
	 oSnlih63GXEq9rRhTOyhnfHx08ucALLREzUo3QawqUUvQfztEgYrEetk3vbMjLttkV
	 C66RInxKH2chgq77VWYyLHm4OoSw5V2cLpxRJnl9u/ikhYZUUAJsbQ5JBnzsq+/aDd
	 RxDtHBhFtH6ag==
Date: Thu, 11 Jun 2026 10:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Oros, Petr" <poros@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Message-ID: <20260611104109.34063873@kernel.org>
In-Reply-To: <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
	<20260607183045.1213735-4-grzegorz.nitka@intel.com>
	<5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
	<IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298259-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ED5D67418E

On Thu, 11 Jun 2026 16:41:07 +0200 Paolo Abeni wrote:
> Fixes tag could be stripped when applying the patches as needed, and I
> think that could be preferable to a repost just for such thing, given
> the current PW load...

To be clear tho, this series has already been marked as changes
requested. Presumably based on the other comments?

