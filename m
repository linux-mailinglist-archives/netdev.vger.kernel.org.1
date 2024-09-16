Return-Path: <netdev+bounces-128461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A22979A13
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAE41C20A94
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116C12B8B;
	Mon, 16 Sep 2024 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="K5lMtS3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7063DF5B
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726456721; cv=none; b=nPtwWtAQ9x3OlxsJQV0dtBrs9mA6P4c6cUVnMIt4FS9TXpLvCiDK414xp/SxfhJSvVYHH8sHpkaH7ppcTTbbUHgZRYQwgJVNNrpy1Is0FGmSqVkaOlaLbKjruwK1QpaJ7/dxGVoTm6zfVG5sClzYzsiyfs+G9mqQXNS4mCRKA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726456721; c=relaxed/simple;
	bh=0NVW+lrH0txx4C0uGXZw7sGouH5LFZ4p1l8M1gMksT0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ITRk4xcx/0IXQEZGMitJqaoWf1MVblyURfh+3KMfy8TYbRcX/G7sPMKmGhDDRugfFUxpwrKP+OqzxCpj+epyKRQ9XTcX1AOq8RK/BJ1S/bXU7aKRC8HsQtM0gGod9YY4cHl4reEYLDrZET85fPeVoAbNsCVAyJZHO3MWeLTvzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=K5lMtS3b; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2820059a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726456718; x=1727061518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvo+4DU+wEQoDL0uKh8kjZYAl0xY60CnlE75DcQcWOM=;
        b=K5lMtS3bn/Hlu17i2glD94Wf3a7Wi1v7hajNXVUpcTsiSTTbmp1SZRQlCvLVfCOhB+
         7O8MNCHVeEHfTGtqkBxjr8EXT+eyffXf08bjV1bqJ+q9AmkrH0m0nXGbZctxs34zikTO
         YEY5OJ+c9UlyM0kDisE5U09jseLelNesF5ZCkcxm0Octo1zUTacAoiB89RjRVTpYNpxi
         +u0LWDcmoYOvRkHSfnRIX9g2ihz5l0RSJUAkMIwRVqjXyRZdwuCwn2dfUKkJk3VoBIM5
         oyUjSz7a0tVCnqPYkqs7liiatDZISYvDIgUIKWseaX0GlnrKZkYte1IspbgY0Fp81at6
         MtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726456718; x=1727061518;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvo+4DU+wEQoDL0uKh8kjZYAl0xY60CnlE75DcQcWOM=;
        b=I1dwrT4Ds4WhezD6+q7LHCQ4Tgpf2cETnuku/8ov2M8QiNeOOc4m7vPQcMv5Kz1KrN
         Kin4vGjMJRC2ySRHo4v6Upg5k1ar6BZDQ8Mu8H6FtowpNBnlN6NyODKel7Xy2UaoAgRr
         IMpZgH04z/HJOI9LD/djK2MD8bGujf7fAlrQJU6t5T7Jo99masnJICF8axt0o0tqexAj
         6+nEWilY7222yESKsv15jqIDlMR7N1MrarDer8MxFDHb0XgXyleU4OLBBT7Fp9/vKEEH
         68XuNA3FoiHwAdaDevcOnGlJdzGeqpXzGz7X4H4Hg8WVaRhPmoT0YgKqpDL7Rw3agliQ
         M5mQ==
X-Gm-Message-State: AOJu0YyeWM96ADbz0Eko2EHL1aSeeUMHbdJhIehVliC2K1xk43AarrBW
	cWvNqrrRZlFkTAmhXF5DfN8M7LefJBXOct1N5CMrBKWz2zndCYg74y7tT+Aiu6pKVriOk2V65w4
	q
X-Google-Smtp-Source: AGHT+IHJqNZ3sXBIIb56vGj7P11FWIPL2JaQUkAYEU1enNY5WMlMMUrY28hHPl3iGIPcIyEag+15EA==
X-Received: by 2002:a17:90a:c10:b0:2d8:f7e2:eff with SMTP id 98e67ed59e1d1-2dba006821cmr16143436a91.36.1726456717685;
        Sun, 15 Sep 2024 20:18:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcfd015sm4040745a91.17.2024.09.15.20.18.33
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 20:18:33 -0700 (PDT)
Date: Sun, 15 Sep 2024 20:18:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.11.0 release
Message-ID: <20240915201831.164de47e@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is regular release of iproute2 corresponding to the 6.11 kernel.
Most of the changes are to the man pages.
Release is smaller than usual less activity during summer vacations

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.11.0.tar=
.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Beniamino Galvani (1):
      ip: do not print stray prefixes in monitor mode

Christian Hopps (2):
      xfrm: add SA direction attribute
      xfrm: document new SA direction option

Dragan Simic (1):
      ss: use COLUMNS from the environment, if TIOCGWINSZ fails

L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng (2):
      tc-cake: document 'ingress'
      tc-cake: reformat

Maks Mishin (1):
      f_flower: Remove always zero checks

Mark Zhang (2):
      rdma: update uapi header
      rdma: Supports to add/delete a device with type SMI

Matthieu Baerts (NGI0) (7):
      man: mptcp: document 'dev IFNAME'
      man: mptcp: clarify 'signal' and 'subflow' flags
      man: mptcp: 'port' has to be used with 'signal'
      man: mptcp: 'backup' flag also affects outgoing data
      man: mptcp: 'fullmesh' has to be used with 'subflow'
      man: mptcp: clarify the 'ID' parameter
      ip: mptcp: 'id 0' is only for 'del'

Przemek Kitszel (1):
      devlink: print missing params even if an unknown one is present

Stefan M=C3=A4tje (2):
      configure: provide surrogates for possibly missing libbpf_version.h
      ss: fix libbpf version check for ENABLE_BPF_SKSTORAGE_SUPPORT

Stephen Hemminger (8):
      man: update ip-address man page
      uapi: update to 6.11-rc1
      man/ip-xfrm: fix dangling quote
      man/tc-codel: cleanup man page
      replace use of term 'Sanity check'
      man: replace use of word segregate
      man: replace use of term whitelist
      v6.11.0

Tobias Waldekranz (3):
      ip: bridge: add support for mst_enabled
      bridge: vlan: Add support for setting a VLANs MSTI
      bridge: mst: Add get/set support for MST states

xixiliguo (1):
      ss: fix expired time format of timer


