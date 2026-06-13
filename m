Return-Path: <netdev+bounces-298886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMxQL5nALGpCWAQAu9opvQ
	(envelope-from <netdev+bounces-298886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401667D889
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:29:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=dL9+XcOX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298886-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298886-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA74D305CBB4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4693382F4;
	Sat, 13 Jun 2026 02:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59F2459DC
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:29:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317782; cv=none; b=thnu8CV0P3HLJGXqZXQQSJXHicX4nui1qYEcBVFya0x2IfEL4jUXWw3Ryv98aDSH3hrHSQJAff7RL1oUUJvscaes2gE2NjFXkUWF6EZH/WZ7DY6/cAr+ASE7eseGL+X7MGCSlNlHoEXNT9AkzR49ixNN+tjhuD1LH5w8iAETDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317782; c=relaxed/simple;
	bh=dO7bHnvCcWblriPTzxTRRLmz8AyNXl0KCbbNGSuNRVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJxpxekjkiUR7tt6WaZrT3jhQkSmKt09bTL5LH61WbhFEhFEuRsj8fTzN6EQ394oGkWq7bhGMWteJGTDeFczIbEW/dKYu9QhgMTqLXZE8+I7DU+MDs+lF+r1AllAV03Y+uBHaMhj38s4dvyUX/gXaT8/pmoFB7NxyvOrOpp1g6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=dL9+XcOX; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307263ad0cbso2541378eec.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781317780; x=1781922580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKeL9TUZLvcDPQWGX7hcJbikOJBTTmxpJSMcgrb+zxY=;
        b=dL9+XcOXk9NbnjBBttKO/SOFe1BPAQsHm2WQKQOO1gIzPqxPl75Rgsps4+b7VgDJSf
         dWC/KU6gvsaawrj+n0/bmlbpsFDX40ArYwznKlCH1QDCsrW1BGywjNdeyFVgYUmfjiWl
         aArxHlF/Upu9SbvFQU/+H3N69ij+HYTo8JpVRjG7CA4jN2mOmPiqE6eNRMRaOkxPnY03
         P3WKtCXeqNaKJZmVF8DsKWgpWELP4yrRa9yAaFJ1Md7XL4xvgriTSjgUy4l91pOnq6TI
         4tmXs8jg3v77CfZVqRDM8EnqRG0F3cnO3I72JL9SUyBvSUxSa8ar94eNMlNZQkDSyXbJ
         j/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781317780; x=1781922580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKeL9TUZLvcDPQWGX7hcJbikOJBTTmxpJSMcgrb+zxY=;
        b=jt+lST8DAj5X/vkPUWuTr1geO9VOjdV6IqqccKqVCsw7nKISMl9B8ysyr4THIE2ite
         TeGPOWAGzPlkaLffeLe1NV81JbVTJLD7N2BiqlBad/HulLuItMfyUXxh+3d+gin/2XIs
         KpLQ/ORBAh+jhgthI8EI3C+l64Nlhuhz2/xZVuTN82dpV7nmgOAb9OWda4hbzhF1Xyqw
         ATLY2VtxnNzXQlvqqPQZmo1gP6wx3Dp1etHj4C4zKuTH6JIbuILlRMO7J03B6hr6Rxj5
         eeHo9wxJtU+7GDSqctxStOMCYpCfToZ8iJo37gDvbD5DU2rmTqHxanCaIALzThcTZ53d
         rCaQ==
X-Gm-Message-State: AOJu0YztgGsb3ETnxCLfN7xhSy/tZsTaC+vF2fB+ej1kLS9UtAQV+ODS
	cvsmyTJa0Nzm3FGTFiV0Bn+S7omrPLH/p/cr4jnH2sFqI4xktWboWNunkGwh731IFWQ=
X-Gm-Gg: Acq92OF6Ox9pGriJLRvOOWqlMTHFKVNTgi4ANK3LA9Q3Lk8XUli9yb9FRrcrDeXa854
	gueJtjY3FBr/IGZgLLVWaByq1yVBnU6Eb+NmZYazrMfcdseNOraiex5IX5SwsKfs+XsReLu9u0q
	qCCt0k+R+jLY3FBe2DasHd9b2gxmrMlugcF9DWN0S/8oZX+BpghxTcI79P0DjarUjCU/R7rq+fr
	ILv4KTEYKqdG4RlliammQb/5rsE/E/L84T7dlxwaVn9Cf8VOmVz5QPFEj+fs4XRQYVpQy/oM9/l
	MDZv5K2FFbyuhjuWsyQXvgtBk6Jic8uF0yKO6+u8/X9l6ts/J8n3iVklIFgqvIQGWWIEcAUhzKn
	mkxGkjwvsGqG1wBPkK41pRnxIYuj9MP7A6BfvRXAU6CJ6h9N7fXJVC6oDp8PPnYjk+UdIWCjFSV
	dfb7ZrKE24b+0kvaPN3FOqf/GrzxDcUVKefAJErE2lbt8hfgY911sOS9rbDCB/jwYs
X-Received: by 2002:a05:7022:30d:b0:136:5c88:d928 with SMTP id a92af1059eb24-1386f392043mr835491c88.19.1781317780160;
        Fri, 12 Jun 2026 19:29:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91fb97sm6123109eec.14.2026.06.12.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:29:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH iproute2-next] ipaddress: add support for showing IPv4
 devconf attributes
