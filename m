Return-Path: <netdev+bounces-177121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D79A6DF84
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FD43A86F0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904B262813;
	Mon, 24 Mar 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BdQehZlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5E2AE72
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833405; cv=none; b=e31YD8E3ODLSKgTFl+XpLp0YbT9KTCJ5IoVxJJsCFWNlUB08T5PkrtK2llsv8ddL+d4VDAQSVgbAC5TBckibWSQZinCSPVnheSNnj81F5WR+XcG+8d66y+WTNoNh+9swfE598BawOo1AgBqaCPmp/WCpsjJGFqCUxBGd3N0eJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833405; c=relaxed/simple;
	bh=IL1V8o7xJHNAQcbCHHp4a+pUnPIrqBv7A8NmZRVKWFo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=W1JkLzJeqinXIlRQ0Nr0Qz1NHpae9veDzSbcNvzXQyKml1MdV5YzTp+EqKuuUm3jDCqixSjQQJHOiIj+uv0AIq8dUVDrSCcGAbc052x5GAGpV2ui09x9Seg4GmpzU6p6rsmgI0OBhMsJZjDgFISN+1v5UersXgtTTkGl88hL+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BdQehZlQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so89889345ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742833402; x=1743438202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqOKFO1YoyRd+UGj4GT6hHQ0hJwAGun7UQixHJLBfEM=;
        b=BdQehZlQyMsRpf2uIIFk9nQvFdvWBbQSR9pgK+ZXk3/QuimkJAmPNg/+2cPd6jU+5Z
         L1hdUVwuJhcmDA1ahaHy3cHQPuavwRaV/RPDwdBZxFAB73Z0oT5hS1JHE6rZmdsihtz7
         blZ17R5lEpKph9N56vz98tST2G0SRfUTPxoYPwTyjLYEGr5gjrcvPJVRyd21vxsUeouT
         2zMrxGc2FOYBlviINwIWBlB5i3/Fo/JLMJ6gjizCYFxwo0G7hU0YpBZZznUZIz767MIi
         sX9Ec1D+Q3mocEE5PB4ay7iG3DQaowg8+CG8F/rD+oEXgBbxj0eCejqTfkCtGR0tcHPf
         E46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833402; x=1743438202;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqOKFO1YoyRd+UGj4GT6hHQ0hJwAGun7UQixHJLBfEM=;
        b=R0TtKY0rx/ahvxyLzUc0imoTJWUo7lc8iSacDo6TXteqwpQrNI5EiSvVOnoF02BVXb
         kUh5U20EiQQmYNeOMcKG1ifJFbJdKAmRdtTRMdMFfinPtxVMAIsxm/rgEHNBlo/J3YHI
         MLvoGM36lbrSHtNRH0+rNWog9AjAUgKAZqW7C/QGyq6xn0GaCRxY9y10FLzwrH4fsews
         bq43uK0nU7rbksxkAS2HZTR2F05O2zW634gYbmp5nnp/mg889NYrRQv3bJTis2KjdHf9
         XkJkaFfdWqQTbldTk9NUvFxyF8MXmChzIXGEgQzer6XcakSM2VK2CUhPv9Q/eSs55Cr1
         HpNQ==
X-Gm-Message-State: AOJu0YyP2Bg5P0Nz6nMPVW5dSpG8zopOVPq+z63a50fMOwg6Kd9odSaJ
	jtgl1Z/vsKjOCtbjf+hQ47gfkp+8oL+6mOG/hj7OsN6MwjdVfNNT4wgOKShl9EprJMuiJmaM+1E
	+
X-Gm-Gg: ASbGncsqsYa2MeB+hHZjSwqbW9+Qk38COR3Zplko9PCN46lHK1U4TsPufQuihUwZ2ZU
	qV03aXhVhXPjg5L5A8PeXeoRmN3lRmvuTQBePPFtV68ZiC+Ew9AXIUn22f+ocDMIgr8YSd9LKHo
	EC5TNhLmziqqyrWua35n/u5ypM0FQUyuNGpEOnnbjJx8yJPJ/co/3vgD3SRDbMYZKWuzTJETk8W
	vzzZjdCeNqBoXUwU+g9nYAqrbwPLgrTcInEf25BfQtT1jxtfNrfhZ7ypwrIc90UTH7oX9NbpfB2
	vIDCIch1uw2QpPP4WWryDw34sH7pEHGyJaNRme/ZMPFYsTGEvseIdtxzcfmp2T+7F0b1E/BGYBx
	gVv7r4aQZ1qw1/O/8XA26
X-Google-Smtp-Source: AGHT+IH2o2ILyFEfeJZ6KNUGmdiU0AZsyM9/8kMZXrefPFMeRWCKGhfoSVaHQHGeTvCweoQvGB/IZQ==
X-Received: by 2002:a17:903:46c5:b0:225:adf8:8634 with SMTP id d9443c01a7336-22780e612bfmr200401695ad.51.1742833402514;
        Mon, 24 Mar 2025 09:23:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f56d7asm73052935ad.105.2025.03.24.09.23.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:23:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:23:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.14.0 release
Message-ID: <20250324092319.28d39f2f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is small release of iproute2 corresponding to the 6.14 kernel.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.14.0.tar=
.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

David Ahern (3):
      Update kernel headers
      Update kernel headers
      Update kernel headers

Eric Dumazet (1):
      tc: fq: add support for TCA_FQ_OFFLOAD_HORIZON attribute

Ido Schimmel (2):
      ip: route: Add IPv6 flow label support
      iprule: Add flow label support

Matthieu Baerts (NGI0) (1):
      ss: mptcp: subflow: display seq counters as decimal

Michal Koutn=C3=BD (2):
      ss: Tone down cgroup path resolution
      README.devel: clarify patch rules and syntax

Petr Machata (1):
      ip: vxlan: Support IFLA_VXLAN_RESERVED_BITS

Robert Marko (1):
      ip: link: rmnet: add support for flag handling

Stephen Hemminger (2):
      uapi: update bpf.h
      v6.14.0

Torben Nielsen (2):
      tc: nat: Fix mask calculation
      tc: nat: ffs should operation on host byte ordered data

Xin Long (1):
      man: document tunnel options in ip-route.8.in

Yuyang Huang (2):
      iproute2: add 'ip monitor maddress' support
      iproute2: add 'ip monitor acaddress' support


