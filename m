Return-Path: <netdev+bounces-207156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171BB060B9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D924A2849
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455E218EBA;
	Tue, 15 Jul 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0eYyKurY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74802036E9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588193; cv=none; b=ZgCBTnNzaSPjyvoGXEVxSgHaK4nkiPqsfa4EsAkmbYttoAX//ylfQA1b+ATSJqHZsO+/aVM81VxJMhsbRevXOVoFIbjFEm1bQG9e4GGEr2AhxXv4xNRoXuX7RkswcFzx+tCUWOOJnFAu8O4qP0e6J5SrFibDRC1jPJVjlHoh048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588193; c=relaxed/simple;
	bh=rIJ5EQU1TpstLP7pxGtRopgbEYh1lL6YdJrh0LxEnDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W62fwhEHlLI+6EX6HTHZEaJ4gJJTnfpqYniqQ4FSbehG+RRdiopMfOqEFrVZJDOioOG8fbFwknausNrP+jsGb8We/OjCHBj13exYwK9TaK+S12Z1SCOQHPwKJ0RK+COl6VuH7rqQtmLgq/INouElp7/xWB/1uQT53Y+Ds/5Ve18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0eYyKurY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3134c67a173so5671042a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752588191; x=1753192991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRd6LKHKbvYO5hg8JiAEuAsxI+C/2xtpKZWe05UWxvM=;
        b=0eYyKurYZMRs9p6NZ+DYVhk6zlw5YQ6tK0+IDixe9Ca/+eQrv+PxgvahUo4g4aZlgX
         xzC6vJ3GCIGjq7iiEZrbWfwCdGxM3JZ4aapr7sBBFLzk4wgJ8P0gFLumMBZBbFupbAyj
         50mpGMlSb9Qgg9FAeA2VXpjwh9hJ3e7onhvw3A+3TFPtB9B4QZs/X+J+un7T+LP/ZJlE
         iRpc/9Z8DCT5QzajJsrCDtnnB4L4bCozqSbwnOcPfZmq3dzbwF4hsugcVMX2lMH57Ngd
         4M8q7j2qVURbKkEaqmLc3IF5C8UC2TknYXhgIJZ9avDAG7k0TNyvhsDk9uGxQIKcOkfK
         fR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588191; x=1753192991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRd6LKHKbvYO5hg8JiAEuAsxI+C/2xtpKZWe05UWxvM=;
        b=SLywmfZgLhHYrKyruRcM2bFFg0bCPMAR9+1I6UiqtJmEDDgyb6vHrkFGvWUN6WJGoj
         AlQiLUiPNoiRINZUqKtTi1Ic+zb0xTzR808bRrsz5fg75dvDiRgTNaVmXiD6p3HYfjMD
         Sit0RCIpKcSEPqwKW1vcpr8/8LggnVgRxWfKesFMGufwCkvmb5qZMBAajHbTRvYkO+Fp
         zac86Ktsozh4zELqiqbfqh9+gmJbX44etcl9AuNa/l44PVNt6mAPmeRtqpi493fauOqD
         ldlCMe9EQa6KsYsslWQSjPIugbfYqXoZmGJpVLeMDGWKF1C83UFpjrFWml0U8TvOtkFM
         j4OQ==
X-Gm-Message-State: AOJu0YxchW6oHIpZufv34Eh38+2MXdQ6T+/p0lxdm05OM/LUCevrLZVz
	TfeEYMXi7B5Urkyc7LarPQwfH3BAi+qgc+Vl90ZKk2wnJy2Y5lXTYE4J9UGuFP5VjZo=
