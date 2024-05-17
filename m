Return-Path: <netdev+bounces-96943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3668C84FF
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DE91F2214F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9F939AC3;
	Fri, 17 May 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="W5yVvBpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578539ACD
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942534; cv=none; b=ftB3fg/OlHlHmgGvv1hVmwjvfGA+hJNrEnvhIMh9QXIvx01oHfqBCTXSCaXSEQ85Q3uzmpNBIC2fVukWQJPJ4Fn0WGJk04bjNp/smGw8JuD7eZgRLs7LGOpV8fkGaJ+5O0Sd1613ennxo+TXTjeqomkbbxcPCxHkHofFIMkqPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942534; c=relaxed/simple;
	bh=Tn3gqGvORrVVvUWeX/AlaSoh4Q4PaVl79FZuGUvXRVM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XfLexUSh/rQOsCGzq69ur3Y4sd0KgsxUcV+1usBLmJxjoCJH3NAWlQ0aB1ijmL66LPxCAHnvFiwaRCPm75L1hotnGjhBSbKySkrAvqYd10P4WIOucjxMusz1etANSaPgLBaD4yaLaw6FxV92E5m3/yVImHz0QEmgPreiYaiu6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=W5yVvBpd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so6260014f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715942531; x=1716547331; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVVuKeze+/l/m/6SZ6VdHyTwnjR9+FVuJKaedifARXs=;
        b=W5yVvBpd/7OUn1ILgmrsHHpwBps/y4ZoF5IxCHhI36HCYs2P2DclUN0IibsfDugno4
         8NP54E0VkzBNNgeDHY/EyAjcAomYn8DcDTtBhKmwE/1a4PNBwQ3Duk07YbDJj5NsON0L
         xse9GNn5uQkE5F9h+svANAAeRb2ga2MX7UaYGLlbBO3Acr2bYYJ1gqsFcL+0n0NZ2c3l
         M3idv+hO2FGo9220K2R0q/jJQTF2fPZTu0x52Djtuu7AJwSwcj5YlFRwj5+dPuDcbx9B
         kE2T0kVv3Qt9HuXc0+ZTS5jMDxqXKxHJEJvQEvcVYO8BKLMdBKXpKyYBRtLVshvA5qxX
         Vrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715942531; x=1716547331;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVVuKeze+/l/m/6SZ6VdHyTwnjR9+FVuJKaedifARXs=;
        b=oZwKBYNEJfPugY12ZuWalWbdKTfDNY+JS7t0LfZyA50dzJm5anxsDd00X1OSQDYs1P
         cYsUDdrnfvWidwfnJ2dTw7LOWwQ310XfWGi27PJRYD4F+8LaHX62L9tJGfhVCS3aoTpf
         jyaX2xOaVvTuwTYOU/osb1hCJFeDDvstP+qqKot4ABo+zoDMMoc0cQNyZTzkDkRAgTVU
         Gdi+gsd24QA9dqwrhrJBVPAz1FYFCGKSt3oVGU8PPeQwvzjNslJGh/3h3pxRQuZRseDN
         6sDJYh+DPQ/TrUY6RcdnvEjxBzp0VGTloHXVljjm91cZm2ZUZoyZODDVe9XNwU41UNi9
         HgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyoFyqQIeKryAEuTXxd6t1+GCkLbEwfLxzG28ttZpHxla7OSdZlt+wqXyPfpxZfJHbxZdCecilw8BddM6Kw3SuZVFrwbwf
X-Gm-Message-State: AOJu0YzLGp35Tp8pzaBQjO6cwqdkw5LRg6LYgiRIXjxZXoHPl4UyMulr
	zQ4GF6ATx1CwHpssP4lLdK5knq6sSBsbTZwYVcCvBqzDFprebuxp6M9d0CIKpqI=
X-Google-Smtp-Source: AGHT+IEjp9qU1QWmuNE004NYUawbuKUIq/KMDMvkPFdBJndlTyNLfoME36VKIbnsStbPx3wk0bzvww==
X-Received: by 2002:adf:fd0d:0:b0:34c:ab55:bf1 with SMTP id ffacd0b85a97d-3504a62ffb2mr15439295f8f.2.1715942530954;
        Fri, 17 May 2024 03:42:10 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:15a2:d0b5:26bc:4a17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b55b4655sm14658221f8f.76.2024.05.17.03.42.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2024 03:42:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3] net: smc91x: Fix pointer types
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <66AB9A6F-4D24-4033-96B9-E5F2F700029D@toblux.com>
Date: Fri, 17 May 2024 12:41:59 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 glaubitz@physik.fu-berlin.de,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 lkp@intel.com,
 netdev@vger.kernel.org,
 nico@fluxnic.net,
 pabeni@redhat.com
Content-Transfer-Encoding: 7bit
Message-Id: <BB22F3F9-BB2E-45B2-A3C3-8A4218B018B2@toblux.com>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
 <20240516223004.350368-2-thorsten.blum@toblux.com>
 <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
 <66AB9A6F-4D24-4033-96B9-E5F2F700029D@toblux.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 17. May 2024, at 01:21, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> On 17. May 2024, at 00:51, Andrew Lunn <andrew@lunn.ch> wrote:
>> It would also be good if you read:
>> 
>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Will do.

Reading this was helpful and I learned that:
- net-next is closed during a merge window
- patches should be prefixed with the tree name

I'll submit the patch that cleans up ioaddr from all SMC_* macros when
net-next is open again.

Thanks,
Thorsten

