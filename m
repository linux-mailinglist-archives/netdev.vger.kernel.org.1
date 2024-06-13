Return-Path: <netdev+bounces-103209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EE90706B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA9FB26304
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACD143C52;
	Thu, 13 Jun 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc3sJT/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487ED1448DA
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281141; cv=none; b=QwG79PoGungp3B00mUp7LfP+gWbr9S0Xxme+TmA+0oW4mBnLkqQddAIKE5x2I8nm3RF5mBxDY1/QvoqNZj9DDhEE4H61k74gqaWeGnSp/qMBLPRWiS0HFIjVakqAUY5S83wmBfNkk2+lSUi9zdU6LtiGu0dduHhSRr2N0dfnGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281141; c=relaxed/simple;
	bh=7VBqIooRcVzAauFWwjigxd9vNsSgUjkoVVT8MaF03EU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BwK7NJM4Ln/gYMZ4848WaixO7HTUTIKSCbf6ww1bWoppC/yFRrwP+DHc0SSxw2lG2K3tLwiOR/LXoOHqpIJXPfZUPlDVn7jqXQrIJU79RegSaXUU3SYIJlleHmsi1SNucGEm1s8JUGz/7ctAKue8//Mqna93qby7X61Y2AdToJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hc3sJT/r; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so15844a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718281138; x=1718885938; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSUKXL012FXP73EEnL09IAOfAs1NB28Fx+G7SmsEBW0=;
        b=Hc3sJT/r/QEeGPetoI25wfMIW6ij0zP+vQ5qgMT9c85MZtfn/ftx2IOiJJ8feNeSlF
         FlB0MQzYojD0LpzWLdV2w4XXd8p4GJciH9rjVpamNOnpLUHpG6GQojNGmj793GKBtSn9
         DJ8B8Jj1yUwnx2cf/DhoiznB+zoVP5bAikYDJ4rfR4PIP21Txgm2772JLdHPS9uGix42
         6HkU+1UahG4hgMo5dbgo9K9afFpF+RSKHOeZZyKW6ns/BtuZ8Or/Kw9kD7gxz0gIn0w4
         rNnElbCAHlD6dwpARq0PyWopwjNbEip6K7sn4SmnRPxt0iGRxOuWy9kKUaXpK5fcwj7w
         Y/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281138; x=1718885938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSUKXL012FXP73EEnL09IAOfAs1NB28Fx+G7SmsEBW0=;
        b=qP9aX33HDkpz1WtwZ175qRTg/xOdMHyQ3n2/SC63drUANp5hKgQc5uQNckiXum1cUG
         6U+/xlZ0QmuVvVunM5v0osS0NwNqzJtAKIZUabVyZLPvCg0iNbGzJKO3WyvvnXH8YVli
         /r7u916SRPa1iKN7X3Mmtx/v6jM0c23z2guD1ePUYZaAJkG/RV0X8SnQcS3ao2XYP8Ne
         WjWxMYB05O5qgO1gzEjryf3cYoaxYlr+8jY8TowvKt8XheDuRSqzD1Q0ZA8qEimcmzuo
         yiHWi7HTt65v/KvDGodfKfpjxtkzmATi9PXxLW33NWMzmct6KcAdZ0rYmjbTPBhjt+Go
         wofg==
X-Gm-Message-State: AOJu0YwXbuZqLDEB68O0lLGbQIKd7pu0jdIg4MX4AK5/Nl/EKR7YtkcF
	hNzhoUEXbJDVbN5sE79QN+LJv49Mty+rfaCeoFTSIORx9glEzc6jhN2Qkp4MxpRtPIh9Ab8wzIm
	zLJoOoOhLRaITj9LwaNZXppBnCJsg9P+C0i/SnMUXPAVcqobE2z2+
X-Google-Smtp-Source: AGHT+IF+QYYLDPrYYV3t9mzeYwtD4UnFYkJtffLeJNQB3xaIhyz+MDl2eaUTvRevAdH6DUw4YpoCHrR3ZXqKD6Ta/HY=
X-Received: by 2002:a05:6402:13c8:b0:57c:9cd6:2a9b with SMTP id
 4fb4d7f45d1cf-57cb70987eamr157907a12.5.1718281137944; Thu, 13 Jun 2024
 05:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 13 Jun 2024 14:18:41 +0200
Message-ID: <CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com>
Subject: Some sort of netlink RTM_GET(ROUTE|RULE|NEIGH) regression(?) in
 6.10-rc3 vs 6.9
To: Linux NetDev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

The Android net tests
(available at https://cs.android.com/android/platform/superproject/main/+/main:kernel/tests/net/test/
more specifically multinetwork_test.py & neighbour_test.py)
run via:
  /...aosp-tests.../net/test/run_net_test.sh --builder
from within a 6.10-rc3 kernel tree are falling over due to a *plethora* of:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

The problems might be limited to RTM_GETROUTE and RTM_GETRULE and RTM_GETNEIGH,
as various other netlink using xfrm tests appear to be okay...

(note: 6.10-rc3 also fails to build for UML due to a buggy bpf change,
but I sent out a 1-line fix for that already:
https://patchwork.kernel.org/project/netdevbpf/patch/20240613112520.1526350-1-maze@google.com/
)

It is of course entirely possible the test code is buggy in how it
parses netlink, but it has worked for years and years...

Before I go trying to bisect this... anyone have any idea what might
be the cause?
Perhaps some sort of change to how these dumps work? Some sort of new
netlink extended errors?

- Maciej