X-Gm-Gg: ASbGnct2EKjhk0rC2XC2/wlueoi2D6TybwjBAwQ5hlOIeNUbINpL95bOVeYvBfeUlWE
	lNyaXJzkBXAykvTUFlcHXWIn4UwhpOgFDSAjVaUal4Dq5jaOTmwRBjq4Jsgf9PIFl63VJnUGzAa
	5wqQbhXXlGsfEBGbkjOudenaWWz0IWzg+7+zN1zKLCzeLkdsSat5Q7Yg15I7mXQ4JwkaEkWcBaJ
	rXwsh3p6BkLhHRBbpI9dDBb3o+RK76KfCeJ6Rw4cMfgy5jb7zsYFF/dJSGCfAWxgvjMNlk+7bID
	Gc57MX/oOvq0pdgCSkFfaO0rCUBkmQJesN/bucNEPKnB3NfWXYkfHdXHwGC3vozYQQwb8h50j3j
	NAHyDCXDmfdQOKncY9sngbZqo/0/aTJJ+w9l1NfHJAgtI8pNiAVwl0waPg53olaKkr2T+b/NwUc
	M=
X-Google-Smtp-Source: AGHT+IEKUA6gRNjEwqkzPbchvzo0CZOe65dmlYLmUDg+/W+2fKG8OBCt04k0TzP4/54Bml5DJ4OrXQ==
X-Received: by 2002:a17:90b:3b90:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31c4ccd99d8mr27655063a91.19.1752588190537;
        Tue, 15 Jul 2025 07:03:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de432317bsm108603145ad.108.2025.07.15.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:03:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:03:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v2 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
Message-ID: <20250715070308.63e8841f@hermes.local>
In-Reply-To: <20250714230613.1492094-2-wilder@us.ibm.com>
References: <20250714230613.1492094-1-wilder@us.ibm.com>
	<20250714230613.1492094-2-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 16:05:40 -0700
David Wilder <wilder@us.ibm.com> wrote:

> This change extends the "arp_ip_target" parameter format to allow for
> a list of vlan tags to be included for each arp target.
> 
> The new format for arp_ip_target is:
> arp_ip_target=ipv4-address[vlan-tag\...],...
> 
> Examples:
> arp_ip_target=10.0.0.1[10]
> arp_ip_target=10.0.0.1[100/200]
> 
> The inclusion of a list of vlan tags is optional. The new logic
> preserves both forward and backward compatibility with the kernel
> and iproute2 versions.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  ip/iplink_bond.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 108 insertions(+), 9 deletions(-)
> 
> diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> index 62dd907c..c4db68a7 100644
> --- a/ip/iplink_bond.c
> +++ b/ip/iplink_bond.c
> @@ -173,6 +173,53 @@ static void explain(void)
>  	print_explain(stderr);
>  }
>  
> +#define BOND_VLAN_PROTO_NONE htons(0xffff)
> +#define BOND_MAX_VLAN_TAGS 5
> +
> +struct bond_vlan_tag {
> +	__be16	vlan_proto;
> +	__be16	vlan_id;
> +};
> +
> +static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level, int *size)
No good reason to inline

