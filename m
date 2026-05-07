Return-Path: <netdev+bounces-285260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLhYKJ9x/GmkQAAAu9opvQ
	(envelope-from <netdev+bounces-285260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BB4E72F9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D36D3025A6A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D234DB72;
	Thu,  7 May 2026 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2TP8h3U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TayXTeFr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3173168EB
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151833; cv=none; b=GMQWI0cHIQ/nLasUJxgV/9CAx4h36NnCMypdrU/3GCPXUnUSJayw84kb0/sH5MCKR3mIYhar03FyDzOxbnXJn3i/SpCTXmp+4j7NP3lW+8VZmROpEbB+k7UycXqIPJ3uXy/GkCV/MX5R6j2HQ76vsgqvdEgrme3o5k/huCpVIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151833; c=relaxed/simple;
	bh=AW5KTQD6JJ+koVuSUIfKl7xusqNrOpHZz58nkZ4KQn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzUjEfNWFLlM5gc8ocvqGXoWinT+OFTSI2bXc4W15PSmsivdPT1vz6JJJu7MwGGMZ1ThLhYtc4EXuG5ucUz87eKtNjLgZU4WmwNw7isltmw+DdkjIiMiR4v2uhWS4G1b6isi9jd9Gtkh2bvZ2Z3J99R2P+yR8e1Pd00ZW6kuhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2TP8h3U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TayXTeFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778151831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUniSdMsdiQoFHzn4uWTGYzknL+ZqOJGdHgYphdXY2I=;
	b=a2TP8h3UNtj9o7Sma5CsGcV9KVtyrrxKkUg8aSYzv7gU3M4v3zQuPLOOUir0vKqPwHcow0
	7iBse/0TuEKejz1wmn6BPr8JkzBOfydSaTdZTnvAnXiYI0L68+LXQlMpZoLvZTxORLzTX6
	PtWg9tEU4JyaaSOoper0iPqfyR32AWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-iOCToWkqMX6u0D3S5Q5uog-1; Thu, 07 May 2026 07:03:49 -0400
X-MC-Unique: iOCToWkqMX6u0D3S5Q5uog-1
X-Mimecast-MFC-AGG-ID: iOCToWkqMX6u0D3S5Q5uog_1778151829
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449dcfe8005so608472f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778151828; x=1778756628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUniSdMsdiQoFHzn4uWTGYzknL+ZqOJGdHgYphdXY2I=;
        b=TayXTeFrPRB5IuxANDTXGu8EqZG7eK8Zz9s8hSJ0z3JEbNHUEfnZ5g9Y0AJ/zavMb/
         5XWLWgNL0keT2lEVg2TWDuiA6B1JlddYfauFzvfrwyc/isG+ZOxaAA1Ga/wzk1crqChy
         IImqU1ukowBB2O6wO7hgF9bG/IhpZRg/+ji/RUEqVIrLotE5ERbBRsUo764yIyyePzGp
         gF8/i2sf7fLsdC1iQNZ9Pfmo2gAcC+mGHZzy02amxOk1aa5XrboPOonkht1vQgqpC9bO
         fhFM8TZBBH10U395cuAVvBP2fHq1F+Yc5M59mxlz/RqpRa8N4xY545eizKNdZeLTP868
         Zp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151828; x=1778756628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUniSdMsdiQoFHzn4uWTGYzknL+ZqOJGdHgYphdXY2I=;
        b=BN7m4f4JBf9Phk2O5GzQpL+bswDakA+38XAk0eALVS/qh8NQz1ZAGQpYsBugp1TiWX
         lYkoYOLJFbVgDicbZj60DpfKPQre2iUfKgZgGrqk/5V27tRNtryaoZBFjq1NICG3YnKE
         PHfHzOuCOD28SqIaG9bNF53Nb6WB+FeU/+Er51JNaXWFyL5WhEX6uVoITj4EaP781ieC
         S/bHjd3YLzP0aAZio7Hi1sia4FC+1bCVxAPouH/vJVBvB/6OoOtPY1RepbW5b4mZZrwP
         4aUUwasXiKTCZZB2OZhJKiYJygb1axrkiXHTRoDNFbcf1VWPNXALnB5EiDjSWQZVBjlJ
         NQ5A==
X-Forwarded-Encrypted: i=1; AFNElJ8zOGX++r7AcHvBs4BMZhTz+LPDra2NaYw0H3tSKz+ifVj/dS00s6ymuit5ot3CVpgpF2NFpjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymdtJ8i2L8K9Ms3t+Vf8MCMQrjr9lysoUALIzkDUS4IncVoDI4
	t0zw2/C2JmVb10uqPzA/rvHZlkH1OCCh07skluSm2X5Z3JuwEpHasIANAybp0FEWz8kEBqL1vSJ
	FyV4gXwlW9FEl8NpIrl6iiwCqo61hgbalv4RQishyBq/xoo38VYRRT68fqlrP4RuCkA==
X-Gm-Gg: AeBDievsV+Pe+LjZ9z7o+ix3wlwyiFk2Kocbwm+kuoFwSCTVtieu93E8cXMiq3TpHX/
	JP65B9vi1l8O4WXYPGZfDc9sD+altbmPE0za+3ttZyTrRzFZfOENfBcHHb4RTUTCozObBcTML0f
	B51hbOw/52uvkYQZTOLal6C7uRbTzbuuDWmRPQeltOWIQ3K7SzeWY1eh1oM1lPvnrCdfAt7WgHd
	2MDkVLNRkxmIgPo4cMUM+YlgG5L69CRuJMVxqMYddrsMOkMUkKFwVqJwT2IPTQWfq3ABDVrG5Cv
	rr6EFBi04e/QhZNmeT1YzgCg9QGqiRhXd5jdy8kK1pDMPyUE2GwHEBEKDg3EqeBtKCLU24BcXuj
	4OBE8nkxaS9kn25eUFN0OVbeotHM0nBV7Qi2kH+LenAfRRfkirOpo8es8SQrg0jcGmA==
X-Received: by 2002:a5d:64e7:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-4515b42fbc4mr11792556f8f.11.1778151828184;
        Thu, 07 May 2026 04:03:48 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-4515b42fbc4mr11792474f8f.11.1778151827500;
        Thu, 07 May 2026 04:03:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d381c8sm18376896f8f.33.2026.05.07.04.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 04:03:47 -0700 (PDT)
Message-ID: <1cc38ea2-74ac-49f5-97b1-b9404726bdbc@redhat.com>
Date: Thu, 7 May 2026 13:03:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: openvswitch: make flow_table an rcu
 pointer
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "open list:OPENVSWITCH"
 <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
References: <20260505084253.998548-1-amorenoz@redhat.com>
 <20260505084253.998548-2-amorenoz@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260505084253.998548-2-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 205BB4E72F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285260-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 10:42 AM, Adrian Moreno wrote:
> @@ -752,12 +759,16 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
>  static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
>  			 struct ovs_dp_megaflow_stats *mega_stats)
>  {
> +	struct flow_table *table = ovsl_dereference(dp->table);
>  	int i;
>  
>  	memset(mega_stats, 0, sizeof(*mega_stats));
> +	memset(stats, 0, sizeof(*stats));

Is this an unrelated bugfix, preventing random values from stack
clobbering the stats? Should it land to a separate fix for net?

> @@ -1501,8 +1537,13 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		rcu_read_unlock();
>  		return -ENODEV;
>  	}
> +	table = rcu_dereference_ovsl(dp->table);

Possibly:
	table = rcu_dereference(dp->table);
would be more accurate

> @@ -518,6 +524,7 @@ void ovs_flow_tbl_destroy(struct flow_table *table)
>  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
>  	call_rcu(&ma->rcu, mask_array_rcu_cb);

This is always invoked after a rcu grace period, it would be probably
nice to follow-up, not necessarly in this series, moving the above
call_rcu together with the call_rcu(table). Such statements could be
bundled in a new helper.

/P


