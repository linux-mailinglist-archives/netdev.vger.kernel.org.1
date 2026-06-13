Return-Path: <netdev+bounces-298906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ts11FdL9LGp0YgQAu9opvQ
	(envelope-from <netdev+bounces-298906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:50:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9187267DDBE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:50:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZeON2lNQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YWzNBIsl;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bTQdjkuy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wduYk4yI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298906-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007923031EA6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 06:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAB34B183;
	Sat, 13 Jun 2026 06:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178F353EDF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 06:50:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333455; cv=none; b=HjwzXQQvdLMSm2rd/94FoKQ3PNRwYZBh8iktSrxl4Mt/CTRVWWF5mwm092PSihTsDl3joloZ3T0C4ptK02WrqSjO1JVAsoH3PHvN1TBpWGvjwXmdnp66J66ukUszWKiN3zSVyD7bqn2Gf5ZYYAocKjNieAbsT0egZ23zM3AWLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333455; c=relaxed/simple;
	bh=6mMNxJHCNmBuXobFJV3+g+K62nrobZFDRutivd1Jc5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds6SsC8vUXIbQ4NcmAZorm32eUlEuzYgNGFpLSE5jhFAzdDBE2ZQE7OsglsOnP64sIkRkCVmI9YkYg1JYc8VIFF4m0em55F6uHiit8loOvasDuBedWYd8FAL184A8+9a/H8qwS6X9yfvCpPYO4cT7/TCCuCuIRjPekqEZBS3u84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZeON2lNQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YWzNBIsl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bTQdjkuy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wduYk4yI; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 010426CF81;
	Sat, 13 Jun 2026 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781332903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA8zAipVer3KDVpJB+uKrSHIQsBGUJIEkEMIoGu8aps=;
	b=ZeON2lNQQ+cJFFPU8R/Y06kaSzPriAMsK8G1aad+3oNGBg0JR64kgBHlL4edkQwhD84GY4
	A7I/wNjOExxqBTykJB1+B5fBpGIZbm0zZsSYYPVUXH+qWl8Vq5Muy4Ca4PgbM6bIf+sv1u
	IyJZBVVXN8OdEzysEcywEFmuMk+oWaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781332903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA8zAipVer3KDVpJB+uKrSHIQsBGUJIEkEMIoGu8aps=;
	b=YWzNBIsl+v88FfmZPSZihDfjK7voSvfNrpbzMnIMOV0eq5K85PyPZR/nzWZiAKZ3hRKDBT
	byIBen7wlyeSgoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781332902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA8zAipVer3KDVpJB+uKrSHIQsBGUJIEkEMIoGu8aps=;
	b=bTQdjkuyS1SnEzT4zjJlNSq+iSBcT/68eMK5TzwboZU4b0/1Nzw5qBtu+IHZWs8x/mlVLs
	50Q8JdWkvAFGEtL9nDUej2rRHHIZAHHUSBAVQDitdCxr7Nyc3Yxw9rQxL+aFqfQOGEmK7T
	PTYZvi/5V//o8nfeMemk66cDgkU2DsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781332902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA8zAipVer3KDVpJB+uKrSHIQsBGUJIEkEMIoGu8aps=;
	b=wduYk4yIljbtcE6twokcqSzsv+Pj/alrzIoPM+sr17Xcj6O4FG9irJI7Dm5XfviXNyrifc
	Ro4q26ANGpDI49AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36143779A7;
	Sat, 13 Jun 2026 06:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k0BVLqP7LGoGNQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 13 Jun 2026 06:41:39 +0000
Message-ID: <bdccf9bf-994d-445c-8167-4bcd8cd77e6e@suse.de>
Date: Sat, 13 Jun 2026 08:41:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ipaddress: add support for showing IPv4
 devconf attributes
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260612231722.30579-1-fmancera@suse.de>
 <20260612192936.61c23f85@phoenix.local>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260612192936.61c23f85@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9187267DDBE

On 6/13/26 4:29 AM, Stephen Hemminger wrote:
> On Sat, 13 Jun 2026 01:17:22 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>> tatic void print_inet(FILE *fp, struct rtattr *inet_attr)
>> +{
>> +	struct rtattr *tb[IFLA_INET_MAX + 1];
>> +
>> +	parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
>> +
>> +	if (tb[IFLA_INET_CONF] && show_details) {
>> +		int *conf = RTA_DATA(tb[IFLA_INET_CONF]);
>> +		int max_elements = RTA_PAYLOAD(tb[IFLA_INET_CONF]) / sizeof(int);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_FORWARDING)
>> +			print_string(PRINT_ANY, "forwarding", "forwarding %s ",
>> +				     conf[IPV4_DEVCONF_FORWARDING - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING)
>> +			print_string(PRINT_ANY, "mc_forwarding", "mc_forwarding %s ",
>> +				     conf[IPV4_DEVCONF_MC_FORWARDING - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP)
>> +			print_string(PRINT_ANY, "proxy_arp", "proxy_arp %s ",
>> +				     conf[IPV4_DEVCONF_PROXY_ARP - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS)
>> +			print_string(PRINT_ANY, "accept_redirects",
>> +				     "accept_redirects %s ",
>> +				     conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_SECURE_REDIRECTS)
>> +			print_string(PRINT_ANY, "secure_redirects",
>> +				     "secure_redirects %s ",
>> +				     conf[IPV4_DEVCONF_SECURE_REDIRECTS - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_SEND_REDIRECTS)
>> +			print_string(PRINT_ANY, "send_redirects", "send_redirects %s ",
>> +				     conf[IPV4_DEVCONF_SEND_REDIRECTS - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_SHARED_MEDIA)
>> +			print_string(PRINT_ANY, "shared_media", "shared_media %s ",
>> +				     conf[IPV4_DEVCONF_SHARED_MEDIA - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_RP_FILTER)
>> +			print_int(PRINT_ANY, "rp_filter", "rp_filter %d ",
>> +				  conf[IPV4_DEVCONF_RP_FILTER - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE)
>> +			print_string(PRINT_ANY, "accept_source_route",
>> +				     "accept_source_route %s ",
>> +				     conf[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_BOOTP_RELAY)
>> +			print_string(PRINT_ANY, "bootp_relay", "bootp_relay %s ",
>> +				     conf[IPV4_DEVCONF_BOOTP_RELAY - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_LOG_MARTIANS)
>> +			print_string(PRINT_ANY, "log_martians", "log_martians %s ",
>> +				     conf[IPV4_DEVCONF_LOG_MARTIANS - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_TAG)
>> +			print_int(PRINT_ANY, "tag", "tag %d ",
>> +				  conf[IPV4_DEVCONF_TAG - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARPFILTER)
>> +			print_string(PRINT_ANY, "arpfilter", "arpfilter %s ",
>> +				     conf[IPV4_DEVCONF_ARPFILTER - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_MEDIUM_ID)
>> +			print_int(PRINT_ANY, "medium_id", "medium_id %d ",
>> +				  conf[IPV4_DEVCONF_MEDIUM_ID - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_NOXFRM)
>> +			print_string(PRINT_ANY, "noxfrm", "noxfrm %s ",
>> +				     conf[IPV4_DEVCONF_NOXFRM - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_NOPOLICY)
>> +			print_string(PRINT_ANY, "nopolicy", "nopolicy %s ",
>> +				     conf[IPV4_DEVCONF_NOPOLICY - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_FORCE_IGMP_VERSION)
>> +			print_int(PRINT_ANY, "force_igmp_version", "force_igmp_version %d ",
>> +				  conf[IPV4_DEVCONF_FORCE_IGMP_VERSION - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARP_ANNOUNCE)
>> +			print_int(PRINT_ANY, "arp_announce", "arp_announce %d ",
>> +				  conf[IPV4_DEVCONF_ARP_ANNOUNCE - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARP_IGNORE)
>> +			print_int(PRINT_ANY, "arp_ignore", "arp_ignore %d ",
>> +				  conf[IPV4_DEVCONF_ARP_IGNORE - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_PROMOTE_SECONDARIES)
>> +			print_string(PRINT_ANY, "promote_secondaries",
>> +				     "promote_secondaries %s ",
>> +				     conf[IPV4_DEVCONF_PROMOTE_SECONDARIES - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARP_ACCEPT)
>> +			print_int(PRINT_ANY, "arp_accept", "arp_accept %d ",
>> +				  conf[IPV4_DEVCONF_ARP_ACCEPT - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARP_NOTIFY)
>> +			print_string(PRINT_ANY, "arp_notify", "arp_notify %s ",
>> +				     conf[IPV4_DEVCONF_ARP_NOTIFY - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_LOCAL)
>> +			print_string(PRINT_ANY, "accept_local", "accept_local %s ",
>> +				     conf[IPV4_DEVCONF_ACCEPT_LOCAL - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_SRC_VMARK)
>> +			print_string(PRINT_ANY, "src_vmark", " src_vmark %s",
>> +				     conf[IPV4_DEVCONF_SRC_VMARK - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP_PVLAN)
>> +			print_string(PRINT_ANY, "proxy_arp_pvlan", "proxy_arp_pvlan %s ",
>> +				     conf[IPV4_DEVCONF_PROXY_ARP_PVLAN - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ROUTE_LOCALNET)
>> +			print_string(PRINT_ANY, "route_localnet", "route_localnet %s ",
>> +				     conf[IPV4_DEVCONF_ROUTE_LOCALNET - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_BC_FORWARDING)
>> +			print_string(PRINT_ANY, "bc_forwarding", "bc_forwarding %s ",
>> +				     conf[IPV4_DEVCONF_BC_FORWARDING - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL)
>> +			print_int(PRINT_ANY, "igmpv2_unsolicited_report_interval",
>> +				  "igmpv2_unsolicited_report_interval %d ",
>> +				  conf[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL)
>> +			print_int(PRINT_ANY, "igmpv3_unsolicited_report_interval",
>> +				  "igmpv3_unsolicited_report_interval %d ",
>> +				  conf[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL - 1]);
>> +
>> +		if (max_elements >= IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN)
>> +			print_string(PRINT_ANY, "ignore_routes_with_linkdown",
>> +				     "ignore_routes_with_linkdown %s ",
>> +				     conf[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1] ?
>> +				     "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST)
>> +			print_string(PRINT_ANY, "drop_unicast_in_l2_multicast",
>> +				     "drop_unicast_in_l2_multicast %s ",
>> +				     conf[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST - 1] ?
>> +				     "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_DROP_GRATUITOUS_ARP)
>> +			print_string(PRINT_ANY, "drop_gratuitous_arp",
>> +				     "drop_gratuitous_arp %s ",
>> +				     conf[IPV4_DEVCONF_DROP_GRATUITOUS_ARP - 1] ? "on" : "off");
>> +
>> +		if (max_elements >= IPV4_DEVCONF_ARP_EVICT_NOCARRIER)
>> +			print_string(PRINT_ANY, "arp_evict_nocarrier",
>> +				     "arp_evict_nocarrier %s ",
>> +				     conf[IPV4_DEVCONF_ARP_EVICT_NOCARRIER - 1] ? "on" : "off");
>> +	}
>> +}
>> +
> There are three different ways to display a flag value in JSON used in iproute2.
> This one is my least favorite.
> 
> The three ways are:
>     - print_bool
>     - print_null (only if on)
>     - print_string
> 
> I would use the print_null pattern but print_bool would also be ok.
> 

Thanks for the suggestion Stephen, I would pick print_bool in this case.

If one of the options evolves to supporting something else we could 
easily adapt it without breaking compatibility if we use print_bool. If 
we use print_null I don't think we could do that.

Thanks,
Fernando.

