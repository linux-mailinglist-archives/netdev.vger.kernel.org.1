Return-Path: <netdev+bounces-192500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC27AC0190
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 02:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3177F4A7806
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 00:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE753CF58;
	Thu, 22 May 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRZEanFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2447F4A;
	Thu, 22 May 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875194; cv=none; b=dujnZ35JUC1pu46C0M8qgaaPBMwFwg+GMtqkt/PFKeuAIUO1IK0W9qYujtVFX9qaBs8gaj4HB1IWxwQSFKWX+ss1oPjl5EvGYfLsouePf6PpYlUwLIn5VqAvVWAyGT2OXwakPmMj0LHNYriHBfmGXlhH0tc/6mRePCnd4p9VAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875194; c=relaxed/simple;
	bh=4Ft0iMqYoHiOxTAuaJ+NIPNqFRP2dzxn0Szm9BsoXF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p4W4jpEEfz96qn14hSupYHMLeba68Rc4sDfTWjrRahzUCybbR8eNLt9qcDz26HBG6O+8qJqkfHZuaOZ/VknLUkXK2prYgoYCO7QV5ssjhH87kBY0Foa69o++rr9GZeydzcsuYNaz9etzlraVA9wpt32LInZQe4CrXuNua/TcDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRZEanFv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32934448e8bso16495371fa.3;
        Wed, 21 May 2025 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747875191; x=1748479991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=22s7w+Jw98xcNkkntdxAEeVIYsqFGoWrJTkU7tGG5AE=;
        b=TRZEanFvJoTfOhSEhPF5+KAKpvpnRPzEoSK+KX5zgZ9ebGnkJ29aDOIBVTEJSUVKZP
         x61Y5zekcOAUtLuWA08KS0lVmsBIjXWwjmbj235vDK+zPAXOyhTr1EsFqHoDyY3s4tGj
         KeD9R/d8sJXbBqt/343I49GotA2vs7cg0LWU3baRTyNaZLPoHWblXtfUzStmdOWA5sJa
         rkmBvCSye8Vlt+4XKTUA+v2B0822LLCwGgWmsbCKs1jGAmUtDxThzqPJc2byevsLuWFR
         OoFVkkvCQLODNW7BNDYmx1ZZDzGpW68DBraBhE7goeYBb6TwcNVWbl9BJk9XNjaG/bNM
         8xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747875191; x=1748479991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22s7w+Jw98xcNkkntdxAEeVIYsqFGoWrJTkU7tGG5AE=;
        b=ASa9lKJNRDek+/M0MUnX5PB649EoyN2hT1CjVGOSo9hP9FLGGOw738PLlK1VxRvSje
         I9xEQ3DU04vsAXvhipqmxjVQheOusmsMZzzbY3lxVyCW2lEtEu5qaUNXCzktc13Tk6SV
         kcJoOP7wKBiBoSupTNLom1gWuo78gENgUOlXbDJNMm6Or5R21o3XXEupKxam09Z520ri
         arzejLqxbKIJ5DzGL3baQLEKbk4P/c5ytj9ff0sLiBnxJzHI3I6TyqQNHnCA9lmxVpqt
         bKiNV2VGjeVlZOSggc2XPvs4rHPeQk0TTnZtcNfyq4lWXExVMd+otWFObhC9HYhEDeve
         yo+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1ts+gmMfiHDqUDbX0aK38oDzGDZ8cYJlO5vMRXTQxicwwC1gnOxg8sXiJJf8jPgBidivh+2n8@vger.kernel.org, AJvYcCUETTAAH5Xb9WCZlSRWKXHdnOCurf4VaDf5P99vMuV9GmYlN48xN79iD5FJJqHWazNfu7zobskiabHbG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9ey7VQT61GDpd6qo+ebnfYlfeLGtuuiy4mNsr5JNHTrX/lhm
	RxZSjJYFoO6/LKczttkDW51axaD0tt0KSy/HRq84RQlZHoNRqKntMyYpZ0M8PIEaESiDeJxGDNX
	pYjZdj3rznAGYhPsMcrJr8FHb4jQBLaQmH1dqog==
X-Gm-Gg: ASbGncu5nbQ5fXEY8z0hzUFVIPQbFQojDfgxaZ6/aR7G8LA+1ipD907fF2xA1Pggy6T
	tKXEU0mQgMgd2jv6Yp9tNjN1K+XvLsVfcg2jg9UT3mE9E5PpzA9KYXID89Yq0+8kNcU1MdY9Ers
	eWuACJSZsiao26LzJ85DtCXqqoZOxE8pPsXlD7q351/VlHS1rihyOClQ==
X-Google-Smtp-Source: AGHT+IHdO/Lo1DdGl31K71Kd6XggJbdfwGqcFqEZ6CywzQGxdI13guaBbnkMmCbfEutGpbp2PMjLJ9txBQ0y1ux/2uc=
X-Received: by 2002:a2e:a00e:0:10b0:329:14d3:366e with SMTP id
 38308e7fff4ca-32914d339ecmr37684151fa.34.1747875190755; Wed, 21 May 2025
 17:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 08:52:57 +0800
X-Gm-Features: AX0GCFtvV1TlfYG-DgUfe2nrjFzAriSQCZPIinpZyeP4upDImzXjA374n-XivK4
Message-ID: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
Subject: [Bug] "possible deadlock in rtnl_newlink" in Linux kernel v6.13
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.13.

Git Commit: ffd294d346d185b70e28b1a28abe367bbfe53c04 (tag: v6.13)

Bug Location: rtnl_newlink+0x86c/0x1dd0 net/core/rtnetlink.c:4011

Bug report: https://hastebin.com/share/ajavibofik.bash

Complete log: https://hastebin.com/share/derufumuxu.perl

Entire kernel config:  https://hastebin.com/share/lovayaqidu.ini

Root Cause Analysis:
The deadlock warning is caused by a circular locking dependency
between two subsystems:

Path A (CPU 0):
Holds rtnl_mutex in rtnl_newlink() =E2=86=92
Then calls e1000_close() =E2=86=92
Triggers e1000_down_and_stop() =E2=86=92
Calls __cancel_work_sync() =E2=86=92
Tries to flush adapter->reset_task (=E2=86=92 needs work_completion lock)

Path B (CPU 1):
Holds work_completion lock while running e1000_reset_task() =E2=86=92
Then calls e1000_down() =E2=86=92
Which tries to acquire rtnl_mutex
These two execution paths result in a circular dependency:

CPU 0: rtnl_mutex =E2=86=92 work_completion
CPU 1: work_completion =E2=86=92 rtnl_mutex

This violates lock ordering and can lead to a deadlock under contention.
This bug represents a classic case of lock inversion between
networking core (rtnl_mutex) and a device driver (e1000 workqueue
reset`).
It is a design-level concurrency flaw that can lead to deadlocks under
stress or fuzzing workloads.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

