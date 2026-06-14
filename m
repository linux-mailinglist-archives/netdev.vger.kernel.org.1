Return-Path: <netdev+bounces-299233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PMylGxXPLmqD3QQAu9opvQ
	(envelope-from <netdev+bounces-299233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DBE681727
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:56:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=oFQETYle;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299233-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91033008A76
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18B386453;
	Sun, 14 Jun 2026 15:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045421FF23
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 15:56:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452562; cv=none; b=H9Nf0XvajA5H0vPt6N5UhMDe4CtCkWwFHNaAECHpV8jWH2A2cKIdwMh8UX/hizV3ArDtf5DUL6dCkbJuj0ZWMXH98xUgtYQ9/2aH1uXluvgBvsCQtjuPoAiVPd9HzwBpydIcv/h45FraCwS3Mwn5H5GTL4tXJHkJHvNODt9KTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452562; c=relaxed/simple;
	bh=6CsdZmxFZtGbdO2ws8b1HWLbyrN5w1wO98MYgMaKDs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7zcEEGnucz6OGlvWDNi4svGynut2cA6cjVdqNsOaoE8SYWGAMEfZXATsxjZxNe2QGVSbuvk+51q+sVFUbNyDj0r+Q4s2Wbj/TR+HmBL5n7HTXyKpaSrTegHXnrraS0ZNSqSpU1q7fIokda8f57uxcKuBpHxG7lpesK72tnEL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=oFQETYle; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3074adb8fcaso3071415eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781452559; x=1782057359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXrFaQ/QnB/9JLymgg98ar/g1st35tkHVFlmEYcRrgU=;
        b=oFQETYle2QpKFx6Cl+2PL5aH+2xf97ePOvkM9vtlTIEokS86e2beoildAfiB3jSq2p
         bK2y/f1BP/I2qw5ktg/OtXJLWEOocPTb2alEZf1lbHbqann8VwBuMJBZuU/DwEvfWwh4
         ZJPnFu++9EHabcQtbcszu7eo5miO8oE0zH7mJ3MSzF/6yFL/ai1/6bw7+QKa4n0YVoRN
         K1Aq+ni+GQkV1Z6Kqf5Mx4tykzHalJUU2IOHQVmFBgM7MsqiebX8TxAL8H6zYJOkC9ff
         WO7RFJ9tn4EgtGOVTYANI7tpp/R/+sj0AZgaQU6p4eS27s7R3DAl7jLCbPW4t6Thexip
         ngJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781452559; x=1782057359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXrFaQ/QnB/9JLymgg98ar/g1st35tkHVFlmEYcRrgU=;
        b=m2t4SoIWrGFQ21Xj47kvIO7ON12xiMNd+w1CRZN64r6X/IkX0SUgBUibKK0bIxecd5
         S+kpYtbLsxk2+/v6VkS0snvVOtFxBvus+jAs+LH14aFqqXh/DHixBWd/SrXt4H3crfGp
         h6Wc1mjMT0BT1Ha8tblvbB+BitM6pr/JpJnWpl+i2+mHe/jUQKpPUZdeMdWH+oDD+++j
         q4pbHshn2UZBJTum+rU2Fk0uqHFoQbwyw8JfysA5zkLcpBkgF1oHkng0D/Ndr57vUpVw
         IXX6mntKtzdyBuCEw6eJ6TMFyH0n8UlBpxw1yacPceFcAT3rvmTXRyaZ+sV1DjoFZWot
         fQaQ==
X-Gm-Message-State: AOJu0YymG9UGEDXKmar/buUR5lfFlq+Pi4acTNTngpJ79eIp5k/y1OlD
	GxlgGO77MUtioTcW99ZKkd1xbsVD3YoQrU6Wp5j128Z4pPM6RyzwLlAbnlNSDkOqppk=
X-Gm-Gg: Acq92OGl9CS7tIdJ1JXKTLNk0g7OGQPYpDGx+yN6QUfNSOIoQn3OVFvBpgx9Jj3KdmC
	TNOw7pdPK4Fb7MgEmWjNH3h+9QSO7BwM10SzP7kPjNhKDjNVkdaBAub561M/PkDAInR/X9fdtVj
	TFux9MbENILL/t4R9EdO3c+1czV8cVfmrkxTgnrABdwjh7sBMB/bIN1E5acwNzEViCjJcH5zSmM
	KGdcgHWIL609ICs8Xmj+K5rLUtCO83Ki8Crl3NxT6AjlInAVURfFn8oBpCR++K6EgMouTBjqLWb
	0pzxgQp57xLmxPh26cXAorM5KWi5tXz0zr6pfaZllPi6eoakqOe/Gq2tMrCj/jSgyfts6NBDvbC
	MoT40CRDWzK6saeZ7YtivohXDROqNI3G62ZCf7wxoMAn6IiO6aWdr7FtMz16gxerHVFrh5xbHE2
	ASbsr+Z72aJT17F+tNGmXftYJ+BKuuz1goVFzacqYX8WUJYhNKP0zn1r+0abBrZFC9
X-Received: by 2002:a05:7300:80ce:b0:2f2:8857:17f6 with SMTP id 5a478bee46e88-3081ff63daamr6128313eec.4.1781452559385;
        Sun, 14 Jun 2026 08:55:59 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm12482533eec.10.2026.06.14.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:55:59 -0700 (PDT)
Date: Sun, 14 Jun 2026 08:55:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH iproute2-next] ipaddress: add support for showing IPv4
 devconf attributes
