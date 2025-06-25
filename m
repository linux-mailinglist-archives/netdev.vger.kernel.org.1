Return-Path: <netdev+bounces-201041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAECAE7E87
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967916F50A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212829ACED;
	Wed, 25 Jun 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f61bimrj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996429E0FB
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845981; cv=none; b=Ci5WgKI2dG+giPrVWuAr9k0QGAEJ7ai8XtJ3HE9fScONvKABOy0l84MMS2xtrmEqWVfoGyUbtflm7zzv5TrD6FfAdI+R67mYXzO5vR8XBJnPjUpIm6NG8+i8PEFAtwAgXagtWNJpPkc6QsInaSiUtX9wBAAQfuMZV2sKRC5hFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845981; c=relaxed/simple;
	bh=xXZ9Eco4R8jlfO1UHIN0G6n/XZuWschji1MaLTx3bMo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Cg1i3AqanCMMZPTdh7TQeh1uKrFnNL7t16T0KIPuwctpSw+i+mXRkSF9tzy0ZFyNDGC3MgOT7JvgUq2+N6OoT1hpFzb8rQT8XDgnAaXTtqjaWWpBWhx7Tg/Zf3HrOknKvDDvF9GuoYuqHQsvtC8WrRz4hs0ONHChQreg2e/PuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f61bimrj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso53382035e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845978; x=1751450778; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXZ9Eco4R8jlfO1UHIN0G6n/XZuWschji1MaLTx3bMo=;
        b=f61bimrjjtR6Q/8UGD7gj7wBRkKgqKzASHb9uYJ75g1C6ndlYPOt19N/B8Q1ym+Wax
         Hh6xmPDIAiT6vKNhmj7+l5ySlwTNMxwOPAb1r2CQ8nlkg9U03e9LTG+VASspB7IqeJrT
         PVQWUpTzgQkwZpmPiUNFRZRolK6szYtEI2qAkHf2eYsna4RP/spoSxREskzzJf466WPR
         JVQxF11UBTfh5+lzkFmW9GeFL2ALx+dSb0OwyTMIRLyGvnZ7nQmNTzbWVQPLNaDvq5IP
         IycKh3aMA1XYJvh5g638wPwagDAHbfBTevlA+OAYRUOtRKPQN5MpqHuK/gksXhJlWvzq
         iyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845978; x=1751450778;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXZ9Eco4R8jlfO1UHIN0G6n/XZuWschji1MaLTx3bMo=;
        b=dBExofU12dugQNU+UAiutHGxn6hE9P7pUsPHbzFkRJBJbrnHJH3oDeJtdvniZ/PCei
         SP/1ct9Z8e2B2GJZnUKeaIt5i+LptefA4p1xa+Yw1s1ahHWYPcMvDl0q+5Hl/QGmIjPE
         S31xu8fD4qANiypxhwqGGX4h3PawnxnV6/mNSWwNSuk9KLhGyWuB9Ec+LpCQPmCjEoUT
         SdLSiEXWdhO2HID65HqFF6rE75ig7HEyuU8eCrCmH/1Fus5+DFe9zJaoIVpsCitc+q10
         Dh4Zj7Nw1BLE/F5orNCf8e3yLHjv20VP3PazYgXZRbamG1V79kwby+pxY8L1AOlPCteX
         E1hw==
X-Forwarded-Encrypted: i=1; AJvYcCV2LLgRBVObPHuojYOcsH5OT2z+BHp+5O++wACVc0qP+iyUP00YHt8Lzt7+bwVR4HLB1Gzd1KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnIAybIMjVBWM9kZySORwQZjXTMqz1HmFUN+C1GF+8uxpeNiy
	SX62HLackX3v2eqYdI6+/SwprwdPHcUTcEUQxlbBjmh5LodAGAGZsooo
X-Gm-Gg: ASbGncuNiQ07rjF9uQkYtu8Qv2HZvlVe1o0xMJBj2oWVed5HCyouIjTTUrRvHnCZegU
	+vOMYoy2w3wtWitZqKW8OcAhfBvqnIBdnbjmIHGdjoUyDXyeqkBxg+rcLhu8/EzXxofiB80WrWW
	RMkVMCsnV8kfR66gHAnQZ/A6+OBlspD2FixSmb8NnqQcXhltJ+EkZfYzafdy2MvRhxiyg5kWgbG
	Y4myKJ54v5yjVtQ1c5xQkr+zW1rs3pJ7BkYwxRf26Yers7fRrCYC9w74zzWoQUNHFO7p170OIfD
	Nc5xEHFlegWhwWIFNzgTmDZBUWllnzvKa+tLFI3a15Y2qtImNYRvBAHjSa4NT5kae79yL3HZtpp
	mclc8TxF8fw==
X-Google-Smtp-Source: AGHT+IFw0fIgom8z5qH9ssBiUKA7qOGFr5YWq0TNR72SbXUNZkHgDmSmmIb7RYEzMJoZRHBuhdwiVQ==
X-Received: by 2002:a05:600c:3582:b0:442:cd03:3e2 with SMTP id 5b1f17b1804b1-45381a9cae3mr18693025e9.2.1750845978262;
        Wed, 25 Jun 2025 03:06:18 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349758sm15155015e9.9.2025.06.25.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net 10/10] netlink: specs: enforce strict naming of
 properties
In-Reply-To: <20250624211002.3475021-11-kuba@kernel.org>
Date: Wed, 25 Jun 2025 11:05:24 +0100
Message-ID: <m2ldpgb0gr.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-11-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add a regexp to make sure all names which may end up being visible
> to the user consist of lower case characters, numbers and dashes.
> Underscores keep sneaking into the specs, which is not visible
> in the C code but makes the Python and alike inconsistent.
>
> Note that starting with a number is okay, as in C the full
> name will include the family name.
>
> For legacy families we can't enforce the naming in the family
> name or the multicast group names, as these are part of the
> binary uAPI of the kernel.
>
> For classic netlink we need to allow capital letters in names
> of struct members. TC has some structs with capitalized members.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

