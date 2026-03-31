Return-Path: <netdev+bounces-273650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPeyBjnWy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83E36ABCC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABC8301D304
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A253B19CB;
	Tue, 31 Mar 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7JkmLEM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3737F00F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966086; cv=none; b=JDIzTCu6K/f8YoSyZdtvnpT06GxbG7KgoYY9Tt+zNIcqqeuH0sRrPCBVsluodqYOeMvg5blQdsZ7/UkBrY6vwhP46smqOxEXwoOT2tL+dpdV1TjKQ3qC1manxsNPjjlMMwboNGMBzyqMTdIZvcUGz5XnGngS1Famct+xiGmZT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966086; c=relaxed/simple;
	bh=Jjt9h28K/efF1DLFVPvfSInSg0iZzSoQRCCkWo4ClG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKBmIoW3Y6yTj1dd1n5d0ALlRIbAWevMDLIbqUu9jRu2DoaElN9G+quuuFEQ5wx+BSi9b4Ul6Q9BWsbhVsNw9jLvxieP1wkCCHORNMnavYOKvni2KbgRVDRcNajnC4PXuG55FkP2rpWIrPqVFEMeF68zBSBpXHMmQCQJi+RGg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7JkmLEM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774966084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrkkKkdPmXNnW3vEUmI64XD06nYdlkwzWMbGo4m1/Xg=;
	b=D7JkmLEMjv87XJOc2MaxirNayWMB4ZQ2gl4CYW3RPXbUrU3ZWVmRoR6H+whZfWUNYfTa4i
	2Fq2TVq3bKLAWjAf0usPhEooUmWMbbIYuwuSJh/7UqCkncmjSmXrgh/hBpoIdAxcVtCp8x
	MeYL5krgD5/8P35D1hFFk99MWGz3uAc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-OifO1yLMNGC9v8pg6wL33w-1; Tue,
 31 Mar 2026 10:08:02 -0400
X-MC-Unique: OifO1yLMNGC9v8pg6wL33w-1
X-Mimecast-MFC-AGG-ID: OifO1yLMNGC9v8pg6wL33w_1774966081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DB0819560A2;
	Tue, 31 Mar 2026 14:08:01 +0000 (UTC)
