Return-Path: <netdev+bounces-269361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBEuF2e5u2mtmwIAu9opvQ
	(envelope-from <netdev+bounces-269361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:52:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C72C81A5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95B3130D9EE2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA336CDFA;
	Thu, 19 Mar 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjCpk/Fw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG8+UInv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE023ABBF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910308; cv=none; b=inVARwdLk9ggyfYCtz9U2K/eBO7rMzNzPCItdzjGcYaP1KKfqA6T1IflE/TBsgkJOTRI5/5jPZrvb1rQ3wkfccwRb6s7TWgkDmdGiuwYqUObHHHnRvVIZ2IWJnQwgu/tBVqiLegAFRW10q10DJCKMqbA1q12Z6qRoSDUK8xqXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910308; c=relaxed/simple;
	bh=Br9BQScBUUPcCFQA0zfnTlmLUs1Wh/NSaW7PhY2lHMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW0iTFJB17M8wPpJw2eUvWKY8Qfoz0/5yd0uKJZpYn54ri0hL/oN2fS3FPx33xcHPr9t8WjZ8eMDF1DgbkqQkW5Wn7Dr91hsB5A5jPdnS5M/Pb+Gbyec+DwViFS4+YcRcYe69ekbI3ByZqmawGodpwEPfhXP1QBZwYJw+c+2Q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjCpk/Fw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gG8+UInv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773910305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql+58h2xm+DbHGFLlAGGwYq66ZcmSTZUyEZ3u+sZqes=;
	b=JjCpk/Fwp5GGzl8HryJHquDJUklSTTp0ArW8KXGKA/PouzPKrWTCZcFSdwoHFO/33d0SFo
	N/29XEkFYAkH5Ti/S8CB8x56zqv1sfe1k24MpKqG195tpvcorrlnHHqZGT6ecsxqqRS6bc
	E7QAS9mJyK1SH2F6fq7R6ileepUtQb8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-GUfKTpXnO3uIssfmbcLe2w-1; Thu, 19 Mar 2026 04:51:44 -0400
X-MC-Unique: GUfKTpXnO3uIssfmbcLe2w-1
X-Mimecast-MFC-AGG-ID: GUfKTpXnO3uIssfmbcLe2w_1773910303
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b41d45be4so1315368f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773910303; x=1774515103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql+58h2xm+DbHGFLlAGGwYq66ZcmSTZUyEZ3u+sZqes=;
        b=gG8+UInvNulWOHjqSGlr/AJadjGj0EIpu/BH372WSB+yS7yyTis9WorQOeA0lf9Q4U
         N1IFixjgeGdJQZQRCgOMz5mOB678nO6cYV2mijuN36Qi+vTs4tKPTNIZvmVHdL01351s
         ZSb+VkQwTWF6EUN0swzv7+VCMbs7rJWM0Oie7D7GQPNtJSWczpZ1lB3IqEV83Pw6RZOA
         sBff2Cx6TB0i/a7frn1DWkvODoiuBTFSoOjVi4OHVCeqkRODJcD+Q/Sg1Ze82R6vhMC5
         mt/q9zhUNeR/9wBgjjmEY8Rs6bdaLZE00DZNiiWPnLB/f26wGgKYdOaN4IXzBD1ygptt
         coQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910303; x=1774515103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ql+58h2xm+DbHGFLlAGGwYq66ZcmSTZUyEZ3u+sZqes=;
        b=KMrsydH053VWtN6/7jxEvHH8eK6MS7cmsH/sFynFuV1lR5XUxnXiE/HmeTZ+nUtADX
         EqTNYqlSJolOWHjwsiHX7Y3bbszP7V5j+ZeiaRBzMC33F/uDPYHSVXAReAucCQ572MSt
         ppbBQndSXGMFDLdNMPBZFYLUEqYjFCU/EmBtUHtX7xacWDypw5RwK3UmjsB1G0TsV97T
         FNRyTwAxWNrcrTovc94ttpNjwEtZrQqt0nb9SkjgtBSxnNdbomRZLRfrYm1j3PFVRkNB
         gzlUMHrkolUoQ1B/BDA2VdhHpt4DOwevcr4ysWJ2WsZrhqzPr5vc6+zOeE6Smml+eQyM
         SEAw==
X-Forwarded-Encrypted: i=1; AJvYcCVqCbbpHIOdvSXDHi6vHZ5CNg5lnISPPGKBTPqt7Bj6Z8I6KrMnlbNb3+5WDrH9PEgHH4XSmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7R9pwlf+eIJNE9APR2jdUZTPc5zugsJGwvcaj1PhIu743U5R
	unPiTNypWcElpciXEaaWuDxPJm8UM6FBSIjEuVsMu6msbe7G1/bPtNHmGYwfrEC80ZF4WH60nGC
	iXuE5nVGF7TL7cU7Na7bI5Ip1jfnPmyjVAsVn4aALk8hmgKnKOJY8h4QL3Q==
X-Gm-Gg: ATEYQzwHYCJA/xNecmKqDKXqG96QbsE5Pix7XlzR+RisBkfLBhM64RYLPyVufuiHuSD
	xTn9IfhhwMt+pJ6insDk1CG48FHFyL7eWy57kUzm4va2Ufp1xNvlaXUU60AIL2w6V024YSRPMju
	HIn50xlE7jGyV2+kufe39uKn8MPdAgpgIeIWPk1KJaEkpCJES5uE0kJFx/R0+J7qH0/7YHneB2i
	W5xQh0725zFIk5ARXKe+hfjHtlSkqECKf7mAATSh0UI0Z/fgST8MNIjJTXPm8X1ZSte/gWNMZmQ
	K9Zfemh6VoMsTxgI8Tx6Cr7P1ZJHpFlqgkSKlF0dMvmQlbHxLH0Xk7qQ2i75liS/zKe/32jJk53
	3HVbeRy4VlbEZpZTWuxFJdkzjYe4axcSFOL0qKTrMjDkckuuWn53eK6+I
X-Received: by 2002:a05:6000:2a05:b0:439:c560:bb79 with SMTP id ffacd0b85a97d-43b57723491mr3125232f8f.17.1773910302942;
        Thu, 19 Mar 2026 01:51:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2a05:b0:439:c560:bb79 with SMTP id ffacd0b85a97d-43b57723491mr3125207f8f.17.1773910302463;
        Thu, 19 Mar 2026 01:51:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm13915250f8f.24.2026.03.19.01.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 01:51:41 -0700 (PDT)
Message-ID: <16a4ac6c-abde-4121-9032-7626640facbe@redhat.com>
Date: Thu, 19 Mar 2026 09:51:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl862xx: implement bridge
 offloading
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
 Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu
 <lxu@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1773591297.git.daniel@makrotopia.org>
 <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-269361-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE2C72C81A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/15/26 5:20 PM, Daniel Golle wrote:
> +static int mxl862xx_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> +{
> +	struct mxl862xx_cfg param;
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_COMMON_CFGGET, param);

AI review says:

Is the param struct initialized here? Looking at MXL862XX_API_READ(), it
expands to mxl862xx_api_wrap() which writes the contents of the data buffer
to firmware MDIO registers before sending the GET command. This would send
uninitialized kernel stack data to the firmware hardware.

Every other MXL862XX_API_READ() call site in the driver uses a
zero-initialized struct. For example, in mxl862xx_setup():

	struct mxl862xx_cfg cfg = {};
	...
	ret = MXL862XX_API_READ(priv, MXL862XX_COMMON_CFGGET, cfg);

Should param be initialized with = {} here?


