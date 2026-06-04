Return-Path: <netdev+bounces-295301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DF8HJT+bIWo/JwEAu9opvQ
	(envelope-from <netdev+bounces-295301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:35:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A306417D7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:35:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NRua8uDT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295301-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE3F730034A6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3048329C71;
	Thu,  4 Jun 2026 15:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216D3264CA;
	Thu,  4 Jun 2026 15:16:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586211; cv=none; b=bl69spkLINfmWUtRe1Nfw/+r5+VbdGZEy6xhShfLGJ5o4wLihPEgfm9fBkbm9xWTRAGEsA6CnVHyfzhNfyYLCf6Ra0haKUu9KbUiJ5CzFw3saP6xEG2SDpVFqIvEI73q4qfpDy0SrPqMBNBYJlQsYAvipmObqBSqhSbA1BXv0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586211; c=relaxed/simple;
	bh=Xplm850EmtocHCFaddifVaOvQwWbY+PSkg4aSxpr33g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrykXQfrFzWtqoB9Kw1NU3WOj+KGUPhqteLzxMhW5iaYFZQv/KyHqoMStyCeLSCKyhcQCO32McxsNEz9aK4DYWa3av0eU20s5Ya3uqG4eWPEhSK49mhnjh1lPFRpxTh2ZS9/o+wQluWn8lIDcR91cVdhJ9elaVOW+PRRglDAF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRua8uDT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BA31F00893;
	Thu,  4 Jun 2026 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586210;
	bh=T51PPVxGiMTXN3uehSniEHKbuRPsHORJ6JVQ8bYHvPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NRua8uDTRS3Dh3IGDFUbMW9eZq2/w4vNMlLlF32oUPqajpkf8bQy/U6FqNpVUROY6
	 r3zFDSrF7bgpKSoVh0j6KZHnESq55M0MvzxCrMsBzW6fMIrrXGGhRN8Etx49ZToiKe
	 fEyaI+TKlJ0IJKEpylkBsy2GLI7sQoRjjym8zdcKQZms1/CDVNgHiqg+o4xdukXPx5
	 KR3K5puhvbjmPxrE8LfKDsUDlrSdWiQYtNXiHfRYcy2Mw2PZyzkcR/q9NE5EhcY/jU
	 L2BrRKU8FyB2PfbHY7fgyBF3HujNtbR5HcESv3RmWZnakc68L6AP5y4Kmpvedp1276
	 qJXHKslYK5gVA==
Date: Thu, 4 Jun 2026 08:16:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jiri Pirko
 <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, Petr Oros
 <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Grzegorz Nitka
 <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin
 type
Message-ID: <20260604081649.1ae5302d@kernel.org>
In-Reply-To: <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
	<20260531194423.383366-2-ivecera@redhat.com>
	<20260603185037.05f8c6a0@kernel.org>
	<be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295301-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[intel.com,linux.dev,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87A306417D7

On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
> > Purely going on intuition here but feels like NCO should be a mode
> > (enum dpll_mode) rather than one of the input pins?
> > 
> > More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?  
> 
> I had a long discussion with Jiri about this and we agreed finally
> that dpll_mode represents a reference (input pin) selection strategy
> mode and not a DPLL device running mode.

Long discussion? I see 2 emails ;) Let's hear from others.
(thanks for the link BTW, _if_ there's a v6 please put it in the cover
letter)

