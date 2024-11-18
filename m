Return-Path: <netdev+bounces-146014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BD9D1AB4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58933283C34
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EEA1E633C;
	Mon, 18 Nov 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiCf5FFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BF1E572E;
	Mon, 18 Nov 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966048; cv=none; b=N/A5SnQynz9Mr85LoUYtdflkc2WFd9D0DRCUrYHbw9QZ/Vv0yvhkbOjfW5U0myTJtQ+smU5DxmRcj0W8Qaq23Ui5o6EX/jBBVr3tIbxFcpXDPUcHGCvX3YFLk4KmG701GpEoA958V42Fn43wqosJDTW6Au4l+27t8rcAGEFdbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966048; c=relaxed/simple;
	bh=lLSih8d4rE3dnDrLhryN4BTC8ycbsBJJ1T2JNGal6k4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r3eVHWCqCCRZiavthOOq9tBlDziDZl5BykyDZ4EsbfSOftD0sYXJRUKgUAi6nTBbhIum8WaptiItAzlxeuej7RjKPzJegP927u9ZP6FheIHXIQ4/uMveJZVqhE7hUoG2jgg7bVe/xvFdliPf9x5C4Okz6FYk6IiOp6wryFgwQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiCf5FFv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b31b66d2e3so9361685a.2;
        Mon, 18 Nov 2024 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731966045; x=1732570845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5P10K1w5ZUXn/OfyZ0psvgsJ06IFxfJy1phi2eczZo=;
        b=jiCf5FFvQw8QaccWdDF3CXHgjIpbhKSW+r/EON7xau6Bf2XHmbyxRe2MI+22sOp/wC
         bCoGDWEBbmCOvdlJKB0AGeD/qa3++xsCBphAx4LTGbsmM5LYuqkmiWsaFg2U6A3M4FdO
         UXLoH8K5AyfKWjCug+WJrMKe2zmXf5ocScuJjQ3sOOVbKZ2sTPfcZq9LpUfOvCCW+LPj
         algrd8U07p9YgRj8MGCS78O8YDd1T0Sm3aHItNREKNHZXMdGY7ct4mdprU4JK+111ZFk
         vSSXnk/lLoEQR+TXfTkgn0AUpfbTj1TwE3PrUwRRqxtEW5+peAKBSi5VeuthTSqdCsPu
         gAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966045; x=1732570845;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5P10K1w5ZUXn/OfyZ0psvgsJ06IFxfJy1phi2eczZo=;
        b=cKs+uZecRLmB5MSO/iAJLD6upwJVnElkTj1pU4dGCKNT1SllJS2E9ETP+b7aURhGZV
         eqMO50o5EcXy9GtSpsAOwpc2CUTi9F0HGj7joeR/ZRdYiPN0HDo/Hzr3V+LRRy8lvz9J
         ppoDJhzALGpixY52S78oB6xxs43gMJVkOfGsDuS3JpmssDzjzHd5PySY9CdmkGNiMOnj
         IrjVsx3xtTGQsEo3fDJVaRviTrCiuPU7xBpGWIaJWDj/d/GJ87uWlMrERK9aDDYI/yj7
         wJLR4ViW2uIh8Yc2aCTM4aZzWy3RkHNof46QJ9U7CKI/1nhlTkKvmuLdl7XPwrRYq3O/
         5GQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cRUnQA8M8WdAA0R5toLbjhxFpsMYrq7VjstNrYku6qUnNSzWb6lf/RMHeVWJxpjfIBEarVFv5ppV6N4=@vger.kernel.org, AJvYcCUp3IfrQIilUcgJoSt362RujaxaWxGhibgLhwMN4pfXQe3xt0VG+tlm223O+yFIOLYB4a0vFQgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7mOAb1NX+N1ych5g/NBjSo1RFZkC6Dt24m72LEqFiXkq25oQ
	RHBOHXN4KXtI2Hhz/eUcgmUbsDTz3XGSXvbwPxgVfqksI+sC504+
X-Google-Smtp-Source: AGHT+IESbUmMUZDRs4jMxJhfXs9SSHGtP5x31ekvTXjC/TUGPQZhFqnwYBkrFwRBeh6vHcpIlvA0mA==
X-Received: by 2002:a05:620a:462a:b0:7a9:bf9f:5ccb with SMTP id af79cd13be357-7b3622c0b78mr2189854685a.1.1731966045556;
        Mon, 18 Nov 2024 13:40:45 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a896249sm29162985a.76.2024.11.18.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:40:44 -0800 (PST)
Date: Mon, 18 Nov 2024 16:40:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Stas Sergeev <stsp2@yandex.ru>, 
 linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 agx@sigxcpu.org, 
 jdike@linux.intel.com
Message-ID: <673bb45c6f64b_200fa9294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
References: <20241117090514.9386-1-stsp2@yandex.ru>
 <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next] tun: fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Stas Sergeev wrote:
> > Currently tun checks the group permission even if the user have matched.
> > Besides going against the usual permission semantic, this has a
> > very interesting implication: if the tun group is not among the
> > supplementary groups of the tun user, then effectively no one can
> > access the tun device. CAP_SYS_ADMIN still can, but its the same as
> > not setting the tun ownership.
> > 
> > This patch relaxes the group checking so that either the user match
> > or the group match is enough. This avoids the situation when no one
> > can access the device even though the ownership is properly set.
> > 
> > Also I simplified the logic by removing the redundant inversions:
> > tun_not_capable() --> !tun_capable()
> > 
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> This behavior goes back through many patches to commit 8c644623fe7e:
> 
>     [NET]: Allow group ownership of TUN/TAP devices.
> 
>     Introduce a new syscall TUNSETGROUP for group ownership setting of tap
>     devices. The user now is allowed to send packages if either his euid or
>     his egid matches the one specified via tunctl (via -u or -g
>     respecitvely). If both, gid and uid, are set via tunctl, both have to
>     match.
> 
> The choice evidently was on purpose. Even if indeed non-standard.

I should clarify that I'm not against bringing this file in line with
normal user/group behavior.

Just want to give anyone a chance to speak up if they disagree and/or
recall why the code was originally written as it is.


