Return-Path: <netdev+bounces-284290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LL4BuS7+WmTCwMAu9opvQ
	(envelope-from <netdev+bounces-284290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B385F4CA040
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 244CA300E038
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB983290A9;
	Tue,  5 May 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmaJ5jtd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQYWJjS3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDB3264F1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974241; cv=none; b=S/REGmtT6PucsR1BqfP/NDhrVExU0/5EkScSDhFsECMV1xFeGAqGwu+b4R2lUFAswc+U34zG5Yr2oKKLvvCWOdonQsF9zaivoXjQG5s/kenYirVU4DJVbkKw2SnIDp4Nd585ygnWNaMK8QBN1bUA3ksVVCIGzodPyUXxW734Zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974241; c=relaxed/simple;
	bh=GB2zSiCiH2B2MkSpdmM8X1Yz2rkioSL551rkMUaheIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlY8HVjvpQipnQ6NeuqziRpfivuXNxY0jRvCluWF3OVnZsv1yZ8KGlSqqE8Fy6Wh45YMrka1brcbc5Jo1ycVSfnIz9wHJJYUJZi+bNmaauWoh7hMrJXrEVKYgQXy+0KLi3MGVQr+zo4YIUYe5CnJ8IDw3byahZgVd327fMm9p2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmaJ5jtd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQYWJjS3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777974237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
	b=dmaJ5jtdLJSdH9PZjrm+u5GTvfAiIM5WnJ5pZV7AxMxDAp13oCSR8MJ4clZAMBaG11nIxF
	V8XMZmIbxNu7zOPnMlIOHDZK7ycUwLxFzLNaCnf7FSzL37NXYkdnocz5I9Li2F5gCgDaou
	iKWnxA73AGYgd16jh6XY0Wxns1UJyno=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-x9Ri8rMGOuSVGS5hWQFBBg-1; Tue, 05 May 2026 05:43:55 -0400
X-MC-Unique: x9Ri8rMGOuSVGS5hWQFBBg-1
X-Mimecast-MFC-AGG-ID: x9Ri8rMGOuSVGS5hWQFBBg_1777974235
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d127eb013so6930695e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777974234; x=1778579034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
        b=FQYWJjS3v2WEH+plSmUPAOCpl+CPb17MvLD/Gv0ckl1+pqCH/mlb39gPruKPAZz3Ki
         EOkg3OzbKDqzpN+doqBiKtDsRNgROu+AtR2tOY3XlKTaZNxlGnVXQ43jsG/sYYwoagvZ
         SUtXK13rv0xonDZ5RAtdfv3m6aXoyuWaOM/UhTBf3WJekWwzzOgFAK71+xKy/UGT0wU0
         8f7Y0rRtjQ6eEI+PSiS+cyu58DaPXVt9bn7o/GwUFgZESq4Po5KGslIGbVCu+7yamyy/
         1SnA1iaIC12NXgVJ6n2BF1WOx5HHM3YclgMDF8TEOPL8IVm6t9/L0bOlc9tNmUvRyqpG
         inOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974234; x=1778579034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
        b=mrIqMEM7Jn3yjI7S+kzah4ZTdtiHqcNXr+anxyD98CFtB2jvrnLKxx2wNc+igOi7oG
         guQOjNU86hFJxWTbaoWtQbKAo6Y0MOCJzhgghFr8cgLKuGb+goLpSMEhZ3FDOSQmGrH5
         gKeQFVUuNfnmesddRwMI9+uDSlKNpaI95EXq4dhCYMARwuclFBRP3+qitjF44S4KFDbe
         l1i+KULH0Tt2WzYzPa6WcMiQi0NdwSpNb8Q9R3V8soTk9x6AiWM/Qjz0TWsYDtwQhEBv
         4tLv58sbpo1xOShiXubJAXQIxnL6gxLcTYNjuYHX33kfGooxfxEUmcoG4Px6K4WsDjy6
         CMFg==
X-Gm-Message-State: AOJu0YxQrUBoVnhfs2Hb+LnLwV6yuIAej0EFWUrtViOGSg3e3ZQtbHJ1
	aB3eToUD3Bt/YR5kq4tixt4eP9C9L1v8ZNULzvX46UOGJWacJn1Yvn6x0lC/QjajWmxOfxChQvD
	3jLzIX8Y4pSX1AGu5lc62pf8PTZcZrFx88iwXP2Xz+7eAjLpKaKjrTh+H4A==
X-Gm-Gg: AeBDievz6IAQTbtNrlgtYS2E2wkEhEPbLdhdmMqswVcIV7QwG3ptLqtk9LqGp67Srr7
	wR84Z7eBaOQI7ol7pu9rbBvSIkbf3PSyyZTHGBV7wd6jqXX22zaRTn+jdubksEikOr7IaabD9vz
	TQn4s1ZQrM0yjHqPsMSQin+sjeC0Z8TlQRvgwuScowK3JslB2jRJ0AzdgpRKnrIo5TcIM+h7Xw7
	Bq80j3DP/4f/n32oJsHmwWPCvlNtzXCo9ojbEyPQYsz3twYzVhq6b8NTInn/tVX63gxm2scDO6F
	p0gD73yDnDdUI3iR0U+7G8UDC73wnxPhapqt/Kta0RhE074+bzNJvRkFPEjrHMPY9DUXg+u/zrd
	m9htKdtE/6MFJ/WKQQu24d3a17rjDwqwhs7EOtr228K+mhyFVXNEXM3E8U1EjxNle9aQ=
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48a988ca441mr218126855e9.29.1777974234576;
        Tue, 05 May 2026 02:43:54 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48a988ca441mr218126385e9.29.1777974234170;
        Tue, 05 May 2026 02:43:54 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm603894855e9.1.2026.05.05.02.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:43:53 -0700 (PDT)
Message-ID: <37382811-ba47-4432-9911-6c39acea4f86@redhat.com>
Date: Tue, 5 May 2026 11:43:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 15/15] net: dsa: netc: add support for ethtool
 private statistics
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-16-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430024945.3413973-16-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B385F4CA040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284290-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/30/26 4:49 AM, Wei Fang wrote:
> Implement the ethtool private statistics interface to expose additional
> port-level and MAC-level counters that are not covered by the standard
> IEEE 802.3 statistics. The pMAC counters are only reported when the port
> supports Frame Preemption (802.1Qbu/802.3br).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/dsa/netc/netc_ethtool.c   | 107 ++++++++++++++++++++++++++
>  drivers/net/dsa/netc/netc_main.c      |   3 +
>  drivers/net/dsa/netc/netc_switch.h    |   9 +++
>  drivers/net/dsa/netc/netc_switch_hw.h |  58 ++++++++++++++
>  4 files changed, 177 insertions(+)
> 
> diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
> index ac8940b5a85c..8d04db534347 100644
> --- a/drivers/net/dsa/netc/netc_ethtool.c
> +++ b/drivers/net/dsa/netc/netc_ethtool.c
> @@ -19,6 +19,56 @@ static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
>  	{ }
>  };
>  
> +static const struct netc_port_stat netc_port_counters[] = {
> +	{ NETC_PTGSLACR,	"port gate late arrival frames" },
> +	{ NETC_PSDFTCR,	"port SDF transmit frames" },
> +	{ NETC_PSDFDDCR,	"port SDF drop duplicate frames" },
> +	{ NETC_PRXDCR,		"port rx discard frames" },
> +	{ NETC_PRXDCRRR,	"port rx discard read-reset" },
> +	{ NETC_PRXDCRR0,	"port rx discard reason 0" },
> +	{ NETC_PRXDCRR1,	"port rx discard reason 1" },
> +	{ NETC_PTXDCR,		"port tx discard frames" },
> +	{ NETC_PTXDCRRR,	"port tx discard read-reset" },
> +	{ NETC_PTXDCRR0,	"port tx discard reason 0" },
> +	{ NETC_PTXDCRR1,	"port tx discard reason 1" },
> +	{ NETC_BPDCR,		"bridge port discard frames" },
> +	{ NETC_BPDCRRR,	"bridge port discard read-reset" },
> +	{ NETC_BPDCRR0,	"bridge port discard reason 0" },
> +	{ NETC_BPDCRR1,	"bridge port discard reason 1" },
> +};
> +
> +static const struct netc_port_stat netc_emac_counters[] = {
> +	{ NETC_PM_ROCT(0),	"eMAC rx octets" },
> +	{ NETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(0),	"eMAC rx frame errors" },
> +	{ NETC_PM_RUCA(0),	"eMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(0),	"eMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(0),	"eMAC rx packets" },
> +	{ NETC_PM_TOCT(0),	"eMAC tx octets" },
> +	{ NETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(0),	"eMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(0),	"eMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(0),	"eMAC tx packets" },
> +	{ NETC_PM_TUND(0),	"eMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(0),	"eMAC tx invalid octets" },
> +};
> +
> +static const struct netc_port_stat netc_pmac_counters[] = {
> +	{ NETC_PM_ROCT(1),	"pMAC rx octets" },
> +	{ NETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(1),	"pMAC rx frame errors" },
> +	{ NETC_PM_RUCA(1),	"pMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(1),	"pMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(1),	"pMAC rx packets" },
> +	{ NETC_PM_TOCT(1),	"pMAC tx octets" },
> +	{ NETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(1),	"pMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(1),	"pMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(1),	"pMAC tx packets" },
> +	{ NETC_PM_TUND(1),	"pMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(1),	"pMAC tx invalid octets" },
> +};

Sashiko says:

Are these standard MAC and interface statistics being duplicated in the
driver-private ethtool strings?
The networking subsystem guidelines indicate that statistics which have
a standard uAPI must not be duplicated in ethtool -S. Standard
interfaces like struct rtnl_link_stats64 or struct ethtool_eth_mac_stats
already exist for counters such as rx octets, rx packets, dropped
packets, and FCS errors.
Could these metrics be exposed through the standardized interfaces
rather than adding them to the private string sets?

Other comments are AFAICS false positives.

/P


