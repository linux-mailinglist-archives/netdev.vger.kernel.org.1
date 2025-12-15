Return-Path: <netdev+bounces-244706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E6CBD6BC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4193004510
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5A326943;
	Mon, 15 Dec 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKDJmtXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243127FD56
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796350; cv=none; b=s9nlmmfvahomkZ051v8QdcO3SwxO6iUpy5afdY/cCV+vOYUVpc3sV8GwH51PdFD2YoTXTDLB82TcCK7ThsSeAhu5cQxaQv3dRG+3fdXmEswX13tIh7P4/Kd4gwyzomuhaMJmJ865usTAQcTDbA7dOPD9xdcDBWT/MIx85Jif/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796350; c=relaxed/simple;
	bh=S4rPeEDIZIwVJq/NhrUpwMxIVRW5R+/pHkM/PxZ/krQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=usrAdK8SnZQKIOugfgVDvok4hM65S8Sfp4OhPP4JRZIRSm7jUzEktPfqCpJ8VTuuJdpg8WAXDQydaJgB6om2+hTRi1+14InrdzQwscZVdPm0bX/CMw+6lNIaqt9lwUG0GqVrU90kGL/mM0Hnw0JckRrBu3KthkvchEmwzjY3Vn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKDJmtXz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so37712385e9.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765796346; x=1766401146; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=FKDJmtXzxHjjewFrwCWimB59IQ5FP1p3qacMevOzfAqhvQCyYAu+tMLYJwPc3Em1QO
         oM3z00GOyNvYTDJnUwp+Qse6Fe9h+GX9xDUVNlXhqouYGRS7oXykI5dAGg6nmPc+jZ1D
         g8+kOdAh2TLd7lM42JbbL3hgsgrMWKIO1L4lEG++Ja0EP4w9GPXfLmjyBHfn+frwsB02
         oOnh5n+c3Beba7C3Jf0DTeU6HQx5HoO0YaIRnNId0eG8N2GsdsjV9lyGV6QK0kX6tn6R
         CS9tk4qHl5VoQoprIXdBshNP6l/ifXu236/P+pffWH288ZmXuFelIgNWZabydS84JJnE
         wgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796346; x=1766401146;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=cBhN/44LhXFdkOJuuPKm6RNDQLNH7jPKNzMSy+0WuWH3aQgCeiQbkzDjqm3qEUMPgG
         woThkoDvsqlsUPHnKhAa5/rpBoPPJCnwBg5sNGGaLMEIVtVEDRTR08iaTFeOT0uMB6QO
         6IHpFH3iTIa2NLHkac9oZqdC6KmKmTsQYmodqcO5SiIDmYSJo/Dqk4g78wSs+k7NTk0l
         cHiHVkj3WCeZrQgDsd+O4mhrDEyhLY8Imivov1Qe0pHKk+ehGq/zhp+lweqx3aXqDkOu
         eGzgbHaGVIgq33bs/xVusYTakBzSZsK8IMRtRcTwJ1pdbfFmEzcK90sVbVMxz8eR90Ft
         lePA==
X-Forwarded-Encrypted: i=1; AJvYcCVgIIORQbkiDB8JATR4dFDsxsk4WSWGMc9Qzltno866imZszDq8iBsNlMLeeGkHIOEPUAINfVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4v7wKUXPWYd9MInim/6mai6/RX4tIMSPnzgl6zCqyn/i150O
	zQNI7Dcp7JEk7U9KU7l57kwHu802HCZFJpxQdVCmnDPoOYrH09qwFxAv
X-Gm-Gg: AY/fxX4Bi+Pon7KCxoRpTJxV2ifPOTIX8CNmFulaEVWbqLWeJApOdMedMho6vrTfOyq
	Vu3x2h6/mh3l7puQMXaWXKBQISUben+J6lSE8rrPGU8vvl3Jqq/IPHVo8NOADGhqR3Scs7Z2AQQ
	TlSJVmx4yOpwf2EA9LS/kj9a6yaZADTb7pqe/iO7pA/Zkb0N4VFQCrb1cBlXZlVp0RpSEW0Su94
	YRO3MexTLwGf3q0QRBgrAX3eSeWASoLyNBda55exUCOL38Z5niCD4tCqXJYM2s3wnrTsGd8r0Y7
	wd2KAdGMFI5lXe39hcQ4hb+fYMkAOL87peB0YvGf1jWB5Qf3nRQ9KSPhBiprrl88RecZu+uOy8/
	bOW0FJkTKVcNlOlSDCGHib187BTlJ+khHDOuUmgatP99jWTwSJgWNNAXFFnYyiOphgJJJrlAc+i
	7o1aiIza9YaiRHKLg+R83KTs8=
X-Google-Smtp-Source: AGHT+IFaWJrWyBE9GIVvce2XyPwUKqAlGkmLp8oPaVrPoTGxqsS9OcEy2fJ4pY8O1VJB9+e56d6ihA==
X-Received: by 2002:a05:600c:8b6d:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47a8f914528mr96729885e9.37.1765796346286;
        Mon, 15 Dec 2025 02:59:06 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:c497:8f2f:d889:ca1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm178004835e9.3.2025.12.15.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:59:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>,  linux-pm@vger.kernel.org,
  sched-ext@lists.linux.dev,  Jakub Kicinski <kuba@kernel.org>,  Network
 Development <netdev@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
In-Reply-To: <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Date: Mon, 15 Dec 2025 10:51:01 +0000
Message-ID: <m25xa8qaqy.fsf@gmail.com>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
	<5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Hi Donald,
>
> Thanks for the feedback. I rearranged a paragraph in the original email
> for easier reply.
>
> On 12/12/25 00:54, Donald Hunter wrote:
>> Hi,
>>
>> I guess the patch series was never cced to netdev or the YNL
>> maintainers so this is my first opportunity to review it.
>>
>
> You are right. I think I ran get_maintainer.pl only before adding
> em.yaml. That's my bad.
>
>> I just spotted the new em.yaml YNL spec that got merged in
>> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
>> because it introduced new yamllint reports:
>> make -C tools/net/ynl/ lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/em.yaml
>>    3:1       warning  missing document start "---"  (document-start)
>>    107:13    error    wrong indentation: expected 10 but found 12  (indentation)
>>
>
> I will fix these lint warnings. Besides fixing those warnings, it would
> be useful to mention running lint somewhere. If there is a general
> guideline for adding a new netlink YAML, I will revise it in a separate
> patch.

I have a patch ready for the next merge window that adds a lint target.
For now you can run:

yamllint Documentation/netlink/specs

You're right, we don't have a guide for adding new netlink YAML but
that's something I should add to the series I have pending.

Thanks,
Donald.

