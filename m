Return-Path: <netdev+bounces-244403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E5CB6647
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70092300A860
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C0304BBA;
	Thu, 11 Dec 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI0uKfIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FE23AE62
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468506; cv=none; b=IQZcpXhim5xMTIPNobnEFjIFKfWNsELrVXQ9GlxoS57i3mptIckAdPRU8kfLRCIU5jAxS+W9TR4AnSiwyoyrfpjX8/+shM5uS76mZu/JZzALc/CVMpnN1NuXs8junZjUu+hDtwVUnHcY0oOMEB4Vfs8s75NRGXC6rIxYpk8kdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468506; c=relaxed/simple;
	bh=fwJlp95bBAG7kWYEepDiexqrENbAswzXKepyzd027WM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Eu3BUj0myCm6e6FHMJ6DDI8pD46bLNoqDkHZ5ceX1g68eWgOz8kfHCsgwKlx+Zf6GM5GxaXx22RdsOxuPQekoG4iqnNv7G2dzp2Svw9ieeY+tdkMWcFt+aSHI4KNYvWeDfuK7V5lwZMLhmmMMyk4cRUab7cKEMH5DxzVmsl4wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI0uKfIv; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4557c596339so123730b6e.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765468504; x=1766073304; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=AI0uKfIvYNqy0i8sBatIb5hKXR2JeAG7zgcLRBGC9YpVNU50w6jDy1+uXx190gkGOc
         C+W2rnF1QGAI544VrmsX5M+gVk0rwQKuICWqRohUd23lkL7owUcNbxUac8UsFzBrOBiZ
         dem1PKTAL0dNKLf1SM+gaLg/4Ain+mOrCswx3od/V7KBDT8XM9ei9epxd3bZB1DZUGWz
         6SxYmKUMk/U7MYsMYagGymf5dGK96Kjh1YAc4CjmChQc7rnYS9DAT3IlB7uHCNAYUZnB
         q+44VAQ9rnO+Azd5T//8uEj0bBGdavsBOTU2tKcnV96wMuOi4h1u96/xMIVQ5WtyTxxp
         t8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765468504; x=1766073304;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=GhB1lbSyRkcDd7m8FPpzNn+dV3syYrIqrE3KI5cWClb90mxIynBWqAfwmWf8oUjLkM
         IqaiEq5OxZk7ARoxfz9xI7zZ0VX3uQqRr+KBhBG36HRUe6xjoxvf//p0h4VEHNkklEay
         A6/feHSXSDFNCDEeJzeEwgfCeUccMmIFb0SkAoFpnr8gpV4gUhRd9fpxRWVVLpjnRJlK
         XuipbOwHjOa0nL7xEqb5q1/MIxecx5fy8Z73aAodwdA3Bnp4OeilnBRN2jHxbMMCMWVE
         Ujsbcu7vGz2kFculTGwCS28v3InYmlfrCC587HdavKdvNQeu33DRwDmPhUL07h9rSnkr
         xzNw==
X-Forwarded-Encrypted: i=1; AJvYcCXN7Pw3yhGDFSdls6uClT6XY78HiWrlnk6jJsQKIv9r1hWUXljmls9Wo9pCOCB1PLPDo9cwBE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Z8naHdyHX4Lc6sUAzkxb+P9yc8CI+niXd4YFm4gtgbkKS+YG
	2io5xJsa2N9j3OLZ4OfZkYvQcu7QLQ90ycAQGjUra3X6ApuujmAm1JBdTSZnPmtzx7HQ6wpY6lM
	/OmIrEtF8LLuFCanDqyUmvfhIEupmJFg=
X-Gm-Gg: AY/fxX5EO/J+WOcNKlDgyfjGac5ED4YuToHgytnAULRgCBZiAbzt5Ns9V60ScMd+nf7
	HSFgkv1Lgq6dGYX/DuJz/aOUcsrUF/Ou3A5w7I4PD8y9Bu2iQTPwMFZfBwkp/2IU1YsxoB/TOe+
	iRfBJK4W6B8Vn9ER59idCXNRB9jh4pPscn37jYTDX4YxD3kU1YaDnVkJIvA/bRmynUMoVoICBxZ
	LoQxR8kID/7TCgzHB8BvX7WuAlWlyIkc+g/bRdDCKASN+JdCly2tM7Rk5u4kRJFqCgjPmDYRdnj
	JwrNb46/BxRSBcZdV5YSOHeQBA==
X-Google-Smtp-Source: AGHT+IHXmInc6hNUIZUoLpP+BYGgYAGze6nb2R2ueRO5VxDEQRxgtOjiPMFdP1lK2Otb1LgPycnughbDIgBoXGBKCXE=
X-Received: by 2002:a05:6808:1490:b0:439:af2f:d1d5 with SMTP id
 5614622812f47-455866d189amr3237813b6e.39.1765468504472; Thu, 11 Dec 2025
 07:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 15:54:53 +0000
X-Gm-Features: AQt7F2ougg8Kbtn1zopP4MM0jMFAvN_Q8zACcGkXN_X9ACZRAZQLHfVWaA3hLE0
Message-ID: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Subject: Concerns with em.yaml YNL spec
To: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I just spotted the new em.yaml YNL spec that got merged in
bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
because it introduced new yamllint reports:

make -C tools/net/ynl/ lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs
../../../Documentation/netlink/specs/em.yaml
  3:1       warning  missing document start "---"  (document-start)
  107:13    error    wrong indentation: expected 10 but found 12  (indentation)

I guess the patch series was never cced to netdev or the YNL
maintainers so this is my first opportunity to review it.

Other than the lint messages, there are a few concerns with the
content of the spec:

- pds, pd and ps might be meaningful to energy model experts but they
are pretty meaningless to the rest of us. I see they are spelled out
in the energy model header file so it would be better to use
perf-domain, perf-table and perf-state here.

- I think the spec could have been called energy-model.yaml and the
family called "energy-model" instead of "em".

- the get-pds should probably be both do and dump which would give
multi responses without the need for the pds attribute set (unless I'm
missing something).

- there are 2 flags attributes that are bare u64 which should have
flags definitions in the YNL. Have a look at e.g. netdev.yaml to see
examples of flags definitions.

- the cpus attribute is a string which would appear to be a "%*pb"
stringification of a bitmap. That's not very consumable for a UAPI and
should probably use netlink bitmask or an array of cpu numbers or
something.

- there are no doc strings for any of the attributes. It would be
great to do better for new YNL specs, esp. since there is better
information in energy_model.h

Given that netlink is UAPI, I think we need to address these issues
before v6.19 gets released.

Thanks,
Donald Hunter.

[1] https://lore.kernel.org/all/20251020220914.320832-4-changwoo@igalia.com/