Message-ID: <20260614085556.1efda1eb@phoenix.local>
In-Reply-To: <3e4a425e-0f58-48dc-a2bc-88fd6eb4a302@suse.de>
References: <20260612231722.30579-1-fmancera@suse.de>
	<20260612192936.61c23f85@phoenix.local>
	<bdccf9bf-994d-445c-8167-4bcd8cd77e6e@suse.de>
	<3e4a425e-0f58-48dc-a2bc-88fd6eb4a302@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299233-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:from_mime,networkplumber-org.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,phoenix.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3DBE681727

On Sat, 13 Jun 2026 09:22:38 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> On 6/13/26 8:41 AM, Fernando Fernandez Mancera wrote:
> > On 6/13/26 4:29 AM, Stephen Hemminger wrote: =20
> >> On Sat, 13 Jun 2026 01:17:22 +0200
> >> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> >> =20
> >>> tatic void print_inet(FILE *fp, struct rtattr *inet_attr)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 struct rtattr *tb[IFLA_INET_MAX + 1];
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (tb[IFLA_INET_CONF] && show_details) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *conf =3D RTA_DATA(tb=
[IFLA_INET_CONF]);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int max_elements =3D RTA_=
PAYLOAD(tb[IFLA_INET_CONF]) /=20
> >>> sizeof(int);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_FORWARDING)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "forwarding", "forwarding %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_FO=
RWARDING - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_MC_FORWARDING)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "mc_forwarding", "mc_forwarding=20
> >>> %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_MC=
_FORWARDING - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_PROXY_ARP)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "proxy_arp", "proxy_arp %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_PR=
OXY_ARP - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ACCEPT_REDIRECTS)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "accept_redirects",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "accept_redirects %s=
 ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AC=
CEPT_REDIRECTS - 1] ?=20
> >>> "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_SECURE_REDIRECTS)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "secure_redirects",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "secure_redirects %s=
 ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_SE=
CURE_REDIRECTS - 1] ?=20
> >>> "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_SEND_REDIRECTS)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "send_redirects",=20
> >>> "send_redirects %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_SE=
ND_REDIRECTS - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_SHARED_MEDIA)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "shared_media", "shared_media %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_SH=
ARED_MEDIA - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_RP_FILTER)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "rp_filter", "rp_filter %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_RP_FILTER - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ACCEPT_SOURCE_ROUTE)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "accept_source_route",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "accept_source_route=
 %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AC=
CEPT_SOURCE_ROUTE - 1] ?=20
> >>> "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_BOOTP_RELAY)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "bootp_relay", "bootp_relay %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_BO=
OTP_RELAY - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_LOG_MARTIANS)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "log_martians", "log_martians %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_LO=
G_MARTIANS - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_TAG)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "tag", "tag %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_TAG - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARPFILTER)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "arpfilter", "arpfilter %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AR=
PFILTER - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_MEDIUM_ID)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "medium_id", "medium_id %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_MEDIUM_ID - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_NOXFRM)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "noxfrm", "noxfrm %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_NO=
XFRM - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_NOPOLICY)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "nopolicy", "nopolicy %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_NO=
POLICY - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_FORCE_IGMP_VERSION)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "force_igmp_version",=20
> >>> "force_igmp_version %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_FORCE_IGMP_VERSION -=
 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARP_ANNOUNCE)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "arp_announce", "arp_announce %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_ARP_ANNOUNCE - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARP_IGNORE)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "arp_ignore", "arp_ignore %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_ARP_IGNORE - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_PROMOTE_SECONDARIES)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "promote_secondaries",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "promote_secondaries=
 %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_PR=
