Return-Path: <netdev+bounces-274540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN3pAjRtzmmpngYAu9opvQ
	(envelope-from <netdev+bounces-274540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A5389933
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D120930EA91A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3683E3C58;
	Thu,  2 Apr 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iItLOhom";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO9DE3m3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABD3921CE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135199; cv=none; b=Vzk/KwHvWXM5bFJ7IqXOlVHOpAdEfdsPsZTVtSrfrdFBP38D4nk26VdSQH9d4zreiZ6L5orBbhJUdYY6wPkVjZZypXbfVGi9XTbKt2uRTW2ATVHnLeO58XBU/JSHbm5bVSdqvyFci1l6HhdZ5wfxs1Sf45ELBsVxRcJhCXrq/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135199; c=relaxed/simple;
	bh=fLISTcpkq3vlQbd3myrhqO+dyl+JVGQYoiohUrWpfMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/AYGmcNg2FedVJnFKI+fh8DALls5w1wYzUTv+YmfyJSsH60kruqEyJP2b89fpkr6AmVwQVyVD8I2IODZOaOnNvG9505WhIbfrngvtfRm11KrcbSmEp7IvKCCO0zfrlSdQBU50sgvxk9vv2aJbK3yw/6jDG2LmotwP2c0PKSQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iItLOhom; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BO9DE3m3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775135191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZfYOudIChwa/S+tLKsP2bUZS1mOOgqBWmRnN94V3MM=;
	b=iItLOhomowqDDzgDDwIhnq2PsCxvAiEYwuhIruaFAWPzlo/APRacG5p2ue+5S42X/QV8nL
	KeQGQVHYwsQevP60lGuzg+qVqM6Eq7en09RmzzByJ2jgGxWRI5CuIbbW0Uav5IcgKOdXR/
	RMtREobrqt6Psg9xNYHUJjHZk96Y9/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-MDe7mnNnMgaCKOUxP8eFGg-1; Thu, 02 Apr 2026 09:06:30 -0400
X-MC-Unique: MDe7mnNnMgaCKOUxP8eFGg-1
X-Mimecast-MFC-AGG-ID: MDe7mnNnMgaCKOUxP8eFGg_1775135189
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so9122455e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775135189; x=1775739989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZfYOudIChwa/S+tLKsP2bUZS1mOOgqBWmRnN94V3MM=;
        b=BO9DE3m3rGbOkzMWrLE3k1pSA1i8/UA4q02JgUJ8T5aZQTIUumwyvAa2cTGiHpi7IC
         Uvue0usgIBlgqdS9Nv2KyWT5WBjba8oKrrZk6vegWIhCW+g6hwWRp6icR532l2CJOMFP
         tbGYTJIoHRum9QXvCwH58NCq5S1JfA3ZtgUXspBeVgtXtk70sWcBW2/rk+NYINfgBPlH
         YEwt6CauWm12qij3ZuEgXu9vy/rypkuGRvzj4zl0DBt0u5wx3uiI+m/ze+WmiP45PBRw
         1whCOQI4AnL8TnoJuwrq9I1lwiJ8cyOvyJFoIaObNMunsz9BadLXsEPZlu95UYRllmLO
         mFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135189; x=1775739989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZfYOudIChwa/S+tLKsP2bUZS1mOOgqBWmRnN94V3MM=;
        b=ndzN6uCSZZOsp5sttkm5AGN46ORTB9NmEPf91alaveTDtT3NRG0s4uFUZoaTEPZrJP
         lKt1Pwq5Ba/ewOHmPYiZ0MIBmqjWPITr5R0LLAn1ezCQz8OV4itqVIa/a7p8+ruYn3ly
         H+ZS3Mi4IpvINmJAOdNMZKqN6K3zFcCWmAifcMykQ57kZfrmPxiRyJxzCcqS7+IbfIj0
         Rh08OsyGMCT8nCL2TvqIEJ5V5HK5ObPqawz5ipmMD5uPIl916ppFogBg67JjhjgQ4sr5
         5SoLECZgps55D08n7EmSRLu8SOVFl7IcoFKaYIUslCv8Zm++HKQnkWF5n161+Ac51wBV
         Z+4g==
X-Gm-Message-State: AOJu0YyLG22L6agMauc5teMNa8Sc47Szbn3us/Bd8W1EAOvZaus0e53s
	RERzWkcdV2r+ymJK9r8godWIFZkfj1lz1fKoLvan8ZWfUKjJW9UqvzhIFbT7y41Mb15rXIdwX9G
	OHg62TYF/xnIqiDYM39t3JzVfVnpiRXJcDIddylEQxsj5a+SgMSfXarG6QQ==
X-Gm-Gg: ATEYQzwFDPOHZ5heX83bGVo7OTn45Cs2168p+KJ6u7h2h+GYsZdwnJGsDaHSinH+5LL
	psbHyJhCqwqVzb2V4In5QOHoKT31zAMIunVXHzrEXycYbNleXCpnceRiE4VbsMtSF38KY1HTKF6
	2T4juZbpPhLLciHfdv3yorr9S8zJAnkdzAcl0aC6VdmR8HnX2Bd0Y9Es9kfnVJ1SdkF22KzVvhq
	ckKDsxt/nxVXIib+0+Zj7t1dgebwsHiq1GYslt9JomARTLJWKGT1/+t9Ff4SomET/+cQumT4kix
	GMCIkO2l/6V4J0IHgTPZc5XHLWJ01AMZPL2kBHzVDnNZyixdfp5cxwv2EkoRUHfLYOu7+4t6mGD
	vQO3zTX6LF53ILnQiFWT4+zQ+yNjPmuJcCGfMNaYW7GWHIuiKBiTcocoWHA==
X-Received: by 2002:a05:600c:3508:b0:488:95d0:ee46 with SMTP id 5b1f17b1804b1-48895d0ef40mr7906265e9.19.1775135189409;
        Thu, 02 Apr 2026 06:06:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3508:b0:488:95d0:ee46 with SMTP id 5b1f17b1804b1-48895d0ef40mr7905695e9.19.1775135188911;
        Thu, 02 Apr 2026 06:06:28 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm8306210f8f.33.2026.04.02.06.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:06:28 -0700 (PDT)
Message-ID: <09e99e68-f7b1-415d-b1ed-efe632432222@redhat.com>
Date: Thu, 2 Apr 2026 15:06:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/13] net: renesas: rswitch: add handler for
 FDB notification
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260331-rswitch_add_vlans-v3-0-c37f41b1c556@renesas.com>
 <20260331-rswitch_add_vlans-v3-12-c37f41b1c556@renesas.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260331-rswitch_add_vlans-v3-12-c37f41b1c556@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274540-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 943A5389933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 12:04 PM, Michael Dege wrote:
