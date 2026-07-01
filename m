Return-Path: <netdev+bounces-303795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LVWVAVtZRWo4+woAu9opvQ
	(envelope-from <netdev+bounces-303795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAB6F0890
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jfarr.cc header.s=fm3 header.b=PkaNpc+k;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=itM3Ha6V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303795-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=jfarr.cc;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1660D3011105
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECF4C6EFD;
	Wed,  1 Jul 2026 18:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7836A01E;
	Wed,  1 Jul 2026 18:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929751; cv=none; b=cjev25Gof80Dx2R8lWYIH/t7Pc6J7KDDoF3WDP5W/VqmjKJ0wyMQmwGbzGzLiyB6CGzBJns3roIRSeI/aKh3qGYPGxq6RyLMrHYS/kmWley9qg5e2Qy6R1jlRoX7bdn8exHgx924hMhyQtwYik7J2fKl2iPHJg7g7rnP0fEjGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929751; c=relaxed/simple;
	bh=WQes+ZO62rO3z/JLFwEVtrgxBa4vWaDNrBhvhs+evbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvUgOoQEXpUC6dAFcAj6Qe3YOk0USNZNG9x7LcPcAa9i+SIxRBnzilKXfwOWnNCSElPpBgrvqchLrhkN58azNX/DaP55spslZL0CO352yMqcjnlxmfaP1Brpb+aCIrG97uF+vo6tO35vIiMA9uYdWPi+7RsGCsU/wPgz3sWCjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=PkaNpc+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itM3Ha6V; arc=none smtp.client-ip=202.12.124.156
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F40D7A010E;
	Wed,  1 Jul 2026 14:15:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 01 Jul 2026 14:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782929749; x=1783016149; bh=iNAoqlZWh+
	TXfxLeRXvH8rsIV0n+gRuJTe9YemFnU6o=; b=PkaNpc+kEG+xTLQJuHSaUU/B2D
	/CyrwNmC4vPGGaSqYAYT0B+N6i8kzYkBwSxADEP4WvXJW4Uedrhfko7BnJVoVQuI
	puLio1XAFlgupYSg1JwUqnf5id5JXWNgUR81JndWMba6oPHc2xRCJJwmjijHTPsc
	cur+Ff6rALfalrTmUOkUB+NklDS5LkOF0KYekN4q8wc/eQR9Uca6X4gKtzEYYlOL
	Co2nJIFgjDVLbQiyhdETfkxyqrmS13dtAvNGpEFSNkmx9x9GPJv5P3WXc++/9KxF
	fPyARe98xnRRoKLAjmNmXJvtqn5IFl6GY9BPvPQKJ5k6lW5iAz3b+7HjPpqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782929749; x=1783016149; bh=iNAoqlZWh+TXfxLeRXvH8rsIV0n+gRuJTe9
	YemFnU6o=; b=itM3Ha6VPMuw93tvh7O0nU0+fjISRL/i1OmswwuqqiHtwk5pNK3
	hgyD9ty7+6d6F6YK8kV2U1o5qvhNVs3ToGeN/FmQRx7gpp0/PkiC5aa3NyEGlSSR
	GfGLBp7g1JWcnbTuakxmF2CS3bUj2s6ZccHl+pDkld5gmUoMcMWT1+YG5xGdwdI5
	nYa0ZnT+9R6aGD6j12OU1bKYU7cdJGvYoy5wSh70OlZrz8YbW2UxG1NJzwS3gRF+
	LRR/fCMWTErQy+S9MmGoXVcq9bPkG0lWwRUv8p//8sDGLacqMMXhTWoVTi7WI6Wx
	nS8yCjv9mdiYnDcfPkBsbX20jhxJYI6oW/Q==
X-ME-Sender: <xms:VFlFaka7UtHYyAvxAO-wWjg9GXplBwA-y_YWvMK8QhhFVT88Hm1_rw>
    <xme:VFlFaum7zZy3shDes0k3dfQs587iGBC0ZeG3h3LAdqG_0mnVuDHRS9fVyo6cfhXuV
    g8i8pW0oAYT2yvQH66UoiuArRjy5fB_cNjgwF2eSZjDK9t7z0qoHQ>
X-ME-Received: <xmr:VFlFahrDaaD3KwFwNxJMLuU6bsA9Qkms2Swojr7b-fc5CfpCbKoUuRMp0kHkSfa9vkFwuhqGT5QLVurzvBxIRGnz254a>
X-ME-Proxy-Cause: dmFkZTEhYKzoYbPTFOda6KfbW7uQxG2TaJ/oIBYcu1HYIVu+fOfEXtWyH1a9D13cNEo/bS
    6Db4NyKQNu7bP++KOnxItTt9InRy/jMGwinlCmWlirJsJHROjUMSy3PsjiN+0DpaA/i7Tz
    JAkvBMGfCOrd8F/Rh3aPW5UAM3PBuSshQtLm6+ztdW5jrf2E4N6KwqhOhp3gYqMUsK7NHb
    ifrWXFq0q4TaVyR34u93VljFhAyFiD7bXNltBhMMcuPFJAwNEB1deIM+3FUtYBGb/RtFqf
    mi9ScI8P4CYpIzCI7cx3AWBh5GZ0jQiLSqbD3JNcCsiiGlNlv0QU6XzYTgb4Wgl3T/O5Tg
    FzfqxruL85bCSomYZjMR7JA0m/+/yrzRWnCFK6RNfMVGtC5DTtzQnHol3IAGFvb9yyiCwa
    3uflpQXhkJM4eYBux8LuyMigGdoTqXPe82Tp3B5Xg+xru0oOdPIxVXu2UrZHMPU+DjHiwa
    qcfScqkE/dSfadmdDC4FjwXU/mKqbupK9F1i3xvBkRE58wZOvSUKykfMb76weeF4Qc/E6O
    LYvq96hV/QEWac4j3b6f/FZmUPMELPvo4VXaG0bFkFSAL33M2CnuW3MlBWJxd6Je0Auvro
    2SVFNei7EbLqqnYnS4LApx879kyv2kFcFdHRcVq7kf/3SKYix/pCEhnuRS+A
X-ME-Proxy: <xmx:VFlFaoCnmoK7gs7AmXbg1SRwRanbgj8nogdZRztES2lUY9A0CfHj9Q>
    <xmx:VFlFasGOBCtoku83KfCnx21_vtWSIIe_WDKqCCPPOxmX3WtP_y0QGA>
    <xmx:VFlFaq3EqKfeg5J9oTEl0LpnblvkhG2lpthpGtSa_LbSkk9eV2Lwvg>
    <xmx:VFlFalP9CYSN5LHWcgyuw0xIxggDoqr_WiQaZFKPEQv0hPS9eVW8-w>
    <xmx:VVlFanHGw4tDNbf3nQoriou_JCQLlbFqw6yL3iHnDqhydM5bTX6DQBwY>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 14:15:47 -0400 (EDT)
Date: Wed, 1 Jul 2026 20:15:45 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hsu.chih.kai@realtek.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, olek2@wp.pl, pabeni@redhat.com
Subject: Re: RTL8159 firmware
Message-ID: <akVZUQX1V-jAM06U@archlinux>
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jfarr.cc,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jfarr.cc:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com];
	TAGGED_FROM(0.00)[bounces-303795-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kernel@jfarr.cc,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jfarr.cc:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@jfarr.cc,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AAAB6F0890

On 01 19:24:13, Birger Koblitz wrote:
> Hi Jan,
> 
> On 7/1/26 19:13, Jan Hendrik Farr wrote:
> > Hi Birger,
> > 
> > it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
> > Could you send it for people to potentially test?
> > 
> > Jan
> > 
> The code to create the binary firmware file is at:
> https://gitlab.com/koblitz-rtlnic/rtlnic_fw

I'm getting a 404.


> But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
> which the binary data is extracted is published by Realtek under the GPL.
> For linux-firmware, a binary distribution license is necessary, which requires
> someone from Realtek to license it under their usual firmware license. I
> contacted Realtek, but never heard back.

Ok, let's hope they'll get back to you...



Jan


