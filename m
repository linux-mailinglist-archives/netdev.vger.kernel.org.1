Return-Path: <netdev+bounces-281013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH3HBn+T62m7OgAAu9opvQ
	(envelope-from <netdev+bounces-281013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BA461173
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09ED030098A2
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12883D9DD0;
	Fri, 24 Apr 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgotbT65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A642D595D
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046392; cv=none; b=QlFNXYYD1FgSeTFau4h5rtqY/OFCur6mkSFhyqEbCjevS5Iq/WWkAnTT/lMBRbWp8AMXiNu+uq79/d9sqGtdPV5cxOdQFIe2MXKLifkncq7efW5HVB7jrr0IYH83H9YQDntPz9w1/E+NguyC6J6MX5EcQQDQRRR2TXk+TUEb/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046392; c=relaxed/simple;
	bh=fLLA0XV7k5kScW1c0vuL4Q3cMsBVX5C6LlJN3+uWFro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW3wNrqC3hJOCFnnURAW8Trw+7U00WeOvVyY+hakG+BO8jvHqEoQDy6G1nid7zRdWV6yV6n6aIMmw+Zcg7i+q0/jt3BJUnXl8J3SOwMEvYc9NLr8bvGOplIM4V+rJeftaDTHiTRD0LuMVMrKZgMM2VaQg9P/P8sNBwv/FdpOlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgotbT65; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso5612989a91.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777046389; x=1777651189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7PO/ZXw0zVFmSU0lsST4kh3s+Ob34J+JzxOTnEfe2A=;
        b=cgotbT65j+mpgiOta8/gmMccIbo63UELAgU2TcF2xwPMZ7ATeVXhSmTWOYAUyG6sFy
         6h1RJKIYU79ktW2RVZ4e4mZ+Q15ng9swMll4/LH9TQStgULzC5ucMGobo6KK85yWONpK
         ezZLFSJhQFPSMqES/qJA85kNxRAhfwhYb3E8CY0+ewqY621NXXGmzO4aYqDUIfgilvNX
         oYb9KXIXs5Vke7PNGIoKc6ZRS3vL0upuOweqACBbWHyX82Hxyw3GV5W8QXnJO+71/WQF
         lyhn4HPbOVxo42hLvZIhEnKTGxPr9IFbImzWagwQTB00NQ4ZqLfHjf8t4WLzuadUs13B
         1r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046389; x=1777651189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7PO/ZXw0zVFmSU0lsST4kh3s+Ob34J+JzxOTnEfe2A=;
        b=X62lupf2iq06WMI5gcymx8eLHCt5QhA2+zZ2+yQICT1KdI7lKz2Iod8Jx/K6rUZERr
         IYM5/8/Uk6yME+LO/VWw8td/6GxCjY4/EjsU+xsK2vRemJL7e2xqrATYqNzuRslk1mP4
         JfDgbV4THxrqDV2qHdomjRuQ3DJKOf63j5sKy23bR99WIkFwVkTz6gRMXr6KGShNkNrC
         wMPVcwfEg6XutwgnlRwB0gcPnfoh2L1jstJHdNz/eyDqKECjEgIfMu0chQFuMd5KS3um
         yMB/mw1fM1+fu4ZznADLUt0cUn+wW6WIJAgkhZWobMehNiHhrvG/qDEQOk2OfdMprgo+
         1uPA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q4Yn5GS5WnTr1Nm9L3aFak1JadIo2HHuwpo102tdhJDRGZZmiWd5luWKjqnEr/es8C588SMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdxrio2WLJn79Yk0QG/JAiwbrbVn6cdS3a0PQis4fMo4He3qF+
	KoRa97D8goC81pKvTl5tKwdsfUn5fDlcWKPYbnXObTj52FUV5B7y/gUW
X-Gm-Gg: AeBDieuN5mR3hAxJwtASr6jTkkub4J8VO0kYu/pQeDhr5N3zp1yWmRBzei3fns0Tnb7
	o7LfLKiZx21KlUMMaLCS9vQe9ICyfD1tfQZvD819OxZYDlGtCLcxr9aRZFC9iJrY4015cakLfRQ
	A3EFtTqyWnUSCa0jVwjG02Y/NPTC4yRCElPOdsL27BXPSxXClU2gzJoxZqB5GSwL9LsLyOYpVyG
	wT3SAYsSwtrumhP/NbwM0pBQ8+x1N6eqzlDiWlJgN+8HynwQn0FjDS22/PySjXvGGjhlwuwdjB4
	CHvuJUpYnh8ZeOq8/Qu0jY1KnaB7PlA1C/5meNqwvMkhiU/Pn7NWE/53w9I9iiy7uJVBkuiWWGg
	oNji5eQlncO2/s0hAaLM07jDAhXwgAw2Y00++bUbLTb91bBBBInxrb7uNFZy7gnP4p5jLNKoqtw
	rQUM9KexrwdiuMvurbxR6BolSE3yD3Ch7hCOH1Mg5Q+CUwADV2QlXo9uvaRJTBdv+kX788hwddb
	PSdyOb7rQ1m4mOLrQq/1Q==
X-Received: by 2002:a17:90b:5865:b0:35b:929f:7e8d with SMTP id 98e67ed59e1d1-3614046cdb7mr35181395a91.14.1777046389576;
        Fri, 24 Apr 2026 08:59:49 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140ff2e1esm23005042a91.8.2026.04.24.08.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:59:49 -0700 (PDT)
Message-ID: <00d5a8f8-64e3-4943-9082-51d4ceb1792a@gmail.com>
Date: Fri, 24 Apr 2026 23:59:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260420134506.35164-1-lucienzx159@gmail.com>
 <20260423102102.0192b7de@kernel.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260423102102.0192b7de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D87BA461173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-281013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


Jakub Kicinski 於 2026/4/24 上午 01:21 寫道:
> Since you need to repost to fix the fixes tag, plaese also improve the
> error handling
>
> On Mon, 20 Apr 2026 21:45:06 +0800 Lucien.Jheng wrote:
>>   static int an8811hb_probe(struct phy_device *phydev)
>>   {
>> +	struct mdio_device *mdiodev;
>>   	struct en8811h_priv *priv;
>>   	int ret;
>>   
>> @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
>>   		return -ENOMEM;
>>   	phydev->priv = priv;
>>   
>> +	mdiodev = mdio_device_create(phydev->mdio.bus,
>> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
>> +	if (IS_ERR(mdiodev))
>> +		return PTR_ERR(mdiodev);
>> +
>> +	ret = mdio_device_register(mdiodev);
>> +	if (ret) {
> goto err_dev_free;
>
>> +		mdio_device_free(mdiodev);
>> +		return ret;
>> +	}
>> +	priv->pbusdev = mdiodev;
>> +
>>   	ret = an8811hb_load_firmware(phydev);
>>   	if (ret < 0) {
>>   		phydev_err(phydev, "Load firmware failed: %d\n", ret);
>> -		return ret;
>> +		goto error;
> goto err_dev_create;
>
>>   	}
>>   
>>   	en8811h_print_fw_version(phydev);
>> @@ -1191,22 +1309,27 @@ static int an8811hb_probe(struct phy_device *phydev)
>>   
>>   	ret = en8811h_leds_setup(phydev);
>>   	if (ret < 0)
>> -		return ret;
>> +		goto error;
>>   
>>   	priv->phydev = phydev;
>>   	/* Co-Clock Output */
>>   	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
>>   	if (ret)
>> -		return ret;
>> +		goto error;
>>   
>>   	/* Configure led gpio pins as output */
>>   	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>>   				      AN8811HB_GPIO_OUTPUT_345,
>>   				      AN8811HB_GPIO_OUTPUT_345);
>>   	if (ret < 0)
>> -		return ret;
>> +		goto error;
>>   
>>   	return 0;
>> +
>> +error:
> err_dev_free:
>
>> +	mdio_device_remove(priv->pbusdev);
> err_dev_create:
>
>> +	mdio_device_free(priv->pbusdev);
>> +	return ret;
I will include this in the next patch.

