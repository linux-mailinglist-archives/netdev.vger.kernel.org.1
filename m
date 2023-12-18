Return-Path: <netdev+bounces-58615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FBB817836
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4884F281A48
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A824FF99;
	Mon, 18 Dec 2023 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="c6p+/Aj3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD449894
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc6b5a8364so16973471fa.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702919517; x=1703524317; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0myEz5mmchGFFDsQbXns7h4YnoVDFFYY18sAmSR5NYY=;
        b=c6p+/Aj3+dXaDykVOazNClFUONN+ftmKUh/LFWladsUSGY8wOCJ03U6uoCCjyGCOmT
         +oLy+7aSbWly3Tdo+Mr8zuJ6QfsWZWwHGmSIbtxY5h1NFtrN9GfOyQxWmcKWwMVs4CWq
         XDdDDqfpRIvNEWS0nliAxSUhXg/foXInLQaXFEgwQt/4d7KOmqZNKHwuuJ0q1PDit9zJ
         Y3pc/zAS8wMizdOsbfa2D73BMzz0iC7blagSY+HTXLSfkbtdR8UoBJiQGK4gk5qupoYk
         /9b/vGf1ktWRnlubh4lyYCMUe3VStaCFwp+raplRmItG8Le0Nb3nq1fmXjjGcuv8ALRN
         arkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919517; x=1703524317;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0myEz5mmchGFFDsQbXns7h4YnoVDFFYY18sAmSR5NYY=;
        b=TQ/V53IOwuyCpMmtgnjXJt5dDx9iT9obek8sqissO1ujaURQavL+rFDcKwUq+BuwCU
         NnygXpy0KZoZABebV6+JYttcLiWQS/7+R7HM0klngL1a+6uSja3KBB/lMdouaBcikSt4
         IQ7YnGB3jcof2XFrQxF3GXhtffLtD4p4/4RzD4d7qiB21BsI2uW65nbpiMTpv7CJ3svq
         srLXJ/+57litaHm07w8N3NVhdB5K+x68qqjRFzDu3r1saYVaDirFAYVDcK9Ow5LbifPV
         l4dLhSjqSYcjyOB7yP15UPrbLIwBA8YjXH6/vQShdLUVOsfiKS8eOnwfDSwePcnVH+Rg
         67vw==
X-Gm-Message-State: AOJu0YygRAsJPIbOQfcI4lot3YLyozVtatX9ha4bgEi3vuArRUgDfnEn
	AHF/v/cf0M/AodYD6+TB6L4pDA==
X-Google-Smtp-Source: AGHT+IGcn7F+LIf2qkEpwynVxjLM9eahi6pgLIyCebHo8kn2zHVzzmtiiBJ120axFEkVs5fTXnXAZw==
X-Received: by 2002:a19:e007:0:b0:50c:2218:7f1e with SMTP id x7-20020a19e007000000b0050c22187f1emr6616472lfg.16.1702919517283;
        Mon, 18 Dec 2023 09:11:57 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512398a00b0050e223d5125sm832508lfu.55.2023.12.18.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:11:56 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
 kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
In-Reply-To: <627fbf7d-5992-4c4b-9e32-b34e363db928@lunn.ch>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
 <627fbf7d-5992-4c4b-9e32-b34e363db928@lunn.ch>
Date: Mon, 18 Dec 2023 18:11:55 +0100
Message-ID: <871qbj8mg4.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, dec 15, 2023 at 15:30, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Dec 14, 2023 at 09:14:39PM +0100, Tobias Waldekranz wrote:
>> When probing, if a device is waiting for firmware to be loaded into
>> its RAM, ask userspace for the binary and load it over XMDIO.
>
> Does a device without firmware have valid ID registers? Is the driver
> going to probe via bus enumeration, or is it necessary to use a
> compatible with ID values?
>
>> +	for (sect = fw->data; (sect + sizeof(hdr)) < (fw->data + fw->size);) {
>
> This validates that the firmware is big enough to hold the header...
>
>> +		memcpy(&hdr, sect, sizeof(hdr));
>> +		hdr.data.size = cpu_to_le32(hdr.data.size);
>> +		hdr.data.addr = cpu_to_le32(hdr.data.addr);
>> +		hdr.data.csum = cpu_to_le16(hdr.data.csum);
>> +		hdr.next_hdr = cpu_to_le32(hdr.next_hdr);
>
> I'm surprised sparse is not complaining about this. You have the same
> source and destination, and sparse probably wants the destination to
> be marked as little endian.
>
>> +		hdr.csum = cpu_to_le16(hdr.csum);
>> +
>> +		for (i = 0, csum = 0; i < offsetof(struct mv3310_fw_hdr, csum); i++)
>> +			csum += sect[i];
>> +
>> +		if ((u16)~csum != hdr.csum) {
>> +			dev_err(&phydev->mdio.dev, "Corrupt section header\n");
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		err = mv3310_load_fw_sect(phydev, &hdr, sect + sizeof(hdr));
>
> What i don't see is any validation that the firmware left at sect +
> sizeof(hdr) big enough to contain hdr.data.size bytes.
>

Thanks Andrew and Russel, for the review!

You both make valid points, I'll try to be less clever about this whole
section in v2.

