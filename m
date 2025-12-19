Return-Path: <netdev+bounces-245500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADDCCF348
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D7B3301634E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3C2EC0A4;
	Fri, 19 Dec 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxQNk7ju";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk/t1bgK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E232D9796
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136980; cv=none; b=RDI16AzsAZSxxfW3NzQGYOmP+E7i74bxlbbzQ63Uxm8iXSWcKk8pymP6RZWIR0GaT7ww4qyIFvYj6dBjQ9jlK2Lfe6RnIDmWf2ApEaHWqNsysB535I0BV6EHTfu9LFklBCS6tsMdOLvZSUI3W1mjCFrEBRW448wnBs+9xi6rFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136980; c=relaxed/simple;
	bh=GiWcSuhwfhSwNHPv2dhlIDCY1StzMEtdf8zT0B4mPbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aH1C6gZlBxxxPzvARYmuJnLsZM9JOn1monf8bnrl5JPc7WrkWyWG9eYjslt4lA9WIVMvyuW8th7XHcLS66v0JdXRWRrhXjRSok6UmHHsmqj0/yjLb9fwb6H/OkFSidkf3Whm5/fVoqwloh0G7R3aaa21R2vR3FWmMTrEbEP0vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxQNk7ju; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk/t1bgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766136977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIYbt7grBQIHzw83Cnuftmwc7pNTj1PBMPieyzGvyRQ=;
	b=CxQNk7juqCryNkfew3vtia1E2t12ZEOWVm2+nnJoeG0wypH300KegvIEzJZP7MmyQsefry
	KhQJmTK7k1P+PgT7gTa+f4tGVpWWQLNSY+0MVX8B4jJd4ekCJWzFu/28jHobkLkUmOD318
	VRIGEkN2MoQOXN0V+R9FvgEwlDMhuPQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-iSKPGCJ7NDC68VStAH0c3Q-1; Fri, 19 Dec 2025 04:36:15 -0500
X-MC-Unique: iSKPGCJ7NDC68VStAH0c3Q-1
X-Mimecast-MFC-AGG-ID: iSKPGCJ7NDC68VStAH0c3Q_1766136974
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-432488a0ce8so1045921f8f.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766136974; x=1766741774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIYbt7grBQIHzw83Cnuftmwc7pNTj1PBMPieyzGvyRQ=;
        b=Pk/t1bgKfV65loeCyFK3co3+nzdjKE24sL5r+mT7eu6NIYU2haS3wZCp00cIUfQwFN
         Bh4pOaQ8QxU2IjUJHy913HOKoSqybRF6hiE7f1AfhXLnoEr442OKM62Z2xJ+69J9Hy9s
         hCOGEBMhT/d5RpfX4q+Wx0LgDQlTazQtcs6/vDvmeo2tnO7LqJdQ3CqZ758GkSdhd5Ub
         3TeClgy5QX9QTePfShbWhovXWtfbA0IOxX4+lcHlHIInFqmNuc3YPYnPwDc7Mn1pKRvH
         xyLo1x4xOtVbwJNF9+xrYvNlSANulZ5Xmsm55czmNDodRU5WUW7J1BYGDyfbSJPsuWUM
         hiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136974; x=1766741774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIYbt7grBQIHzw83Cnuftmwc7pNTj1PBMPieyzGvyRQ=;
        b=D6QFrRjOQ/v2XA4X8LGjcHXhuqXmhJnurnTyt+LUcxzQgdrNuOkbVpF127guMYVRCW
         nYympxUeYJD/JwYskq50Q7GGOXEXcn7CGz97jp5ECfAsfXZnAE3zUxGcLFRNYMmmm3OT
         ZWilOjnBJDEyPTK69zZaf70ni3WOB1oRFiLSl7j6LreJ1StIM+F+95tGLmRAJSJOJDgi
         31WseW682GudYNI9U03sWa+PrTz+bUroluuzLG6bVKi5ilvZoAFTiIkQcMujqvStstIS
         ++M4h2TuaJzswTVcRapAo+NugqUtJFME2/QfnDRoWBCtK6spLhq/VMNWqeNZIGUqhJGG
         gB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1xJgsDwyDFENHVQI7HgzFT+Ntx28AuoHnA5AXazsOu9sJmOf9qy2sUDUk7XCyjBw1irtLO5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQ6GOM+lbnUC9jDxLXzshTjLRKejsw2G90vxXgUW7EtJ4w7nA
	JefmsdcSEnycGrri5XCMurUV14SG/Akk4aA4Uks12mwIKZ8K1CidB7VpHx8PvwGuYbzvu2zfPrP
	z2weJsR2xXMnolr8iDzpPgX69+uYBJX1iuVBT8W/w3H9gn3biLkUG00w8Vg==
X-Gm-Gg: AY/fxX7JVDK/hn2rKYd7INc4EeoaitiHP7yf6g3C8R/WJvesyl11nWeqEQn1+XXT3rB
	txCaiqdGk7DmeAwRGCZrjQ1i/GcImle2ZIW3hkTuDyvkoULChGMDd+e8pIAN1QJapROIbp4v314
	hH5KvfuO/udZKCsqygOMqr0ZyNg0eVmcQl6iUeI0Uq7tK3DCVzW33LZRzVbNOVefItIqHzrSZvh
	9h5zdSzQvm8zGGWhNHZnTvoA/aNB7yqlyvcRn436/UQm8RmF6joy7UgtIvrfXnVt/O8TrKzrGa9
	tNa72bY62JQXV/PBTVsk94vj5OCQgJbmOYctQho0UFFdDNVQmJzBo+/PIDW6tuYwzBm4QAkNJIy
	nUVNY9HUbBLG9
X-Received: by 2002:a05:6000:2907:b0:430:f3fb:35fa with SMTP id ffacd0b85a97d-4324e708c5cmr2718423f8f.57.1766136973993;
        Fri, 19 Dec 2025 01:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCuR3cgSEQwzSvGYDAcne7PBu99GClzJIGuNqcNF5F1N1BF/0rlwj0Jbshv7zUfUIeX2+zeg==
X-Received: by 2002:a05:6000:2907:b0:430:f3fb:35fa with SMTP id ffacd0b85a97d-4324e708c5cmr2718385f8f.57.1766136973538;
        Fri, 19 Dec 2025 01:36:13 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm4195438f8f.35.2025.12.19.01.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:36:13 -0800 (PST)
Message-ID: <5356f427-3966-4d41-b4fd-11dcd1140505@redhat.com>
Date: Fri, 19 Dec 2025 10:36:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v3 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
To: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Rob Herring <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218173718.12878-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 6:36 PM, Marek Vasut wrote:
> Sort the documented properties alphabetically, no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.