Received: from [10.44.49.213] (unknown [10.44.49.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AA9318002A6;
	Tue, 31 Mar 2026 14:08:00 +0000 (UTC)
Message-ID: <ebcd7473-a674-40b6-8387-4b342b3a8e18@redhat.com>
Date: Tue, 31 Mar 2026 16:07:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] dpll: add direction and state filtering for
 pin show
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org
References: <20260331135918.49567-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260331135918.49567-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273650-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E83E36ABCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 3:59 PM, Petr Oros wrote:
> Allow filtering pins by direction (input/output) and state
> (connected/disconnected/selectable) in the pin show command.
> These filters match against parent-device nested attributes and
> can be combined with the parent-device filter to check a specific
> parent-device relationship.
> 
> Example: dpll pin show parent-device 0 direction input state connected
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   bash-completion/dpll | 11 ++++++-
>   dpll/dpll.c          | 71 ++++++++++++++++++++++++++++++++++++++++++--
>   man/man8/dpll.8      | 23 +++++++++++++-
>   3 files changed, 100 insertions(+), 5 deletions(-)
> 
> diff --git a/bash-completion/dpll b/bash-completion/dpll
> index 5913c894dda96e..981c3edbf367b0 100644
> --- a/bash-completion/dpll
> +++ b/bash-completion/dpll
> @@ -185,10 +185,19 @@ _dpll_pin()
>                           int-oscillator gnss" -- "$cur" ) )
>                       return 0
>                       ;;
> +                direction)
> +                    COMPREPLY=( $( compgen -W "input output" -- "$cur" ) )
> +                    return 0
> +                    ;;
> +                state)
> +                    COMPREPLY=( $( compgen -W \
> +                        "connected disconnected selectable" -- "$cur" ) )
> +                    return 0
> +                    ;;
>                   *)
>                       COMPREPLY=( $( compgen -W "id parent-device parent-pin \
>                           module-name clock-id board-label panel-label \
> -                        package-label type" \
> +                        package-label type direction state" \
>                           -- "$cur" ) )
>                       return 0
>                       ;;
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index 634b8fd1976ffd..0afc2b4213180d 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -162,6 +162,17 @@ static int str_to_dpll_pin_state(const char *state_str, __u32 *state)
>   	return 0;
>   }
>   
> +static int str_to_dpll_pin_direction(const char *dir_str, __u32 *direction)
> +{
> +	int num;
> +
> +	num = str_map_lookup_str(pin_direction_map, dir_str);
> +	if (num < 0)
> +		return num;
> +	*direction = num;
> +	return 0;
> +}
> +
>   static int str_to_dpll_pin_type(const char *type_str, __u32 *type)
>   {
>   	int num;
> @@ -921,6 +932,8 @@ static bool dpll_device_dump_filter(struct dpll_device_filter *filter,
>   #define DPLL_FILTER_PIN_TYPE		BIT(5)
>   #define DPLL_FILTER_PIN_PARENT_DEVICE	BIT(6)
>   #define DPLL_FILTER_PIN_PARENT_PIN	BIT(7)
> +#define DPLL_FILTER_PIN_DIRECTION	BIT(8)
> +#define DPLL_FILTER_PIN_STATE		BIT(9)
>   
>   struct dpll_pin_filter {
>   	uint64_t present;
> @@ -932,6 +945,8 @@ struct dpll_pin_filter {
>   	__u32 type;
>   	__u32 parent_device_id;
>   	__u32 parent_pin_id;
> +	__u32 direction;
> +	__u32 state;
>   };
>   
>   static bool filter_match_nested_id(const struct nlmsghdr *nlh,
> @@ -953,6 +968,39 @@ static bool filter_match_nested_id(const struct nlmsghdr *nlh,
>   	return false;
>   }
>   
> +static bool filter_match_nested_parent_device(const struct nlmsghdr *nlh,
> +					      struct dpll_pin_filter *filter)
> +{
> +	const struct nlattr *attr;
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		struct nlattr *tb_nest[DPLL_A_PIN_MAX + 1] = {};
> +
> +		if (mnl_attr_get_type(attr) != DPLL_A_PIN_PARENT_DEVICE)
> +			continue;
> +
> +		mnl_attr_parse_nested(attr, attr_pin_cb, tb_nest);
> +
> +		if ((filter->present & DPLL_FILTER_PIN_PARENT_DEVICE) &&
> +		    !filter_match_u32(tb_nest[DPLL_A_PIN_PARENT_ID],
> +				      filter->parent_device_id))
> +			continue;
> +
> +		if ((filter->present & DPLL_FILTER_PIN_DIRECTION) &&
> +		    !filter_match_u32(tb_nest[DPLL_A_PIN_DIRECTION],
> +				      filter->direction))
> +			continue;
> +
> +		if ((filter->present & DPLL_FILTER_PIN_STATE) &&
> +		    !filter_match_u32(tb_nest[DPLL_A_PIN_STATE],
> +				      filter->state))
> +			continue;
> +
> +		return true;
> +	}
> +	return false;
> +}
> +
>   static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
>   				 const struct nlmsghdr *nlh,
>   				 struct nlattr **tb)
> @@ -979,9 +1027,10 @@ static bool dpll_pin_dump_filter(struct dpll_pin_filter *filter,
>   	if ((filter->present & DPLL_FILTER_PIN_TYPE) &&
>   	    !filter_match_u32(tb[DPLL_A_PIN_TYPE], filter->type))
>   		return false;
> -	if ((filter->present & DPLL_FILTER_PIN_PARENT_DEVICE) &&
> -	    !filter_match_nested_id(nlh, DPLL_A_PIN_PARENT_DEVICE,
> -				    filter->parent_device_id))
> +	if ((filter->present & (DPLL_FILTER_PIN_PARENT_DEVICE |
> +				DPLL_FILTER_PIN_DIRECTION |
> +				DPLL_FILTER_PIN_STATE)) &&
> +	    !filter_match_nested_parent_device(nlh, filter))
>   		return false;
>   	if ((filter->present & DPLL_FILTER_PIN_PARENT_PIN) &&
>   	    !filter_match_nested_id(nlh, DPLL_A_PIN_PARENT_PIN,
> @@ -1892,6 +1941,22 @@ static int cmd_pin_show(struct dpll *dpll)
>   						   str_to_dpll_pin_type,
>   						   "mux/ext/synce-eth-port/int-oscillator/gnss"))
>   				return -EINVAL;
> +		} else if (dpll_argv_match(dpll, "direction")) {
> +			if (dpll_filter_parse_enum(dpll, "direction",
> +						   &filter.direction,
> +						   &filter.present,
> +						   DPLL_FILTER_PIN_DIRECTION,
> +						   str_to_dpll_pin_direction,
> +						   "input/output"))
> +				return -EINVAL;
> +		} else if (dpll_argv_match(dpll, "state")) {
> +			if (dpll_filter_parse_enum(dpll, "state",
> +						   &filter.state,
> +						   &filter.present,
> +						   DPLL_FILTER_PIN_STATE,
> +						   str_to_dpll_pin_state,
> +						   "connected/disconnected/selectable"))
> +				return -EINVAL;
>   		} else {
>   			pr_err("unknown option: %s\n", dpll_argv(dpll));
>   			return -EINVAL;
> diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
> index 479e5ed9871eeb..4213ae7a494fb8 100644
> --- a/man/man8/dpll.8
> +++ b/man/man8/dpll.8
> @@ -169,7 +169,7 @@ Device type:
>   
>   .SH PIN COMMANDS
>   
> -.SS dpll pin show [ id ID ] [ parent-device DEVICE_ID ] [ parent-pin PIN_ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ]
> +.SS dpll pin show [ id ID ] [ parent-device DEVICE_ID ] [ parent-pin PIN_ID ] [ module-name NAME ] [ clock-id ID ] [ board-label LABEL ] [ panel-label LABEL ] [ package-label LABEL ] [ type TYPE ] [ direction DIR ] [ state STATE ]
>   
>   Display information about DPLL pins. If no arguments are specified,
>   shows all pins in the system.
> @@ -211,6 +211,22 @@ Show only pins with the specified package label.
>   Show only pins of the specified type:
>   .BR mux ", " ext ", " synce-eth-port ", " int-oscillator ", " gnss .
>   
> +.TP
> +.BI direction " DIR"
> +Show only pins that have a parent-device relationship with the specified direction:
> +.BR input ", " output .
> +When combined with
> +.BR parent-device ,
> +only the specified parent-device relationship is checked.
> +
> +.TP
> +.BI state " STATE"
> +Show only pins that have a parent-device relationship with the specified state:
> +.BR connected ", " disconnected ", " selectable .
> +When combined with
> +.BR parent-device ,
> +only the specified parent-device relationship is checked.
> +
>   .PP
>   Output includes:
>   .RS
> @@ -401,6 +417,11 @@ Press Ctrl+C to stop monitoring.
>   .B dpll -jp pin show id 5
>   .fi
>   
> +.SS Show connected input pins on device 0
> +.nf
> +.B dpll pin show parent-device 0 direction input state connected
> +.fi
> +
>   .SS Set pin frequency to 10 MHz
>   .nf
>   .B dpll pin set id 0 frequency 10000000

Hi Petr,
thanks for this!

Tested-by: Ivan Vecera <ivecera@redhat.com>


