Return-Path: <netdev+bounces-149658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD99E6AF7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C505A1882018
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2311E130F;
	Fri,  6 Dec 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0+ZLDWOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D19F115
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478361; cv=none; b=pffFmcCSrLqnIXH2V9+tlzdFoJFM0J+m3wqed28wTVSjByJ161OLlhI9VdqqbD9JU/0OEGDu6JmhRMUW3l2/8blWILI5r2HaoBVnSn+zCKVA4yjYbVdaFO8wxz481DGdOozHntn+zn+WW4d7jDV6fRsVXBO2woHcfdKHlEWrCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478361; c=relaxed/simple;
	bh=S89ZoYdlTVuIzfeGCMsYj433cOSJtEfLRRBger7Adnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQuO8WZLwJGnrC1S2tkuN57st8GoOYgbKssAH16OrDTYCfqyqn68svloABCcb5ewHuL7qiL3tfDnQOb1r/A8pD7HcyJ+oVNZG4GKPNQKjAEx1/zD62CDLlJYQlNNfQ38LwEebQ/jlHLjzEosBh+QjCeOIfIPkkujmRh1IM0g6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0+ZLDWOi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0bf6ac35aso2445759a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478358; x=1734083158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CFq0KRofkiCY50Nk+lWFtQIfqY+kXAlwju7bKYqB+U=;
        b=0+ZLDWOivggy2Z++kwoTSrmzJqhRDI7CGY/GDMk3J/NBWy6Lazdh5nelXnu3XbMP1m
         nlDh2s/Wu8uCTlqkMg2x+rUJ0UPwhMMhJwB8saWNNh374xqe7o5GWzaHuwqyAvKkfQDo
         ULTUNAHHTotlPBW3YplbDiuaECFjCxIHu+p4d9KEaZR0VDQrz9wtHbWDN9DhT+0nQcT2
         HbRf/RpQme4h0tCh6ERrKmYDcYeOQKIaN8oNAOEGhkm2u2HTz+zIXe9iQAGwF3bPgsdM
         qroE2+ZAEHoujpRPVSchGLHz11jUudOYwfn66ilDDYSluYZyTlUMIrj2pXkp/FymZ66M
         z2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478358; x=1734083158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CFq0KRofkiCY50Nk+lWFtQIfqY+kXAlwju7bKYqB+U=;
        b=MnoxHhztyUyFh70TPWLyWUj5X3LBhwrZCsG05FNZF/rPA345dCaSb73sqJCD+KAUiH
         go5eI4Pzbivl8+n+nfb6nQQYQB6Gt1NXIbc6hY0CIx0Lb39HhyS0BI0r5kBzkJDWqaRV
         QivD+xISthTFAjPAWqXIsHumtwrE+7Dd3w/KK3bm4cKUjJ09YWUs5LEXXrBCLHkVyh6J
         Vz25awvgYm+hi7Rm6C3mMRtvoqN6NXVFNnHRgdGnngNJObD4L2riXRiuOPfmESRI4x/x
         jAh+aW7Iqd1dfdhEnJDWxOYflNRpBmEp4auFwEKEUY3gDmocWNKjMOpFQdY82WojpQyl
         OWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXEc8chUXcWsEM5blkmF9UGokW+M6Oqpa7tnMHGt5PYHlaMO83P9J/q+GtFL+gryOBDPX0HK8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeKxzuy7c4Kir+d1bhcJsFO+6CVVOouLR6z3WhOYkgSm50Er3
	vkdvAXCnSJzwltIVoEs3FhewiTylmSrJCzDtkfxQtpcKlXyA/eCoODwbiMW2lCc=
X-Gm-Gg: ASbGncuF2JdpNxTZGrTS7JRDAsXWc3mNN525KeUjtvETwEPt7byC8Ne7PilRY728rAJ
	KchkLqEOmgH7t8zVsFq3/OEswu7R4nwJ7uhT3A2E60itlH2BiCPqEkzQgeAZ8ozGuDnqZEZ6/AD
	BBTa9hpjWVZLuLbU7oMYtHXWhwOE4MKHLOgrztQe+iKr96dlQKAzlDm9BeQfCbr12ZgDeZ6Nbho
	U+mRoASB6v9Fa43esvr2xSHsIsc03EdMRBljIsP8rly23tk7GaQ
X-Google-Smtp-Source: AGHT+IGxGmOdOTehNnOAzn0DmQ547jCokCtbplYr1WD+1pLfDDrc6XJp5yJXqPEYK2Pc7e2kpyhakQ==
X-Received: by 2002:a05:6402:280f:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d3be6b8145mr4529291a12.19.1733478357996;
        Fri, 06 Dec 2024 01:45:57 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cda23bb7sm442665a12.60.2024.12.06.01.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:45:57 -0800 (PST)
Message-ID: <5a4f2b05-2b3f-4878-91c5-6c0444d34c4b@blackwall.org>
Date: Fri, 6 Dec 2024 11:45:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/11] vxlan: vxlan_rcv(): Drop unparsed
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <4559f16c5664c189b3a4ee6f5da91f552ad4821c.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <4559f16c5664c189b3a4ee6f5da91f552ad4821c.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> The code currently validates the VXLAN header in two ways: first by
> comparing it with the set of reserved bits, constructed ahead of time
> during the netdevice construction; and second by gradually clearing the
> bits off a separate copy of VXLAN header, "unparsed". Drop the latter
> validation method.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