> +{
> +	struct bond_vlan_tag *tags = NULL;
> +	char *vlan;
> +	int n;
> +
> +	if (level > BOND_MAX_VLAN_TAGS) {
> +		fprintf(stderr,
> +			"Error: Too many vlan tags specified, maximum is %d.\n",
> +			BOND_MAX_VLAN_TAGS);
> +		exit(1);
> +	}
> +
> +	if (!vlan_list || strlen(vlan_list) == 0) {
> +		tags = calloc(level + 1, sizeof(*tags));
> +		*size = (level + 1) * (sizeof(*tags));
> +		if (tags)
> +			tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
> +		return tags;
> +	}
> +
> +	for (vlan = strsep(&vlan_list, "/"); (vlan != 0); level++) {
> +		tags = bond_vlan_tags_parse(vlan_list, level + 1, size);
> +		if (!tags)
> +			continue;
> +
> +		tags[level].vlan_proto = htons(ETH_P_8021Q);
> +		n = sscanf(vlan, "%hu", &(tags[level].vlan_id));
> +
> +		if (n != 1 || tags[level].vlan_id < 1 ||
> +		    tags[level].vlan_id > 4094)
> +			return NULL;
> +
> +		return tags;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  			  struct nlmsghdr *n)
>  {
> @@ -239,12 +286,29 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
>  				NEXT_ARG();
>  				char *targets = strdupa(*argv);
>  				char *target = strtok(targets, ",");
> -				int i;
> +				struct bond_vlan_tag *tags;
> +				int size, i;
>  
>  				for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
> -					__u32 addr = get_addr32(target);
> +					struct Data {
> +						__u32 addr;
> +						struct bond_vlan_tag vlans[];
> +					} data;
> +					char *vlan_list, *dup;
> +
> +					dup = strdupa(target);
> +					data.addr = get_addr32(strsep(&dup, "["));
> +					vlan_list = strsep(&dup, "]");
> +
> +					if (vlan_list) {
> +						tags = bond_vlan_tags_parse(vlan_list, 0, &size);
> +						memcpy(&data.vlans, tags, size);
> +						addattr_l(n, 1024, i, &data,
> +							  sizeof(data.addr)+size);
> +					} else {
> +						addattr32(n, 1024, i, data.addr);
> +					}
>  
> -					addattr32(n, 1024, i, addr);
>  					target = strtok(NULL, ",");
>  				}
>  				addattr_nest_end(n, nest);
> @@ -507,12 +571,47 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			print_string(PRINT_FP, NULL, "arp_ip_target ", NULL);
>  		}
>  
> -		for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> -			if (iptb[i])
> -				print_string(PRINT_ANY,
> -					     NULL,
> -					     "%s",
> -					     rt_addr_n2a_rta(AF_INET, iptb[i]));
> +		for (int i = 0; i < BOND_MAX_ARP_TARGETS && iptb[i]; i++) {
> +			struct Data {
> +				__u32 addr;
> +				struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
> +			} data;
> +
> +			if (RTA_PAYLOAD(iptb[i]) < sizeof(data.addr) ||
> +			    RTA_PAYLOAD(iptb[i]) > sizeof(data)) {
> +				fprintf(stderr, "Internal Error: Bad payload for arp_ip_target.\n");
> +				exit(1);
> +			}
> +			memcpy(&data, RTA_DATA(iptb[i]), RTA_PAYLOAD(iptb[i]));
> +
> +			print_string(PRINT_ANY,
> +				     NULL,
> +				     "%s",
> +				     rt_addr_n2a(AF_INET, sizeof(data.addr), &data.addr));

I know you just moved this line, but can you shorten it, and use print_color_string?

			print_color_string(PRINT_ANY, COLOR_INET, NULL, "%s",
				rt_addr_n2a(AF_INET, sizeof(data.addr), &data_addr));

> +
> +			if (RTA_PAYLOAD(iptb[i]) > sizeof(data.addr) && !is_json_context()) {
> +				print_string(PRINT_ANY, NULL, "[", NULL);
> +
> +				for (int level = 0;

iproute2 follows kernel style and avoids using declaration in for statement

> +				     (data.vlans[level].vlan_proto != BOND_VLAN_PROTO_NONE);

paren not needed for single conditional.

> +				     level++) {
> +
> +					if (level > BOND_MAX_VLAN_TAGS) {
> +						fprintf(stderr,
> +							"Internal Error: too many vlan tags.\n");
> +						exit(1);
> +					}
> +
> +					if (level != 0)
> +						print_string(PRINT_ANY, NULL, "/", NULL);
> +
> +					print_uint(PRINT_ANY,
> +						   NULL, "%u", data.vlans[level].vlan_id);
> +				}
> +
> +				print_string(PRINT_ANY, NULL, "]", NULL);

Did you check the JSON output? Looks like it won't print the tags.

> +			}
> +
>  			if (!is_json_context()
>  			    && i < BOND_MAX_ARP_TARGETS-1
>  			    && iptb[i+1])


