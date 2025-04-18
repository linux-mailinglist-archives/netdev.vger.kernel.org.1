Return-Path: <netdev+bounces-184128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E410A93643
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C592D4487D2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FF275853;
	Fri, 18 Apr 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3C6R2S7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA3208970
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974012; cv=none; b=IR0i/RCHGyYFH+kYGQidoeB+r6S7aZ2E4M6fPFm+pEJUrKUnB11WHd/M+Bow3qmuqgqRRWD6Km5giih0+ThNA9GQscZTsBc7lXXBVMYLNOZ8oIjNNLrCT4xRJbF4y17jKWoSg2djG21OY3+He5PK8Dz2t6H6aaM2xkYFBouHYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974012; c=relaxed/simple;
	bh=qgl6QWVKM1LFGcN3ceD49QWK+6HvaAsvyiEItREc//A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=aHL05MOrGm8V6yZcOFCGrTo9OnQZWdUI79SEeZxGjWVNZjn/0IgPWWDnKLXhSu/EXw+rwMHSRYTwDW7MUtUjAbxMyDNzM8xRT+0rKghWrbpEjXkwDTJnUrz/wqAfOiQ2hCaqQI9YquIqIbpOC16cPqq6LVKnMboLj9qC2aagMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3C6R2S7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so8645755e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974009; x=1745578809; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aArCc+ArgaxAUn+zWcdJJNAuMEQ3ejVHUVmQxpLtIRc=;
        b=e3C6R2S7+u5d8yMCa2HXptlHr98Qk0ovZTexHf4OFBeYRiLVsGB/fgAJBBuXdB02o7
         4AWny9haMyRzP7CB2iOtf2Big16fpTqwZ75b9kCShoIxz8e0QLdVBj7a2CysLIKTFVlq
         5JzpcMNtAzPfml+yRFgsg3BIX/LYMtyHnxUY3eO62NO8JgGSZF2ptAG+HnfIoLt5Kvzf
         2z2edOIPA9/O+WS369S4PcdrJN3kWeUqd/Z6A/t3ahfCmbA9ZmewCkV5bN7pEDzA4IAQ
         LV+LJlSL8chtkvnCwH7deDxmHruyv/XoAgG5iDqlulfsDFjzauXTRd9O2SevOnLaTt1x
         O4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974009; x=1745578809;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aArCc+ArgaxAUn+zWcdJJNAuMEQ3ejVHUVmQxpLtIRc=;
        b=Kxd1ygdL3/8TVgsvGsemlg7zh6dOLELVT1xd5HCY99Sh/Hv7fLneKaoCyouij+upj7
         4kH8pjO0T3k5G61Z+nicNxG+J2mMvwRO3e293UDdKpvHMBU+biui+bzQw0VhbAoTlR51
         WrGR33XUV1Zhq+KqQ3Ku8pFovYFt325Ez6uBZo62SYtTzxHC60qmbSsTWmB0/bm/MFdG
         CrAQd0/A3KfigKokhI5PMw9H6ATPhwb/bXGmCNtLnjFtCc6vqaZOptyXCbiVfEFHvDxU
         3gea7GcnnoZprVils6QVKtsDixdYds4HZsn+SoZ5FlRU5Iy+yfwLXTDcf18X2eRo2zD2
         FVow==
X-Forwarded-Encrypted: i=1; AJvYcCVeSxzDySXWTD5nrY+oMnTcUe+uw+zWtv8iCewB2EaIT0nXmYswv+dQiFlNQqmYHpTTCH5k0Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpilem2Fi6A5LBzeVnRWcTjcFlaRNa2d4o3W7tG09Bs4n00JZa
	pPjM0IrwE5WvnFu7Gg8MtyENTmHERfGAaqmMsX1HxjV6bxfD/jfY
X-Gm-Gg: ASbGncs8r4OfYZ1N+szEoilEyfgHAWNVTupYeW7TJsmlnCG3uHGw1bpOfY/T90O+a3e
	mnXwjL7wvppxS4LKX2IExjrukHMG9UjEIuP44GnlactI5kDmBwy5ZbIauvRmULqLcYN7BiPbVRx
	LsypsNbduc9YBeYrNVZ5euDBU/TeNZo+PQKhmEmGog+4WusVNnTYW/oBGBMiS0Mpoha4sBexIuY
	e1zlCYzfGPTFqH/b1RBAKnZx2Fn8WFEfs3xJ73eBSDleYO6FBtnP9t9ZR5+KulSkHmRr9deWXQI
	xxqII2GBwMRc/MxvvKUz3coyIo0yNevPFjdgpi9mPXqNanMyTaMRe4rGGeE=
X-Google-Smtp-Source: AGHT+IEhzcuof4Vt9OBrgEq15AC7u3rn5A24yMDcI5iF8ORpknGuNsRTHQAT0sEIu47k65Zw4cWzIQ==
X-Received: by 2002:a05:600c:1906:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-4406ac11581mr16245955e9.33.1744974008713;
        Fri, 18 Apr 2025 04:00:08 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9eb8sm17982135e9.4.2025.04.18.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 11/12] netlink: specs: rtnetlink: correct
 notify properties
In-Reply-To: <20250418021706.1967583-12-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:05 -0700")
Date: Fri, 18 Apr 2025 11:46:01 +0100
Message-ID: <m234e5iw7q.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-12-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The notify property should point at the object the notifications
> carry, usually the get object, not the cmd which triggers
> the notification:
>
>   notify:
>     description: Name of the command sharing the reply type with
>                  this notification.
>
> Not treating this as a fix, I think that only C codegen cares.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