Message-ID: <20260612192936.61c23f85@phoenix.local>
In-Reply-To: <20260612231722.30579-1-fmancera@suse.de>
References: <20260612231722.30579-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298886-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,networkplumber.org:from_mime,suse.de:email,networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1401667D889

On Sat, 13 Jun 2026 01:17:22 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> tatic void print_inet(FILE *fp, struct rtattr *inet_attr)
> +{
> +	struct rtattr *tb[IFLA_INET_MAX + 1];
> +
> +	parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
> +
> +	if (tb[IFLA_INET_CONF] && show_details) {
> +		int *conf = RTA_DATA(tb[IFLA_INET_CONF]);
> +		int max_elements = RTA_PAYLOAD(tb[IFLA_INET_CONF]) / sizeof(int);
> +
> +		if (max_elements >= IPV4_DEVCONF_FORWARDING)
> +			print_string(PRINT_ANY, "forwarding", "forwarding %s ",
> +				     conf[IPV4_DEVCONF_FORWARDING - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING)
> +			print_string(PRINT_ANY, "mc_forwarding", "mc_forwarding %s ",
> +				     conf[IPV4_DEVCONF_MC_FORWARDING - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP)
> +			print_string(PRINT_ANY, "proxy_arp", "proxy_arp %s ",
> +				     conf[IPV4_DEVCONF_PROXY_ARP - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS)
> +			print_string(PRINT_ANY, "accept_redirects",
> +				     "accept_redirects %s ",
> +				     conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_SECURE_REDIRECTS)
> +			print_string(PRINT_ANY, "secure_redirects",
> +				     "secure_redirects %s ",
> +				     conf[IPV4_DEVCONF_SECURE_REDIRECTS - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_SEND_REDIRECTS)
> +			print_string(PRINT_ANY, "send_redirects", "send_redirects %s ",
> +				     conf[IPV4_DEVCONF_SEND_REDIRECTS - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_SHARED_MEDIA)
> +			print_string(PRINT_ANY, "shared_media", "shared_media %s ",
> +				     conf[IPV4_DEVCONF_SHARED_MEDIA - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_RP_FILTER)
> +			print_int(PRINT_ANY, "rp_filter", "rp_filter %d ",
> +				  conf[IPV4_DEVCONF_RP_FILTER - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE)
> +			print_string(PRINT_ANY, "accept_source_route",
> +				     "accept_source_route %s ",
> +				     conf[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_BOOTP_RELAY)
> +			print_string(PRINT_ANY, "bootp_relay", "bootp_relay %s ",
> +				     conf[IPV4_DEVCONF_BOOTP_RELAY - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_LOG_MARTIANS)
> +			print_string(PRINT_ANY, "log_martians", "log_martians %s ",
> +				     conf[IPV4_DEVCONF_LOG_MARTIANS - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_TAG)
> +			print_int(PRINT_ANY, "tag", "tag %d ",
> +				  conf[IPV4_DEVCONF_TAG - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_ARPFILTER)
> +			print_string(PRINT_ANY, "arpfilter", "arpfilter %s ",
> +				     conf[IPV4_DEVCONF_ARPFILTER - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_MEDIUM_ID)
> +			print_int(PRINT_ANY, "medium_id", "medium_id %d ",
> +				  conf[IPV4_DEVCONF_MEDIUM_ID - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_NOXFRM)
> +			print_string(PRINT_ANY, "noxfrm", "noxfrm %s ",
> +				     conf[IPV4_DEVCONF_NOXFRM - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_NOPOLICY)
> +			print_string(PRINT_ANY, "nopolicy", "nopolicy %s ",
> +				     conf[IPV4_DEVCONF_NOPOLICY - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_FORCE_IGMP_VERSION)
> +			print_int(PRINT_ANY, "force_igmp_version", "force_igmp_version %d ",
> +				  conf[IPV4_DEVCONF_FORCE_IGMP_VERSION - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_ARP_ANNOUNCE)
> +			print_int(PRINT_ANY, "arp_announce", "arp_announce %d ",
> +				  conf[IPV4_DEVCONF_ARP_ANNOUNCE - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_ARP_IGNORE)
> +			print_int(PRINT_ANY, "arp_ignore", "arp_ignore %d ",
> +				  conf[IPV4_DEVCONF_ARP_IGNORE - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_PROMOTE_SECONDARIES)
> +			print_string(PRINT_ANY, "promote_secondaries",
> +				     "promote_secondaries %s ",
> +				     conf[IPV4_DEVCONF_PROMOTE_SECONDARIES - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_ARP_ACCEPT)
> +			print_int(PRINT_ANY, "arp_accept", "arp_accept %d ",
> +				  conf[IPV4_DEVCONF_ARP_ACCEPT - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_ARP_NOTIFY)
> +			print_string(PRINT_ANY, "arp_notify", "arp_notify %s ",
> +				     conf[IPV4_DEVCONF_ARP_NOTIFY - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_LOCAL)
> +			print_string(PRINT_ANY, "accept_local", "accept_local %s ",
> +				     conf[IPV4_DEVCONF_ACCEPT_LOCAL - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_SRC_VMARK)
> +			print_string(PRINT_ANY, "src_vmark", " src_vmark %s",
> +				     conf[IPV4_DEVCONF_SRC_VMARK - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP_PVLAN)
> +			print_string(PRINT_ANY, "proxy_arp_pvlan", "proxy_arp_pvlan %s ",
> +				     conf[IPV4_DEVCONF_PROXY_ARP_PVLAN - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_ROUTE_LOCALNET)
> +			print_string(PRINT_ANY, "route_localnet", "route_localnet %s ",
> +				     conf[IPV4_DEVCONF_ROUTE_LOCALNET - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_BC_FORWARDING)
> +			print_string(PRINT_ANY, "bc_forwarding", "bc_forwarding %s ",
> +				     conf[IPV4_DEVCONF_BC_FORWARDING - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL)
> +			print_int(PRINT_ANY, "igmpv2_unsolicited_report_interval",
> +				  "igmpv2_unsolicited_report_interval %d ",
> +				  conf[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL)
> +			print_int(PRINT_ANY, "igmpv3_unsolicited_report_interval",
> +				  "igmpv3_unsolicited_report_interval %d ",
> +				  conf[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL - 1]);
> +
> +		if (max_elements >= IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN)
> +			print_string(PRINT_ANY, "ignore_routes_with_linkdown",
> +				     "ignore_routes_with_linkdown %s ",
> +				     conf[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1] ?
> +				     "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST)
> +			print_string(PRINT_ANY, "drop_unicast_in_l2_multicast",
> +				     "drop_unicast_in_l2_multicast %s ",
> +				     conf[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST - 1] ?
> +				     "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_DROP_GRATUITOUS_ARP)
> +			print_string(PRINT_ANY, "drop_gratuitous_arp",
> +				     "drop_gratuitous_arp %s ",
> +				     conf[IPV4_DEVCONF_DROP_GRATUITOUS_ARP - 1] ? "on" : "off");
> +
> +		if (max_elements >= IPV4_DEVCONF_ARP_EVICT_NOCARRIER)
> +			print_string(PRINT_ANY, "arp_evict_nocarrier",
> +				     "arp_evict_nocarrier %s ",
> +				     conf[IPV4_DEVCONF_ARP_EVICT_NOCARRIER - 1] ? "on" : "off");
> +	}
> +}
> +
There are three different ways to display a flag value in JSON used in iproute2.
This one is my least favorite.

The three ways are:
   - print_bool
   - print_null (only if on) 
   - print_string

I would use the print_null pattern but print_bool would also be ok.

