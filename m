Return-Path: <netdev+bounces-100604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E988FB4D4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D7282948
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0018028;
	Tue,  4 Jun 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LMgXrG8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144B1756A
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510260; cv=none; b=DDgXbhPC0lXOOMcw/bTuwkQBcHOI90VaY+fyb6hJmTgF5U5nHdhqoLW8ePb67oXUscBzBKGozxkfOfPyyZwf9x4Nbe4THN1qJsNPx2Y8f2UaohjKeTpldTnHaPY6shoC9BmJyjablex9UBf4ju0gQ0ubauGd3TY2/5U/FP/vQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510260; c=relaxed/simple;
	bh=6cmXp3he9brpWOBwHop9iE26Md4KGRFmH7CoNQVbpe8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g6qw8HXRRPeDvOny7TgFaysBgeSUjMH9vy0KnbssnrFEv4cZWqaF4i6gA7sXbsfzf33h9E6L+ipWy1y0flcWP4ioQw2kFcta/5NUX3b7NBJt1iZIVKWBaNMxyERJLkHf+dfYhRQ6MQbZGOEq1QZiQ5Xaxv3QSdTTIaSg7XcFDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LMgXrG8c; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa80cb4d3so51092811fa.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717510257; x=1718115057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baFFAijHHZMbMbOiyZjBKnPAuN2EF/pC6FwbCPVRy04=;
        b=LMgXrG8cmibtf0gAqr8/AdnKJ35ulv4u8Uk8oXB8VvCMx/ygDEm4dC+Jv4tWJEk/YX
         IdCEa9Y95k2vJGFaUNmWoC6BPDaWO/RMHNFWK1bXEzX+N6wWPKLtltFBmQfOU/d9DNqd
         YDO8x5ZKlsy9uWIczLRg7rgt4ZyPpgLMaWaXsZ0go6Tl8iEc8yLWPzypoIXz8uGC5BTF
         lOsvGpX0elVl7DI4Z8rX6Nu3rxjNfl/elkY6s1PySXihsdkmGHQZgPETx9TbFTuqG73J
         Plx9GA/zh6Ci94B1fy57lYf6gZrKN470QQ5yn32y454pZwbAhDDapH+0R4+ul36L4G6K
         bIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510257; x=1718115057;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baFFAijHHZMbMbOiyZjBKnPAuN2EF/pC6FwbCPVRy04=;
        b=bsDXbBToPNOr4j0G9w/cyuAWGd++qMC6GlDXWXG29K5VIptBWKKsL3I320uYb1kcsL
         4SnTrFjb2f3UtKTPpRo/j5r5rhzvicu6Bv4AX0SpLGWGqzepSNGmICftC9JB0hOSxBOH
         yfy/L6LIG3YE85ibVyXvkKzm7Qhq2ECvFSDVPwpKTkdUlXdaXgH6PdctUMGjhvUx4Jih
         UXUNqvIggBtORvo8kDXyaA+aKfZkxnwoV9KkURJy5N83eX82jh2f5Y6GtJ+UIvEwzqaM
         /yHDmwC0I9Dkm2ijtdwrVHh5Xzieyet/a700ynv2Kwjf1qBbxNxcI7psoiFHid1/eWIA
         28yg==
X-Forwarded-Encrypted: i=1; AJvYcCUbU/6UhF7sF1h+tsYAwKeZbULK1qXN5mLve9OhEd53wkPI5aMDrr1+0JLZ2IjOWsbY8pzygf7qQvN6530Z5ptowcGBSoOz
X-Gm-Message-State: AOJu0YwUpbML+iNuZ3g2WC9ThvnNY5sW15XeRG6KCN+qrbmkwL/rl5ek
	TT674lobSAlqbtwOhQ2oADkTopdtXbQQa9AR1CPgsXquw7D+U0P8qAgxrs+o9Cc=
X-Google-Smtp-Source: AGHT+IFGi/nRxSt8VzqDMp2GUHMUGUhYLVn6chJnQfDA05ayGELL9N8JVnwgFNAMyYZXf4dXOXeVNQ==
X-Received: by 2002:a2e:2a43:0:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2ea9515426amr88035371fa.26.1717510256849;
        Tue, 04 Jun 2024 07:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([94.131.244.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c5c523b4sm467216366b.11.2024.06.04.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:10:56 -0700 (PDT)
Date: Tue, 04 Jun 2024 17:10:52 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>, Chen Hanxiao <chenhx.fnst@fujitsu.com>,
 Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: fix an inconsistent indentation
User-Agent: K-9 Mail for Android
In-Reply-To: <179c9ada55ae686f8142f3fc78dacece2db4f407.camel@redhat.com>
References: <20240531085402.1838-1-chenhx.fnst@fujitsu.com> <179c9ada55ae686f8142f3fc78dacece2db4f407.camel@redhat.com>
Message-ID: <5C3E0B27-B3FF-44EC-98EB-FA43B0790957@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 4, 2024 4:57:12 PM GMT+03:00, Paolo Abeni <pabeni@redhat=2Ecom> wro=
te:
>On Fri, 2024-05-31 at 16:54 +0800, Chen Hanxiao wrote:
>> Smatch complains:
>> net/bridge/br_netlink_tunnel=2Ec:
>>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
>>=20
>> Fix it with a proper indenting
>>=20
>> Signed-off-by: Chen Hanxiao <chenhx=2Efnst@fujitsu=2Ecom>
>
>My take is that purely format changes should be part of
>larger/features-based change, to avoid any later stable fix harder for
>no real reason=2E
>
>Thanks,
>
>Paolo
>

This is new, I don't see anything wrong with fixing bad indentation=2E
Waiting for a set which touches this code which hasn't changed for a long =
time ib order to fix it is doesn't sound=20
good to me=2E It is very trivial to resolve for anyone=2E

Cheers,
 Nik



