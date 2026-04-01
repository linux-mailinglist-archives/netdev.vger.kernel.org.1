Return-Path: <netdev+bounces-274177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEepKkxOzWkWbwYAu9opvQ
	(envelope-from <netdev+bounces-274177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:56:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76437E424
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC4E31A05E7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A03F23B3;
	Wed,  1 Apr 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFhmvW6x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uKG3iR/0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45663E0C4A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060991; cv=none; b=Xlhwz4Yn9qz26oICpLGtrTvgGyTuRUqyRMD5aNxcParMjYizftYkTW3SUqkAIigaCYA2qSBewnQqnYFjLbY7bJHwLvh/XJ7eso6cbD6Z+ZxkN/CZENWDK04p04UH7l7z92hkB4HsUEYgfyGoHf6CFsiDFN0SZM6zjEP1ib+r4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060991; c=relaxed/simple;
	bh=rF2Gpipf/QbXqAiccQMe4YVjy/JRYxwqoF1uwpKVApM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JkhpZgiWC9SwvIWvqo9yohI+UFJUsFvvLUQOA3UAQrWSNvu8uaHaS6f1ntfY4aJZkbnLIvPy6gDMnO2gG6AvKLG6210B48jvS//NxQ6WgTXkDEYpz1sjXO5u5fNicSnwD6P1wbceRI6uNucc6dXaLld/RRP4BJMETUwYs1THF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFhmvW6x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uKG3iR/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775060988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crQDVEMNgZuDWbtP3Vrsa6F4kWYqeOFCExx6F21ipec=;
	b=HFhmvW6x7LN0wPY7L6QzYX4uDL05qUtRHCYwAZwjImlEqg2lUCRE6exrdV53U5oehNLx/Z
	BpgruTXwJVKTs0/YsFWgtOXgbqCIlZ8U2uVLXAR7jZEga6VvXDvhe2lGuR9fq+HaxjzucG
	y46J88CdrjiJE813uBLRoq6N2AYrjww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-33ZthzoeMhSIyJzglx2pEA-1; Wed, 01 Apr 2026 12:29:47 -0400
X-MC-Unique: 33ZthzoeMhSIyJzglx2pEA-1
X-Mimecast-MFC-AGG-ID: 33ZthzoeMhSIyJzglx2pEA_1775060987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fcc05b20so46299675e9.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775060986; x=1775665786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crQDVEMNgZuDWbtP3Vrsa6F4kWYqeOFCExx6F21ipec=;
        b=uKG3iR/0naPvOat6MkwrV6vo6eWxAboYqZIvy8rBIpPP4j1bE8nlX077KEmIPr5bei
         N3cPpRW1bEGChpip/vvEmtPSuqQh1UMquotlHZNGJwdnok721cNfvtU5Fm12QkRf5KXW
         KXwkSKUwVgBmFTnHRVTSSff69YUhwUmSp+yZZWKGQPasEZ3pnLFV7y07VRZaVePvB2vT
         rOvtyJ1pw0GQWz0+kD2xLP77yPKOD5A0AYX4+ZNBbeFOaFI0yKy8aTmIIimuibbFxdjX
         zNSO1nW8JNGc7MbqpkR+opPwB1ba1eYTaZ9IKbTHppJ9hLP6JXA/OfG7zpZpDFYao/6R
         wnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060986; x=1775665786;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crQDVEMNgZuDWbtP3Vrsa6F4kWYqeOFCExx6F21ipec=;
        b=eLfpzmspSlCMPQWEGNfCZS6v0Q9E2YGBH+ehJtMnoaGjNIpfudIvEqFOFxzLwHjAUC
         Y3r4iW1ZdU4dGcxkNS3SHY3watPX/jsIDc9e4vru/JnaI0wRdhFAdFoemR8ll7dAILXS
         BM1eZ3P0JjzvY63BDKZW/rB8QQYx9+48A14rR8ivbWaPKoNw/znLdE+RxT4Mh51EShz2
         5osyF830Mf5FoIx46bbpTpKPQa2qiuSYoLCUI4sy7Q4mcK30pjNl4qyMQdpcJyTtVaxo
         ghtqN2PNA/MSEmvmgXBBuuZsxSRMduUYpCmXE1ATXh/6FDLDhoz7fdtRKGt8LJXqcpi/
         0vIA==
X-Forwarded-Encrypted: i=1; AJvYcCUYmmt8OucfX+bl2jBGbz6hldJOlliyTF3bwmzBBSNxs0YzsNSaO5fq8lX0KgnH95bcRV/8R/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfto8Np7Yu5SKYwqmmR9r2biTrjfX2Sicdf9Uq6LnDclyvizQ
	ih/M/SoWB98lA9VnU44N6qZmqF2i3VZUkmJOYa8IkOdU9Ajs+Duo5TsE8xXSO6WnjSZwHaPsumt
	V6CSDKX4DllJugS8A52aEJINV2pv7Qt1Rbf0TgttKkHNmurwqQa54TsE5qw==
X-Gm-Gg: ATEYQzxGiM88Px3FBuwGXvtDXOubrjCbpb/nGQWc2OG9Mim80vZBt7b3yNOZU8ANX7+
	L+Wg63ClvXogeqRDiTxncR7L9X/e4mz6feFBXRCPl0r3SGsQ4nTM4TKJ87aLuX7+uqyayUXDgdD
	2GjAHBc3//hFPbFATYyLwGF4xLzsDLz7D8owRRTyIyH4KQgx7bFrtxfrYgyntSaJIqc3yNYDRLe
	1PL8dg+yPq3i8Qm7PfC1jcpVInu1I6CtWzvJGW7VXxI+rjxwAD9wBy8UZHfqCmd200pV7E3h3h+
	xIlGUAU5zw2JCcA1m5VZfhkIWjSPnfGKyPBUKHu3q2mmPOlTS3cZatEKz6MU5g4CE7EiQ6vr3Pz
	eY17Fas6p+3SbjzOSoocw9+gPpvwIsUkIMA==
X-Received: by 2002:a05:600c:524f:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-4888355df93mr73321805e9.3.1775060986414;
        Wed, 01 Apr 2026 09:29:46 -0700 (PDT)
X-Received: by 2002:a05:600c:524f:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-4888355df93mr73320895e9.3.1775060985641;
        Wed, 01 Apr 2026 09:29:45 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:11b1:10c1:fc96:ef02:f3ea:14e2:3716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93c014sm147639555e9.10.2026.04.01.09.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:29:44 -0700 (PDT)
Date: Wed, 01 Apr 2026 18:29:42 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
CC: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v3_2/3=5D_dpll=3A_a?=
 =?US-ASCII?Q?dd_frequency_monitoring_callback_ops?=
User-Agent: Thunderbird for Android
In-Reply-To: <ccb93d19-19a9-4dd9-8ac7-e0d41dbb884d@linux.dev>
References: <20260401091237.1071995-1-ivecera@redhat.com> <20260401091237.1071995-3-ivecera@redhat.com> <ccb93d19-19a9-4dd9-8ac7-e0d41dbb884d@linux.dev>
Message-ID: <CE3CDF40-CA7B-43A5-9DBD-A04FA37F4E57@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274177-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2F76437E424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vadim,

1=2E dubna 2026 16:47:21 SEL=C4=8C, Vadim Fedorenko <vadim=2Efedorenko@lin=
ux=2Edev> napsal:
>On 01/04/2026 10:12, Ivan Vecera wrote:
>> Add new callback operations for a dpll device:
>> - freq_monitor_get(=2E=2E) - to obtain current state of frequency monit=
or
>>    feature from dpll device,
>> - freq_monitor_set(=2E=2E) - to allow feature configuration=2E
>>=20
>> Add new callback operation for a dpll pin:
>> - measured_freq_get(=2E=2E) - to obtain the measured frequency in mHz=
=2E
>>=20
>> Obtain the feature state value using the get callback and provide it to
>> the user if the device driver implements callbacks=2E The measured_freq=
_get
>> pin callback is only invoked when the frequency monitor is enabled=2E
>> The freq_monitor_get device callback is required when measured_freq_get
>> is provided by the driver=2E
>>=20
>> Execute the set callback upon user requests=2E
>>=20
>> Reviewed-by: Vadim Fedorenko <vadim=2Efedorenko@linux=2Edev>
>> Signed-off-by: Ivan Vecera <ivecera@redhat=2Ecom>
>> ---
>> Changes v2 -> v3:
>> - Made freq_monitor_get required when measured_freq_get is present (Jak=
ub)
>>=20
>> Changes v1 -> v2:
>> - Renamed actual-frequency to measured-frequency (Vadim)
>> ---
>>   drivers/dpll/dpll_netlink=2Ec | 92 ++++++++++++++++++++++++++++++++++=
+++
>>   include/linux/dpll=2Eh        | 10 ++++
>>   2 files changed, 102 insertions(+)
>>=20
>> diff --git a/drivers/dpll/dpll_netlink=2Ec b/drivers/dpll/dpll_netlink=
=2Ec
>> index 83cbd64abf5a4=2E=2E576d0cd074bd4 100644
>> --- a/drivers/dpll/dpll_netlink=2Ec
>> +++ b/drivers/dpll/dpll_netlink=2Ec
>> @@ -175,6 +175,26 @@ dpll_msg_add_phase_offset_monitor(struct sk_buff *=
msg, struct dpll_device *dpll,
>>   	return 0;
>>   }
>>   +static int
>> +dpll_msg_add_freq_monitor(struct sk_buff *msg, struct dpll_device *dpl=
l,
>> +			  struct netlink_ext_ack *extack)
>> +{
>> +	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>> +	enum dpll_feature_state state;
>> +	int ret;
>> +
>> +	if (ops->freq_monitor_set && ops->freq_monitor_get) {
>> +		ret =3D ops->freq_monitor_get(dpll, dpll_priv(dpll),
>> +					    &state, extack);
>> +		if (ret)
>> +			return ret;
>> +		if (nla_put_u32(msg, DPLL_A_FREQUENCY_MONITOR, state))
>> +			return -EMSGSIZE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int
>>   dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
>>   				     struct dpll_device *dpll,
>> @@ -400,6 +420,40 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, s=
truct dpll_pin *pin,
>>   			    ffo);
>>   }
>>   +static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dp=
ll_pin *pin,
>> +				      struct dpll_pin_ref *ref,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	const struct dpll_device_ops *dev_ops =3D dpll_device_ops(ref->dpll);
>> +	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>> +	struct dpll_device *dpll =3D ref->dpll;
>> +	enum dpll_feature_state state;
>> +	u64 measured_freq;
>> +	int ret;
>> +
>> +	if (!ops->measured_freq_get)
>> +		return 0;
>> +	if (WARN_ON(!dev_ops->freq_monitor_get))
>> +		return -EINVAL;
>
>I think pin registration function has to be adjusted to not allow
>measured_freq_get() callback if device doesn't have freq_monitor_get()
>callback (or both freq_monitor_{s,g}et)=2E Then this defensive part can
>be completely removed=2E

Ok, make sense=2E=2E=2E Will move such check to pin registration function=
=2E=2E=2E

Q: with WARN_ON or without?

Thanks=20
Ivan