OMOTE_SECONDARIES - 1] ?=20
> >>> "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARP_ACCEPT)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "arp_accept", "arp_accept %d ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_ARP_ACCEPT - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARP_NOTIFY)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "arp_notify", "arp_notify %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AR=
P_NOTIFY - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ACCEPT_LOCAL)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "accept_local", "accept_local %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AC=
CEPT_LOCAL - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_SRC_VMARK)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "src_vmark", " src_vmark %s",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_SR=
C_VMARK - 1] ? "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_PROXY_ARP_PVLAN)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "proxy_arp_pvlan",=20
> >>> "proxy_arp_pvlan %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_PR=
OXY_ARP_PVLAN - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ROUTE_LOCALNET)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "route_localnet",=20
> >>> "route_localnet %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_RO=
UTE_LOCALNET - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_BC_FORWARDING)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "bc_forwarding", "bc_forwarding=20
> >>> %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_BC=
_FORWARDING - 1] ? "on" :=20
> >>> "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D=20
> >>> IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "igmpv2_unsolicited_report_interval",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "igmpv2_unsolicited_report_interval %d=
 ",
> >>> +                 =20
> >>> conf[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D=20
> >>> IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_int(PRINT_ANY, "igmpv3_unsolicited_report_interval",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "igmpv3_unsolicited_report_interval %d=
 ",
> >>> +                 =20
> >>> conf[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL - 1]);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "ignore_routes_with_linkdown",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ignore_routes_with_=
linkdown %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_IG=
NORE_ROUTES_WITH_LINKDOWN -=20
> >>> 1] ?
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "drop_unicast_in_l2_multicast",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "drop_unicast_in_l2_=
multicast %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_DR=
OP_UNICAST_IN_L2_MULTICAST=20
> >>> - 1] ?
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_DROP_GRATUITOUS_ARP)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "drop_gratuitous_arp",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "drop_gratuitous_arp=
 %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_DR=
OP_GRATUITOUS_ARP - 1] ?=20
> >>> "on" : "off");
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_elements >=3D IPV=
4_DEVCONF_ARP_EVICT_NOCARRIER)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rint_string(PRINT_ANY, "arp_evict_nocarrier",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "arp_evict_nocarrier=
 %s ",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf[IPV4_DEVCONF_AR=
P_EVICT_NOCARRIER - 1] ?=20
> >>> "on" : "off");
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +}
> >>> + =20
> >> There are three different ways to display a flag value in JSON used in=
=20
> >> iproute2.
> >> This one is my least favorite.
> >>
> >> The three ways are:
> >> =C2=A0=C2=A0=C2=A0 - print_bool
> >> =C2=A0=C2=A0=C2=A0 - print_null (only if on)
> >> =C2=A0=C2=A0=C2=A0 - print_string
> >>
> >> I would use the print_null pattern but print_bool would also be ok.
> >> =20
> >=20
> > Thanks for the suggestion Stephen, I would pick print_bool in this case.
> >=20
> > If one of the options evolves to supporting something else we could=20
> > easily adapt it without breaking compatibility if we use print_bool. If=
=20
> > we use print_null I don't think we could do that.
> >  =20
>=20
> Hm. I am actually not so sure about this..
>=20
> the current print_string approach matches the setter and also the=20
> netconf side. While print_bool would be easier to parse for JSON, it=20
> looks not so good for command line output.
>=20
> print_null presents a different problem, users would need to make sure=20
> their parsing is working with an iproute2 version that support these new=
=20
> attributes.
>=20
> So I am not so sure what is the best option here.

None of this is a hard requirement. The requirement is that the output
be valid JSON. The other common practices are:
  - non JSON output of display should match the input command line
    there were even some user tools that depended on this to do save/restor=
e of state
  - JSON output should be easy to parse in python.

If user is using python to read JSON (which seems like the most common).
then bool or presence allows for use in conditional.



>>> import json
>>> json.loads('{"forwarding": true}')["forwarding"]
True                          # <class 'bool'>
>>> json.loads('{"forwarding": "on"}')["forwarding"]
'on'        =20

