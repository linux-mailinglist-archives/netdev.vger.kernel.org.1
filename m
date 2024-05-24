Return-Path: <netdev+bounces-97912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199878CDF50
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C949B281F57
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222843838A;
	Fri, 24 May 2024 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwNKJC8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88479C8;
	Fri, 24 May 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515466; cv=none; b=L4WBpQ3EPytkS6UbP91N9IV8e3fS+a4QsS4EUtq7GMsBA5REGLIEyZZyMZqIaaagglglaJu1JoZBuYy8aNjX8xuKCy7aOBcwvSWV77noz9JV/mJFIwREcZXrcR5TqNKhXM6pbByGKCv7kZs1MhF9g/wLz9mQNOVrYgKFcXBxmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515466; c=relaxed/simple;
	bh=1Dx6B0x3HwSyPtDZPkm3qQoaDQgUwygq0DF1q7lwqAo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BOns2aWPJ5TK+gFOnqi4VRlZg73dyhinpBrpBlRC/0tnXmeEc9tLCcQrH1waE6NQ1iylqFR7mdrBoV2U266t6RuvELworEfUBxW97S++LyCo9PTJGJEEESa6scziS14lVQb09BMp9uodFWTa3FNvDhUAkkNqP4wI3OvdKnTF95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwNKJC8g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f8e987617dso14989b3a.1;
        Thu, 23 May 2024 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716515464; x=1717120264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G9CXv9nfwqE5OkPVRybOEjUygy+4YTjIzuZ+oweX1c=;
        b=MwNKJC8glEayN6rFRMjg4PyIwMnDQ/6PPhF/7wJN9UsPPk/40b1u9T1ZfNEJXfh7Mm
         LAyuYHCyTg91iGFBVUhBPlbBmiXOPXXi4Bc8I2uwkOLVWjwWWRbs05UQopTghxhK/toU
         OXZPpUkdLnXFTzVifeFKq59P46YNk2TAk4pZwmQHAajSBBObYpBaNbGCuIfq7XV2yo+G
         HEczxJlB4FBS6uh4jJMYp1/CS1dglNOMHXkGs3pQZ2mbzoQWO8Zjbsw3LYtbAPKDQMmB
         tEGpeDp8L22x9E6PZKrdCS/SnJKHPAIDKUkkxTKyxLXE4F+t1kYGHZw7FwQ3jkj67M7i
         sdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716515464; x=1717120264;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1G9CXv9nfwqE5OkPVRybOEjUygy+4YTjIzuZ+oweX1c=;
        b=v4bkn6SJEY6OFt8sWED48rMV4u40vNhuwIyzoibIDoZYW4HfRSkTcO5NiideXbcjvo
         kbl6tiazgpyLc4PfKf31Ak1n2OENae75sgIucz0+BpL4FOkqyO1rtxY2o6wFWVOlwmKy
         z5IdAVVlDBtq6ptvvBBJWKrU9zQ0H9xjEIss7VL9xO/3vcNvFqj2GuWbPy7hNlULP+mN
         nrjc5KGYJIcVCxLBu5KmoFsG2rA41XG5Ge/smHewIsHCfoM6EAdOwDnJw9lQfcT4i1Ml
         arVSY5a6fq8y99vTPu+k964++mTQLHpOqZbPzkc/sNOZSC4O4os3qgJ/yAR37Ma17Ohc
         JCnw==
X-Forwarded-Encrypted: i=1; AJvYcCXmn4P7Jmpb7sr+Cnb5nwHuSN3+xiuj2ttOEBdVWGhvQGfHCdvrL8TNd2giSFiPbU6mv1XNgUGcb/q4XOCVF6XQVjkcpQNIVg4CW8unr2Qtc7+/nHZbbtjFY+tvEZguA/MctJ1xNSM=
X-Gm-Message-State: AOJu0YzNL9aaCBTKmu3SNM52YdpCN5GDWGdq03w6xPb+dKZ+DrqFLEca
	fYVJK3GMqrWmZDogg8UNMl9qzT9ejDx/2BdSXiDmCPF+2wORDR14ezHHzA==
X-Google-Smtp-Source: AGHT+IFHU9epZnKkThJzLGUH0v6UIM9p4iRNjXHsQnLlzQc9UI9paQ1gVWCet7y+YGvUfhe3cAa9SQ==
X-Received: by 2002:a05:6a00:4b16:b0:6ea:ba47:a63b with SMTP id d2e1a72fcca58-6f8f1a66115mr999375b3a.0.1716515463792;
        Thu, 23 May 2024 18:51:03 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4dcde6sm234131b3a.211.2024.05.23.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 18:51:03 -0700 (PDT)
Date: Fri, 24 May 2024 10:50:50 +0900 (JST)
Message-Id: <20240524.105050.1475782462057764400.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: tmgross@umich.edu, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <0aa87df5-a2b8-45b8-a483-37eee86739bc@lunn.ch>
References: <20240415104701.4772-5-fujita.tomonori@gmail.com>
	<CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
	<0aa87df5-a2b8-45b8-a483-37eee86739bc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
Sorry for the long delay,

On Tue, 16 Apr 2024 14:08:32 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > +        let mut a = MDIO_MMD_PCS;
>> > +        for (i, val) in fw.data().iter().enumerate() {
>> > +            if i == 0x4000 {
>> > +                a = MDIO_MMD_PHYXS;
>> > +                j = 0x8000;
>> > +            }
>> 
>> Looks like firmware is split between PCS and PHYXS at 0x4000, but like
>> Greg said you should probably explain where this comes from.
>> 
>> > +            dev.c45_write(a, j, (*val).into())?;
>> 
>> I think this is writing one byte at a time, to answer Andrew's
>> question. Can you write a `u16::from_le_bytes(...)` to alternating
>> addresses instead? This would be pretty easy by doing
>> `fw.data().chunks(2)`.
> 
> That probably does not work, given my understanding of what is going
> on. A C45 register is a u16.

Confirmed that it doesn't work.

After some experiments, I found that the PHY on my environment works
without the firmware loaded. So I'll remove the firmware code in v2.

I assume that there are PHYs that need the firmware because the
original driver loads the firmware. Thus I'll add the firmware support
in the future after the abstractions for the firmware API are merged,
which the Nova GPU team has been working on [1].

[1] https://lore.kernel.org/all/20240521212333.GA731457-robh@kernel.org/T/