> +/* called under rcu_read_lock() */
> +static int rswitch_switchdev_event(struct notifier_block *nb,
> +				   unsigned long event,
> +				   void *ptr)
> +{
> +	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
> +	struct rswitch_switchdev_event_work *switchdev_work;
> +	struct switchdev_notifier_fdb_info *fdb_info;
> +	struct switchdev_notifier_info *info = ptr;
> +	struct rswitch_private *priv;
> +	int err;
> +
> +	priv = container_of(nb, struct rswitch_private, rswitch_switchdev_nb);
> +
> +	switch (event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		fallthrough;
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
> +
> +		if (!switchdev_work)
> +			return NOTIFY_BAD;
> +
> +		switchdev_work->ndev = info->dev;
> +		switchdev_work->priv = priv;
> +		switchdev_work->event = event;
> +
> +		fdb_info = container_of(info,
> +					struct switchdev_notifier_fdb_info,
> +					info);
> +
> +		INIT_WORK(&switchdev_work->work, rswitch_switchdev_bridge_fdb_event_work);
> +
> +		memcpy(&switchdev_work->fdb_info, ptr, sizeof(switchdev_work->fdb_info));
> +
> +		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
> +		if (!switchdev_work->fdb_info.addr)
> +			goto err_addr_alloc;
> +
> +		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
> +				fdb_info->addr);
> +		dev_hold(ndev);

Please switch to netdev_hold()/netdev_put(), providing a suitable
netdevice_tracker.

/P


