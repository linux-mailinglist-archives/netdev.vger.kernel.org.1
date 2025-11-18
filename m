Return-Path: <netdev+bounces-239340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F44C66FBC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCAE04EA14A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2B26B0B3;
	Tue, 18 Nov 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmxqFwwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9E270EC3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431761; cv=none; b=E354W1hZ0M8MNKDP1B0pxNOMhzPoOtNSgSeJnJfFMln+a/IeuWqxhu8Nw1vVh04GexEoRE+GCQjo1skgnIb25U/TjPL7iRsUCaJtn0CBAQdRZPG7lQzbw5sGL9Tf/EdSmEeRPUsNROfwA5CKWH8uvXq6Y0sfGKTjK7G3MpHftS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431761; c=relaxed/simple;
	bh=hFh8IINo3mUa/2K398UVvXRC4w4QfBZgpD1aFDHyvkw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z1t2rHMh4TB46R3lOePItNP0dMkaGF8gFWJEscPD7RRP/hgmLZ0RZa8hpVHfoLNw8XhKZK3QVT5M/cEH2IOFrDa8kCdVh1HRwlhttGxkaXJ6NwOseVeErMOkber1zSRhrttEvKMFT/TfcEODPbsIVZ750y35JMvODbilIRl7OSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmxqFwwx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f97c4eccaso4792511d50.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431759; x=1764036559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThW0CBgJk5lLQ55qGD6pmrtIV6ecDbrMPNoiNkJoTnk=;
        b=QmxqFwwxQw5b9aFxWZleSTH1CqJKpGovyqqcoNes+5EVzx/X7AKE9wMMQjeb62VF7b
         d2mixOkywjwCDX2kCVpGMJiDVeem32H+5owUC7KpBxzAi8A0smFOL4Or6ErxExle2isi
         u7cNL9at/KPRBoQPCmGl36DAvp9OTss3X7WYiJx71fHSuoCL3YhACya9vzdJxQ1RZanZ
         wETX1f1iiKCBhMzepQklk6DSIHYwxS9Ct2CLKFZzKp9P9teukusU8oQiDJj/5ZAxkf3c
         pNTd6lPtUvra855MKP9iUFAwLT5nDskdrFNlugA5Tf8LJCCtH1m6wAdNE8JHmHJJOKkh
         NaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431759; x=1764036559;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThW0CBgJk5lLQ55qGD6pmrtIV6ecDbrMPNoiNkJoTnk=;
        b=qbS7Z1I+VCeWTPoey/IUNIHZzVvHvPDOtHI6M8Eerr5Rng6ZvM+/dZ3bej3vmeYce8
         xCqMhriomNxDaf/5+G/qvvBpps7daneMe9w27tX/s8y/IaumWdOschWmpm5FE3N2O+Ao
         Ke4rj6W+JEp8bMvO2ZScKOHEjL7jn5VCtlXl6QEBViaDlH3aH5WY09aH82XQAK+odaa7
         QDapyn4LZRuhUoHsKVLeIIN4fwLS7i8EknMstZDszIkkxeYA2EXqZA3V6IJAUtNBcxC/
         qfYANzIrH6ChCpRXVtiV1EyU215owbL4Wp4iKewTt8NIEvB1dURzCmC9rGR567vvTNx/
         KxGQ==
X-Gm-Message-State: AOJu0Yy/MRIGr0DGSVP+ZTtKdm3O0TAzr5ueYvfWGX/vDP3ZQICk4yXU
	sxybu3xbZ2LRZ7mPY/CRRCmNXl0kqSat9xAHS7/UU9v0EckebFUFiIe1
X-Gm-Gg: ASbGncvY/CsCoLbwpVvz1eny8Vlcb3rXH/9jpvcWCK6f3ghteIhCmiNDeVdx3nRpQ/M
	wSlSirFFf2Z1Xh7JCWufidCVH7OxjmJ44B5+TCC0rKhYsFCFibTfinx6Uh70TGk9WEwHmvj+1l8
	pkAsUguHhez+MssJoDcxdkA21uhdzASR9KbL22y5GbNS+Hh/qQ9USxjbA4Pq1u1lId/RBCIgP24
	HvA8VHFLKyiadNw81aSsGxxSQDE2x5An0Y3c97f1TUoBZySam5x94W9pTa9L6pM5cJqvgvlxRPm
	qGedaduggaKAEV7W3Z6gvk7e/Fjl8QXzjbcqzH+4t2Ae7Fusx7SyYtaxzF+Od0sANctBQ85/IoT
	TnAIOWSDr3ScS5yGDTGHFvWKzgCMBaWNCKYk/4F+cW40B2lPA0dFSVrgceUF0/bi7GZqMfiNiIZ
	2+qf6tsDlGINwKu6lO+SKgMtiRZODtb22z0aBDMVDbQtpkL733GMFdJjOxewbT8mKeYmY=
X-Google-Smtp-Source: AGHT+IHfibol9fYGEa1/DESKLJigWrM8g4dH8AUVNSRxxkHSj0Q2TihB4TwZuCX+TUfEL8qqXX5qhw==
X-Received: by 2002:a53:c04c:0:20b0:63f:6cae:8587 with SMTP id 956f58d0204a3-641e7655a40mr9595392d50.37.1763431758912;
        Mon, 17 Nov 2025 18:09:18 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78822125317sm47628447b3.37.2025.11.17.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:09:18 -0800 (PST)
Date: Mon, 17 Nov 2025 21:09:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.3ab6e98979752@gmail.com>
In-Reply-To: <20251117205810.1617533-11-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-11-kuba@kernel.org>
Subject: Re: [PATCH net-next 10/12] selftests: drv-net: hw: convert the
 Toeplitz test to Python
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Rewrite the existing toeplitz.sh test in Python. The conversion
> is a lot less exact than the GRO one. We use Netlink APIs to
> get the device RSS and IRQ information. We expect that the device
> has neither RPS nor RFS configure, and set RPS up as part of

configure -> configured

> the test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

