Return-Path: <netdev+bounces-68314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5E846906
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F741C25D42
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1851757D;
	Fri,  2 Feb 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OSWel9zs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D1175AC
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857793; cv=none; b=uZyDzZOp1M2+3ijZLQ+ZFe/8ASbrgAZch2ws+bxgasFeyoq67pSUzIjrWhqopxg0Z7ZaQyv9Kln7T7lAI9OwNUaBNZWlDQGkz2o+0Tp12i04gV8ONSP2j4u5iq9f10Q7Fq2L4aCDXCGadu4aAsiW0SDzcQMbwvTTQZXETb/4Apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857793; c=relaxed/simple;
	bh=aM0I27fSxG9ncsoOwq8+RLtJ8Akzqu2IpCqFvquszZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYrtxH5ND1Iaw8NKO4kccogJXFhPfSo6wXs8988zsAc6gECeIH2z+Q07hFZNL9IZQhU2J/KBlF7k2MNRjW7vJoz8ZwqX4xq3fBMapYvrV+CWp/YtWlD3CN3wc6nNMBSJCfqJgJTXUqR/ZLtLTjqPpOHIzwA8vX7oqmge6/nCw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=OSWel9zs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eac018059so2193272e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 23:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706857789; x=1707462589; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0xl4+XqIugVEwtcY8bcqC8nTrvfpuE9sxWYNsaFq/A=;
        b=OSWel9zs9kVAlt+7C0FdZDtdoI7EQD9xLjLvmrhErHPDJNVN3GZ935btnY2K8wjl8U
         lRYGrqN1L8/R0uG4xATcrzJDGvnqCcW0eGwp7ly+Aba40mbfWpFRmG7yuKz0gKr+xwCV
         Yk3SXPlQXROdNAmyB8mnMdjzHhO//u1YC7lNSYfCoEAnK5Ss4fQO6KWElQDWZrTH81NN
         qlO85lbpfnerrU+nOQQYuyJ59Ggc0hsXtaSzhP8WW7kXl4kgZQS1KVcHZh5C9NdPsR/O
         D5nPuurrOZ07lfnMedipNySBvAxQJ2Az5RSb0dRtI/ub29PbcdVwMOy8fyDlou6HNpDw
         yZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706857789; x=1707462589;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0xl4+XqIugVEwtcY8bcqC8nTrvfpuE9sxWYNsaFq/A=;
        b=nbKCgFEQ8/tcb545CY2E5o4y2AVkvqpSYTCa7FGUTeY/S4rcISb4gbrqLisa3kgywx
         XWzBf5rjRuf4kaBS8xASfZw2RkaQDqqISctA/sLU/DdabK1rqs8JtRbkKkmYjIvj5VKa
         XFDW6p85hVjwHmRXVnwVQqnkZOHeHHLT/Rc8shKQWTYvofMkO7+S4Krb3iyfpa1OUIZp
         sihpjKlfw3vVJji8BhRmjAv6qo6VrZ/rQnxAa/kJJNu+WQJZvMdnuc5Qf8fT0jceJ2XK
         JW1B8GIWBcp7fmRjYrz/cBp4pGZIJzp6CgFaLt5l0sBZ8EDYJfOjyF7DUil6zXqS4PNs
         zKCw==
X-Gm-Message-State: AOJu0YxoDC7wPRDG1I7FJJqphjVLvtNnnqlQUgulhEYkVGcBr4Ilm178
	ginafLHTGTNcuCnhhWBGGl+mXAOLSAVYEoE0Q3LFcEVvYbXOcROM5FbOJ9LYie8=
X-Google-Smtp-Source: AGHT+IHBrRXbjJRB+j0ms4uycbW4rA/CKq+L9eqPj4WvKyB6UQPVnsq0i+wC8O2Sd5Jl/r8nXNQglg==
X-Received: by 2002:ac2:4542:0:b0:50e:1870:1ef4 with SMTP id j2-20020ac24542000000b0050e18701ef4mr601401lfm.48.1706857789212;
        Thu, 01 Feb 2024 23:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfU6Hxs3SQwI/O6LS5fYegHC2xgnfAhMJL5Wg7Fel7Xbx1AvMT0xyuyGIeUTttCKZzUJwavB8Ph4IZs8DwJGqHg1V+iJprkUz/jjMXOxYAtJQ7ABPtOBDS+IWALSIgL0x/kRPPYBp9qRyAeLqGvPyMNhZKQp0kCk7gjF34S4nqkI3y9rn509f3bLjc/4dmMYxqMLcgYNk/jVNRKMLspbIn3vnudhsOY53WhkxwWzZOhRrdFT8huEZlvkg2x3GkO2Y0h7BXhnpvLjsmnZj+FYQXGA==
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u18-20020ac243d2000000b005101b937bedsm209068lfl.5.2024.02.01.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:09:48 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
 atenart@kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
In-Reply-To: <ZbvFwVSQI1M_2WZo@nanopsycho>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <ZbvFwVSQI1M_2WZo@nanopsycho>
Date: Fri, 02 Feb 2024 08:09:46 +0100
Message-ID: <875xz7tk91.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, feb 01, 2024 at 17:24, Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Feb 01, 2024 at 05:10:45PM CET, tobias@waldekranz.com wrote:
>>Before this change, generation of the list of events MDB to replay
>>would race against the IGMP/MLD snooping logic, which could concurrently
>>enqueue events to the switchdev deferred queue, leading to duplicate
>>events being sent to drivers. As a consequence of this, drivers which
>>reference count memberships (at least DSA), would be left with orphan
>>groups in their hardware database when the bridge was destroyed.
>>
>>Avoid this by grabbing the write-side lock of the MDB while generating
>>the replay list, making sure that no deferred version of a replay
>>event is already enqueued to the switchdev deferred queue, before
>>adding it to the replay list.
>>
>>An easy way to reproduce this issue, on an mv88e6xxx system, was to
>>create a snooping bridge, and immediately add a port to it:
>>
>>    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>>    > ip link set dev x3 up master br0
>>    root@infix-06-0b-00:~$ ip link del dev br0
>>    root@infix-06-0b-00:~$ mvls atu
>>    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>>    DEV:0 Marvell 88E6393X
>>    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>>    root@infix-06-0b-00:~$
>>
>>The two IPv6 groups remain in the hardware database because the
>>port (x3) is notified of the host's membership twice: once via the
>>original event and once via a replay. Since only a single delete
>>notification is sent, the count remains at 1 when the bridge is
>>destroyed.
>>
>>Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
>>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> Could you please maintain 24 hours period between sending another patch
> version?
>
> https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr

Sorry, I will avoid that going forward.

